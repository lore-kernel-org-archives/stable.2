Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA33FBB76;
	Thu, 18 Jun 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795731; cv=none; b=iBPSGOilxMtvX00E4m5Z/5dZRBUQKHzpb41D5rL+pBe3uUNPk37dYah8dzr21uQDXVWotX95s5MunxHwHzc9ug9IkJ8Jx0aVQitVG/PPj+kULTHXJr8cE0d3sUskvu84AS72HF6w/IBRL6Uc01HJ+5E9eljcaOz2f5m1SEPrfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795731; c=relaxed/simple;
	bh=HWdAP7bN8wgLM9Uk9w1J0MsTcc9ctSj3NsL8gL3RJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZocpNmGkuj70KawF60QZHDqoTrduxLaliFkzOXKJpOCWsXmwGtB0oO++9IX2+N7m/8fxyXGgRcMyFsqSBLtiHbTk/RQuaxlb7ZamKtziUL7dIuAu1SR8Stj1l94YiPbXT/6Rb2luNAj0sIyhEU5zeV09FosomZA348mrdocoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4otBAAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4otBAAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940931F000E9;
	Thu, 18 Jun 2026 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795730;
	bh=f+ZFI7Qgbe7xnOZyetZ4L3vI22eJ2l2ckq5hmR8a2XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4otBAAdK7g3o77FEZQlZkjkONMzdQBJ0R4LsRPs5AkdB02wLhURfZ5fgv/dnc1eW
	 x7EtoweTcNqhD8+CSvHCtoKjG06LMUpEU/sMWCBNiThl/khQFDDxnamTr2pbeGL6Na
	 u14I1gBO1NVF5qzQ5SVCCdRULpcy/o1xKdvuLG5e7MsJQv3LbGBjInCHNIgPOQenbQ
	 KhCLsKOe/KUMaBEfTu3BFjCxi1nmosMs/FD4xSVEcOCkvC5kKCj6yWaz5QhLzePkE9
	 t7HRJH/vG4FA3T7JSX7bq6rso8OyVWf6DKuJY7ytEGZHa3AePC67Ma5zeGjIYBXC+w
	 6MQCZ6V9CAJxA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 02/11] mm/damon/sysfs: kobject_del() region and target (error) dirs
Date: Thu, 18 Jun 2026 08:15:06 -0700
Message-ID: <20260618151517.5366-3-sj@kernel.org>
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
those issues for the normal creation path of region directories and the
error path of target directories, by adding kobject_del() calls.

Fixes: 2031b14ea757 ("mm/damon/sysfs: support the physical address space monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dba1c67fc188f..3c349f0fe80f0 100644
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
@@ -372,13 +374,15 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
 
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
