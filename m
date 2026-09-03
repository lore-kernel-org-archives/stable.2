Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A03EF0BD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427443; cv=none; b=Xy2eB32dRyyc7Kkhd+t1uaNW3cXw/JtwG0ainIL19xiiqsm4XdRH/FJbOxRAS2slmihxw8LlUlFzac+1lIIhX1Ten15ypq+DOyV7hqI5cjDEdr4uYDNT3y2++kT93zg5ZuoFzIqhH+tnbi+uDbI4UhhWvIYcPJ9EKZnqtMdyFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427443; c=relaxed/simple;
	bh=RtjW6gApa3Po8RM0j3sc1s0MN0vmoCVMf34WnHB+xR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+0Nshrs9M8DNn3V/n6/vYxnStOA0/hD0p9nV+UkayvKKaqejjliBjNsEemtliTG9on8q6A1rkWLLdaszOEfGYR82+5YTX0HYh9d4soAQ5MXfl3AFM77CGba9FoAv3qAcSze+VYb+gDQT8BVL2wnSmcc8OgKPWEl3R9HOq+DNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+MaImU2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+MaImU2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1702093a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427433; x=1789032233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7qTGz8yA1h581X4DOr85MyyM+WIOFqQrYJ5cYnccTM=;
        b=i+MaImU2f5XUmj9MWdLbrZDHj47Yda0fg9dtd2/ERHyc/hAkZidRPfcjQUzr3n/LS7
         ID4k72GM04+Zp4iHpMXfSliGfDm5NG+g0OPsc5BdeQ0QClzOzriRMVUpz80zno9tAeYT
         HmI+By8mM0fD72+Fe5VF5NbPUoeyGgb0amXHiiuQAQtmPcyBNvEsfoR8HaLFsJbtr2Fi
         0Dkpx7YeVdh6aOrFEeROHKea7N5b2qF617BSphtPfj0uiNFwIPr8wW2+Yh2IRSoZ5p6n
         B3orslS/ZEy4Kavw5XBQJ/luBGmXbi1Se6SjKsV/XfKF3taWHimRqSRdYgU3tRjXwDEt
         py5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427433; x=1789032233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7qTGz8yA1h581X4DOr85MyyM+WIOFqQrYJ5cYnccTM=;
        b=hCbRilsnmNE8Wc0OaIWAy/80fM9/O1z26BHt15yALpG99lZrCMBzA3DNl2UBKWBZJr
         OSLazanh0FicXO/pwiwGavk7htb5ZbROO3ZMHdBGrQhHSjl8013EfElkhL/f5md586EN
         QtiN4LxUFMX+N/aF0B2vSMVRRXhMwdZWfoVTbtO3sq53JR0gCsmgN7Tu1sx7imkBddzE
         jUSMKxh/r8WDLQMMv0p1tJZzajIkhOUFy5eZ6tYUf7THWyG3plxT+opbQ1TavVFFZLJN
         DHxRdWC0+owHAUMnkDOJ+vMOCqEe1ZU+9Aqm88iBVC/L3dIAyk/Pc77kYSrS5TMn5V27
         1DGg==
X-Forwarded-Encrypted: i=1; AKwUvBwuMYx+9ARp/o7eRT7+Kvd2p0xOFgH392r7b3XROBq6GflqW12dydrRkSYCcFvrlnPa4HzE+fo=@vger.kernel.org
X-Gm-Message-State: AFuF++k6sjYC/JQqwixaJBMBDMVKwucug1IfeoXwqSUwS4TVFNtZfx84
	0SccirKVJj+apABr+u/V8ZQad1EwLSTo2xYKruw9enycjGOMmX4Ot82q
X-Gm-Gg: AYBFou38krHJeVzdxcUkaFdxNNqiU03sKoBOEIL+sttHcF+Y0Uwupo8zMjoBZmF1KJz
	crhFINvmH3M9R8Pmqdhn6NSn9sD0TE4ibUSaivVH/9sxmktLGUC0/m/XTChU9+GcVE7P0An/qOL
	m1kG/P3CdlbB1wwCTX010aAyuyyUrhC2gL4kFzJLTxUHce7R3bmTQNRrV6/61u7KRwJ6P8OWEzp
	e1NApLY/U+SZCqMljbG7TnXi+WNE0Ol7N4wkAP6jdxcXEWZY0wYBSLFKUt/1TWM4APSLJ+D5lMr
	o1y1Y/n4DDTsM3aZA2E3Mjg2lhNZwQF/3ymyF1N1Zre5FVB7cWO6oJ+wY/coAtBfsYpOxGUHZgM
	B/JEE2bu2i8FX2bqAXlcNdDEXvk0ZU4gV/NZBaBhwh2yhwbcnvX2rOCmB1bMACUBH2sqHquhhBV
	afhSf7z0EP5d7e5JbBfzOsg/ZhF5CmIajGfaw958Ce/5q/UhGD1nLkYpSE61M=
X-Received: by 2002:a17:90b:2d4d:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39aee108918mr17835573a91.19.1788427432993;
        Thu, 03 Sep 2026 02:23:52 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccdecdsm2638527a91.2.2026.09.03.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:23:51 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 2/4] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Thu,  3 Sep 2026 17:23:33 +0800
Message-ID: <20260903092344.3079122-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:21 -0700 SJ Park <sj@kernel.org> wrote:

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
> 
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no
> initialization at commit time was intentional.  It is also explicitly
> commented.  That said, nobody likes behaviors that are unexpected or
> difficult to be expected.
> 
> Check last_psi_total initialization and skip the tuning round when it is
> not initialized.  For this, initialize last_psi_total with U64_MAX in
> the goal creation and the goal commit time.  U64_MAX means the field is
> not initialized.  The tuning round shows the value and adjusts it to
> guarantee the current quota is maintained for the round, and
> last_psi_total is correctly initialized on the next round.
> 
> Before this change, committing a new PSI goal on an existing PSI goal
> with goal-only DAMON sysfs command (commit_schemes_quota_goals) just
> worked.  After this change, the tuning round right after the commit will
> be unnecessarily skipped, because last_psi_total is unconditionally
> marked as not initialized in the damos_commit_quota_goal_union().  This
> is an intended tradeoff for simplicity.  Skipping just one round of
> tuning is no problem.  Meanwhile it makes both the code and the behavior
> simple to understand.
> 
> Also update the quota goal commit unit test for changed last_psi_total
> setup behavior.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
> 
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c             | 13 +++++++++++--
>  mm/damon/tests/core-kunit.h |  9 +++------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0df785e72438f..20748b0a71026 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -636,6 +636,8 @@ struct damos_quota_goal *damos_new_quota_goal(
>  		return NULL;
>  	goal->metric = metric;
>  	goal->target_value = target_value;
> +	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> +		goal->last_psi_total = U64_MAX;
>  	INIT_LIST_HEAD(&goal->list);
>  	return goal;
>  }
> @@ -1129,6 +1131,9 @@ static void damos_commit_quota_goal_union(
>  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
>  {
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		dst->last_psi_total = U64_MAX;
> +		break;
>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		dst->nid = src->nid;
> @@ -1150,7 +1155,6 @@ static void damos_commit_quota_goal(
>  	dst->target_value = src->target_value;
>  	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
>  		dst->current_value = src->current_value;
> -	/* keep last_psi_total as is, since it will be updated in next cycle */
>  	damos_commit_quota_goal_union(dst, src);
>  }
>  
> @@ -3039,7 +3043,12 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		break;
>  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
>  		now_psi_total = damos_get_some_mem_psi_total();
> -		goal->current_value = now_psi_total - goal->last_psi_total;
> +		/* uninitialized last_psi_total; make no effect this round */
> +		if (goal->last_psi_total == U64_MAX)
> +			goal->current_value = goal->target_value;
> +		else
> +			goal->current_value = now_psi_total -
> +				goal->last_psi_total;
>  		goal->last_psi_total = now_psi_total;
>  		break;
>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index f1e11548c771b..af26b3d60957b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -757,19 +757,16 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
>  		struct damos_quota_goal *dst,
>  		struct damos_quota_goal *src)
>  {
> -	u64 dst_last_psi_total = 0;
> -
> -	if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> -		dst_last_psi_total = dst->last_psi_total;
>  	damos_commit_quota_goal(dst, src);
>  
>  	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
>  	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
>  	if (src->metric == DAMOS_QUOTA_USER_INPUT)
>  		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
> -	if (dst_last_psi_total && src->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> -		KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		KUNIT_EXPECT_EQ(test, dst->last_psi_total, U64_MAX);
> +		break;

The U64_MAX sentinel approach looks correct to me.

In the first feedback iteration, setting `current_value` to `target_value`
gives the PSI goal a score of 10000, so the uninitialized PSI delta does
not affect the quota score. The current PSI total is then recorded,
allowing subsequent iterations to calculate the delta normally.

I also checked the commit path: the PSI goal is reset to U64_MAX when
committed, which intentionally skips one tuning round when replacing an
existing PSI goal.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
