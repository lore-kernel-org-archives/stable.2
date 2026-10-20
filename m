Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792460226;
	b=SGw0wU6+qFIql5BUkQXTMMd5yewagV1uVbrdAgn1LtuCTFtWWkRI8ZQQI8ZalIpVwmVE
	 ZXIWO7CVMNOGVjVgL9JrYGKno9Tye+a3kE6Yu+M4/m4HZ5D5zbmcyxE4RBbhJqHLKJTIq
	 ARhATPfpdoMGfeK/2vM2vGAf2J6o9KZAL6I2D2uip2p6bQ0LsMOPdQ96ujeSlotssuWH5
	 m21SW3z4kHKCpbqU165g1izXUunpvxdBY4sFpKpgxbtFccIVizolE1/PXkdtclyb3DsHJ
	 FFsrz8+H0XPVx98syJfW2R846CB0J8DWV+NCo1w4cu3pfbGZUNVk9BjVHzCF2lp02kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BGjAR6GJbqkB0JeXW82W/emLheBNUt2rVvKEQMHhSAc=;
	b=fLcwa7bWMMSyhNgF8BABfV0+KaCNKmyUQKI66ZBbBP0lfKuQPdZ0az0JXDLAgCqJNOEg
	 Rj7vYNHRVoUHBNibWKuv/KvB2uwIdcLDbbFM0r6ZX4vV4Dd3Gv9ybmQxrEHYr3Piz1/Gt
	 0g2e+CotpCrw0B4g70FGPUSa5nWqyArXsHcXpJiGs/r7Lmg1Owl137HBMcY/6sMGVYWVe
	 lXUcGsmavuX49VbzL13s35lMTqz9pyxyMraVfjXg3ot+ZmD6s7+cg1VAptI+45RQ0k3bM
	 XocGs2XHMN37UKBcQQ2F6aN4kIGPkEYq1jMxmkolVkfNC6qErNAUJ8+4I2V9FcxfXEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJ+aPCK1;
	arc=fail smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A37606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A37606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJ+aPCK1
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b10d24345dso12674327b3.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792460225; cv=none;
        d=google.com; s=arc-20260327;
        b=r0rtIOR4P5ObBLmydN02yxIjzqsfPOTLk+QPuEY+F7vOohd7/e36afrk3Ohu3CFItk
         XDMlap7q1SfDu2YZxGpSLzxvyIDLLyACqhX2Hs8MjS9r1KgkN8jiWCLI4/x6CpnWLWIb
         xKHS6yaf8qnA1F5sPOIGaYEZGqRYLBVOSn4PPFnvNA3Pusz/gr2Zg2aQe4UvZXAAXCQB
         daLyriww6luGs+qGaqkWbNDf9fd2SrRxqyUUtCZAVrxUSGoTTs7FrL9YqJWzGov0Q3lC
         XJR5Hkwiz3I4MI8EWbyUXS0pV4AlyPSRkiLIWcc9WHdRGtX30kR11xbEYP2F7RycnvsV
         letg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BGjAR6GJbqkB0JeXW82W/emLheBNUt2rVvKEQMHhSAc=;
        fh=dCdG3QxQg66a+52RqEyId1QYGoxnauw+7nkyGhaaiQY=;
        b=iFGh0Qxw+3LQekRjDsFGPf7oByE/5NywC3C4r04Zje+rO4pfvMdp19yvaKMD4tvuYV
         Y/Pvwt/uKWJ6Tfmy4gv1cqNItm8gybDvuTycEL9l9pajDb2v282DUB1aWXW8mApbyw4s
         bGUX91ojxcqx0XRhkCl3QoBZZR8DBHVyaaijQXxcrVtYmp2dGwHnxBivUyalEft+f0Zs
         4z2OUHyI0cvofkGZ9OKHyPPywtZJlP0t8pIGdURbQuxl6/G29iR7nRf12c65lK1dQhdf
         CcNcsCTyk4HsXtHrfpi/V+Z+pev3ZA8Yb7PPkDT51Ui5bUVHFVQYJkhmzneGoxi4Sqcj
         EL3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460225; x=1793065025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BGjAR6GJbqkB0JeXW82W/emLheBNUt2rVvKEQMHhSAc=;
        b=GJ+aPCK1ga+bNhn182ZfbLWSU/lIXCmJ0SPKDnpPLVopNDiMZt2z3LGvyKl1SFOiH9
         6hLcMz+i9g/EKBLhA927CUHvBtEDyo6W6sOM0TuiM45lWEN/TzZ3gvzfD29ziP5Ot7pv
         9jDqaoi8grsbjzQqv/SCXZh0cZk+RYGbKaZZRH2XP6trrbOfACONNwDNP7MZShlIh5Z8
         bA0SJWoJaePuVA7gsArnSPx8NbX0tD6BTv5U/r/fGBVcUavYSRXFGQITMwgVwbDaLxJC
         68wlfW7UPwz0TquDmdC+CbteStrP0a1sw3PyG9bC9WAu2OCqiMDenpNar8isH0+/eDUi
         dsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460225; x=1793065025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGjAR6GJbqkB0JeXW82W/emLheBNUt2rVvKEQMHhSAc=;
        b=u4VZjum4V2oly/VpXMugBWHw2W3vT+99Bv/uhPIiP43Rs/2Ym/I7L3VwzOfRmzY/fj
         tPUEbiD3ZmiiaBBmdFODWjL4/jwR3PlzmwXJXePJNS+Bw7UdzzhZpYx/jxRh4GeuyfNC
         0thhGm+VTUCQgP2T7wVUalGLJ4fSWBEbm4GME30sF4jURDyhb3L3isMwgmvDgT+NiPOj
         zUncJOa7xk+5p0GRRrZ8scibx5C5vw+kL5/tV2Ps1Jsi/d02+s3ViQq1AO0OjmwdkwPg
         nyhtFUXgK3terXr+KHkGD+OgRU4HZGoO2xM5cCZsoY6GTLEKNn1mJuLaNVEZ7WSrs8f1
         zhPA==
X-Forwarded-Encrypted: i=1; AKwUvBykqJoxw2YYVSdY/IV4a/gkc3fDUTupth0C0VkYz2jX0wQiYmjZr5gYrHG/gvLEaIW5M7w0HSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/52oRDJMId8KfuOfoCegD5XOmx2Ck4aORoWCiZ7TLxOz5rqxN
	h/mV7gEeZKgWaT6sMfMRIHQgLyMT+pcUJ8BxLg456FPjGnuPwbS9a+K2/mxSnWurHAGYdD6AdMu
	njT8jwxWMJsNHRORZAynkU5XX0k76NJU=
X-Gm-Gg: AYBFou0KFaTKCvXPVBJTcO2/e8zEuWNQZNBi95zgzlRSCXUCpLPIkfRPUpWVWCZRdN1
	okPu1p2/pp0gkCVhy9xfUUQd95QuAj5jjCEgfuf9eaaOOhXKg3/f5dMJvXkX1NSIvJinQfEa67F
	+AK1IwoSqKs9/9vLaPyQwvFU+y1l8FTffV/769KWjF1KvFpXTDTatKD5xqCll7yG83kdvaEYLrG
	/fg8LoPf3KWHYwZD1mI/PI1m1DbKGrfw1X6ZkSO9ke2dZ8MRLH2gVZupST0wow0T5IwIwgePCzJ
	McS3LKNbut1L+wapWaw4HLTFySjUHQBKgeFamqHCZ8gft1wh3LdYKn1Ee0y6eLl+AyvH2q/B2rk
	8TXWPEKXKIiEcWRH46vv8e+qgApeP3BX8oUoIPw7xgDrFP/pO3PE2GYokjgD6iWa7kIQ5TqmnCl
	+eKEUkNTeSp9hQ/qssIK0j9UlYNvdxUO+2kHQ9rrf6YbICdlEb5RTreAVe8b/IWwNx8Kv9Uvg1X
	g01VqCV
X-Received: by 2002:a05:690c:f8c:b0:8b0:a957:80bc with SMTP id
 00721157ae682-8b0f2196dc2mr38396937b3.40.1792460224531; Mon, 19 Oct 2026
 18:37:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
 <20261017050928.128582-2-sidchintamaneni@gmail.com> <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
 <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com>
 <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
 <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
 <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
 <CAE5sdEjFgVoQbWw12=+AKdCOB9cWm-akxzbX7hJzvyO3vpCtgw@mail.gmail.com> <CAGsJ_4yrAosgxnxqc18qXyeJQHszYOdTxJw4TzSJqp10YQWjag@mail.gmail.com>
In-Reply-To: <CAGsJ_4yrAosgxnxqc18qXyeJQHszYOdTxJw4TzSJqp10YQWjag@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 19 Oct 2026 18:36:53 -0700
X-Gm-Features: AclHuK8ck52zGHHnsy_oDpaMPdyA6LZuDR7CHNRNZa81ymtH366yW7A4g5vgegE
Message-ID: <CAE5sdEj9biuOuXp7aej7pV1Zyjc0kqcH12Oi6gLyJCeuihF6Hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 at 18:20, Barry Song <baohua@kernel.org> wrote:
>
> On Tue, Oct 20, 2026 at 9:02=E2=80=AFAM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> [...]
> > >
> > > Thanks!
> > > I guess you mean the following:
> > >
> > > -module_init(kswapd_init)
> > > +//module_init(kswapd_init)
> > >
> > > Yes, I can reproduce it with the above as well.
> > >
> > > But kswapd_init() is definitely called before we enter userspace,
> > > so this doesn't seem to be an issue here?
> > >
> >
> > Looking at the callee sites of get_lruvec, all of them happen after
> > boot. So it should be fine. Anyway code clean up will address the
> > issue.
> >
> > > So I feel there is no bug here, but this cleanup is still welcome.
> >
> > Are you ok with the patch as is, or would you recommend  changing the
> > callsite of get_lruvec to mem_cgroup_lruvec?
>
> Overall, I'd be happy to see MGLRU-specific code being removed.
>
> If possible, could we split this into a two-patch series? The
> first patch would be this one, and the second would drop
> get_lruvec().
>
> In any case, if this isn't a bug fix, there's no need for a Fixes tag or
> a stable backport.
>

If that is the case, do we still need this patch?

> BTW, I've been struggling to understand why MGLRU introduced
> its own version in the first place. Maybe your follow-up
> patchset will help clarify that :-)
>

I have a theory -
when MGLRU was introduced lru_vec also returns NULL
https://elixir.bootlin.com/linux/v6.1.190/source/mm/vmscan.c#L3163
that is not the case anymore. I haven't looked at the refactoring that
happened later around it yet.
That might be the reason but I could be wrong.

> Best Regards
> Barry
