Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914315;
	b=v1V5MJvrrCXDg0Z39tSsj5Lr90m2dIub8GLgrBtby0h6ydvcfUaT6Pa0gSVyxCvanMZE
	 Ct1APSsGNI/1LR6sMh4ST3jpCRGuRiiWz4zSKtMnMYlAEY4Av15WiCcA71cvu3qc28KTC
	 5mSrSr6TWgexePgwmAlSlFltfDm296u9n7WpT4CDOnEid7GC1gli5NXGnK8OawlFD8CYk
	 SHsSip7fviIdYjFQywscJNh/btc6Y8hiQw/qnF2ifrrXGStqzQVEbmdRdQRLLPk0bpHvb
	 SW3rE4V2EBkYVm1RetJgZF4oJyD29xRPcWX8auszmVkJvKwQhfpxAW9lgZGgsczk+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914315;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IqLBpYE7h7awA0TG7t8nA0duIGgbrcEUjs5NwXMZs9w=;
	b=xud7HHSwwToHSw5i+9qhC/rkQOiwdy9qRaE8QASpRahF2DqRFYc/0W//y/uslZkXcaVr
	 LVA2X9R7w2kQKyiUURRylJuViUZnlVh0hjUOpfTWdUieyJ3X2jMhNEwJwozw3NGFMGPhR
	 Ck6SseP7l4ts/Btoed8UsrDHIUlraN0uWkd/94yGcN5f0Wuf02/Us74nohGozHLhWhjQN
	 A0yEDlCIBH7L2BwIB6cIwFRVtKSKaQJNNknHePT47pEaazun106eaKs8tbKzK4pvUtR0x
	 W6CrJ5NxZ4NtP9iIYc1ytE9zfBoPxCS8qqnSKCDYs1ktx+IKxc+DvkSbrsqty0pgO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCaFIUZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFD606A883;
	Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCaFIUZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7801F000C8;
	Tue, 17 Nov 2026 11:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914315;
	bh=IqLBpYE7h7awA0TG7t8nA0duIGgbrcEUjs5NwXMZs9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mCaFIUZHgw8kLUr6stTj4HbPc4TcRO5utbPuxEnmgAh2uyLh1xZi8xwK8jP3U2fmD
	 smuWD0opczWQVBhCsXOtMOQyIebNiRDs+4AnLZMwvi4II0g2YITzYMsEpw7AoLNnNt
	 V78ked96eUSWdEvNqFUAjqjOzse+If31UgybNkxZrn7MVJzDNCRHzo321wLlyzJgZY
	 LSFaVSe4HyqMqI5d/YpqstPM5cx9PgX9n/P+rEzrOmZLvdl1SZkk1+OpBl/nT6X/6d
	 DSTysjKCUqcJ9LGqiYJvmnaqVLAEWWhLnuJkDp14qoFFqRh3x1nc3BOKr5e1JevbB9
	 6nKQLbxB1TvwQ==
Subject:
 Re: [PATCH net 3/3] igb: only allow runtime PM if the device can wake up
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zheng.z.yan@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:18:34 +0000
Message-ID: <179491431428.3136.15501039766024079493@kernel.org>
In-Reply-To: <20261113105835.3821433-3-antonio@mandelbit.com>
References: <20261113105835.3821433-3-antonio@mandelbit.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Probe and remove can disagree about the runtime PM usage
  count.
- [Medium] The patch decides whether igb may runtime-suspend from one
  pci_dev_run_wake() check in igb_probe().

--

igb: only allow runtime PM if the device can wake up

This patch changes igb_probe() so it drops the probe-time runtime PM
usage reference only when pci_dev_run_wake() is true. Devices that can't
signal a wake-up from D3 therefore no longer runtime suspend.
igb_remove() takes the reference back under the same condition.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f1ce9aa696ab7..145daee832640 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3677,7 +3677,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>  
> -	pm_runtime_put_noidle(&pdev->dev);
> +	/* A device that can't wake up wouldn't notice the link coming back
> +	 * while runtime suspended
> +	 */
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);

[Severity: Medium]
Is one check at probe time enough to close the bug described in the
commit message?

pci_dev_run_wake() depends on pci_target_state(), and that can change
after probe. On ACPI platforms, acpi_pci_choose_state() limits the
target to D3hot only when d3cold_allowed is clear:

drivers/pci/pci-acpi.c:acpi_pci_choose_state() {
    ...
	if (pdev->no_d3cold || !pdev->d3cold_allowed)
		d_max = ACPI_STATE_D3_HOT;
	else
		d_max = ACPI_STATE_D3_COLD;
    ...
}

Root can change d3cold_allowed through sysfs while igb is bound.

Here is one sequence:

1. igb binds with d3cold_allowed=0. The target is D3hot and PME is
   supported from D3hot, so the probe check passes and the reference is
   dropped.
2. Root writes d3cold_allowed=1, so the target becomes D3cold.
3. The part doesn't support PME from D3cold.

On the next link-down, igb_runtime_idle() or the watchdog schedules a
suspend. igb_runtime_suspend()->__igb_shutdown() arms the WUFC
link-change filter without any PCI-level check. Then
pci_finish_runtime_suspend() runs:

drivers/pci/pci.c:pci_finish_runtime_suspend() {
    ...
	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

	error = pci_set_power_state(dev, target_state);
    ...
}

pci_dev_run_wake() is now false. Wouldn't the device then go into D3cold
with PME disarmed? The port would stay down after the cable is plugged
back in, until user space resumes it.

Could igb_runtime_idle() or igb_runtime_suspend() return -EBUSY when
pci_dev_run_wake() is false? That would cover this case and also remove
the need for the separate probe and remove accounting below.

>  	return 0;
>  
>  err_register:
> @@ -3899,7 +3903,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  
> -	pm_runtime_get_noresume(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);

[Severity: Medium]
Can igb_probe() and igb_remove() disagree about the runtime PM usage
count here?

igb_remove() calls pci_dev_run_wake() again instead of reusing the
decision made in igb_probe(). The result comes from
pci_pme_capable(dev, pci_target_state(dev, true)), and the target state
can change while the driver is bound.

One way it can change is a write to d3cold_allowed through
d3cold_allowed_store(). That changes what acpi_pci_choose_state()
returns, as described above.

Another way is surprise removal of a runtime-suspended igb that the
platform does not manage. pci_device_remove() calls
pm_runtime_get_sync() before drv->remove(), and during that resume
pci_power_up() does:

drivers/pci/pci.c:pci_power_up() {
    ...
	if (pci_dev_is_disconnected(dev)) {
		dev->current_state = PCI_D3cold;
		return -EIO;
	}
    ...
}

pci_target_state() then returns PCI_D3cold when igb_remove() runs. On a
part with PME from D3hot but not from D3cold, pci_dev_run_wake()
changes from true to false.

After that, pci_device_remove() runs the same sequence regardless:

drivers/pci/pci-driver.c:pci_device_remove() {
    ...
		pm_runtime_get_sync(dev);
		pm_runtime_barrier(dev);
		drv->remove(pci_dev);
		pm_runtime_put_noidle(dev);
	}
    ...
	pm_runtime_put_sync(dev);
    ...
}

If the check was false at probe and true at remove, doesn't the usage
count stay one too high for good? The device could then never runtime
suspend again, even after rebinding.

If the check was true at probe and false at remove, doesn't this drop
one reference too many?

With power/control=auto, rpm_drop_usage_count() would warn "Runtime PM
usage count underflow!". With power/control=on, the extra put would
silently cancel the pm_runtime_forbid() reference.

Would it help to save the probe-time decision in struct igb_adapter and
test that flag in igb_remove()?

e1000e and r8169 also re-check pci_dev_run_wake() in their remove paths.
Following them doesn't by itself show that the pattern stays balanced.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113105835.3821433-1-antonio%40mandelbit.com
