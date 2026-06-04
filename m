Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4447DD4E;
	Thu,  4 Jun 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578299; cv=none; b=pBiXKc7AHB6R00XrmvLcIMFlzTJl/o3VuScJiItEMnpwykxr7t3P9VTqo+XxtyChlJ1LsDHxAzNqeAIKGGxPtixwiHs1ncHnMCNTinS6OeEfauZ1VmAU1gW4cUka0n2jy6ffnCWgNtrS3p0JpapjJR42yqfR1vSoVLke/PEXGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578299; c=relaxed/simple;
	bh=viq9Gy3TGhufH4tXUrrgSO4Hk4PH7YP5ObvP3Tb7cC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I37NQ503k79Ysmkr5CbsEY7vySPog1xRjtLK7wJ5m/3xrc2pOrvptpiXa2LrvgnsWFeJUa35RyiQFh/8m4/EGtTnNHDtV3nDCUIBUJd1AIApeBWxds2xIzNmC2xgHX9M5c17CAJiKbSlzG5VictjvplQ0+Yfx7eWjb983UccUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWoqnDlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWoqnDlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E31F00893;
	Thu,  4 Jun 2026 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780578297;
	bh=Ouk81xprjo4lWjBJXrltuvcmQkhjiEHAH428GrXLZt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YWoqnDlvd0ychHWTakimutDjgi4nnBkhaDXu9AdIzLIDNpJ01k6HjBiyfyyLcFqhv
	 9KK2RKgTc1TywV7pEU5bnby4hA5TPk42ArDi7HUWUIxGnbmH4sKCIMKduacaoC6PX6
	 1DTRc+TTm5iaDMm04l7h45FRs9a0nhweMpd59GW0k8BsLf49LuxmDwO8KC2ywhVFZe
	 qXB2ttnz+oVF24GoFb2IWAUlrevKMQP2YdP3N6Ebl4ZlUtTI4YUO6ZQx5dYgX5+VRj
	 y6BWyI4h33U7LmcRupJaRjwK2P0ntVlql/fOWOBHCrnwbe4A9sTcbA+LBJ4Ktcjmdz
	 b4M11ctCErRiA==
Message-ID: <19754889-0aa9-4a4a-b015-8ddb0a61b678@kernel.org>
Date: Thu, 4 Jun 2026 16:04:52 +0300
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
 <8687d3cb-628a-477b-9dfd-2db8c412b277@kernel.org>
 <aiB_3kneo2Scy5bB@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <aiB_3kneo2Scy5bB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Frank,

On 6/3/26 22:26, Frank Li wrote:
> On Wed, Jun 03, 2026 at 05:23:06PM +0300, Claudiu Beznea wrote:
>> Hi, Frank, I3C maintainers,
>>
>> I've inlined the sashiko comments here to discuss them:
>>
>> On 6/2/26 23:12, Frank Li wrote:
>>> On Tue, Jun 02, 2026 at 04:28:13PM +0300, Claudiu Beznea wrote:
>>>> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The Renesas RZ/G3S SoC supports a power saving mode where power to most
>>>> SoC components, including I3C, is turned off.
>>>>
>>>> On systems where the I3C devices also loses power during suspend (e.g. NXP
>>>> P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
>>>> 2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
>>>> resume.
>>>>
>>>> Running DAA in the controller resume path restores communication. However,
>>>> DAA relies on interrupts for TX/RX, which are not available in the noirq
>>>> suspend/resume phase (unless they are wakeup interrupts). For this, the
>>>> suspend/resume callbacks were moved out of the noirq phase. Currently,
>>>> there is no identified use case on either the Renesas RZ/G3S or Renesas
>>>> RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
>>>> the noirq suspend/resume phase.
>>>>
>>>> Since renesas_i3c_reset() is not called anymore in atomic context
>>>> update it to use read_poll_timeout().
>>>>
>>>> To cover the case where the controller had already attached all the
>>>> i3c->maxdevs devices before a suspend/resume cycle and i3c->free_pos is
>>>> zero, struct renesas_i3c::resuming flag was introduced.
>>>>
>>>> The flag is set in renesas_i3c_resume() before calling
>>>> i3c_master_do_daa_ext() and checked in renesas_i3c_daa(). In case it is
>>>> set the previous saved DATBAS register values are used for the slots
>>>> already occupied before suspend. This allows keeping alive the connection
>>>> to the I3C devices when all the supported slots are occupied before
>>>> suspend.
>>>>
>>>> When resuming from suspend, renesas_i3c_daa() re-runs DAA for al
>>>> slots except those used by I2C devices. I2C devices are attached during
>>>> probe, at bus initialization time, and always occupy the first positions in
>>>> i3c->free_pos. In addition, there are no DATBAS register settings
>>>> associated with them.
>>>>
>>>> Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
>>>> Cc:stable@vger.kernel.org
>>>> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>> Please check sashiko review result
>>>
>>> https://sashiko.dev/#/patchset/20260602132824.3541151-1- 
>>> claudiu.beznea%40kernel.org
>>>
>>> commit 6783acf82418dd115df661f4dc9d5758f653b084
>>> Author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>>> Date:   Tue Jun 2 13:28:13 2026 +0000
>>>     i3c: renesas: Perform Dynamic Address Assignment on resume
>>>     The Renesas RZ/G3S SoC supports a power saving mode where power to most
>>>     SoC components, including I3C, is turned off.
>>>
>>>     On systems where the I3C devices also loses power during suspend (e.g. NXP
>>>     P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
>>>     2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
>>>     resume.
>>>
>>>     Running DAA in the controller resume path restores communication. However,
>>>     DAA relies on interrupts for TX/RX, which are not available in the noirq
>>>     suspend/resume phase (unless they are wakeup interrupts). For this, the
>>>     suspend/resume callbacks were moved out of the noirq phase. Currently,
>>>     there is no identified use case on either the Renesas RZ/G3S or Renesas
>>>     RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
>>>     the noirq suspend/resume phase.
>>>     Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
>>>     Cc:stable@vger.kernel.org
>>>> --- a/drivers/i3c/master/renesas-i3c.c
>>>> +++ b/drivers/i3c/master/renesas-i3c.c
>>> [ ... ]
>>>> @@ -657,14 +664,33 @@ static int renesas_i3c_daa(struct
>> i3c_master_controller *m)
>>>>       /* Setting DATBASn registers for target devices. */
>>>>       for (pos = 0; pos < i3c->maxdevs; pos++) {
>>>> -            if (olddevs & BIT(pos))
>>>> +            if (olddevs & BIT(pos)) {
>>>> +                    /*
>>>> +                     * In case of resume, reassign DAs for all devices on the
>>>> +                     * bus to avoid failures when all i3c->maxdevs slots were
>>>> +                     * already occupied before suspend.
>>>> +                     *
>>>> +                     * Exclude I2C devices, as they are attached during probe,
>>>> +                     * at bus initialization time, and there are currently no
>>>> +                     * register updates associated with them.
>>>> +                     */
>>>> +                    if (i3c->resuming) {
>>>> +                            if (i3c->addrs[pos].is_i2c) {
>>>> +                                    last_i2c_pos = pos;
>>>> +                            } else {
>>>> +                                    renesas_writel(i3c->regs, DATBAS(pos),
>>>> +                                                   i3c->DATBASn[pos]);
>>>> +                            }
>>>> +                    }
>>> Does restoring these blindly from the saved state cement addresses for future
>>> ENTDAA, bypassing normal device assignment?
>>> If a device is removed, hot-plugged, or wakes up slowly, couldn't a different
>>> device win arbitration and be assigned an address from an unrelated DATBASn
>>> slot?
>> Currently, the driver don't support hot-plug.
>>
>> I presumed the remove in suspend is not actually a valid use-case, but with
>> this scenario, if that happens, the device still remains attached in the
>> software data structures. After this sequence:
>> 1/ suspend
>> 2/ disconnect an I3C device
>> 3/ resume
>> 4/ suspend
>> 5/ re-connect the I3C devices
>> 6/ resume
>>
>> the reconnected I3C device works again after step 6 (according to my testing).
>>
>> Waking up may happen slowly, indeed. So, I presume this is a valid use case.
>>
>> Now, I have few question (if my I3C understanding is right):
>>
>> I noticed none of the I3C drivers are taking care of the use case where the
>> bus is fully populated after resume (and we are after a resume with power
>> lost, for both the controller and the devices). That looks a bit tricky
>> scenario to cover, to be honest, as all the drivers check for a free slot in
>> ->attach_i3c_dev(), and, for a fully populated bus, that will not update the
>> newly assigned addresses in the subsystem data structure.
>>
>> If the ->attach_i3c_dev() called though the i3c_master_add_i3c_dev_locked()
>> fails then nothing is continued so, the device address changes are not
>> propagated in all the software data structures.
>>
>> In case we re-use the DATBAS() register values as proposed in this patch, we
>> have the changes that the driver software data caches (i3c->addrs[].addr)
>> and the subsystem I3C devices addresses to match. But, that may not be true
>> all the time.
>>
>> If we re-assign new addresses to i3c->addrs[].addr in the DAA API, then
>> write those values to DATBAS() registers, but the bus is fully populated, or
>> no new devices are discovered as the indices remains the same, then, since
>> we execute i3c_master_add_i3c_dev_locked() only for the newly attached
>> devices, then the subsystem and the driver addresses don't match anymore. I
>> couldn't found a global API similar to i3c_master_add_i3c_dev_locked() to
>> work for removing devices and re-attaching at resume, for such scenario. I'm
>> not sure that's good to do, though. If we call
>> i3c_master_add_i3c_dev_locked() unconditionally, then it will still not work
>> on a full previously occupied bus.
>>
>> If I'm not wrong with all these, could you please let me know how would you
>> consider covering this scenario? This is what I've tried to address with the
>> approach in this patch. I currently don't have a testing setup for this, I
>> only simulated it by setting i3c->free_pos = 0 before calling
>> i3c_master_do_daa_ext().
>>
>> Would the usage of i3c_device_do_setdasa() being called from a master driver
>> be something acceptable? Though, I currently haven't played around with it.
>>
>> As I don't have a real setup to test this, would it be OK to restore the
>> approach in this patch as proposed in v1?
> This case is quite complex, and many people try to resolve simialar
> problems, you may want to reattach device because controller lost state.
> 
> hub have similar requirement, which need reattach devices.
> 
> https://lore.kernel.org/linux-i3c/20260525064209.2263045-1- 
> lakshay.piplani@nxp.com/T/#ma99fa92cb3aac770995350e0fc22c144b974a038
> 
> controller lost state, but may i3c devices still alive and they dynamtic
> address during suspend. Does reattach to the old address help your case?
Yes, re-attaching works and I also need to update the subsystem data structures. 
Something like the following works for me:

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index cd7f33250b7c..494703a87a18 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -252,6 +252,7 @@ struct renesas_i3c_xferqueue {
  };

  struct renesas_i3c_addr {
+       struct i3c_dev_desc *dev_desc;
         bool is_i2c;
         u8 addr;
  };
@@ -771,15 +772,27 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
                 newdevs = 0;
         } else {
                 newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
-               newdevs &= ~olddevs;
+               if (!i3c->resuming)
+                       newdevs &= ~olddevs;
         }

         for (pos = 0; pos < i3c->maxdevs; pos++) {
-               if (newdevs & BIT(pos))
-                       i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos].addr);
+               if (newdevs & BIT(pos)) {
+                       if (i3c->resuming && i3c->addrs[pos].dev_desc) {
+                               struct i3c_dev_desc *dev = 
i3c->addrs[pos].dev_desc->dev->desc;
+                               u8 old_dyn_addr;
+
+                               old_dyn_addr = dev->info.dyn_addr;
+                               dev->info.dyn_addr = i3c->addrs[pos].addr;
+
+                               i3c_master_reattach_i3c_dev_locked(dev, 
old_dyn_addr);
+                       } else
+                               i3c_master_add_i3c_dev_locked(m, 
i3c->addrs[pos].addr);
+               }
         }

         return 0;
@@ -997,6 +1010,7 @@ static int renesas_i3c_attach_i3c_dev(struct i3c_dev_desc *dev)

         data->index = pos;
         i3c->addrs[pos].addr = dev->info.dyn_addr ? : dev->info.static_addr;
+       i3c->addrs[pos].dev_desc = dev;
         i3c->free_pos &= ~BIT(pos);

         renesas_writel(i3c->regs, DATBAS(pos), 
DATBAS_DVSTAD(dev->info.static_addr) |
@@ -1060,6 +1074,7 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc 
*dev)

         i3c_dev_set_master_data(dev, NULL);
         i3c->addrs[data->index].addr = 0;
+       i3c->addrs[data->index].dev_desc = NULL;
         i3c->free_pos |= BIT(data->index);
         kfree(data);

To me, this looks OK but I don't think it is yet completed. If I'm not wrong, 
even with this adjustment the problem may still persist when running DAA on a 
full ocupied bus at runtime (e.g. after devices are removed/inserted). This 
driver don't support hotplug but I noticed the ones that supports it do DAA on 
hotplug events.

Could you please let me know what's the procedure to go forward with this 
series? The approach proposed in the above diff depends on the series exporting 
i3c_master_reattach_i3c_dev_locked(), which is in progress.

If all good with the rest of the patches in this series, as I don't have a real 
setup to test this, would it be OK to switch this patch as it was in v1 and 
return with the adjustments in the above diff once the 
i3c_master_reattach_i3c_dev_locked() is integrated?

-- 
Thank you,
Claudiu
