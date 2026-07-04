Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4133347521
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167909; cv=pass; b=tmgGlTrwEy0YaMq6S8GdQ2UHPjo+pz+Xd+I7yTTvvcrC3dccfLvsmZ17BzfLS2b/cCEJ8FHaqnTYKUGdoupfHcIq7wCWNMJzO04WFbx7EHMjQO6PSWOc6Oi8Px2bgdkT5+/HYmhlMNWc5ez4Px0enHP/fd2Nq/Sfp7SWKWmpELM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167909; c=relaxed/simple;
	bh=IW0LdZboWFvM51IoGirgs2r0L0XfBs0zXkDLmAa1uVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4XTex99rFlxUXQuu8K7bYwyguNctcxBL/upNMLo/AoZUZer8/6S+O3dE/mjLKcHj/XpVMWG5OkTt3T2PSJBLxwjKbwK8ggnV8BemcxZdEVMjXX8HedRIEGqdfn7ppu/aHpE727QRlP6WK0btySulCGtgc9j6no1BRdU4cFcDUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enngNoMk; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enngNoMk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6770f12e4so2041855ad.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 05:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783167907; cv=none;
        d=google.com; s=arc-20260327;
        b=SzB8cQNiDd+yAZDPvuDurGF2GckSAapMz/DeU9kGsCOYdeDUTVDcHP/1BAqMHKDzTj
         dhGX5Y6xzWizzXMWGffTi6kFRT3kLOhs9+5fFYrGX9stjQu9a+deackxUzXwLGHhGDuN
         bazWz4UBsGjE1xbRi+tH9gKw534gN82Tt3PCJXLEBbTeGAxbMKUWgM9G72ESz6O/zZB1
         Bydcpj1zNJzB0HBvHdRZbtDklNRw7ydhU5IFKwgLxJtCAIUFt0/5FEbhCjLnuEznBGrl
         mFTtFBVTHNNtqHBTrZO0jp0UfyhxuiDyh2R+EKYzp1AekXh4R+Pb+W6aUoLuT2gHd3xH
         o+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IW0LdZboWFvM51IoGirgs2r0L0XfBs0zXkDLmAa1uVs=;
        fh=DjVqH2kpNf7/TnnDRejGEpJ1l8oCb3RMHtU/HtU0Krg=;
        b=k+C7tgzIfflWM0mendYqLrrDIwY15sXS9VeTlijVRbBjrTvI0hiE1buiDyozPTPUNF
         tIrUxfG10ntdXOgswjw9eodEGKDYmYIKUvia1Dt970fQmnC4c9lsLfl0tJ1t7L/QsfP+
         AC7gBrz4+Cpp9c1EzQjo9Kvd00c1for7+j2TNOSaaLIkZ7mwmjWK0wAwjeUVZ0w/bwut
         qGi4WhYA/+DQZ0VHLrBGTyZsIyUWdrcVJPPLvGrirqfqC3StgjsHjwHXyuwDdMvc2T2c
         v083WnQNj8smf9L5iDidETU31b6IYv3Hc3NAvXlDezo8lf0EMyEfC1YDoJAkB9yo3pOA
         rRLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783167907; x=1783772707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IW0LdZboWFvM51IoGirgs2r0L0XfBs0zXkDLmAa1uVs=;
        b=enngNoMk88cGGf/zlnyH1RtTMHsu0VGK+16qlOXwFSOgJdpkT1uEt85+y/cOBZC6aX
         si6K18RWc1whAhqhKw5ObSz5cEO913czKLWuFh/PSD4RywkF9IXHHW0TZovy7zmqrLMF
         04iIXUrsnkkOYRhZwKAGOf78T9gwlLOczOL/lZO+1pbZLTpampxd/7EYtQGKGR1/OviR
         u4E3jluNyhrJYor1nOSbpXV4jmyLK7Ir1vget7Z/jJZHzYhTEppKy+j6fzhuSDvMl/N1
         Fx+gHYofDKoKMU2HMvpTi2P+Q77kW3rp+7e2aZkHfGi9X3GmxGedbSB2DDhHPrxXR0N3
         fpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783167907; x=1783772707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW0LdZboWFvM51IoGirgs2r0L0XfBs0zXkDLmAa1uVs=;
        b=WlVFjXADNMuG4nfREmKDX4omCFp+vjgszY61BR+V7dlWBInipwqd6Ymzmiz2bnpC8b
         wSBYRjJPDHJVd3ZWzpoPpRLB08v8gqBewwdGQMMN5gCzaNUODXrh1jmmxmfDANlBKJwU
         ofOQszjsco4tZWzLhcjbqbWRaZ87t6ZU4t/WyfN7u719Yts+1o7zp9ohFLk7rlycTyyh
         2oFbmya5gSRG8bezEFYAr8edoo2cn5CAXTbfLZM+O4DjwJRhEmKk5zxdrK8bLOgDhvWi
         mdAI1SthL5u3G8l1Dqchcv5LDR+wSdh39363dzuu97xjq9sx0fQO5aKXiRFUUWn/K1+d
         mAnA==
X-Forwarded-Encrypted: i=1; AHgh+RqH+yaHNRVsCjl7YPUXl/XSxTi6ctA0LxZ4W6BnhyuPCHNLDXRj3aRWdbSKuvBtHYSMVFTVn0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAv12rLvJ2MvTQ5KKXwfRzBh86jaVkJK9NTWvEimZmXUd2G3Cw
	KbuVBszGsXpAwgN1H+ExQNbAYOJLfDZ6iStEv0sXO82rXAskeeWFqwRo/ho5ZYs3cJYcn3ZST4L
	NuKbOT4ZBeVejxEirviI38fn7E3REuwI=
X-Gm-Gg: AfdE7cnNCl3hWrzBiNNpUmqems5MWBghgfqgU3BKCxV8y9pQWaurGNRHrWCgKNVrRsa
	IEKTAryTAh92u/MWeDOjIZY1V3kgLUsAovqzYTD5cO20Dg124XEE2QeLJsqsOwPkOLd+DNHDAjb
	rXl4uUqUee2ckMyIhfU5eUTIikJ7ud239etmjyelNZc8cvhvy14vhtQIhb5Lelw1yJGnPPSoJxw
	71jb8QudyVn9z0/iYGeAwKFA5AbxFFweLSlVHmnhhAUYqqnndu5uILCBoa02tyYjCNJPIX5IgHu
	HxUEByo5AehbzPvbzUsEZNW6EPYHN3FIx1W2YOI24BT2LBN9KbXrQf8GrpFpBsxhmmF+nMCzTiR
	IMllLg1SgJ23K
X-Received: by 2002:a17:90b:4c48:b0:381:1ffc:7d35 with SMTP id
 98e67ed59e1d1-3829f2f4787mr1810011a91.6.1783167907067; Sat, 04 Jul 2026
 05:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001546.13180-1-ojeda@kernel.org> <2026070315-stable-reply-0017@kernel.org>
In-Reply-To: <2026070315-stable-reply-0017@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 4 Jul 2026 14:24:54 +0200
X-Gm-Features: AVVi8Cfjum1GJrjh8yR6GvgU-et3kTr8XXe9nhIDMrZNGVJAZ7wZTKzqAxVKLTE
Message-ID: <CANiq72=N_n2o5jSH3G5E8B4ohn4jxAQAfznpYLQqfhUQ4BXrbA@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 4:05=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> Queued for 7.1.y and 6.18.y (along with its imports-style prerequisite),
> thanks!

Ah, thanks for dealing with the imports bit!

Cheers,
Miguel
