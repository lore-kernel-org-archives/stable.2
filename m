Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7743C061
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582391; cv=none; b=pU7T96QIOOj6sGzXB2AX6kh+dgGnFATjWq0nMPEcRbwRBG7exQsijWUaD/rFJyYJ2zTlPvqx9tlh+B4aHZm0WYImVM4vu3twyzqyluDJN04OiJwqKGel+LR+RE+znXBjkqFZdZgflM2V/8Z/noDav1U72vPOGBgBnDjcK0qqQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582391; c=relaxed/simple;
	bh=9493f1ychnYbg7oQLXWLPjb/RGy7UM/fzgEegVG+3Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIBTElAfjDR/Qkwcb6b9zUOqBv+jxP2vD5PFWcEXhJxO/emt3VcXtfKZV+JCH8kSNRcRfYwO78K0vb9f5ue8CWzCJBzlF+KEbrEgXO8O+mxp90kSiCbVeFsMMEl+rltaqW/9t6FgSGr8XE031CAOjR98O2GRiilEHR7WwVC8tCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z81dgDTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z81dgDTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E9C1F00893;
	Thu,  4 Jun 2026 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582390;
	bh=BamHn1KlBbqX6gAQHsFnNIfhjlnANmy5RDNhlWUuvNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z81dgDTljUxcRROSro7M1Fm05J9UkIA9qBuziO/rABMF7ooBmgVnJ/TB0f0IDvVmh
	 /8qNLjKHJ3W0PhYO/RRoOd7oRQjGhbOI5NdaDBQsLhqLH69HtZhS8mVHmmGKwLIvg0
	 /Ciu9YJvZSdBzrJI0/pZBplhn4Pa+ZlnRB0GIqI8Oi2RROXFdZZd/OR6o4hW2IVNi9
	 jrLJ3LPQltYHZFPh3YCqVAnoHktxiUPqjQ9ke72pWNpkXKcqOZUnmCV7xiWa4L+zi/
	 kypX71tJHfBdSeQchNwpdQ/ovC96jjxeik+lVLlKE/RlG8lMh4RVwI2shYfDks/fQr
	 /BnSrreV14IeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Thu,  4 Jun 2026 10:13:08 -0400
Message-ID: <20260604141308.3549703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060426-crept-cursive-9df8@gregkh>
References: <2026060426-crept-cursive-9df8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 441f92f7d386b85bad16de49db95a307cba048a2 ]

DAMON sysfs maintains the DAMOS tried region directory objects via a
linked list.  When the user requests refresh of the directories, DAMON
sysfs removes all the region directories first, and then generate updated
regions directory on the empty space.  The removal function
(damon_sysfs_scheme_regions_rm_dirs()) only puts the kobj objects.
Deletion of the container region object from the linked list is done
inside the kobj release callback function.

If somehow the callback invocation is delayed, the list will contain
regions list that gonna be freed.  If the updated region directories
creation is started in this situation, the list can be corrupted and
use-after-free can happen.

Because the kobj objects are managed by only DAMON sysfs, the issue cannot
happen in normal situation.  But, such delays can be made on kernels that
built with CONFIG_DEBUG_KOBJECT_RELEASE.  On the kernel, the issue can
indeed be reproduced like below.

    # damo start --damos_action stat
    # cd /sys/kernel/mm/damon/admin/kdamonds/0/
    # for i in {1..10}; do echo update_schemes_tried_regions > state; done
    # dmesg | grep underflow
    [   89.296152] refcount_t: underflow; use-after-free.

Fix the issue by removing the region object from the list when
decrementing the reference count.

Also update damos_sysfs_populate_region_dir() to add the region object to
the list only after the kobject_init_and_add() is success, so that fail of
kobject_init_and_add() is not leaving the deallocated object on the list.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260518152559.93038-1-sj@kernel.org
Link: https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org [1]
Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e8bf79c0d344ec..62df3ff8de178e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -78,7 +78,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	list_del(&region->list);
 	kfree(region);
 }
 
@@ -151,7 +150,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
-		/* release function deletes it from the list */
+		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
@@ -1772,14 +1771,15 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 	region = damon_sysfs_scheme_region_alloc(r);
 	if (!region)
 		return 0;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
 				damon_sysfs_schemes_region_idx++)) {
 		kobject_put(&region->kobj);
+		return 0;
 	}
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
 	return 0;
 }
 
-- 
2.53.0

