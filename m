Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704586;
	b=sW5e2g37AtVyLgj3j5NxSlkGHxHgKRepCVDd8fO/NrSJS3WTi7161jFUpxOFT5pI8a08
	 BO480lz2FO4SrXwFl5rs/Mw4jdYb4e/FZ52w7x84g8dRPWrwfq8oIN03QggK3cR82Y4bY
	 pOZyz7hQjosyFd1l4mMYQrt8NekgvzDJw4va8gxot1qAKkh1VAGCjEXperrq0SMlpAhEy
	 sRg7dQm2HssCfaapGR9cHnRYUDujhrI8x1W0/alYXu3jDbtOJSnRoJXfklTEhhhDt8Cb7
	 x7UGapKbdyQPB/Gpv1zOS6uRVZlZktAJ0oogxn0rf6TVHgxLLtobZGXC+u3rpIe7sTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704586;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g6O6a5beCv8LhfM9sQGN6bgiLPfhlM94Vo/zePfSuS4=;
	b=P5seGENxvqOnmeTu9/+FPnhpLSxX0cHoy/Jq/Wb6xnAYwodp/V5bvQhA2ZbprjfmWLkp
	 km2Ojb38SxsZf19oK+D1VGmdgQce0ThMU15pBO1tivvBocucTy+aaxkmZ7/sqdgZVaBQd
	 ppOUn1OD9fwO2hTeXuVUAvc0MfcaNeeIHaG99tJJ7/Ill0kavvkRd8JrjF406uV1+pfLb
	 7IglmNJwHM/8vIZ836n16WLoRM6ooIy5FoOCTNE1h+D+EC36P1ZzPRfXw4ALrZqcKLMre
	 36I7GqCb6zJ1MvvwT4IaxCEEozfAOjzYRh7vWEPAUEiRg2ouiYL39LIdO6WtDhUzgpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awe0zXNi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A03606BA71;
	Tue,  3 Nov 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awe0zXNi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B88B1F0093A;
	Tue,  3 Nov 2026 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704585;
	bh=g6O6a5beCv8LhfM9sQGN6bgiLPfhlM94Vo/zePfSuS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=awe0zXNiUD/1s52pSmvtw4opVsxgDwP60nJtXjegl+GUAIjsbLwejKft+9BqoWX7j
	 cqucgZi976cnWfLoV7hKrXs8W/cF8iYHhi6P7mzUMiJ9PW17ll/XLV2umB5Z1v4hsV
	 ZdOT5ADO2NnFC8GcLnLsqtBfg8yN4rqEH7IOWSSVL9RtwilNT3o5DklMkaAXdfet+O
	 /LBNw567w5FJ6c+fsNCcrmnrmCdQbhH3ADPB95O5utstuFYmrtVngdPlwe7ol9M013
	 n8sMEC1K+IeDh8EJlKNxlaRFw5t/4DGqI4pwXc35GmlU7eAuxfczM5sZch5/U1tmsf
	 xK+sRCx+cUKYg==
Subject: Re: [PATCH net v4 2/2] igb: only strip Rx timestamp header on the
 first buffer of a frame
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Tue, 03 Nov 2026 11:16:24 +0000
Message-ID: <179370458415.488856.4986828557551816954@kernel.org>
In-Reply-To: <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says "igc has the same bug and is fixed the
  same way." The patch does not change igc.
- [High] igb: XDP setup and MTU checks in igb_xdp_setup() reject default
  MTU 1500
- [Low] The commit message understates what the pre-patch bug does.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is the same
  failure this patch fixes for igb, on igb's other Rx path.

--

igb: only strip Rx timestamp header on the first buffer of a frame

This commit guards the Rx timestamp header strip in igb_clean_rx_irq()
with !skb, so it only runs on the first buffer of a frame. Before this, a
continuation buffer whose payload started with 8 zero bytes could be
mistaken for a timestamp header and lose 16 bytes.

Link: https://lore.kernel.org/all/20261028083344.3047350-2-p@1g4.org/

> returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
> that buffer. A frame spanning N buffers whose continuation buffers start
> with zero bytes therefore loses 16 * (N - 1) bytes from its tail.

[ ... ]

> the all-zero frames arrive truncated while frames with non-zero content
> are fine. There is no error indication.

[Severity: Low]
Is this an accurate description of the pre-patch behaviour?

On a continuation buffer (skb != NULL), the old strip only reduced size.
pkt_offset is only used by xdp_prepare_buff() in the !skb branch.
igb_add_rx_frag() then does:

	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
			rx_buffer->page_offset, size, truesize);

So each affected buffer loses its last 16 bytes, and the data after it
shifts left. For frames that span more than two buffers, the corruption is
in the middle of the payload, not at the tail.

Also, igb_ptp_rx_pktstamp() only checks that the first 8 bytes are zero. It
returns IGB_TS_HDR_LEN without comparing against the descriptor length.
Suppose the last descriptor of a frame holds k bytes, with 8 <= k < 16, and
they are all zero. The old code would then do:

	size -= ts_hdr_len;

The unsigned size wraps to 0xFFFFFFF0 + k. That gives a frag of roughly
4 GiB that no longer matches skb->data_len. The sender picks the frame
length, so a remote sender can reach this.

This patch closes both cases. Could the commit message mention the
mid-frame loss and the possible size wrap, for stable and security
triage?

[ ... ]

> igc has the same bug and is fixed the same way.

[Severity: High]
Is igc actually fixed here? The diffstat only lists
drivers/net/ethernet/intel/igb/igb_main.c. Neither this patch nor the
previous one in the series touches drivers/net/ethernet/intel/igc/.

igc_clean_rx_irq() still strips on every descriptor that has TSIP set:

drivers/net/ethernet/intel/igc/igc_main.c:igc_clean_rx_irq() {
    ...
		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
			ctx.rx_ts = pktbuf;
			pkt_offset = IGC_TS_HDR_LEN;
			size -= IGC_TS_HDR_LEN;
		}
    ...
		} else if (skb)
			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
    ...
}

There is no !skb guard here. There is also no reserved dword check like
the one in igb_ptp_rx_pktstamp().

If i225/i226 set TSIP on continuation descriptors the way igb does, every
continuation buffer of a timestamped multi-buffer frame would lose its last
16 bytes, whatever its content. Is that the case?

There is also no size check before the unsigned subtraction. A last buffer
shorter than 16 bytes would make igc_add_rx_frag() add a frag of about
4 GiB.

Should this patch add the same !skb && guard to igc_clean_rx_irq()? The
alternative is to drop this sentence and fix igc in a separate patch with
its own Fixes: tag. igc already limits RLPML while XDP is attached, so the
guard looks safe there.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 5bf489cd7b066..c4eb9f589fbe7 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9072,8 +9072,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  		rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		/* pull rx packet timestamp if available and valid */
> -		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +		/* pull rx packet timestamp if available and valid; it is only
> +		 * present on the first buffer of a frame
> +		 */
> +		if (!skb &&
> +		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
>  			int ts_hdr_len;
>  
>  			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,

[Severity: High]
This patch depends on the receive length limit from the previous patch
in the series, so I am raising this here. The checks that patch adds to
igb_xdp_setup() and igb_change_mtu() look like they reject the default
MTU of 1500 on systems with PAGE_SIZE < 8192.

At MTU 1500, frame_size in igb_xdp_setup() is 1500 +
IGB_ETH_PKT_HDR_PAD = 1526.

igb_set_rx_buffer_len() only selects 3K buffers when
adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB, and that test does
not include IGB_TS_HDR_LEN. With 4 KiB pages and SBP clear, the ring
stays on build_skb buffers. igb_rx_bufsz() then returns
IGB_MAX_FRAME_BUILD_SKB, which is 1536 - NET_IP_ALIGN.

The new check

	if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {

compares 1542 against 1536 (or 1534) and returns -EINVAL. Does that
mean XDP can no longer be attached to an igb interface at the default
MTU? Every MTU from 1495 to 1510 is affected the same way, or 1493 to
1508 when NET_IP_ALIGN is 2.

The loop in igb_xdp_setup() also runs when bpf->prog is NULL. Two cases
leave a program attached at MTU 1500:

  - It was attached while the interface was down, before the first
    open. ring->flags is 0 then, so igb_rx_bufsz() returns 2048.
  - It was attached at a larger MTU with 3K buffers, and the MTU was
    then lowered to 1500.

Can that program still be detached or replaced?

igb_change_mtu() has a related problem. It checks max_frame +
IGB_TS_HDR_LEN against igb_rx_bufsz() using the ring flags for the old
MTU. igb_set_rx_buffer_len() has not yet picked the buffer size for the
new MTU at that point.

With XDP attached and the MTU at 1494 or below, every larger MTU is
rejected. That includes MTUs from 1511 to 3030, which would fit in the
3K buffers that igb_up() would then select. Going from 3000 down to
1500 is allowed, though. That leaves XDP running on 1536 byte buffers,
where the detach check above then fails.

Should igb_set_rx_buffer_len() include IGB_TS_HDR_LEN when it decides
whether to use 3K buffers, so that the ring sizing and the XDP checks
agree? Should the detach path skip the buffer size check entirely? And
should igb_change_mtu() check against the buffer size the new MTU will
get, rather than the current ring flags?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
igb AF_XDP zero-copy Rx path seems to have the same problem, and the new
first-buffer rule does not cover it.

igb_clean_rx_irq_zc() still strips on every descriptor that has TSIP set,
and it treats each descriptor as its own packet:

drivers/net/ethernet/intel/igb/igb_xsk.c:igb_clean_rx_irq_zc() {
    ...
		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
			int ts_hdr_len;

			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
							 xdp->data,
							 &timestamp);

			xdp->data += ts_hdr_len;
			xdp->data_meta += ts_hdr_len;
			size -= ts_hdr_len;
		}
    ...
}

Frames can span descriptors in this mode:

  - igb_setup_srrctl() takes the hardware buffer size from
    xsk_pool_get_rx_frame_size() in 1 KiB units, so 2048-byte chunks give
    1 KiB buffers.
  - igb_xsk_pool_enable() does not check the pool frame size against
    max_frame_size + IGB_TS_HDR_LEN.
  - The RLPML limit from the previous patch is based on
    adapter->max_frame_size, not on the pool's buffer size.

Suppose a continuation descriptor holds 8 to 15 bytes, all zero. Then
xdp->data ends up past xdp->data_end. On XDP_PASS, igb_construct_skb_zc()
does:

	unsigned int totalsize = xdp->data_end - xdp->data_meta;
	...
	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
	...
	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
	       ALIGN(totalsize, sizeof(long)));

totalsize wraps to about 4 GiB. napi_alloc_skb() adds NET_SKB_PAD, so the
allocation length wraps to a small value (56 bytes on x86_64 for k = 8).

Can the memcpy() then overflow the skb head? For k = 9 to 15, ALIGN()
wraps to 0 and the skb is left with skb->len near 4 GiB.

The zero-copy path does not track frames, so a !skb style guard would not
work there directly. One option is to reject pool frame sizes that let
max_frame_size + IGB_TS_HDR_LEN span descriptors. Another is to handle EOP
there and only strip on the first descriptor, with a size check. Would
either of those make sense?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102-igb-rx-ts-fix-v4-0-8785124c5d23%40aweta.nl
