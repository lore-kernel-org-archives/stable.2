Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9ED3D648F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247707; cv=pass; b=KPOb9qnfjyST6UtLJ3Wm64lFc87nazkcZrbCObz8Kbp79cPEFRJ10FOzAGixYb3r77VctFE4uRunNYQPL+zu+nwfcvY4+hMXMcXs7lWr8BI6iGo9SZoOEbVgesXcdnWoQkhssNwVMzMMNEGBKIWa5JDq0YNm/GuuCFsr4Y26heo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247707; c=relaxed/simple;
	bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUO3zGXZBhF6H36y/qgiwzHYI/38CWY40+gK9huFqXkUBHRAGXmKAbfIpf52H/vBLieHko1Fy8G7RAaHCTVJFAdSxQk4RBhV3grspB/umvjC3YQ7YGmPPLGLGe6aiA5HxEGk4dEUt1rv97qQ7e6W5AliUcrlBq7mfNDgS0RxHvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0i1TrGh; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0i1TrGh"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13721dfd471so777789c88.1
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247705; cv=none;
        d=google.com; s=arc-20240605;
        b=RTi031m55iqjueKlg9fN8/4SXjBApcAIkQS2zZFDU3aGZIMw92occGxMfcix6jHfuH
         HOk/Jg0y0oPdnm+Cs5Rt4+khSfq+8wdqPrauauMwMzBoPdWUgvZxlRZ4pSAtlWZsvVzr
         gNTA7asiTWLI55w55hnhBPErSS4KaDr05QFBLl30eDBW34jCblNEkiCAV8WMuutcC+N0
         isYbJKcgfwE4lyx+SmqVpxMlQHeRdtpNuO9Iop13vnQfb0GFMubgUrjZ4Q+YU4f6g9wW
         KyXtv00rplUM0n9cFF8Ee7AyQsrM8J39GTTWoyyupvGCZY/JxjNRF6DluvYNEw68W+Zg
         rdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        fh=pppgg2/3Ei9aaYwKZK5ETLV5bj+FGPqevC1qE9Uk7Vs=;
        b=ReJEaI8ObupyUsg1P3y4Ef1ho3M3OR2HRdm2urWTHlVIF+qecW4DYNUUg50eIMsyfj
         Z5SuYjuW+GUFY8sB1R3REYB2Lex/fzCT249Df3K8j0rVMlGItJaFeg0dsQ/dSYKgwg7k
         FwhtX+qMBwc+Rt2xoYBrgX7CHZcNTUWcmJk+hHpk6NqUVIpdHYUcEEAAv2yAenFQSByg
         KIC9tCtCJJp8oE0ax48RV72Poxszr/uaRHmbOAMQMkPYgR6S3EhOR3c4GImCYMpjBeU2
         ij7+o8prorVGsqaVRKvHD359XkwLmfK/m15hqgLOsP/BrFVOC+wkmT5WQffMHGSTXbSe
         fa8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247705; x=1781852505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        b=K0i1TrGhc3E/DC3IMW+dsFoOI1kDwKxaen7QDWBXYfoXv5bWy6Ou9+3PaZC2+GnwkO
         oiCTVuDjHxOL3caEpuHu3PoiAhnlEcxeSnOO+Z15GUNEtqcWBwD7PNHtMb8GLzOCRT0o
         Pqn6d74bM1wVNqUfM8DjV8GBHZ81njJY6nXv5aOMSLWJVXRp9ko02r5WqsJCyWW/6BQU
         S+yu/VPA1MqmgKKqwsvCY6zzT9Qlay5CmF6+k6wUHU51RU2p6tqPCv4nS/TOs3PqxooZ
         CaeEHNjKw88o79jDR2qEmibilY1d1qHqGHdabZi8SwK6etR2HqYv69JimyjRgyvx/aux
         I1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247705; x=1781852505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InPp7ej1yT86/ndkgDy4dMtSxeVN9Mc7Zh61V64SEC0=;
        b=FgfzUV1tYe6rG/OKY0z2A1EMqUtbVEGAOoJNO8IzrRqKMnVkwHUMnb+GZRJ5KKga92
         gqehJH8EtvXVGb1gFGP6UiJoT1EtLUZ+WghyWhZ73Zi1bg8K0ssDlH67jrC5moAy3ozm
         Uz9asi14r49VQ0OyWZJr50V8z58J1ZUpDl5MkR1MLIQjkbBqfqYW1i2zpxxUeRqlPctt
         DPjzZLkwcUYLCiAbg84RkuUAeGa0rdV/r9GHjCI27QtXSUO+zgXVoarAr1k/Et78macN
         b4YO+jcv5yAw7gTKGAI0ExBchr25hPDjz4fjhWpnpaFcP45JiiCR0DYA2LFpFl3oXC+N
         gX8g==
X-Forwarded-Encrypted: i=1; AFNElJ8j6WD34TzhxYVCZGikXKIea2wUQMK9FGV3vjrPqcSmxxLEaOVxLjgopNa8xhKB88hozdQbclg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BCQnEaZc9A+JY0jeb8/3zw9Bke4aJCaNe3Cg/kVll9pqFxB1
	tCNf2ERalthGQ803LgSDaaeFsnwjja1tfrdr5WC/wedVAS7LUQ21tMQSfw+jiS2MojjBsB9xQ+O
	2haT2FffcHibXh0eraGp/DslYvq6W2SrWXKr0H/Dr
X-Gm-Gg: Acq92OFn58ZfwvgPS579J4voo542yyYE2eET4JOXOI1WM4KFrMx43/VPF7ALxnMEcFb
	mwVsuV6wZoKd2+XAe/5e8/6zJdAkk8EyzIafhN3vJSeNC/DqDzNagsugZ8QWsAc4QDtvOxjNGBA
	GDMd/arHij71b16X3h1znHzB7IdIkqDT3essz2bN8pEqeLK1HPMe7lYtAKjMiiZD1s7M77ZPkPA
	0LN/N40aw3csTTwnOMPVxiOwD/I+iaHCWSNaY37wmVg5kZkNHB/Ng2UrjoOkbQ8EGRcLj1kQKm4
	trsNW3ixc+fvj2jUNrirxRlmeQ4E+vMlFKqpAQ5NOtmjRKeYWBiwebByHjDDXq87glD4N26yLiw
	43lfMQc7ZpMaQpDcssHe7NY1toWC6b86tYjkziWT1L4kPtPgQiTeC
X-Received: by 2002:a05:7022:692:b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-1384bb1abb4mr811348c88.6.1781247703664; Fri, 12 Jun 2026
 00:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-8-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-8-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:01:32 -0700
X-Gm-Features: AVVi8CdNFhjQWdclCUPGXyrImRDlOr2v8TiKlXZvLYYwjbgiFpqUyAQrvSMElHg
Message-ID: <CAAVpQUDz+gkVpsYZzQrW2kwgc9csh9=V+DBy_nkh6YnfRk7Zgg@mail.gmail.com>
Subject: Re: [PATCH net v5 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in
 the device netns for changelink
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
> xfrmi_changelink() operates on at most two netns, dev_net(dev) and the
> interface link netns xi->net. They differ once the device is created in
> or moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in xi->net can rewrite an interface that
> lives in xi->net.
>
> Gate xfrmi_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
