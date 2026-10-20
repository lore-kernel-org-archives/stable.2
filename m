Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516045;
	b=D73ls/lFI+X3NXRiQ8IB8fulGXkR+rCxFhYrCSez7ov+P6NYUCparPLReuP2/IhmNw3G
	 7hOxDZgavJbnUmPAWTJMXOb4QmjJwHpB4vgwIcDavJ33p2aPRHsV6/6qd1ld6AglyIld0
	 BnpYUVcrc14ubYyb8N8ZLchmgq6MgG1UpvpXdzVxK47tPVAIZQnxqpLlyn3XOCquGlJF0
	 IQwAbhM3SA+q1QRUohWcDhK4hPf4UjBxJ7nad832DbyRv0enhdwZZ97gRUaJ9RT78ZDh9
	 37aPlBisRXfoLXtWIUZ7957kc0L7G6L/46r0wc2aUe2QGnd+cT599gFl/ISNBm76agA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516045;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=9/l68fSQm/RuZObxkeWmD9P0V6B9tkMkoAUEJkdJXq0=;
	b=OePukrZABgwSLc87tuTC+gaTYhNRepVkOyG6WeE7jMvyMBVPAxcEic9eGcBF3CUJ9huG
	 urwlHvfiahj2sL9Nw2lgTfOUnCsm2gN+X/fEhdG1Bm8BMF24YLdbqXwVkaHWRu+S3UyjK
	 J84MNA1ptkplIvivxmhvYsnHio1ayGZGK0CDQQNGqyD2qDGcyoc9CXqbfsRED1TFmmqgx
	 2qe/2ez03xo8CHjq/OtG1eqgARjbXYTpb1YGx85VZUPbMOU6yEL8vO1XdzzIbh+b/pbLF
	 0eCTX/g5AQ5TlnMt4ioqjpek5q3Ig2jTpfOaod37XsqdV2nreKwc4xL7DnV3sHBABwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A7606A31A;
	Tue, 20 Oct 2026 17:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B891F000C9;
	Tue, 20 Oct 2026 17:07:22 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:06:49 +0100
From: Simon Horman <horms@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	aleksandr.loktionov@intel.com, maciej.fijalkowski@intel.com,
	avigailx.dahan@intel.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <20261020170649.GQ503057@horms.kernel.org>
References: <20261013010854.4068874-1-p@1g4.org>
 <179194315897.434549.3743742848544230715@kernel.org>
 <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>

On Wed, Oct 14, 2026 at 05:43:10AM +0000, Paul Moses wrote:
> On Tuesday, October 13th, 2026 at 8:59 PM, netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 2 · Medium: 0 · Low: 0
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [High] The patch fixes the TSIP length underflow only in
> >   igc_clean_rx_irq().
> > - [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
> >   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean…
> > 
> > --
> > 
> > igc: only strip RX timestamp header from first buffer
> > 
> > This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
> > header is only stripped when no skb is in progress. Before, a continuation
> > buffer shorter than 16 bytes could underflow the unsigned length and
> > produce a skb fragment of almost 4 GiB.
> > 
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > >
> > >  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> > >
> > > -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > +		if (!skb &&
> > > +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > 
> > [Severity: High]
> > Is !skb a reliable first-buffer test when an XDP program is attached?
> > 
> > Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
> > REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No skb
> > gets built, and the loop moves on with skb still NULL:
> > 
> > 		/* fetch next buffer in frame if non-eop */
> > 		if (igc_is_non_eop(rx_ring, rx_desc))
> > 			continue;
> > 
> > On the next continuation descriptor, !skb is still true, so the TSIP branch
> > subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
> > bytes, size wraps.
> > 
> > The wrapped size then goes to xdp_prepare_buff(), and the continuation is
> > run through XDP as a new frame with data_end before data. On XDP_PASS, both
> > igc_build_skb() and igc_construct_skb() compute:
> > 
> > 	unsigned int size = xdp->data_end - xdp->data;
> > 
> > That comes out to about 4 GiB:
> > 
> > - igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >= 8192,
> >   igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
> >   napi_build_skb() would place skb_shared_info inside the packet data.
> > - igc_construct_skb() turns it into a fragment of almost 4 GiB. That looks
> >   like the same corrupted skb the commit message describes.
> > 
> > Can this be reached from the wire? On PAGE_SIZE >= 8192, igc_set_rx_mode()
> > never clamps RLPML:
> > 
> > #if (PAGE_SIZE < 8192)
> > 	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
> > 		rlpml = IGC_MAX_FRAME_BUILD_SKB;
> > #endif
> > 	wr32(IGC_RLPML, rlpml);
> > 
> > So the hardware still accepts jumbo frames even though XDP limits the MTU to
> > 1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
> > leaves 1 to 15 bytes in the second descriptor would hit this.
> > 
> > Would it be safer to track start-of-frame explicitly, or to drop the rest of
> > the frame's descriptors after a non-PASS verdict? Another option is to
> > reject size < IGC_TS_HDR_LEN before the subtraction.
> > 
> > >  			ctx.rx_ts = pktbuf;
> > >  			pkt_offset = IGC_TS_HDR_LEN;
> > >  			size -= IGC_TS_HDR_LEN;
> > 
> > [Severity: High]
> > The same unchecked subtraction is still present in the AF_XDP zero-copy
> > path. igc_clean_rx_irq_zc() strips the header from every descriptor with
> > TSIP set. There is no first-buffer gate and no size check:
> > 
> > 		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> > 			ctx->rx_ts = bi->xdp->data;
> > 
> > 			bi->xdp->data += IGC_TS_HDR_LEN;
> > 			...
> > 			size -= IGC_TS_HDR_LEN;
> > 		} else {
> > 			ctx->rx_ts = NULL;
> > 		}
> > 
> > 		bi->xdp->data_end = bi->xdp->data + size;
> > 
> > Can zero-copy frames span descriptors at MTU 1500?
> > igc_configure_rx_ring() programs the XSK frame size through
> > IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the frame
> > size is 1792, so the hardware buffer becomes 1 KB.
> > 
> > igc_xdp_enable_pool() only checks:
> > 
> > 	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> > 
> > That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
> > inline timestamp, even though the comment there says frames should not
> > span multiple buffers.
> > 
> > On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
> > 1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes in
> > a second descriptor.
> > 
> > The reproduction in the commit message suggests TSIP is set on such
> > continuation descriptors. If so, size wraps here and data_end ends up about
> > 4 GiB past the XSK chunk.
> > 
> > Wouldn't that let the XDP program's packet bounds checks pass for offsets
> > past the chunk? On XDP_REDIRECT, it would also report a bogus length to the
> > XSK socket.
> > 
> > Should igc_clean_rx_irq_zc() get a similar fix? Should
> > igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and the
> > inline timestamp?
> > 
> > --
> > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013010854.4068874-1-p%401g4.org
> > 
> 
> Yes, there's work needed elsewhere, but it's entirely independent of my fix. It's 
> questionable how much of this is even reachable and if any impact whatsoever. 
> 
> Here's what I can reproduce with and without kasan and what my patch fixes. You are on your 
> own on the rest.
> 
> I'm sorry, if only there were more time...
> 
> Good luck.

Hi Paul,

Thanks a lot for your patch.

I  do accept that there are some pre-existing issues in the AI-generated
review that are not strictly related to this patch.

But I do think that it would be best to make this patch more complete
in so far as preventing the overrun described by making a wider guard
for calling igc_test_staterr().

And including igc_clean_rx_irq_zc() in the fix.

My slight preference would be for explicitly tracking the first buffer.
But perhaps that degrades performance.
