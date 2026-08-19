Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05B3BADA5
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154538; cv=pass; b=YE4slWS51L1E62GKEDEsqiRnMOVynELpZHjhUzA9HvYHEtTAVdEWK1qVZGOpTh1Nui87tlCOBGEZnY1NxL1VYUxSVj2PTBlVbHqILvVGwZF89K2HrKf2Y2RmL0JkRr6DUAM/6AtI/h3U4BgKyDgApmMYNy5QiSIKQRzDmWDVdOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154538; c=relaxed/simple;
	bh=C1LDy4d6ND+Sroxg1OCZ9KkCmvKKRkawoRU3rs+6chw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HasImDAL6wjM7KHrD0tVANSDP9p65hobhcTtc9PWYswWxqofN/06O66g8KrW8s/ibmJDFQKB3ct6o9Db8EUa+SjH9SzpUZn34yt6uXoQbkoDyRfC2CsZNd9Qy8i47bPE+Sg9z7xfnlwkY/jOQMzo0r9nAlFgc9+au2GIYPn8qmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MmbLshU8; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MmbLshU8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so14378521fa.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787154535; cv=none;
        d=google.com; s=arc-20260327;
        b=GX9t+VnciaBWmIVyz7vLlCTDmzOgwa1gD1/aEISIiUpOXKj2tbVlTkXDWox28+N540
         1nbaaj5VvhXROlKD/H05ihkd6s3isx2iiOYWuGigetbovsuXb7R3+wiKAFwxN3KasSSM
         mV5VzNGMhcQDNr6ixI2T1YevvzjVggaLLBONo5dojAlojt2d3M5vICxa1up/tB3DVWzs
         CDWve84emcsdS+Jw2As+Ga8NaolUjsiLGimV0bgdWJpb2h2F1tCt8iEebRXZUixuIawV
         ZACRjSW/ZAWYBXbRtiqyurCOPD/wV0OXxPbLLpOdoN50QDlR474qILX2jqJST1w3Vx2I
         lLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+A5sw0Gkcd80rFyIPgG7wRWGaGNkrO9aHrdYGv5WlFk=;
        fh=nwMUakMpzxiF9eToWfcHVj9yCPQWuP9WKPPVfLi3GVo=;
        b=bykm7KdCUcxHXTSaZKa67w5yHA8RX325Qu8TbD6YJax3xFV6jDhXa/UlkNluUtkp42
         hVg+jMwcTklEGt+DKab2KdAJjANtVbHstSUCDT+/5bfBBRPHX5/Sahk2ityjyx76uV54
         nkK1hGg7GllCQv4PINzd0l3KxthTcadGAI3R0Ir19WzNUkVSfAzwCavtewJGDKi0zEdq
         VN9Vz40zsTaR7C9yH/nADiA1zDIvoBUDa2Ap4uxxgg/p6TLHAJ7b5JXt1pJ1zrx+oR+C
         LPnS80hLwL2WAJzxGRaDg9J+0z3xt7z8/DCkgWJzmTkNL2ahsDP0Poau3N/36ryCC0Qs
         ucRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787154535; x=1787759335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+A5sw0Gkcd80rFyIPgG7wRWGaGNkrO9aHrdYGv5WlFk=;
        b=MmbLshU8zc0/2LOHh6GoAiG3HVnbCNZS/80wUmF6MoJjcR7xqImOYiAp1IxQwJw/Z+
         6SRDQkEk7NuyWOwkU6+PurhCJELnINHdfCKmlXpFK3ZL8OPOC7KXtkIfqkpvrj4n0F2+
         Jshi8gctDorx2h/UqhNw8/dYUh4dicZpT1Ntrl8fK/KZVq5QzmknX+kks98qY0I3cLCi
         9IAp0JW/lj9hL8NHPstiMkqh0dJrBAEpxN9BG32cj8q/CP5mirWQqCXqco9tqh/p61O4
         ddJylV3l9DSUw1XOCV4D4NIhD0zbNG049lVgM+qkVDaObzlUQtglZkCcUqAKpd4PXu6+
         zEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787154535; x=1787759335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+A5sw0Gkcd80rFyIPgG7wRWGaGNkrO9aHrdYGv5WlFk=;
        b=GAtzTxYpQ82RHJBobt08bEvCpSsOVLJIQ1fkP1A/JOOJtqwtNL8BOgZGZEGg4N6qwI
         MDd6pVtIcz+1rhDU3uYAPUZmK5PD+6xm2C5o6yOo1kHR4PzcVx5RdEB6IHsMNdFY+Xxo
         et77Uy6y7GrfCIq6WGhNFd4iSjkm+Ju1VBenXAkopsnUyirO83n9rE12d0DIMt3J3L2s
         SxaFc36P/fO8XYUZUN+NPYdS/AQWz0Vdl0m5nd+s+0Frw2hPSBbF3tGXAVTWts+tDl3L
         Ce6g20ej3SR9+HdoKBdyA6fq6oDmDhVa5LGFNXXXA9gAgwDgsKlG8b64GCkwemH0LTI8
         Z9eQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1HhyYQxf8qu6IvQdZh2mJ57hIrCEi/Z9Bv+c/kiZ/G7A3tBsrfkqMYmpWrkwgXjQl2s85Cvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zh88pJwoVhrmSadbuEJX5u3Oxfai5fAjZFc6aj5vqlQ8rT08
	b5e1ibaCFORN4ocwr8mAMC4RHE/ZTSK8zKU3+5g0edD5nx89sD3jgVUYHbuNgB0teb0Agn+vpdg
	gA1CkLn1YSQe9fLTYjJtEpsTS00TwwoMBbAOXY4brsR8=
X-Gm-Gg: AR+sD10zJP92YYrxbVE6UQb3HP8Q6EBvTncdLQ6cYXSmUI27bYyuHE6LLdoD4hr4n78
	NKsHE6MUxiXCcdDA1zLrw5x0/FewA5FYzRKoU8PFybELGqHK7bhT8IrabP7LHxBOnu6zT7BhHlm
	1UORbvZvbhdh+OnypBIpWOEogisRFXsug6DvRMsDYSHmpjX2G/SWfU/uW9pCP6Txo0S1+0iAWy6
	9YfcSZJymmtRpaZjj03nSyEO7vPPPWCoxnqH8tan4+Mr72sWNqP5MXAiMqumV76hB6GrhSshv30
	bembUR2JMZs+eRJlpZvfGHEuPNyVFU678RIaEgt5huhGsDnonO/ttExs2MG0OCHF0mNM+s6Adlg
	=
X-Received: by 2002:a05:651c:2109:b0:39f:27a4:8036 with SMTP id
 38308e7fff4ca-3a1899f1d41mr11387071fa.9.1787154534767; Wed, 19 Aug 2026
 08:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786812660.git.zihanx@nebusec.ai> <2080e22819c552b0d186563eda255a44c68404f7.1786812660.git.zihanx@nebusec.ai>
 <20260819153109.GB1248049@shredder>
In-Reply-To: <20260819153109.GB1248049@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 19 Aug 2026 23:48:21 +0800
X-Gm-Features: AcwNN1X0-V-C_EkZavQn1ho1Bq-wtRQeRLmvDZUt25d4tg5QIRX-85A22Cwk_mU
Message-ID: <CAANe3eQJTp5esgxQqGcRO47Nv9epoW5tYqNY5D-39WaUaDSsqQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipv4: Fix fib_rebalance() divide-by-zero race
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net, 
	pch@ordbogen.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:31=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 01:12:10PM +0000, Zihan Xi wrote:
> > fib_rebalance() reads ignore_routes_with_linkdown while summing active
> > nexthop weights and then reads it again while calculating each upper
> > bound. Sysctl writes are not serialized by RTNL. If all nexthops are
> > link-down, a concurrent 1-to-0 change can leave total at zero and make
> > the second pass divide by zero.
> >
> > Route insertion and link-state updates call fib_rebalance() under RTNL,
> > and netlink devconf changes are already protected by RTNL. Make the
> > sysctl handler take the per-net RTNL lock before changing
> > ignore_routes_with_linkdown. This gives both passes a stable policy vie=
w
> > without adding work to route lookup or rebalance paths.
> >
> > Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>
> I think that this is a better direction:
>
> https://lore.kernel.org/netdev/20260817013237.2797-1-blbllhy@gmail.com/
>
> Instead of taking RTNL, make it consistent with IPv6 and mark all the
> nexthops as dead (upper_bound =3D -1) when total=3D=3D0, as the first pas=
s
> indicated. Something like [1].
>
> It's true that it can lead to incorrect upper bounds if a concurrent
> 1-to-0 change didn't result in total=3D=3D0: during the second pass we wi=
ll
> account for nexthops that we skipped in the first pass.
>
> It's not very interesting. This sysctl was never meant to be configured
> on the fly and the kernel doesn't rebalance nexthop groups when it is
> toggled.
>
> Let's wait for the IPv6 patch to be applied so that you could reference
> it in the commit message.
>
> [1]
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 0483519b7fb0..7a362f2e2c2b 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -874,7 +874,7 @@ static void fib_rebalance(struct fib_info *fi)
>         change_nexthops(fi) {
>                 int upper_bound;
>
> -               if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
> +               if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
>                         upper_bound =3D -1;
>                 } else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
>                            nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {

Hi Ido,

Thanks for the guidance.

Agreed. Taking RTNL is unnecessary here. I will revise the IPv4 fix to
skip the upper-bound calculation and set upper_bound to -1 when the
first pass reports a zero total, consistent with the IPv6 fix.

I will wait for the IPv6 patch to be applied and reference it in the v2
commit message.

Thanks,
Zihan
