Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047633;
	b=MUXklJCuN9W43kFfO2AwtmaPfYtQEuxqNPnkhtfJZyblA/tlRdlcd4sEr/5owATbp0nk
	 xLdSo1M5yfhIMhuv0M9nRXD/8HQZMDaYWtDTaNVFvvi+AjNqJHbZP7NV/Uh2OepizBEVK
	 avtqe95CmNokaGs/PKKA4U5focJmclY57H9d5Dy8GWGcnOUL7O+04RVDXvJbbKg08wCh6
	 Ne49pxdT755Lk841d2rMem5qUJBCibj0rDCLILp4gqY4rSJIAXezuz2PDhf39+/79IZ3y
	 EbT9ixaIm0AscPnofZVNbYvh8iJ96GB2p1hfL74UPd6RGPIKsmG1kek9G/noLOIgzfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KA6R1ZP+1vZpG8i6sDmorUkj/Hy801w7phQXlDeKdsc=;
	b=y80RQDGe/I29iIwmst5B3F8vqmGqdzHilyAZbcgwNwEVScUF5XOSePFUG5GCR5PqM/AA
	 A6OY4MK3NF1YzM5j9+ZYTSFbuiErvLwTrDpK3aFAFWILS68G4FE+OKiuBSIcigN5u9FY/
	 SiiTm0cODJg0JmX/U8WyGN0ESbeaA5BdYM+lz7aHzh7CEC+8yxZqsQTRyxdXjPVkmx+ML
	 Az5v3NfwpTuCTsj3ktAHJHAd0n0uaA4d5zwLINnk3d01ZMuhUtQm+ogzXnaATrUr3pRqe
	 B3b1/DiQXBhhiehn7qQZKz0EV7exS6Cez/59fc1ZBVEBNl8E0thIFimdhWLCtJBeQ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcuPA0y8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC171606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcuPA0y8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A0C1F0089F;
	Sat,  7 Nov 2026 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047632;
	bh=KA6R1ZP+1vZpG8i6sDmorUkj/Hy801w7phQXlDeKdsc=;
	h=From:To:Cc:Subject:Date;
	b=YcuPA0y8Z3+lsmcv4Iw64PshpCDI58D6onnWcwLVyP0w3ybpu1SFdxrgetYWwxkIB
	 73GTGC8ZzNyzBjGBWvqhk2xwVuAZTWGYIWy5mlWVV9+5/sFIjFbaAxu6gkaFGqxACC
	 TDO8rxjQw34+PSPZtjfii7LbykcL7UpO8uswfyj81n8W8IBUyjW9JAxaSDjHef4Jmk
	 bjDoTTQ9CgISIZV+Je/+C2NK8xjvjgTGLFHlqgZ/2C0qxXUX63DEhs/DKTGAofrPrf
	 C49C9K61nt2Fey/xXr7CQtbX72nzyABwQxq/LrXoE/qfXPxnkQfaPFO+BR0SAdyuIO
	 qi01W7H8a4Z1w==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:50 -0500
Message-ID: <20261107053350-failed-6.6-cec08aad3def@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053350-failed-6.6-cec08aad3def@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cec08aad3def79bdb7a795a05e7c9a11d577b4f8 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:23 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: use switch-case in
 add_scheme_filters()

damon_sysfs_add_scheeme_filters() has long if-else chains for DAMOS filter
types.  Convert the code to use switch-case, which would be cleaner and
more efficient.

Link: https://lore.kernel.org/20260914142327.92510-7-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a4ec5d54cfbd1..bfb6f0bc3f213 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2822,7 +2822,8 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 
 		if (!filter)
 			return -ENOMEM;
-		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
+		switch (filter->type) {
+		case DAMOS_FILTER_TYPE_MEMCG:
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_filter->memcg_path,
 					&filter->memcg_id);
@@ -2830,16 +2831,23 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 				damos_destroy_filter(filter);
 				return err;
 			}
-		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
+			break;
+		case DAMOS_FILTER_TYPE_ADDR:
 			filter->addr_range = sysfs_filter->addr_range;
-		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
+			break;
+		case DAMOS_FILTER_TYPE_TARGET:
 			filter->target_idx = sysfs_filter->target_idx;
-		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
+			break;
+		case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
+			break;
+		case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
+			break;
+		default:
+			break;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.53.0




