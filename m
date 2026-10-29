Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317042;
	b=JcXBXpiTW6hIT/Nb+QC4YDByYQDfPh4bZ0D5eI3ksD9FuPa1ZTNCIick7j9uDlrip0RB
	 mLy2pt8AY/EgT9okp03gP22jLrY4Bk4K7YmMshEybW9LFaMHJRrBtOmP2ckRssgU4vzLi
	 3qYVhMrxXyaplD70HHCQtja5QKdNmVnX+tco/0WRoQNcKuNT83eAGiVhKHSVvnCnliHpG
	 GtdVU4BADIDmnZQMPf4NxZyeqF440wbWHmvtGd79xCdsqTCtWDU5r5ti2vzkiDAQai48K
	 r5A2MtIDhXe2NoeaxbRrPFMP8PfR0KAiPaWAOmtKGZBQNXJYBgQtgu9SKMoyPrHfKaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317042;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
	b=A2tXL37GkZ5vIBRhAZKNo5YGTs7U6A7f2pfZt1AeYBd8E2TFTX7CixC54KO/eoDRb+2K
	 kY4Zk6jNn83cCzwg+/1oIRVVvEin6rQ1abxtUPku5GyqLVOTXkmd6cmWZU5/+lcyhG673
	 01thw6wd8AlHFcFLvxqzOZA+3JYDCmQgXQ9kAdgVVosxDcFWXyCCY+iAQv8OmGdlTF6rD
	 4dHn0xfNFFHJL1fGplvBrzy5zUAMxLsUiS9PViUqJQGqrWOCMxOZyIhMWoR6ofThv1FUj
	 ZEyvwgXhZI66F9EbpYELubwQZ/ujt/oxlLlg1D1NccCa5/vJqUlXQHNvRsmMBzxeh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R05gLblW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E38606A31A;
	Thu, 29 Oct 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R05gLblW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0F41F000C1;
	Thu, 29 Oct 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793317041;
	bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R05gLblWTTN824zu82pI3l2ENb3x0UJOC2wCnnFXkei5l9JntgziiPL8ezIF4Mt5P
	 +GarUUsN4gosKnKJjeHjcU2z85IFjIoTdqFY6iS8Mi4t2pXW1r2oJLpYKqtJeVsSWy
	 ANNh8H2cs7eB7GGM/yncFyPqQXSQswnxNhQmQqxHUm7C/UzfBbSZWzEfCD1PsavHZ1
	 LTkboY5WWkDMdeztFiiP8A16Q+aHX5cYaewmA/Hs+iRxBCboWHqtCTtUbaYCfxOmLZ
	 8+7cVlSEgKnq5HsUo1MlKFdIt7k0xXJubn+o6mCBA5jTP2w7EsdfwajLbZ3SP4p1/2
	 REq73ohMTC4aw==
Subject:
 Re: [PATCH net v3 1/2] igc: only strip RX timestamp header from first buffer
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 vedang.patel@intel.com, jithu.joseph@intel.com, maciej.fijalkowski@intel.com,
 andre.guedes@intel.com, aleksandr.loktionov@intel.com,
 avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 29 Oct 2026 23:37:20 +0000
Message-ID: <179331704005.3134.12545545223659652020@kernel.org>
In-Reply-To: <20261028083344.3047350-2-p@1g4.org>
References: <20261028083344.3047350-2-p@1g4.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit by itself, the new first-buffer test `!skb &&
  igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)` in igc_clean_rx_irq()…

--

igc: only strip RX timestamp header from first buffer

igc_clean_rx_irq() used to subtract IGC_TS_HDR_LEN from every descriptor
with TSIP set, which truncated multi-buffer packets. With this patch the
timestamp header is only stripped when skb is NULL, which the commit treats
as marking the first buffer of a new packet.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/

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
>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;

[Severity: High]

Is skb == NULL a reliable first-buffer marker when an XDP program is
attached? The commit message says:

    Only consume the timestamp header when skb is NULL, which identifies the
    first buffer of a new packet.

Suppose igc_xdp_run_prog() returns IGC_XDP_CONSUMED, IGC_XDP_TX or
IGC_XDP_REDIRECT for the first, non-EOP buffer of a multi-descriptor frame.
Then no skb is built, and igc_clean_rx_irq() moves on to the continuation
descriptor with skb still NULL:

		/* fetch next buffer in frame if non-eop */
		if (igc_is_non_eop(rx_ring, rx_desc))
			continue;

The continuation descriptor still has TSIP set, so this check strips
IGC_TS_HDR_LEN a second time. If that descriptor holds fewer than 16 bytes,
can the unsigned size wrap here?

The continuation buffer then goes through the new-frame path:

		if (!skb) {
			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
					 igc_rx_offset(rx_ring) + pkt_offset,
					 size, true);

In that case the XDP program would see a data_end about 4 GiB past data.
On XDP_PASS, the same size would reach igc_build_skb() or
igc_construct_skb(), and the __skb_put() there does not check it.

At this commit, XDP with multi-descriptor frames looks possible on kernels
with PAGE_SIZE >= 8192. igc_set_rx_mode() only clamps RLPML under the
small-page #if:

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
		rlpml = IGC_MAX_FRAME_BUILD_SKB;
#endif
	wr32(IGC_RLPML, rlpml);

On large-page kernels, RLPML therefore stays at MAX_JUMBO_FRAME_SIZE while
igc_rx_bufsz() returns IGC_RXBUFFER_2048. igc_xdp_set_prog() only checks
dev->mtu > ETH_DATA_LEN, not the hardware receive length limit.

This needs RX hardware timestamping enabled, an XDP program that returns a
non-PASS verdict for a first buffer, and a peer that sends frames larger
than about 2032 bytes.

The next patch in this series, "igc: fix AF_XDP receive buffer size for 2K
UMEM chunks", adds igc_set_rlpml(). It caps RLPML at 1526 bytes whenever
XDP is enabled, whatever PAGE_SIZE is. It is called from igc_setup_rctl()
and igc_xdp_set_prog(). With that change, XDP frames always fit in a single
descriptor, and skb == NULL becomes a correct first-buffer marker.

This patch is tagged Cc: stable and could be backported on its own. Should
it depend on that follow-up change, or should the two patches be swapped in
the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028083344.3047350-1-p%401g4.org
