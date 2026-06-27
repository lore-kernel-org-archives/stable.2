Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F57223DCE;
	Sat, 27 Jun 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579668; cv=none; b=UvRSQIuWrY+8W9hSmtqtIoJ2Xm44fpOVDjP/nI+Iu8jiLd9ENGDsU/banqfEdWv4/m4biO8pPiKI47ZfPUVfSCcoThJHRGjn0/d8j3u2RZZ9BC2hocFbcas2oJn3wdrNcjjVDvVZLfYOrpfcE6KKbGU05eRhh1swHkKo1iTAj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579668; c=relaxed/simple;
	bh=TulduVJ3UOJV8TsyJ7ffk1l75Pt4FkT2/HyvATqxan4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JC1Adp5X5OhnQBBuXZ8wM/SpWDHO4CCPRmfCtwjbAfckru0vWUKIECQ5d/YhFT2NRzEoZFdyQtsnlbKAgBtJqrZLCLv1s41YU6DoSxWTON3tAshTbVHo7HbII5GveYnNBDQa5TdXlkBG86UmXdkAJgRvXguG/Jnkaq7LzF8bp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PesMaXNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PesMaXNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E9F1F000E9;
	Sat, 27 Jun 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579666;
	bh=hEn2zn5pWhG25VPBcYCkS7+7B1NjobplNjZ+d8XjyHk=;
	h=From:To:Cc:Subject:Date;
	b=PesMaXNupjJJGZuvo+yqSgEunZs+pIOijrjAHoAz5KrDeHs0eigW5qDmImhC3o89x
	 3b05rCW3a4MZW5+hrLKEXgTaI6tudKUTTVvihDNtu3HdxuR1GuIj2Mzxgr6RiY1SWh
	 MsmNSEeCYz2UitAgd6o8IWpfmoVHW0ELS1mJAMEDeDOzBRoNaW4L14iN1um4STbEmJ
	 Rm6tlfZuBEb4TplCTLPpgBz2BYti0F6F65IB9CEOdRVIlh1MPC7NU+uakrRCaYMKC2
	 vxE+vucgP/CpLxAX0vYqKHLzaVSul7ngSaIxty8mvzcKvekNwYDXW7dmjT+X5k3KoU
	 FpI7CLVly3dqw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 10:00:56 -0700
Message-ID: <20260627170057.1867-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core logic assumes zero length regions don't exist.  However, a
few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
and divide-by-zero from damon_merge_two_regions().

For example, the WANR_ONCE() can be triggered like below.

    # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
    # CONFIG_DAMON_DEBUG_SANITY=y
    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/targets/0/regions/0/start
    # echo 0 > contexts/0/targets/0/regions/0/end
    # echo commit > state
    # dmesg
    [....]
    [   73.705780] ------------[ cut here ]------------
    [   73.707552] start 0 >= end 0
    [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
    [...]

Disallow empty region user inputs by updating the validation logic.

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b06..b3100d7fa5596 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	unsigned int i;
 	int err;
 
+	for (i = 0; i < nr_ranges; i++) {
+		if (ranges[i].start >= ranges[i].end)
+			return -EINVAL;
+	}
+
 	/* Remove regions which are not in the new ranges */
 	damon_for_each_region_safe(r, next, t) {
 		for (i = 0; i < nr_ranges; i++) {

base-commit: f5cde2d41633df3fb1965efa00bfa827ca41836c
-- 
2.47.3
