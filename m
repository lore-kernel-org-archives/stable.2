Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925429;
	b=BN/yfUjWJ/r6H1rfOn4gzTI05SiBFcKuxaosIhSAGa4rVsNJuiUKpdDcBiq/Dla0X4XS
	 quKj+0gwrxbE0kQf8qu7iZrdhKYYl3ylHI7XzfO4qp/IlnxJSQOBf0FFqRwfzjhrFwa6r
	 8BxMKCeJ1yN4zKSL1kAAKguPxLSOm+fS1lY0XphA7UW0VK66hh3PFyZoDnXtz1T1Ah9sR
	 1yZqgIIu+/laeTJo3iDb/tlkFRSnK0lO5IGLisZqC42pDEfXXqTMC5DuK69Nw2cEfxzzj
	 MVrUK8xhvy7h7bOl7ZTr2Pp7Gk65xDuG3n1yjfjwIVpdhIWkGzlkDjG02/DhHDPmJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925429;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z34xT/KTKRp/P6iMZZaSFLF0nWR84Andajbw0zEcAS8=;
	b=Tx5jtmv/8AA4GduFbWcgPWw5Kl6MFPli0v8mkt4GVmS0tTsebiO40gtcp8SBY4TiZQXP
	 SxTEnyBrVh8Uv4/6k8K2Ps6p7cdttoyrvuV6uMkbiUMgURdi9ftq7Nxa2x/BknMZksXV1
	 i7GGKEc5WDzlYPob8VhFtb3f2mvTzY9AxzKs05GsugncyMW55n2WtkBEWk2rogPTX5tkc
	 c8FDUU7Gp09MdCyyzvXsmlYSGojfmVQqHbsRQ7cXIv0hnSNebvsGVzFr/Lgwhmldfmb78
	 HApVr7h9HUMVUGo8Oos84+l6a7PR8j/r9ydpTpNzMPjboLtMvrFpCGZrOMqhahwP0vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzKbTqvG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C1606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzKbTqvG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FFA1F031E5
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925429;
	bh=Z34xT/KTKRp/P6iMZZaSFLF0nWR84Andajbw0zEcAS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HzKbTqvGw+J7Rt2H61H+MqpNBD2+7Ul6LiEHJyqZ2kG75cJqXupN1Tw7Hl7zKHzmb
	 gLUf8yohM6NfShS1CguT5aEmJtQV9C5pzlWZEyOz6Ja5/nUbHRoB09ysWuKilgJz1j
	 QZ7Tc5qNDWso3z69N9mgh8iWgulVTto1ZIMDuEFS78Wj5NGtiyzZL4ACQbpEcahaD4
	 GWfAEaiZE75qS1Ot2yUqDTRwsjP+0msUN6SQrOzSI5nu5ET6j4dFudT8XdewgTjIzT
	 XYlfFO6f3AVZZiQ1RIf3CPIKroaOReSI9gt6rjJcjr6U8b8SG2OtD+jAWZTc8ZFriL
	 D78kDF2Bmg8hw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-49e08af5fd4so835565fac.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBycbAfzXQ+4x1zChxKa8vUeJc+W0YQnogV58UiQWWD7mVuza8LMWXbGMomIa+8vkHpnFWDEbe4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL8qkl3no2MB3qdMFhUFovlebtl/XV/fWNeN5120gH4M3H+Hgk
	uUOneTbY4Yj0Ka36Ev3q+hkJ+rZzhFKwU6sb+jEz0+vhrQYtTAyLsrdL5mwPdhF7zxwiarRM6Et
	IZe+3NE8w0jFt5dawgYK5lesF1DOVLUE=
X-Received: by 2002:a05:6870:2c49:b0:491:520f:e6d0 with SMTP id
 586e51a60fabf-4a83f00d327mr2211468fac.4.1792925428140; Sun, 25 Oct 2026
 03:50:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025071729.34967-1-idosch@nvidia.com> <20261025071729.34967-2-idosch@nvidia.com>
In-Reply-To: <20261025071729.34967-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 11:50:17 +0100
X-Gmail-Original-Message-ID: <CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com>
X-Gm-Features: AclHuK-JgswlkfMhiZ2fs2aB1d2-JI9OOSyqjldUoMV99nSOE8B2ON7VxY1KuxE
Message-ID: <CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ipmr: fully initialize the synthetic IP header in ipmr_get_route()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	yoshfuji@linux-ipv6.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 08:18, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> For an unresolved multicast route query, ipmr_get_route() builds a
> synthetic IP header in the headroom obtained from
> skb_realloc_headroom(), which does not zero the memory it allocates.
> Only a few fields are initialized, leaving others as stale heap
> contents.
>
> ipmr_cache_report() copies this header into the IGMPMSG_NOCACHE report
> that is queued to the mroute socket, so a recvmsg() on that socket leaks
> the uninitialized bytes to user space: the 'tos' field [1] and the 'id'
> and 'frag_off' fields [2].
>
> Fix by zeroing the IP header before filling in the few fields that are
> used, so that the entire header is initialized, as in ip6mr_get_route().
>
> [1]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter
>  raw_recvmsg
>
> Uninit was stored to memory at:
>  ipmr_cache_report
>  ipmr_cache_unresolved
>  ipmr_get_route
>
> Uninit was created at:
>  pskb_expand_head
>  skb_realloc_headroom
>  ipmr_get_route
>
> Byte 1 of 28 is uninitialized
>
> [2]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter
>  raw_recvmsg
>
> Uninit was stored to memory at:
>  ipmr_cache_report
>  ipmr_cache_unresolved
>  ipmr_get_route
>
> Uninit was created at:
>  pskb_expand_head
>  skb_realloc_headroom
>  ipmr_get_route
>
> Bytes 4-7 of 28 are uninitialized
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee=
2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ipmr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index acacaae05cc4..eac23f251bfd 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2506,6 +2506,7 @@ int ipmr_get_route(struct net *net, struct sk_buff =
*skb,
>                 skb_push(skb2, sizeof(struct iphdr));
>                 skb_reset_network_header(skb2);
>                 iph =3D ip_hdr(skb2);
> +               memset(iph, 0, sizeof(*iph));
>                 iph->ihl =3D sizeof(struct iphdr) >> 2;
>                 iph->saddr =3D saddr;
>                 iph->daddr =3D daddr;

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

SGTM, I will send this follow up as a separate patch.

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index acacaae05cc49dc15910f23f7539865432518587..8b84142fd7754d95aa1f2facf68=
ac554916efd27
100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -550,6 +550,11 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff
*skb, struct net_device *dev)
        DEV_STATS_ADD(dev, tx_bytes, skb->len);
        DEV_STATS_INC(dev, tx_packets);

+       /* skb->cb[] holds qdisc/tc state at this point, not IPCB.
+        * ipmr_cache_report() reads it as IPCB to build IP_PKTINFO.
+        */
+       memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
        /* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
        ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
                          IGMPMSG_WHOLEPKT);
