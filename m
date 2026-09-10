Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C768385539
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068251; cv=none; b=iX4p8aC4pFzPBtVkULDUIWqNO5IltEXjKUuLuc+zwdKLef0YQ+buwjiLCXPIMplFaVTurxzWutBpKbe1dx8A+ZHC+sC0GaWLY8BvfXd9gdmpwJfOkkAo+3k6IhLnMRjiTQjqbpwUoY0gRipbx9hIXa6ezUEc0pEAgbBMebw1CAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068251; c=relaxed/simple;
	bh=NFdPHhc3LsLcrwO8I1jm9fAG7WMoI0tLSX9zCgLEAR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJLmd0PjIChzYDVV6KLNM8x0z8b44dfNeTU23MUXgP2jV+qinpX6TNB2VCSzBF6Hc4wxMav+nwL01bSHhuBE3hHB8NKYOwnXIz2UqQ6seylv17emONYU7G9v5rzx5lHVoJgu0CTWPyF6LuxWKS1BgDN8vnH5FvlqxuX15odTFMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=pkDF1Iw4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="pkDF1Iw4"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-910316a2fc9so480496d6.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789068245; x=1789673045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cgtHhNSTchXYsp+hlynbz5tZ66bgVPaYzguNWbLkTBs=;
        b=pkDF1Iw4g9w3t2bXjLYcTPESzHkp7bFctyPqxdWu2j4rcpNY53KBgDcYWj+dAryKC3
         BLhKBXsK0bH3Aj8p7scMf2/i/HOjveOgMrMQfgXt8bqGJup+fIoC2wE1o8WO2ARY8XxH
         Z3V3OmFBjqwgY5Ddk0XDvtdNPEV9h+t/jUwTL5kZIwAlGUyojhUWI6gnv2aqo97Ss4s5
         65HP+roRSIHOcsMfbUyNjn+h+2tMl/8qdJ0EzQHDSKGWQMPthv4AdY8ysGG9KZ97xzZY
         31hjUb5nBXT2SgczDalJ/a+HAzCnjDmkLDfofqziwo/RfYcG1YoxzpycCqqxHLp4Prpa
         4r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068245; x=1789673045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgtHhNSTchXYsp+hlynbz5tZ66bgVPaYzguNWbLkTBs=;
        b=P1eMSSqZmQBIAZhftrZ92LpV4Lw09fZW1RC4Yw4FiAnAffGGShQHX0Ol2I86DE09wr
         kzawedZN5kPPEqDQFfrwa89xwVQtGb17nHqlgcZpv7ETXiby9diwuaUkEcpC/CiXOFgp
         up0EAxStZy7qtSb09jFFBr5nUIBoT0VDB+4luttRZeKpf04uhWNmSkOS7t2bHRVAoxU4
         ylNfpq8381JNeDDvptK6ne+mYydRHHbIr/efelt5um1c0rgCGT9pVlgUH5MSZwZlcd9u
         4shjs1VWBYuBVrJD3BWtvHU/7AWsqqFwHnKv1xkbefDUgZoELNfXMj4sbsg7FuEMjbKB
         yoSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpW6Rvw9OlIbKwLtx3HXXib+MIAHNDDCzVzzcIPRL5Si+gkrRV64eVi+/M5q+e5AUmHNqKgf0=@vger.kernel.org
X-Gm-Message-State: AFuF++lqg8IP76HmkphmUaEf6kpfBDkEJtb7/JPdsbG9A4zNLfccCWuG
	Ja19sGTEnv3Jmtu2nwxDVxehsY17FShMJbedsTpK8wKpS+6CtrosX03xwlc1BCcsafg=
X-Gm-Gg: AYBFou0tST9GXqdv/HxeKe/6tw90gwKfW8Qsa6xTzVUeDnToI3ULbLiC7bcGy39/NhX
	xQrU1qVnM9r72Ay3d0DODUVCtGTS+BLiRYBWg4Ts5uC5J7BmOCHEXTQfaUHRZ4Ixlkds4kq7gXx
	Bj0vrIKrW0Gju1eHoV0yRCbqNHykLOFbSc69mJBAYNdSCZBlalJ7OBVBfMpiTgGXifAqocC8OQk
	9Kpr2ot7+VjFNYlG6O2IdvypdYEl5ISqaf35gX28sI7amyL1Tw57P411xQSQaGlCep5uQdsX1tV
	932LjjWB/DwObAzOSPd2kZLw9ItvK2KPsb3EYCXEnp/llW5lMWfVZ+rCPeZGD/Vq2JJuyO2hnil
	iWoY40+qiro8tResDHpVXL+T/h29SmjApcwr3ul05rb0SAxAWwWHdttX5Iz7b2KBrcdU5XiZ28h
	UZeTgAgIu299iQ/aaUdNirE0s/vytS/RFaSg1SuK0bnRF0e6mPScruSWQI8oX/JeFyNjz5lQ==
X-Received: by 2002:a05:6214:226a:b0:911:9375:bc33 with SMTP id 6a1803df08f44-912120f2d2bmr2797916d6.30.1789068240280;
        Thu, 10 Sep 2026 12:24:00 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f202856sm3329906d6.2.2026.09.10.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:23:59 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:23:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-ID: <aqMDyxhGXZyhcm5H@cmpxchg.org>
References: <20260904022657.2656810-1-ziy@nvidia.com>
 <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org>
 <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com>

On Sun, Sep 06, 2026 at 06:46:55PM -0400, Zi Yan wrote:
> On Sun Sep 6, 2026 at 9:33 AM EDT, Sasha Levin wrote:
> >> __GFP_ACCOUNT is needed for xarray node allocation accounting when
> >> XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
> >> convergence regression") fixed a workingset regression with it.
> >> xas_split_alloc() does not have it and needs to be fixed.
> >
> > Mainline's c299a2285d9d takes a reference on the folio's memcg with
> > get_mem_cgroup_from_folio() and holds it in current->active_memcg for the
> > duration of __folio_split() - rcu_read_lock()+css_tryget(), released with
> > mem_cgroup_put() afterwards. This 6.6.y version instead holds a bare
> > folio_memcg(folio) pointer across the same window, which includes a TLB
> > shootdown and several lock acquisitions - exactly the kind of window the
> > upstream refcount exists to close.
> >
> > 6.6 already has rcu_read_lock(), css_tryget() and mem_cgroup_put() available,
> > so nothing's missing to do this the same way upstream does.  Could you resend a
> > v2 that takes and drops the reference (under CONFIG_MEMCG, as upstream does)?
> 
> No, this is not needed. Before commit f1cf8d2f36dc3 ("mm: memcontrol:
> eliminate the problem of dying memory cgroup for LRU folios"), like
> v6.6, a charged folio take a ref on its memcg. During split, the folio
> is locked, so will not be uncharged. As a result, its memcg will not go
> away.

Yes. It's safe until that last unlock & free in
__split_huge_page(). We don't have allocations or indirect references
to current->active_memcg afterwards that I can see.

> According to Claude, adding a ref there might cause a deadlock when a
> to-be-split folio has a dying memcg, where css_tryget() keeps failing
> and folio_memcg() keeps returning the same memcg.

If the cgroup was rmdir'd, only css_tryget_online() would fail. The
page itself holds a reference, keeping the dying cgroup from being
freed. And css_tryget() would still work.

So it would be doable if you wanted to keep the backport closer to
what we have upstream. But yes, it's not strictly necessary.

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
