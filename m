Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046893;
	b=YRAO/a1dcOUECT/lMTWj++fOtjAecg6ezCuC7YJcExKqno0uysKjugSES6ID1Ltrodvy
	 1QQ9PvOz8qmmfW6DHuXndLij2QbuknqhE0g3q9I0Fr5WWW7xqymCijggXWrdPc1lqL/4a
	 yHERjKcUf2+yTR3qE+BhagJleCS0Z/Ld0IZrxPQSd39cH2vYk6T6iaNGwJ2ttknDJsZOq
	 IA9d18EpPMEtm/+IJKbwJMcNUCp8qIvQRJveTj83MoU3cQW3lwKAlnPadaPDofix5Tfe+
	 FEzhgUrqLHoh8GyozFFMPwwfJd8cRAgD3ktWY1DKVlXRraxovRFOhtGuHSpRoVp9+3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=slPzfr/1KeAwv5xtf06F2uTAM00kJQ7XmNnNhKWP/zc=;
	b=0sOu7106DL84IUK+flR/7QfUk+WTvYImXe7lEQZiSVQ3dXkOez+glW/Hlz/rZ1ppWxUw
	 0hIidu8X0ZNtSCPV3dDoi1yvQUcCboOKQiURczfmGn1rbrBh5dBW4xNfuDtNlcQHQjgXh
	 kE+R6n5cg2HgS2iq3vqLUTJoenKTaUsQ1TW9aujPQfhCNqnDvT0bj+FOYDVGviHpMmRbb
	 r9I2m/Ih8WRttb6X7SlaZYVqe+UCVJo3YHQVl85oANwVbcAxPb8MfdN3C5Q9QSxqApdyQ
	 fflnjC03/YoxKrMYccp+RaIR3emY8VuZmAddJHF9MaJ7hP71lcoMlnl/EnliRb4PKcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIdpfRlj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5540606A33C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIdpfRlj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF21F008A1;
	Sat,  7 Nov 2026 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046892;
	bh=slPzfr/1KeAwv5xtf06F2uTAM00kJQ7XmNnNhKWP/zc=;
	h=From:To:Cc:Subject:Date;
	b=TIdpfRljbWqQb4uXSMCDEfWaR9+LRLO83JM2FntYuYYLgL5pZyGD2X6LMKiIhj4lc
	 F+f4exeR1KLkJHzvZvG3HjakvYcYV5tFqIM5eI+NcCRGlPZYYAnFqXDbp0z0Rtgu1d
	 XLUD0O+cRtB92ZV3Y4rmp/0EpJiD0OJJI5L5Eerynu1WMlU3nR1qc34grgf2TlXXyF
	 bfZVosI0TGkGrIWMZ4YNq9l6XPs3uEpU83JTPvvUL/GJMk6Vzn1MCpvCiY9WzPwi33
	 HNO8XVuOiqHJfL9VAVcofhgLi5HGeNlf+JhSvzBQM3pLoOyNF/pKOktgenb0pEZOEo
	 4GQ49vcYdsoyg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:30 -0500
Message-ID: <20261107052130-failed-6.12-cec08aad3def@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052130-failed-6.12-cec08aad3def@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




