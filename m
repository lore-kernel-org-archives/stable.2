Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF83A2E39
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046637; cv=none; b=UzQxxl2h6HJBgmm/ngax85sCN6NMWqyYcHtjtePsksAOQx5kRAFTk/UAb5YWI7Q8yDZD0w7iPbXB/Juj3U0YfQM4+8nlweepqQN4vlmUEbNYKiAsMERtFrxh+MTJjtOn2unJCaLHUPIgeI/gipFeLQEvD2jNvVNdZfUg8eSwpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046637; c=relaxed/simple;
	bh=WHCiSnc0ONIs1uA0+0anTixoo55lB3Fa2WbuoEhoxos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+hWVuzqMUDzGvPPhETADdQYXYkPu9YXANR7E2IQilUMnz5phscJjd9DGO4iTEY+5SfWU5RkjPc/dQ0mMGzP08q0Dljo9XXuO3jM+pnjgUXOnLsZwQog6UCq1+vOFc7aO8Ii4wsV4JrFPlrkT5alOBQlvWhlYPdKsDKlTR6actg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wDDwWbNA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wDDwWbNA"
Date: Thu, 6 Aug 2026 13:03:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786046616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPKg8QMwwWLCGGZZI8KkM6QbnBXtsMGOQLkRtcQ339w=;
	b=wDDwWbNAa/jORPyFOSxyRdpfHizF+0Hq9u+chRZy2pz09OrGkjgSLKIAC5yIJDqC7rJapQ
	muXt42AKEYpyLrxuoz86VHcRPezv78Dki35zG4NGfMzirTy28sWPUQlOct1iy3f4YH8YlN
	ZFkho8hYtKdGRRqu2a43OkGgNktuh/s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Karl Erik Hofseth <karl.e.hofseth@opoint.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] memcg: keep folio's objcg same as its node
Message-ID: <anToOuVZ-xF6onE6@linux.dev>
References: <20260806165813.2526415-1-shakeel.butt@linux.dev>
 <anTPPr5hVV4aQLRD@cmpxchg.org>
 <anTfChWlK998-7sY@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anTfChWlK998-7sY@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 06, 2026 at 03:22:50PM -0400, Johannes Weiner wrote:
> Hm, it's still not quite right.
> 
> When there is a root mismatch, we cannot fall back to committing the
> old objcg. That would reintroduce Karl's issue. Not as broadly as
> before, but can still happen if the memcg tree died up to the root.
> 
> So we have to commit to the new objcg, always.
> 
> What obj_cgroup_is_root() then comes down to is whether uncharge will
> balance the page counters or not.
> 
> mem_cgroup_replace_folio() gets a new charge for the new page. We can
> just conditionalize that right away on whether the new objcg will
> actually uncharge.
> 
> mem_cgroup_migrate() currently trades the charge, but that won't work
> if the new objcg is root and won't uncharge. So we have to settle it
> right then and there.
> 
> This?

Thanks a lot Johannes, this looks much better. I will incorporate this and run
through the reproducer before sending out the v3.

