Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7743E5A2B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942751; cv=none; b=e2vYs8MEgaQGUJ+4mJv1e2B8/TDHP8DT4VgebrscqjkGBt/c8Lv1u2yLPFQBlFMhDCIPnJBLwb58h7lY1A/rK4wJL2fr81/0fBI8Tue2lCeh9FTzgZo2mEtdp7rXEJijYK2t9XvybWvdZP+qW/VAzrbrJBSLEsbhzKoPAmFQax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942751; c=relaxed/simple;
	bh=A4zo2+xQeX1vbXQna3iVpqkY6KIz76I1W77x/MUxy0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw73/CXyyhYCu72MGd9yLITi9gMPDNlrTQ774SxDCbAIdYygYua+tpn62J7EiQiEnH08SfrFIrDuHxBtqCaio5uhbSIuI/jLtWC02BPgm/8J53sc76ZbUuK10KFYW4MxznNy4THkTW6eSjaNA8wRRFj4YgtS3oi38XMDRiqSwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=VA8CuCvg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="VA8CuCvg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b77b150aso25437275e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942747; x=1784547547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SyGrauJ6Z/D7QxLsQH4fnjbmvOpSdbv71QSALvp4E6s=;
        b=VA8CuCvgfGGkCyqKmHeOkFtpBz32Tl6QHxXPxixf9osP8opwAIWCbsAwwYyUxgIiad
         94hjON7VcI5h7qGfptpg+PsOVw1jSgDP1bsvQFGdho7u1E6mqFjVud2rSCN39mtGyFcr
         escfbKYAw5x+LNSXeZqEgzOAYNa7MIk5DED5rfAuHptJjeWGsrTgud1fo1CtNm+DBNHS
         fQSKKYbcA8zTBR/FPxNVAFzwjzdWmLOYP4uzmduu6MiwEhY3hAkyvM4ditxI8ZDtukML
         JLGTjmj7EQ2GVRPKux3PbRm2UK29kEOVVeWqtz33oV7tmYq7WmBrNQIQmbFIDr4eXmsV
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942747; x=1784547547;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyGrauJ6Z/D7QxLsQH4fnjbmvOpSdbv71QSALvp4E6s=;
        b=rC5W+GklKfuCSXuA5SY0eob5dynkJLJX6iewiWKaMnPq6/iGMRxPECmG1vxO2p1g4d
         v/0FaXYcWQ6OcZPANPAEgkzeDSRruF74fX3rKnPOiyx+/nItHQ16TjQ3flW+0kN5T84r
         SMHU3lTEbHo15rX358qL8T29beGe+ngKfQRvgvKCEn79/kp6d0LOQnJp94oi2h540LkG
         G7gi6huHv9zN5e8lLMs4jv5W+eJ59d1dbGViuP+WakZRQFdMq6JQz0+vTW5FM5qz022N
         IX4nrEKjHdHhcXOtA8EINGaPWFYxamXxy5Y5cpHuo7pTEqD04Pbgp/iEwblVLITXvrET
         Zo6A==
X-Forwarded-Encrypted: i=1; AHgh+RqB76o3oFBtxLRK60ZCqoHguTiSqNA428kwRAdK/eXDOkOJ835dto489KsBRYus4kPwKv8DxC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhH5JrqfYY6n+Cz4GeORzRJrZqxJW+qt0AfNapCMUdBgmJ3Wf
	d/wNRM61vEGKvqkDUryVdPUnSjimFf44TnPtVqbeFxBTDZtQrVJ5fnN+Fb+7GlOyNm4=
X-Gm-Gg: AfdE7cnKQQnSiLDPpz1l4YhK4AHONNGovKSTlJ/oHqgTa1QOQKIAk+27uy3bLVNMSAI
	aiS6BC5+r5807Bh0mifLn+YucNe5y9HkAcF7EhbMBKe8XKuCORCKdBFoejMMcTgXOi9Xp2oZmP4
	ruqtn+FANmCXrjV1FkAZVJSKmLvY8WjQfg19Srn0ZaRFiZTRlVa2fx92ErN3af1SecPtVQZH/6F
	lZEOSrM/tqjbicfaMaMfqaFc5BiIIMfo5pesDPnEQM3PwtKFCnb4cqN1Ox6SsdPBmSLEOff1vNU
	aipcVK/qXm7JiC5I1FjdOvA6hCZJMd6QTfvVUiusvL+FKjvborkOoW9vfsqOJdvEYbuRwiCgeXZ
	CDZ/TFSMq5Mswni0zjTGMgu9hjz0ohPOSncTRcaGGqpJY88AvbZXHp/zTX/VTVxMgb3//k/uQO7
	t0ecw3FJot9g==
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-493f884f5f2mr85117975e9.37.1783942746646;
        Mon, 13 Jul 2026 04:39:06 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm372032495e9.3.2026.07.13.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:39:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:39:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: update state_local when flushing NMI
 stats
Message-ID: <20260713113901.GG276793@cmpxchg.org>
References: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713085053.2916813-1-guopeng.zhang@linux.dev>

On Mon, Jul 13, 2026 at 04:50:53PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> flush_nmi_stats() updates state[] for kmem and slab counters but leaves
> the corresponding state_local[] counters unchanged. Local kmem and
> slab statistics therefore miss updates collected through the NMI-safe
> atomic path.
> 
> Update state_local[] together with state[].
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

This issue affects memcg1 but also the workingset shrinker.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

And we should probably CC: stable # 6.15. Shakeel?
