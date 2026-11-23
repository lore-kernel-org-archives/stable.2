Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411072;
	b=fgpl31Bsp8sxbiZel9maCKMYAjXbjLrpL4aLNnaMmhBKoTRIvgnXhSnGfENsgeRRif8G
	 dJ7y4vrDpOhi47TYIpqx5CMQrsGEzn3Q48hsEafVsXUqk9u6/2NOEv3/vdbZrVFlwH1wE
	 X8YYfWWQtC7qMIQ1JHFONapT/fyfRRLKDsAJPAU2W76AigemsC6iktV3uaWS7LW+Md1qo
	 aSkQbTbpRx3EIb9MsV19h6u/7VUKTSVolxY/3MWXhXRu3xxRxqEHaoh3ktP3hiyXV2lCO
	 4RPDsggj3/d7BqltRHpVFCt+SntEE6nbzD0z3uWreZxkNl1WrK4/lgnuuCR4NeyJwNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411072;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=p4ilBBmu4wqkUrExqEeONwlOBor94s/7aXOC9EBEpWM=;
	b=VDk5cPPgDYvwJtIxA0P8DREDBhGYcH9lKz9tBL7WdvEQCuNZuvt7xC6PnE53LABoIjpO
	 m3SKi3z3xj3Pu03LysaQhIUbcNs0L5y8wNi4eJUkUBJaCCHXagIlhRCFUhXGvSzZ6vvPj
	 OGj5XVIaSZKNTn4P9OjqcvtE4cSEMsKhUZw970O1qobXsQSDr+aLS9hvQxoyoxNKruWKO
	 gkSRqwC/7exhG3ywx1rUwyKL2+4HxCxT6E8JjFic8WQihaSibiUtrS9N1WHdUaAU2X9FP
	 +JQtU6DLfvSHA9g45ZgeU6Gr/B4526mDUdQQTMzrMrHku2pO7No66TEr18rGUTwgG/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHyDgflT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC3606A336;
	Mon, 23 Nov 2026 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHyDgflT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EE11F000D0;
	Mon, 23 Nov 2026 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411072;
	bh=p4ilBBmu4wqkUrExqEeONwlOBor94s/7aXOC9EBEpWM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NHyDgflTwXBT0Xrs/2H7JNc/Ij6du99K29Hen2VvceONUtEVCZPe/gMDTEsACnoD4
	 jQcXlEiqM+m7RpoJeRL89u+S/s5s/6/QORkAKrGQQ/llMbDTipUcndCyTtpgl+o5hE
	 m6NlDdBns9q3ORCl73/RSZP2kwXAj3QkQbv847fno+hQ9iFANo54HZJmizfA/dqO97
	 g36qpeo8TW6gjtLt7JaAimXuuhfr0hYRlBuxGj6Vwgq8UgjNfwG7esbQ4F2zQermt8
	 QE8dORK7CE/EDGvx4SaK6yrruBuDBz0wMuh0pC2XAPB8vmqcdKbXLln7js4GcLW0Qf
	 3hdJ+h1sHXZzw==
Subject: Re: [PATCH net v2 2/2] net: wwan: iosm: fix S3 resume by re-binding
 the driver around it
From: netdev-bot+sashiko@kernel.org
To: davidlwesten@gmail.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 m.chetan.kumar@linux.intel.com, linux-kernel@vger.kernel.org,
 mail@maciej.szmigiero.name, nihaal@cse.iitm.ac.in, stable@vger.kernel.org
Date: Mon, 23 Nov 2026 05:17:50 +0000
Message-ID: <179541107082.3135.11504382259893948340@kernel.org>
In-Reply-To: <20261119042714.505405-2-davidlwesten@gmail.com>
References: <20261119042714.505405-2-davidlwesten@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free in the remove path, which this patch now runs on
  every S3 suspend while the modem is live.
- [Medium] When the card keeps power, the modem now goes into system
  sleep fully awake.
- [Low] The new PM_POST_SUSPEND branch in pm_notify() registers the
  driver again based only on the global `pci_registered` flag, which…
- [Low] The stable backport prerequisite is not declared.

--

net: wwan: iosm: fix S3 resume by re-binding the driver around it

This patch extends the iosm PM notifier. It now unregisters the PCI driver
on PM_SUSPEND_PREPARE, unless the default suspend mode is s2idle, and
registers it again on PM_POST_SUSPEND. This reuses the hibernation
mechanism from commit 0b6f6593aa8c, so the modem is probed again after it
reboots during S3.

> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Cc: stable@vger.kernel.org

[Severity: Low]
Will this apply to the stable trees that this Fixes: tag selects?

Commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding the
driver around it") added pm_notify(), pm_notifier and pci_registered. That
commit has no Fixes: or Cc: stable tag. A tree that has 1f52d7b62285 but
not 0b6f6593aa8c has no pm_notify() at all.

Could the prerequisite be named, for example with
"Cc: stable@vger.kernel.org # depends on 0b6f6593aa8c"?

The dependency on the preceding ADB timer patch is only described below
the --- line. That patch carries the same Fixes: and stable tags, so that
part is less of a concern.

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511baa..13e81012d818c 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -534,12 +534,17 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
>  
>  static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
>  {
> -	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +	/* The modem may lose power in S3 and S4 and boot again on resume,
> +	 * which the suspend/resume callbacks can't handle, so probe it again.
> +	 */
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
> +	    (mode == PM_SUSPEND_PREPARE && !pm_suspend_default_s2idle())) {
>  		if (pci_registered) {
>  			pci_unregister_driver(&iosm_ipc_driver);
>  			pci_registered = false;
>  		}

[Severity: High]
Can this expose a use-after-free of ipc_imem->ipc_task on every S3
suspend?

Here pci_unregister_driver() goes through ipc_pcie_remove() into
ipc_pcie_cleanup(). That function frees the imem resources before it
releases the MSI handlers:

drivers/net/wwan/iosm/iosm_ipc_pcie.c:ipc_pcie_cleanup() {
	/* Free the shared memory resources. */
	ipc_imem_cleanup(ipc_pcie->imem);

	ipc_pcie_resources_release(ipc_pcie);
	...
}

Inside ipc_imem_cleanup(), the CP is told to go to IPC UNINIT. Then the
tasklet and its container are freed, and the pointer is not cleared:

drivers/net/wwan/iosm/iosm_ipc_imem.c:ipc_imem_cleanup() {
	...
	ipc_imem_device_ipc_uninit(ipc_imem);
	ipc_imem_channel_reset(ipc_imem);

	ipc_protocol_deinit(ipc_imem->ipc_protocol);
	ipc_task_deinit(ipc_imem->ipc_task);

	kfree(ipc_imem->ipc_task);
	...
}

The threaded MSI handler is still registered at that point. Its only gate
is the s2idle suspend bit, and this path never sets it:

drivers/net/wwan/iosm/iosm_ipc_irq.c:ipc_msi_interrupt() {
	...
	if (!test_bit(0, &ipc_pcie->suspend))
		ipc_imem_irq_process(ipc_pcie->imem, instance);
	...
}

ipc_imem_irq_process() only checks ev_irq_pending[irq].
ipc_imem_handle_irq() clears that flag before its IPC_P_OFF_REQ early
return, so the flag doesn't block a new enqueue either.

An MSI that arrives after tasklet_kill() in ipc_task_deinit() schedules
the tasklet again just before it is kfree'd. An MSI that arrives after
kfree(ipc_imem->ipc_task) makes ipc_task_queue_add_task() read and write
the freed structure:

	struct tasklet_struct *ipc_tasklet = ipc_imem->ipc_task->ipc_tasklet;
	struct ipc_task_queue *ipc_task = &ipc_imem->ipc_task->ipc_queue;
	...
	spin_lock_irqsave(&ipc_task->q_lock, flags);
	...
	tasklet_schedule(ipc_tasklet);

The softirq could then run that tasklet after ipc_pcie_deinit() has also
freed imem and ipc_pcie.

The unbind and hibernation paths already use this ordering. This patch
puts it on the S3 path while the modem is running and has just been told
to go to UNINIT. Could the MSIs be quiesced or freed before
ipc_imem_cleanup() tears down the tasklet?

[Severity: Medium]
Does the modem now enter system sleep in D0 with its firmware still
running? This applies when the card keeps power in S3, or when freeze or
standby is entered while mem_sleep is deep.

The driver is unbound at PM_SUSPEND_PREPARE, so ipc_pcie_suspend_cb() no
longer runs and neither sleep handshake is sent:

	switch (ipc_pcie->d3l2_support) {
	case IPC_PCIE_D0L12:
		ipc_pcie_suspend_s2idle(ipc_pcie);
		break;
	case IPC_PCIE_D3L2:
		ipc_pcie_suspend(ipc_pcie);
		break;
	}

This skips both the IPC_MEM_DEV_PM_FORCE_SLEEP doorbell and the
ipc_imem_pm_suspend() host sleep message.

The PCI core also stops putting the device into a low power state. With no
driver bound, pci_pm_suspend_noirq() takes this branch and never reaches
pci_prepare_to_sleep():

drivers/pci/pci-driver.c:pci_pm_suspend_noirq() {
	...
	if (!pm) {
		pci_save_state(pci_dev);
		goto set_unknown;
	}
	...
}

Before suspend, the modem only gets IPC UNINIT from
ipc_imem_device_ipc_uninit(), which is not a sleep request.

Could this raise sleep power, or keep the platform out of S0ix during an
explicit s2idle? The changelog lists lost data sessions for these cases,
but it doesn't mention this.

> -	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
> +	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE ||
> +		   mode == PM_POST_SUSPEND) {
>  		if (!pci_registered) {
>  			int ret;

[Severity: Low]
Can this register the driver again in the middle of a uswsusp
hibernation?

The hibernation and suspend paths now share pci_registered.
snapshot_open() sends PM_HIBERNATION_PREPARE, which unbinds iosm. It then
drops system_transition_mutex while /dev/snapshot stays open:

kernel/power/user.c:snapshot_open() {
	...
	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
	...
 Unlock:
	unlock_system_sleep(sleep_flags);
	...
}

enter_state() only does a trylock on that mutex:

	if (!mutex_trylock(&system_transition_mutex))
		return -EBUSY;

Suppose a suspend to RAM starts before SNAPSHOT_FREEZE. PM_SUSPEND_PREPARE
does nothing because the driver is already unregistered. PM_POST_SUSPEND
then calls pci_register_driver() and sets pci_registered = true.

The hibernation image would then be created with iosm bound. The later
PM_POST_HIBERNATION from snapshot_release() does nothing, so the unbind
added by 0b6f6593aa8c is lost. Before this patch PM_POST_SUSPEND was
ignored, so this couldn't happen.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119042714.505405-1-davidlwesten%40gmail.com
