Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C291125A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726640; cv=none; b=bbz4Tf4lYU6kYs0/GeSaSBLrEvM7fgdSmNOJts7cLqWRMG3QdMg8ziuEBe9K+C8RelRpcJAH9QdQWAD3eUxltxqORdWS+2DVvss6lpvaSzyXAKDGexGdufDdjRYnRWdYzheZe5yolcmz7m9U2v3+M1gUadSk0ByYz9BhVqAtXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726640; c=relaxed/simple;
	bh=63Pv6ivuphDOjFDrohKDp2nqIvnfcxPv24IcG9yhd5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHd4sb98orGAHuD1XSYG92tZ+PQdM0KXQseZdXEKbxeYfi2pTcV2Ds5HZ2TjuQtSc/G+kubaEB5RK2psQiBIsKV6+3b5lRWxr5fNLPUd17XsHvAKKWJ9Xb6Fbc3je7Co8AT2YIPHRFhgmr+HwEmse2BVyl16R9JngwruKFFvVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt88BBj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt88BBj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391331F00898;
	Wed, 30 Sep 2026 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726638;
	bh=2lrlKrV00wViJnLRQM9o+ePVhtUQ3LxMsPiCF9anWOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yt88BBj84ZbMDALzi5odC4s9jaMHil1EPb8LSmcWn4u/0+e6RKzButIfrWBUdBLr8
	 EiH6yT0vAP1TzIDoHRYT8b++gtsSVeal7pTaggPHDiqUIPUsO9l1BXiHC901iHPgJI
	 tRTLqT9Sez7wfI6SKMefEI57UGF5FBXxhoDBafHlfeTfOV8r9FQllPieEQUNenm6sR
	 1IKA5rblW/OtNY79oYdXnbBRoEbUo3G95fG3PDZzaBXdSRBrMZ0u6B0/zn+VLKwLsZ
	 cIGp0FHE3YwxyVaRUuwCUmjObzuzw3fGmx4GXAIzsrs6hizZwV5OsHp7I2qxY+9YtA
	 K1P/kB/rxkmIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enze Li <lienze@kylinos.cn>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] mm/damon/core: fix wasteful CPU calls by skipping non-existent targets
Date: Tue, 29 Sep 2026 20:03:51 -0400
Message-ID: <20260930000354.2861391-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000354.2861391-1-sashal@kernel.org>
References: <2026092947-shush-encode-1e48@gregkh>
 <20260930000354.2861391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enze Li <lienze@kylinos.cn>

[ Upstream commit 6e4930e33329eec80dd245f28b52202271f5fb28 ]

Currently, DAMON does not proactively clean up invalid monitoring targets
during its runtime.  When some monitored processes exit, DAMON continues
to make the following unnecessary function calls,

  --damon_for_each_target--
  --damon_for_each_region--
      damon_do_apply_schemes
        damos_apply_scheme
          damon_va_apply_scheme
            damos_madvise
              damon_get_mm

it is only in the damon_get_mm() function that it may finally discover the
target no longer exists, which wastes CPU resources.  A simple idea is to
check for the existence of monitoring targets within the
kdamond_need_stop() function and promptly clean up non-existent targets.

However, SJ pointed out that this approach is problematic because the
online commit logic incorrectly uses list indices to update the monitoring
state.  This can lead to data loss if the target list is changed
concurrently.  Meanwhile, SJ suggests checking for target existence at the
damon_for_each_target level, and if a target does not exist, simply skip
it and proceed to the next one.

Link: https://lkml.kernel.org/r/20251210052508.264433-1-lienze@kylinos.cn
Signed-off-by: Enze Li <lienze@kylinos.cn>
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index da57c6dd93310..2d9c27b490683 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2325,6 +2325,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	mutex_lock(&c->walk_control_lock);
 	damon_for_each_target(t, c) {
+		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+			continue;
+
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
-- 
2.53.0

