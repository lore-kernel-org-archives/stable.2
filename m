Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DF39936B
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247324; cv=pass; b=byMUu+ig9izqsIlzddYjCWW30XbUivIBfBQ0eNE0W6+KB+jz7pdJ3Kd1C+FJO5exAgxSspw8X+KiWNedNpbiz+VPOphjiyq9Ctuztf90RgHlIURn1YP4z+sMvotsdAneps+AaiJyzqzo5duO0H0qmji8Ye7lWmax/iQY+ZM9Cc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247324; c=relaxed/simple;
	bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrrKsZ1OWCIYjU8gG7/9Qn6CHUUfVCZTjUD+o3h5pAKzFzJ9GPCaTDrJ4B4hkzisE2CTKyauX91WdODOcHY8XPaCmuzcN5UZ+2F9Qqq8zLtKT4XENUXuQd27NIvPKjr/Lc8IIiDYZDO3TWa+rP6quv031Lzt29osipzgPfS79M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F804j2R/; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F804j2R/"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13832028e9fso595809c88.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247322; cv=none;
        d=google.com; s=arc-20240605;
        b=Jg26zm2+8ulvAJhfAfMwhOHU+yscvwXywjFHWxmlbrdcABogFZoy6YQKNYB1GJkiQM
         ddrQSiB1Vre+nyo5N7/EZNfXVW6ao5oAVA9WvzMVfwmqqxgtNiOFHseknGy3Jz0e3bvU
         fJvEh6YCrm5obgCVI9HsqpVJlXt5tWKN7ContIbObqEldqcb9j3m6M8R8F6FHl8P3JZY
         6Qf4qM+f+C/zOvgmJIeXJaAOin6WPv9mrJs8Ubx9AAxWyA06fn+NoNP9iJDqlSQpJf5k
         UrguSlccT5bG75M5SgTncOKMiWUDhNCCNXe62SgsO1zD2uKfgtNU4DjJe3j4jE4BUWoI
         lCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        fh=I3sSnFtQ7gK1PNRg7fOEoAlO6Tk5p8hwlJG6u4uzbgg=;
        b=h8kCdu8LONPb82Kd2vmW9uz1cpk0RSdyrrfXFVzx9wgpAz9O7DD9igWuitC6yf83zI
         aF3/6KVyqV4DCIQ84omatzNSpVDCw+KNh1kMBpQgs1xFsUnTSpMLu6GXuTkj7P8cH067
         dv/Dow6Dbgnjwmbbub60C6S4Vjy5beyfmd4bebf+puueLV7OgYiYV0L0shHjRlO2AVgd
         QQx6PkHZUQlZcH7jf88Khj2HBqnVg6z4PBOzYLKWs3AltRdsaBPJtVFsN//3wG3eSfxm
         B6TezmTVL/fu6e4oeBqcJPk+LT1MbHklrW+4sS58UkifzLxxf0ec/7qoYmsvoUbM5QoQ
         zITw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247322; x=1781852122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        b=F804j2R/0SRYv6zsT2GSsTGO/PxUPiDKURF9nd5dnOKyxT8lXKA+lfNg1TIdCl423r
         skflsC/JFiVO1K4StVXwmQEgv5AiU8oXvdJXT9jnraZse+KlS3KdUZYtsx/Al1ZYt0xZ
         mj/PWz3PwnCfiCMkTn4xxv8wkLCW+BTLrYCnZJ861R4EYHyIl7RuashU2EQpevBjymfV
         WUMP7nQEx9ZKntVW/4Z2F4o1bRACK+6Ots+0GkaR6Y/leJfc8sbPjaRDdaI4vVlGkTry
         WIL5Bx0NedYIeCOMtBh761ml2sjDiFScPNPNHJyjsBASnNi3YROBmbrQQS3s7Vj1XJdz
         uf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247322; x=1781852122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        b=KaoJKdVQ1+9WZ8+am4iYAWZIH3JWJvuVZhJCHhyCYOq0n3CDmPQjrAP/anAoJugzA9
         1sB3tC2R2sKrtEQI27mNg57YzyZA37H/jeMZbjPfQ+/QvBR3CS54Z1XiNcocnPAKs8BI
         GM08Aw9tfZNvPY8ykNolpfvy7uy3GliJojuSiASfCrSLTwjR3/LT7yLIOSEud9X4nT6k
         1TMLEub3L03Q8RU/KCl2YRW4zCXw8Ed04k+9mLBoAMiXxt2UruiI6haoVSSwb6szR90K
         mz1ZsgrBMK13/2ichZGrUT+OZ+ir8OEja8t5aBjMaXrSbCTYA7LY9ZztRKX78aGurpno
         Klqg==
X-Forwarded-Encrypted: i=1; AFNElJ8u+ja4KlNJSAK2dAxrkQNKqila2oaJL9ujmj2VnrADRCnglmpXcY5HVUbKByGk2VJ1x1LOWPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNpztmG0nULKFcOf6ZZWL+9b6/4UXGgMEzjNE30k8tf9W3vgL
	m0RdXGqlOLm8ab+3TiqkuRzHqOn+rHLFm0BJ44aNDsmQ8w05WCHWcOktXHpNgScXbVHMzcFS6UG
	nVNo61yMmYhDiALuOYU3x0RgZZK774grOG/jYk44v
X-Gm-Gg: Acq92OGVacgc2aHs5TtEvzq15vlCeD6m2UyzqBmCzsXfT6qMz1DDIR8t2uS/mvdEEA1
	Mw79Q2BeLx8jcahS/5dTQDO/jO+jAPAqYXhpZy8nh0K6NXjJzWpETYGRtPj4+9GJ9SCdTU4bjDp
	QyjUDqd4Y+uK3fd6eHy/LLlfibapgO1EaZsWLGNlpsQ2Ljp7ykj+RtiLjI5WlZiAwT6HT1wdBcd
	mu27BdUa3Y//LcxC5ATnTwDrytCcQoGQ3pjOQJdcl4VdrgCxU/lkNv2kvsmZYmcpExA6MilIt7z
	Sh7aqQYkWkPWWgNarAJ0j+tyIr5IY0EbGTY9/X28XM2tZSx2BhOMD+BpgfwNVi//UskLhgCa5G2
	qwold/8yzyos4L4b89SSn6a3afbKGOPSnV/S3VLk9HKHmwUq6e4pP
X-Received: by 2002:a05:7022:78d:b0:137:e45d:7c3e with SMTP id
 a92af1059eb24-1384bb85425mr663563c88.25.1781247321177; Thu, 11 Jun 2026
 23:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-5-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-5-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:55:08 -0700
X-Gm-Features: AVVi8CdJxHjAgBQ70gRf0u3EPOXvDk9NFYfa82XgAhsq5qFDc9YyaQfsZas8P9U
Message-ID: <CAAVpQUAJq3WEMPzn_rcjct8LO+KDtiCvFZ_0aLZ97PR5awZdaA@mail.gmail.com>
Subject: Re: [PATCH net v5 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")

Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
