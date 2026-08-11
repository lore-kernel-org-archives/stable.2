Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E82C3257
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421159; cv=pass; b=QbAkz/XF/NIbueHo3pQNav7FpWG+s+gO+qG0kr8VX1jqQAfTEn3q5YIynCstMucuzny4BWi2yQ2XRoNG87giEJmAVf4gZ2jCSW6VaVeDNhnEL1gypnMxwREywOMvcp2L1l2V1UU+MONgqH0HTvbfibQVJia5VMKz2hDbLjxaj60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421159; c=relaxed/simple;
	bh=0WXRSv15ad5J1Wm3gdbDOQTvs/POzoPB7R4n4kuoe9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5fz4BJU/IKW9MRJb5Tai6a3CBXT5B72IAdgsNYlruDHiVgYBVsmMTShldrZOZFyH2Yl2EaXVpMY/x+POPOQ+egXX+o6pKjqgRQp2OGRXHt6p+tfs6tAuiznyyqZgYMMbY85uNh/NgRoRzisQVVflCZJk19XdwcDnGMT8Hnsa+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/OJYKoW; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/OJYKoW"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6611669cd16so3458534d50.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 21:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786421157; cv=none;
        d=google.com; s=arc-20260327;
        b=ko9WZ+xGZoJYT0dZIiN48Nu9yW0yzwiMetco2yIasLO64L0OgIqOcSz0qBzMuAW9Xo
         SJ35QMHiLKI0IEJ+GQgfjwA0R/VjPAjIx7Hx7xiFMLfj5eOw9akxEYupLBjsalvFh4sn
         nteus2AEBP0FS3AgyJS61MVNoc6GldB2Yk0ms4ohmNLiWSAM2VbEaR0tLVN0/3wIa7EP
         JFgWDaV+bcJaJ5wQnGwZBasVJBZ0SOou/UB3san+MJroFRozfWijtTOJeTifdpOm0quU
         bX95ulys/WJXl4y2fKVfa+bE5xL/b1Tt0Qai2F2TZEncIt5LS3QW5kgBrJTOhlEKUt4F
         np3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
        fh=BbrUgPspuTScGG1PZAIc+yneTLxCTpGtSCOhC7H9aPo=;
        b=iQr7rKRYbmPZbB6EHLXcvHqHLHnA/enNZxQOJN4Q6R8CaoI12/QGkYbyChtM6YQ83N
         4eFNb41aU3m2ZoSjJe+huvlSz4FqAssZ3On2P6sCJzBUfZGQNhVBXndMsdjV20uvhtk2
         VK/k6peHPKmM0lDmfvSsEO8e3XUJGKiyrIe0Dt+fLTVIZIOWc4BlMdQUa3E0WJ3265tc
         hBF49As1hQU1QTLgGY4yeDEkH0u++DYNAxTu0abX9uaq8rpk0S5TSja3Yqztm3vW1dPG
         86s+7D9JIL4wvlFz7sWkbitSIta0XL/mXWUewe1jP2sVTLqQMU0pZMoERyqXqnW1npT4
         nMvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786421157; x=1787025957; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
        b=A/OJYKoWNBswloq8OhgrqUARaRshto2U5/opav//SRU5sG1Uj03I8qXubHNLSvSHv+
         LpLwYFyw67JZTGYXT40EA7xSimZ00JjJiGuwnks7VlaCUnFkGvPGlaTJKJIZ63Ny1vRE
         z/GlmXufq7V8L7pt7WQk0qo0qilWkpnFDc0TbGrqjEoeW2d/z5w3grsxRnwSlHiZkMCK
         HEpZ+UWNjikt6Za/k2q+k8OwHdAw/NKgjbKKb5NJlFTSEI3ahJ8L4B29xA5w0kifsuR2
         6hubpdJQwNq/70sqs9JAniQSSTNv2Adv/VnkD36sEWIjYaV07nQY45301Pto0RRVJXsU
         Vecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786421157; x=1787025957;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
        b=E1sUqj0ddj/8O5XrlrPZKWtQ5roTXovSGu2ftyr2r47r+qjLhhU3WVjvzdSEzlLMx3
         Aybm58WBcyz9zaKy339tLxsHB7BC7KzPdRUkNgS8inFFyznTrsZ+DCkCowh3biL4/1Iu
         FiMbFsuD9r8h2GvtcBkYxZd15S75y+uJBzjsT00MLSjRy9fVRcMb0y7nGknUNBG5YT/K
         ibQf7nTlei6UhJfOTGcoLLTOjDwKfyhFQOiJZcN8hpwJZvsFcsqawPkI3Sfrn5k58fKr
         z1Cg29nUeyAbBtUUcjI5bFwaGRNoEocHNBlwDJ7nSvU5lthyv0ad70cvmo0M8Wp9286n
         QqYA==
X-Forwarded-Encrypted: i=1; AHgh+Rr14G8YkIz4IPBLSrg7vCgHYqA+FL9JYvGZpvpr/rYEyf+bizBduCgVTKldNal7xImHk6PxvT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMG44guahCBydnQQzzVsid8KpCh67JW4mATfxAGl39b1VZQluZ
	v63Fc6eFwvXQSV/HTMFy6XdUw6S+/dW/G7PSlCrtmTx74vwzt44TDyGplw4ZT/ZN+Mq+12e+ldy
	x9qiJarTYBmq8f/MNPuFOFyCzbpLkLgXIH2g21mzcXw==
X-Gm-Gg: AR+sD12NLpsj+hrIFzO4ehKzomrWvcpAQQS+zIUMchuLMD752/ULmQYBfdPr0OMk3nT
	YMJUafXldrzytHFk7FmGWji2ZbWVCxOlkS8Y3YbpSV3YeID0Qao/s4oMOBGb6VhAHAngiGAhhep
	xvtzq3OWzMXtHHa1DnRaAVDi30BbIRd9jdkE1Zr4zTfX8KRH6fIoio2SWEq3TBSzvT+ODH8Rq01
	Inp4CVzPEcufUis2BIoUHG4fMHpcEMqxqhCOy/2JM95r22Ms2VPzVrpgT2FFFi7LEB/MnpITaj+
	vTqOG8gemFEG4ueaEfSCChptaCe4A2O83GGXjZVNmlfIzWBkpsobxDpakB70wjPbA/Lg7ec4zaQ
	f7suwPXTLeiSGfgSnIRke0PTlqQWbRQ==
X-Received: by 2002:a53:acdb:0:10b0:666:541f:6355 with SMTP id
 956f58d0204a3-66b22ed1439mr132084d50.35.1786421157461; Mon, 10 Aug 2026
 21:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com> <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
 <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
In-Reply-To: <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 11 Aug 2026 14:05:45 +1000
X-Gm-Features: AUfX_mygO8g3uDRlU_tKv8cfeWEPc5DomvcU0l-wKoJbB4Wcs1CRG-FE0Jl6bRo
Message-ID: <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and VM_BIND
To: Junrui Luo <moonafterrain@outlook.com>
Cc: David Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Aug 2026 at 14:00, Junrui Luo <moonafterrain@outlook.com> wrote:
>
> On Mon, Aug 10, 2026 at 08:43:50AM +1000, David Airlie wrote:
> > Have you run a complete Vulkan CTS with NVK across this with no regressions?
> >
> > I'm weary of those limits being too low, but I think the only app that
> > might push them beyond CTS would be Forza Horizon 5 or 6.
>
> No, I have not. I don't currently have the hardware to run NVK, so I can't
> offer a CTS run or any other regression test for this.
>
> Is there a better guard that avoids a hard limit here, or does this need
> a test before it can go in?

Looking at xe it also has 1024 limit on number of syncs, but it
doesn't have any limit on number of binds,

                *bind_ops = kvmalloc_objs(struct drm_xe_vm_bind_op,
                                          args->num_binds,
                                          GFP_KERNEL | __GFP_ACCOUNT |
__GFP_RETRY_MAYFAIL | __GFP_NOWARN);

Maybe nouveau could do the same.

Dave.
>
> Thanks,
> Junrui Luo
