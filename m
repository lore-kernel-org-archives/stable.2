Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40423B993B;
	Sun, 28 Jun 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684088; cv=none; b=jhPoK0qQkzmOeIm94mFjt6mY931pfwT2VymAM2LzYYz/OkGCwhvjYJvv6M3RNsohOrRcZCgzeOhOnAtuLHNdsU9ua+43ZqxEAOQUBkxG6MIqmcRpNjoW/b1AuoNz5LVxJXz11JGJMrD4J7EuyyVB5bryjJdd9Pn2q6YhW2K3/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684088; c=relaxed/simple;
	bh=+HqDYSfJRqMjE30x6P+7tsUTx5xC+f6+iwrRC3CA6TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5WcY47OGgC1pOrSmCjdYgUoaS/NSomzDUwo6O82gwMDxaMdU7h5ng+6bS2YgIsM/y4qC7VUkzxAk7hybSsArHvG7BRAttA7bgqCEP5kqHr8P3yHqrL/GMOCwutjSZCXNzxxzboNiRX8Zhplx7ts5v6rc1Jvy9oQ8jhojN29ij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7snI7ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7snI7ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9C31F00A3E;
	Sun, 28 Jun 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684086;
	bh=NXkhSNQJNDKDyNoOpZwIsSL2pL1PP1RKf/KNfR1efPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7snI7dsYQUBKz+sEXAwEJ0jGoB9h7VmSZbnukrtFhNlKgg15CBOgF4ez3l7Yz1zZ
	 UhN6WecoYgfpASxnzeLpWiE0xxUi2Xtzu+qd8iNdgnbe4o0GvWz23YEU4USNP+uyb4
	 dLdMpwRVQUFQhu8qVbN4Zwp4Lo2nkfOo8DQikfnNwcZAH/U+cfiQq+Zw4V3g1QZfkj
	 QvDnc6khpqr0OygI0Pjlr/sOB9zPGiwuhXI/honAzHMywIJyoofAafC1Ud+qf1PiVA
	 tBf/BzCaWvCTsTDlNQ9wQyt5zMyczTsXLhkjl5bLV4B7RLUK+ZStT5ohRolTSRJYSn
	 cBz4JzhrUw6IQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/11] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Sun, 28 Jun 2026 15:01:12 -0700
Message-ID: <20260628220121.97360-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3cbeccd436e40..db496d2e493a4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2681,6 +2681,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
@@ -2722,13 +2723,15 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 			goto out;
 		err = damon_sysfs_scheme_add_dirs(scheme);
 		if (err)
-			goto out;
+			goto del_out;
 
 		schemes_arr[i] = scheme;
 		schemes->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&scheme->kobj);
 out:
 	damon_sysfs_schemes_rm_dirs(schemes);
 	kobject_put(&scheme->kobj);
-- 
2.47.3
