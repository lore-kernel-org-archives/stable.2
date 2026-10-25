Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901040;
	b=OOo7teKWoLmIj5acnTUCqB1ZICDHThta3cWN7am4uhK4g+fBfvnQDgOE5Qe1CXXgBxrw
	 8QzZ78A/tmSIASZymiMOZAYWSJu9obe0/PT78GtLAyg+wrMvd6Sq1Fm/2qSit6MS1aSZS
	 VWt+1uv53a80ux/lcSDoutvGTPlcnEVMdccTrseQAb+U8A0Z0GpQeD3r8QPNNv/VrBPQL
	 +NEiIWBAOGignBNalGy035K3nL5foe0AJ6k/5T7YTpS/YRt3aW3ZcK5lCDHjp5sIDh7Ud
	 pPbfU7LfAmYnPy5lTbGJlOH0Wfrw5Khv+CDZ+iZb5K36xaeT4fbro1wZV9Y/DZHBBlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901040;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yV3DnlCa7cPKCYr05NihlpKIAyZk2yGPkehULISRMaE=;
	b=MHrtmKvl3+mjukexyitE2r+LE7ihVDj34SkmlGk4nLzqTDoIJ1US1zvz3NHgKqiKFXXR
	 PzLDo28hWmmgMMbFO9H0mRgQ7NgGXTE2oPBWQipFnRD1r/E9VTbklgLdYH+qq6vqwvPSx
	 UuS8aoM89Z2Jz/0LDD0HD83xJZFZ6a5NLVNSVvhoALHqVrVAZiLvj2WWz9MhC0GngfZUx
	 6XunBn9/uA4t0QNafUg+HbHQBfLf3uqlN7Zl8KOJH/Puul/Ys2rgz/B3nRdsoWGFVOn7Y
	 9V9SzBGHhXC+79mSjK7yeLxRwIh6zMQpMEqmukcTo94LnaWuv1IZ5vVODuAOn3k3+HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoKmTUfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAE606A31D;
	Sun, 25 Oct 2026 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoKmTUfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4CA1F01828;
	Sun, 25 Oct 2026 04:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901040;
	bh=yV3DnlCa7cPKCYr05NihlpKIAyZk2yGPkehULISRMaE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aoKmTUfGZoHx4Gm4woJ4O0GZPAUVdRHSHnNCmOVQQkwGFHzTsPnTITWuXty5x4P6E
	 PpsGQ40Js2irxkqSC2aMAe+auQ2QCrC5Sux3monelvI3HtZVqdTiPbOqD8pdTQHQqW
	 Hl6mz/L3xqdpuH/kZTstM9LR4BLBpLmHYXBdxaag+SYID1F5V+mw/xMBD2dJO8AqKr
	 Wt8ztIK2W/fTlnpGbyickkvqOmFZ/0DtTqP2KmBDC7WsnXnLCbmOodbGsvykZADXMi
	 7SrNbHCvo4LZCsiOcsHCfwrzxJ8h7d3T0NprVOnZcHu0yn0euCdARFPm4CA3uWSO7P
	 yrt7m7LegDlTg==
Subject:
 Re: [PATCH net v6 6/6] nfc: nfcmrvl: stop firmware work before unregistering
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, oe-linux-nfc@lists.linux.dev,
 gio@octane.security, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 04:03:59 +0000
Message-ID: <179290103922.3134.7272004019340679673@kernel.org>
In-Reply-To: <20261021032443.44412-7-shubham@octane.security>
References: <20261021032443.44412-7-shubham@octane.security>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Teardown can leave ndev->cmd_timer armed after the NCI device is
  freed.
- [Medium] The new order (nfcmrvl_fw_dnld_abort() before
  nci_unregister_device()) can leak an NCI command skb.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  process_state_fw_dnld(), which the reworked fw_dnld_rx_work() still…
- [Medium] This problem wasn't introduced by this patch, but nfcmrvl
  reports firmware download failures to the NFC core as negative errno…
- [Medium] This problem wasn't introduced by this patch, but
  nfcmrvl_fw_dnld_start() sets fw_dnld->active = true and then calls…

--

nfc: nfcmrvl: stop firmware work before unregistering

This commit adds active and stopping states, protected by a new rx_lock,
to fence the firmware receive entry points. It moves timeout completion
into a work item on the firmware workqueue and processes one rx frame per
work invocation. It also calls nfcmrvl_fw_dnld_abort() before
nci_unregister_device(), so firmware work is drained while the NCI
workqueues still exist.

> diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
> index 8b9d5257320dc..d3dec74a333d3 100644
> --- a/drivers/nfc/nfcmrvl/fw_dnld.c
> +++ b/drivers/nfc/nfcmrvl/fw_dnld.c
> @@ -92,11 +92,29 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
>  
>  static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
>  {

[ ... ]

> +	if (fw_dnld->fw) {
> +		release_firmware(fw_dnld->fw);
> +		fw_dnld->fw = NULL;
> +		fw_dnld->header = NULL;
> +		fw_dnld->binary_config = NULL;
>  	}
>  
>  	atomic_set(&priv->ndev->cmd_cnt, 0);
> @@ -104,8 +122,7 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
>  	if (timer_pending(&priv->ndev->cmd_timer))
>  		timer_delete_sync(&priv->ndev->cmd_timer);
>  

[Severity: High]
Can ndev->cmd_timer still be armed when nci_free_device() frees ndev?

Suppose fw_dnld_rx_work() has queued two commands back to back. Then
nci_cmd_work() has sent the first one (cmd_cnt is 0 and cmd_timer is
armed), and the second skb is still on ndev->cmd_q.

If nci_cmd_timer() has already been detached for expiry when
fw_dnld_over() runs, timer_pending() returns false and the sync delete is
skipped:

fw_dnld_over()
    atomic_set(&priv->ndev->cmd_cnt, 0);
    if (timer_pending(&priv->ndev->cmd_timer))   /* false */

nci_cmd_timer()   /* delayed callback */
    atomic_set(&ndev->cmd_cnt, 1);
    queue_work(ndev->cmd_wq, &ndev->cmd_work);

Suppose that queue_work() happens after the flush in the !NCI_UP branch
of nci_close_device():

nci_close_device()
    flush_workqueue(ndev->cmd_wq);
    timer_delete_sync(&ndev->cmd_timer);   /* waits only for the callback */

nci_cmd_work()
    skb = skb_dequeue(&ndev->cmd_q);
    ...
    nci_send_frame(ndev, skb);
    mod_timer(&ndev->cmd_timer,
              jiffies + msecs_to_jiffies(NCI_CMD_TIMEOUT));

destroy_workqueue(ndev->cmd_wq) waits for cmd_work, but it does not
cancel the timer.

Before this patch, nfcmrvl_fw_dnld_abort() ran after
nci_unregister_device(). The timer_pending()/timer_delete_sync() pair in
fw_dnld_over() then removed a re-armed cmd_timer. With this patch, the
second abort from nfcmrvl_fw_dnld_deinit() returns early because active
is already false, so nothing deletes the timer.

Would the timer then fire on the kfree()d ndev, calling atomic_set() on
ndev->cmd_cnt and queue_work() on the destroyed cmd_wq? The window is
narrow, but nothing seems to prevent it, for example with PREEMPT_RT timer
threads or vCPU preemption.

Should the shutdown also purge leftover firmware commands on ndev->cmd_q,
or delete cmd_timer unconditionally?

[ ... ]

> @@ -114,7 +131,7 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
>  		nfcmrvl_chip_halt(priv);
>  	}
>  
> -	nfc_fw_download_done(priv->ndev->nfc_dev, priv->fw_dnld.name, error);
> +	nfc_fw_download_done(priv->ndev->nfc_dev, name, error);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the sign of error
right here?

The kernel-doc for nfc_fw_download_done() describes @result as "The
positive value of a standard errno value". nfc_genl_fw_download_done()
then passes it unchanged to userspace via nla_put_u32() in
NFC_ATTR_FIRMWARE_DOWNLOAD_STATUS.

fw_dnld_over() gets -ETIMEDOUT from fw_dnld_timeout_work(), -EHOSTDOWN
from nfcmrvl_fw_dnld_abort(), and negative process_state_*() return
values from fw_dnld_rx_work(). Userspace therefore sees 0xFFFFFF92 or
0xFFFFFF90 instead of 110 or 112. The "%d" in the nfc_info() message
hides this in the log.

Other drivers negate the value first, for example
nxp_nci_fw_work_complete():

    nfc_fw_download_done(info->ndev->nfc_dev, fw_info->name, (u32) -result);

pn544_hci_i2c_fw_work_complete() does the same.

This patch rewrites this call and adds new paths into fw_dnld_over().
Could it pass -error here?

[ ... ]

> @@ -404,53 +434,64 @@ static void fw_dnld_rx_work(struct work_struct *work)

[ ... ]

> +	case STATE_FW_DNLD:
> +		ret = process_state_fw_dnld(priv, skb);
> +		break;

[Severity: High]
This is a pre-existing issue, but process_state_fw_dnld(), which still
gets its frames from here, trusts the 16-bit chunk length from the
controller. In SUBSTATE_WAIT_COMMAND, the only check is the complement:

    len = get_unaligned_le16(skb->data);
    ...
    if (((~len) & 0xFFFF) != comp_len) {
    ...
    priv->fw_dnld.chunk_len = len;

Then in SUBSTATE_WAIT_ACK_CREDIT:

    out_skb = alloc_lc_skb(priv, priv->fw_dnld.chunk_len);
    ...
    skb_put_data(out_skb,
                 ((uint8_t *)priv->fw_dnld.fw->data) + priv->fw_dnld.offset,
                 priv->fw_dnld.chunk_len);

alloc_lc_skb() takes uint8_t plen. With len = 0xFF00 and complement
0x00FF, the skb is sized for NCI_DATA_HDR_SIZE + 0. Would skb_put_data()
with the full 0xFF00 then hit skb_over_panic()?

SUBSTATE_WAIT_DATA_CREDIT also does this with no check against fw->size:

    priv->fw_dnld.offset += priv->fw_dnld.chunk_len;

Could a controller that keeps repeating command/credit cycles with
chunk_len <= 255 make skb_put_data() read past the end of the firmware
image, and send that memory back to the device?

The I2C, SPI and UART PHYs set support_fw_dnld, so they can reach this.

[ ... ]

> @@ -546,8 +628,19 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
>  
>  	/* First, reset the chip */
>  	priv->fw_dnld.state = STATE_RESET;
> +
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	fw_dnld->active = true;
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
> +
>  	nfcmrvl_chip_reset(priv);
>  
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	if (fw_dnld->active)
> +		mod_timer(&fw_dnld->timer,
> +			  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);

[Severity: Medium]
This is a pre-existing issue, but what happens to the reset line if the
download fails while nfcmrvl_chip_reset() is sleeping?

active is set before the reset pulse, so nfcmrvl_fw_dnld_recv_frame()
accepts frames during the usleep_range(5000, 10000) in
nfcmrvl_chip_reset(). A frame that isn't CORE_RESET_NTF makes
process_state_reset() return -EINVAL. That could be stale transport data,
or a misbehaving or pty-backed controller:

fw_dnld_rx_work()
    process_state_reset()        /* -EINVAL */
    fw_dnld_over()
        nfcmrvl_chip_halt()      /* reset_gpio = 1 */
        nfc_fw_download_done()

nfcmrvl_fw_dnld_start() resumes
    nfcmrvl_chip_reset()
        gpiod_set_value(priv->config.reset_gpio, 0);

Doesn't this take the chip back out of reset after userspace has already
been told the download failed? The chip's CORE_RESET_NTF would then be
dropped, because fw_download_in_progress is clear.

The new "if (fw_dnld->active)" check before mod_timer() covers completion
during the reset for the timer, but not for the reset GPIO.

[ ... ]

> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 27fadd64155e1..86cf653962535 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c
> @@ -185,13 +185,12 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
>  {
>  	struct nci_dev *ndev = priv->ndev;
>  
> +	nfcmrvl_fw_dnld_abort(priv);
>  	nci_unregister_device(ndev);

[Severity: Medium]
Can this new ordering leak an NCI command skb left on ndev->cmd_q?

fw_dnld_rx_work()->process_state_*()->nci_send_cmd() puts an skb on
ndev->cmd_q and queues ndev->cmd_work on ndev->cmd_wq.
cancel_work_sync(&fw_dnld->rx_work) in nfcmrvl_fw_dnld_abort() does not
wait for that cmd_work. fw_dnld_over() then does:

    atomic_set(&priv->ndev->cmd_cnt, 0);

If cmd_work runs after that, nci_cmd_work() sees cmd_cnt == 0 and leaves
the skb on the queue:

    if (atomic_read(&ndev->cmd_cnt)) {
        skb = skb_dequeue(&ndev->cmd_q);

NCI_UP is clear during a firmware download, so nci_close_device() takes
the !NCI_UP branch. That branch only flushes cmd_wq and deletes the
timers, without purging cmd_q. nci_free_device() doesn't purge cmd_q
either, so the skb is lost when ndev is freed.

Before this patch, the abort ran after nci_unregister_device(). The
cmd_wq flush then ran with cmd_cnt still 1 from
nfcmrvl_fw_dnld_recv_frame(), so the queued command was consumed.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021032443.44412-1-shubham%40octane.security
