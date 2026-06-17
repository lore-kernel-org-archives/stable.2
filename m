Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D443D4EE;
	Wed, 17 Jun 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707715; cv=none; b=NnWV29cQYFt9tu70Hn6LKBDp4EIAfD7Yi8SgYVFu5aNgtYEEOv0UIcFd2OjO0WzreNGxId+89IUQo/b8LdyfDPriAA+o1+zeu0vn9mCUT15LSaIS312Wx92YiMd1nMdVNYHDP1OPeIt0A1gu6X0SyvtfzhlDBTs9VRtJM5AzoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707715; c=relaxed/simple;
	bh=HWdAP7bN8wgLM9Uk9w1J0MsTcc9ctSj3NsL8gL3RJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1m0SuprDejMszcj54Un7tei2gxO/l0NbqxHrv8eXFkXAzUGKEPXJ/vrAcHc/ovv1Hxt3OzibJW9TWVR/i3e99W/KMpCZUOBPPBngvUr1xrZoFngj1dgPjqmB+KN9gU8WHfs+u9c7w9A5W1PJ2aurf5Gnn8cRFTHMGYbGnDvOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVxXd2YX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVxXd2YX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF3A1F000E9;
	Wed, 17 Jun 2026 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707712;
	bh=f+ZFI7Qgbe7xnOZyetZ4L3vI22eJ2l2ckq5hmR8a2XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVxXd2YXwpYsPaBtMxM9HElDwEg9rP0hxcsnpXi1/rBg5I54lAOndY2s1LZcLjtJS
	 a4528TTqCrHARYcSxWzsGnb7j7l7qv68OOZZ5OjgHdSuGw809Zbrn5M+Rhp3nhr2SG
	 H7D9jNT/owCWRE2mxBKG9AikIEbr5Upnf0ULRT8lxTTiNXHE1BZCo5AdpKvN+Q4VhO
	 IooLKTCvvSUzXfYZOTE26gZ6YwLBtDUijfjBwhpOwjMuT3C6F2k/eXXZDzQ9oAmesE
	 KBe74AwM91+YT5ksiBxqUIDm2m1JyIRXCRoOCUKjOBuZnO+qKI1uoz+ecKXQ4m7RsE
	 3P+dlmPi7BVCQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/11] mm/damon/sysfs: kobject_del() region and target (error) dirs
Date: Wed, 17 Jun 2026 07:47:56 -0700
Message-ID: <20260617144807.91441-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
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
