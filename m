Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A340410D09
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830867; cv=none; b=S/biMiigZvkqs50va7xTjYW06ua8v6wJEQwDRWdTV8A/vngYRTGLEEiA5R3+LhG/1oPYiblyRhVkPIU5w2wdoCnmYlS42mMZvd4BSvKZUNxy7V3JAAmOjAbDvbJrUjtm+jATNcYCI7TOmCaLgCHKx+gcQR+6X8SAs9eM85RjgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830867; c=relaxed/simple;
	bh=I/zLi514bfgMzHbULipHGX78klpg+H8YN/GCoHJja18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6u5UZ4QdRaS0Y2z/97VyaWW/3QL9qWVtelH5gkfyCtaM92vbbSAzus3Nz1o7AVHbR2tGuOlaVGizGu5pCnO7HoekicoDml4mEciD1UOmXbgTvEsts3ADjuO38JtHfquAcpE4Uvi7rXAokd5/9gq4CuomvpHsZAYmqjFfciX8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FmJRX50X; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FmJRX50X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782830854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec4y5CC9osX1Fg3YZN+Ow/rvBlJD1nIcT1j8LM/GIAs=;
	b=FmJRX50XWFqK5QpU/Lvd2417iY8koi8gFcrrlCJZ0ywgG9BIYPSxM1kBham4gcZRtHT+3C
	HssL7y8kdeHl0btKk6Tdd1envqSoEJNhkTWliRUtxC/hZY0yn+CRBrH+UO+Tjmy9mlxfPr
	bBh65Em9nvNfgtDhFGZPfLqWE4cVp4w=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: vbabka@kernel.org,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does not match
Date: Tue, 30 Jun 2026 22:47:14 +0800
Message-Id: <20260630144714.66550-1-lance.yang@linux.dev>
In-Reply-To: <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
References: <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Jun 30, 2026 at 03:39:56PM +0200, David Hildenbrand (Arm) wrote:
>On 6/30/26 09:44, Vlastimil Babka (SUSE) wrote:
>> On 6/30/26 03:35, Zi Yan wrote:
>>> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
>>> range does not match the requested one, the code errors out with EINVAL
>>> without freeing the allocated PFNs and causes free page leaks. Fix it by
>>> calling release_free_list() in the error path.
>>>
>>> The issue is reported by Sashiko[1].
>> 
>> So this?
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> 
>>> Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
>>> Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero-at-free-v1-0-f4ce3930d10f@nvidia.com [1]
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: stable@vger.kernel.org
>> 
>> Hm well, it's a path that warns, can only happen due to a development error?
>> Not sure we care about stable then. Anyway.
>> 
>
>If someone would run into the WARN we would already be in Fixes: territory.
>
>it's a path that should never be executed. If it does, the real issue must be fixed.
>
>So (a) I don't think this is stable material (b) I am skeptical that this is
>even a Fixes and (c) I am wondering whether we should touch this *at all*.

FWIW, this patch looks fine defensively, but probably not a stable
material unless we know a real caller can hit it :)

Cheers, Lance
