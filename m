Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E423C50A;
	Thu, 18 Jun 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795737; cv=none; b=byignq+BtkG2E3A0e4IGnSD5C7JqWr39eEFiWRflwNJP5Ngq2uK7/ktbfMLIFWi4x+jCKOzjl3Bf3wvBvSDUp/dvqkLsEWgkgByl9poGZZV+ChJSlEe0q8AXpJk8k7+z2XI8s8ymk1JG8NWAbgGNybuWvW4rMygFufhxhFzAe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795737; c=relaxed/simple;
	bh=PrCUoNhHlTlE3ViwxH1NyTh+XS2Xv6AHDrJL2FJidVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoS6XyGpYSow39LS7+4cqKI9Bl3wvxtE9R0lqiZb20twmcI8kBxxd528h8NPFL0eALZiwiaP/1gwBnCDCIQ39jdb6R/93W3egOaDqbnZUAysuyWFiIGPO/gApOVjjx9lXKX1a6ViZxUl8XogcuVESql1L0FV09N9eqKULIEn128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6IRoX6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6IRoX6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66201F00A3A;
	Thu, 18 Jun 2026 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795734;
	bh=wcaOZ+THlXEeNyxi5XOx757xXbcMuDB56hf+0XEr0ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6IRoX6rTjCgJ5+uGS69LdhfK+neY28Ivn4UZDzL2vWa4NVi0Dlykg2xWYphkvxB8
	 tT2eSMjIOIztvoXLALn7GvO/HcVe7yLGkbWZhn3MJ4StKcNuzBx1EocyFRWR406FDO
	 iIz7jJjddEGRT6YFdYQuDmqx3TSOdEX9AeEfVpf9NeAjhGDGkF9Wd0GJXyVodbbA5g
	 E1RIr8LwsuA5NgsUYntqiolCepCwO/utlXPOPtfKvjaVIjAcJFc1fbEIFguZ2zF0lR
	 ttTAkQACdbsz1RmnfOuQAREcVkpssJSwZKvZQ+O6g1YsxXGXLnYk8Ae8Gs72/e673J
	 4eMyjGj38bibw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 8 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 06/11] mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
Date: Thu, 18 Jun 2026 08:15:10 -0700
Message-ID: <20260618151517.5366-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme quota goal directories by adding kobject_del()
calls.

Fixes: 7f262da0a30d ("mm/damon/sysfs-schemes: implement files for scheme quota goals setup")
Cc: <stable@vger.kernel.org> # 6.8.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2b0a1ac36420c..306c1d3d357c4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1465,8 +1465,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
 	struct damos_sysfs_quota_goal **goals_arr = goals->goals_arr;
 	int i;
 
-	for (i = 0; i < goals->nr; i++)
+	for (i = 0; i < goals->nr; i++) {
+		kobject_del(&goals_arr[i]->kobj);
 		kobject_put(&goals_arr[i]->kobj);
+	}
 	goals->nr = 0;
 	kfree(goals_arr);
 	goals->goals_arr = NULL;
-- 
2.47.3
