Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027963;
	b=eScsJAWZskLUAAJQOjKVIRTHFdDflIJCE/4ejmyYNfDwsHLR3mVNxlhw/RANfe4jHau1
	 9AELcotH4CkOIK/HK8XhdBc60Omw8Or7F3Fp90Rl2p4fR6c4O8CyU3oSEGQVYbc3Hq/hS
	 k/htoTlNESNrTN4nSwUt0FlGczxTGQQdd7EJMhv7yqv6X3XoKDyqmX5jGehtGQUB+pA3K
	 +/xgep41YNETtl0cWBAXBNmrdUffiJCDDX/l0idZLMx072xgcr3fyn3aD5Vj+mkZAIt3w
	 MtMEOkJMcZkIb3OkZWFxU3MMR/sfmWXBiHCU1ezCdqUzIAIIsMy+xklCVjlyk5osH8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iq7770+X68F0gI3cSr/iPyC45eaIdd4N3BvfHNRFTww=;
	b=iSFC43tBvqlVK+8H9mbKIvhD+07hknr942T4NxjHWmnq5CKgELoOST30LG5FIfMFcVJ5
	 1MdX+eFQhaDyvbPou1h3onfvUO8A8YspQ5Th7ohS6mgjQIVkQzjzMn4NJEFwKaLHoGO17
	 0q+k+MeOkjZ9f1ecLZ7PaCFX+vzV6huTFpiTidpAAE/LmnI1kp5u/0dnIfe84KaPiGeuf
	 W3FmjOqjSczcuDmz0KaCrMK1il2OiGiXz9yppbk/68Y3eekKoYq8TmAzJk6wwnDS3yGBX
	 4jOyZxduAD5zGJi3Uqc+Ufzwym2WV812jAWVzVtaTFUYJgq4tUggVR4xt1TdT4G2u9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jJhlE/3S";
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0631606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0631606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJhlE/3S
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafb65e163so2083674e0c.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793027962; x=1793632762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iq7770+X68F0gI3cSr/iPyC45eaIdd4N3BvfHNRFTww=;
        b=jJhlE/3SRPxdUI5bWwiIdWWTM1QZ7x3YLaHxNFtK7R+6tNfG495pNFm4JE4O45hgaV
         IY7blEDXzgAFOyuoE9jDE1X4CXTjekDlIt3ZOQS57RrB5mdGDgLtFzVSFwP41UKIWZOe
         DOBkcMu/zSF3wOsC8ACNWovbo4aRF9vbnVvOA/1w4ajXLg20iko+lnRzmL2F7D/8EBG1
         fjIvDBnF8w6NDpDnq8H8fwC6zrmiBq1MjaBi8aV+ZwSk8Oduz40SgohDOXvH/R77Zn5+
         QfRviSEr0o1eTETwzPriO9GDeZsa3j5t6yAWfPsxHwa2DEPoArWNtYlP4/6HmPl9nCSS
         2fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027962; x=1793632762;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iq7770+X68F0gI3cSr/iPyC45eaIdd4N3BvfHNRFTww=;
        b=GO6vids+9yxgE/qTaRICCxs8hq2pqFyugbO/w0TSAov4o6rxtJXJp0zPWuwngJvOGt
         0IQM9abh+G6aQdq2UHBODBncjPSylFlzRmUOzY66OwZ0AJYU9j4Sj28N+P4OlpxQkDlq
         sLQMoLLbPLbWBLTBwkBcWT2UlCPKXwvyEa5ZlrzdmTP4YxR4A8XP0Y9qCcOo0ieTeTML
         Qk05Xpam0LY2QdPHVQJO2kO/9JggNTfAonFNhBMJx7quC5qENfV2pRjjfljSkwNQKRqU
         lZE6QLDN3bMeZ6+OrDb/HB3KlFlvjQNRKnczTkj7BTogxtFbwkzFSEnsajFipcuWf7ZX
         FN6Q==
X-Forwarded-Encrypted: i=1; AKwUvBz6wyTI3W+pam9wRBeoBO/yQSXVsN583HO/WxLsrxlKAC8dURz0TURcbOPTt1SYiedfV6y0NpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxiP7ixv2afdC6yl1iqPQY4kwthkJVHrTlVQ1FyJh4id41C7LF
	SBrTOmF/nLYWKIvtP9XW6bPXdLtK574udvsdwTNVc+XRkYsSo4Jt6DTH
X-Gm-Gg: AYBFou3ekdijnuqZ3ch5HHxvJfuRLM/1tX3+nlFTBPgEkvx6L+OyY5CmyZzSOcaUDZ0
	eXhidRxDba7zJUba1vF7MTYj/64pdgMs7pgAU0xzsDFSbczoYNxGEhOe9DHF1rYKLDRxMgqgjEo
	PkgRbp3H/9dKeuZJG02SBHvKAM/1oal3tINERpVpjTmg4MWx62yup/+GCamdemnUzELMcPFMTE/
	tue4Nk68VQBVo0fCLDlb8nqUp8wa/pDE87IcsULkMPLpjFVNsm5hRXldnOcZO1qBk4IfRjBcXSV
	UnwJDU940yzZB1fQ14SyBKiDdI0LEIkHaqz3SpvwqQ3A72SDw4tmCPLekiQrAMUVYee8LC5Oq4U
	ILXXAc4EpcNL3+R4+q2ZIXdKOWhfOTiA1/rnLmP5nKwGlNKc7snKyZ4CtQHnZYxAxH+bz7E43S4
	U8CeuKo2eAE7uphmYJfwrYbH0HYh0F6Ho4395yJYtQbEUU4JZ8F00C0gtCCq3lY3rxYCAPeVhn7
	PhxVpvM8hS5pGknFB1cE6h7JIoVTYTgjUIdVhB2yN6N9x7u6iMHPLkH7LpnULmzLj5zvKEqlJUh
	8u6hB4x4NAaM9DB50eGYJ9YbtWWUrV+OXvXaWXi2blMsq+Te6bpnvFagwZaKyRJoNQuKYBIUADU
	L7pAfTA/4W5niYewEGQo=
X-Received: by 2002:a05:6122:3a03:b0:5ea:d18e:dca5 with SMTP id 71dfb90a1353d-5ec232b3397mr2666051e0c.16.1793027961259;
        Mon, 26 Oct 2026 08:19:21 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7fbf61sm8607427241.9.2026.10.26.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:19:20 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:19:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?5bmz5LmL?= <treebacker@foxmail.com>, 
 Greg KH <greg@kroah.com>, 
 netdev <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 Ahern <dsahern@kernel.org>, 
 stable <stable@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.491fe86e17fa@gmail.com>
In-Reply-To: <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
References: <tencent_B58BAE2F5FF485D1B4F652E9980EAB132A09@qq.com>
 <2026102604-circus-juvenile-c521@gregkh>
 <tencent_7454E65EE7BD1C085B6951A7D2305157370A@qq.com>
 <2026102658-jockey-volley-94ff@gregkh>
 <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
Subject: Re: [PATCH net] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E5=B9=B3=E4=B9=8B wrote:
> The second half of the MTU guard in __ip6_append_data() has been dead
> code since the initial git import:
> =

> 	if (mtu <=3D fragheaderlen ||
> 	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct fr=
ag_hdr))
> 		goto emsgsize;
> =

> (x & ~7) is unsigned and >=3D 0, and fragheaderlen is at least
> sizeof(struct ipv6hdr) =3D 40 > sizeof(struct frag_hdr) =3D 8, so the
> second condition can never be true.  Commit 5e34af4142ff ("net: ipv6:
> fix skb_over_panic in __ip6_append_data") tightened the first half
> (mtu =3D=3D fragheaderlen) but left the dead second half in place.
> =

> For mtu - fragheaderlen in [1,7], (x & ~7) =3D=3D 0, so
> =

> 	maxfraglen =3D ((mtu - fragheaderlen) & ~7) + fragheaderlen - 8
> =

> underflows below fragheaderlen.  Every later bound computed as
> maxfraglen - fragheaderlen then wraps to 0xfffffff8, in particular the
> datalen clamp inside the fragment loop, which never fires and lets
> fraglen =3D datalen + fragheaderlen escape the MTU constraint.
> =

> With MSG_MORE on an egress device without NETIF_F_SG, alloclen =3D mtu
> while skb_put() is called with the unclamped fraglen, so a single
> sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg and
> IPV6_MTU =3D fragheaderlen + 1 triggers:
> =

>   skbuff: skb_over_panic: len:61280 put:61280 ...
> [   37.607856] kernel BUG at net/core/skbuff.c:214!
> [   37.607865] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> ...
> [   37.616606] Call trace:
> [   37.616606]  skb_panic+0x5c/0x60 (P)
> [   37.616778]  skb_put+0x9c/0xa8
> [   37.616952]  __ip6_append_data+0xf80/0x1948
> [   37.617172]  ip6_append_data+0x94/0x2a8
> [   37.617363]  rawv6_sendmsg+0x588/0x988
> [   37.617716]  inet_sendmsg+0x4c/0xa8
> [   37.617891]  ____sys_sendmsg+0x268/0x308
> [   37.618105]  ___sys_sendmsg+0xb4/0x140
> [   37.618299]  __sys_sendmsg+0xa8/0x140
> =

> Replace the dead expression with a direct check of the payload space
> available in a fragment, which rejects mtu - fragheaderlen in [1,8].
> =

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Fixes: 6596a0229541 ("xfrm: fix MTU regression")

> Cc: stable@vger.kernel.org
> Signed-off-by: bo cao <treebacker@foxmail.com>
> ---
>  net/ipv6/ip6_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..7d4d4d45e207 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1500,7 +1500,7 @@ static int __ip6_append_data(struct sock *sk,
>  		     rt->rt6i_nfheader_len;
>  =

>  	if (mtu <=3D fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <=3D sizeof(struct f=
rag_hdr))
> +	    mtu - fragheaderlen <=3D sizeof(struct frag_hdr))
>  		goto emsgsize;


Correction: I thought a difference with ip6_fragment was benign and
this patch is still an improvement, but it seems that additionally
ensuring enough space for one octet of payload is mandatory:

+        if (mtu < fragheaderlen + sizeof(struct frag_hdr) + 8)
+            goto emsgsize;

See ip6_fragment:

        if (mtu < hlen + sizeof(struct frag_hdr) + 8)
                goto fail_toobig;
