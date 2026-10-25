Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925535;
	b=jacQcLrCsY/gidurQQchSjkzJ97VtytUufPV55U/sFX+mIuLeKb9RRfyiSd17xWnAA1d
	 LCl8Il/aCme+YF8QtZg4ojk0ttNsNBB3g+TcOjUN8bIoDN49oSQ+g2ddCSamXxlkMDnlT
	 KraEIVvNELG6IePpYgTLRWXn7B7zccai5ZvVdCK1Nkb/QLl7JOzm3Z/A2qlTSEyRekSug
	 z27lisdKuvC6zwJ1lc4/S9mKUtVtIy4Epa/rDghAJfRp2iPczKYRu3xYuS6SAoy8R6sQQ
	 lPH8zKRppYnsDc1NDqqoDyULMiThHcaJ6zrJJzvIkKfVbTsiPEQrxfNbIe7iGFqk8Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925535;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hPKSPo730DdMIk8vI3kNTPBHSLfjkeDsFQWYgCdWptQ=;
	b=EqpWsDVGFzQqhvejpQNF1AF7ZFigPcNgKrVOQzcTC5tPzj1qTVS6e2erpDQDISdxpCBO
	 xvkmZqd2ONs/oicT9WCEomv8D7A7KBUZX4i7DcGr8m/7ch9uRGfmciSV1gQR3S22xcJ6l
	 /1CXs2QK/WA7eshKIPRSEtw9Kwa7qI6J4r0RrgKR5Y56L2hZmS07bNTePFljUf7qBRCU+
	 lP6vPI5hmFTf9CFruMT75S4mUkSvJ9zGRd9fiJywV1tVLavvq3+08RaIvfMP3pg2Z/q40
	 X1Pfl4G5TXgBlVyyVrAMNBaifUSqM7aTKVid7eM12ue0s8Fjsk7QIwI4JpFJDtnxbpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoCjN7mY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F327606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoCjN7mY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAEB1F01825
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925534;
	bh=hPKSPo730DdMIk8vI3kNTPBHSLfjkeDsFQWYgCdWptQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AoCjN7mYl33hi24P5LWbL86/NhclCu4RS0pStpBPOewB+IwblOR4Tfr07z7dW76Gi
	 xZx+Qa9WBRdhNpcw3M9CiYn+AxieakIRIBl9fV960JABdzohScGn7OqPEuB7ldda1U
	 cQ+Ysb09EpV6g/PjdeLRBgU4myV7Zg5x+azXX3mcFJDY7Gwsx3JfHvKMs0/A/x3OES
	 NrO1kYBe7EQVtDhBzH0gfiaJORGR8QYHpdkChG2aBcyJc/gcLYBxXS8LXe8/Vu2pQj
	 Rb7ShKif6fvkcJYhqRAvzg7z20vBVPVwI+S577+z62M7lWmoXAzrValZStpLqEdkiX
	 GCDgWggYOM4Lg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a76f63b243so2310555fac.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:52:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByxF09+UDYfBdFpyp9sofokoP5+3l42/PQ/AMCwVx8I3WN/eVNO68CrhnjuJwBPurMOzwTh0pY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDo2/WRsstwR3jOS9iYtE54XgAuDyH6Q/ePKTuFQ6sHWAWA4Ij
	gOLjSzmCybau0iCG0yULrzPV3QEx48Ws4fmudoqVEopgUu/kOlJuEehYHH0LKhQxF5XjtYNtR/1
	aACeVVNz8jGCFQAboV7s4ajghud6Pqs0=
X-Received: by 2002:a05:6871:c91d:b0:45e:d645:e03d with SMTP id
 586e51a60fabf-4a83f4cf2bbmr1508221fac.11.1792925534172; Sun, 25 Oct 2026
 03:52:14 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025071729.34967-1-idosch@nvidia.com> <20261025071729.34967-3-idosch@nvidia.com>
In-Reply-To: <20261025071729.34967-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 11:52:03 +0100
X-Gmail-Original-Message-ID: <CAL4WiioCj01X+x=kmq4DAsusQGHSbUTi3ZZSrVNxX4dVHks_aw@mail.gmail.com>
X-Gm-Features: AclHuK-w_CWxZjTECE6jJnpscRA3B6CFD46erB9ilUpSlsm3V1pz5ChEGv915LU
Message-ID: <CAL4WiioCj01X+x=kmq4DAsusQGHSbUTi3ZZSrVNxX4dVHks_aw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipmr, ip6mr: validate packets injected into the
 register vif on xmit
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	yoshfuji@linux-ipv6.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 08:18, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> reg_vif_xmit() passes the packet to ipmr_cache_report() which copies its
> IP header into the IGMPMSG_WHOLEPKT report that is queued to the mroute
> socket. Nothing guarantees that the packet contains a full IP header, so
> when a short packet is injected on the register device (e.g., using
> AF_PACKET), the copy reads past the end of the packet and a recvmsg() on
> the mroute socket leaks the uninitialized bytes to user space [1].
>
> IPv6 has the same problem [2]. Its reg_vif_xmit() does call
> pskb_inet_may_pull(), but the helper keys off skb->protocol and does not
> pull anything when the protocol is neither IPv4 nor IPv6.
>
> Fix by dropping packets whose protocol does not match the address family
> of the register device or that do not contain a full network header.
>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
