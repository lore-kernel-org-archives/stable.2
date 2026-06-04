Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96F42314F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581499; cv=none; b=pCR6r1CDvpQukt7GYp3rSThaRBMcs6wfK+NX0PtmxBwNvBi2tV1eLzGas/mdkP2LT2k8AMp849FU09f1u6IlRUMnI17QLONiyLUvcU4NUacTT2s5c63W1gUz+JOm0+PbYv5cNYkmTB3FYw/DBjfu9QfCcGOjJOQtr2n7uJbFGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581499; c=relaxed/simple;
	bh=ENgYcvN9O2d4UTLvvvhPXNSaFtfLXLuqibB8pKCbW1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWK1AkmbO/KCVtvtGUFZAs+ehrjQHS2ZtvdBKXrQVK4l3Hnz3xVYlb3wPV7lSrIyhxTLvpcOQbL1QdaDmNZh1UgdTVC7VUpSp0aHQimhm3xzC0jL8LXVFa6c91tFBHwhntjikHJXQnSRxmqpldUrx5UwVo7BTYiGm2ccs0uDtro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaKnks1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaKnks1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029631F00893;
	Thu,  4 Jun 2026 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581498;
	bh=dhzzd1HTIcy8covyzvvMvOFjY1rZ4MA3AvUYkRTxR9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaKnks1HqpQfR1qaSd3fS/n9vLp8GqEygKN0qY2lcyTb0mXBlUlDmlZ0ogHvyk9Ow
	 opqfJJeiL+OdUZD7N00ETISy94+anRXI8p409a9NH2Ii59t5KHpmTX0GarGutb62Cy
	 Upk8ffm7RPoE5a9Nd3Ev4sq0qK/n4q5bMBeMbRWYZeapWPjsiwZCwzTZ7emvUne6gy
	 FhPMUrDzxcgWzHjrJ9R+TIv6wpe+jVCRP4lkNQRZV98WUSh5ORb01KGdj5xM7hLE8K
	 NScauqWYaGmNfLt0mV9rvHF0Q8KSAC95Ar4W49ps2wj5K4JM3HXYAM5/SpWQIe2gLD
	 KntSeizNx+MjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Thu,  4 Jun 2026 09:58:16 -0400
Message-ID: <20260604135816.3505741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060424-tranquil-chewable-b88b@gregkh>
References: <2026060424-tranquil-chewable-b88b@gregkh>
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
index b550d1a175074e..a84a633e792412 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -79,7 +79,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	list_del(&region->list);
 	kfree(region);
 }
 
@@ -197,7 +196,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
-		/* release function deletes it from the list */
+		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
@@ -2186,14 +2185,15 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
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

