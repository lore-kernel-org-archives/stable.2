Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224739CD11;
	Sun,  4 Oct 2026 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099572; cv=none; b=WJX6KLrr7PkELrK5OATeQlOaIyAJyOTQOv01n8Jt+BcbAkKjGeoG+L1+PYw3nbLK7hN3a+wq1r50wjEI8GBPOMurT2h5DVQNerCrmJ+8RDZxgFYbot8ZhkROJJGITo9a1zYpo8ZGDsgN8jvbXZ66S9kLiml9aRn7Er1CnJ6IDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099572; c=relaxed/simple;
	bh=gVYOp4RmhhHVlPqgKzJFM049Uck5BlbClVJ6IK8BiNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cv6sBGYxX/0TDUQu4btDQ8mzCMFjQANTdvzAoro/DCqm9TYrQosSiWV2F+JVI/3aKrz3Tq3DfN9xqJ/q2EO6UF3rBVrTzBZb27M0I4x8l8Ez0Lb78fmKBsW53KlzGGfh5YJHP42qubwH0OQhhTzp+rywGjxQUXjHKtRshIEcIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y67FxG4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y67FxG4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE641F00893;
	Sun,  4 Oct 2026 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099569;
	bh=P33t5zMpSQrUHCy6tHTxrwX4i5lkx0ERpcv0NVFH1s4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y67FxG4HgJaW/r5jC6YRfJfuE2/Na83jy79zV9iAxTBhZLCwUN0z9uM2qpzWFSp/f
	 ZJv2HlEWOxNn0e1JkHAPUst2OOgH+wzBZY2IlHbIFRQmewAIMjZ5FS7mREqbunxIun
	 vuSqC+fpyogmzi1VgmiodnuPoITXC6ii0wZPZ7Px15tHPOA3AkCt4ypobVQ1bqySq1
	 lilvHMqRTP8fvpQUl45lRySd2PrKFmfj6DBPVmHp5seeqFFKgIBRXrxqt0BUrc6Dp6
	 KWpwPLWKGN/N+AePLdR5e09c4ZXrOYdtx7rw7bte199G3K/LyeGkZG1v2Fnnumi94Y
	 q2MDkCD0xrOQQ==
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 04 Oct 2026 07:39:28 +0000
Message-ID: <179109956850.434549.7143809589105470854@kernel.org>
In-Reply-To: <20260930071914.421586-3-benquike@gmail.com>
References: <20260930071914.421586-3-benquike@gmail.com>
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

- [Low] The commit message overstates how reachable the bug is, and the
  stable backport is not justified.
- [Low] The patch changes the contract of hwme_get_request_sync(), but
  its kernel-doc was not updated.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sync
  response pointer can be written to after its stack buffer is gone…
- [Medium] This problem wasn't introduced by this patch, but
  hwme_get_request_sync() uses a stack 'struct mac_message response'…

--

ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()

This commit adds an upper-bound check to hwme_get_request_sync(). If a
HWME-GET confirm reports an hw_attribute_length larger than the
caller-supplied *hw_attribute_length, the function now returns
IEEE802154_SYSTEM_ERROR instead of copying past the end of the destination
buffer. It also sets lenvar to 1 in ca8210_get_ed(), so the size of the
1-byte level buffer is passed in.

> In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
> stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
> unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
> bytes into hw_attribute_value without checking the caller's destination
> buffer capacity, overflowing level on the stack when hw_attribute_length
> exceeds 1:

[ ... ]

> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org

[Severity: Low]
Can any in-tree code path reach this overflow?

ca8210_get_ed() is the only caller of hwme_get_request_sync(). The only
reference to ca8210_get_ed() is the ops table entry:

    .ed = ca8210_get_ed,

In net/mac802154, the only use of ops->ed seems to be the NULL check in
ieee802154_alloc_hw():

    if (WARN_ON(!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||

Energy detection scans are also rejected in two places.
nl802154_trigger_scan() accepts only NL802154_SCAN_ACTIVE and
NL802154_SCAN_PASSIVE, and mac802154_trigger_scan_locked() has:

    if (request->type != NL802154_SCAN_PASSIVE &&
        request->type != NL802154_SCAN_ACTIVE)
        return -EOPNOTSUPP;

The splat shows init/1 calling ca8210_get_ed() directly. Together with the
testing note quoted above, this looks like it came from a test harness
rather than a path that exists in the tree.

The code change itself looks correct. Could the commit message call this
hardening of a callback that has no in-tree caller today? And could the
Cc: stable tag either be dropped or be given a justification?

> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index a990a0f347ad8..8aa7ffeb22d78 100644
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
With this check, *hw_attribute_length is now read as the capacity of the
hw_attribute_value buffer, which makes it an in/out parameter. Should the
kernel-doc for hwme_get_request_sync() be updated as well? It still says:

 * @hw_attribute_length: Attribute length
 * @hw_attribute_value:  Pointer to Attribute Value

It doesn't say that callers must set the buffer size before the call. It
also doesn't mention that a successful confirm with a length that is too
large now returns IEEE802154_SYSTEM_ERROR.

A future caller that follows the kernel-doc could make the same
uninitialized lenvar mistake this patch fixes.

>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(

[Severity: Medium]
This is a pre-existing issue, but can a short HWME_GET_CONFIRM make this
function return success with stale data?

response is an uninitialized struct mac_message on the stack in
hwme_get_request_sync(). ca8210_rx_done() copies into it only the length
the device advertises:

    len = buf[1] + 2;
    ...
    memcpy(priv->sync_command_response, buf, len);

If the confirm is truncated, hw_attribute_length and hw_attribute_value[0]
still hold whatever was left on the stack.

A length of 0 passes the new check. Nothing is copied, and SUCCESS is
returned. ca8210_get_ed() then returns 0 without ever writing *level,
because it doesn't check lenvar after the call.

A length of 1 in a truncated frame would copy one uninitialized stack byte
into *level and still report success.

Would it make sense to:

- check that response.length covers the confirm fields and the claimed
  value,
- require lenvar == 1 in ca8210_get_ed(), and
- zero-initialize response?

As noted above, mac802154 doesn't currently call ops->ed.

> @@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   */
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	u8 lenvar;
> +	u8 lenvar = 1;
>  	struct ca8210_priv *priv = hw->priv;
>  
>  	return link_to_linux_err(

[Severity: High]
This is a pre-existing issue, but can ca8210_rx_done() write into the
response buffer in hwme_get_request_sync() after that function has
returned?

ca8210_spi_exchange() publishes the caller's stack buffer:

    priv->sync_command_response = response;

ca8210_rx_done(), which runs from the SPI completion path, then does:

    if (priv->sync_command_response) {
        memcpy(priv->sync_command_response, buf, len);
        complete(&priv->sync_exchange_complete);

It holds no lock and doesn't use READ_ONCE().

The wait on sync_exchange_complete can be interrupted by a signal
(-ERESTARTSYS) or can time out after CA8210_SYNC_TIMEOUT. In either case,
ca8210_spi_exchange() does:

cleanup:
    priv->sync_command_response = NULL;
    return status;

Nothing waits for an rx_done() that is already running:

CPU1                                  CPU2
ca8210_spi_exchange()                 ca8210_rx_done()
                                        if (priv->sync_command_response)
  wait interrupted or timed out
  priv->sync_command_response = NULL
  return
hwme_get_request_sync() returns
                                        memcpy(priv->sync_command_response,
                                               buf, len);

In that case the memcpy() writes up to sizeof(struct mac_message) bytes
into a stack frame that has already been unwound. If the compiler reloads
the pointer after it has been cleared, the result is a write through a NULL
pointer instead.

The same pattern applies to every *_request_sync() helper, for example
ca8210_set_channel()->mlme_set_request_sync(). Nothing in the driver locks
sync_command_response, and priv->lock is only used in the TX path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071914.421586-1-benquike%40gmail.com
