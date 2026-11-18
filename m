Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014773;
	b=Ic8HeFa+vKJw0XgpoI6ykGDmUZdIij2B1L7ncyUVws4U+tm+rkEZA5ea418cLELP+hXh
	 aC84y85Oi6o7LbYibAlo5m3s1RNOKAUMQeZ1Tq58UgAxtZTo07KixH0ECnUkcJC9wBQJ+
	 iIbxA+6M9PrA10Q9NP/O2bj9teEmCq5GieR6oOUO5smTwIofzBA+gVz/plg6iaF0Y+Qnk
	 1VKCaVDl2pvgJaPnDjqRbZsEEeFpE5+3QB7U/3yE5lm7mqDNExIMiSYOGEPqZhMEA3NLm
	 zi3vHJpxavlieejnCjiSngZFUGbym9ytm0nd97i+4yyZJ24FtR8CbqB5ZVGuq5cosUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014773;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E1I4DMrDkkk5wAfSY5fVXBnZyddN9IWcr9/nWeAq8GU=;
	b=Ikn+zIO/rS3M0szF6xkGScDxjETZ4a3zZk9soh1ONovkmsHZVxf1nuMU+QZF3bEJkcA2
	 lt1NkLsL2h1Hya91FKAPSYCnxlo6+mhDqpCCJl7lqfqPpjDj/i3ds+JGdZGntLlFhcT0z
	 rINGoWAb/WNdIZAQggMYJecAN6GEt4Yst/AEbbmIMn7CbriUUWANq48lfXOLu1l9O18xH
	 uIv+OWi6dCCQHdi6LqM07npkLlJFBBNFguWxSH65mg+3AqTYNG+RkNm604qSxbfGMnGJ/
	 W/QO9jurVOWPEu9ccalQls4bYE1PPIeiovvAou4wXoP5297nlSUIPa4ClgLNwjMIRYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awDYblFx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2173606A320;
	Wed, 18 Nov 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awDYblFx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228631F000C6;
	Wed, 18 Nov 2026 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014772;
	bh=E1I4DMrDkkk5wAfSY5fVXBnZyddN9IWcr9/nWeAq8GU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=awDYblFx+WEEpUXZMK25lGzXz9uphm6TJa333icuaBvqyiJyFGZYYq3aTjXvQH568
	 kf7RXA7Xi0jMRxhsfUxtVkUo3Ea9pM3cmqPuuPG6CBSx0K4UMmWzjgbt0z44EgigrS
	 aG1kt4C9FJzFMelX1uKseLhMbm4cQc5UdRI1EG5LDDnPeeeff7NFhrb3JmYJzJEzRs
	 NqRNyKxXsg/tHE31wrZuHUwR6k35AdUiwCgwqUzdeY5ursz8s0jQmHxkJo+3lobadP
	 XhfWel0Kv67E7Ubft9VuEObglGEHGnDwrrJ149hC0wjqEPoIngSDVKlZzTofJ/8rdb
	 uwRnP17nA85og==
Subject: Re: [PATCH net] net: wwan: iosm: fix S3 resume by re-binding the
 driver around it
From: netdev-bot+sashiko@kernel.org
To: davidlwesten@gmail.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 m.chetan.kumar@linux.intel.com, linux-kernel@vger.kernel.org,
 mail@maciej.szmigiero.name, stable@vger.kernel.org
Date: Wed, 18 Nov 2026 15:12:51 +0000
Message-ID: <179501477167.3136.5713040375169842773@kernel.org>
In-Reply-To: <20261116031148.333990-1-davidlwesten@gmail.com>
References: <20261116031148.333990-1-davidlwesten@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] pm_notify() in drivers/net/wwan/iosm/iosm_ipc_pcie.c decides
  whether to unbind the driver on PM_SUSPEND_PREPARE by checking…
- [Medium] The changelog limits the problem to "platforms where S3 cuts
  power to the WWAN card".

Pre-existing issues:
- [High] ipc_imem_cleanup()
  (drivers/net/wwan/iosm/iosm_ipc_imem.c:1231-1266) cancels…

--

net: wwan: iosm: fix S3 resume by re-binding the driver around it

This patch extends pm_notify() in the iosm driver. When the default
suspend mode is not suspend-to-idle, the PCI driver is now unregistered
on PM_SUSPEND_PREPARE and registered again on PM_POST_SUSPEND. This is
the same approach the driver already uses for hibernation, and it means a
modem that lost power in S3 gets probed again after resume.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511baa..ec27d6fd79100 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -534,12 +534,17 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
>  
>  static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
>  {
> -	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +	/* The modem loses power in S3 and S4 and boots again on resume, which
> +	 * the suspend/resume callbacks can't handle, so probe it again.
> +	 */

[Severity: Medium]
The changelog limits the problem to "platforms where S3 cuts power to the
WWAN card". This comment says the modem loses power in S3 everywhere. Is
that true on every iosm platform?

The condition below has no platform, PCI device ID or BIOS RTD3 check. It
therefore also covers INTEL_CP_DEVICE_7560_ID, which the notes say was not
tested.

The driver already treats modem sleep power as platform dependent:

drivers/net/wwan/iosm/iosm_ipc_pcie.c:ipc_pcie_read_bios_cfg() {
    ...
	if (object->integer.value == 3)
		sleep_state = IPC_PCIE_D3L2;
    ...
}

ipc_pcie_suspend_cb() and ipc_pcie_resume_cb() use that setting to pick
the D0L12 or D3L2 path. ipc_imem_pm_resume() also already re-reads the
exec stage:

	if (ipc_protocol_resume(ipc_imem->ipc_protocol)) {
		stage = ipc_mmio_get_exec_stage(ipc_imem->mmio);
		ipc_imem_phase_update_check(ipc_imem, stage);

Because the driver is now unbound before every S3, none of these paths can
run during S3.

Some platforms keep the M.2 slot powered in S3. On those, the endpoint has
no driver during suspend, so pci_pm_suspend_noirq() skips
pci_prepare_to_sleep(). The modem then stays in D0 with no PME armed.
Every S3 cycle would also destroy and recreate the WWAN netdevs and the
/dev/wwan* ports, and drop any active data sessions.

Could this be gated on ipc_pcie->d3l2_support or a platform check? And
since the patch is tagged Cc: stable, could the changelog mention this
change in behaviour?

> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
> +	    (mode == PM_SUSPEND_PREPARE && !pm_suspend_default_s2idle())) {

[Severity: Medium]
Can pm_suspend_default_s2idle() tell S3 apart from s2idle here? It only
reports which state the "mem" label maps to:

kernel/power/suspend.c:pm_suspend_default_s2idle() {
	return mem_sleep_current == PM_SUSPEND_TO_IDLE;
}

state_store() only looks at mem_sleep_current when the string is "mem":

kernel/power/main.c:state_store() {
    ...
		if (state == PM_SUSPEND_MEM)
			state = mem_sleep_current;
    ...
}

"freeze" and "standby" go to pm_suspend() as PM_SUSPEND_TO_IDLE and
PM_SUSPEND_STANDBY directly.

So take mem_sleep=deep with "freeze" or "standby" written to
/sys/power/state, or mem_sleep=shallow with "mem". The system enters
s2idle or S1 and the modem keeps power, but pm_notify() still calls
pci_unregister_driver(). That skips the ipc_pcie_suspend_cb() handling.
With no driver bound, pci_pm_suspend_noirq() then only does this:

	if (!pm) {
		pci_save_state(pci_dev);
		goto set_unknown;
	}

The endpoint stays in D0 with no PME armed. On PM_POST_SUSPEND the modem
is probed again even though it was never power cycled.

The reverse case also exists. Some callers invoke
pm_suspend(PM_SUSPEND_MEM) directly and never consult mem_sleep_current.
Examples are test_wakealarm() for test_suspend=mem,
drivers/char/apm-emulation.c,
drivers/firmware/arm_scmi/scmi_power_control.c and
drivers/soc/xilinx/zynqmp_power.c.

If the default is s2idle, could these paths enter real S3 without the
unbind? That would leave the original "PORT open refused, phase
A-CD_READY" failure reachable.

The changelog says "Suspend-to-idle keeps the modem powered and is still
handled by the suspend/resume callbacks". That doesn't match the cases
above.

>  		if (pci_registered) {
>  			pci_unregister_driver(&iosm_ipc_driver);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
However, this teardown path used to run only on rmmod and hibernation.
With this patch it runs on every S3 cycle.

ipc_imem_cleanup() cancels four hrtimers, but not adb_timer:

drivers/net/wwan/iosm/iosm_ipc_imem.c:ipc_imem_cleanup() {
    ...
	hrtimer_cancel(&ipc_imem->td_alloc_timer);
	hrtimer_cancel(&ipc_imem->tdupdate_timer);
	hrtimer_cancel(&ipc_imem->fast_update_timer);
	hrtimer_cancel(&ipc_imem->startup_timer);
    ...
		ipc_mux_deinit(ipc_imem->mux);
    ...
	ipc_imem_device_ipc_uninit(ipc_imem);
    ...
}

With MUX_AGGREGATION (the 7560), the UL path arms adb_timer for 500 us
through ipc_imem_adb_timer_start(). PM_SUSPEND_PREPARE runs before tasks
are frozen, so UL traffic can still be flowing right up to teardown.

The sequence would be:

pm_notify(PM_SUSPEND_PREPARE)
  pci_unregister_driver()
    ipc_pcie_remove()
      ipc_pcie_cleanup()
        ipc_imem_cleanup()
          ipc_mux_deinit()
            kfree(ipc_mux), ipc_imem->mux is not cleared
          ipc_imem_device_ipc_uninit()
            usleep_range() for up to 30 ms, tasklet still alive

adb_timer fires
  ipc_imem_adb_timer_cb()
    ipc_task_queue_send_task(ipc_imem_tq_adb_timer_cb)

tasklet runs
  ipc_imem_tq_adb_timer_cb()
    ipc_mux_ul_adb_finish(ipc_imem->mux)    <- freed mux

Could this write into the freed iosm_mux through ul_adb->adbh, skb_put()
and channel->ul_list?

ipc_imem_cleanup() later does kfree(ipc_imem->ipc_task), and
ipc_pcie_deinit() then frees ipc_pcie->imem. If the timer were still
pending at that point, could the hrtimer embedded in the freed imem also
corrupt the timer base?

Should ipc_imem_cleanup() call hrtimer_cancel(&ipc_imem->adb_timer) along
with the other timers before this path runs on every S3?

>  			pci_registered = false;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116031148.333990-1-davidlwesten%40gmail.com
