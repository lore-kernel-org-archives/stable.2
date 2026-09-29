Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5097538D8B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695736; cv=none; b=piMfykFzbquNaBduLDB2FpfdIMI5JGA76Y0BK/6GuKHeW3AnYRVAwbWwEnMO3f89R9ksZjOTYYzr5SEiUhSQnHIVIzjARF/6d6HPh+U4E7QmgMSxEqIb3imI7X6o+tBu3ZnLN735Sjfxefa7PhmDHb4Vww+v++3J1/6KK+wp3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695736; c=relaxed/simple;
	bh=5I+PG1LJwpZfrorxHQ6vHavEcbMCTKjy9jPyw9xe4Vc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nz5eLuzvc7KW6piHb7VIirXvVYpaAobpNBwVnjUFJbFTtbHAllB92dnTtuqISLilg1Ogcy3rV3HlcoAnycV5YTQb1KnGwkW2Yeq5DJ6i/nN+dR5P8O4OTYZlTm6NFZDGDGp2TVftzLuaPM30hmoyHCpt0mYWA6A1DJqeo0N0uzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4VnoWOc; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4VnoWOc"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so9581977b3.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695729; x=1791300529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hwlExALEuIqma+phYwZ53l5lEw6aiZrSHMRC6Erf8OA=;
        b=W4VnoWOcHwdnGGvzV85AVV6fisuTNHcLwQOmz0zjjM4q3vSQLALNqOCC+5rl/84ZJJ
         rdcL+qwFz7Fqd05uQMEbV+JeFk5V5FMIOIUQO7SUVFUi8qNwbLiswpG+ghM9VaeKoM0z
         4MxMzq41lsEinlTFoLVPKBiEY1MQW5liMBpzFX6KhJ+BeDThpDr9QBSkbqS4jC1GgC4x
         Xdz2qCOWwZC5soJfJ5wcrmx40WAJAJXSpplGYUXT031ixBlFssATn/1vZPzz7yMYJhge
         7gIxdytnpxALkHbOmyUQDl3FQxoWbgkd69oc7z3CKdYpU2oMhIYpJqjpzZFHRtf+pu9w
         R3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695729; x=1791300529;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwlExALEuIqma+phYwZ53l5lEw6aiZrSHMRC6Erf8OA=;
        b=qrgu1z3hfSoOFKPKDH0wMSgOU3qOYhIYjQoeiAwtH7matpOKPBEC+GcEKBuWK1sHL9
         odq+z5dqvXldLPYl5KtuiivBQrHcXceui7NpUM28pEIm2V5i4bHCfWVG4B7fUM4ZaLct
         mMWoUN3Bo11LwCYK1T4H/cLz4GllWXcxYBb1skIn3Kj/sSIo1S6b7AM83fPF7s3sRyNf
         xyZ+04yb562Vf8ky8HFJt36bZwpwtCqDD73IhIN1Quw+9C86N6WLqbolPP67Lg45dMho
         olX7X7sTbwsUFRHTshvM76iifgQX6rKibbsluRaEgkAuW1L096SPuxnQ0SmMFRjAQp90
         yB0Q==
X-Gm-Message-State: AFq9FYKjguiQohLaDzD332iHcb/UGPy76HgQoHNVDSgi3WeHFKT0qH7w
	J/1L40WzKQbBpxksw4qbYDMai2ITNVMoG19md9UzA+FYlZxwP54g6AaC
X-Gm-Gg: AYBFou3+/SZ2lfNXqqdqXEnnGWK7uZ/ysOl/jiVDTYdbJocXgjIu0ZFwo+CPBi2RrMQ
	7OnIf5xNI5OkTQGahIM8B/zyZ+/TsjwGZudo3RS5xIqMe3lkHNcqL1Az4QHeWSUGkp2REiFJN/6
	yxYjCWKef0KMxTJ6ZVbxn219z4DK7TWfytAGTsjcQp8keYwwdxmaPNsmkLaxS9d5tim/VIVM/Lm
	r36x0fs1vWkp465gNYjlIMFdMf4a/G9JGRMJX/4OPU73hdLSJhOm289IGSt0mbF5NIlW70Ftv83
	LM6A6Ss2VRAEzwxDvwkM+NqndNQQJoC9lbiGBn9jOIm24Jw9qYu6TeoaA9DLfgLFHmaXM+aoLmP
	YdSXO6WjW9hNZ7BGKIZnICu+JxAn1tPSiPM0PaaAQEgUMv83jvGr0OgDnXfngqNzdOWE8SCBs0Z
	OwUogPOASm2uPP/f2ATz9GcdEafCSvVo5/U1d+uyrbY16BLz898Nhhp00qkPa8b9w5mclC3BzKy
	kNLYZ9DdRUvNsIcQFLC/mRwbb5KYAsTh8DFOCuykZEw8ulG6vDW
X-Received: by 2002:a05:690c:e3c3:b0:868:505e:b96d with SMTP id 00721157ae682-8a64c3432b4mr71353467b3.2.1790695728518;
        Tue, 29 Sep 2026 08:28:48 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f9cdb0sm60998327b3.24.2026.09.29.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:28:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:28:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.20906a8caa141@gmail.com>
In-Reply-To: <20260929100256.23192-1-shiming.cheng@mediatek.com>
References: <20260929100256.23192-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH] net: gro: mark frag_list GRO packets as SKB_GSO_DODGY
 when a list element exceeds gso_size
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiming Cheng wrote:
> When RX LRO (or similar offload) is enabled, the TCP/IPv4 GRO path may
> aggregate traffic using frag_list. The resulting skb is later segmented=

> via the frag_list segmentation path (skb_segment_list()).
> =

> However, some drivers can hand GRO/LRO-aggregated frames to the stack
> where individual frag_list elements are already larger than skb_shinfo(=
p)
> ->gso_size (i.e., an element itself contains multiple MSS worth of
> payload) and may be non-linear (nr_frags > 0). This shape is not
> naturally produced by the software GRO aggregation logic for devices
> without LRO, and can lead to unexpected behavior in the frag_list
> segmentation path.

Did you observe this with a specific driver?

We don't want to have to support every crazy driver scheme. The right
approach may be to fix the driver.

To understand the geometry: the driver passes a GSO skb with frag_list,
where frag_list members may be any size, not just gso_size? I.e., these
do not conform to SKB_GSO_FRAGLIST rules?

I don't recall immediately what the acceptable behavior for regular
GSO skbs with frag_list is. But for starters such a driver should not
advertiserr SKB_GSO_FRAGLIST.

> =

> Detect this condition during frag_list aggregation and mark the
> aggregated packet as SKB_GSO_DODGY when a list element=E2=80=99s length=
 exceeds
> gso_size. This forces a more conservative segmentation/linearization
> behavior downstream and avoids relying on assumptions that do not hold
> for LRO-produced aggregates.
> =

> No change for normal software GRO aggregation: the new check only
> triggers when skb_shinfo(p)->gso_size is set and a frag_list element
> length exceeds that size.
> =

> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---
>  net/core/gro.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/net/core/gro.c b/net/core/gro.c
> index 29b4d02bf519..e70ecf19b0a7 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -259,6 +259,9 @@ int skb_gro_receive_list(struct sk_buff *p, struct =
sk_buff *skb)
>  	skb_shinfo(p)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;=

>  =

>  	NAPI_GRO_CB(skb)->same_flow =3D 1;
> +	/* frag_list element larger than gso_size (already coalesced before l=
ist-append) */
> +	if (skb_shinfo(p)->gso_size && skb->len > skb_shinfo(p)->gso_size)
> +		skb_shinfo(p)->gso_type |=3D SKB_GSO_DODGY;
>  =

>  	return 0;
>  }
> -- =

> 2.45.2
> =



