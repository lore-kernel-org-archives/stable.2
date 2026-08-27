Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5426477991
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838295; cv=pass; b=iyqzjoqbAS7KJUMaEvjNNUfsmKFGE+noVQtMo54Gu5iV4sx6ACu4fRs5W7yuvTXfol3r7isHy8lfeH7Wd9b+UpsQ2Wum/Dwsac4X9qXKEaky+UtnmuNHAiyoOArG82pOSXCCUFd9GqCAwky4jjIzEr636cUV2D4L7Pfma39wWAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838295; c=relaxed/simple;
	bh=Mzu4lSA71TnUpIkFlRqeJimp6Rqi1HOQl6MU/Vy3sxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEl+ZG2N+2EDwuo0bVx7IWDrwlPJfP/YskyKdj4NlS/Q8BQ8yb1xlvY0UUh74GcoZCedLyLczqLp7iilbaEREowF2ngSPcwzQI0xwXCNZWdevZXULg5wXvn+m3LmCQVk9+RDBPmpNmgEJxS1750HRExxYYyZ3OGD60FOqlKM6rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpV24GdT; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpV24GdT"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52fa9c055b5so4420121cf.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787838289; cv=none;
        d=google.com; s=arc-20260327;
        b=gwDoOu/BSUoJVZ6hxYHs8vAaqyeni5TPFj7yHMATB5D0ry7jZvebOEQTPYCK/wI1lf
         vZDrWMV1RL0uDaYseITgCnIT4mpoIBB5v36yt3exWCkhi5lg7Xu+UelGfKRlzwWTdmD1
         QFeeVXMdUGbUT1pw1G/95sFpV3ltDQrsbpZb7YryQRN8NPw/4rGZFRTJl1PAqX+zjNqY
         +qHFg8h0gI365ipN2J8l/QY9gjOdYuso/wxi+IJ9BFnIkOTp+49qgpWt/Pl5mQbRX3es
         EHsTJb+TD044tCbnZXqhgCIBnXCkIb8VGTn+VR4H4FOAocPhGwHm9Ukf12pFVoBaBy/L
         roww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        fh=RsP867qwuLq/g04AWMczulEh1C8NWUvqkjIN1aY/L7g=;
        b=fgShrcxQ8u7e2eaPeUnzi8ovuv20wUfg+vxTaeubKmHCWtOlIV/RvmEd+7TmADLDgH
         4qWK0Lo19FotXhSfZ2uQSBwI8K0ywUTb5FtE6Orf6TST85ywSbuZRMDeZZtz+byQ8t3Y
         cJ7mH/okeEDXYmFG6KGiHo72O04MbQiPnWS6L7l4lIY+0wmuBXdJXHCe6MmgfUmSZkwT
         M2qn6+m9Bo2gtyYji9b16rFjJTT+4dkM54407Afm0MSNk7Q2H4G9hta2msJzbdamX0r7
         fbSOkCPW+NYhZdBfy6Cs8d7gE33gIfvONFk1rKavtfE0OebyNz6Ml8rjCMVocpbLVtac
         c+rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787838289; x=1788443089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        b=bpV24GdTMFBEm6u82o+JoRDDkfAlcFUN4HBmtPkCRmU2qQrPiEKqf1ct3XU5w1TVsI
         6aA9pwgm0sV7SlYAmWfovTRchDMJVO9F/ea6o989B1wZzoDJ0bhPCBTsy6PKm3P/QaJD
         QomcPu+ygzVVzi37+KYo9S0cASPmYbVL1uUoJmvB/1VyV2oYcj8ZnBx5a7jtEqgkklyJ
         wXIbKGjP0124LsLVtoTIXnxzq0kse3a4Mtk6g2ANjSdR4KXdr3cwVb5/55GGOnapdtco
         MvynFb2gv0qbfIi847uq7EtJoMI2SEixevEZrYFtyAvR1Xegz4RoDRKnOlOEvj6HdK4h
         e1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838289; x=1788443089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        b=kpbboMppH4iTdxNqoOe3mQXxwztzvWPLEYSj+/aKXvfaagxYrO83rYj40gQA+wyTP1
         +qpO4Fj49qJQrMX0085l2QWZS5hARx35tjXrfp1YYn1hG1TD1y6sef+6tOUY64Ptl76c
         eQslS4BOtAj4/RMJYeIpZD3LWGu5d87VwvZwORNvEXslVA7J+KnwODqAPQSnTVrKMZta
         xMrlv/VEQTxH05ptqQ9xQu+cW5a1skRBIRyfALU2/4frMCkVHvaYBxdYW9es838krXIo
         uGMjlx7I4H8UjXp7G2p4BDB/RHiymasZQwtYbOaLe4BSilD17SVoj2ZtMJMCpX2ochJE
         51Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rpwv8ROcV+7/YJqpR56Zc9sitzr3DHqe4D8btI9sMb5QuaWoOXApeHw5ytFF/LNbTSgV76Uerw=@vger.kernel.org
X-Gm-Message-State: AFuF++lE8C7EPRfiBus7aGzT6B+BdMHRzFVgszdaQazVXX+Vvyg1f+6F
	E06dzL/qLc6G5t8psQFHn21W4knn7pJsyOYR9rmKS5y21+pniRPItNBWOtkfnlAEzS9G+3qV4Nm
	vpJAiGFzgEEboEtiKwVklC6Jrv8TSwedcKgUtfCgY
X-Gm-Gg: AR+sD11fJWgK1orBcMUn0KWXiMs5Zoy06iQlDMAKWzekwklTjQlmR+hz7RIJsCf/v5X
	+HCeGW26KHcUsBW+dFUYE1cQSk9Zs13Rjxv2etSv9aR057rgYgdDsKAEskgcIhJfAJLJVPNzrOa
	DOFBD1KCv0/pdoT08llHC4+1Gf2bAkE+jn4LKFmEL5VQEiGNR1OZBuVuzYeUKmLAUULL9kWSAt8
	xZW69WAz0vMIpEDEhL2G1pWwxEou/zO4ALTVSyisuxK4GcxnnRkUm7yIA8VqfruBFpo+8Ehv/q5
	qBt/2n3p2TCbKmFwHPaQqbXvJhkpnPLq0SnHktiUgrLst1F96phmzDC9h5HAHk7DDbu3Y8oOJVc
	zwnV3vYLsiqu5G+mC4LoKGEKytBzYLxv3Yuf540l5wMN/tW46wtv1gU8owCa5820IRIRiiQ==
X-Received: by 2002:a05:622a:1aa9:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52fa1def2bamr71264701cf.22.1787838287984; Thu, 27 Aug 2026
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827132820.11815-1-2045gemini@gmail.com>
In-Reply-To: <20260827132820.11815-1-2045gemini@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 15:44:36 +0200
X-Gm-Features: AcwNN1VTeP4O74Z9FZNjuIihE6nD92fIGVkcW9WBbJsfoH-8owf1Wfnzar0YN5c
Message-ID: <CANn89iL_6foOEX5_bhDq5i9yXBFMyeyPy=uZHSxhsw8q_71B4g@mail.gmail.com>
Subject: Re: [PATCH net] net: gso: always scan dodgy frag_list for linear heads
To: Guidong Han <2045gemini@gmail.com>, Xinyang Ge <xinyang@anthropic.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Shmulik Ladkani <shmulik@metanetworks.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Cen Zhang <zzzccc427@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:28=E2=80=AFPM Guidong Han <2045gemini@gmail.com> =
wrote:
>
> skb_segment() moves frag_list data into the segments either by sharing
> page frags (zero-copy, requires the source memory to be page backed)
> or by copying. Sharing into a linear kmalloc head is invalid, so for
> SKB_GSO_DODGY skbs (untrusted GSO metadata, e.g. from a virtio net
> header supplied by a VM guest or an AF_PACKET/TUN user) the frag_list
> gets a defensive scan: if any member has a linear head without
> head_frag set, NETIF_F_SG is cleared to force the copying fallback.
> Without it, segmentation dies at BUG_ON(!list_skb->head_frag).
>
> The scan is skipped when mss =3D=3D skb_headlen(head_skb), on the
> assumption that the frag_list members then terminate on exact mss
> boundaries, so segments never cut into the middle of a member and
> page sharing stays safe. That assumption comes from GRO-built lists,
> where every member holds exactly one received segment. It does not
> hold in general: the first segment also contains head_skb's paged
> frags, so even with mss =3D=3D skb_headlen(head_skb) a frag_list member
> need not start on an mss boundary.
>
> Such a layout is reachable from a guest: it sends two IPv4 fragments
> through virtio-net, the first with a forged gso_size equal to the
> reassembled linear head length, and conntrack defrag appends the
> second, kmalloc-backed fragment to the frag_list. Forwarding then
> forces software GSO (gso_size > egress MTU, or the egress lacks
> NETIF_F_FRAGLIST) and panics the host: an unprivileged guest can take
> down the host and all co-located VMs. The same layout is reachable
> from host userspace via AF_PACKET PACKET_VNET_HDR or TUN with
> IFF_VNET_HDR, given any conntrack user.
>
> Drop the mss !=3D skb_headlen(head_skb) test so the scan runs for all
> dodgy frag_list skbs.
>
> Fixes: 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_=
size mangled skb having linear-headed frag_list")
> Cc: stable@vger.kernel.org
> Co-developed-by: Cen Zhang <zzzccc427@gmail.com>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Signed-off-by: Guidong Han <2045gemini@gmail.com>
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ba3dbac80fb4..e97b27ec13fd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4796,7 +4796,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_sk=
b,
>         int nfrags, pos;
>
>         if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
> -           mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(head_skb)) {
> +           mss !=3D GSO_BY_FRAGS) {
>                 struct sk_buff *check_skb;
>
>                 for (check_skb =3D list_skb; check_skb; check_skb =3D che=
ck_skb->next) {
> @@ -4804,11 +4804,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>                                 /* gso_size is untrusted, and we have a f=
rag_list with
>                                  * a linear non head_frag item.
>                                  *
> -                                * If head_skb's headlen does not fit req=
uested gso_size,
> -                                * it means that the frag_list members do=
 NOT terminate
> -                                * on exact gso_size boundaries. Hence we=
 cannot perform
> -                                * skb_frag_t page sharing. Therefore we =
must fallback to
> -                                * copying the frag_list skbs; we do so b=
y disabling SG.
> +                                * The frag_list members cannot be truste=
d to terminate
> +                                * on exact gso_size boundaries: head_skb=
's paged frags
> +                                * take part in the first segment, so eve=
n
> +                                * mss =3D=3D skb_headlen(head_skb) does =
not guarantee the
> +                                * alignment. Hence we cannot perform skb=
_frag_t page
> +                                * sharing. Therefore we must fallback to=
 copying the
> +                                * frag_list skbs; we do so by disabling =
SG.
>                                  */
>                                 features &=3D ~NETIF_F_SG;
>                                 break;

This is not enough.

We have a better fix coming from Xinyang Ge soon.

pw-bot: rejected

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index fc0cb993959f9b6506063a4118078abde12521d9..c17e57ec7d5cdb6aac4b26777ab=
96254940b1945
100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -435,6 +435,13 @@ int inet_frag_queue_insert(struct inet_frag_queue
*q, struct sk_buff *skb,
 {
        struct sk_buff *last =3D q->fragments_tail;

+       /* An IP fragment is never a GSO packet, but an untrusted source
+        * (virtio_net_hdr) may have attached GSO metadata to it. Do not le=
t
+        * that reach the reassembled skb, whose head keeps the first
+        * fragment's shinfo and whose frag_list is not GRO-shaped.
+        */
+       skb_gso_reset(skb);
+
        /* RFC5722, Section 4, amended by Errata ID : 3089
         *                          When reassembling an IPv6 datagram, if
         *   one or more its constituent fragments is determined to be an
