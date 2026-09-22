Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6864399D0;
	Tue, 22 Sep 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065950; cv=none; b=ss4fIiyF0rkbmRxjUByDJrMyndUXUi/+LhFqMb9DjRG1Vbt6xmzyEvRtF1A5NxsCWHirwebrp6bTUJomrow3N2Fs5/RMPLeTj8W320FoYHVbyPB+7rHXnCULuRN/KMU64wWAaq6BXd9aebOyhgh07HTzYQPJwWNjQwv4hXCx5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065950; c=relaxed/simple;
	bh=Vv6fPgCUZj/soRazk9ebt3+wPAoAtsHUWWOxCZBUoAw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFuj0wD5WUNTE65XnuvO+KwnIXqHr4Z5eB3Cc9CwcWk6N2lcxuW4+v8txVxlNr2s4c7N2TEnLGPVEIHsmJBnEp6u2fbn1OHuzdCY6qi+OvB6zDsZtQayLEdTRLfAWdLhGlHIMkMs0GxceKl2jw8Oly9uMzpRVZ/haTAltRKpa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8gLeeo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8gLeeo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAFA1F00893;
	Tue, 22 Sep 2026 08:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065947;
	bh=fAIA8Q2J3svLfWDXTx4EauJ5wfM4s9L5MuIAOMddNks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k8gLeeo0tHm73NzfON2KVkA9/T2cX1q+yv80RtP0lyFfICYiF5ewdnE6t2tuwIzRl
	 9nPkq0FMMz7Ab0D9Ev7MaZE/+H8bWGYmgFzjv3xATygZDMstQBmc7D7ZBOc6bPPun/
	 ivpfGo40M/ejsE1oa0nAXFivV33C8fXnrV5vY0vrw4eUgkqw9XDwj2w0cfzFbsh5BF
	 zbR8H1zlRuzTHvuCCURq3IZ/odmTbmQrcb6mQIRtleSACXo/SyZD8mB9e1gGtHvEgp
	 yDSo/gGViQG5nUGnjMP4dZg6OTFGora4Sna+1xHfV63ZXhd1eErz/bSYLua0qW/hbw
	 0JE6eBGrHxXFw==
Subject: Re: [PATCH net v2 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 22 Sep 2026 08:32:26 +0000
Message-ID: <179006594674.2160803.16794276288943461505@kernel.org>
In-Reply-To: <20260921074205.2289211-2-benquike@gmail.com>
References: <20260921074205.2289211-2-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message presents the KASAN stack-out-of-bounds
  splat as a live, device-triggerable overflow (Fixes: + Cc: stable,…
- [Medium] The new bound check in hwme_get_request_sync()
  (drivers/net/ieee802154/ca8210.c:1681-1683) is one-sided: it only…
- [Medium] hwme_get_request_sync() still declares `struct mac_message
  command, response;` with no initialiser (ca8210.c:1663) and then makes…
- [Low] The patch converts `hw_attribute_length` of
  `hwme_get_request_sync()` into an in/out parameter — the caller must…

--

ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()

This adds an upper-bound check in hwme_get_request_sync() so that a
HWME-GET.confirm reporting a hw_attribute_length larger than the caller's
destination buffer is rejected with IEEE802154_SYSTEM_ERROR, and
initialises lenvar = 1 in ca8210_get_ed() so the helper knows the
capacity of the one-byte level buffer.

A few questions about the change and the changelog below.

>     In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
>     stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
>     unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
>     bytes into hw_attribute_value without checking the caller's destination
>     buffer capacity, overflowing level on the stack when hw_attribute_length
>     exceeds 1:
>
>       BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>       Write of size 16 at addr ffff888001907780 by task init/1
>       Call Trace:
>        <TASK>
>        dump_stack_lvl+0x70/0xa0
>        print_report+0x153/0x4c6
>        kasan_report+0xf1/0x120
>        kasan_check_range+0x125/0x200
>        __asan_memcpy+0x3c/0x60
>        hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>        ca8210_get_ed+0x9c/0xf0
>       ...
> [ ... ]
>     Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
>     Cc: stable@vger.kernel.org

[Severity: Medium]
Is this splat reachable from anything in tree today?

ca8210_get_ed() is only installed as the .ed member of ca8210_phy_ops, and
the only reference to that member in the 802.15.4 stack is the presence
check in ieee802154_alloc_hw():

net/mac802154/main.c:ieee802154_alloc_hw() {
	if (WARN_ON(!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||
		    !ops->start || !ops->stop || !ops->set_channel))
		return NULL;
}

There is no drv_* wrapper, cfg802154 op or netlink path that actually calls
ops->ed, and ca8210_get_ed() is the single caller of
hwme_get_request_sync(). The changelog itself notes the trace came from
passing "an oversized hw_attribute_length response into ca8210_get_ed()"
in QEMU.

Could the changelog say that the path is currently only reachable through
the never-invoked .ed callback? With a Fixes: tag, a Cc: stable and a call
trace that is truncated right above ca8210_get_ed(), a stable backporter
would reasonably conclude that shipping kernels have a device-reachable
stack overflow here.

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index c009930da77a..1de63142a45a 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1678,6 +1678,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>  
>  	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;
>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(

[Severity: Medium]
Should this check also reject a shorter-than-expected length?

The test only covers lengths larger than the caller's capacity. A confirm
with status == IEEE802154_SUCCESS and hw_attribute_length == 0 still takes
the success path: *hw_attribute_length becomes 0, the memcpy copies
nothing, and IEEE802154_SUCCESS is returned.

ca8210_get_ed() discards lenvar, so link_to_linux_err(IEEE802154_SUCCESS)
returns 0:

drivers/net/ieee802154/ca8210.c:ca8210_get_ed() {
	u8 lenvar = 1;
	struct ca8210_priv *priv = hw->priv;

	return link_to_linux_err(
		hwme_get_request_sync(HWME_EDVALUE, &lenvar, level, priv->spi)
	);
}

Does that report a successful energy-detect read while *level still holds
the caller's uninitialised stack byte, contrary to the ieee802154_ops::ed
contract in include/net/mac802154.h that a 0 return means level was filled
in?

HWME attribute sizes are fixed and known to the caller, so would an exact
length comparison (!= against the caller-supplied expected length) cover
both directions of the mismatch in one check?

[Severity: Medium]
Can this check be made on never-written stack memory?

hwme_get_request_sync() declares its response with no initialiser:

	struct mac_message command, response;

The only writer of that memory is ca8210_rx_done(), which copies exactly as
many bytes as the device claims:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
	buf = cas_ctl->tx_in_buf;
	len = buf[1] + 2;
	...
	if (buf[0] & SPI_SYN) {
		if (priv->sync_command_response) {
			memcpy(priv->sync_command_response, buf,
			       min_t(size_t, len, sizeof(struct mac_message)));
}

SPI_HWME_GET_CONFIRM is HWME_GET_CONFIRM + SPI_S2M + SPI_SYN, so a frame
with buf[0] = 0x73 and buf[1] = 0 passes the

	if (response.command_id != SPI_HWME_GET_CONFIRM)

gate while leaving .status, .hw_attribute_length and .hw_attribute_value[]
as stack garbage.

If the garbage status happens to be 0 and the garbage length happens to be
0 or 1, does this copy up to one byte of uninitialised kernel stack into
the caller's *level and return success? And for other garbage status values,
does link_to_linux_err() map them to an arbitrary errno?

Would zeroing response, or validating response.length against the size of
struct hwme_get_confirm_pset, close this along with the out-of-bounds write
the patch targets?

> @@ -2028,7 +2031,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   */
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	u8 lenvar;
> +	u8 lenvar = 1;
>  	struct ca8210_priv *priv = hw->priv;
>  
>  	return link_to_linux_err(

[Severity: Low]
This isn't a bug, but the kernel-doc above hwme_get_request_sync() no
longer matches the new calling convention:

 * @hw_attribute_length: Attribute length
 * @hw_attribute_value:  Pointer to Attribute Value
 * @device_ref:          Nondescript pointer to target device
 *
 * Return: 802.15.4 status code of HWME-GET.confirm

hw_attribute_length is now an in/out parameter that the caller must
pre-initialise with the capacity of hw_attribute_value, which is what makes
lenvar = 1 load-bearing here, and the function can now return
IEEE802154_SYSTEM_ERROR for a purely local capacity rejection rather than a
device confirm status (which link_to_linux_err() turns into -EPROTO).

Could the kernel-doc be updated to state both, so a future caller reading
only the documented interface does not pass an uninitialised or zero length
and reintroduce the overflow or the silent truncation?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921074205.2289211-1-benquike%40gmail.com
