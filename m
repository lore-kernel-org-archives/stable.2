Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AA305698;
	Mon, 28 Sep 2026 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577750; cv=none; b=UHzoP2HR0atLT8KXcHm8tv2vPtrlJehjRmbLh3CMMr7lMYoMRaA0mdk/NK+/1zt9MpSOoK7xCQLIKjjJiMd+1AbPHA6eWyR0c5D+AZGG86rutU1a6e8mf/HVHfwGvr7x3Z/C0dbCmZWf7Ev2D6XXQ45hpHQanHBgAV43UC5wtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577750; c=relaxed/simple;
	bh=ebBeNbh1qd1uuT6dE4t8UDhbv0yLldqXdRL1Qi9pORw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GaSZ9702NmYJSw/Tc80wKwTVEDtloEwiaDX/4lqCplLJTZxkXS/hxbHviXfkh+sOzGyY32R5vfkqX/o//fdBEccdNrPB9hIKuQyMT+yv8WHuieQb62ZVHH+s8GfPpWPQi3OvpZL5eOEvNR58/OishG+jhUzc1mL/400zcDsbwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLcNatKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLcNatKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2761F000FF;
	Mon, 28 Sep 2026 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790577748;
	bh=PR+qD69Mmn3ee91G2H+UEY/KNwLNvbrpeNnSfIqIdhQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bLcNatKHq18iM5FnX0pSZ/JCGbahS6AtzehgZICIY6pemzoi/yOdFGNGSze2rNJPR
	 OuPk78U9ApvKrstJav2HUFDvplZZVPdiFgMVodcntLurCjBJmGXRgatQjQZhAGRYll
	 bCJxXmWoknGWdOyij5uLi1shhqHEA/MUwbZu7tDDbNr1Mk1aulaO/HYqqrodvD4AhM
	 19/W2c8hXPySX5F41LPCdUoDN+t4gTlXpN+N7zoTZ0IqkBfK2y+n70rxIeIIV8eq6f
	 OnVYhCpqzyoDOepOhLw4RoipvyFBQ2DfhnZ0oCyBGPLIx0xfaMkdpABoLozTPfUWrD
	 cTfYFy7y0rQOQ==
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 28 Sep 2026 06:42:27 +0000
Message-ID: <179057774769.3145.8753084259856546356@kernel.org>
In-Reply-To: <20260924062244.2444225-3-benquike@gmail.com>
References: <20260924062244.2444225-3-benquike@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message reads as if the stack overflow in
  ca8210_get_ed()/hwme_get_request_sync() can happen at runtime.
- [Low] The patch turns `hw_attribute_length` in hwme_get_request_sync()
  into an in/out parameter, but the kernel-doc was not updated.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a real
  memory-safety race in the same sync-exchange path.

--

ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()

This patch initializes lenvar to 1 in ca8210_get_ed(). It also makes
hwme_get_request_sync() return IEEE802154_SYSTEM_ERROR when the device
reports an hw_attribute_length larger than the caller's buffer. The goal
is to stop a stack overflow of the 1-byte level buffer in ca8210_get_ed().

> In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
> stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
> unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
> bytes into hw_attribute_value without checking the caller's destination
> buffer capacity, overflowing level on the stack when hw_attribute_length
> exceeds 1:
>
>   BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>   Write of size 16 at addr ffff888001907780 by task init/1

[ ... ]

> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org

[Severity: Low]
Can this overflow actually be reached at runtime? The commit message reads
as if it describes live stack corruption. It shows a splat from task init/1
and carries a stable tag.

hwme_get_request_sync() is static. Its only caller is ca8210_get_ed(), and
ca8210_get_ed() is only referenced as the .ed callback in ca8210_phy_ops:

	.ed = ca8210_get_ed,

As far as I can tell, mac802154 never calls ops->ed. The only reference is
the NULL check in ieee802154_alloc_hw():

net/mac802154/main.c:ieee802154_alloc_hw() {
	...
	if (WARN_ON(!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||
	...
}

nl802154_trigger_scan() also accepts only NL802154_SCAN_ACTIVE and
NL802154_SCAN_PASSIVE. So an energy-detection scan from userspace can't
get there either.

Even if there were a caller, the device would have to answer
HWME_GET(HWME_EDVALUE) with hw_attribute_length > 1.

Could the commit message say that the .ed op is not currently invoked, and
that a misbehaving CA8210 would be needed? That would help maintainers
choose between net and net-next, and decide whether a stable backport is
needed.

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index a990a0f347ad..8aa7ffeb22d7 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>  
>  	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;

[Severity: Low]
Should the kernel-doc for hwme_get_request_sync() be updated too?

*hw_attribute_length is now read as the size of hw_attribute_value, and
then overwritten with the copied length. That makes it an in/out
parameter. The comment still says:

 * @hw_attribute_length: Attribute length
 ...
 * Return: 802.15.4 status code of HWME-GET.confirm

Before this patch the argument was only written, which is why
ca8210_get_ed() could pass an uninitialized lenvar. A future caller that
follows the kernel-doc and does the same would compare against a random
value, and the overflow would come back.

The only caller meets the new requirement with a bare "u8 lenvar = 1;".
Nothing ties that 1 to sizeof(*level).

The Return: text is now also wrong in one more case. This
IEEE802154_SYSTEM_ERROR comes from the driver, not from the device's
confirm, and link_to_linux_err() maps it to -EPROTO. Two older
SYSTEM_ERROR returns had already made that text inaccurate.

>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(

[Severity: High]
This isn't a bug introduced by this patch, but there seems to be a race in
the sync exchange path that this length check can't protect against.

priv->sync_command_response is per-device state shared by all sync
callers, and no lock covers it. ca8210_spi_exchange() publishes the
caller's stack buffer, waits interruptibly with a timeout, and then clears
the pointer:

drivers/net/ieee802154/ca8210.c:ca8210_spi_exchange() {
	...
	if ((buf[0] & SPI_SYN) && response) { /* if sync wait for confirm */
		reinit_completion(&priv->sync_exchange_complete);
		priv->sync_command_response = response;
	}
	...
cleanup:
	priv->sync_command_response = NULL;
	return status;
}

ca8210_rx_done() runs from the SPI completion callback
ca8210_spi_transfer_complete(). It tests the pointer and then copies into
it, with no lock:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
	...
	if (buf[0] & SPI_SYN) {
		if (priv->sync_command_response) {
			memcpy(priv->sync_command_response, buf, len);
			complete(&priv->sync_exchange_complete);
	...
}

Suppose the waiter gets -ERESTARTSYS or -ETIME after ca8210_rx_done() has
loaded the non-NULL pointer but before the memcpy. Can that memcpy then
write into the stack frame of a caller that has already returned from
hwme_get_request_sync()?

Sync exchanges also don't appear to be serialized.
ca8210_mlme_reset_worker() calls mlme_reset_request_sync() from a
workqueue without rtnl, and ca8210_rx_done() queues it on
TRANSACTION_OVERFLOW. It can run at the same time as rtnl-held
ieee802154_ops callbacks such as set_channel or set_txpower, which also
use the *_request_sync() helpers.

Could two callers overwrite each other's response pointer, or consume each
other's completion? One caller would get the other command's confirm. The
other would either time out or return with its response buffer untouched,
because hwme_get_request_sync() doesn't preset command_id.

Would it make sense to serialize sync exchanges with a mutex? The handoff
of the response buffer would also need to be synchronized against
ca8210_rx_done(). Ideally, the confirm ID would also be checked against
the request that was issued.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924062244.2444225-1-benquike%40gmail.com
