Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42853B2FCA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424412; cv=none; b=bqx0CyxZk26bYsIHCp0yD72DQHh7+xakQzzk5mjR7NuH0nqebibNiRiteo0Hy5IYj7n/iGgUcvslvh8SIdkgZ6SCqbFqQVERoeH3pgOz54n6ZKTyMC0E406cM3bvXxJ75miSZui0FetGbIEMxZIPcRzhMqaCQO3MAkfheGZJmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424412; c=relaxed/simple;
	bh=D6LEF5qrYz6DbFwcjMxDSZY/iZagbFXt2muTMD4vUes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNQYNrSOH8s16jFduPQ+lkHU40APEAzQHiUM/qlBL2lxxZ3CS2RhZaiSxm2SG7zTbezjlrM4b8n4/5AVnL+ylYjESIZMR9gnExRmH6R4qxy824WRzWLePvz5Hyz2RE4oceRYlxBAtjKNrQZ7jpKf5jJ60ozA6jmjf0xi5/wzpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5t8ubOs; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5t8ubOs"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso831122a12.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424410; x=1789029210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OociqrsBmV/E6a5jpk0qDALr4bKhrSE+A8mgKI0tJ1g=;
        b=M5t8ubOsX6jeEy4gU7oPAUeJVi7f+V9euo3pYU7IgkCvU7XTCjpajBwqPZ2Jn3/p5/
         7Fvr3lMNi1sR+VRMwI9vwKYtCsmXQOgcBrpjdB2cxRRd20Yo2fkMsyqCzRkAy8nvw0Pd
         SdDnNaZEiK/udGXTBvlmqzx1AjSI5WkFnjAPA3A9RkW0/MMb0srbLnV3oSmqeq7N6gbg
         3yj8vZ+RkjOR8UUlEjc23eWAO00IiS1WJbPiYnULvFB/Onjm9H3Uur9ksXqku1sRq4ix
         vQoAxmy9qQvxbMbAb7kjHJ1nWCzLuqNLyx+GHT/z/TyvBcryFaNByA0HAFzUjKKHVXHF
         EoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424410; x=1789029210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OociqrsBmV/E6a5jpk0qDALr4bKhrSE+A8mgKI0tJ1g=;
        b=OSLKPABbcUUxdX/ZsCI/hon3AXnzlxyqpDb0mTspEVMv0e+uwYOChDwvZq8B7yLh+I
         bCMeXKuRFIXP+iwyj+GIV+lJKzCFLxS8DsWJnt/pi83kCCoNgUEoqIgqnsVX5b86NiRd
         /Xr1fmNZOdT9hTPh71ArYrJQeOb9eeKLovHmMbieXKceiVMq5PKBtbUAtzGYCA6tZcaF
         VOSTL8gAkXAuPzk+mtXmsIDIKA5n6u5YQ3L4k83mFCovIaaUqVfoRLJx0bZFrr8ZvV4e
         mXJmaBCLaQjqwQxX/OfrfeJNgegD02ruIBg4ZRW4f9ww3xfskdCg69gWeRpm/CD1/jj1
         Jutw==
X-Forwarded-Encrypted: i=1; AKwUvBxPPC06BoCIFmmZQ0Oxu8QbIsWRI4it/abLSHOT1CFIbin3g/kKrhi3HG6HbcZty+bDJ+jNWDo=@vger.kernel.org
X-Gm-Message-State: AFuF++nlvYFKV+dKTKc847LYtT0KfUR8cZ0ZJwSp0+be3K0ngS0HsOE+
	daTwkjqpcINbO39L0XKzX3bYolA9wDR5Yyit3B2hI2RzS/qqdN8OsAUW
X-Gm-Gg: AYBFou0ANlISaYOeEf2PyuUqpHxpAAhwmDDidd1Tn9UM7yWeU9h3VUT9dZrTld7Y6Ns
	HQS31O9ePd9WslquBGHfS79mkxT6Cu3iyvxUbR9CbfEfkbxBzzIrcvAt+Nwi06CKzMpkgyqeyaR
	DVp/bH1SmJsLd8glsNuiJG/YZhIc6cR6aF5yhbDhDpEoPPSoVhpKR9mbK1rkksesejIIyn737D0
	U5KmYRMZTVgpLVHuXR1t33m7LXNsRs2LbZXwTu6KutYQqXvyasVNA5jfSGI6XFUJxcqprT+o1m4
	rKnjS9MtwDhY6/No7sC/vq31qUGjxuEC/XfIGH4G7cerCsS1d5GRnX1hoQanacRa2JmF5DCrg8C
	OJJXACKu74MaZYM+V6/k4uiWUUqww0feW+y7kxDXdzjsSLqPADN0ym1DjLW+55mUhRFYjZJe700
	Ejp3s8Kv3gQwdAejUogzI5BspMiTcDsggviTlGqVgyWrr3awXI74g6qA1XtFk3GwkpyHYHFtCh
X-Received: by 2002:a17:90b:3cc3:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39b132d819emr1843780a91.14.1788424410133;
        Thu, 03 Sep 2026 01:33:30 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm4001175a91.1.2026.09.03.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:33:29 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 1/4] mm/damon/tests/core-kunit: test committing psi goal to psi goal
Date: Thu,  3 Sep 2026 16:33:18 +0800
Message-ID: <20260903083319.451754-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:20 -0700 SJ Park <sj@kernel.org> wrote:

> damon_test_commit_quota_goal_for() is set to test committing a new psi
> goal on an existing psi goal.  However, damon_test_commit_quota_goal()
> is mistakenly not covering the test case.  Add the test case.
> 
> Fixes: 99f89debafc5 ("mm/damon/tests/core-kunit: add damos_commit_quota_goal() test")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 7071ec277b007..f1e11548c771b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -793,6 +793,13 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>  		.last_psi_total = 456,
>  	};
>  
> +	damos_test_commit_quota_goal_for(test, &dst,
> +			&(struct damos_quota_goal) {
> +			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
> +			.target_value = 234,
> +			.current_value = 345,
> +			.last_psi_total = 567,
> +			});
>  	damos_test_commit_quota_goal_for(test, &dst,
>  			&(struct damos_quota_goal){
>  			.metric = DAMOS_QUOTA_USER_INPUT,
> -- 
> 2.47.3
> 

Thanks SJ. The added case correctly exercises the PSI -> PSI commit 
path before the existing tests change the destination metric.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


Sent using hkml (https://github.com/sjp38/hackermail)
