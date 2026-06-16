Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926643D4FA;
	Tue, 16 Jun 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622541; cv=none; b=PjisfAWGgtiREeIgU7z9HFfhvt60x9Mmz9P3+301wGh3Dn3NXg1SxYch9HWK0xs8dL33YCfWi7bqVcD0kNX88hN2zxYHfwJQJg//gjXZU73do3OGwnhzAjKYskesNIDxZesgFeR+2hUYR+lnGLMvplmKta1JReQ7sDCS1tk6EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622541; c=relaxed/simple;
	bh=Pd8mPE2Fvko1J6KmHaqS4qqATElkvq9vRLOsxZd+vHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH6bRI4HAF8xWOzpUIfII/MEk93YHa3ykGbM0AIy3CfbyKR1IQ7yBTEVdvOoiZejC7C02San87oNGv6noU3W12HrPw2cmDpRSMRgTs40OmB00uvuewf3Y7gBsiOJMXx3OTLUgLhFP1+sgF7cT1yTJolYm5cqloQScgfesI3idCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPvn8Uii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPvn8Uii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7041F000E9;
	Tue, 16 Jun 2026 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622539;
	bh=3zqOErsRkzq/3LxD3DfZ11Lqil1gbzd/2T/9oVVoavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dPvn8UiizKIj/OWCEgR8H1mhbgGp+l68N3YuiCAev7YJWay2aU9tVTKg/MhjQhmbQ
	 d/Nn20RcW4dLnZpEpVQJmUHkEIl4ftmbts2+U3X9/p7ZCZBAIr8KqLsYGgglOfkgPF
	 B5MCNggh70wcPXt67jIACfKHHm2xJXZmoR5svit8Iwq6ccJGMK8lgXqEoPci2CYDzD
	 iLDKGMBZR5Joej2Q0Cnn4lmsl3Mjy7SHjD3GFOpmxXFGxBemJxyjpw/7rIpega2F3R
	 tRZ7nNO4ZsBKNuk8cplBmpS5adJapXVdP8hq4VqZ3UoZutSEfIzcC353YfKv52XJ0u
	 WtHIWFu0LN20Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/9] mm/damon/sysfs: kobject_del() region dirs
Date: Tue, 16 Jun 2026 08:08:36 -0700
Message-ID: <20260616150844.88305-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for region directories by adding kobject_del() calls.

Fixes: 2031b14ea757 ("mm/damon/sysfs: support the physical address space monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d93f7919c3ca1..f72e1e37df9d8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -107,8 +107,10 @@ static void damon_sysfs_regions_rm_dirs(struct damon_sysfs_regions *regions)
 	struct damon_sysfs_region **regions_arr = regions->regions_arr;
 	int i;
 
-	for (i = 0; i < regions->nr; i++)
+	for (i = 0; i < regions->nr; i++) {
+		kobject_del(&regions_arr[i]->kobj);
 		kobject_put(&regions_arr[i]->kobj);
+	}
 	regions->nr = 0;
 	kfree(regions_arr);
 	regions->regions_arr = NULL;
-- 
2.47.3
