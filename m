Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C240B0FE;
	Thu, 24 Sep 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232131; cv=none; b=LS6SVelvKs+jDc7JoZqHO4gv8cOjPWmuspe7Lm9svH9R8y/V2yseYEpZk7nyZmvNHQC+fEJ2AW+vvOVH2ouFbsxV+bQHjJe8NnEWRJtQjGr5HlPaGalr/3IAu2t8lvYQO5/pVlH73JybxWE0ih7xPcMr45tfwWDbOeVBVs7f60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232131; c=relaxed/simple;
	bh=meTevEAx63VoU8Z84Anl84+Dyomtfyb3OaTgc/fluOs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCmXN+8mhMUv2mKJUIBsQHVnMY4PQ/31gkSIhGmPoFgqhEUA7fVD0DtzLbzn25ztblCuPpxfbwpmSey2MJ8cOWYqNfZle5uCGSk+D3DUpenGw1pFhmC9B2CDZWoALtbSqbS/UzADGV7DQQP47ZK08VHJp3omkj99BpvomSAi0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6MsxWCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6MsxWCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026731F000FF;
	Thu, 24 Sep 2026 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232126;
	bh=Hf2kO5YOY3KalHQaeAkcW4ZtTxm5AaXHNpVzUFmNyIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f6MsxWCMyau3S24kpHf0zSYuaTnV/WC0OVIh2Krm1amSYJIl0NBCSSiilZRN8vUTH
	 HTXK+NRi/mtCUvowFUZ+Dz8k51EgsPIeD/kCa3lu48xqJRzoHwILoCkZbwSZzra84m
	 r8CgF3j0rzASKyTpCfeljVjFDZViZ+Ea1C057A/vB1lTBQWUqwSTUDRDvsPj4q5+HB
	 vizMc8AFEEIoDgF8wiNRZI2a3AjpJ7jI0wmY23K9nmDgGKAwlPP6UTc0RsHUZHz0jX
	 lHpz2yJ4Y3e5LPzSOewGk3zt0EsQvo7PP7S1XqiVRj41Mv2ffACbvW8VV4Dz/7tYII
	 tAfhgRNez1JKw==
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, david.laight.linux@gmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 24 Sep 2026 06:42:05 +0000
Message-ID: <179023212547.2160803.17631623699458578311@kernel.org>
In-Reply-To: <20260922093126.141969-3-benquike@gmail.com>
References: <20260922093126.141969-3-benquike@gmail.com>
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

- [Low] hwme_get_request_sync() (drivers/net/ieee802154/ca8210.c:1655) is
  changed so that *hw_attribute_length becomes a mandatory *input*: line…

Pre-existing issues:
- [Medium] hwme_get_request_sync() validates the device-reported
  hw_attribute_length only from above; it never checks that the confirm…

--

ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()

The patch turns the hw_attribute_length argument of
hwme_get_request_sync() into an in/out parameter: the caller-supplied
value is now used as the capacity of the destination buffer, and an
over-long HWME-GET.confirm is rejected with IEEE802154_SYSTEM_ERROR.
The single caller ca8210_get_ed() initialises lenvar to 1 to match the
one-byte level buffer.

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
This isn't a bug, but should the kernel-doc above hwme_get_request_sync()
be updated to describe the new contract?  The block still reads:

  /**
   * hwme_get_request_sync() - HWME_GET_request/confirm according to API Spec
   * @hw_attribute:        Attribute Number
   * @hw_attribute_length: Attribute length
   * @hw_attribute_value:  Pointer to Attribute Value
   * @device_ref:          Nondescript pointer to target device
   *
   * Return: 802.15.4 status code of HWME-GET.confirm
   */

The @hw_attribute_length wording is word for word the same as the one used
for hwme_set_request_sync(), where the parameter really is a plain input
value, and the Return: line no longer covers the new
IEEE802154_SYSTEM_ERROR case for an over-long reply.

A second call site that follows the current wording and passes the expected
attribute length (or leaves the variable uninitialised, as ca8210_get_ed()
did before this patch) would either reintroduce the overflow being fixed
here or make every valid reply fail.  Would it help to document that the
caller must pass sizeof(destination buffer) on entry and receives the number
of bytes written on return?

>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but since the
new check sits exactly where a length test belongs: should there also be a
lower-bound or consistency check here?

Only over-long lengths are rejected, so a confirm with
status == IEEE802154_SUCCESS and hw_attribute_length == 0 passes, copies
zero bytes and returns IEEE802154_SUCCESS:

drivers/net/ieee802154/ca8210.c:ca8210_get_ed() {
	u8 lenvar = 1;
	...
	return link_to_linux_err(
		hwme_get_request_sync(HWME_EDVALUE, &lenvar, level, priv->spi)
	);
}

The returned lenvar is ignored, so ca8210_get_ed() reports 0 while *level
was never written, although struct ieee802154_ops.ed in
include/net/mac802154.h expects the callback to store the measured energy.

There is a related case for a short confirm.  'struct mac_message response'
in hwme_get_request_sync() is an uninitialised stack object, and
ca8210_rx_done() only enforces an upper bound before copying:

drivers/net/ieee802154/ca8210.c:ca8210_rx_done() {
	buf = cas_ctl->tx_in_buf;
	len = buf[1] + 2;
	if (len > sizeof(struct mac_message)) {
		...
		goto finish;
	}

	if (buf[0] & SPI_SYN) {
		if (priv->sync_command_response) {
			memcpy(priv->sync_command_response, buf, len);
	...
}

If the device answers SPI_HWME_GET_CONFIRM with a length byte that stops
before the attribute bytes, response.pdata.hwme_get_cnf.hw_attribute_length
and hw_attribute_value keep whatever was on the stack.  When that stale
length happens to be 0 or 1 the new check passes, and a stale stack byte is
copied into *level while success is returned.  Would an exact length test
for the fixed-width HWME_EDVALUE attribute, plus a check that the confirmed
attribute length fits within response.length, close both cases?

In the current tree neither variant is reachable from userspace, since ->ed
has no in-tree caller (net/mac802154/main.c only checks for its presence
with a WARN_ON, and ED scans are refused in net/mac802154/scan.c).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922093126.141969-1-benquike%40gmail.com
