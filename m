Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739440;
	b=277xzkgYI+NjnSzlDWmJ4iR/jHEj3xOxukWjVuH4y6knIt9bbl0rx5SJkT1+AQW0rwG0
	 gJSv1JQFYtYQM0qzArMZvGL7UVRp5KEIvMfb+uETbB/ktziNPa810exPBt7ONxXFQ3DlC
	 eBx9o4NjFvgG09UgfV6368GToFhj9Zqslf3QWlnbuSFrkdk/YBh2eme9Nn2EmGZ76qHHU
	 8wFwpIJXJEM9HRTb+ArF0nMHUvZSeNXext+5Obyyx+6gkWZdspv5ptOR09Yo3nYIzvWfH
	 Q60SIFPswDTJLXew5TC2aARyivhUMHd2tNiPlwEgP4kmV6YgIB9zZVfS2xAdWaz15cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739440;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=M7q3XhZjIgILEi4FdjQiYVSDqbk2Z9+UcwOqPf7M1/A=;
	b=ODhFZDM+3dq42aAgLvfCsTelp7oJj6C+Odl0Okk7+bgF/B96EAPUqv/pQkzHj9jnmNjj
	 bvlR9dEkxI1Q1aYBpRgTSCsQ5IzKlAqj9fTMimdY6zhgn4jwvq3K9j3y7fia43dIqF0C+
	 jXobSIEhKv18K5NkC/vc7pBacAB9bmUhoBBhZxLtiieN40sBUce+M4aOdmrDKv8YbrWJS
	 bcj4cDRTmFDpXxnvivdbeBothC5wej/W0cF9HyDjAXHQPPgdltYcyrkI2SvEUp0i80Wqq
	 hJMgirxIcuhqR34eVBxrscrOw0zKHY8vyG13Pmsv7sWEKlKnvNiFmbB+iaT5oG4Fq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeUAfFIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F88606A31D;
	Sun, 15 Nov 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeUAfFIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F91F000C6;
	Sun, 15 Nov 2026 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739440;
	bh=M7q3XhZjIgILEi4FdjQiYVSDqbk2Z9+UcwOqPf7M1/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AeUAfFItkVVRp5bTvSTFjDeHDYNEYvM4O5BdA7kmULxNkZa9fZu39iCGNwwpZ39B5
	 iRK65c2cwPH9/yzOG/0qS6+53Z1iU0xJd9+U9KGu1tADbh45FR+RC4TwgTsZFf6auK
	 Sky1cCxoxLTahy/0BkMewmsDvQ5Z7bN0eGTDUCD/gJ1AindVPej4vM/FJIeBxKlYBE
	 6h76iPLtsL96F2ILVqeflxIwb7fHYP+wLoqYQ7arMv6A47MuByyed2StJOKSuxWDuE
	 b41j8345woVKZREpgI/PKXvuCEUMIn1pEGpytoFQ2kuVy55cDtXxp2qkigih3CqZoq
	 IeFyf11JCqVgQ==
Subject: Re: [PATCH net] nfc: llcp: fix SNL PDU size truncation in
 nfc_llcp_allocate_snl()
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 yangguikun19@qq.com, stable@vger.kernel.org
Date: Sun, 15 Nov 2026 10:43:59 +0000
Message-ID: <179473943962.2199510.6509653868703486721@kernel.org>
In-Reply-To: <20261111095907.3366028-1-xiaolinkui@126.com>
References: <20261111095907.3366028-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message names the wrong trigger and leaves out the
  real one.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it easier to reach.

--

nfc: llcp: fix SNL PDU size truncation in nfc_llcp_allocate_snl()

This commit changes the size accumulator in nfc_llcp_allocate_snl() from
u16 to size_t, so the SNL PDU allocation size can no longer wrap before
alloc_skb(). The commit message says the overflow comes from
nfc_genl_llc_sdreq() building many SDREQ TLVs out of a netlink request.

Link: https://lore.kernel.org/netdev/tencent_634C55A23C7CCCA3985283BFED46A69C9E09@qq.com/

> nfc_genl_llc_sdreq() walks the nested NFC_ATTR_LLC_SDP attributes of a
> GENL_ADMIN_PERM request, builds one SDREQ TLV per attribute and sums
> their lengths into the size_t tlvs_len. Each URI is capped at
> U8_MAX - 4 bytes by nfc_sdp_genl_policy, so every TLV fits in its u8
> tlv_len, but nothing caps the number of attributes, so tlvs_len can
> exceed U16_MAX.

[Severity: Medium]

Can this netlink path actually wrap the u16?

nfc_genl_llc_sdreq() only walks a single attribute:

    nla_for_each_nested(attr, info->attrs[NFC_ATTR_LLC_SDP], rem) {

NFC_ATTR_LLC_SDP is one NLA_NESTED attribute, and its nla_len is a
__u16, so the nested payload is at most 65531 bytes.

Each entry costs at least 8 bytes of nest and URI attribute headers plus
NLA_ALIGN(uri_len), and it produces a TLV of only uri_len + 3 bytes. With
uri_len = 251 that comes to about 64014 TLV bytes at most. The
LLCP_HEADER_SIZE, NFC_HEADER_SIZE, tx_headroom and tx_tailroom that
nfc_llcp_allocate_snl() adds are small for the in-tree drivers.

The path that does look able to wrap is the remote SDRES one:

nfc_llcp_recv_snl()
    nfc_llcp_build_sdres_tlv()   /* 4 bytes per 3-byte SDREQ TLV */
    nfc_llcp_send_snl_sdres(local, &llc_sdres_list, sdres_tlvs_len)
        nfc_llcp_allocate_snl()

A peer in NFC range can send one SNL PDU packed with 3-byte SDREQ TLVs
(type, len=1, tid). sdres_tlvs_len then grows to about 4/3 of the frame
size.

Neither nci_add_rx_data_frag() (via skb_cow_head()) nor
digital_recv_dep_data_gather() (via skb_copy_expand()) caps the
reassembled frame. An SNL PDU of about 49 KB would therefore wrap the old
u16 size and hit skb_over_panic() in nfc_llcp_send_snl_sdres().

The code change fixes both senders, since they share
nfc_llcp_allocate_snl(). Could the commit message describe the SDRES path
that an unprivileged remote peer can trigger, instead of the
GENL_ADMIN_PERM netlink path? As written, it reads as if the bug needs
CAP_NET_ADMIN to trigger.

> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 80a00938c8696..0a3d66e6cd59f 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -542,7 +542,7 @@ static struct sk_buff *nfc_llcp_allocate_snl(struct nfc_llcp_local *local,
>  {
>  	struct sk_buff *skb;
>  	struct nfc_dev *dev;
> -	u16 size = 0;
> +	size_t size = 0;

[Severity: High]

This is a pre-existing issue, but now that size no longer wraps, does
nfc_llcp_recv_snl() leak the llc_sdres_list entries when alloc_skb() fails
here?

nfc_llcp_send_snl_sdres() returns before the loop that frees the entries:

net/nfc/llcp_commands.c:nfc_llcp_send_snl_sdres() {
	skb = nfc_llcp_allocate_snl(local, tlvs_len);
	if (IS_ERR(skb))
		return PTR_ERR(skb);

	hlist_for_each_entry_safe(sdp, n, tlv_list, node) {
		skb_put_data(skb, sdp->tlv, sdp->tlv_len);

		hlist_del(&sdp->node);

		nfc_llcp_free_sdp_tlv(sdp);
	}
    ...
}

nfc_llcp_recv_snl() ignores the return value, and the list head is on its
stack:

net/nfc/llcp_core.c:nfc_llcp_recv_snl() {
	HLIST_HEAD(llc_sdres_list);
    ...
	if (!hlist_empty(&llc_sdres_list))
		nfc_llcp_send_snl_sdres(local, &llc_sdres_list, sdres_tlvs_len);
}

Each SDREQ TLV from the peer leaves behind a struct nfc_llcp_sdp_tlv and
its 4-byte tlv buffer. That is about 72 bytes for every 3 bytes on the
wire.

Before this change, a frame that needed more than 64 KiB wrapped size and
panicked. Now alloc_skb() gets the full size, about 4/3 of the frame.

That allocation can fail for costly orders under fragmentation. It always
fails once the request is above MAX_PAGE_ORDER: on x86-64 with 4 KiB
pages, that is an SDRES over 4 MiB, from an SNL PDU of about 3 MiB.

Frame reassembly has no cap, so one such frame would leak around 1M
entries, roughly 72 MB. Repeated frames could drive the system to OOM.

The same leak happens when local->dev is NULL and nfc_llcp_allocate_snl()
returns -ENODEV.

Should the tlv_list entries be freed on this error path, either in
nfc_llcp_send_snl_sdres() or in its caller?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111095907.3366028-1-xiaolinkui%40126.com
