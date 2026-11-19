Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052580;
	b=nvAk9RUIOwerQ+2/VvkMcPfa8ItbhvL4m6wh+KIi44HuwVAEntoWMkoZS5fPIi51iI/T
	 DtDb74yKvF/6oqfgcaHU2BdWqNHkP/YdpTROQbVARGGSq5YVMA9piKMNdd2bxKsu6aiw1
	 PvovR0jD5tV+quvGJ5rHmjBXMu1NBaVKUodK2+hs9kCB9BJQG1qBwIbHPmSAcbovzDzft
	 HIivzjcNH1n11ELrlbsehQHMyGgY1P/3ulLnYwcq4QUfdEzSFjkWAfaH2Nk3HTAUc0Umw
	 +hpWuS2quHOgjMnzkfJErgU8Vfqon74PHFWbV8UPuQeXj6bZkn1m0qfqZTGM5z/ZKHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uNFMtGegQbyx2nsp7e9y5ycgaKcKYuwzocjWkIqM9lc=;
	b=PMCicCLzbazA5dyms3LZN8/x+9nyKlTWe7V8rvuC7+sq8bFv7QVWvrC4/ATod2tm1GMP
	 MwjXsi0b0RrrqJe1sbKYSPCmpxilJftNoIcGIrhLpN2K9z2h7S8heWNGvVWACve8ushez
	 zgjncuKp+slpVUak8rwD+aNMyAPODfhCujCEA3t8BxDGEdbSqpKMsoz68odjqHIi2tgKC
	 5uF//Y0qcn7sODTJvMiiWj/F7OHMqhVnm+Jp1M3ilUOaiT83n7BhQeUoh0brXIthCGsj9
	 Hsqwp3l4CivKq1sf1JgQBazDDf//I58EtTooKFRqckMlJQKN3IJpTWQ8GoEvy/4Ikcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogTMimAN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF7606A335;
	Thu, 19 Nov 2026 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogTMimAN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796FC1F000C9;
	Thu, 19 Nov 2026 01:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052579;
	bh=uNFMtGegQbyx2nsp7e9y5ycgaKcKYuwzocjWkIqM9lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogTMimANOmUqTobBj3k5z8Ybv4Sh/Xzn9W2Y46iWRHZAq8ZB8I05tso9X74qShZT6
	 C0JLDe2ZFWfOypRJIf1IBHloNLxCqdjWfad7+raqfL051GS39hofagtpNq07QEUzFD
	 0TTduLSQhFZ9HYYyLbRcglWv7hjStpr+TpmPl54iPaOgU4lfQzL5aYOZqrQwGy8icy
	 Uv6UQPQV7ri40GIlYw/8UiVUQn3YHyBvNsnct20EQxRsGxjZ8R6lPRskGd836tWDB3
	 NWOmghVmQMAqI8eKNcurb4kPqlL/lnk86fcWwOeMeGUuFHCm26LaDV9vc6Oji563JJ
	 wMbx9qswO7urw==
From: SJ Park <sj@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Wed, 18 Nov 2026 17:42:46 -0800
Message-ID: <20261119014247.119946-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118235012.14859-1-evanfengff@gmail.com>
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

Hello Yifan,

On Wed, 18 Nov 2026 15:50:12 -0800 Yifan Feng <evanfengff@gmail.com> wrote:

> kdamond_wait_activation() cancels damos_walk() requests while all
> schemes are deactivated by their watermarks.  But it returns without
> waiting when the watermarks check interval of a deactivated scheme is
> zero, which is the default of the DAMON sysfs interface.  The kdamond
> main loop then runs with all schemes deactivated.
> 
> In that state, kdamond_apply_schemes() finds no scheme to apply and
> returns before it calls damos_walk_complete().  The walk request is
> neither completed nor cancelled, so damos_walk() waits until the
> watermarks activate a scheme again, possibly forever.
> 
> For example, with a scheme that has the free_mem_rate metric, zero
> interval_us and a high watermark below the current free memory rate,
> writing update_schemes_tried_regions to the kdamond state file never
> returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
> other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Thank you for finding and sharing the issue.

> 
> Do not skip the deactivated schemes when deciding whether
> kdamond_apply_schemes() has something to do.  damon_do_apply_schemes()
> still skips them, so no action is applied, and the walk is completed
> with no region for them, as it already is when another scheme is
> activated.
> 
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>
> ---
> QEMU: the write hangs before, returns after; kunit and 13 selftests pass on both (2 need drgn, not run).
> Found and written with the help of an AI coding assistant.
> 
>  mm/damon/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b8678a53b0a9..12578fc3280c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3498,11 +3498,11 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
>  		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
>  			continue;
>  
> +		has_schemes_to_apply = true;
> +
>  		if (!s->wmarks.activated)
>  			continue;
>  
> -		has_schemes_to_apply = true;
> -
>  		damos_adjust_quota(c, s);
>  	}

But, this could make has_schemes_to_apply has false positive.  How about
calling damos_Walk_cancel() when has_schemes_to_apply is false, like below?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3849,8 +3849,10 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
                damos_adjust_quota(c, s);
        }

-       if (!has_schemes_to_apply)
+       if (!has_schemes_to_apply) {
+               damos_walk_cancel(c);
                return;
+       }

        max_region_sz = damon_region_sz_limit(c);
        mutex_lock(&c->walk_control_lock);
'''


Thanks,
SJ

[...]
