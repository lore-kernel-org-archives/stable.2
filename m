Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404519;
	b=2lthooQHeUc7lS32LyC8RE24BS/9S1vTFitKnVOpPYCRElUn9wwEVhUMkQLJEwNEMC9Q
	 gurPUGz5h3BvT/wQET0p4lrPvkay/HWYwc8Kn3rpLwy1DLjIMPDp98tFEWp3+cfbm7y4/
	 3apfqKHa+iiIPxfEXRpyaR2SL2xDRuV6kgrZP7lqrQm2wVHePzuvRvXDX98Lli5X3N+Y/
	 W7f3TP3znUMQYOTB3m94Fk54pb/GD6TMGQZBfVRHYcR/UuvtSLz98jojiIyQaG7nhsNtB
	 ns1RtrGpuLCFib6MR8y0rbmy+qFvcU2H5mer9qzcVmX6rAHI7akFGGUu2fA7rCqarsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
	b=IuNoD2OFMQNyqBu5g6vdKJ5SEuDS738LNXOL7zEZO3n/PSsbDzuyAX3LN5PgsjgXFmS8
	 Cz4Vo2+yfu7rHCtiS5e4ASLhgu2CcQZWHmma+WkulWuuAAieUjQssszZbYIJiPgfA/xUR
	 tzGnPMEeeaK+sIK/4PXriR4IFRlYQ8k4igQhgEhghIeyKWkYDtJ+SBL1jO9XFCfRgFPNW
	 qnoR28recT4gsz5nCvY4RHdlZyd+Fi9BdBWsmEn4viV8IM5kJdxT1GILLWPAwzAbG6RJJ
	 dI//xz0bzAsua6KeB7inLB/KzmsscCqFwoazK5+qaXhjBFvwldfj6UQCIwXZrSfJHjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g90birjF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.192
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42650606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42650606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g90birjF
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-533fe730856so1367518b6e.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794404518; cv=none;
        d=google.com; s=arc-20260327;
        b=ADkSNY+SkA6J7iPbvBbm+GeKr1LMmZTGWt8zTk2e8YdcZlLjrFWocwTIM+cV2tFjFx
         ziOaBmod41lHC24IJExhLx0t4kOLY3wU8KXi/Qz/ERO2CQl/t5OaErvpcltpNMBWLmTd
         Fj+4pZeyEYrj3vJNRilTknbYPQS5HlWEfW1s5oZ5VwsgKyAB/e/EBlc5DiP4nKk3lJrQ
         pIgaeyolvSH/ad93TtlCEcBs2A2RbYQS5hSq6dLg3NiEZTDGeIq5dn72fABBbT1ZCiKN
         olm+3I6W4V2vDOKjrC0mHl1SYh0xjHajn9g0YF9+lCr07IZqs1ubG6vfreptfdq26d7S
         SM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
        fh=38yE9YOgPyLbznHoTqe8qfWklPBQbb18ItQUt7armdU=;
        b=NojFnmL37rkubDLIqtAbwd9Ckz/U4vrCszexZlRY8q1DJZFUF3bvL5J1BvAuWADfQ5
         dkUr9RTPseqY3guz+Diq9Uw/tAR17QQeJBHhXAN3Sn/4j8StUtim0aJNMsnSDUacmdMg
         wKtDW82IpBLeCWrgRZYBOsFqSkPMCBJWGaRY+79PyfWMQsiOwgoZGn4jpPYYn1aPkm2h
         N4e2tUwSoNXaJQ62Rq5ZU04Wt7G2x+rIDnsc9TdRiBLAt0GUr7qWzmzVAErxlUdAeJp/
         tzQWZ5LxJzXm12f363iEs+E3rS0l43RgGomSXufrY3KSd7ThQbUGmlzfF3zS//SDpTsz
         74ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794404518; x=1795009318; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
        b=g90birjF51kGiHNi911bO4MwqBelgEELX+vyzPNk+SOLHF+7TbZ0bMj8500ez/uy8e
         ZrQEXliuV86UgyR4l6e7htHKO4P2TzesiSsRciHkULeuTEh2Vr+ppWsqmB+Fj1L+cmIZ
         cuspCo0ll37tCrXTBp+dQyUrO73YGrAw5Srd1GYqGUihiK8eY7iMJwWCIaL0KNShVObA
         /GjDwSE/nml/rN7h3upqn7Na1I8GHTUMQe0uk6l+ElYTduAciMQrwZkBjUnOmrTL8p4R
         F/q4q45jAZrbJ7fcwljfqcnRVX7vCTL0ToO7h/RleoK8zZeAJNH1CsBqFqlh0Cpsl8uC
         VaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404518; x=1795009318;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DXnOrYJndBjtvfOZAozL2l4Cp0d2hZXtDRZnAOOlgK4=;
        b=wQ5STJ6bXdIgplbQD2lS2c/p6N2095LyqNMLsidPMhXapWKou8ZEBEkfi+rXWNllW5
         h6Gx7U233rcXtGgQo78eFRPVqB4+y35D4hZUQDqv9uPA1ginw/7rpxz3jHfdQ+9WHyEu
         DxFD0q2QBP9a+ecSAe45e5BXtsIEiyRed1S7eHuW+NavlUzwRILdTJp5G+Rmx9zFwvLK
         fdpzk3ICc1m0ZH1HGq7/EQIm/tnYGX1Iy7A7CPjV98Hl3dzuOSCjwGIvTdczIiWTUn69
         S2qjevA8I6PnJWjinvJa7b9TJRlS2FAdVhLEMwkbC1w/PqFbzXkpDiSLqC2C8L2GWLCo
         8yoQ==
X-Forwarded-Encrypted: i=1; AL+hErEEkbLVlzBlDjiEOFkNgtdGhQWDuW32oSMhR/0CgiKgiQyhbpvMTYTjlHbR7TT0N0ndctdPnMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sHkeeMLeCOzd+q/ehiTq8OSu795KRykOe92G8OTwMVGjJ6FmQ
	3PuOQvrFwSEd2gF6ZQQBCIsdK9NRvfVaYAYAen8HwGSYnt/uDZ3dAg9a1nR3Y8FdN165Cx8G6dD
	Mu4Vd3ECrA7e7KtO6tVM6D2xf5J4MaYk=
X-Gm-Gg: AYBFou24GmIvoPmkAVcpTSlYZ0Oe2lxm7vrR9p0ndmb91WzycmZ4N+X3N1cx+547nsW
	WIVyCLHJk8eKL/+dy39X2QJg/eX6/sz/7Luqo1kzOqzSPWTAtVmyV0jMtlLkhoa7zj6GyloUFi5
	rGbfV+3646uOxGxFIMknJpYBxFP4qagEf29ldA6v+M0qr+VJ1R5S4Qk/eI6ZdgRuzYCJ/spsC4E
	IQzjCkm4vA98GWK8K1jy0VDAfUEmouB5d22X8sadKqftWq7rBui6lR8OfNRTNlUpj7yV8LLimwq
	cd66fchPCNTIuwy3VGks32mQ2uLtt0Gr8Y5MNcXuvR9RhIwVu2UThoATgqdDBncfGkWO5R0nHVb
	N8NjLdpadlgQpbRU5UMffCTfC1aMMkT+6yce2RMbD6f+SHOaX39E+ls66xan+y2xeMUs6Q+V/ix
	zRHEKEFq17nTntxGyXaY1qTxn05VG7dCpCqcRqK4uV47lJcDiT723IhOuZKuR/iiYW4mat75A2b
	Q==
X-Received: by 2002:a05:6808:10cd:b0:55b:f88d:6ebd with SMTP id
 5614622812f47-56b9293c5f0mr1861940b6e.3.1794404518140; Wed, 11 Nov 2026
 05:41:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104191621.89561-1-dennylin0707@gmail.com>
In-Reply-To: <20261104191621.89561-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 11 Nov 2026 05:41:47 -0800
X-Gm-Features: AclHuK979fFPsKcuUOg3hUc17dq81L1BTuEdNVZioITPsDqDO4LERCg-x-Z03Ik
Message-ID: <CAGEkeHeMnYs_SM610dCCBPufJHAN6t00WBtC6YtgyZbw_GfUcA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: read atomic replacements through the COW inode
To: jaegeuk@kernel.org, chao@kernel.org
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chao,

Gentle ping on this.

Thanks,
Hungyu
