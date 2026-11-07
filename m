Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046241;
	b=XNS2UjDG60ymZN/1ILPjSTp2G/+KRt2EWXi+G37kAww5DT5dCVUxira5omiyu/OagFmL
	 3cw8jkYG3lOzlgUeCUZB7RCHj51hA7xW7jGEPdF0WnjmI+ejdj37n7KavuzHbpe0VU6MD
	 ud8tErUoyOP4oN6zLoGjjRg+iOInRF23rE0aVTKidrt52AT8hCKVzhzDkuvgfS8FVFQrD
	 tEZEurPiMUDrqlzotKSXNADUUD099CjW5pXRUeC3FcmpdHYpmp/zNK94NKjlXU5xjVi/6
	 EdJLVPHhpyK6AtbDY+9piWC7DuGziQrkfzfGubjivhRr+zEtLOAr4DzqrfwAfVyl/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zcALOyBpX0aEGp1UkVzo0j5csM/2WoghZ1KGNOEASg0=;
	b=m8+eZL7FAj5r7aHUSh+fhiO9YwtJW5hHTdF4ysENB8BNIh5eZYhtJzcRCHUBHzN3AmmP
	 4tlhnJZ0ZcFCHbnJLKkv7hya2yUod0cyDbV5/IuU3CnQA1rawfyIy1M/oyrmoNtK3NhqZ
	 FByRk6yo4PcCqYRsSsgpMGnir0fsWfvSuohmXepwu5PXvuojz+Jgys7LNgJelwSkHmkwq
	 72hubtQ4Sh+/PaWItB2bKFMweme/XEILQRBiv/UkmD+3404EEM115wgPfQ/96Enxu1bcE
	 pX3VcIujTE8/qmylV3C2SAbE2YbLU8nEu8aMElDsSunKiG85R34tl0RscmJLpmx68/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hF46V8ri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hF46V8ri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F4F1F008A1;
	Sat,  7 Nov 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046240;
	bh=zcALOyBpX0aEGp1UkVzo0j5csM/2WoghZ1KGNOEASg0=;
	h=From:To:Cc:Subject:Date;
	b=hF46V8ri7X5FnNdvO3r40sr05p859nKjiTl2IvHZ1yZ+tw15Oz0hF4sbQ0py8aykv
	 TCekWBENpgQQppn11DT5gX/jrMKyaCx7KNIjohyTRHZpmHYYfFLj9LA7z6Ei9M7lzg
	 EITEczdxjkiGEvNmwYHQ66TIIz/bULUvDI7wL2RHy+ZYWI/2bdY/Y5WmrzAlO9BBhl
	 tOR171+WZRKew/Qe8+p4L5pTzfOEtCz+dtMuniAVjNdTXJc4CD6KhzxxeDPEKEhGCt
	 2dbrMeuyU+jrV9VdCP0o1cpH6WZji9jmugZjOlz2Y7EctMzBP2Elej8ydeS1U5/8zC
	 l3CTFh30FKLbA==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:39 -0500
Message-ID: <20261107051039-failed-6.18-af19aff38d6f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x af19aff38d6faea35b10f26cca32d0e54f8aea5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051039-failed-6.18-af19aff38d6f@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From af19aff38d6faea35b10f26cca32d0e54f8aea5e Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:19 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once

DAMON sysfs interface reads the user-provided size range arguments for
hugepage_size type DAMOS filter twice.  Once for validation, and once
again for assignments to the variable that will be passed to the core
layer.  If the user updates the arguments in parallel, an invalid size
range could be passed to the core layer.  Avoid it by doing the
assignments first, and then validating the assigned variables before
passing those to the core layer.

User impact of the bug should be trivial.  From the core layer's
perspective, the invalid size range is not really invalid.  It just works
as having a weird size range.  No critical issues such as a crash or a
leak could happen.  And sane users ain't do such parallel arguments update
anyway.  If they do, such racy behavior is arguably somewhat expected and
deserved.  That said, there is no reason to keep such races.

Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3c1c1cb387fec..8c8ab82c8facc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2840,13 +2840,12 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->range_min >
-					sysfs_filter->range_max) {
+			filter->sz_range.min = sysfs_filter->range_min;
+			filter->sz_range.max = sysfs_filter->range_max;
+			if (filter->range_min > filter->range_max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range.min = sysfs_filter->range_min;
-			filter->sz_range.max = sysfs_filter->range_max;
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-- 
2.53.0




