Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793088287;
	b=ecrl2yYQDMVRaLjTRt9U1Khkt7UNg4W86iT5sbWWV4rm8JxWTFEpbE9jzqB3CN9fVFmR
	 GB2gTzoxSWuOcvDDwIhvZO7NKtPN9jKk/JsuQMDqdLWS7Ey+8V7PPI86zk7/g2/Qlbr/w
	 DO3nHt/IaOYWPt8kCG69S/6EymJIl+0iLbE0/9kA9PsnmuYOQf//87amjGCT6uGpSNx/z
	 rZ3oYyJeppNM0FMrr1kGnYkFr1Ao4kh3iimI04PHprEUXXF86p7mh7qPr1oS1PvYyAH7Q
	 ZFe6AcsWo1KdtR9NkUXGkRRRYOL34qRK+DdvTK3tvskzwXgMlXmmtuVei14L6ZLG+4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
	b=arXjuiI8jHItmYyJhhodprHktjFW+oRlQPzpN89d9l1QnLGevlIuQEDFtCTaO3W26Aqq
	 A9AJKHq1zawgvLt10JGfnr7TF7gF4Uj5osxg3FVni/lJ8TolDzJGe5/LZY9BRhWNFMrpU
	 IPL2e0jgqr/+8cILnKRHbSQ686VsV9MxRRYGbAVJBp4gOpUVODmL4jfRO04C/S+OgGi47
	 Jtk4hVzyYMSEyaq4cFR3qw3XT+bsG01qjy3BHJtLHzVI/xeXqHIJWJADBUvTutUSjMc84
	 QMABxezq3RAbCUBOxiOEkGFEOgnp7sUr4+5Y4DfSnY0lpa22vbqwiJCPlpQ7tYoRUUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qGblQpZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFD606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FFD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qGblQpZU
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89ff475a152so1532801b3a.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793088286; cv=none;
        d=google.com; s=arc-20260327;
        b=fTvHvYEq1z1ROU/MnH4UxfbX1FagT3PkGO3lsa3u2jjkEKn5LYR1sPrX1tzCBfW96Q
         PrfQZmamgttb3mj5pBuVgno7DiySsTqhglDKRM4T5fyDQFP/ArAtJZSeF5ygZgwJk+/k
         eONRIQL9JOlQyZt+++pl7Xt3kMf7S6ZC7EZu6H3p4zdeUXIpWBQcPhVAr/43AUG54pzf
         e8fNx2OwiyMrK+SjHhpN93LxxPXPr+WXgaCnRAgb/OMd7xDyjzMbKamPCO0p84yfR6K/
         fm/NPrjTizDDUCRGxoQtXAiQ6APssonP6X8n4veBLtZwxW/UCo9L3fE39jOr1Bm8uTQs
         kVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        fh=B0zM9HPatKlgZm7ny9lYIKmVr6s3GnNcfEVCN6H9x5w=;
        b=nld5j+T/RWHUFR5POBmnVh3KAixHMvK3jGHCG0qtPvaiVKvwRilqquCkoKvJkixz5T
         FhagT3JqMIPkqNJvAQpW81ecUxrZndC0M+vSUSR+0GIlZLdv1YOBSid1tSVQnJhkWf99
         EKWES0HsTiFIK96PdI1wmtwVqMooVJz/Rjx0j3TkbVETnWjjZF8aub5Z1vLTl8vTYUZ4
         5t7YcqQzI3tPm+ZkpMX2G7gZtfctO1JhdaMHEKuUgHxrtotZIbQQzsv8kMNy67DYj9gY
         DCxps2KQJPeKXTRtNhAeTStUhsdlsSLxqn8WN1vU7Vpshb2w4Bwy2tbBET8qpmXsbcBL
         a/pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793088286; x=1793693086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        b=qGblQpZU/vrwCydehnxMnDAmePPsneRZLdrxFgVhU0KJNNc/ur0T4HlIONfSW+soiN
         ij0UawoILbPi9RdwxfM9m/CMsScsBMIo2VpHhep5HJGSYlYILb/d3v4Q/6fImx4Hl0P7
         tipPmp6XYYVDS3m6L/bMiwivv9R2gjt2bYaDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793088286; x=1793693086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xHC2EdgMXpB48QAnOPloOveUQ2DKHM/5gPM/pLMfkk=;
        b=IiDzNirQ7Tbb6cmB3fhJSjvNhRlo6GgxRiHDRYao9d2jLdciHPzfwO5yx5vZPg3hBy
         TL6E2RnGB2UDqc7QZ+r43xb0J5tY7/Ur+XP73Q0hi9qvD8hCJZ9gaaI4aaTMrfCrxUkb
         7ONuWnVAa6xQOHqcB4m80bW+P/CIT95RmHJGWcXMvdYpC/j7SyyaCju2DhJ1kyecDp4t
         WjL1WKJkKAeb1yzW7DwjtZTqHpn0Kbin33tGx9nMPpj3Fk5dvQvBn7SAE1oPYdKSwZ/k
         ePl76jcusJyw0j02NPSu3JXs6qM4Or8XOS06fWNYYRb82SJ5vwBlUwMN/ysLnynLYE8I
         FRng==
X-Forwarded-Encrypted: i=1; AKwUvByfsrU+V6vEXyjniXz79Km1USnXZBUj+Z46J/gWdibXin/EJmUY1Et2qkff8tU3Nt/OnM4e1Zw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzoTO33Rph7bcVeU/PQmcaVBFGtOfxwuwzp2GjnXzAC6ftdAbM
	T0zjYWj05szEy3k38YHnPWGOqnqLaMLyFmYWVZYYoktQ3I0qErIwes1zW5Vpy/jJ3VUUlMMX3Ku
	28SQKLyka9pbDhxWetlfDA1YRwh8xBmRlU0MCfaXd
X-Gm-Gg: AYBFou3pBSNGgFtdH343CfAgY5M6QmpFQWC8dEfDHQ6Ddf4YI17/GIzYJI8jBbVcv3+
	GO5jOcrePxBGBh6lBtsMbEbPvMKFbwkB1nRCOrMNPhzZ1I1jDGE6f9yBAmHGNRa9zjqzgTDsZaH
	H6Un1BWU10BHSzDyNd12jnGdfJR3AYw6F38fd+3KgdlK8H5TxiEO9RcFmyKAXJpDnQ7VYbo1Fma
	Dpw5xYKmfAUcQPWTRFkAh3lY1tOqCfTaoBMxmDFa/lWZeHkzndMMJuOq7+e3fKgejSDNBcK+XSO
	rsnDqLRf3NnsV59itYTHNp8CTcYfnivPZDeoBh8WbPFTb7gowYM7rJ8KOMcWfoNy9zP2AKYqTBg
	NAAxPIpj2CteGfYhLBNMXxvYjFBHBZf+t8f1mawoDpwsOUSyLdwYm97PKStpngxsy/M3QPt/6s7
	EAfTwiuEik39Oz1nQ=
X-Received: by 2002:a05:6a00:21d5:b0:89f:3c81:e733 with SMTP id
 d2e1a72fcca58-8a3684d2be6mr6451664b3a.25.1793088286278; Tue, 27 Oct 2026
 01:04:46 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
In-Reply-To: <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 04:04:34 -0400
X-Gm-Features: AclHuK840k9irP3d1n36aWH39cgcyPna2KxP6UOHD5J1yZKTog1Eti3xiI9sJ0U
Message-ID: <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > This is an AI-generated review of your patch. The human sending t=
his
> > > > > email says "Hi Jamal, passing this on for your consideration as i=
t
> > > > > seems to have got stuck somewhere."
> > > >
> > > > There was nothing wrong with the headers this time - so not sure wh=
at
> > > > is going on. A bit frustrating.
> > >
> > > It is frustrating, you are the only one with these issues.
> > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > >
> >
> > Let me send a repost3 - will take the opportunity to pedantically fix
> > the commit message (no code change).
>
> BTW, checking i see the threading was:
>      0/2 cover  (root)
>        1/2      (reply to 0/2)
>          2/2    (reply to 1/2)
>
> I checked other postings that didnt have issues and it was fine. I
> also found the approach
>    0/2 cover  (root)
>        1/2      (reply to 0/2)
>         2/2    (reply to 0/2)
>

And for repost3:
- 0/2 (root)
     1/2  In-Reply-To/References: 0/2
     2/2  In-Reply-To: 1/2; References: 0/2 + 1/2

I am sticking to this approach going forward.

cheers,
jamal
