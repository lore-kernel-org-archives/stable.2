Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CC383C65;
	Wed,  3 Jun 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496592; cv=none; b=XZii2CgfgNla5ZAhm1Naa+IOmAdyUtLzOqwqkP0dbwjMmJZdevKsZAfb4Zh3LW10pHTDUS9CbueylYQm3t38J1ormPod9mfzWESOJmUF6qGmDxlz9eMbuIR1SvwVdTqz9be//jqtCUuuAMJWpsFFOg8YwiFkEsLQ/X23T7KCkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496592; c=relaxed/simple;
	bh=5rPv0rBqTP78hAs7+vvvXuSl690VXVAyuOOdSSB1ri4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/p6HGzFW+vKn5bNDRgMNU8optrePE0hCAx42CQoIUmBBMJ++5oUnGyaA/OLKv7nKO4Qp8u2HBaNhzODC1uebejyi07xakWh5Z1qpX9Ah5gSbIZr4CzD//p7PJtMTL8evt+pvjH+HzfsN9sto2XhXoEwpYnQQCpv6GaBnOzl2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhbtyuJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhbtyuJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28B11F00893;
	Wed,  3 Jun 2026 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780496590;
	bh=x1z48cikCloEgwei4UZk2o1cFtb4Fcuckbpr03SF0K4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GhbtyuJ2Lk5KVFguq11SYAHj+S5CMxeq39Ya2P9x4oLLpnU8O4/Deg51/RpCYuO/+
	 d3p5YonWwOINm29f2sNzIlGdtncmC6AgglLpPEijOpV1G3GC6DpY6xzsuZY7EkZ45N
	 QLtQcMVyxJFqp+CehMhZsjSAOuEopmuGR4MRDiWr26V0BXx3Db60gjNsZ3uKmntaV4
	 30JAivctrmzDXBqye3x0LZe2rZ4Znr3jNGy5Q93vn3j0sC82akGqrdUh52cRgVLFIi
	 cKfd4TrehxlPP0uQydYLTDofP39S7TzoSjE8Al8dJF1BOoAHL9n96fWWqa0txQDOgv
	 i6LDvgMUnW1zA==
Message-ID: <8687d3cb-628a-477b-9dfd-2db8c412b277@kernel.org>
Date: Wed, 3 Jun 2026 17:23:06 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] i3c: renesas: Perform Dynamic Address Assignment
 on resume
To: Frank Li <Frank.li@nxp.com>
Cc: wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
 alexandre.belloni@bootlin.com, p.zabel@pengutronix.de,
 claudiu.beznea@tuxon.dev, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
 <20260602132824.3541151-7-claudiu.beznea@kernel.org>
 <ah85RaUXmaBVFkYk@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <ah85RaUXmaBVFkYk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Frank, I3C maintainers,

I've inlined the sashiko comments here to discuss them:

On 6/2/26 23:12, Frank Li wrote:
> On Tue, Jun 02, 2026 at 04:28:13PM +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S SoC supports a power saving mode where power to most
>> SoC components, including I3C, is turned off.
>>
>> On systems where the I3C devices also loses power during suspend (e.g. NXP
>> P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
>> 2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
>> resume.
>>
>> Running DAA in the controller resume path restores communication. However,
>> DAA relies on interrupts for TX/RX, which are not available in the noirq
>> suspend/resume phase (unless they are wakeup interrupts). For this, the
>> suspend/resume callbacks were moved out of the noirq phase. Currently,
>> there is no identified use case on either the Renesas RZ/G3S or Renesas
>> RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
>> the noirq suspend/resume phase.
>>
>> Since renesas_i3c_reset() is not called anymore in atomic context
>> update it to use read_poll_timeout().
>>
>> To cover the case where the controller had already attached all the
>> i3c->maxdevs devices before a suspend/resume cycle and i3c->free_pos is
>> zero, struct renesas_i3c::resuming flag was introduced.
>>
>> The flag is set in renesas_i3c_resume() before calling
>> i3c_master_do_daa_ext() and checked in renesas_i3c_daa(). In case it is
>> set the previous saved DATBAS register values are used for the slots
>> already occupied before suspend. This allows keeping alive the connection
>> to the I3C devices when all the supported slots are occupied before
>> suspend.
>>
>> When resuming from suspend, renesas_i3c_daa() re-runs DAA for al
>> slots except those used by I2C devices. I2C devices are attached during
>> probe, at bus initialization time, and always occupy the first positions in
>> i3c->free_pos. In addition, there are no DATBAS register settings
>> associated with them.
>>
>> Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
> 
> Please check sashiko review result
> 
> https://sashiko.dev/#/patchset/20260602132824.3541151-1-claudiu.beznea%40kernel.org
> 
 >commit 6783acf82418dd115df661f4dc9d5758f653b084
 >Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 >Date:   Tue Jun 2 13:28:13 2026 +0000
 >    i3c: renesas: Perform Dynamic Address Assignment on resume
 >    The Renesas RZ/G3S SoC supports a power saving mode where power to most
 >    SoC components, including I3C, is turned off.
 >
 >    On systems where the I3C devices also loses power during suspend (e.g. NXP
 >    P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
 >    2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
 >    resume.
 >
 >    Running DAA in the controller resume path restores communication. However,
 >    DAA relies on interrupts for TX/RX, which are not available in the noirq
 >    suspend/resume phase (unless they are wakeup interrupts). For this, the
 >    suspend/resume callbacks were moved out of the noirq phase. Currently,
 >    there is no identified use case on either the Renesas RZ/G3S or Renesas
 >    RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
 >    the noirq suspend/resume phase.
 >    Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
 >    Cc: stable@vger.kernel.org
 >> --- a/drivers/i3c/master/renesas-i3c.c
 >> +++ b/drivers/i3c/master/renesas-i3c.c
 >[ ... ]
 >> @@ -657,14 +664,33 @@ static int renesas_i3c_daa(struct 
i3c_master_controller *m)
 >>
 >>      /* Setting DATBASn registers for target devices. */
 >>      for (pos = 0; pos < i3c->maxdevs; pos++) {
 >> -            if (olddevs & BIT(pos))
 >> +            if (olddevs & BIT(pos)) {
 >> +                    /*
 >> +                     * In case of resume, reassign DAs for all devices on the
 >> +                     * bus to avoid failures when all i3c->maxdevs slots were
 >> +                     * already occupied before suspend.
 >> +                     *
 >> +                     * Exclude I2C devices, as they are attached during probe,
 >> +                     * at bus initialization time, and there are currently no
 >> +                     * register updates associated with them.
 >> +                     */
 >> +                    if (i3c->resuming) {
 >> +                            if (i3c->addrs[pos].is_i2c) {
 >> +                                    last_i2c_pos = pos;
 >> +                            } else {
 >> +                                    renesas_writel(i3c->regs, DATBAS(pos),
 >> +                                                   i3c->DATBASn[pos]);
 >> +                            }
 >> +                    }
 >Does restoring these blindly from the saved state cement addresses for future
 >ENTDAA, bypassing normal device assignment?
 >If a device is removed, hot-plugged, or wakes up slowly, couldn't a different
 >device win arbitration and be assigned an address from an unrelated DATBASn
 >slot?

Currently, the driver don't support hot-plug.

I presumed the remove in suspend is not actually a valid use-case, but with this 
scenario, if that happens, the device still remains attached in the software 
data structures. After this sequence:
1/ suspend
2/ disconnect an I3C device
3/ resume
4/ suspend
5/ re-connect the I3C devices
6/ resume

the reconnected I3C device works again after step 6 (according to my testing).

Waking up may happen slowly, indeed. So, I presume this is a valid use case.

Now, I have few question (if my I3C understanding is right):

I noticed none of the I3C drivers are taking care of the use case where the bus 
is fully populated after resume (and we are after a resume with power lost, for 
both the controller and the devices). That looks a bit tricky scenario to cover, 
to be honest, as all the drivers check for a free slot in ->attach_i3c_dev(), 
and, for a fully populated bus, that will not update the newly assigned 
addresses in the subsystem data structure.

If the ->attach_i3c_dev() called though the i3c_master_add_i3c_dev_locked() 
fails then nothing is continued so, the device address changes are not 
propagated in all the software data structures.

In case we re-use the DATBAS() register values as proposed in this patch, we 
have the changes that the driver software data caches (i3c->addrs[].addr) and 
the subsystem I3C devices addresses to match. But, that may not be true all the 
time.

If we re-assign new addresses to i3c->addrs[].addr in the DAA API, then write 
those values to DATBAS() registers, but the bus is fully populated, or no new 
devices are discovered as the indices remains the same, then, since we execute 
i3c_master_add_i3c_dev_locked() only for the newly attached devices, then the 
subsystem and the driver addresses don't match anymore. I couldn't found a 
global API similar to i3c_master_add_i3c_dev_locked() to work for removing 
devices and re-attaching at resume, for such scenario. I'm not sure that's good 
to do, though. If we call i3c_master_add_i3c_dev_locked() unconditionally, then 
it will still not work on a full previously occupied bus.

If I'm not wrong with all these, could you please let me know how would you 
consider covering this scenario? This is what I've tried to address with the 
approach in this patch. I currently don't have a testing setup for this, I only 
simulated it by setting i3c->free_pos = 0 before calling i3c_master_do_daa_ext().

Would the usage of i3c_device_do_setdasa() being called from a master driver be 
something acceptable? Though, I currently haven't played around with it.

As I don't have a real setup to test this, would it be OK to restore the 
approach in this patch as proposed in v1?

Please let me know. Thank you!

 >> +
 >>                      continue;
 >> +            }
 >>
 >>              ret = i3c_master_get_free_addr(m, last_addr + 1);
 >[ ... ]
 >> @@ -674,9 +700,21 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 >>      cmd = xfer->cmds;
 >>      cmd->rx_count = 0;
 >>
 >> -    ret = renesas_i3c_get_free_pos(i3c);
 >> -    if (ret < 0)
 >> -            return ret;
 >> +    if (i3c->resuming) {
 >> +            /* Nothing to do if all slots are ocupied by I2C devices. */
 >> +            if (last_i2c_pos == i3c->maxdevs - 1)
 >> +                    return 0;
 >> +
 >> +            /*
 >> +             * Do DAA for all the devices on the bus, if resuming, except
 >> +             * the I2C ones.
 >> +             */
 >> +            ret = last_i2c_pos < 0 ? 0 : last_i2c_pos + 1;
 >Does this incorrectly assume that all I2C devices occupy contiguous slots at
 >the beginning of the device array?

I wasn't aware of the notifier used to add I2C devices to the bus.

 >If an I2C device is attached dynamically at a higher slot while lower slots
 >are occupied by I3C devices, will DAA start at a higher index, skipping the
 >lower I3C devices? The hardware would assign new addresses from the higher
 >offset, duplicating devices and breaking communication.
 >> +    } else {
 >> +            ret = renesas_i3c_get_free_pos(i3c);
 >> +            if (ret < 0)
 >> +                    return ret;
 >> +    }
 >>
 >>      /*
 >>       * Setup the command descriptor to start the ENTDAA command
 >> @@ -694,7 +732,7 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 >>
 >>      for (pos = 0; pos < i3c->maxdevs; pos++) {
 >>              if (newdevs & BIT(pos))
 >> -                    i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 >> +                    i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos].addr);
 >>      }
 >Since olddevs are masked out from newdevs prior to this loop in renesas_i3c_daa
 >(newdevs &= ~olddevs), is the I3C framework prevented from being notified of
 >shifted dynamic addresses landing in previously occupied slots?
 >Because i3c_master_add_i3c_dev_locked() is never called for these, the
 >framework could remain unaware of identity shifts and continue communicating
 >with devices using mismatched PIDs, risking data corruption.

That is a previously existing problem that may happen. However, I am not sure 
how we should deal with the case when this is called after resume, on a fully 
populated bus.

Frank, I3C maintainers, should we cover this case for now? Do you have some 
hints on how to go forward with it?

 >[ ... ]
 >> @@ -1435,7 +1475,7 @@ static void renesas_i3c_remove(struct platform_device 
*pdev)
 >>      i3c_master_unregister(&i3c->base);
 >>  }
 >>
 >> -static int renesas_i3c_suspend_noirq(struct device *dev)
 >> +static int renesas_i3c_suspend(struct device *dev)
 >>  {
 >>      struct renesas_i3c *i3c = dev_get_drvdata(dev);
 >>      int i, ret;
 >[ ... ]
 >> +    ret = reset_control_assert(i3c->tresetn);
 >> +    if (ret)
 >> +            goto err_presetn;
 >> +
 >> +    clk_bulk_disable(i3c->num_clks, i3c->clks);
 >> +
 >> +    return 0;
 >Since this callback is being moved out of the noirq phase where interrupts are
 >still enabled, is it safe to disable clocks and assert hardware resets without
 >first disabling the device interrupts (e.g., via disable_irq())?
 >If an interrupt fires during this time, the ISR might access unclocked MMIO
 >registers belonging to a reset IP, which could trigger a synchronous external
 >abort.

That may have happen even previously if the interrupts were configured as wakeup 
sources. However, at this point, all the clients should be suspended and thus, 
they shouldn't generate interrupts.


-- 
Thank you,
Claudiu

