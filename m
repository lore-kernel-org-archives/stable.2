Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412887;
	b=ir1c3qB/6j8L+d+KIJTu0bIwwzXwtZba84zHYGwVn9NC8+AkSJNOc5sjBni/J/znPsI6
	 7zb0AGf5uVYnvknfk87gWZeoiLmOy1053WScQpc7CxbHajRae3fzHjR1MpsMCee8s+B+h
	 gdU2So7hAA64sATz9TOVpo4lVh6IYdYYKd1cZiZL7IlSIFx+EMEdspyfPmlCh6/h+w3w1
	 Crtx9b+ueO/0nEYg7b8jLnQguULutU61BSn4uYuwYfXEFFdcCc3M0sFihN+FJH9DKlcYK
	 O5L6bXVbmiveSt9xgJzqJMEipuGwm8AHxWUs1SnKFhbKtNajndelBmPYI6XRb2i7VIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412887;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=//NJH9cDc4+QbK55lhh6lAvE1Jzbk1sEQRnauS9w+sU=;
	b=yk9ZAeu3wumFCGUgie0o5gPXaQqOEd71uLPgkPKKEKZMRT1vZpkJV4dAQfTzSU7Umj/W
	 7W5WRn+nFKaLOmGnIP/Ppx3qTo0gzR/rOzUzZabqbP0QN9DqvBd8PD2qcnZZlDI5qktvX
	 5bGEq1p5+4ee6/BYqMAOWxZzafN5FrRt/drLa9LVb13PA/6seM0tANwqjz/cEyxw9aEaE
	 KaB9M65BwrhYhNtRUWPCpZCBLdRe6E2H9Zun7BhZHzhyQ3LQZyRcoRGClZaHSsQfMxi5g
	 k0OF2rBZ7xNODgCvRwq2vt6vM3id/iz9aJ4JmtHDLi7cH59XtTUlWIKYFzl6LLC0qPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9n93YHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34663606A327;
	Mon, 23 Nov 2026 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9n93YHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3703E1F00ACF;
	Mon, 23 Nov 2026 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795412885;
	bh=//NJH9cDc4+QbK55lhh6lAvE1Jzbk1sEQRnauS9w+sU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h9n93YHgTR5WnzqFhlvTNgT/mTMfO2VKfLo9lVq+Q1RV4eI1bRwIWZ2F2xqXszTG3
	 x1PW7stmss8IViMUejTleeeZnPM0T4msSi9YA6S0YcXY1zd7AR2VUOT+rjbM6ajrau
	 rDEWNwEGbhmNWzC56HmsahXbfbf3Vr/4oyL8O/qzZHOtzQW81Offwheyg1V5TePwRo
	 t1oTNHbctShpJz9UyaL1zhqGAPN6L4pX1Yc287YnAx3fYIQG8xSOFiV6GzDh3sxFxM
	 tk2QK18zIs008kPAB3fHdsoNUim74QCTZG1Fn1wawajlWFJ5z4PBbynP2fVQPE/Psi
	 OKyEdqphnMXMg==
Subject: Re: [PATCH net] net: wwan: iosm: always send the host sleep message
 on suspend
From: netdev-bot+sashiko@kernel.org
To: davidlwesten@gmail.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 m.chetan.kumar@linux.intel.com, mail@maciej.szmigiero.name,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 05:48:04 +0000
Message-ID: <179541288475.3135.162337854159176054@kernel.org>
In-Reply-To: <20261122050039.861287-1-davidlwesten@gmail.com>
References: <20261122050039.861287-1-davidlwesten@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch sends every platform through ipc_pcie_suspend() ->
  ipc_imem_pm_suspend() -> ipc_protocol_suspend().
- [Medium] With this patch, every system suspend on D0L12 platforms
  relies on ipc_pm_wait_for_device_active().
- [Low] SIMPLE_DEV_PM_OPS(iosm_ipc_pm, ipc_pcie_suspend_cb,
  ipc_pcie_resume_cb) expands to SYSTEM_SLEEP_PM_OPS.
- [Low] The patch removes the only callers of the s2idle path but leaves
  its pieces behind, and one of them changes behaviour.
- [Low] The new comment in ipc_pcie_suspend_cb() says "The PCI core puts
  the device into D3 whatever the BIOS RTD3 setting says".
- [Low] net: wwan: iosm: wrong commit cited in Fixes: trailer

--

net: wwan: iosm: always send the host sleep message on suspend

This patch makes the iosm suspend and resume callbacks always use the
ENTER_SLEEP/EXIT_SLEEP host sleep message path (ipc_pcie_suspend() and
ipc_pcie_resume()). Before, the D0L12 doorbell-only s2idle path was chosen
from the BIOS RTD3 _DSM setting. The goal is to keep an XMM7360 usable
after suspend-to-idle when the PCI core puts it into D3hot.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511baa..dd7cfe3747efc 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -406,14 +406,10 @@ static int __maybe_unused ipc_pcie_suspend_cb(struct device *dev)
>  
>  	ipc_pcie = pci_get_drvdata(pdev);
>  
> -	switch (ipc_pcie->d3l2_support) {
> -	case IPC_PCIE_D0L12:
> -		ipc_pcie_suspend_s2idle(ipc_pcie);
> -		break;
> -	case IPC_PCIE_D3L2:
> -		ipc_pcie_suspend(ipc_pcie);
> -		break;
> -	}

[Severity: Low]

This removes the only callers of ipc_pcie_suspend_s2idle() and
ipc_pcie_resume_s2idle(). They are __maybe_unused, so a W=1 build won't
warn. ipc_imem_pm_s2idle_sleep(), ipc_protocol_s2idle_sleep() and
ipc_pm_set_s2idle_sleep() become dead code along with them.

ipc_pcie->d3l2_support is also still filled from the ACPI _DSM in
ipc_pcie_probe(), but nothing reads it any more. Should these be removed
too?

There is also a behaviour change. ipc_pcie_suspend_s2idle() was the only
code that set bit 0 of ipc_pcie->suspend, and that bit gates IRQ
processing:

drivers/net/wwan/iosm/iosm_ipc_irq.c:ipc_msi_interrupt() {
    ...
	if (!test_bit(0, &ipc_pcie->suspend))
		ipc_imem_irq_process(ipc_pcie->imem, instance);
    ...
}

On D0L12 platforms, MSIs that arrived between the suspend and resume
callbacks used to be dropped. Now they go to ipc_imem_irq_process() and
the tasklet. Was this intended?

The commit message doesn't mention it. The referenced commit f4dd5174e273
dealt with spurious XMM7560 wakeups on this same s2idle path.

> +	/* The PCI core puts the device into D3 whatever the BIOS RTD3 setting
> +	 * says, so the modem has to be told with the host sleep message.
> +	 */

[Severity: Low]

Is this comment true in general? For platform-manageable devices,
pci_target_state() returns whatever the firmware chooses:

drivers/pci/pci.c:pci_target_state() {
	if (platform_pci_power_manageable(dev)) {
		pci_power_t state = platform_pci_choose_state(dev);

		switch (state) {
		case PCI_POWER_ERROR:
		case PCI_UNKNOWN:
			return PCI_D3hot;

		case PCI_D1:
		case PCI_D2:
			if (pci_no_d1d2(dev))
				return PCI_D3hot;
		}

		return state;
	}
    ...
}

So firmware can choose PCI_D0. The commit message describes this as
platform-specific ("here chooses D3hot"). The comment turns it into a
general rule and uses it to justify ignoring d3l2_support.

Where firmware keeps the WWAN function in D0 for s2idle, the modem would
now get the ENTER_SLEEP/EXIT_SLEEP handshake while it stays in D0/L1.2.
The notes say that case was not tested, and neither were the XMM7560 or
platforms where the doorbells work.

> +	ipc_pcie_suspend(ipc_pcie);

[Severity: Low]
The Fixes: tag points at be8c936e540f ("net: iosm: power management").
That commit only added iosm_ipc_pm.c and iosm_ipc_pm.h.

The code this patch changes lives in iosm_ipc_pcie.c. That covers
ipc_pcie_suspend_cb() and ipc_pcie_resume_cb(), including the switch
on ipc_pcie->d3l2_support that picked between the s2idle doorbell path
and the host sleep message path. As far as I can tell, all of it came
in with 7e98d785ae61 ("net: iosm: entry point").

Should the tag be this instead?

  Fixes: 7e98d785ae61 ("net: iosm: entry point")

There is no runtime effect. But the stable tooling and anyone bisecting
later rely on the tag to find the commit that introduced the behaviour
being changed, so it is worth pointing at the right one.

[Severity: Medium]

Every platform now goes through
ipc_pcie_suspend()->ipc_imem_pm_suspend()->ipc_protocol_suspend(). That
includes D0L12 platforms and platforms without the _DSM. What happens when
the handshake fails?

ipc_pm_prepare_host_sleep() sets host_pm_state to
IPC_MEM_HOST_PM_SLEEP_WAIT_D3. If the wake ack times out, nothing sets it
back:

drivers/net/wwan/iosm/iosm_ipc_protocol.c:ipc_protocol_suspend() {
	if (!ipc_pm_prepare_host_sleep(&ipc_protocol->pm))
		goto err;
    ...
	if (!ipc_pm_wait_for_device_active(&ipc_protocol->pm)) {
		ipc_uevent_send(ipc_protocol->pcie->dev, UEVENT_MDM_TIMEOUT);
		goto err;
	}
    ...
err:
	return false;
}

Only the branch where sending ENTER_SLEEP fails resets host_pm_state to
ACTIVE.

On resume, ipc_pm_prepare_host_active() rejects any state other than
IPC_MEM_HOST_PM_SLEEP. EXIT_SLEEP is then never sent and
ipc_imem_phase_update_check() is skipped. Every later suspend also fails in
ipc_pm_prepare_host_sleep(), which requires ACTIVE.

Meanwhile ipc_pm_signal_hpda_doorbell() holds doorbells back:

	if (host_slp_check && ipc_pm->host_pm_state != IPC_MEM_HOST_PM_ACTIVE &&
	    ipc_pm->host_pm_state != IPC_MEM_HOST_PM_ACTIVE_WAIT) {
		ipc_pm->pending_hpda_update = true;
		...
		return;
	}

ipc_pm_on_link_wake() only flushes pending_hpda_update in ACTIVE, and only
ipc_pm_init() resets host_pm_state. Would the DL_PROCESS, UL_WRITE_TD and
TD_UPD_TMR doorbells then stay held back until the driver is rebound?

A message timeout has a similar effect. When wait_for_completion_timeout()
returns 0, ipc_protocol_msg_send() logs "msg timeout" and still returns 0.
An ENTER_SLEEP the modem never acknowledged still moves host_pm_state to
SLEEP.

The failure result is also dropped. ipc_protocol_suspend() returns false
when the suspend must be aborted, but ipc_imem_pm_suspend() returns void.
ipc_pcie_suspend() and ipc_pcie_suspend_cb() always return 0.

When the handshake fails, the PCI core then puts the modem into D3hot with
no notice at all, not even the FORCE_SLEEP doorbell the old D0L12 path
rang. Isn't that the condition the commit message says leaves the modem
unusable?

Could host_pm_state be rolled back on failure, and then either fall back
to the doorbells or fail the suspend?

[Severity: Medium]

Every system suspend now depends on ipc_pm_wait_for_device_active(). Can
it lose the wake ack?

drivers/net/wwan/iosm/iosm_ipc_pm.c:ipc_pm_wait_for_device_active() {
	if (ipc_pm->ap_state != IPC_MEM_DEV_PM_ACTIVE) {
		smp_mb__before_atomic();
		set_bit(0, &ipc_pm->host_sleep_pend);
		smp_mb__after_atomic();

		if (!wait_for_completion_interruptible_timeout
		   (&ipc_pm->host_sleep_complete,
		    msecs_to_jiffies(IPC_PM_ACTIVE_TIMEOUT_MS))) {
    ...
}

ap_state is checked before set_bit() and not checked again. The modem
answers the WAKEUP doorbell from ipc_protocol_tq_wakeup_dev_slp()
asynchronously:

MSI -> tasklet
  ipc_protocol_pm_dev_sleep_handle()
    ipc_pm_dev_slp_notification()
      ipc_pm_trigger(IPC_PM_UNIT_LINK, true)
        ipc_pm_on_link_wake(ack=true)
          ipc_pm->ap_state = IPC_MEM_DEV_PM_ACTIVE;
          if (test_bit(CONSUME_STATE, &ipc_pm->host_sleep_pend))
              complete(&ipc_pm->host_sleep_complete);

The tasklet can run between the waiter's ap_state check and its
set_bit(), on another CPU or on the same CPU. In that case complete() is
skipped and the waiter times out after 500 ms. ipc_protocol_suspend() then
leaves host_pm_state at IPC_MEM_HOST_PM_SLEEP_WAIT_D3, as described above.

There is also a signal case. With a signal pending,
wait_for_completion_interruptible_timeout() returns -ERESTARTSYS, and the
!ret test treats that as success. ENTER_SLEEP is then sent while the link
is still waking:

- its doorbell is held back as pending_hpda_update
- ipc_pm_on_link_wake() won't flush it in SLEEP_WAIT_D3
- the message times out and ipc_protocol_msg_send() returns 0
- host_pm_state becomes SLEEP without the modem being told

This needs the callback to run in a task with a signal pending, for
example with pm_async=0.

host_sleep_complete is also never reset with reinit_completion(). A stale
complete() after a timeout mostly can't reach a later wait, though,
because ipc_pm_prepare_host_sleep() fails first.

>  
>  	return 0;
>  }
> @@ -427,14 +423,7 @@ static int __maybe_unused ipc_pcie_resume_cb(struct device *dev)
>  
>  	ipc_pcie = pci_get_drvdata(pdev);
>  
> -	switch (ipc_pcie->d3l2_support) {
> -	case IPC_PCIE_D0L12:
> -		ipc_pcie_resume_s2idle(ipc_pcie);
> -		break;
> -	case IPC_PCIE_D3L2:
> -		ipc_pcie_resume(ipc_pcie);
> -		break;
> -	}
> +	ipc_pcie_resume(ipc_pcie);

[Severity: Low]

SIMPLE_DEV_PM_OPS(iosm_ipc_pm, ipc_pcie_suspend_cb, ipc_pcie_resume_cb)
binds these callbacks to .freeze/.thaw/.poweroff/.restore as well as
.suspend/.resume. On D0L12 platforms, hibernation therefore also moves from
the doorbells to the ENTER_SLEEP/EXIT_SLEEP handshake. Is that intended?

The commit message only covers system suspend and suspend-to-idle testing.
The new D3 comment in ipc_pcie_suspend_cb() doesn't hold for freeze/thaw,
where the PCI core leaves the device in D0.

On restore, the restored driver has host_pm_state ==
IPC_MEM_HOST_PM_SLEEP from the snapshot. It sends EXIT_SLEEP to a modem
that the boot kernel re-initialized. If that message fails,
ipc_protocol_resume() sets host_pm_state back to SLEEP and the HPDA
doorbells are held back.

S3 on D0L12 platforms changes too. According to the notes, S3 was tested
only on top of the separate S3 series, which a stable backport will
usually lack.

The coverage caveats (not tested on XMM7560 or on platforms where the
doorbells work) are below the --- line, so they won't reach the git log.
Could the commit message mention hibernation, S3 and these caveats?

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122050039.861287-1-davidlwesten%40gmail.com
