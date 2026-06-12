Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6039936B
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247368; cv=pass; b=mR3kq0F5NiEofAN3KEOpVkqDIGLXuS5xHX8SOHHRfFjfYvDCHB0LjH/Nx/b4P7H8NbTMvpieXs7izUMzr21VcoL0wSD4Rak5h8i/BoBgVTXtyJdphoLeMo77P9CRfFSG7iP/Cx3TwaDW/HO81qTF+IiA5zkar4XexkzWmhYD2Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247368; c=relaxed/simple;
	bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFA6jvOqgsUAwIATpCnDBgQ7Ue269vx889VI2mj5B0QrQd7T+YYq8vtuNSZmrhHHSjehevk6N4O1eydoIrEA+4De0psVq2K9Dk32PnDWRobWc9aEi2obXRIIbLZ1mLnl04BkUpvf9DYaIFCbbCHda9d+SBAWMzUH6YCtdNq2hlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDnnLq66; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDnnLq66"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13807d2f898so726812c88.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247365; cv=none;
        d=google.com; s=arc-20240605;
        b=XsOXrCjwUnJHzjnLsEnfDzVqfGcqLE/eayvMLWLvHx29zXVb2tj6hawpXMp83r8BTF
         k0TK9jz3KcnpPZdKl3HeNA5HFAYPDL9ntVHDTIaPHBQDobSHNYuGp47dxW0sWtXpS11Q
         BF9s00bE8RJrHEqjht+S7axBxIJy5lB4pxMFU7asSmnR0DyioeeHYpjsUM33O2vwboV8
         xr+ox3Y+JqhlcHpfBZ1/NN4eOxuRyXuajMDzkVUrzATUG/ugKL+kJLndl9z/JOAeUNe/
         GIH9EUZolgaDjhLcfPeudBQm2XPK0TuvWAB9qzM0XK7gVoeaa194yKSDnh9GkfuJBk9S
         1J2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        fh=rjsNYrmaXFSXt/EtUwBLRXcxpsTXBxCTKmWLNwB70FA=;
        b=Tjx33jYvxaNqWpObN3ZQWAN+fJeA7lG6NG9hTpwW+P5asrvnqE0up+OjJtKtzIzIGy
         NLk8yhd+K+qrexd8byAyfF6UFglD+5MSW66dyqtSj8JaAxRcg4bgrx/Roq2jTAjCavNK
         ia8xwGnAQ4icERxwZV0RE5oKJ7PGt/38iehkcNxYnd6UH1PNNcocRBm7a4cvjfWbprRe
         vIDHve9UkHy4F29t0Ie97ILuOPOt7r2J+3EITGfHd8qW1xfutzjy3Z1F8oTTaQBKBc/f
         +lKBJPgqI2ExorIT5pwTr3PZIGloYB7FY9J0K8SBswkUNYrkF7YdiUV/APcsRK1tWX3U
         64uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247365; x=1781852165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=tDnnLq66U/7YriXO/p3hf0xPPUBvccDxaEvLMPzkHpgINh1BfVj8jd9tniKdCjQ00O
         bpHWoby/guzin1dGMSWfGjdqN9xcP7DUFcS7wMDaEuMPms6XTQ0fESFvGBr2GYHPDofX
         10/tBTgDBflQxktWRoBjSGOxXtFNLTx4zEeQFWD8x5e6UqbR1fOygVVWcFi9IjDBulh4
         hvYiRePGKLZoemC1huqsCRQv5551AkWyRH/b69I+XQbAMY1tWkgtfw5fQ+Y2BaRIgfTy
         TcEh+0dn3C76VLk0oDfr61KI8OkznPfPOM+JFJHavCoOj+K0YyAUxp18ewG0uguteNg3
         c2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247365; x=1781852165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=TsKwU/MPrGlU9f3dEvopmsmc0ms8De6RBMAm9OWhjF5c91zyKFtoWRCDfI39VPNhI+
         v71E/Ec6RQkD8Tdb4bAiEv72IaP6aYQF9P/EyIuCkbQz1WLVyGU4Bucneq17XfsCVhlJ
         y0kmQsNJ1o4q1V04vTQ+1R8p6N7mK5z9tD+wVQ7rqmY9buivDF+uIsc8KlYf8ZVslf4j
         +CXZFzLZDbMgysK8NrkB/6bRZ9i/Egp1mmjxgDLhf4V9MiHP+0PA3bZHDt1vd0rCalTf
         muhTRVS6XGmO9bVUBhk/oK7UsyqPnOhGaeMneAceQ77dGncBNaDldE68o5R/+CQV2xDT
         rM9g==
X-Forwarded-Encrypted: i=1; AFNElJ9AS+fA0XirSV11yZPyafMLb7zh5qTwbVdTu9tvcwQzMxyROoc7nFIgCLOyYogZfrxxqMbwQ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxypOsWPa7L3SRUvtL0citS9WSIjlgZxCfO9uRu1+bRla/Kcrdj
	7HqD8d5+g/ThXMW4mXfai8ljXrzz2EK1trBKMalCor0n1SHoLkKGDtWaEkXbWL3zuVvN9uWrhcW
	wuPrSzoDkRUbljmvD9wKdH88a/BXEuPHssoo2b+LM
X-Gm-Gg: Acq92OFP59U77Az8J52e8xRKV4vF+NXe1wUqs+X++pzCpiRX14VkVAMkqubReZzT6Wk
	iQf+SFxcoXlYDzET9OX3fEPZP0/Ypnd+NgQhulE6/h6O2XglQYfkbSjxwAo/EW40u8LkXV/D5wb
	2qW+O961tCP9MQLUdhu19S4eP+dx1Urw03MpO4q7pYio2iLHmgGbFs6erIlu9c1ShTyd3JotSA1
	nZfhqkRyfEFRycTQR/+RHwR0ysrSLOI0n9DpqlH3eh51sdchuXmszt45I1kBFEimvTrzn7qwX58
	u/jaF5fLyym1VR51B6vxgeILScYsEzS4EtYkr6FrsobKQgJn6XtyZu/HueoQU9QdUxzbMmYuUuJ
	zq2NX42+SvfDirB8fNBROM7tFZn0+ZHQ/b1TyL/K7TZ9r9LvJlxwC
X-Received: by 2002:a05:7022:799:b0:138:407c:1d0e with SMTP id
 a92af1059eb24-1384bafed35mr979348c88.9.1781247364686; Thu, 11 Jun 2026
 23:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-6-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-6-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:55:53 -0700
X-Gm-Features: AVVi8Cf1GPdShmUPANLnqMFhkLhcgfZz7kJnzsrHhuMtqU_Vi6lWkaFdf4-H8sw
Message-ID: <CAAVpQUDgZuLGpY1UisY1inkiage1m_Yw_FEtLzxq=yFK3oi8gg@mail.gmail.com>
Subject: Re: [PATCH net v5 5/7] net: ip6_gre: require CAP_NET_ADMIN in the
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
> ip6gre_changelink() and ip6erspan_changelink() operate on at most two
> netns, dev_net(dev) and the tunnel link netns t->net. They differ once
> the device is created in or moved to a netns other than the one the
> request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
> against dev_net(dev), so a caller privileged there but not in t->net can
> rewrite a tunnel that lives in t->net.
>
> Gate both ops on rtnl_dev_link_net_capable() at their top, before any
> attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
