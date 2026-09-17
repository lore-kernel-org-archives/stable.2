Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EA4ED1AD;
	Thu, 17 Sep 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677235; cv=none; b=r385Ap6FdUkcSC/NPBWeRv1cXJpWZTQPQNDNXscRiJM6biUQ18lS5BoqyJxkKT6qbF7Q5bCy9b1L4+ASBFIgwiYTBtw7ExJSA4OPEUBHFTBJxxmevrwxOTM61fjXMLwvZyvUP+rCWt+LDG2w0fSo10csH9ZEtZsyVLW1A37uOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677235; c=relaxed/simple;
	bh=TuXfcPHBp9FvahIvid7hsJ/Khq5HIE0Mo0o7Kr8D+ZY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4XwhT+j1VQNm7WUkUqWETrKmjEzWpGyfpPPZVy0sOSg50XmoqN42L6/7jIJbqUB+viLturVEI7nvzKsXoHYWHPWTOv0m/fX4XWrd80LXiuHVjZOvVCcv6qQTrHSxkMvEItgo/GLTjNFw1MtuBKDpBmPtGl7P9zOH4EKok+P7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEBfqQHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEBfqQHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D941F000FF;
	Thu, 17 Sep 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677233;
	bh=Yr7HK0kftoCdmM8bNrRVERfce8uX3MHxXvfOKuyBG14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IEBfqQHem+ge2XtMpOTXxgH0gTi0qyOk5qgM0H3xPfJ8J0UlX1TsRgGIl5KsKVCSZ
	 GqEBm2ekzEJVfqez8DHfl8rClyn+2NlH259swPEkBIHV3iDBy8qu+r9pte32DHd/NS
	 Us1MjbaRYDZ2aDNXOr8ZCPdoPUotrGg7Y1v25pi3zObnaiQrWp6B5JjUIb2GZCEdu3
	 vcC5odKSY5lsFZQ39VVp0zjxZAXMWdP8+55gtgeMDnEYwWlJOSVPhFFg5nDHX+zN6A
	 UYlH+KqB7YCkyAc4PlCYTcva50qzJ+jobvt3eRlKutTCvdPP0YYlbusrcDdInqdfIW
	 0tmswI8+3iLUQ==
Subject: Re: [PATCH] net: ionic: free VF resources on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
 kees@kernel.org, tiwai@suse.de, wangruikang@iscas.ac.cn, sln@onemain.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 20:33:52 +0000
Message-ID: <178967723229.22033.17764468265213166164@kernel.org>
In-Reply-To: <20260916053117.2906446-1-lgs201920130244@gmail.com>
References: <20260916053117.2906446-1-lgs201920130244@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] The newly added `ionic_vf_dealloc()` call in `ionic_remove()`
  (ionic_bus_pci.c:427) reaches `ionic_vf_dealloc_locked()`…

Pre-existing issues:
- [Medium] `ionic_vf_start()`
  (drivers/net/ethernet/pensando/ionic/ionic_dev.c:804-816) issues a…

--

net: ionic: free VF resources on remove

The patch adds a call to ionic_vf_dealloc() in ionic_remove() so that the
VF tracking array and the per-VF statistics DMA mappings created by
ionic_vf_alloc() during probe are released when the PF driver is removed.
Previously only the probe failure path did this.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c8..666efe972de78 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -424,6 +424,7 @@ static void ionic_remove(struct pci_dev *pdev)
>  		ionic_auxbus_unregister(ionic->lif);
>  		ionic_lif_unregister(ionic->lif);
>  		ionic_devlink_unregister(ionic);
> +		ionic_vf_dealloc(ionic);

[Severity: Medium]
Can the device still be DMAing into the VF statistics buffers at this
point?  ionic_vf_dealloc() -> ionic_vf_dealloc_locked() asks the firmware
to un-arm each buffer but drops the result:

drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:ionic_vf_dealloc_locked() {
	...
		if (v->stats_pa) {
			vfc.stats_pa = 0;
			ionic_set_vf_config(ionic, i, &vfc);
			dma_unmap_single(ionic->dev, v->stats_pa,
					 sizeof(v->stats), DMA_FROM_DEVICE);
			v->stats_pa = 0;
		}
	...
	kfree(ionic->vfs);
}

ionic_set_vf_config() is a synchronous devcmd that can fail.
__ionic_dev_cmd_wait() returns -ENXIO when ionic_is_fw_running() reports
the firmware down, and on a stalled firmware it returns -ETIMEDOUT after
calling ionic_dev_cmd_clean(), which zeroes the doorbell and command area:

drivers/net/ethernet/pensando/ionic/ionic_main.c:__ionic_dev_cmd_wait() {
	...
		ionic_dev_cmd_clean(ionic);
		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
			 ionic_opcode_to_str(opcode), opcode, max_seconds);
		return -ETIMEDOUT;
	...
}

In that case the firmware never sees the clear request, yet the mapping is
unmapped and ionic->vfs is freed anyway.  Does anything stop DMA before
this?  SR-IOV is still enabled here (ionic_remove() never calls
pci_disable_sriov(), and pci_iov_remove() only prints "driver left SR-IOV
enabled after remove"), and ionic_port_reset(), ionic_reset() and
ionic_clear_pci() run afterwards, each of the preceding devcmds able to
block for DEVCMD_TIMEOUT first.  Can a later stats DMA then land on an
unmapped IOVA, or on recycled memory when no IOMMU is present?

The FW-down case looks anticipated by ionic_remove() itself, which turns
IONIC_LIF_F_FW_RESET into IONIC_LIF_F_FW_STOPPING just above, and
ionic_lif_reset() guards its devcmd with ionic_is_fw_running() for the same
reason.  Would it make sense to check the ionic_set_vf_config() return
value, or to skip the clear when the firmware is not running, before
unmapping?

The commit message says the call is made:

    "so the VF statistics addresses can be cleared"

On the failure paths above they are not cleared, although the mapping and
the tracking array are released regardless.  Could the message mention
that?

>  		ionic_lif_deinit(ionic->lif);
>  		ionic_lif_free(ionic->lif);
>  		ionic->lif = NULL;

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the VF
devcmd paths: ionic_vf_start() in ionic_dev.c issues a devcmd without
holding ionic->dev_cmd_lock, unlike ionic_set_vf_config() right above it
in the same file:

drivers/net/ethernet/pensando/ionic/ionic_dev.c:ionic_set_vf_config() {
	...
	mutex_lock(&ionic->dev_cmd_lock);
	ionic_dev_cmd_go(&ionic->idev, &cmd);
	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
	mutex_unlock(&ionic->dev_cmd_lock);
	...
}

drivers/net/ethernet/pensando/ionic/ionic_dev.c:ionic_vf_start() {
	...
	ionic_dev_cmd_go(&ionic->idev, &cmd);
	ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
}

The only caller, ionic_vf_attr_replay() in ionic_lif.c, drops vf_op_lock
and then calls it with no lock held:

	up_read(&ionic->vf_op_lock);

	ionic_vf_start(ionic);

Since idev->dev_cmd_regs->cmd/done/comp and idev->opcode are a single
shared window, can two unserialized sequences overwrite each other's
command and consume each other's completion?  The replay runs from
ionic_lif_deferred_work() -> ionic_lif_handle_fw_up() ->
ionic_restart_lif() -> ionic_vf_attr_replay(), before
clear_bit(IONIC_LIF_F_FW_RESET, ...), and ionic_firmware_update() in
ionic_fw.c takes dev_cmd_lock for its own commands without testing
IONIC_LIF_F_FW_RESET, so a concurrent devlink flash seems able to overlap.
This behaviour predates this patch (it goes back to the VF start control
change), and this patch does not touch ionic_vf_start().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916053117.2906446-1-lgs201920130244%40gmail.com
