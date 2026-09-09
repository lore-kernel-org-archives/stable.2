Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BF38E8DA;
	Wed,  9 Sep 2026 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935656; cv=none; b=sF7b6DoxJheF/UxnYqODzPRSR8wHnFmIiMU2zTrLQUwcDdAUn4mTUkIJCZ8/AA64JvppezTMbws9Aiv5/CQFauemOo+ctDMpC5dkptnLGstDZUuDvjyrq6YGSiTJ/dat8hVAExbYsVSyXhtVcF9DRgbrVTqgsSeszQHyGNAjUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935656; c=relaxed/simple;
	bh=C5NnKJebx0PWyNyVQBtXH/AgxIIrmjEWHsUoD5JzuRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVPBIDSZ98TmP8HUwcEdgcHnw7hVt680x2pTSqnnJnlT5oXy8kaUelYbwc+jLA/9TrkMzW93ioN1sDCaez1Rehor6qo1AGp0iSfDUv79Dnm2X71SKZjPmujx/ZZ66KNvl4ow04FJcPSxqJiYsLKiRsKE4F4eok20KRkowd0OVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYbCYjGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYbCYjGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC1E1F00A3A;
	Wed,  9 Sep 2026 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935654;
	bh=4eYhGpk1brUnNp/JHbhNmr0ZlmaWiURYEZZlvGmzEwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYbCYjGUr0DAnP95FJjiwD3OgXm4ipeYU4NpqzXvAuPKp/i/GV6rMh+7jjSu+NamB
	 +l5rRjDFQKa/ydDRxq+8Wrm6B43Qt8H/JAHEmIuVzKOqKQZqN8r1QzgOIrg4Ju5pZa
	 OeAfGjHQj740MpuxF0kuGViM+HvlhmGInYzF3SB45nm6KzLuQPf/lmpNxAr7nDJsIu
	 MtJSSgPwC6U5ZcTxXRI7xshv7vNb+r4fDepKXnhdxZuEwMQ5Y0kpRpk0H8wLXINiQi
	 +9SKcdLFRNh1m9LlpVgdAR4VD2oFYj96ArO7AbGYH2WMfZx1npWDod3oDfTd5V1WKz
	 tLiMPq6nkTYKA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Tue,  8 Sep 2026 23:34:07 -0700
Message-ID: <20260909063407.94616-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909035813.162131-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 20:58:13 -0700 SJ Park <sj@kernel.org> wrote:

> damon_test_split_at() test next region that is assumed to be created by
> damon_split_region_at() invocation.  But the split might fail.  In this
> case, the succeeding test may dereference invalid pointers returned by
> damon_next_region().
> 
> The invalid pointer may not cause a really bad user impact, because of the
> implementation detail.  It would only read wrong contents in the belonging
> damon_target struct.  Depending on the future change of the offset from
> the link header to the accessing field, this could also be really
> dangerous, though.  Still, the realistic user impact would be limited.  It
> would affect only test run setups.
> 
> Fix it by testing if the number of regions was also changed as expected
> and exit early for the failure.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 9b18ef3c3aa1ce24176e340061caf15fa2742564)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core-test.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index d8fef225930a5..1dd17d43a642c 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -162,6 +162,9 @@ static void damon_test_split_at(struct kunit *test)
>  	}
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
> +	if (!damon_nr_regions(t) != 2)
> +		goto out;

Sashiko found the above if condition has a typo.  It should 's/!damon/damon/'.
Please ignore this patch.  I will send a corrected patch as another reply.

>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
>  
> @@ -169,6 +172,7 @@ static void damon_test_split_at(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
>  
> +out:
>  	damon_free_target(t);
>  	damon_destroy_ctx(c);
>  }
> -- 
> 2.47.3
> 
> 


Thanks,
SJ
