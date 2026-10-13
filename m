Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553E48A2C5;
	Tue, 13 Oct 2026 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866141; cv=none; b=revuRCIXweC0t2qj/A6/DtryBcnlpUCrd47zm72iVvd6U3pGSUsJn0obp2j9vZXPmePCStrEv43lZlPCf6Bkyq4LPLCfKSlHjXb3YfbQUUzQ18wvbIHxcUluOYgRcfXilSbVnS13HAwJJxka7MRmx5fpj7BmgrURYtkJ38DOxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866141; c=relaxed/simple;
	bh=zDkd/DpXD4RNquKCU5XNY0xlz0NSS/xSGYtu2LzW3JI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GezdyX0cAmbEsWfDcXrAS0q7XqxOXBNJDdyrDWrT7HhhNgav/Opc+QWb2e75xgvly7XJmPpjI0s3RuE2/swN4PooFR17PJUOwJDKL0n+rTXwU9llv5cYR+OBro8rp6NsMFwMUUIFD2sQZlw0wNsvP6tN1j6GiARq2YCQ8LpRm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hszgltsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hszgltsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785231F00893;
	Tue, 13 Oct 2026 04:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866140;
	bh=be2mDEcK7rKwx7Svv2x4MdQehAQMku3L3KG2TnD+PJo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hszgltsjs1V3pPht2Y4UVq7FFoSxjGu0ZzznB2AQwnFnbrBtHO2TNoIl6n68vJzVs
	 I1a48JBI4pz8vZNmxzP8E3MdCFTuPoNYAy4AnzEe+O39Dr28hrCYiXY4ub5ZtChVd1
	 i+sZcDUlEdgZYRln/G9F3FyLbVCmvTu5xZLCqAJpEY0pqaPf9gwR25qFtsq1/Ghfdq
	 NDf+MGwbnw4yMgNSa9onPIdR5F9nBrEIdESrMOd+2iOvmfQEWcvWUzRhx1PuhhfcS6
	 7jZfde2ZZDjdMYQLPO0r+6SUSu9B/i3OeQjAAGiyFm5V869WtjxcF+XkYKuAjsMGsW
	 h7EC1AXO3cn9w==
Subject: Re: [PATCH net v3 5/5] eth: fbnic: bound the XDP Tx completion head
 to the ring
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, daniel.zahka@gmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 04:35:39 +0000
Message-ID: <179186613908.434549.6327483797678084146@kernel.org>
In-Reply-To: =?utf-8?q?=3C99790c3eceac9ac0bc9afbd90e8adb9789a08c50=2E1791775?=
 =?utf-8?q?409=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3C99790c3eceac9ac0bc9afbd90e8adb9789a08c50=2E17917754?=
 =?utf-8?q?09=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
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

- [High] The patch fixes only TWQ1.

Pre-existing issues:
- [High] fbnic_clean_twq1() can release the same XDP_TX pages to the
  page_pool twice, by a path the new head-window check does not cover.

--

eth: fbnic: bound the XDP Tx completion head to the ring

This patch adds a check to fbnic_clean_twq1() that returns early when the
TWQ1 completion head reported by the device is outside the ring or outside
the posted window. The goal is to stop the cleanup loop from running
forever, and to stop XDP Tx pages being released to the page pool twice,
when the device reports a bogus head.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 7a9bd91bcc41c..3a148eb4e560f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -661,6 +661,12 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
>  	u64 total_bytes = 0, total_packets = 0;
>  	unsigned int head = ring->head;
>  
> +	/* bound the device head to the ring; see fbnic_clean_twq0() */
> +	if (unlikely(hw_head > ring->size_mask ||
> +		     ((hw_head - head) & ring->size_mask) >
> +		     fbnic_desc_used(ring)))
> +		return;

[Severity: High]
The new comment names fbnic_clean_twq0() as the model for this check. The
commit message says:

  fbnic_clean_twq0() masks the head difference to the ring and is finite;
  twq1 did not, which this brings in line.

Does fbnic_clean_twq0() actually do either of these checks? As far as I
can see, it only masks the head:

fbnic_clean_twq0() {
    ...
	clean_desc = (hw_head - head) & ring->size_mask;

	while (clean_desc) {
		struct sk_buff *skb = ring->tx_buf[head];
		unsigned int desc_cnt;

		desc_cnt = FBNIC_XMIT_CB(skb)->desc_count;
		if (desc_cnt > clean_desc)
			break;
    ...
}

fbnic_clean_tcq() reads head0 from the same TCD that head1 comes from:

	head0 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK, tcd);

head0 then reaches fbnic_clean_twq0() through fbnic_clean_twq() with no
ring or window check.

Suppose head0 is past the posted tail, or wraps behind ring->head. The loop
cleans every posted packet and head reaches ring->tail, but clean_desc is
still non-zero.

Wouldn't skb = ring->tx_buf[tail] be NULL at that point? The slot was
either never written or was cleared by ring->tx_buf[head] = NULL. If so,
FBNIC_XMIT_CB(skb)->desc_count dereferences NULL before the
desc_cnt > clean_desc break can run.

The timestamp path has the same exposure. It stores the unchecked value in
FBNIC_XMIT_CB(skb)->hw_head, and fbnic_clean_tsq() later passes it back as
head0.

fbnic_bdq_head_valid() already implements this exact check:

static bool fbnic_bdq_head_valid(struct fbnic_ring *ring, unsigned int hw_head)
{
	if (hw_head > ring->size_mask)
		return false;

	return ((hw_head - ring->head) & ring->size_mask) <=
	       fbnic_desc_used(ring);
}

Could this helper be used for both TWQ0 and TWQ1? If so, the comment and
commit message could be updated so they no longer describe TWQ0 as already
bounded.

> +
>  	while (hw_head != head) {
>  		struct page *page;
>  		u64 twd;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Can
fbnic_clean_twq1() still release the same XDP_TX pages twice, by a path
the new window check does not cover?

Further down in fbnic_clean_twq1(), the page is released for every AL
descriptor the loop walks. ring->head only advances when total_bytes is
non-zero:

		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1,
				   pp_allow_direct);
next_desc:
		head++;
		head &= ring->size_mask;
	}

	if (!total_bytes)
		return;

	ring->head = head;

The tx_buf[] entries are not cleared either. If every descriptor walked in
one call has length 0, the pages go back to the pool but ring->head does
not move.

The next TWQ1 completion would then walk from the stale head and put the
same pages again. So would the flush in fbnic_nv_flush():

	fbnic_clean_twq1(nv, false, &qt->sub1, true,
			 qt->sub1.tail);

A zero-length AL descriptor appears to be postable. FBNIC_RX_PAD is 0, and
fbnic_pkt_prepare() accepts an RCD with len == 0 and builds a zero-length
XDP frame from it.

An XDP program that returns XDP_TX without adjusting the head or tail sends
that frame to fbnic_pkt_tx(). fbnic_pkt_tx() stores the page in tx_buf[]
and writes this length into the descriptor:

	size = pkt->buff.data_end - pkt->buff.data;

Zero-size frags from fbnic_add_rx_frag() can also be posted as len-0
descriptors when a non-zero frag follows them.

A device head1 just past such descriptors would pass the new check. Should
ring->head be advanced before the total_bytes early return?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791775409.git.yhlee%40isslab.korea.ac.kr
