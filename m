Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901039;
	b=sNpUBHAeR/jO0K9g9Wi64SLBrVWf9+npyZe+G0Mxs3Io1sxm20DOljJkTsQxw5VCQanh
	 /8l0ObOAUcVN7ct2xDgnS+VoRN2KhHTncno+djTMteJ9XB6m5VQUgJbqK1QxlkZcoym9/
	 j9FeV66nmqHz1sDwyJIjzL/rZ3rdhZJ5kJGMLWRQh144mcJJAmkCG0aBJDpA7vZZ1Z50c
	 FUT39dVD/KwY6ZgLfylcNq6eTYL5eG5Qr63y6NFp0Upd4eWZZuEG5OJjKCpmRUdnKm9PU
	 Q2m13fIC3cb7O8d8m5Orm3n8M2xiVnHwvcew2zevi/BLW6k59EOJHJJP2Nw5TVz16Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901039;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=G9NOx4IeQi+RRkkPdnfXiI87hM3WT2SiE3S/E8UwrBo=;
	b=X5yeYEGANnnFMRJxWoXTTP4xlXHfaNvBSIcI5dUsWSDW7tdt+a2V0mXoqI6uX6AAwb46
	 X58SYIjcJeXUMH35m1DYBsmFinEFJb9e39HOTAb08e0tIGCuM5XpRrL2SUN6f+9i+6Atr
	 UlivbbV88cPBFac/wjmQaOQxnjF4B3jlqxLyTNkiV6U38LdXH13a7a4WS9jl3uV66aOvu
	 8tX4/Bt5AI392OqQORcBNRE5kLHA1+45jjS3kL8QmREDAWtpnEMp0B5NhJI3fYkWhdl+C
	 emZvAaziTIxj3s1m54hX/QIEOUxVfKaTCHXFIrI03qWXsSUxzFvbHuVcutmSxuDDgKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tnc2xZnx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C0606A327;
	Sun, 25 Oct 2026 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tnc2xZnx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86151F01825;
	Sun, 25 Oct 2026 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901039;
	bh=G9NOx4IeQi+RRkkPdnfXiI87hM3WT2SiE3S/E8UwrBo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tnc2xZnxYNQTQabJjOWRCFBZ5hHsusGT2QU6AGBOzJFQ1wA36ynGfuaPX7J8+6ise
	 LP0HMB+PqiO7ZsymaZvlsowrhF5REtrscsvAlNR4hUSl3J/E0Y1hfOS1bPhPNBqRAK
	 quMvMhye/u/udtY5C7dcPB966dOtbPirSLM97asZl9PQESU0SEKxta3TjVfHYIJGiv
	 wbJSWLtIynEITkT2Bqt3EGSOkJczzE/V63QBWiFviurPQOnVjUbL70nWw39hxnON+e
	 5cbHTBGos10hcLHGOzHthysbfsFtmh5pfjUKZoWVUvI3Lhbf2CynDHayJTqfRReIoP
	 MMsJ/V2oFv6qw==
Subject: Re: [PATCH net v6 5/6] nfc: serialize firmware download state
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, oe-linux-nfc@lists.linux.dev,
 gio@octane.security, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 04:03:58 +0000
Message-ID: <179290103824.3134.1739068989213537290@kernel.org>
In-Reply-To: <20261021032443.44412-6-shubham@octane.security>
References: <20261021032443.44412-6-shubham@octane.security>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit nfc_fw_download_done() releases the shared
  fw_download_in_progress claim unconditionally, with no owner or…
- [Medium] The patch changes how the st-nci vendor command
  ST_NCI_HCI_DM_FWUPD_START behaves, and the commit message does not…
- [Medium] nfc_fw_download() now claims fw_download_in_progress with
  atomic_cmpxchg_acquire(0->1) and rejects every later request with…

--

nfc: serialize firmware download state

This patch turns nfc_dev->fw_download_in_progress into an atomic_t. Both
nfc_fw_download() and the st-nci FWUPD_START vendor command now claim it
with cmpxchg and return -EBUSY if a download is already in progress.
nfc_fw_download_done() copies the firmware name, then releases the claim
before sending the netlink completion notification.

> diff --git a/drivers/nfc/st-nci/vendor_cmds.c b/drivers/nfc/st-nci/vendor_cmds.c
> index 6335d7afca24f..ec577d497500c 100644
> --- a/drivers/nfc/st-nci/vendor_cmds.c
> +++ b/drivers/nfc/st-nci/vendor_cmds.c
> @@ -158,11 +158,12 @@ static int st_nci_hci_dm_fwupd_start(struct nfc_dev *dev, void *data,
>  	int r;
>  	struct nci_dev *ndev = nfc_get_drvdata(dev);
>  
> -	dev->fw_download_in_progress = true;
> +	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1))
> +		return -EBUSY;
>  	r = nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
>  			ST_NCI_HCI_DM_FWUPD_START, data, data_len, NULL);
>  	if (r)
> -		dev->fw_download_in_progress = false;
> +		atomic_set_release(&dev->fw_download_in_progress, 0);
>  
>  	return r;
>  }

[Severity: Medium]
This changes what the ST_NCI_HCI_DM_FWUPD_START vendor command does from
userspace, and the commit message doesn't mention it. Is that intended?

In st-nci the flag is set only by FWUPD_START. The only place it gets
cleared is st_nci_hci_dm_direct_load(). FWUPD_STOP leaves it alone:

drivers/nfc/st-nci/vendor_cmds.c:st_nci_hci_dm_fwupd_end() {
	...
	return nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
			ST_NCI_HCI_DM_FWUPD_STOP, data, data_len, NULL);
}

st_nci_hci_dm_reset() and the close/teardown paths don't clear it either.

Suppose a session is abandoned after a successful FWUPD_START: the tool
crashes, or it sends START then STOP, or START then RESET. Every later
FWUPD_START then returns -EBUSY. Before this patch, START was simply sent
again.

The only ways out seem to be sending DIRECT_LOAD, which sends
ST_NCI_HCI_DM_LOAD with user data to a chip that may already have left
update mode, or rebinding the driver.

There is a second change userspace can see. For NCI devices
dev->ops->fw_download is always nci_fw_download(). So while a vendor
START is pending, the new cmpxchg in nfc_fw_download() makes
NFC_CMD_FW_DOWNLOAD return -EBUSY on st-nci, where it used to return
-ENOTSUPP. Is that intended, given st-nci has no core firmware download
state to protect?

[ ... ]

> diff --git a/net/nfc/core.c b/net/nfc/core.c
> index f521669293f05..1f335fa7f6f07 100644
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c

[ ... ]

> @@ -53,10 +54,14 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
>  		goto error;
>  	}
>  
> -	dev->fw_download_in_progress = true;
> +	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1)) {
> +		rc = -EBUSY;
> +		goto error;
> +	}
> +

[Severity: Medium]
Can this leave a pn544 device stuck in -EBUSY for good?

pn544_hci_i2c_fw_download() returns 0 as soon as it has scheduled the
work:

drivers/nfc/pn544/i2c.c:pn544_hci_i2c_fw_download() {
	...
	phy->fw_work_state = FW_WORK_STATE_START;

	schedule_work(&phy->fw_work);

	return 0;
}

pn544_hci_i2c_fw_work() then waits in FW_WORK_STATE_WAIT_WRITE_ANSWER,
WAIT_CHECK_ANSWER or WAIT_SECURE_WRITE_ANSWER. It moves on only when the
IRQ handler reschedules the work, which needs run_mode == PN544_FW_MODE
and an interrupt from the chip. drivers/nfc/pn544/ has no timer or
timeout for these states.

So if the controller never answers (hung chip, I2C fault, bad image),
nfc_fw_download_done() is never called. After that:

  - every NFC_CMD_FW_DOWNLOAD fails with -EBUSY from this cmpxchg
  - nfc_dev_up() fails with -EBUSY from atomic_read_acquire()

This lasts until the i2c driver is unbound, which completes with -ENODEV
in pn544_hci_i2c_remove(), or until a reboot.

Before this patch, a second NFC_CMD_FW_DOWNLOAD reset fw_work_state to
START and rescheduled the work, so userspace could recover. Should there
be a timeout or a core abort path before this recovery is removed?

>  	rc = dev->ops->fw_download(dev, firmware_name);
>  	if (rc)
> -		dev->fw_download_in_progress = false;
> +		atomic_set_release(&dev->fw_download_in_progress, 0);
>  
>  error:
>  	device_unlock(&dev->dev);
> @@ -73,9 +78,12 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
>  int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
>  			 u32 result)
>  {
> -	dev->fw_download_in_progress = false;
> +	char name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
> +
> +	strscpy(name, firmware_name, sizeof(name));
> +	atomic_set_release(&dev->fw_download_in_progress, 0);

[Severity: High]
Can a second completion of the same download clear the claim of a newer
download here?

nfc_fw_download_done() releases the claim unconditionally. There is no
owner or generation check. At this commit nfcmrvl can finish one
download twice: fw_dnld_timeout() runs in timer context, and both it and
fw_dnld_rx_work() can call fw_dnld_over().

fw_dnld_over() syncs the timer only if it is still pending:

drivers/nfc/nfcmrvl/fw_dnld.c:fw_dnld_over() {
	...
	if (timer_pending(&priv->fw_dnld.timer))
		timer_delete_sync(&priv->fw_dnld.timer);
	...
}

So it doesn't wait for a timeout callback that is already running. Also,
the rx_work loop keeps dequeuing frames after fw_dnld_over(0).

A second completion can then:

  - call release_firmware() again on the same firmware, or on a newer one
  - delete a newer download's timer
  - halt the chip
  - clear the newer download's fw_download_in_progress claim

Later in the same series, the commit "nfc: nfcmrvl: stop firmware work
before unregistering" seems to fix this. There, fw_dnld_over() claims
completion through fw_dnld->active under rx_lock, calls
timer_delete_sync() unconditionally, and runs the timeout as
timeout_work on rx_wq. At this commit, though, the window is still
open.

>  
> -	return nfc_genl_fw_download_done(dev, firmware_name, result);
> +	return nfc_genl_fw_download_done(dev, name, result);
>  }
>  EXPORT_SYMBOL(nfc_fw_download_done);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021032443.44412-1-shubham%40octane.security
