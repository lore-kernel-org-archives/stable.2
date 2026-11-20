Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135782;
	b=jix3AgCM5c8IQOxYr5MgKXDZ4qF2vSsdS4NMCwj6YBtbIkHZ5/Uc6XEMTcSkCDhwBKTy
	 Av5GwxcLa9gS/YTEQMqNk5+MdQ1OcSSu+AJySUyQuagUlIiURKH2W7ndAynd60tmPBXCz
	 Vmwz3S4U+1evS9znSp8m5mkC17luhMsVSI6N+54RbN7WeVRrPv43lItIBlYG0UZbNJV2/
	 A1lZscBQyCZyerOo9IAYOizaDMBSv/OqHUxHo1Jp4XxVab8oZ6P4S747YFS9nnqJm6nLE
	 csEjzRUHOB901YYy2TilW+H1DA/PREq1AaSs2yZyXBIARrXLHq33SXib6Xjr6Ux+1HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xkS1ralUzvuQKKu8b7gkCgxda4Hz1Nq+3pjzMQUco7M=;
	b=tcp+VoDEiM+wdWT+YK3NlIBJUjo9k57eNtSuk8Ys4divQdwl7Y6a5hcmZpjqVGPB4NOr
	 ROJDwm6paeClma3DmBm3mBTim2UvxuuTkXsJYwvn591buIpa1aO3nvVpSe6wCMGYozwlB
	 gWc+VDejrJFxI+RHaBzesfHvb9z2/oGdDSNPjdp3346VO/k0diH78TUl/2QF9l0H+OJNM
	 VoXcisove/lbmzvYts0etRqilKNFpXWEzq5BOxFmFcPQu6CtxlbO2bg0q0MgO5MGt9+KF
	 8uWevXH6HmYRou06NNuMHG2UE+jCFBzMS7GpO+kRPeKZKCHewBE/5KXa2ztAD3hvqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGuAXDAP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EE606A326;
	Fri, 20 Nov 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGuAXDAP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0085E1F000C4;
	Fri, 20 Nov 2026 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795135782;
	bh=xkS1ralUzvuQKKu8b7gkCgxda4Hz1Nq+3pjzMQUco7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aGuAXDAPUStqYD3A3YZkgo8Xe+lSt4wKwYW/DoY5jQoiLKq7jxiFcW8Td0wS3NJKo
	 KlmlaawvS8x4FEZPRxDdfubLGqbYs6JuMyL9x6KZAdpufm8muhmxICpxPatvB1MH38
	 r7o1H8ONwOx2c25JYrs6RvdvYjZZiSqZi2hVQRqoaXgyKPi5Ozdi6BeVtYIxIYcaPA
	 4xrZIOGC90t6yGHHiz5LEc6NDi4IWBep4rHc26G2gJPHgVSZtZEhEAXMXhkKzGxEk0
	 SbXR33DJqWt1TVFyy9Cr5UJ55rhBDE7NAqHidr+syqqkvgKQlOK/bKHzjBD43cF52F
	 np5huzxb3BYcg==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Thu, 19 Nov 2026 16:49:34 -0800
Message-ID: <20261120004935.86433-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120001300.11809-1-evanfengff@gmail.com>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 16:13:00 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> On Wed, 18 Nov 2026 17:42:46 -0800 SJ Park <sj@kernel.org> wrote:
> 
> [...]
> > But, this could make has_schemes_to_apply has false positive.  How about
> > calling damos_Walk_cancel() when has_schemes_to_apply is false, like below?
> 
> Thanks for the review.  You are right about the false positive.
> 
> I tried your change.  It fixes the hang, but has_schemes_to_apply is also
> false whenever no scheme has reached its next_apply_sis yet, so it cancels
> the walks of activated schemes too.  In my test (one stat scheme, default
> intervals) 18 of 20 update_schemes_tried_regions writes got -ECANCELED,
> and two selftests fail: sysfs_update_schemes_tried_regions_wss_estimation.py
> and sysfs_update_schemes_tried_regions_hang.py.

You're right.  Thanks for further testing and sharing the results.

> 
> What do you think about cancelling only when no scheme is activated?
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
>  	struct damon_target *t;
>  	struct damos *s;
>  	bool has_schemes_to_apply = false;
> +	bool has_activated_schemes = false;
>  	unsigned long max_region_sz;
>  
>  	damon_for_each_scheme(s, c) {
> +		if (s->wmarks.activated)
> +			has_activated_schemes = true;
> +
>  		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
>  			continue;
>  
> @@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
>  		damos_adjust_quota(c, s);
>  	}
>  
> -	if (!has_schemes_to_apply)
> +	if (!has_schemes_to_apply) {
> +		/* The walk cannot be completed while no scheme is activated */
> +		if (!has_activated_schemes)
> +			damos_walk_cancel(c);
>  		return;
> +	}
>  
>  	max_region_sz = damon_region_sz_limit(c);
>  	mutex_lock(&c->walk_control_lock);
> '''

Looks good to me.

> 
> With this the hang is gone, 20 of 20 writes succeed while the scheme is
> activated, and kunit and selftests results are the same as on the base
> kernel.
> 
> I will send v2 with this if you are ok with it.

Yes, I'm ok with it.  Please wait ~1 day before posting the v2, so that others
can also add comments if they have.


Thanks,
SJ

[...]
