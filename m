Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26403B585F;
	Sun,  4 Oct 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099572; cv=none; b=unhLBbUQMui0XFGyeWf1LSZyrNX8/2VSDe7j63ZndAPF6d0UmBjPQk9Z/CnNC3nqkHfoFuPbB3ul5vd8Sfm7N0QiAW0ggTY6ytz/46QCEbKjZ9rygxOSiMTnnACHx+LcTXM5NIvGElez/m+RCS98Azu1UKtdcyTvEUPRlWTe1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099572; c=relaxed/simple;
	bh=bNHru6tPNOl7NkQDLeKwO5c/1mzXsHz05Fm4tjjZdvM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uw6PmvmU9gpF6chL1nAYoE/lWa0E6uCWnrbbvPi9mn0s/d29+ExDzXcAvdBjBt+yYd/PAOxC1DyYBK6z1BLDQ0YFP56uBTqFjdgMuwj1AHpfAEfJBHB5q5crTDa0WV57J7BvxtkhfU5Gb9Ml9zIT8UTUXhxylsQdRvEpWt+1WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc9EBcST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc9EBcST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B61F000FF;
	Sun,  4 Oct 2026 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099568;
	bh=1/SM6hfU17pkgG+PJ5/yRnxH8auKg8f1+S1/we4zQ4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bc9EBcSTn0DNh6IJtBZ/RTNMu5OqtcEF+t8q1eYCVlnE4PKzQzuQLKJ58pipQVGOK
	 Mbh3T/vNL80V4DuymurHUiNrCQxeZlpBIe3zf5ZqRyYksc+fkxBFTzGo3pazg3OI9r
	 3H7s7kWjM6sk9d9JrLomnxStZalwB6c3vezgQOGZ+PjcWOmrvPKEEwuASraT+E9jmF
	 ugsjJ47UqQwhyX5EC9d9TcAVrcMrQ5DF0vTnUtxwiOo89to4gxI+ggziXunyRLPBLw
	 B/4yXxYRKjGX6TK6RMlFzb1J2BZWq6vdoe+BcVfhDUlpkPO85iPTPx8wSvw3r0JWzu
	 H21D7IpqdMr9g==
Subject: Re: [PATCH net v3 1/3] ieee802154: ca8210: prevent stack buffer
 overflow in ca8210_rx_done()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 04 Oct 2026 07:39:27 +0000
Message-ID: <179109956717.434549.8174843499392291323@kernel.org>
In-Reply-To: <20260930071914.421586-2-benquike@gmail.com>
References: <20260930071914.421586-2-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ieee802154: ca8210: dropped Rx frames and log flood DoS due to
  length limit

Pre-existing issues:
- [High] priv->sync_command_response is a plain pointer to a synchronous
  caller's on-stack struct mac_message, and nothing synchronizes access…
- [High] ca8210_rx_done() calls msleep(2000) (line 718) and then
  kmalloc_obj(*mlme_reset_wpc) (line 723, default GFP_KERNEL) when it…
- [Low] Baseline decision: not reported (preexisting, low impact, outside
  the bug class the commit claims to fix).

--

ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()

This patch changes the length check in ca8210_rx_done() so that it compares
against sizeof(struct mac_message) instead of CA8210_SPI_BUF_SIZE. A
response that is too long is now logged and dropped. It is no longer copied
into the synchronous caller's on-stack response buffer or passed to
ca8210_net_rx().

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 01af4f9cf7f29..a990a0f347ad8 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -686,7 +686,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
>  
>  	buf = cas_ctl->tx_in_buf;
>  	len = buf[1] + 2;
> -	if (len > CA8210_SPI_BUF_SIZE) {
> +	if (len > sizeof(struct mac_message)) {
>  		dev_crit(
>  			&priv->spi->dev,
>  			"Received packet len (%u) erroneously long\n",

[Severity: High]
Does this new limit also drop legitimate MCPS-DATA.indication frames?

The check sits at the top of ca8210_rx_done(), so it applies to every
message from the device. It is not limited to the synchronous responses
that get copied into priv->sync_command_response.

ca8210_net_rx() passes SPI_MCPS_DATA_INDICATION payloads to
ca8210_skb_rx() as buf + 2. ca8210_skb_rx() then reads the security
spec that follows the MSDU:

	hdr.sec.level = data_ind[29 + msdulen];
	...
	if (hdr.sec.level > 0) {
		hdr.sec.key_id_mode = data_ind[30 + msdulen];
		memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
		hdr.sec.key_id = data_ind[39 + msdulen];
	}

That makes a full indication 42 + msdulen bytes. With a 127-byte MSDU
(IEEE802154_MTU), the device reports len = 169. That is larger than
sizeof(struct mac_message), which is 150 according to the KASAN report
in the changelog. If I read this right, any received frame with more
than 108 bytes of payload is now discarded.

Each dropped frame also triggers a dev_crit() with no rate limiting.
Anyone in radio range can send long frames, so a remote peer could
flood the kernel log this way. Should this at least use
dev_crit_ratelimited() or dev_err_ratelimited()?

ca8210_spi_transfer() only clocks in sizeof(struct mac_message) bytes.
So before this patch, the tail of a long indication may already have
come from stale tx_in_buf contents.

Would it be better to keep the generic limit here, and check against
sizeof(struct mac_message) only before the memcpy() into
priv->sync_command_response? Or should the transfer length be sized to
cover the largest MCPS-DATA.indication? Either way, dropping long data
frames on stable kernels looks like a regression worth avoiding.

[Severity: High]
This is a pre-existing issue, but since this patch is about the memcpy()
into priv->sync_command_response, can the pointer itself go stale?

Later in ca8210_rx_done(), the pointer is checked and then written through.
No lock or barrier protects it:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
    ...
	if (buf[0] & SPI_SYN) {
		if (priv->sync_command_response) {
			memcpy(priv->sync_command_response, buf, len);
			complete(&priv->sync_exchange_complete);
    ...
}

ca8210_spi_exchange() stores a pointer to the caller's stack buffer. It
then waits with an interruptible timeout. On timeout or signal, it clears
the pointer and returns:

drivers/net/ieee802154/ca8210.c:ca8210_spi_exchange() {
    ...
		priv->sync_command_response = response;
    ...
	wait_remaining = wait_for_completion_interruptible_timeout(
		&priv->sync_exchange_complete,
		msecs_to_jiffies(CA8210_SYNC_TIMEOUT)
	);
    ...
cleanup:
	priv->sync_command_response = NULL;
	return status;
}

Suppose the device response arrives just as the waiter times out or gets a
signal. Could this interleaving happen?

CPU1 (SPI completion)
ca8210_spi_transfer_complete()
  ca8210_rx_done()
    if (priv->sync_command_response)   <- sees the caller's buffer

CPU2 (a sync caller such as mlme_reset_request_sync())
ca8210_spi_exchange()
  wait_for_completion_interruptible_timeout() returns 0 or -ERESTARTSYS
  priv->sync_command_response = NULL;
  returns, and the on-stack response buffer goes out of scope

CPU1
    memcpy(priv->sync_command_response, buf, len);

That would write up to sizeof(struct mac_message) bytes supplied by the
device into a stack frame that the caller no longer owns.

Also, ca8210_spi_exchange() callers are not serialized by any mutex. Can
two concurrent synchronous callers overwrite each other's
sync_command_response and sync_exchange_complete? If so, one caller's
reply could land in the other caller's buffer.

[Severity: High]
This isn't a bug introduced by this patch, but can ca8210_rx_done() sleep
in a context where sleeping is not allowed?

The only caller of ca8210_rx_done() is ca8210_spi_transfer_complete().
ca8210_spi_transfer() installs that function as the spi_async() completion
callback:

	cas_ctl->msg.complete = ca8210_spi_transfer_complete;
	...
	status = spi_async(spi, &cas_ctl->msg);

The spi_async() kernel-doc in drivers/spi/spi.c says:

 * The completion callback is invoked in a context which can't sleep.

When ca8210_rx_done() receives SPI_MCPS_DATA_CONFIRM with
IEEE802154_TRANSACTION_OVERFLOW, it does this:

		if (buf[3] == IEEE802154_TRANSACTION_OVERFLOW) {
			...
			msleep(2000);
			...
			mlme_reset_wpc = kmalloc_obj(*mlme_reset_wpc);

Some controllers finalize messages from IRQ or tasklet context. Would this
trigger "scheduling while atomic" there?

Other controllers finalize from the message pump kthread. There, it looks
like this would stall the SPI bus for two seconds.

[Severity: Low]
This is a pre-existing issue, but ca8210_spi_transfer_complete() dumps the
received buffer using the device's length byte without checking it. That
happens before ca8210_rx_done() reaches the new check:

	if (duplex_rx) {
		dev_dbg(&priv->spi->dev, "READ CMD DURING TX\n");
		for (i = 0; i < cas_ctl->tx_in_buf[1] + 2; i++)
			dev_dbg(
				&priv->spi->dev,
				"%#03x\n",
				cas_ctl->tx_in_buf[i]
			);
		ca8210_rx_done(cas_ctl);
	}

If tx_in_buf[1] == 0xff, does i reach 256 and read tx_in_buf[256]? That is
one byte past the end of the CA8210_SPI_BUF_SIZE array.

This only happens when the dev_dbg() call site is enabled. The loop also
prints bytes beyond the sizeof(struct mac_message) bytes that the transfer
actually received.

Should this loop be limited to sizeof(struct mac_message) as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071914.421586-1-benquike%40gmail.com
