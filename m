Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A11D7E5C;
	Sun, 28 Jun 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684087; cv=none; b=Exy7Es5R4tuiFJ0Hur09I73bavanaZT5eDY53j5mT852nj9jWp4lw3jiC6euyknL5OE4RAaHWT3GSmLjWOrud6l0NMx+8KLZpx99USPzv3SEpeCBj3b3JHgN9tXhSHentJ/nWQS1bX5xNUj+tC1WOdbcH6/fPSPzqjpfFwmQgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684087; c=relaxed/simple;
	bh=HA4Oo4o34VNWfpLaqZC03s0bqN02SO5fjScWYx2bDM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8gdhuKsDN09EOntancfhmjBwUz+VxyYp/d4FeTk8vEj6I1gu911wh9hJjCq1XHijI93bXJjE6txm5YZYY4F7SDMVSDNlGHIXoJUpIHroj+stbQZsFYORZMh2dFvTAYHv7XWrZxMDHq3Vh6CverVtHfm5MQER7zGkANLIj3LrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXALbY/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXALbY/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3DC1F00A3D;
	Sun, 28 Jun 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684085;
	bh=kWsoAsTU2RLrwCg9yIH11L07Sw1ho6y486HJ6RBWC/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXALbY/bP7agD+NSNT/wgc3+09pPckbDI6uMcxzEJJp0aSErNwKoOXuGUuQ/V1+Vy
	 U1wzqONNSi8fzYLB8K74lWuWsqW639h1mV0b7BI7kDq5gdHwPNdp6aqwUJGbL7O4QZ
	 AXLr2uOOV78AWdEaZ6MdwT/AepXjH2Y1v8K9RuaNDi6CXgdLeENvD1s3HJTMQhi8et
	 TiGM2D4DeW1xSbfD/OvLYw+o2BGC4IY+dpAi+nNUesTid3oCMhTPxSmn2Ih7inRh+3
	 x/sAUs68rILMRHGHQG68nltgKY2RY+ebq04XD8S8VR5PHjUnWfooR6MBBtKYzX7TY8
	 U0QxGPPsPiWlA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] mm/damon/sysfs: kobject_del() region and target (error) dirs
Date: Sun, 28 Jun 2026 15:01:11 -0700
Message-ID: <20260628220121.97360-3-sj@kernel.org>
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
those issues for the normal creation path of region directories and the
error path of target directories, by adding kobject_del() calls.

Fixes: 2031b14ea757 ("mm/damon/sysfs: support the physical address space monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 38f3b02481f0a..204aed6a3e5da 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -105,8 +105,10 @@ static void damon_sysfs_regions_rm_dirs(struct damon_sysfs_regions *regions)
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
@@ -370,13 +372,15 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
 
 		err = damon_sysfs_target_add_dirs(target);
 		if (err)
-			goto out;
+			goto del_out;
 
 		targets_arr[i] = target;
 		targets->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&target->kobj);
 out:
 	damon_sysfs_targets_rm_dirs(targets);
 	kobject_put(&target->kobj);
-- 
2.47.3
