Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EC3B9931
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574328; cv=none; b=l6N0+FDTtOM7YqA3BBanqe1VO4Pcp5g7kO7HFSjFMJqJVvcZ1DWkv2QYUYHG5ydS6uzSz/m8wXr9lNGu3MbKjHUhzfE/S/2QkvcIaocmySCdP8MZCvXiEQOVqEJctuZaA4q/mcCqZ6qKBHmhRceaqULL8KlZFfZlYPFMH6Q2dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574328; c=relaxed/simple;
	bh=+6aMjHH+Jl+Ml/kjCyAc+ni40OSaFZs1senFwZLmkis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ueYTAGxekFcshxL7RQTLnhpYQ1XeZL1CxCEWVUy+ex6RN+7fFbyOEuXooPEdVehA4/+yu64MIPRQYjPO+mBysnEXeHzGu79/vzskGr0EtTuYQ+wSbdyDMR4MC/vpkEY+5eOSDbuaaqFSGLAxofNeE5hVMA1fhTscVz6soB78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=mxy947Qa; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="mxy947Qa"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe208so11092416d6.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789574314; x=1790179114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bjcBGUR39i2CtxsYZA+y8R1kv00jh+PXwHXxQnV1eiQ=;
        b=mxy947Qail07AL9t2Ag0dSp7kFCQr+bAzVIypiyzW0zASsfINssXUmISG1WGaiaxL9
         zMAIp6+RhmhTn4fPH+98BVQ7RIBBHGYvMJyFE+4/n6rubXroqjT1ofD3x7gSLqKAsZIL
         Sq92DQFsU8zhBvSCtlYaBNSrEQh18Awe6Omn32t82761kFBwE7EL0rqpnQ4QvucznX+z
         o8o1c48JZ+9pIgd8xih/5XrUvEGwFXbv3XaphihX05pMeqPSiqKen08/YeZdeXsOBFdD
         Tvnxc2uOOrhqL56m59ngfpsIWwWFEH4NN1GvRoGx6uZ82TmniIt7+/aD/m5d6CO3Xwhi
         bGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574314; x=1790179114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjcBGUR39i2CtxsYZA+y8R1kv00jh+PXwHXxQnV1eiQ=;
        b=SfRpwonJb3el7f9AcW69+M1tx17Uakx8jukKbyvPEYZV2AmKuUncm2J64JcI5ufYPK
         DlOW8BhWZluh5lVvjONfd2zv+gEQFyFEyBt6SV0PDrlXKyHQeqtjuM/5n3P8FwjUiWlA
         6/hTewIXUF4lZPy7pPjuNwk5FO3yysGWHgMeQYjJLNkgY8hNzeptcFySX/iUONRulXyX
         Q2vUhyPT3ukugSmEQObDc0AzIj8hDOwbWPnOWY+DlX8vGamGy+ZZdq+Cu/+bXEwX9Qrm
         lYQX4sDgHQYnMD+c3kWXq7MQSOmoSGJ8p/Y7tkTJSC9jdpkeuEnJxi/ttUUyTpW54MqV
         DhAA==
X-Forwarded-Encrypted: i=1; AKwUvBxLCEZUJlQEYZmv5fxcX7s9sLlIFAU0yTMPSoac/YyTByEBQStdaoNWqsWclv3AvwGezVHoIrI=@vger.kernel.org
X-Gm-Message-State: AFuF++lejRkngLcKWobDu0L6w/fHPIpWUQQx8yUJ3gdZsx5J+CyVXHkB
	EKQeepGNhMUlyO/zeknp4Q1b+oGVLY1B1ubBPz4EGF+n2YUAdfSSarceQfCWAOPvu5E=
X-Gm-Gg: AYBFou1+XW5qW0/Fl4mPvxYU3vDDaj5zipYKlOwj50LEKHaMCDQWPbM9RfQSja+Iiai
	fdoWtt5dA1q1XZvhejWV2qaG1Q6+G0vRcS36FgCFLBiSy/1NdtLurhfyQXNsGuJqVSGVxe4S10d
	BQ2A+o/zqm1tM98XYPHGJpZBJeuwcwc1hN/mIqHPopOYoihXDxAblol4PdwraUBHsTdn2fhd1e6
	6p1lT+oKr2Bi+aJnQR2hUvc20duo1f17xjaob7+Bac3R0G1hLWaG+npN8cNfX+yVPH6MR9aymy9
	iZ8SnaPdS1cweaIm8kXxffxXIqXAholwNd1CwNIUbf88xRg691tMSuSiCihab88NPsa8wpbQS4F
	5eNS4IAFrn7ZOSJs9TmOjk7VY9oiWm9SMjvY8uhPvba3raItuOjwkoKFcS6lVDvMHCDfET/vQWT
	Y6Q38al8oHkV8VfvPBtztaS+cvsPvDiEYgin1q22oaIZEdUVPap47cEQfqD2HFLGM8P0zx4Q==
X-Received: by 2002:a05:6214:1248:b0:90e:96d1:40d3 with SMTP id 6a1803df08f44-9123d7a5b32mr54271566d6.20.1789574313980;
        Wed, 16 Sep 2026 08:58:33 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be609dcsm28537916d6.15.2026.09.16.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:58:32 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:58:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>, akpm@linux-foundation.org,
	abuehaze@amazon.com, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, brendan.jackman@linux.dev, david@redhat.com,
	dgc@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org,
	hch@infradead.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mhocko@suse.com, ritesh.list@gmail.com,
	rvvandan@amazon.com, stable@vger.kernel.org, surenb@google.com,
	willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH v4] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <aqq8pWI0u1IZNWHT@cmpxchg.org>
References: <20260905174239.99e31515fabe220aa7d8e6fa@linux-foundation.org>
 <20260910114602.926944-1-dipiets@amazon.it>
 <aqQlUr-1h07G8JWM@cmpxchg.org>
 <8d6a8a63-4adc-458a-b548-a47bf5ff8eb7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6a8a63-4adc-458a-b548-a47bf5ff8eb7@kernel.org>

On Wed, Sep 16, 2026 at 01:24:31PM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/11/26 17:59, Johannes Weiner wrote:
> > The access to
> > MIGRATE_HIGHATOMIC that it points out is in itself too generous. This
> > seems like a real but separate bug. It will allow GFP_TRANSHUGE_LIGHT
> > into the highatomic reserves as well, for example.
> 
> I don't follow this part. For ALLOC_HIGHATOMIC you need __GFP_HIGH in
> alloc_flags_nonblocking(). So GFP_TRANSHUGE_LIGHT won't get the access, no?

rmqueue_buddy() has this:

			/*
			 * If the allocation fails, allow OOM handling and
			 * order-0 (atomic) allocs access to HIGHATOMIC
			 * reserves as failing now is worse than failing a
			 * high-order atomic allocation in the future.
			 */
			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);

It says "atomic", but it's checking only ALLOC_NON_BLOCK, which is
broader than GFP_ATOMIC. alloc_flags_nonblocking();

	if (gfp_mask & __GFP_DIRECT_RECLAIM)
		return 0;

	if (gfp_mask & __GFP_NOMEMALLOC)
		return 0;

	alloc_flags |= ALLOC_NON_BLOCK;

	if (order > 0 && (gfp_mask & __GFP_HIGH))
		alloc_flags |= ALLOC_HIGHATOMIC;

So this can apply to random !direct_reclaim requests, no?

I have to correct myself on GFP_TRANSHUGE_LIGHT because it happens to
include __GFP_NOMEMALLOC, and so won't actually get ALLOC_NON_BLOCK.

But what about random GFP_NOWAIT and & ~__GFP_DIRECT_RECLAIM sites?
Those explicitly don't get watermark exemptions already, and weren't
the intent of the rmqueue_buddy() exemption above.

Something like this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..c79cc7aa4dff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3246,7 +3246,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * reserves as failing now is worse than failing a
 			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+			if (!page && ((alloc_flags & ALLOC_OOM) ||
+				      ((alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59..11714ddca254 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -60,6 +60,9 @@
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flag combination from GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*

> Unless I'm mistaken about that MIGRATE_HIGHATOMIC part, it seems all sashiko
> concerns can be dismissed and then indeed v4 is the better version.

It looks like a real issue to me, but one that already exists
independent of Salvatore's change.
