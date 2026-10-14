Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E01F3B85;
	Wed, 14 Oct 2026 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943161; cv=none; b=PRdz8Glvd5HmRBQvhT2QiHTzL7ueEaCczPahiX41vHmmCgV2UN+U8QEpqCgb7Cu+tQ4FoiRTQzUMCTiY3yDoJtseINu3XKIbhlGDbPiInnZpxI7UmW7LWy4LJ/TT7IQNNM6/BWRUepDAjTQHOEkwDe96tIrTGBktW8GQhY7SDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943161; c=relaxed/simple;
	bh=yp44U3CTZ5DsK3GUM+LruQNdIDVedDrXoM0mpjSozXs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezpA7Wuy/mfeITgTBgX/5FSUYtshENBixB3VHH9NRIJ4fPhMViMO+L9PngXF/S/fft8SVeUbWVyh58Ykk1vTGIKU8kxN6QdUb7VhgdiJF1Rlm2vfA5TJLI7lkdNq37QZBLhqe87Qcw19iuNOsx47N20m5BzSBsWZMmKevLxhDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6UcFYmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6UcFYmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722F21F000FF;
	Wed, 14 Oct 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791943160;
	bh=kawrkzhFyj9yV3XlykGBmt/LBNk1s9fbUDf5Qjez1pY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y6UcFYmdpqYwYSSRtNG+xfeScFwh/UDGZROvC8G28l/WPGdqjFiwXsxfDSg/arcoI
	 hcUEYYKZydK8C6oTiPZXkto919qEYKD0r0ZJFFjc+zOXWUZm62qilB7NpzR6MyQ/sc
	 TZ6njX0HhJDmZK3g2VkRxSAEzmSfWgOoXAP08hfCbw/jssJA6Q5PVyBBtG4jyl7fNo
	 MXnAGGtWGmw/tcxVcxKhophhooiXfzqoEv95/cds52r90k7Py/fBl7sXIsHSacLW0Z
	 3bxCBGqvW5ua3UuLXERYgbRT84FOTmetQed133DiXCz42ufgOM87FrdB7W+tlxBkqj
	 J3zqljMP8C6XQ==
Subject:
 Re: [PATCH net v2] igc: only strip RX timestamp header from first buffer
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 maciej.fijalkowski@intel.com, avigailx.dahan@intel.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 01:59:18 +0000
Message-ID: <179194315897.434549.3743742848544230715@kernel.org>
In-Reply-To: <20261013010854.4068874-1-p@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the TSIP length underflow only in
  igc_clean_rx_irq().
- [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
  igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean…

--

igc: only strip RX timestamp header from first buffer

This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
header is only stripped when no skb is in progress. Before, a continuation
buffer shorter than 16 bytes could underflow the unsigned length and
produce a skb fragment of almost 4 GiB.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..41b293dc10c3a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {

[Severity: High]
Is !skb a reliable first-buffer test when an XDP program is attached?

Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No skb
gets built, and the loop moves on with skb still NULL:

		/* fetch next buffer in frame if non-eop */
		if (igc_is_non_eop(rx_ring, rx_desc))
			continue;

On the next continuation descriptor, !skb is still true, so the TSIP branch
subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
bytes, size wraps.

The wrapped size then goes to xdp_prepare_buff(), and the continuation is
run through XDP as a new frame with data_end before data. On XDP_PASS, both
igc_build_skb() and igc_construct_skb() compute:

	unsigned int size = xdp->data_end - xdp->data;

That comes out to about 4 GiB:

- igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >= 8192,
  igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
  napi_build_skb() would place skb_shared_info inside the packet data.
- igc_construct_skb() turns it into a fragment of almost 4 GiB. That looks
  like the same corrupted skb the commit message describes.

Can this be reached from the wire? On PAGE_SIZE >= 8192, igc_set_rx_mode()
never clamps RLPML:

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
		rlpml = IGC_MAX_FRAME_BUILD_SKB;
#endif
	wr32(IGC_RLPML, rlpml);

So the hardware still accepts jumbo frames even though XDP limits the MTU to
1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
leaves 1 to 15 bytes in the second descriptor would hit this.

Would it be safer to track start-of-frame explicitly, or to drop the rest of
the frame's descriptors after a non-PASS verdict? Another option is to
reject size < IGC_TS_HDR_LEN before the subtraction.

>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;

[Severity: High]
The same unchecked subtraction is still present in the AF_XDP zero-copy
path. igc_clean_rx_irq_zc() strips the header from every descriptor with
TSIP set. There is no first-buffer gate and no size check:

		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
			ctx->rx_ts = bi->xdp->data;

			bi->xdp->data += IGC_TS_HDR_LEN;
			...
			size -= IGC_TS_HDR_LEN;
		} else {
			ctx->rx_ts = NULL;
		}

		bi->xdp->data_end = bi->xdp->data + size;

Can zero-copy frames span descriptors at MTU 1500?
igc_configure_rx_ring() programs the XSK frame size through
IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the frame
size is 1792, so the hardware buffer becomes 1 KB.

igc_xdp_enable_pool() only checks:

	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {

That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
inline timestamp, even though the comment there says frames should not
span multiple buffers.

On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes in
a second descriptor.

The reproduction in the commit message suggests TSIP is set on such
continuation descriptors. If so, size wraps here and data_end ends up about
4 GiB past the XSK chunk.

Wouldn't that let the XDP program's packet bounds checks pass for offsets
past the chunk? On XDP_REDIRECT, it would also report a bogus length to the
XSK socket.

Should igc_clean_rx_irq_zc() get a similar fix? Should
igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and the
inline timestamp?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013010854.4068874-1-p%401g4.org
