Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F53B47D2;
	Sun,  2 Aug 2026 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687658; cv=none; b=J8ti7X2EsFk3dw5PMSXF/KfM/s4EsrBZpma+VH14O9jrtYhJlaUIB2dAcX9mUOpC9ZYpyV8OtlYzCM48qvIV1dYPoSsI7rwGhCbYXx2AQfk2EMIKiDkY7RYmv6RQHpP/uP9dAiQPN+2lIMSTnsN96tciOARUpN9SFoU+YeTdoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687658; c=relaxed/simple;
	bh=DYkfgeYQNoEyMshaanBDBVEep120wpw9eT8YnPr3mmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5MKsXN9Z2C8kqhWqfgKv8SYZBz8VWOvaB/NwwuDidjWuO5yhodXJmxR+jF6982YaxHPMI4jc6EWoPcsl8yXMXuAFGG5A/+P5fzMB3HDPLSpdtAiWEssje0aruwvTHvBSwEqG7tABnoYoFEgxBiBzmJTsU5zsmo0mGUJbXM9EpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxVIL/x+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxVIL/x+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD31F00A3E;
	Sun,  2 Aug 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785687656;
	bh=0zkQs6mCwPIKeiUIY1+pQwOcOcVfTo/+g8AflA0OwVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxVIL/x+lPSXwBymfAdejVtDamYvADtCXQL5xRajDaAI8Gtuk0W4YR66+gJVP68cE
	 AyVJuw5NeKTPnIKO/ZGdT2Qu63tJV8HimD/8MoEdAKw6JezCnyWY6qoGFr+zMG/dYd
	 ZRKupuw6+fXNZq6TxU2gEqvxrScLxZZ1OS+aWCTNGaEci361wpAEc05DNzFCh/ORYr
	 I/JAuAsVw5ratIlFX69NZwaAf47uqJtpFDuZs0YO03FFoWdqOJCGoXkb5dyXT19ITS
	 uYAIr9RczGoJlfHEx4QUNjArx+eBkYKipPkoZcwBUBxn8e5ADi2zcwaxUyaWQHG7T+
	 fBzMWiKviU46g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/2] mm/damon/lru_sort: error out for >10000 active_mem_bp
Date: Sun,  2 Aug 2026 09:20:49 -0700
Message-ID: <20260802162050.89477-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162050.89477-1-sj@kernel.org>
References: <20260802162050.89477-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_score() can trigger division by zero if the target value is
zero.  DAMON_LRU_SORT lets users set the target value for the hot memory
scheme via active_mem_bp parameter.  It avoids setting it as the target
value if the parameter value is zero.  However, it also sets the cold
memory scheme with a target value that is calculated as '10000 -
active_mem_bp + 2'.  Hence, if a user sets active_mem_bp 10002, the cold
memory scheme's quota goal target value can be zero.  As a result,
division by zero can be triggered.  Fix by returning an error when the
user tries to start DAMON with >10000 active_mem_bp parameter value.

It makes no sense to set active_mem_bp with 10002.  It also requires
module parameters write permission to reproduce the issue.  That said,
the consequence is quite bad.

One reliable way to reproduce the issue is like below:

    # cd /sys/module/damon_lru_sort/parameters
    # echo 1000 > wmarks_high
    # echo 995 > wmarks_mid
    # echo 0 > wmarks_low
    # echo 10002 > active_mem_bp
    # echo Y > enabled
    # dmesg -w
    [...]
    [  597.421247] Oops: divide error: 0000 [#1] SMP NOPTI
    [  597.428848] RIP: 0010:damos_quota_score+0x6f/0x480

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260801213028.5127-1-sj@kernel.org

Fixes: 40d98d31cd70 ("mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7e077084cb03a..3920d5042f109 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
 
 	if (!active_mem_bp)
 		return 0;
+	if (10000 < active_mem_bp)
+		return -EINVAL;
 	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
 	if (!goal)
 		return -ENOMEM;
-- 
2.47.3
