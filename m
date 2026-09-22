Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9343CEC7;
	Tue, 22 Sep 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065948; cv=none; b=hicG0uZVEdJJy28iE/pVgDiSR91sTk9eGlborihyz4I8kB50UulfYBy8Jg1z/CJOOfgMHIvEZFehXyZzN8kuopxzPClt7H5FFtPgQ/nNQnwlSGKsLaZgF50ZRcggNQELP5cPaD4aKUAA7XAKPROZLkwW+bkywHxjFd11UYtdE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065948; c=relaxed/simple;
	bh=s2W+vC7qfOlhoVhBtv2it42AY6T85OB7bCXVy7nHOEU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDokSM+OC/JlEPdAbqt10/pfxRP0isZZLhSUbJB2Cvqt6DDVoSLXKctuUpGVtqmWNOyFRhqhcJE6s0u5sxuEDC2/Q3eEdQRBpYwUmWNfGrsLUwId6Lqgczs3bj2n5/Yrp0MfctCGA2NVnQlUs0cgI+ABgY86/C7pDBq0qxhCcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td+dKVFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td+dKVFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF381F000FF;
	Tue, 22 Sep 2026 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065946;
	bh=qPOLWIlNSFJKAgu6FC0EaLpmyXSHOORaVLH5FqtG1qs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Td+dKVFDSzQ62WjvTS0iQQ5HrArXQJmn4ccapDVLkEpAILpFmi8a2GdOWXIxn4c1+
	 b8krARHBSV9cXPEKxYildP1NQawSBuNdcihYWqJt/NOXQ276aF3j2ZxYwnAm5vEbc7
	 DBnMvEZ/1prV5MXDSfl62DegplM+9J8+Yxp0wOrsuaDF/S90ngPpAKwcPZDBYftRqs
	 5a/fakwGes54fBvVpLqaCpZYHApTtZes8lof5KSaX3kPtnSL2W5TzJCt97TXqH/ahT
	 d3gNpAvoWd44VLFuqBpz1766KGRtVqs5GN8e3NJj2LyzfUVn0H3VfgHHN9vQEbnWRf
	 r/DN2NKCy1EWw==
Subject: Re: [PATCH net v2 1/3] ieee802154: ca8210: prevent stack buffer
 overflow in ca8210_rx_done()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 08:32:25 +0000
Message-ID: <179006594544.2160803.13499921947508364292@kernel.org>
In-Reply-To: <20260921074205.2289211-1-benquike@gmail.com>
References: <20260921074205.2289211-1-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's factual basis is wrong.
- [Medium] ca8210_rx_done() still validates the device-declared frame
  length against the software buffer size instead of the number of bytes…

Pre-existing issues:
- [High] Unsynchronized stale stack pointer: ca8210_rx_done() writes
  device data through priv->sync_command_response, a bare pointer to the…
- [High] Sleeping calls in the spi_async() completion callback.
- [Low] Device-supplied length in the synchronous response consumer:
  hwme_get_request_sync() copies…

--

ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()

This patch clamps the synchronous response memcpy() in ca8210_rx_done() to
min_t(size_t, len, sizeof(struct mac_message)) so that a device-declared
length larger than the destination object cannot overwrite the synchronous
caller's stack frame.

A few questions about the change and the commit message below.

The commit message states:

>     priv->sync_command_response is non-NULL, memcpy() copies up to 256 bytes
>     into priv->sync_command_response, which points to a struct mac_message
>     object (sizeof(struct mac_message) = 250 bytes) on the synchronous
>     caller's stack, overflowing the stack buffer by up to 6 bytes:

[Severity: Medium]
Is the 250 byte figure correct?  struct mac_message in this file is:

	struct mac_message {
		u8      command_id;
		u8      length;
		union {
			struct mcps_data_request_pset       data_req;
			...
			u8                                  payload[148];
		} pdata;
	};

All members are u8, so the alignment is 1 and the largest union member is
payload[148] (data_req is 1+11+1+1+1+MAX_DATA_SIZE(114) = 129, set_req is
3+MAX_ATTRIBUTE_SIZE(122) = 125, hwme_get_cnf is 3+MAX_HWME_ATTRIBUTE_SIZE(16)
= 19).  That gives 2 + 148 = 150 bytes, not 250.

If that is right, then with len bounded only by CA8210_SPI_BUF_SIZE the
pre-patch worst case wrote 256 bytes into a 150 byte object, i.e. up to 106
bytes out of bounds rather than 6.  Could the description be corrected, since
stable backporters will be triaging this based on the stated magnitude?

The pasted report also says:

>       The buggy address belongs to stack of task init/1
>        and is located at offset 32 in frame:
>        ca8210_spi_exchange+0x0/0x190
>       This frame has 1 object:
>        [32, 282) 'response'

Can this frame come from this driver?  ca8210_spi_exchange() only receives a
pointer:

	static int ca8210_spi_exchange(
		const u8 *buf,
		size_t len,
		u8 *response,
		void *device_ref
	)

The struct mac_message response objects live in the sync helpers
(tdme_setsfr_request_sync(), mlme_*_request_sync(), hwme_*_request_sync()) and
are 150 bytes, so a 250 byte local named response in ca8210_spi_exchange()
does not appear to exist.  Could the actual reproducer output be included
instead?

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 01af4f9cf7f2..c009930da77a 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -697,7 +697,8 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
>  
>  	if (buf[0] & SPI_SYN) {
>  		if (priv->sync_command_response) {
> -			memcpy(priv->sync_command_response, buf, len);
> +			memcpy(priv->sync_command_response, buf,
> +			       min_t(size_t, len, sizeof(struct mac_message)));

[Severity: Medium]
Would it be better to fix the length validation instead of clamping one
consumer?  ca8210_rx_done() still validates the device-declared length against
the software buffer size:

	len = buf[1] + 2;
	if (len > CA8210_SPI_BUF_SIZE) {
		dev_crit(&priv->spi->dev,
			 "Received packet len (%u) erroneously long\n", len);
		goto finish;
	}

but every exchange only clocks in sizeof(struct mac_message) bytes, into a
buffer pre-filled with the idle pattern, in ca8210_spi_transfer():

	memset(cas_ctl->tx_in_buf, SPI_IDLE, CA8210_SPI_BUF_SIZE);
	...
	cas_ctl->transfer.len = sizeof(struct mac_message);

So for any declared len between 151 and 256, bytes 150..len-1 are the driver's
own 0xFF fill and were never driven by the CA8210.  The patch bounds the sync
memcpy only, while the same unbounded len is still handed to the other two
consumers in this function:

	cascoda_api_upstream(buf, len, priv->spi);
	...
	ca8210_net_rx(priv->hw, buf, len);

ca8210_net_rx() then calls ca8210_skb_rx(hw, len - 2, command + 2), so up to
106 bytes of idle fill can be delivered as 802.15.4 payload and exported
through the debugfs test FIFO.  This is reachable with well-formed traffic
too: a maximum size MCPS_DATA_indication (msdu 127 bytes at data_ind offset
29, plus an 11 byte secspec) declares len in the 158..169 range, so its tail
is replaced by 0xFF.

Would bounding the existing check by sizeof(struct mac_message) and dropping
the frame close this for all three consumers at once?

On the sync path the truncated copy is also followed unconditionally by
complete(&priv->sync_exchange_complete), so ca8210_spi_exchange() returns 0
and the caller parses a struct mac_message whose length field describes more
payload than was delivered.  Should a truncated confirm be reported as an
error rather than success?

[Severity: High]
This isn't a bug introduced by this patch, but does the clamp cover the
lifetime of the destination as well as its size?  priv->sync_command_response
is a bare pointer to the synchronous caller's on-stack struct mac_message,
published without any lock in ca8210_spi_exchange():

	if ((buf[0] & SPI_SYN) && response) { /* if sync wait for confirm */
		reinit_completion(&priv->sync_exchange_complete);
		priv->sync_command_response = response;
	}

On the -ETIME (CA8210_SYNC_TIMEOUT) and -ERESTARTSYS paths it simply clears
the pointer and returns, without cancelling or flushing the in-flight SPI
message:

	} else if (wait_remaining == 0) {
		dev_err(&spi->dev, "Synchronous confirm timeout\n");
		status = -ETIME;
	}

cleanup:
	priv->sync_command_response = NULL;
	return status;

The write side runs from the spi_async() completion callback,
ca8210_spi_transfer_complete() -> ca8210_rx_done(), and the confirm read is
queued straight from the hard IRQ handler
ca8210_interrupt_handler() -> ca8210_spi_transfer() -> spi_async().  Neither
side takes priv->lock and there is no READ_ONCE() or barrier, so can this
happen?

CPU0 (spi completion)			CPU1 (sync caller)
if (priv->sync_command_response)	/* non-NULL */
					wait ... times out
					priv->sync_command_response = NULL;
					return -ETIME;
					/* tdme_setsfr_request_sync() etc.
					   returns, frame reused */
memcpy(priv->sync_command_response,
       buf, ... );			/* writes dead stack frame */

Since the pointer is a plain load used both for the NULL test and as the
memcpy destination, and memcpy() is expanded inline through fortify-string,
could the compiler also reload it and observe the concurrent NULL store,
giving memcpy(NULL, ...)?

Would landing the confirm in a driver-owned buffer, or quiescing the
completion path before clearing the pointer, be a better fix than bounding the
length?

>  			complete(&priv->sync_exchange_complete);
>  		} else {
>  			if (cascoda_api_upstream)

[Severity: High]
This is a pre-existing issue and not something this patch introduced, but
while this function is being touched: can ca8210_rx_done() sleep in the
context it runs in?  It is called directly from
ca8210_spi_transfer_complete(), which is installed as cas_ctl->msg.complete
and submitted with spi_async().  The spi_async() kernel-doc in
drivers/spi/spi.c states "The completion callback is invoked in a context
which can't sleep", and ca8210_spi_transfer() itself allocates with
GFP_ATOMIC.

Further down in the same function, for
buf[0] == SPI_MCPS_DATA_CONFIRM with buf[3] == IEEE802154_TRANSACTION_OVERFLOW:

	msleep(2000);
	...
	mlme_reset_wpc = kmalloc_obj(*mlme_reset_wpc);

msleep() and the implicit GFP_KERNEL allocation can both sleep, and the test
path reaches ca8210_test_int_driver_write() which does kmemdup(..., GFP_KERNEL)
as well.  On controllers that finalize messages from hard IRQ or DMA
completion context, would this produce a "sleeping function called from
invalid context" splat, and on kthread-pump controllers stall the bus for two
seconds inside the completion callback?

The MLME reset is already deferred to priv->mlme_workqueue, so could the
msleep() and the allocation move into ca8210_mlme_reset_worker()?

[Severity: Low]
This is a pre-existing issue rather than something introduced here, and the
out-of-bounds part of it is already addressed by patch 2/3 of this series,
which adds:

	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
		if (response.pdata.hwme_get_cnf.hw_attribute_length >
		    *hw_attribute_length)
			return IEEE802154_SYSTEM_ERROR;

together with u8 lenvar = 1 in ca8210_get_ed().  What remains after the series
is that struct mac_message response is not zero-initialized in
hwme_get_request_sync() and the mlme_*_request_sync() helpers, unlike
tdme_setsfr_request_sync() which sets response.command_id = SPI_IDLE.  Since
ca8210_rx_done() now copies only the bytes the device actually sent, can a
short confirm leave response.command_id, status or the attribute bytes as
stale stack data, so that a wrong ED level or status is returned?  Would
zero-initializing response in those helpers close that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074205.2289211-1-benquike%40gmail.com
