Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607356;
	b=DFOf7pY3qcD+WuAv7VvRpWIoGYQAK+DpSeESGKbR45KVtvSmIp+13EjTzgmTVezwHRg8
	 DMxW2ZCbZQAAIkv3sO8VlHcgFRSc2h7iRDR+uClhia+xR1PhhXANSMStB08fj7jmGlYN8
	 Y6R+wNGxdMdNbMhCRseZomtoLVGOy6R//qFYIc8ug/9cjkf12KaHxl8j3fM9u8KqqJwzO
	 7DMKfHEKXm8LBXs2TR6ggD9xAtGLKJInQ12ey5k70jDZ6O4Oa4hGJaES/mgIBYp3dBmrZ
	 MJ4MtVvWn5xCLSvHK4BLfOgEj0L3aNgOuy4wLX7am7mRjZx75M6VBzTM1jYuQrOIvMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607356;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ggVpSG/Q2EbzVO8MsL3OxAqR882doyE1OLiyat9CU3Q=;
	b=dCcDDl2mS2HvmJjHPOU1ZYH8mOaVvUmzMqH2lyRxOtjr15+ICGvAwBZ1/6BchqC3tCd+
	 xsVXM8Rl2KkwOfFvO4RUROy3kPDINm2m/i8ijaGdqEMyuXb+GUtwCjYLo5sUk8UNqMT0h
	 cdfR/jUO5/fXqJ7zKUuwZ4DFLH/gZMS7avNxkzX/mwOS5367M7mlUUO+p3uPmk5MmiQn2
	 zv6OVetC2+LXjPv8LmZiCOVvxTK20WIEpq0RoPGPKnmxKeI8Sap9CJ8rLZbcm/k3mg8dR
	 KmOutgcELb/nh3fed8JqO99DN6s86BBmGoMb5RYVfkEFHcxdZqL1UIoxysARro+Ze2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dooHytXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A725606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dooHytXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192021F00A1F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607356;
	bh=ggVpSG/Q2EbzVO8MsL3OxAqR882doyE1OLiyat9CU3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dooHytXaEmX5IvBrV6UTjQdMy8W56tpSkMndQrRdEvjEH5heTpQih4Uo/9f4PXxAZ
	 mVIRZVdXV0I7idNNg3K/SRuYyrUu/Y0UW8GAi0jQQZZc3Cp+96/3lWSpWu125Lfv9v
	 J3nzq/NxtEAgt4nYml95Se2JHyrQm6Gu0021Z9hGUxURoiIbDTllDvROjgcWcpSsLQ
	 71XTl9lTp0TlgnHuiTEIjc/T55hPXYF/U42yWk8NaXEW/8xZaale1pn8Z2UpWjp1la
	 ALOUrZQPh8nuhq7zc6CIUxSyVoKs7gIhlR8eeTrLiNQyUAYiP2TJ6Uh8X02CeGa1nt
	 HO5sM4udYbhhg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6e560e00a86so1918569eaf.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 00:15:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByOePL4Zc6BbzKb4Q7Z44nx8jCH+WrrtbGZJ8N6Jt8KV1YhZKlNToQOeHxdtJqUYznpQwv7/5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+NIWNa8tBZzBPRIwCp9WOrYt5YfiPs1VqFTaisrUDHRieNvkM
	8VK6SyjDjou2QYL3o8Vf2+ArwQ25J0cONAP5FPd01etSytN9mFNUjAcAGkCTpo7D64dKWa6qvWt
	G8Zw3so06jeMmdVPSrrW3/gXo6Qr5XbI=
X-Received: by 2002:a05:6820:1504:b0:713:de09:427c with SMTP id
 006d021491bc7-714f254b5bbmr5208069eaf.60.1793607355409; Mon, 02 Nov 2026
 00:15:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101075145.698399-1-sgzhang@google.com> <audwphXNeZhVItS0@google.com>
 <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
In-Reply-To: <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 09:15:43 +0100
X-Gmail-Original-Message-ID: <CAL4WiioN5-eu3DExHHs75BaK77j+aR3CNr+9p11CRQDd4gpXhg@mail.gmail.com>
X-Gm-Features: AclHuK8YH8kivFCcxwhh3LmuTY3n9bSMVGRi64ndTBUddMQAOZY_6fQD74nptxU
Message-ID: <CAL4WiioN5-eu3DExHHs75BaK77j+aR3CNr+9p11CRQDd4gpXhg@mail.gmail.com>
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
To: Ray Zhang <sgzhang@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 06:35, Ray Zhang <sgzhang@google.com> a =C3=A9cr=
it :
>
> On Sun, Nov 1, 2026 at 9:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Sun, 01 Nov 2026 00:51:45 -0700, Ray Zhang wrote:
> > > Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 50=
0")
> > > on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=3Dy, HZ=3D1000, LATENCY_W=
ARN)
> >
> > I guess you tested it on 6.18, but note that CONFIG_PREEMPT_NONE
> > is no longer selectable on arm64 since 7dadeaa6e851.
>
> Right, we hit and tested this on 6.18 -- thanks for pointing out
> 7dadeaa6e851 and for the review!
>
> On mainline, cond_resched() in __release_sock() still applies to
> !ARCH_HAS_PREEMPT_LAZY configs (e.g. CONFIG_PREEMPT_VOLUNTARY on
> 32-bit arm/mips/sparc, or CONFIG_PREEMPT_NONE with ARCH_NO_PREEMPT),
> and landing it in net lets 6.18.y stable backport it cleanly.

SGTM, thanks!

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
