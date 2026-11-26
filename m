Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712674;
	b=AOgHWFZ+fHVhVbqrFogt5WixRFKwdbH17ITsShGCYYSwRCXIQRhi/ifbkMRNJkpJ1sIM
	 KlHn9Nj+n3mYRxpTO15TDh6pjudcsL4FxmnPmr4nfTqHJRNAy1kpIUsyh8AqgN+JbZpGR
	 5QukQQo7BqVUeOg3NslrspR87stFcuVztuVqMK/bc1fPk5tHKbbdkMHZBBSUlVIfjhIb+
	 3sLl7opzRVngVdjZmXUQAG2IIbzWwjQKtQBHzMMCPoI03hTNdbt+0b4SzMNK64MxmGuNN
	 Z2CEfcQSVrQbPgH4HF7aHA58UdShwjkeekcHS5WcwkkcwKCTsWndfyBvXYepogkvKEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712674;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=X9gxt+mz/TULmt9o/Nqc5NO9HE0PhI4S9ybbS41Z5BI=;
	b=nTSHU8o7uJYZsbm63TVGXNJQCYPlFCXDImHEsyUuWQHEuwbuaFkYhfC/MrOViyasJVkS
	 BaV6f7RWqL3VZP0qcKZBIYDG9SENfs1Hqy67m7N2kxVOo39Ln6SKEWuTozRlxh8wsiLGh
	 jZi/LYYNagHhTh1+PKv/Mp8dcR91zTxZW5Bhi/SmiASoUxBh/ZMlP9Ka+kbgxJy2PYXz8
	 sc+b8VnO+oIR/WEkboup1CnY6mE4VZf7Am24z0ypDtD9yqBdnhBG/7Dvr2MihskYpgXYc
	 qOwzNy6lyUbNFVJmoarp8bNML9AeocRwU7eImL3PJyihaukYYqJdWHcsShY3T+IawRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iubu2FL4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F8606A31C;
	Thu, 26 Nov 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iubu2FL4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BB81F000C0;
	Thu, 26 Nov 2026 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712674;
	bh=X9gxt+mz/TULmt9o/Nqc5NO9HE0PhI4S9ybbS41Z5BI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iubu2FL4KRJ2u18YDk746L5Ty2aFXo4hJYjX9pu/ddFTDz2P+jXrrlejY9eT46bE6
	 QZdKWRNzUCwteC7p5iKz/Q/avMm1aa96D1lOJVEE+Qk3JviJMPorwl/ODwnnJRkuhR
	 jjscqSgiS5ZHn9zgXZG4LICOLFKgy610ib8Jw1Mw0gHNb20SPB/SQEtwfEzxoIFlk/
	 t9tP2noO9a3IVXUDKFiy65ggfcledvLWs8MSjq0TdoMrrlGsM9jDsBCqiGQgEmMndY
	 lKgjOK6oyF6NL6KmGRW58QAyhLskCiM01AxdaNMgSsIxyM65cUEu8LKk1wC23Is1HO
	 2frQEgH6P/OZA==
Message-ID: <f4805e08-06ac-4668-a081-668b180422f2@kernel.org>
Date: Thu, 26 Nov 2026 19:04:28 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/14] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-3-claudiu.beznea@kernel.org>
 <179562477303.5580.355686478965853081.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562477303.5580.355686478965853081.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 18:39, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The runtime PM documentation states the following:
>> - During system suspend, pm_runtime_get_noresume() is called for every
>>    device right before executing the subsystem-level .prepare() callback
>>    (in device_prepare()). In addition, the PM core disables runtime PM for
>>    every device right before executing the subsystem-level .suspend_late()
>>    callback (in device_suspend_late()).
>> - During system resume, pm_runtime_enable() is called for every device
>>    right after executing the subsystem-level .resume_early() callback (in
>>    device_resume_early()), and pm_runtime_put() is called right after
>>    executing the subsystem-level .complete() callback (in
>>    device_complete()).
>>
>> The driver's .suspend_noirq() callback is invoked after .suspend_late(),
>> while .resume_noirq() is invoked before .resume_early().
>>
>> If:
>> - the device is not part of the wake-up path, and
>> - its runtime PM status is not RPM_SUSPENDED,
>> the generic power domain .suspend_noirq()/.resume_noirq() callbacks
>> (genpd_suspend_noirq()/genpd_resume_noirq()) invoke the driver's
>> .suspend_noirq()/.resume_noirq() callbacks and call
>> genpd_stop_dev()/genpd_start_dev() before and after them, respectively.
>>
>> Calling genpd_stop_dev()/genpd_start_dev() allows devices whose power is
>> controlled by generic power domains to be powered off and on during
>> system suspend and resume, even though their runtime PM usage count does
>> not reach zero.
>>
>> Since the runtime PM usage count is incremented in device_prepare() and
>> decremented in device_complete(), runtime PM operations performed from
>> the driver's .suspend_noirq()/.resume_noirq() callbacks are no-ops. The
>> actual power transitions are handled by the generic power domain
>> .suspend_noirq()/.resume_noirq() callbacks.
>>
>> Moreover, attempting to runtime resume a device while runtime PM is
>> disabled may return -EACCES. This may cause system resume to fail when
>> resuming after a failed Root Port reset, as described in a subsequent
>> patch adding hot-plug support.
>>
>> Remove the runtime PM calls from the driver's
>> .suspend_noirq()/.resume_noirq() callbacks and rely on the generic power
>> domain callbacks to power the device off and on.
>>
> 
> Going by this logic, do you really need the pm_runtime_resume_and_get() in
> probe()?

Yes, it's needed. I just dropped it and it leads to:

[    0.688377] rzg3s-pcie-host 11e40000.pcie: host bridge /soc/pcie@11e40000 ranges:
[    0.688484] rzg3s-pcie-host 11e40000.pcie:      MEM 
0x0030000000..0x0037ffffff -> 0x0030000000
[    0.688525] rzg3s-pcie-host 11e40000.pcie:   IB MEM 
0x0040000000..0x013fffffff -> 0x0040000000
[    0.690412] 1004b800.serial: ttySC3 MMIO:0x000000001004b800 (irq = 44, 
base_baud = 0) is a scif
[    0.690581] printk: legacy console [ttySC3] enabled
[    1.814157] SError Interrupt on CPU0, code 0x00000000be000011 -- SError
[    1.814180] CPU: 0 UID: 0 PID: 37 Comm: kworker/u4:1 Tainted: G   M 
      7.4.0-rc3-next-20261120-00008-gd09508e93329-dirty #251 PREEMPT(full)
[    1.814193] Tainted: [M]=MACHINE_CHECK
[    1.814197] Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
[    1.814204] Workqueue: async async_run_entry_fn
[    1.814234] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.814242] pc : rzg3s_pcie_host_setup+0x17c/0x830
[    1.814261] lr : 0x(____ptrval____)
[    1.814271] sp : ffff80008383baf0
[    1.814275] x29: ffff80008383baf0 x28: ffff00000cbcdb58 x27: 0000000000000000
[    1.814287] x26: ffff00000cbcdbc0 x25: ffff00000cb70e40 x24: 0000000000000001
[    1.814297] x23: ffff800081e532b8 x22: ffff00000ba72010 x21: ffff00000cbcd800
[    1.814307] x20: ffff8000807d0b84 x19: 0000000000001014 x18: ffff800083a21044
[    1.814317] x17: ffff00000cb8b2c0 x16: 8000000000000000 x15: ffffffffffffffff
[    1.814327] x14: 0000000000001000 x13: 0000000140000000 x12: 000000013fffffff
[    1.814337] x11: 0000000000001010 x10: fffffffffffffff8 x9 : fffffffffffffff4
[    1.814347] x8 : fffffffffffffff0 x7 : 0000000000000001 x6 : 0000000100000000
[    1.814356] x5 : ffff800083a21054 x4 : 0000000100000000 x3 : 0000000040000000
[    1.814365] x2 : ffffffffffffffec x1 : 0000000000000002 x0 : fffffffffffffffc
[    1.814379] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.814386] CPU: 0 UID: 0 PID: 37 Comm: kworker/u4:1 Tainted: G   M 
      7.4.0-rc3-next-20261120-00008-gd09508e93329-dirty #251 PREEMPT(full)
[    1.814396] Tainted: [M]=MACHINE_CHECK
[    1.814399] Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
[    1.814403] Workqueue: async async_run_entry_fn
[    1.814412] Call trace:
[    1.814418]  show_stack+0x18/0x24 (C)
[    1.814437]  dump_stack_lvl+0x38/0x90
[    1.814455]  dump_stack+0x18/0x24
[    1.814465]  vpanic+0x39c/0x3b4
[    1.814478]  nmi_panic+0xf0/0x108
[    1.814487]  arm64_serror_panic+0x70/0x80
[    1.814496]  arm64_is_fatal_ras_serror+0x3c/0xb4
[    1.814504]  do_serror+0x58/0x78
[    1.814511]  el1h_64_error_handler+0x34/0x54
[    1.814523]  el1h_64_error+0x78/0x7c
[    1.814531]  rzg3s_pcie_host_setup+0x17c/0x830 (P)
[    1.814542]  rzg3s_pcie_probe+0x3d8/0x5f8
[    1.814552]  platform_probe+0x5c/0xac
[    1.814567]  really_probe+0xbc/0x2a0
[    1.814576]  __driver_probe_device+0x16c/0x19c
[    1.814585]  driver_probe_device+0x3c/0x114
[    1.814595]  __device_attach_driver+0xb8/0x118
[    1.814604]  bus_for_each_drv+0x80/0xdc
[    1.814613]  __device_attach_async_helper+0xec/0x134
[    1.814622]  async_run_entry_fn+0x34/0xe0
[    1.814631]  process_one_work+0x180/0x2dc
[    1.814646]  worker_thread+0x190/0x2f0
[    1.814656]  kthread+0x120/0x124
[    1.814667]  ret_from_fork+0x10/0x20
[    1.814683] Kernel Offset: disabled
[    1.814685] CPU features: 0x0,80000000,00800050,02300a02,0800e21b
[    1.814692] Memory Limit: none
[    2.083468] ---[ end Kernel panic - not syncing: Asynchronous SError 
Interrupt ]---

Genpd should also enable the power domain before this driver's probe().
Genpd calls genpd_power_on() through platform_probe() but the clock power 
domains implemented for the devices that uses this driver [1], [2], don't 
implement genpd .power_on()/.power_off().

On platform drivers probe:

platform_probe() ->
   dev_pm_domain_attach() ->
     genpd_dev_pm_attach() ->
       __genpd_dev_pm_attach(dev, dev, 0, 1, true) ->
         if (power_on) {
           genpd_lock(pd);
           ret = genpd_power_on(pd, dev, 0);
           genpd_unlock(pd);
         } 


pm_runtime_resume_and_get() calls genpd_start_dev(), which is, for [1] and [2]:

genpd->dev_ops.start = pm_clk_resume;

This enable the clocks for us and is what genpd calls on its own though resume.

Thank you for your review,
Claudiu

[1] 
https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/clk/renesas/rzg2l-cpg.c#L2607

[2] 
https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/clk/renesas/rzv2h-cpg.c#L1533
