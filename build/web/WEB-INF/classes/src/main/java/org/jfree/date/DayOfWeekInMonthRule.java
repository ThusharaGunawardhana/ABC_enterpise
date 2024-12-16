/* ========================================================================
 * JCommon : a free general purpose class library for the Java(tm) platform
 * ========================================================================
 *
 * (C) Copyright 2000-2005, by Object Refinery Limited and Contributors.
 * 
 * Project Info:  http://www.jfree.org/jcommon/index.html
 *
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, or 
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, 
 * USA.  
 *
 * [Java is a trademark or registered trademark of Sun Microsystems, Inc. 
 * in the United States and other countries.]
 *
 * -------------------------
 * DayOfWeekInMonthRule.java
 * -------------------------
 * (C) Copyright 2000-2003, by Object Refinery Limited.
 *
 * Original Author:  David Gilbert (for Object Refinery Limited);
 * Contributor(s):   -;
 *
 * $Id: DayOfWeekInMonthRule.java,v 1.5 2005/11/16 15:58:40 taqua Exp $
 *
 * Changes (from 26-Oct-2001)
 * --------------------------
 * 26-Oct-2001 : Changed package to com.jrefinery.date.*;
 * 03-Oct-2002 : Fixed errors reported by Checkstyle (DG);
 * 01-Jun-2005 : Removed the explicit clonable declaration, it is declared
 *               in the super class.
 */

package org.jfree.date;

import org.jfree.date.units.DayOfWeek;
import org.jfree.date.units.Month;
import org.jfree.date.units.WeekOfMonth;

/**
 * An annual date rule that specifies the nth day of the week in a given month
 * (for example, the third Wednesday in June, or the last Friday in November).
 *
 * @author David Gilbert
 */
public class DayOfWeekInMonthRule extends AnnualDateRule {

    private WeekOfMonth weekOfMonth;

    private DayOfWeek dayOfWeek;

    private Month month;

    /**
     * Default constructor: builds a rule for the first Monday in January by default.
     */
    public DayOfWeekInMonthRule() {
        this(WeekOfMonth.FIRST, DayOfWeek.MONDAY, Month.JANUARY);
    }

    public DayOfWeekInMonthRule(WeekOfMonth weekOfMonth, DayOfWeek dayOfWeek, Month month) {
        this.weekOfMonth = weekOfMonth;
        this.dayOfWeek = dayOfWeek;
        this.month = month;
    }

    public WeekOfMonth getWeekOfMonth() {
        return this.weekOfMonth;
    }

    public void setWeekOfMonth(WeekOfMonth weekOfMonth) {
        this.weekOfMonth = weekOfMonth;
    }

    public DayOfWeek getDayOfWeek() {
        return this.dayOfWeek;
    }

    public void setDayOfWeek(DayOfWeek dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public Month getMonth() {
        return this.month;
    }

    public void setMonth(Month month) {
        this.month = month;
    }

    /**
     * Return the date for this rule, given the year.
     *
     * @param year the year.
     * @return the date generated by the rule for the given year.
     */
    public DayDate getDate(int year) {
        DayDate result;
        if (this.weekOfMonth != WeekOfMonth.LAST) {
            // start at the beginning of the month
            result = DayDateFactory.makeDate(1, this.month, year);
            while (result.getDayOfWeek() != this.dayOfWeek) {
                result = result.plusDays(1);
            }
            result = result.plusDays(7 * (this.weekOfMonth.ordinal() - 1));

        } else {
            // start at the end of the month and work backwards...
            result = DayDateFactory.makeDate(1, this.month, year);
            result = result.getEndOfCurrentMonth(result);
            while (result.getDayOfWeek() != this.dayOfWeek) {
                result = result.plusDays(-1);
            }

        }
        return result;
    }

}
