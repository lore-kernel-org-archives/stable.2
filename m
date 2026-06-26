Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799983BA241
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500005; cv=none; b=VqAoP+lSbNT4giVLtLlZ3oDP1kmvTgN6XjbewQJMBRmuC8F3qkGTx9rg/8uQnlvqKhMpiRqC7XpXYxT5SLT2gtiETMZlf6CAcwKeOLxRO3Lg1NpNJ0Rxb1ttLmY0OGMFhEjhxGRp/VZGHqYb9y+tlaMghLGbrvKGSD9rjDEOQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500005; c=relaxed/simple;
	bh=9XZqRQr/DXO0LxKf+tpIzaYO4GMeJs4kCEdyLaXiu2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs83rVi8uaCseUmqwibfre20O9hLj4q9R6i6rtA3KIsAjqD/IPxlHCCYgdkuxLArDOndjVrKJyXsdYfhs+KhF3F8qKbzr5BebuApHCNvZk6uSKmKL0zkjP5oPDb6gDjw8bXzJ4+eOFSotM3aE0mMhH3xWcF1EZrayJm8Fa97usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dAcnO2eD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="dAcnO2eD"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so15630086d6.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782500002; x=1783104802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69VEjjKoDye+wBUZ6dmdcwCgt8H3I0Ua/NDklzX2JWs=;
        b=dAcnO2eDaFxfoCwz9CoVaF0XkL/rzd5Y8ltZgUwXVXuq5eDUVxQrdIG9B/OiPEEQvm
         Q+eCzVYHIQkJelsH+g9qf7UYocUszgZ/qp7tGmDJ7m7cNAQ7WTTPFhei3sU0YvuWAZBF
         P3WlMIX9wyoWDlyDhpYsj5DsBUeKc9MpqRg+kEKEg3toIf3ggqOvHC5duQmJwO13suLR
         A9ex83CV4R0/IpCGDuAVMAoUbDCqCzniJYPG7GrbNbMGxX8WiQyIkx7xrQzZOiijaZqB
         1Gg7+imZAw60UaMwpuITG5fZcx3tVYnNTY6JnnDBfIO1Ta+hvfW3zGZLvSdQYfl6S/VC
         r3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500002; x=1783104802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69VEjjKoDye+wBUZ6dmdcwCgt8H3I0Ua/NDklzX2JWs=;
        b=fMqoQ/qrWc5H9E3PoGxABKQeTMm+p+/xhSK646quFPyNnS6VXosukMg5lUgx4z1oHA
         GOxLF+HlpbLLS5FpeD1Wxum+XJu8ppj1ti/yAerCWrzeW+xQ1jHXVupnN1yUJkLH6Prj
         n04hZk/5ahi5iWIM/3p2fxBnjqNaBIJ/6VhRKDfvHQyROjmTYp9yxsSXKurRzG8KhqGe
         61VsAVeIavJ0PoepQFx02I/Gr2ZBhgyMLACU3BwSvxptPYGRKB0aYt/fBh0lRniB4SUx
         VtAbBXSbmxJ6upXRQq8ozZ9J+zKb3E7VpmuliFcoevrH1N9c/XI0of5Cy6eAPoJeikw5
         YYMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpF4VOgrmYKdm6g0RSCnUS0GUL9QWBhWINFwvGVtm48P8iHPEPAcE+iBar/E9ufARDGbycwhcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBSWxwQ200JMWwnSstTnQplnV/tpcAJlz0yxrgIxiDOnj/LDx
	zYwa+xvyXzXv2KwuvFvykZxs9IbYIQayhoK7AamNA4p5oM6B9jtARqAQFAxn7vIycX0=
X-Gm-Gg: AfdE7cmSBu34py+g5Wu+Ddqe6BHbcXlrhGtLgeYAM4bQrlC3SEg59DaczcMzROh57Cv
	lPqr/5iC3IlgVejCLo2x/sMJSGDPFRJ6nPWc72Orz53oAEzY2jxoPbF46nUeoOZYAsqBvo8MWo7
	oO9Kmpqtl7n5q3oeYwU4MKlw2n1s33Rd9/11TcT/jylCuT6J4BsnoxIr7rFZ3tWwB8E6JCCerVQ
	VSoFQe00bpBGIKI34R/ScVzOhK8Txj+fX7qIHS/4sT3uZiwYYFbkejhg6suINDYcpj2WRiHsPkL
	n/BPAyflBkBBdVA1GBwX9oUCiIkLFkdierLM26FV7WJEPo8t46hzaZW0tIgPXW2VG+2Dr+GuGN+
	JmdwCXg8mqRAIEk6DMR63N8s4yaOIb5WkX2flbe1A61IBiaxznPbjnhN1SHZTqN14lI5xLNGRG2
	zFA/NQMOazP+Y=
X-Received: by 2002:a05:6214:3907:b0:8db:a79d:1f0d with SMTP id 6a1803df08f44-8e98609495amr30686266d6.31.1782500002098;
        Fri, 26 Jun 2026 11:53:22 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0180d3sm219727366d6.3.2026.06.26.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:53:21 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:53:20 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Breno Leitao <leitao@debian.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare()
 stub
Message-ID: <aj7KoDXJv3NByGUm@cmpxchg.org>
References: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>

On Fri, Jun 26, 2026 at 05:43:02AM -0700, Breno Leitao wrote:
> mem_cgroup_oom() passes an uninitialized "locked" to memcg1_oom_prepare()
> and reads it back in memcg1_oom_finish():
> 
> 	bool locked, ret;
> 	...
> 	if (!memcg1_oom_prepare(memcg, &locked))
> 		return false;
> 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> 	memcg1_oom_finish(memcg, locked);
> 
> This relies on memcg1_oom_prepare() setting *locked whenever it returns
> true.  The CONFIG_MEMCG_V1=y version does, but the stub used when
> CONFIG_MEMCG_V1=n returns true without touching *locked, so
> memcg1_oom_finish() consumes an uninitialized value.  On a memcg OOM this
> is reported by UBSAN:
> 
>   UBSAN: invalid-load in mm/memcontrol.c:1932:27
>   load of value 0 is not a valid value for type 'bool' (aka '_Bool')
> 
> Initialize *locked to false in the stub; with cgroup v1 compiled out
> there is no OOM lock to take.
> 
> Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I prefer this way over the idea to initialize in the caller. For the
actual implementation, the protocol is that the thing is initialized
when the function returns true. This version of the fix maintains that
for the dummy as well:

> ---
>  mm/memcontrol-v1.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index f92f81108d5ed..4fa6e2bc8413f 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -107,7 +107,11 @@ static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
>  static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
>  
> -static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
> +static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
> +{
> +	*locked = false;
> +	return true;
> +}
>  static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
>  static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
