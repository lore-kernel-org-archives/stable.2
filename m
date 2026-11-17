Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883912;
	b=FtRCRHwKoyOgJqpyLd1baIB6Hf0U2+fhXAjpKCUJ6IxAVP0w3wyWKT0rQQT37dM7lqaq
	 C171QnhSObgmqi+U3APuBorp8eVpE8vZbBhfxeD1PgmaT2lxOZGNyJzDLvegGIlseMUEW
	 +F909z4DbsHdY4KV/5Q61xaquKZ+X5zWLjfxnwQkPnUBnfU6tjXTQVAV/i2Pla2Pwkp6g
	 UD0/Mdx12epA/MIBkZKQFVMLCtjRlQ1y1pcLzFWplaYVlvg63WQ/3zMUEAp+hH56XnrBA
	 0nMiFJ/75Py6EBtvAzwL9uDDySfxQa4r2esUAAhebGmbC5OZtjz4nX7rTdsK60NMjnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YT7dJBTJ5NpMKHm7zef0UK+gnv6Fb8K6ANn5jOwpk54=;
	b=jfKrYMiuiWh5nKDe++1HAYKiB0WG5tjlz2kfI3to4ZR081dzgzwCNN6PYgFqMN1A7xaD
	 7BPR4DXumoKPkck3XFU1yGx2arEw+01fNhzaeSu6KO1b25NO3tAeIzdiEplCjGK6lL4us
	 rbh2UihpStNLSfGPEybXpj+OTZn8GrtcezpYZH33Mi5s8SzNtTYUOXJ4KZlz5Wnd4uSqE
	 PgXijUWKtiIIOoHBs+2JdqUMnjG21+M2chDW9qMx3Rfd2UlPwPueCccwhuW0vMnc3cAlC
	 nHbHwab5/VBpQMiBUeIyNzgvRoNruWHip2O5GAs/ig+ZPMxcCzT8peKIGLDDg2D9VdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bz/yjurB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD36606A31C;
	Tue, 17 Nov 2026 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz/yjurB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593DA1F000C4;
	Tue, 17 Nov 2026 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794883911;
	bh=YT7dJBTJ5NpMKHm7zef0UK+gnv6Fb8K6ANn5jOwpk54=;
	h=From:To:Cc:Subject:Date;
	b=Bz/yjurB2tXqFCox6lw5FYMKZMY3cqFANa75FHh/q5cop5PzxLyd5qXy4WKkeJ6Ik
	 MiYPqVCQdY8DMWHxoSdnjLKIcVkI9pUxxIciiQpKHZXlAi3snx3nqo6VN+tVZkACqw
	 Bh7OGQOnn2BEQPLcOVEPa3Bcw2FytVQLi0QkjTOO7nTuiClUQha4jpYRULqh3GxiH/
	 fcZUTG9zSNWamHOCEYdIFH6UuebMoJza3xiZGm76zub/V6bf4jFQ3wNLJsDXCpvyjW
	 GKpTyAJtvlX3XVdLyonEeK6VHVBnMQmjKNwbf4349yk3cjBg9EFm2EslKo8xSmKYKr
	 2RlWqddR3yi4g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y] mm/damon/reclaim: use parameter context correctly
Date: Mon, 16 Nov 2026 18:51:42 -0800
Message-ID: <20261117025144.117100-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

From: SeongJae Park <sj@kernel.org>

damon_reclaim_apply_parameters() allocates a new DAMON context, stages
user-specified DAMON parameters on it, and commits to running DAMON
context at once, using damon_commit_ctx().  The code is mistakenly
over-writing the monitoring attributes and the reclaim scheme on the
running context.  It is not causing a real problem for monitoring
attributes, but the scheme overwriting can remove scheme's internal status
such as charged quota.  Fix the wrong use of the parameter context.

Link: https://lkml.kernel.org/r/20250706193207.39810-7-sj@kernel.org
Fixes: 11ddcfc257a3 ("mm/damon/reclaim: use damon_commit_ctx()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fed48693bdfeca666f7536ba88a05e9a4e5523b6)
Signed-off-by: SJ Park <sj@kernel.org>
---
Mark Polyakov found [1] this patch is missed in 6.12.y and causing an
issue.

[1] https://lore.kernel.org/CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com

 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9df096218beb7..254d84166131f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -190,7 +190,7 @@ static int damon_reclaim_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
+	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
 
@@ -198,7 +198,7 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		goto out;
-	damon_set_schemes(ctx, &scheme, 1);
+	damon_set_schemes(param_ctx, &scheme, 1);
 
 	if (quota_mem_pressure_us) {
 		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,

base-commit: 8ea1fd6d2beedbc49a917cdccea09a0354b64d5f
-- 
2.47.3
