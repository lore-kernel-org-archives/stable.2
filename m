Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BA445AFE;
	Mon,  5 Oct 2026 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241367; cv=none; b=eTOCoKMQY+q9GPmZY9BrzwlAOy0PJlpl6MaZ1G8Ldjhn69Rlpky4MuiH4lILrZovkacyPyrLLm0qGNoe0ID3rw3YeOCUGvXsT8WveyE3xuH/kG6XzkSNP3aopisyKUFZtqiVx8mctt6/CWLUHu9bzMtqKd0elJ3Ti8ZZVGGXyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241367; c=relaxed/simple;
	bh=yNHbVuv0O/5rdFaj/0Y9AEaRLX/seBtS04v78XepPZo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JU4PWH3Np4Ge3mpR59CRq4ybwG9Z3KwNjUn9ARkZHanvzqY6kTwJmSeDJBbF3MFQWhlWML79wTCPcx+xueRl3LPjjyiMuiKp4dPcbBjIEdBwv21FesjgSWoWMCQDTH3AtEQfpEL5ICIPH4fY13ojyaQwYNDbdQxXIRqzwOt4H3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSAaWg6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSAaWg6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8071F000FF;
	Mon,  5 Oct 2026 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241365;
	bh=wflY3NyBHI60sZwNeNEK7rfq0qRKQiiOaScUkJWpQVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jSAaWg6/LjbF8tvLl6uB3SB8LfvRpqA5LsuPgQnnoLQsFbKpxXn3QLo83IuraUQl9
	 Mm7HehMFHfD+19ZRie1pGsNViY2aMYoUCzjYYskiQg9q9LsA4XIphy63Cn34ZJN7iB
	 eefe/Rj4NshxxzaFrLODAa5Pp8TphihdDamFKNa+TxGtlh93m5eBzJTpRY1GE6085p
	 eQhMrk6YTn2t1lPBCvLtsY87MpZWPX35su+AzR1vWdMchcCtx/A4QhzsAK0vVkBQ01
	 GY5AVFL8JE7HaJN45N4aPxbPbYiutyiqQAkJAGne+gGLHvZY3a8C7ps3UjS0DYC7oF
	 vC20RDQYsTRsQ==
Subject: Re: [PATCH net 3/6] igb: only strip Rx timestamp header on the first
 buffer of a frame
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com,
 dima.ruinskiy@intel.com, raanan.avargil@intel.com, gil.fine@intel.com,
 stable@vger.kernel.org, javier.herrera@afronta.com,
 aleksandr.loktionov@intel.com
Date: Mon, 05 Oct 2026 23:02:44 +0000
Message-ID: <179124136413.434549.11535076575423885448@kernel.org>
In-Reply-To: <20261001222443.3500206-4-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-4-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same
  unguarded strip exists in igb's AF_XDP zero-copy Rx path.

--

igb: only strip Rx timestamp header on the first buffer of a frame

When Rx hardware timestamping is enabled, igb_clean_rx_irq() tries to strip
the 16-byte timestamp header from every Rx buffer of a frame. A continuation
buffer whose payload starts with 8 zero bytes then loses 16 bytes of data.
The patch adds a !skb check so that the strip only runs on the first buffer
of a frame.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..5c09dc4a25660 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9069,8 +9069,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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

[Severity: High]
Is !skb a reliable stand-in for "first buffer of a frame" when an XDP
program is attached?

The commit message says "skb is NULL until the first buffer has been
processed". However, when igb_run_xdp() returns a verdict other than PASS
(DROP, ABORTED, TX or REDIRECT) for the first buffer of a multi-descriptor
frame, skb is never assigned:

igb_clean_rx_irq() {
    ...
		if (xdp_res) {
			if (xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR)) {
				xdp_xmit |= xdp_res;
				igb_rx_buffer_flip(rx_ring, rx_buffer, size);
			} else {
				rx_buffer->pagecnt_bias++;
			}
    ...
		if (igb_is_non_eop(rx_ring, rx_desc))
			continue;
    ...
}

So the continuation descriptor goes through the loop with skb still NULL.
If the budget runs out mid-frame, rx_ring->skb = NULL carries that state
into the next poll.

On 82580 and newer, any Rx timestamp filter is upgraded to
HWTSTAMP_FILTER_ALL. Per the commit message, continuation descriptors also
carry TSIP. That means the !skb && TSIP check passes on payload, and
igb_ptp_rx_pktstamp() returns IGB_TS_HDR_LEN whenever the first 8 payload
bytes are zero.

Won't that still strip 16 bytes from the continuation buffer?

Now suppose the final fragment is shorter than 16 bytes, for example 8 zero
bytes chosen by the sender. Can size -= ts_hdr_len wrap the unsigned size?
xdp_prepare_buff() takes an int data_len, so data_end would end up before
data:

include/net/xdp.h:xdp_prepare_buff() {
    ...
	xdp->data_end = data + data_len;
    ...
}

On XDP_PASS, igb_build_skb() then does:

	__skb_put(skb, xdp->data_end - xdp->data);

As an unsigned length that is roughly 4 GiB. With legacy-rx,
igb_construct_skb() passes a frag of similar size to skb_add_rx_frag(). On
XDP_TX/REDIRECT, the bogus length goes into the xdp_frame and into
igb_rx_buffer_flip().

Multi-descriptor frames do seem to reach XDP rings:

- igb_xdp_setup() and igb_change_mtu() only check
  mtu + IGB_ETH_PKT_HDR_PAD against igb_rx_bufsz(). That check ignores the
  16-byte in-buffer timestamp that igb_setup_srrctl() enables with
  E1000_SRRCTL_TIMESTAMP.
- igb_setup_rctl() always sets E1000_RCTL_LPE.
- igb_set_rx_mode() leaves RLPML at MAX_JUMBO_FRAME_SIZE when the MTU is
  above about 1514 on 4K pages, when VFs are allocated, or when
  PAGE_SIZE >= 8192.

The underflow was already possible on this path before this patch, and the
patch doesn't change it. Still, the continuation-buffer strip that this
commit sets out to fix looks reachable here.

Would explicit first-buffer state work better? Two options are a flag set
at frame start and cleared after the first descriptor, or discarding the
rest of the frame once XDP has consumed the head. Checking that
size >= ts_hdr_len before the subtraction might also help.

[Severity: High]
This isn't a bug introduced by this patch, but the AF_XDP zero-copy Rx path
has the same unguarded strip, and this patch only changes
igb_clean_rx_irq():

drivers/net/ethernet/intel/igb/igb_xsk.c:igb_clean_rx_irq_zc() {
    ...
		xsk_buff_set_size(xdp, size);
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

This code runs on every TSIP descriptor. It has no first-buffer check and
no size >= IGB_TS_HDR_LEN check, and it treats each descriptor as its own
frame.

In ZC mode, igb_setup_srrctl() sizes the hardware buffer from
xsk_pool_get_rx_frame_size(), rounded down to 1 KB. With 2K chunks, a
normal 1500-byte frame therefore spans more than one descriptor.

Can a zero-prefixed final fragment shorter than 16 bytes push xdp->data and
xdp->data_meta past data_end here?

On XDP_PASS, igb_construct_skb_zc() does:

	unsigned int totalsize = xdp->data_end - xdp->data_meta;
	...
	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
	...
	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
	       ALIGN(totalsize, sizeof(long)));

For an 8-byte fragment, totalsize would be 0xFFFFFFF8. napi_alloc_skb()
adds NET_SKB_PAD + NET_IP_ALIGN in unsigned int, which wraps to a small
value, so the allocation succeeds. For fragments of 1 to 8 bytes, the
memcpy length then stays at 0xFFFFFFF8.

Would that overflow the skb head?

For fragments of 9 to 15 bytes, the copy length wraps to 0, but the skb
still ends up with a len of about 4 GiB. Fragments of 16 bytes or more lose
16 bytes of payload, the same data loss described in this commit message.

The kernel-doc for igb_ptp_rx_pktstamp() also says it is meant to read the
timestamp from the first buffer of an incoming frame, and the ZC caller
doesn't follow that.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001222443.3500206-1-anthony.l.nguyen%40intel.com
