Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701596;
	b=mOFvMr7lrvANmpe+wxG2m1wm2ttQ9yRnD91c7ZJGncGX9aqERDHIoEjoXjyiypoay5cg
	 Y3Y2tRBiYIgI9E949MN1MrhIagAxsh9j08WUL3twHPp0QvAbM5Wm5AM2UlmULKnEY+KsX
	 0NR6R3cN24Zb6RKomWGfFZn5Fg2VX4yicRDY9XtQ2p3+bBLgY+ma1lfwEIlW2/aE74Jqj
	 NrM5QfLxB3kk88d4mEa/gLyWyxibvBi5OH22FNuhbgquN6Yg+AP3HuX6LqYmGV2ZpQE4f
	 VFiK62LMSpbBnZwNBK0ollXW4xlZz56K1lQ0Gna/8l4Qq4thfJJdboVv28wtXBmC6wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701596;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hmBDURKZM2gT8yAhEobO4jEMpgXoE9EjguJBnydKsTg=;
	b=KjcTIG14+pIFh1hyapWgeoGceH2eCp4UC4veXMHOPrzbp4YY4dr8DNmUlKJRm715B0QA
	 uXdEHB/61rGlCzZ3W9McTsaUO5QloYmW22OokxAayzrESgxnrFy5t+1XeFafF9Ke9pgHt
	 ENI4YrbiovEM3m645R5Pn61jZ8PGIq8hDBm/8FvtbYqSP+ILUrCAKenNVrY2ea+Zu2KDM
	 rdQPEDP19zw7wOedZ1VTE61t7IUccu9e8oJqkvyTrcXiMw96HbfGUONAdYarnS4JFHNah
	 qTiv4HbyL35sy349aOCalsuvTQWIpYmlY5PwRP+aFcc6aWnU/+h/yO4NPH7TaX04V4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AS8y0wXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA460606FAFA;
	Tue,  3 Nov 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AS8y0wXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A2E1F000C1;
	Tue,  3 Nov 2026 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701595;
	bh=hmBDURKZM2gT8yAhEobO4jEMpgXoE9EjguJBnydKsTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AS8y0wXnWcBUBfhwFlyUm7+MNcSgfdkdGZy7w0+Yc7BXy59IV4eONnGcHohniBb9K
	 OPLHbgXnHPR8Y0nQeB359c4s+kuhkKhWxl8RrImYfSd/HPChDd4+EKLOY0lybaZUyY
	 n5NOCnXzTaLtqVvmnZ0oAyJXPRroHJs7qT/Ay3xMmJlDwFLrRSTbpO34VzC6cPOiWm
	 2gcmG5X8T3c1rCCIuCORpvAmpVNsL68DUBlCkmajLZ0x7JJOUSc614o/zf9lIKRcj8
	 SuckTqkzCm2xQO+Nn9Ru08zNPxqxhYjnmuCNK/4aYkjXmMaeUcUH0bma8Flc+Xd63N
	 TdhtYHsJV+OAw==
Date: Tue, 3 Nov 2026 11:26:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Coly Li <colyli@fygo.io>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] bcache: Release the cache kobject when
 cache_alloc() fails
Message-ID: <20261103-statuesque-lionfish-from-saturn-baae9d@quoll>
References: <20261103094643.1289833-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103094643.1289833-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:43 +0000, Wentao Liang wrote:
> cache_alloc() initializes ca->kobj with kobject_init(), which takes the
> initial reference on the kobject, and takes a reference on the bcache
> module.  The object is released later by bch_cache_release(), which also
> drops the block device, puts the super block folio, frees ca and drops
> the module reference.
> 
> When one of the allocations in cache_alloc() fails, the function frees
> only the buffers it managed to allocate and returns an error.
> register_cache() then only calls fput() on the block device and returns,
> so the reference taken by kobject_init() is never dropped: ca is leaked
> together with the super block folio and the module reference.  The
> comment on that path still claims that ca->kobj is not initialized, but
> kobject_init() is the first thing cache_alloc() does.
> 
> Put ca->kobj on that path so that bch_cache_release() runs and releases
> everything.  bch_cache_release() frees ca->buckets and ca->prio_buckets
> as well, so clear those pointers in cache_alloc() after freeing them, and
> drop the module_put() from the error path because the module reference is
> now released by bch_cache_release().  Skip the bucket page free in
> bch_cache_release() when cache_alloc() failed before allocating them.
> 
> Fixes: cafe56359144 ("bcache: A block layer cache")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/md/bcache/super.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




