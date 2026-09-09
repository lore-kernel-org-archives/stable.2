Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9335C695;
	Wed,  9 Sep 2026 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935304; cv=none; b=MLhUFoToFAViT8F3YghdGEy8vH97Ywf4sG1UyaDGpB0EXlXX5eCg8dpso8stJpF8R1TbqvOt9ZfJPOGXxXl3tCFOWDivgKKG6UW4fd788S3n8zul/SgbltdTAyVyXJCMdZejIxshY1QTG8J/Aax1DzorM12DuOUdYa7DdhDyF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935304; c=relaxed/simple;
	bh=zqkdrlLQG6cKcYa6GejJtZVgSfIg2Txq0yW8gXUO380=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evwBaQI4G7AQ06KmkOYgco8kntbRclFoTXoG/09MXVFRtLM895jabt6mv37DwSDya8ifQeWkU+T58+LJHSSZ5m0ZaEYixJYSVRwaFSiREdaMfFuicasn8WHHu4mHwVmZj7PsLtapdbuqIEVWVUKjX5ng1NNQM7OPT51MtKA0jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4glpN84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4glpN84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8841F00A3D;
	Wed,  9 Sep 2026 06:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935303;
	bh=Hv6bPUikw/0ByI6pTLFl4Ni5u+TBEJppPMIVSYIDOLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4glpN84OJ44+l9JO21mBpU96YtrfIn1Md/Xn56uv0UljoNchR5x7kGJrUsAX8END
	 lfyCQJ9B6iY7V4+LhS28fFZ8H+vi6iT7YtUfd3/VlCQIruuBZbcYzBNIsiEn/Wq8Sm
	 17pjOXn3/VBSyM724LnlW/chcFPXNuDnm4AfZANVtMqZ9KiL4r32NHbyLI9FnIZj3S
	 s/z++WOifBFm94x0jaQ9XaawTjE9FZbFye39u7HmfEF+7gw2yVFFQRFCHDav4hzoh7
	 Ja/qvk10/OG3yr68qbTJOq5h9eb0Qh2BJFNjy7SsDsjO0PjBw6xUMCkweMgJaB7Vou
	 P1uEkosXyiuaA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 23:28:14 -0700
Message-ID: <20260909062815.25299-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909033832.132107-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 20:38:32 -0700 SJ Park <sj@kernel.org> wrote:

> KUNIT_EXPECT_EQ() does not abort the execution of test code when the
> expectation is not met.  But damon_test_merge_regions_of() code after its
> initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It does a
> per-region test with a hard-coded number of regions that is correct only
> if the expectation was met.  As a result, __nth_region_of() could return
> NULL, and the test code can dereference NULL pointers.  Fix the issue by
> catching the expectation failure and skip the per-region tests.
> 
> The user impact on realistic setups should be negligible, as it is a unit
> test.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
> Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit b640708929aa956235866bf7717d89018c661083)
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 6687778752728..c1f0be6746abd 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
>  	damon_merge_regions_of(t, 9, 9999);
>  	/* 0-112, 114-130, 130-156, 156-170 */
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> +	if (damon_nr_regions(t) != 6)
> +		goto out;

Sashiko found the above if condition is wrong.  It should 's/6/5/'.  Please
ignore this patch.  I will post fixed one as another reply.

[1] https://lore.kernel.org/20260909034527.D29C71F00A3A@smtp.kernel.org

>  	for (i = 0; i < 5; i++) {
>  		r = __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
>  	}
> +out:
>  	damon_free_target(t);
>  }
>  
> -- 
> 2.47.3
> 
> 


Thanks,
SJ
