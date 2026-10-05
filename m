Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96B41F7FD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195693; cv=none; b=g5NAJJMFjwL9w/LV1Wj/P4SOI3WuwYF0Ue4tmrrU/2Sl/xeKElqv1DEt/Adud7YW1safxvg9QS1CodhCXzmDNv5N47rlfaLo2cuH4RGKutMP1C2UfCgRfcjthdzdTllRz5T5ccNqo/MZQDl4dt2a8IeV2pHLANf5uJhjQilDg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195693; c=relaxed/simple;
	bh=K0Zp9opT8YiIxnyesajyW83vYzMWJ2UB1wS3KyXFGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2KSfXB5sNXg6ulE3PHDlBbE+WyBOQG4QDQ1XV5mU0NnNomFFbkdD+AF/yrSNmTrP/BU7OjsqqLAR5AAAd4xRudan5f8WEFDjO449KEpRiEth38AhysC/gKM7b9emS1hSDJo6hYuIuwW/Xg8QFmJ07BLRz5zGNDBquFgdevXxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN1/F5sR; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN1/F5sR"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso314923a12.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791195692; x=1791800492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K0Zp9opT8YiIxnyesajyW83vYzMWJ2UB1wS3KyXFGYY=;
        b=kN1/F5sRk2OpYHUOPuorhrW+rcEpqH2XqT7Vuvyi/fsRgL/BrdgY0YmokFfWb3a5nK
         6Jj/E8i8sQWLC8yEfc35DNaFCNxH1YpJ2ANE13aE69T8Ttg1pXDXv35ktUv541jdgzfS
         S0gT6nwCx5rzGkQQmmP4wGv/yGsF93PbqUYPNdo7hf51EfXxo0TPZQJo6nc3oLdKIiZF
         Zp4CzAvJPjHcxG3r0yZouQEvTp9ndYlmRvh+WHjWVeOHLKehPIUOwbAifVA2rahXt261
         48O+iT03SQ3tRGXDDbccsP4BWxI90XLhMnuqy09U3loHCRGMKpxdFYvUVW1Gcj4BTAyu
         BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195692; x=1791800492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K0Zp9opT8YiIxnyesajyW83vYzMWJ2UB1wS3KyXFGYY=;
        b=ZYKZYrdx5KnQTI8YKv3YfAsqPpTY/s7oHo8Ahdu8v0L0SsNZyucUH3qejbKgtdr12p
         yaBJj2P9jcUjk6cbJc1IrpTavbcRwLY9IconAAt38apEhVHcw7IN/Gdb8kWHudph4RjC
         1siASYEvgAiO0FQHuB9Yi1ubkvKg1Pld3JCYw+P3YGHatAMAdOfO8Muo3z7vfKOkaSza
         im3q9h4it8EL1H3FHekGQ9ZLGzSuv1Lrh+DTpM/DJh5soWYA6KCthZ72pZJ2Ch7ZNv3q
         qVFgeB9GgXEnE7tCV3vRDVagxkZRBNn8jEwl1sxIh8bMDgGgHfsnVaWSmXF5/cfvSaRi
         SfqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2GVvl7KM5LrSP4kkFZWj5gPkitoL2z8CGN/RbMdCbmfFLxqgggemDDiPeiDRqwS3mTHlj2f0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnSq0VsDHSXFfbhO0WamhSIUR98VczP5a5vbShVF3cxpO4Lxf8
	6yh3Do6CsVFGPOjWfcLJj+DTTA7wH3uFAwWKmGNXKrWcjQFR3H6iATN5
X-Gm-Gg: AYBFou1QsimamLbzUsKdZoJB5SKPaVN1ijwzhXAnsscqcBr/xoP6uTRDfEWqMhMTBgc
	/3clV2dgKMjXHaIeGq+uUF52QNZVMd8S2SaUhjkWTT3ywLkhyWx9gMfP3DmBVuYrCLGlE2/QoNR
	rzSHt10N4VjDR+cK5RlgkwTlRpgw0XiW08T9/4J+NZfC12gWfpGDgo85dempO71dKnsNXaN91g9
	iZ0pXSTEhWaGYFHYLR7sFFlwGPC9vZwEGwMP9ZvbL418WX0pP3jJOniSD9RilZDNRAPF092fcnU
	kfesW1fmwq2SLe7X3H+h08nYl5bJEg+xWTg6S0R2KkWu4unvMq6wE/Nzffbvjfcz0qBVrrOIxFU
	zmTC5t8rf0pcMUhbaDrJy2l92dNZB2pddX9iEhNotv6aLV7jTqrnNYcN2WiTjpuHbSVAqoN9U/g
	kyEatqGMdSoDhCQRjxIHaTX6W91jJ3PYKS9e+9vBhAWRk9WTqVW8ubTWk3fckv3lJwzOW2M7HYi
	xd7UzsespJ0z0sgr6ehG3px
X-Received: by 2002:a17:90b:5483:b0:3a4:b509:88be with SMTP id 98e67ed59e1d1-3a6ce981729mr5582306a91.15.1791195691651;
        Mon, 05 Oct 2026 03:21:31 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd0cd76bsm8291372a91.2.2026.10.05.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:21:31 -0700 (PDT)
Date: Mon, 5 Oct 2026 18:21:23 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, ljs@kernel.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-ID: <4cdb95f5-4140-4116-8247-c04f4b2a5c4c@gmail.com>
References: <20261005062236.564210-1-vernon2gm@gmail.com>
 <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>

On Mon, Oct 05, 2026 at 02:30:36PM +0800, Barry Song wrote:
> On Mon, Oct 5, 2026 at 2:23 PM Vernon Yang <vernon2gm@gmail.com> wrote:
> >
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > When the cgroup has no memory pressure at all, writing to
> > /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> > NUMA node, causing increase in the writer cgroup's memory PSI.
> >
> > Due to this reclaim is performed in the context of the write(),
> > accounted as memory pressure on the writer, like
> > commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > as memory pressure"). This is unexpected, the phenomenon resembling
> > senpai will appear again.
> >
> > The Documentation/ABI/stable/sysfs-devices-node documentation also
> > notes that "This interface is equivalent to the memcg variant."
> >
> > This patch unifies the semantics of the memcg and node interfaces:
> > per-node proactive reclaim is no longer counted as memory pressure,
> > and the per-node proactive reclaim interface no longer produces
> > phantom pressure.
> >
> > I ran demo[1] that performs per-node proactive reclaim 10000 times
> > in qemu, writer cgroup memory.pressure as follows:
> >
> > without patch:
> >
> > some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> > full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> >
> > with patch:
> >
> > some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> > full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> >
> > [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi
> >
> > Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
>
> This seems to be a valid concern. Personally, I don't like
> having the code depend on whether `__node_reclaim()` and
> `node_reclaim()` are called from proactive reclaim or page
> allocation.
>
> Can't we check whether `sc->proactive` is true? Am I missing
> something?

It is also fine to directly check `sc->proactive` in __node_reclaim().

I chose the current coding because a previous similar fix commit
e22c6ed90aa9 was written this way, and it is also very clear.

Of course, it depends on everyone's preference. If everyone prefers to
directly check `sc->proactive`, please let me know clearly. Thanks!

--
Cheers,
Vernon
