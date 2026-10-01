Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F23B52EE
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829600; cv=pass; b=uPeR5F/9Hj4g7nZ4fwMPZj1L9BOGlntRp6v50WiaoNTo+cUh7rqv5BaheES9/Elh5IXlWal5EL3pWM7dd1FiBtZ/vzkDyol5bsoe0cIlzHtA5rhwolo2oA8IfE/6pPEaiIcdkwcHnl+McAYmFda9WTnuDSFfCdz+EiHvO3M5tm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829600; c=relaxed/simple;
	bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A409VG6wGD9UPpo6e9Ck/RF4Xrz0Kt/hb9FCrzN1+1BgEJ3hGQxk9XlIbLUhKUWIgHT++OgS0TGPqLVzTXe8XfGE1eqY0Gngzdo/8lAWijN5UW5q8CF2qP1Zjm8k7TN6tLGGaVI6Wiwfz6V+bVy6ZerTcY6aBXWGinkyqK5yjRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiEcbkyV; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiEcbkyV"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7d702c76so152712a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829597; cv=none;
        d=google.com; s=arc-20260327;
        b=BSg/8hToODazZ73UL+NL/oACUlyed1/DONzbtcp38RMgmZ9i0hFQn1LSCJkHfs5aSN
         I9V4eKvSyYD7r5X+Kph/XrtMpHEcD/ZyAxpzZA08IjnIIkJh1v9+6dFej5xz1Vv8Vzr1
         Seg07KFknZAdsr3l2ufdjhQE1nX+VcAKNL3MAn94EMUbBWkETkR84lyWZAeyIAdVkxFR
         k0rcqb+blhQ4S3Lu0lvclZLlS0Hh2luQhc4FLrvKyrMrvgmvRluC6fhF7BDCnKl8t6gT
         /9FTd/3kxYSUuU46WDFpSUFqiBF6kvywetP0Jt146z/j7tOBjID0BqvmVSRbJJSx9ynB
         NYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        fh=djDDqsNHJv94ki0uCV6Yni3+HbYHn8Zs4uKRRgAlu0Y=;
        b=RQ4iW4ZT60k3LmpGso+4HZS9q4j3KwdlIz8s4exfV+9jbfNYXfOQ5eUJHU70s67teF
         8YOL5WmMY02KKvDfmJSOCOjvq96a35wkb7IhXyepqIumtHYz2qcYc0xIo2i/x0eS+9sk
         pfcc0J4SHg7XeS/NuC4dAmw934eQTBrPdJPzV5sQAtiiH6Dzs/e75Cb46xmktEnag9Oq
         6yuglqtX15fM+cq7iBaPzlK6GiCF6ryKFc6cgP7RbTlWh9vJBij0Ty8s9AepGAyqKYUB
         vCMRKm8BJsRIvXGBBym0O9uW6FTZPNPK1LBO1a0ijKGjYaFMpl+wri2Ix43v3Qtu2g6E
         4Dgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829597; x=1791434397; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        b=UiEcbkyVNIUMhWJVyn+9JG0V7GlKzWDUqST50o7uZbjD2aP3yc1bGkMz3mv3rlWMri
         ddG01q47E5ZAaz0GjpeO4mkwku5DtuP1CCndIEf3hNB8ix2tQZFtJsYk7Q5zEDB5pNso
         nILZBHRjr8bB1vieZEe9QiHf4qDwCUdrfD5CKuvNXEOH+WXjqwqYGtYx9J+ImxAcgn3l
         AUzMFApvIVTiZ5zpZF7hcqWrgrMyorV0WxntmOvWrKoKCuzWkAwmR3nQHEBA/cYwOGcA
         /yFQP25txJiyYT28rPGPYqnzpt5BmfexCyC4lPWwgG/WQ4l+pPHoJAJ+aelDJbdP9hWs
         OgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829597; x=1791434397;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        b=mlWEsqs0Ldn5RVO8c0d54vXT9lVvMHKHgRXLs7NYf7MzLFApFo1JDtmjSK/azbUUcB
         kLYT1NkmgR9MIzP/+iyf7m+fKbZILg2k4Z8HRr+YJ8Lth0DtWQnXDkHyfqXAyw+kpDYt
         cnPv6OpJEsjFtc0HzPkYhIH73Wt/lSTpGKQwf+LtvJjWPel4ibeeV5X24OKyb0RcymWN
         6BIvLMIqB6J0kOIE/uNSbwwNy2+QbLjPWm7rVe0gVWaOjMf+WXw00zrKV5LX+ZT6LYCm
         dmY8+0NVIMpGQ6dvtTs3jC5P76Vypl6aKBVbprXczAf7GcLHq+OyRBoPIpwRoRI+3gmn
         KpBQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7hm98bDkZ8MIHOgsMrNUAHy3sseItgMf52XQgJJ2WqEpOvcCjy+l5MDLXNyY7k/OU6TaeqPI=@vger.kernel.org
X-Gm-Message-State: AFuF++mByiHztVeG3leetklIIc7CeWWuaxDLRxIL27IyngoqO0FaBwZX
	j4cNobzDFshorJ39K8lnt/jj7NEol/sBNKr9Aqpx8++3G3hmeJtrF1z5afyp9y/0nH/9/vrCPvW
	YSDvN2mnHnfbE99kE0teAhlLaTgShr9w=
X-Gm-Gg: AYBFou3LDQLqe89YOID5zGEoAAUjQk0cQiQzZuSg3gbpahP20fuGvp0M5M7pp0u3VdH
	0X95UftleKNEoRIvFX4ftsETAYdXbDGYops14SA7kN4CrvSVHWOlaL/onFfwf4znXJ0K/HWtVUG
	t8Q1WToqTYrTuubv4SUSGqrwQZ/2Zwnn7e+zW1SmSqvCoEHX2AE9bC6oKqjObRuqtzosm1kIU02
	htfX3V3UyloSHQqB16JaRDzWJfJrChNkCPoUQIARfkkN7gO/CgzuchX5idOIv94u9fWqdSxevyT
	Jg2RGc3brKW/cQ/jZO8BfX5nGp4werALSNtC1WtW57mSxNRL0n8SmII/
X-Received: by 2002:a17:907:6d25:b0:c2d:c739:30e0 with SMTP id
 a640c23a62f3a-c2e23e24b86mr265473566b.38.1790829596884; Wed, 30 Sep 2026
 21:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile> <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
In-Reply-To: <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Thu, 1 Oct 2026 10:09:45 +0530
X-Gm-Features: AclHuK-y1tLB80ZNINzXQ6UtPI8XoZSzzsSAP0Y8v4QLKDC9gVJNA8sSucY42gE
Message-ID: <CAHeizqEqOx_bTJdNaUYGc1Mc_dcWbY6ybJNmo9uKMcyBPVLS1g@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Subham Pal <subhampal789@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

Just following up to check if there are any remaining questions or queries,
regarding the multi-vendor testbed I described, or if the series is
ready to be applied.

Thanks,
Subham Pal
