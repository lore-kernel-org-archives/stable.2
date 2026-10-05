Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8341443A;
	Mon,  5 Oct 2026 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241365; cv=none; b=NHML1pk9fotUB4BS3nOr0h1ThiMQG0lgfkO3wAvD8ba8N8t3UX4XfFwdyvNoKnAR1zNaeslBY73kPafaHB2bzo/hg19Q+traNSDcyJiPq+ZcvtY99+wOyqXFxeGLfu2X8PPh2n3xiXsjaGQrladMghkEFY1WbqwypE8N0BDUqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241365; c=relaxed/simple;
	bh=S7161uxvopcopansKei+alyqVpXa/8us9gp3IxXcnvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVmz1b+dGIMGgkqMxn/EmBG1E+luh0kyJDnM+bU05vmgiJ6Cgr4jpVXHwJ1PCWnHaKPVnttVUH2uSHcO4qKtS5jX4KKxJj4M7peTlRQvBoO5jyVZtSkBPci6X/jFUwlEp2S7YK3nVAiBV+6V28a51e0Nj+xtSym49+e+in/DiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii8Lfm9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii8Lfm9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1401F00893;
	Mon,  5 Oct 2026 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241364;
	bh=x4ouE7WLUkTarQ2ORxDDHiTQ5NVmMhb23Iw2rbl/8V8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ii8Lfm9XvHil7lbtusWCM5TXUEpg9G5Xg5RAe7hl19Lr5zx4fpd52K0YaAFpDtNBD
	 9Bz4+yvnTQOIKjeQ8gGBfYJHZTEeQnpIlmJI/ITO1jucgMx8TMziduVGqzXeTHHap/
	 pnoD3qWWVl84Lm/z4S+Iq5ujcOSsoLu0mHi8czlGDdAGkuwUFjyFIVDjNxSICCs6v+
	 PW3AQA9e+WqzJA9zgKVkbafRcbW1QQgF8IiJLkipW7zVDfE3y6qUmgRztyMq0SxprX
	 cdX9Rv5djyjFk5TkgD1vQU4ivOvIA866cQ9eI0ET5YfR10T3KjMMCSB/OmvZm69rkg
	 vamlbFXagfkaA==
Subject:
 Re: [PATCH net 2/6] igc: only strip RX timestamp header from first buffer
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com,
 dima.ruinskiy@intel.com, raanan.avargil@intel.com, gil.fine@intel.com,
 stable@vger.kernel.org, javier.herrera@afronta.com,
 aleksandr.loktionov@intel.com
Date: Mon, 05 Oct 2026 23:02:42 +0000
Message-ID: <179124136251.434549.964852326814446468@kernel.org>
In-Reply-To: <20261001222443.3500206-3-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-3-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In igc_clean_rx_irq()
  (drivers/net/ethernet/intel/igc/igc_main.c), the new `!skb && TSIP`…

--

igc: only strip RX timestamp header from first buffer

This commit changes igc_clean_rx_irq() so that the inline RX timestamp
header is consumed only when skb is NULL. The commit treats skb == NULL as
the marker for the first buffer of a packet. As a result, continuation
descriptors that still report TSIP no longer have IGC_TS_HDR_LEN
subtracted from their size.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 95f7747b347b1..b94a08791102c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2658,7 +2658,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;

[Severity: High]
Is skb == NULL a reliable first-buffer test when an XDP program is
attached?

Suppose the XDP program returns a non-PASS verdict (DROP/ABORTED, TX or
REDIRECT) for the first buffer of a frame that spans several descriptors.
In that case igc_clean_rx_irq() never builds an skb:

	if (xdp_res) {
		switch (xdp_res) {
		case IGC_XDP_CONSUMED:
			rx_buffer->pagecnt_bias++;
			break;
		...
	}
	...
	/* fetch next buffer in frame if non-eop */
	if (igc_is_non_eop(rx_ring, rx_desc))
		continue;

skb stays NULL, so the next descriptor is handled as if it started a new
frame. The commit message says continuation descriptors keep TSIP, so
that descriptor passes the new !skb && TSIP check as well. Then:

  - ctx.rx_ts points at payload data
  - 16 bytes of payload are skipped
  - the XDP program runs again on data from the middle of the frame

The igc_fpe_handle_mpacket() continue path can also leave skb NULL across
a non-EOP descriptor.

What happens if the last fragment holds fewer than IGC_TS_HDR_LEN bytes?
Can size -= IGC_TS_HDR_LEN wrap there?

xdp_prepare_buff() takes data_len as an int, so data_end would end up
before data. On XDP_PASS, igc_build_skb() then does:

	unsigned int size = xdp->data_end - xdp->data;
	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
	...
	__skb_put(skb, size);
	...
	igc_rx_buffer_flip(rx_buffer, truesize);

This would produce an skb with len around 4G and tail past end. The rx
page would also be flipped by a wrong truesize, so the hardware could DMA
into memory that the skb still owns.

Even without the wrap, wouldn't the mid-frame payload reach the stack as
its own frame after the real frame was dropped?

These multi-descriptor frames look reachable with XDP attached when
PAGE_SIZE >= 8192. igc_set_rx_mode() caps RLPML only for small pages:

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
		rlpml = IGC_MAX_FRAME_BUILD_SKB;
#endif
	wr32(IGC_RLPML, rlpml);

So RLPML stays at MAX_JUMBO_FRAME_SIZE on those systems. At the same time:

  - igc_configure_rx_ring() uses IGC_RXBUFFER_3072 buffers when XDP is
    enabled
  - igc_xdp_set_prog() checks only dev->mtu > ETH_DATA_LEN, not the frame
    size the hardware accepts

With RX timestamping enabled, a remote peer sending a frame larger than
3056 bytes would take this path.

Could the frame-start state be tracked separately from skb? One option is
to discard descriptors through EOP after a non-PASS verdict. Another is to
cap RLPML whenever XDP is enabled.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001222443.3500206-1-anthony.l.nguyen%40intel.com
