Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014416;
	b=AL9LrL8Tv67EGeVafL6OMqlXasThXceE9Opa6AYYayEzd1m32gQQG1a6Wc/E+lUzC/cs
	 08bKBkBh9fFIhXyl514J8LnbeMUYfzGtcjbBKNN6c/mGfUmq+DPTzsgA5XwEBoK0BRPWu
	 cqwfwO8mLz3XEQwnC62/TxXslb/39o2jlR2bp4vIG0bLChTgMqOpdof2h7U97fiUgS5jO
	 55BqMuPuHEXn3EaBUl8oRPof1tyj2Ctfl5NneaMVBTptxb2zFy9BF7AzsUHZfYmRPkVo+
	 NGobfVUh8Z8Ea3f02mukYg8ugyUB9yePuAheV9T7Wclj8P/QL5sHoFcnTfL95nzXOmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=83uVxgrEq/KHZPaRBP/vtVmxJ0Dkegg3YGWIX/TiyJA=;
	b=cyCgKaddfq7tT/ClYSMEKjzXs0UVBNdpB2W9Ju8iSNNcraaB1/oyXmQbQ4bgs7bjFGuv
	 KZYRG0lVgX2zdQ4rVO+YY8K6uu/Genwg3Ek3xZ9Du+ojtAQIC29ATMiJKw8/boBTIr3R0
	 Gx1AzsBDd2Lq/kVYGsqRVIOzd6Z1k86LdK/48FdlaPHF2ImNsg+WBX9JuRjD/gR1jZSWw
	 4L3a2LpR7/94VDsucX4t86A5qqLDfFDppskwOnI4I/2jVuXlrmBynWWhjQ5DAQ3wufMqq
	 FSRZgci0qIJ26dnjNJaAd3BX8LSzA+w5reOGB66d+nu/VWC6nnFkq+pNbeB4143Qaww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0g0R4jS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA23606A32F;
	Wed, 18 Nov 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0g0R4jS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4161F000C4;
	Wed, 18 Nov 2026 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014416;
	bh=83uVxgrEq/KHZPaRBP/vtVmxJ0Dkegg3YGWIX/TiyJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0g0R4jSls70FcEfEtTYh/gU12t1TLrpQPsG0SBMcjeEK1SHaBQq5LF2/fA6p9BWu
	 Rl8dCtc/9GrRJ1TxDesqDNcWfySsMvLhQWzlJ/eum2Afg4Odg80nUcWtqQtJ6+JTkD
	 ZjYXA4GJNMlzh1azd/mXlB0o5zc/KnUXzHJetc5qOfB/7trYSK1jWhZM0si1sjw+eQ
	 o777azljqij/UIT3jKYWK2jpBrEyRa7A5wrQY87uyo091KTA4fRDrFRp9cyhLl2ug9
	 jUtIByZOzXr/jhOGUiM/0iwZ3s6IS+9zGkwa0UX40knUMNCMgbDPQGlyCaBA5PcdSJ
	 T5FSWkk5wQmeg==
Date: Wed, 18 Nov 2026 15:06:51 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: xiaolinkui@126.com, david@ixit.cz, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
	yangguikun19@qq.com, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: fix SNL PDU size truncation in
 nfc_llcp_allocate_snl()
Message-ID: <20261118150651.GE860048@horms.kernel.org>
References: <20261111095907.3366028-1-xiaolinkui@126.com>
 <179473943962.2199510.6509653868703486721@kernel.org>
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
In-Reply-To: <179473943962.2199510.6509653868703486721@kernel.org>

On Sun, Nov 15, 2026 at 10:43:59AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message names the wrong trigger and leaves out the
>   real one.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch
>   makes it easier to reach.
> 
> --
> 
> nfc: llcp: fix SNL PDU size truncation in nfc_llcp_allocate_snl()
> 
> This commit changes the size accumulator in nfc_llcp_allocate_snl() from
> u16 to size_t, so the SNL PDU allocation size can no longer wrap before
> alloc_skb(). The commit message says the overflow comes from
> nfc_genl_llc_sdreq() building many SDREQ TLVs out of a netlink request.
> 
> Link: https://lore.kernel.org/netdev/tencent_634C55A23C7CCCA3985283BFED46A69C9E09@qq.com/
> 
> > nfc_genl_llc_sdreq() walks the nested NFC_ATTR_LLC_SDP attributes of a
> > GENL_ADMIN_PERM request, builds one SDREQ TLV per attribute and sums
> > their lengths into the size_t tlvs_len. Each URI is capped at
> > U8_MAX - 4 bytes by nfc_sdp_genl_policy, so every TLV fits in its u8
> > tlv_len, but nothing caps the number of attributes, so tlvs_len can
> > exceed U16_MAX.
> 
> [Severity: Medium]
> 
> Can this netlink path actually wrap the u16?
> 
> nfc_genl_llc_sdreq() only walks a single attribute:
> 
>     nla_for_each_nested(attr, info->attrs[NFC_ATTR_LLC_SDP], rem) {
> 
> NFC_ATTR_LLC_SDP is one NLA_NESTED attribute, and its nla_len is a
> __u16, so the nested payload is at most 65531 bytes.
> 
> Each entry costs at least 8 bytes of nest and URI attribute headers plus
> NLA_ALIGN(uri_len), and it produces a TLV of only uri_len + 3 bytes. With
> uri_len = 251 that comes to about 64014 TLV bytes at most. The
> LLCP_HEADER_SIZE, NFC_HEADER_SIZE, tx_headroom and tx_tailroom that
> nfc_llcp_allocate_snl() adds are small for the in-tree drivers.
> 
> The path that does look able to wrap is the remote SDRES one:
> 
> nfc_llcp_recv_snl()
>     nfc_llcp_build_sdres_tlv()   /* 4 bytes per 3-byte SDREQ TLV */
>     nfc_llcp_send_snl_sdres(local, &llc_sdres_list, sdres_tlvs_len)
>         nfc_llcp_allocate_snl()
> 
> A peer in NFC range can send one SNL PDU packed with 3-byte SDREQ TLVs
> (type, len=1, tid). sdres_tlvs_len then grows to about 4/3 of the frame
> size.
> 
> Neither nci_add_rx_data_frag() (via skb_cow_head()) nor
> digital_recv_dep_data_gather() (via skb_copy_expand()) caps the
> reassembled frame. An SNL PDU of about 49 KB would therefore wrap the old
> u16 size and hit skb_over_panic() in nfc_llcp_send_snl_sdres().
> 
> The code change fixes both senders, since they share
> nfc_llcp_allocate_snl(). Could the commit message describe the SDRES path
> that an unprivileged remote peer can trigger, instead of the
> GENL_ADMIN_PERM netlink path? As written, it reads as if the bug needs
> CAP_NET_ADMIN to trigger.

It seems to me that the analysis above is correct and the patch
could benefit from a v2 that rewords the commit message.

> 
> > diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> > index 80a00938c8696..0a3d66e6cd59f 100644
> > --- a/net/nfc/llcp_commands.c
> > +++ b/net/nfc/llcp_commands.c
> > @@ -542,7 +542,7 @@ static struct sk_buff *nfc_llcp_allocate_snl(struct nfc_llcp_local *local,
> >  {
> >  	struct sk_buff *skb;
> >  	struct nfc_dev *dev;
> > -	u16 size = 0;
> > +	size_t size = 0;
> 
> [Severity: High]
> 
> This is a pre-existing issue, but now that size no longer wraps, does
> nfc_llcp_recv_snl() leak the llc_sdres_list entries when alloc_skb() fails
> here?
> 
> nfc_llcp_send_snl_sdres() returns before the loop that frees the entries:
> 
> net/nfc/llcp_commands.c:nfc_llcp_send_snl_sdres() {
> 	skb = nfc_llcp_allocate_snl(local, tlvs_len);
> 	if (IS_ERR(skb))
> 		return PTR_ERR(skb);
> 
> 	hlist_for_each_entry_safe(sdp, n, tlv_list, node) {
> 		skb_put_data(skb, sdp->tlv, sdp->tlv_len);
> 
> 		hlist_del(&sdp->node);
> 
> 		nfc_llcp_free_sdp_tlv(sdp);
> 	}
>     ...
> }
> 
> nfc_llcp_recv_snl() ignores the return value, and the list head is on its
> stack:
> 
> net/nfc/llcp_core.c:nfc_llcp_recv_snl() {
> 	HLIST_HEAD(llc_sdres_list);
>     ...
> 	if (!hlist_empty(&llc_sdres_list))
> 		nfc_llcp_send_snl_sdres(local, &llc_sdres_list, sdres_tlvs_len);
> }
> 
> Each SDREQ TLV from the peer leaves behind a struct nfc_llcp_sdp_tlv and
> its 4-byte tlv buffer. That is about 72 bytes for every 3 bytes on the
> wire.
> 
> Before this change, a frame that needed more than 64 KiB wrapped size and
> panicked. Now alloc_skb() gets the full size, about 4/3 of the frame.
> 
> That allocation can fail for costly orders under fragmentation. It always
> fails once the request is above MAX_PAGE_ORDER: on x86-64 with 4 KiB
> pages, that is an SDRES over 4 MiB, from an SNL PDU of about 3 MiB.
> 
> Frame reassembly has no cap, so one such frame would leak around 1M
> entries, roughly 72 MB. Repeated frames could drive the system to OOM.
> 
> The same leak happens when local->dev is NULL and nfc_llcp_allocate_snl()
> returns -ENODEV.
> 
> Should the tlv_list entries be freed on this error path, either in
> nfc_llcp_send_snl_sdres() or in its caller?

The problem flagged above seems to be reachable both before and after this
patch. So I think it can be handled separately to this patch.

-- 
pw-bot: changes-requested
