Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383D349CFD
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160486; cv=none; b=QGLRx2I955KWI3hQ1TvWeE1SlrZD+zA6KbbauN8QBrhNOmfXpoGqkedm6mSHUHFv9FjcaRyO45nImGXcSPHRFF7VyD/o03H9qTMO0M3WhIdRb4EoQR1znV8sUibwYZxX6+TslZZwy6wKVIhLIiY7sxMxjaUpghMsO6l+lFWoQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160486; c=relaxed/simple;
	bh=ta/gSKNvGoanoIlYiNOUoI1vgzNbOnFIlXHsHy7guYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0RqLc9i4GDOjnpsv+gYZeY1zW/yMGw4f6DXOuCljLYb4SGSsctSr9TB5ZQrzH4OJohWv4S3OovBF4jJexbBVo/Rz+3zvuzXAf1uHPIj36h78vGt6fxEtDrQEDm4I/sGYw0qa/QLr6M7x+94NI15FAtfl9c4/XhJKIVQR4ck3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FLcDG9Cr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FLcDG9Cr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac357c55so79320035e9.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781160484; x=1781765284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAKTHXTGuL4/wSXAiskSC+BGLHaNjyNvdmJF1qOpYQQ=;
        b=FLcDG9CrgtP22lbv+GPacljZ4jk+JmpEwrIpiiQehpTGXE3RWGNmM3OHHdwdju9+JD
         mUP1Ek4PSOXazw7MOk66I4yOR1twi48Map7j6nXueFy2E90ZLkP0mSuUql8cu3iouP3k
         wkRpvX5igByT+ZIyE37wk2YTiODrS8UgnC8zZVhB+Cvmxj8lRKOVm6l9Yeaq1MmWGxcf
         xVXHdz7KJGpq6TmIgaJSWpx8RfHeLFXxydf8xbbc71HX0j5fB997/DZryt3o+mBy5O1I
         5TqDOKpQiTwI+/RuHSNvHsbm5vCjz5z11LA1lmnB8mUN2PRDn17YcWAE9vWdfMU7P2lG
         og4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160484; x=1781765284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAKTHXTGuL4/wSXAiskSC+BGLHaNjyNvdmJF1qOpYQQ=;
        b=IosqsJsUC2fx7b8iWhoYmNdy2IsgWtKmmB+2oKzx49AHqCBRe2qCdCbGvM1tiq3sGV
         v+TD5NA01tPZZUPk3pqYl2r3Yv6mfAaLCly1WYpKD/+yIN4wWDqDJVBB+Ej9K/BHE1u0
         nmFm47CQPulxBLKMD6svPqZvGeKk9GkhCTECgEu9ITli1QB6sXsOEK2mr3G13IJirSev
         3fTliR8KL4zSH3d7JOrHDcoxj4GRIs1w2gPjoRLqdU+cV7UxzezldPm6XhR5XiEYQdGV
         G5kbRg7pXW1yj+uTtqnAyzi/QC3shCecrIMG8lgNnw0iAfMv6zzz/ubs1bMmn6r42vpl
         Aqgw==
X-Forwarded-Encrypted: i=1; AFNElJ9+gOcHnvlPBs/bH+coxffBnXjBY004ctmHLNCn32yzutE3YoatwGJCRzuA9bTX09TxlWbW4Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VUPw2MtATfTs/s0kaDezPBCuaYIqNSUhlG4xb4anxx6E9ukv
	JqlWNQcMXO7sROddq457KsuTWKIgheEi61CJBLnJBZYxq4HwDX4flkogYPJGbXZZzOM=
X-Gm-Gg: Acq92OEo/tfiQJEOL3xlH5pA4SvuRHIfxrklS0LVG55gk1LxsFoST7fFo+BBe+y9RrU
	ViVPM9U0AQ/MheAjtr9LWu5Amnz5W/XI/79nQI+VpW/8l4J8hQPeav1WY+LJzkgVqX+poriWym4
	lV/g86dH1vUeVnIs6nFjMSBRYqPRiXAerUH+fJf7l25i4Yg6Hs+R3UR8n7dY9Cl7ZJBYAm6LeTg
	3tz5T5dbwSzbzcSPPnkIgY+XdIxzcixkw+2Iw9wHPFbT+2ZeFbLekSbSApUA1tXpAxl90PGY5TA
	QI0b4atso2AvrBLRGyEqB+wTOhIsrjtWjQFA8fxFczpfDRR6P18lLnGP/kq6UGBwGKzToGBzaMJ
	pdreXkMHwt/4xCXfdH3X8HcgMu/oAi3RE0dmjGcZxcel4Fc+CEOJBgDH8KXndjarWtrDbFUWFNb
	i/QknmbBebFCG/OVtFcfRHIhNXWeCs33uZLZf6oDihQKUWKVyjpS6PF6FpWTvjAfEa
X-Received: by 2002:a05:600d:6447:20b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490e561edccmr10410125e9.24.1781160482422;
        Wed, 10 Jun 2026 23:48:02 -0700 (PDT)
Received: from u94a (27-51-16-188.adsl.fetnet.net. [27.51.16.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa404fsm263800475ad.37.2026.06.10.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:48:01 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:47:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
Message-ID: <aipWPPxNu_dELdd0@u94a>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
 <aiaTZCQLWy-96M9O@u94a>
 <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>

On Wed, Jun 10, 2026 at 11:46:18PM +0800, Zhenzhong Wu wrote:
> > More importantly, 'bpf: make the verifier tracks the "not equal" for
> > regs' does not address root cause of the issue, it merely mask the issue
> > by making the two states different enough that the two is no longer
> > equal, which works for the Rust specific case you have, but won't work
> > if the value was slightly different (e.g. "r0 == 1" followed by "r0 !=
> > 1").
> 
> Thanks for spelling this out. I now see that I did not fully
> understand the point behind your suggested bpf-next-with-d028-reverted
> check.
> 
> I was treating the not-equal refinement and the linked-scalar precision
> issue as two ways to break the same failure chain, and chose the
> d028-based path because it was smaller and easier for me to reason
> about. With the `r0 == 1` variant, it became clear to me that this only
> fixes the zero-valued branch shape from my original reproducer, while
> the underlying linked-scalar pruning issue remains.
> 
> > Could you give backporting the full "bpf: track find_equal_scalars history on
> > per-instruction level" series[3] a try? For 6.6 it should be doable, and
> > hopefully for 6.1, too, but not too sure about earlier ones. If you prefer I
> > work on it I can also give it a try later this week.
> 
> Sure, I will prepare v3 based on that series for 6.6.y, and then work
> on the 6.1.y adaptation separately.
> 
> I tried applying the series starting from 6.1.y and still hit some
> issues that need adaptation. 5.15.y and 5.10.y appear to need more
> surrounding verifier changes, so they may be harder, but I will still
> try to work through them. If I run into anything I am unsure about, I
> will raise it earlier.

Thanks. Yeah besides the requirement of having to backport 6.6 before the same
patch will be accepted in 6.1, personally I find it much eaiser to backport to
newer stable to build understanding, before moving on to older ones; hopefully
you'll should find starting with 6.6 first helps, too.

> > As for the selftest, it would need to be send separately and by itself
> > to bpf-next, and picked up there, before it can be backported to stable.
> > I suggest you look at [4] and have your test placed similarly, and
> > mention that your test specifically test a Rust/Aya pattern.
> 
> Thanks, I will send the selftest to bpf-next separately. I will also
> change the test to use the `r0 == 1` / `r0 != 1` shape, so it covers
> the broader linked-scalar pruning issue instead of only the original
> zero-valued case.

Actually I thought it is better that you keep the `r0 == 0` / `r0 != 0` shape,
the reason is that it seems to be the pattern produced by the compiler. But now
that I think about it, using that shape in bpf-next means that impossible path
will get min=1 due to the not-equal refinement, and thus precision won't matter.

In that case using the `r0 == 1` / `r0 != 1` shape is probably better indeed.

> Thanks again for the detailed explanation. I have only recently started
> digging into the verifier implementation details, so this was very helpful!
...

Happy to help!
Shung-Hsi
