Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB22E3F0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511825; cv=pass; b=oRFRK/7BtNjCB8mpIxKp1EVAVShZ06N/xG+WGwgx2exmt6nc9G78CbOcMqhQmBceqwU9FfAhWkCGXlvSugibUAC0UUGKOXQA5HquBZm+Z6wTw/EzhJ5ElwAcgcFvYHHigvSsLHF8rprzTE0XpQ8TA6kyrpGMWFvUAyLMeFqrRt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511825; c=relaxed/simple;
	bh=LEVAMfzTnIrU83A9+0hwO+Thr1TbDzEvww7s5Ai+Z6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2erCg1eENVKvnb+SaBBgIXP3fWBiOnp4FvxmvYvzFHbJpbNcwpexPyL3zuj2ay910xAhsQRQVK93OcQKM6zpIud4uw7jSI+JZ/NxMc6qLH2APw24d6y7NZ8Nh5FNFdxFnFJxnOCxDxazWdIsKtzIF54ORz+F86GJqnNDaq70yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNgct5au; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNgct5au"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c318489900aso19044666b.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 19:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511822; cv=none;
        d=google.com; s=arc-20260327;
        b=RBXmvXtLvuOnTJNArw1XXv4wGZtjdo4xW8uJo1YfuJVjiC7zop6oN0moM1Y41qn7kN
         F+7uGwMe30W703NaxOJU0IHVClIWWKcqHade+hNHGZD+Ori37UEPk+GcA7cYHkEyApPq
         6JDhxQiEPD0b+QrVo6KZMhA0+P+rHc7oKXtl/V4wfxq9bqCmmYa/2TctbnwANKKTOZbW
         4IYNSh4M7AR6KjepRc0Hvp+CoyJ2RbyJzydPA6tr84KZgxdbfx/m2ZjjX3c9CK0muoMx
         PfqLAj2uUtnGhGJyiakBbytMnHJjOhNxDYuQ57f6V1khAtThy17A+fLPXR7aH2w/4jFQ
         o63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        fh=gjXWEcRFHVN/nNE8LIpaF8roJ2OI8Hmbu1sqkVLLR3w=;
        b=NVnEBlPKatLdydh9GmvGsNPUsuKohqFL7da+QNSlw93BMnfKzYwn09TvyD0B9U1cSc
         gspcYGeeaI9+b3ELi3St8EaGA59vpW/EB1xs/jEuQn0E3bRCDD7M6Q0MUqvowPqyKQ/4
         8XcSoNSdU1gkHGKLcjv2Hnr3GKn5l6BsJGgsV94MrbW59msLrHN18+B1HkQP0pSVB4UJ
         OlASQQ0GfrlF4dO746jg3uSpunvV+NU9x6l9NkRdGVgWy12VinyBz/ZNOxkJiZ3S2GoO
         thXUKhdyNMF2HFKjE5SnvjohhVRWigT5tOcubMZ2/tO6SLzz0OQFHjw+DyVoGlYZdLu0
         KuoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511822; x=1792116622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        b=kNgct5au5wCwKWLNtoBCPHGbAjnHrJRqGe9RaVgWX0H+K+I1dJUsbZMsGwDLYf4Yvk
         0Xel3s/XBgDmE+qKpHDtixRGjkmk77c0a4sYu66YcmzaLZg2HbNG/uHEPQfbADs8JvHv
         uP5fpvXLiWtfRfm5k4UHoJQ/vyIgZkWQ6rh6fwRM8+vzqVJlaws68xsX11XwEFWdXAXp
         mFVOgIVaPYZ987YgOlFNAZcd5ZAXqDhLakDX53wLRwlVF8JeRm4Uz3NjZRg88qMvqjJr
         UdxA30mu1EdSR/RrAn1wHiIIH044Xj3p9cyyH1eI9Ccph9gn5cetQkyD/17A0Ib4GRJL
         gXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511822; x=1792116622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCrQzglEO/A7J/yCrkORnHOdyV+MsWSTQsRZD0EiG0E=;
        b=pAyC22CVq9RelVhpgrUPnMKFSicyHGFI9NaYEkPZgeo5J4SMtsFlJs600HmXw9+Y7+
         XaiFuoOfFOwlR/0y5Lt27tPYGN6upQZmgZvMCxRl6Yoci4HZT9efyYWJUTGV33aeq/rs
         1IPz+I7HZmyXKhOmCOyuJIFS+/f/gN1J1mF4sz2b+U+kuqErL+/lp0NOg3aTVn13LIe+
         GNa2/LkjQiHHA1QkJEGZOODsbeCE3OxfXHa4n5q2R5Ddqd+zseZ1QxXMDeWalTGApz1x
         kZT+2hYqPtMIgPLj9tu5ZjzS0HY1C0wzl/1egd0wjd4isAFPnGWL5FzPq2lnhN26i1rc
         nQ6Q==
X-Forwarded-Encrypted: i=1; AKwUvByYoPstgICYxN1q1LLipZBQxC/2b2g8/DmPqbP4DYhqAIBZqSSBbi+LxRJLghuDcR7IVqrridE=@vger.kernel.org
X-Gm-Message-State: AFuF++lTJttf1/sq1K5qP1a/7EfuxaMkoiI7Q9+l/sdk//Ob6qz8wDQ1
	ssux6mKNrUzPXG0Ff6wJpuPgXf3SCC5iU/QadI/bQtIB2n+nVdUHEatza8mq/MJvDxivQpfjqVY
	36ib7lY0pp9GUyTlrwc91HsFqbm9hri8=
X-Gm-Gg: AYBFou2wcQ3VHD/m9svP0HdYnafM56EZ65xuIwoe+Gsh8egYeKdNpTlsIt8g3zSl8qE
	BnRY/nTQpfPxhbaz6Qk1OAbqcA1/lDSKGpfMetgQ/Z5J//hRtxelY0fmBsZn8dJzcYrXSbcSv/b
	ySKEg3YYQSfd+uiHdYR95n/diVrd8yOHRq5lKERxmtQ9qDgp/mQXtyeZY/L8BXDhKW9KD0cJv1K
	jbLlAl9DhhpHh0Nno81pZ8DbIjF4m8W0oVB2QjPJCv28KJ3swdR+I/AGgb/SiGvbf8MjXamMxPv
	iGH0y6OVJMPzQrwv36PbWDwegTQd/qhLwtcsiQP9ap/PF4jnheMoVt1PEUATyvft++uFrVn3m4b
	Vnh0/jtRQNw==
X-Received: by 2002:a17:907:d516:b0:c2e:39bd:d6bb with SMTP id
 a640c23a62f3a-c31a9a09d51mr46781466b.1.1791511821833; Thu, 08 Oct 2026
 19:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
 <179096305349.1402591.6316561110428507255@kernel.org> <20261008164917.384b8e96@kernel.org>
In-Reply-To: <20261008164917.384b8e96@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 9 Oct 2026 10:10:09 +0800
X-Gm-Features: AclHuK_MKZrYKC0pZ5TgunLeFOJeDzBazt2GlOkbI3BRXa-QDM_6-DuNBaLWb9c
Message-ID: <CAAo+4rV243Tj28op=Pos81-g-txz59Tb-a6CP-6rbngN=rKU1Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket allocation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 02 Oct 2026 17:44:13 +0000 netdev-bot+sinfo@kernel.org wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
>
> You have to answer the bot's question.

An LLM-based scan of the networking source initially identified the
issue, I then reproduced it with l2tp_ip by racing socket (AF_INET,
SOCK_DGRAM, IPPROTO_L2TP) against module unload on a KASAN-enabled
kernel on QEMU.

The reproduction used a temporary 50 ms delay between reading
prot->slab and calling kmem_cache_alloc() to widen the reported window
proto_unregister() destroyed the same cache before the allocation used
it.

Best regards,
Chengfeng
