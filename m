Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634836;
	b=UcFtIANbcq/jNjTdMLLcImixTIHkeckh6JfZjIkivRphWS+4kUQ/Nz81kwxuliYwEXzT
	 g+zVPwAc9Trf/aO42bV4MTn0p0jYX1KRKnk07Dg5LKX2dbyLvZRNmnP9YWdEoXQivsMSg
	 r6VKKSUnhaRo6g+we39egL/hL4ooo0a7y6u6JnqqlQgu3lwh+fiDDd8yDA7AJe8yGdRIX
	 wP8ed1CBRO+m7PX29Q+Nv1lSXOFX0raqk1EuUisIzZGL7293u9VfRxewJqE1p/Keueomw
	 wzDfwNeMhoF7lCJsOUGl9Y1gckf/kK2k23QALZg88P2OCAE4q6zGkNuDe7kg4hY51Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634836;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=772ZW7xwS5Lb6OoXbHUKU95CKNMFhT7w/NVTOJdJ/Iw=;
	b=UitXCEU4IVoAtoTqtslCSZJlfELyUuZlFuQflLq9hDYzx7d60ST7eDV9Mxs6q4cenIz9
	 qe69QTCm2dSiiTgqWlhbfY1PF6PerHCvAIdtuLuNsOigZYNQGyQ/r5dDh1t7WA3c7bAB9
	 k/lOZuG/Xsee0PLSftsuEz6YkZjPQVJsptC1y63N+GRce63GnN7SblXi4DnJ+2HJjDEHU
	 KZQ06yWy9Q13+CESh+WjydInZVbaeoZt5C0sXMZ/XCW6KWIGzdRB8+Jq4D0w8UJLG1yMq
	 oltzZItACOOjX1t+7I7NOarzgH1+C0U9dYLQ1nbqC53pHykTisHRUVmnSQJNzXdRnCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kWw/Ia+Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931A607B44E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWw/Ia+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70A31F00A24
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634835;
	bh=772ZW7xwS5Lb6OoXbHUKU95CKNMFhT7w/NVTOJdJ/Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kWw/Ia+QjBzhXnj5i8zWqJ7FJZCWcXqxeK6lp99YwbsXoRBZdVxV7Lm4RD9rVDjzI
	 YjDIEsgSi/dTSk7E18MHQk+ZXh8i6K59ZfzW8dNCSv8lVh0pqGPuWu1QsN6THQGdY/
	 FmM/xkCazevo7gxf4zKL1npDrSnNfypDsUytbOZt0ikdOHJJrVw0K6qdDdjJkt3i1y
	 9DEoIQo7Zg+FZdKHs22Tbmv+0MSWNGnzVFnXNyEF+wHOpAmo5rS3i38Zfj+E5ZZ0ME
	 EyTiRoTtAItHBuqrc4/FYw8hBLpkAPstO+gE8Ywe+n5XCmNLfTOzXv7m5FPe45+aF7
	 obbnVv88a8muQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6fe4372c5f3so2174213eaf.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxk4pGxxnsILAPjJqadwrfb0iXN8xVwDdnkC9z8dKrTkA0ryfY6oLzDTmLyKuGR35mHA9NCtUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT6N1l8dyZ2Edk2N2BAKJayOZwrgT115uXyb7DR/OIQAoZA5xV
	j5HTLDSRNSqj9qUQrGNoBxJXiVyujAEdPH3dofWLAYnnY3QOzwgLybgUA0QbV62ex1GZpVO4VeM
	Tz2gspUpNZey+bmoAPNY4hyHUTc0VNTE=
X-Received: by 2002:a05:6820:f033:b0:712:c751:22e4 with SMTP id
 006d021491bc7-714f29918demr6803097eaf.35.1793634834935; Mon, 02 Nov 2026
 07:53:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030081225.2575462-1-edumazet@kernel.org> <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
In-Reply-To: <24feda7d-ae49-45af-9596-2cc5f149f28e@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 16:53:44 +0100
X-Gmail-Original-Message-ID: <CAL4Wiio-LDx1Z4uWwmUmTP-Xs+Gt=gaM_9T054ZSdY=t3afQJw@mail.gmail.com>
X-Gm-Features: AclHuK_-XE5Vpi_c17l84qWtsRUvWrKeAkHo-16LCcc1h6-7Xgfi8MPFo7166qQ
Message-ID: <CAL4Wiio-LDx1Z4uWwmUmTP-Xs+Gt=gaM_9T054ZSdY=t3afQJw@mail.gmail.com>
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	netdev@vger.kernel.org, stable@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 16:04, Paolo Abeni <pabeni@redhat.com> a =C3=A9c=
rit :
>
> On 10/30/26 09:12, Eric Dumazet wrote:
> > The truesize of fragments in a reassembly queue is only bounded by
> > the per netns ipfrag_high_thresh sysctl, which has no upper limit.
> >
> > inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> > If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> > adjustment of the socket owning the reassembled skb can cancel its own
> > reference, leading to a use-after-free of this socket.
> >
> > This can be triggered from an unprivileged user/network namespace,
> > raising ipfrag_high_thresh and using padded TUN packets, which keep
> > a large truesize after being trimmed by ip_rcv_core().
>
> Clasiko infers a similar scenario is still reachable using multiple
> concurrent frag queues:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030081225.257546=
2-1-edumazet@kernel.org
>
> I'm unsure if that should be dealt with separately?!?

Sashiko is right that this is still reachable, but it's a pre-existing
issue and the consequence differs:
the charge per reassembly is now positive and below INT_MAX/2, so
__refcount_add() saturates (WARN + leaked socket)
instead of wrapping, and the UAF is gone.

I'd like to keep v2 as the minimal stable fix and send a separate
patch bounding the sk_wmem_alloc
charge in inet_frag_reasm_prepare() against the socket's sndbuf.

Thanks.
