package com.furazin.projecttestgithub;

import com.furazin.projecttestgithub.Math.Arithmetic;
import org.junit.Assert;
import org.junit.Test;

public class ArithmeticTest {

    @Test
    public void addTest() {
        Arithmetic arith = new Arithmetic(2,3);
        Assert.assertEquals(arith.add(),5);
    }

    @Test
    public void subTest() {
        Arithmetic arith = new Arithmetic(2,3);
        Assert.assertEquals(arith.sub(),-1);
    }

    @Test
    public void mulTest() {
        Arithmetic arith = new Arithmetic(2,3);
        Assert.assertEquals(arith.mul(),6);
    }

    @Test
    public void divTest() {
        Arithmetic arith = new Arithmetic(4,2);
        Assert.assertEquals(arith.div(),2);
    }
}
