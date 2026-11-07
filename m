Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049479;
	b=HoZQDQi0wAWLiRo5jspaasmE/1FaWiPI8g3grxuueiH5U00zYfPfNoZ89AzW+K1tHWGM
	 8EXqOUfnKdHbzoWuvyKCPNdna02CmTn9ctgEsrQzxDAs2I3w+Y7afV5MQQpGMc/RrcyO0
	 vA92+jaBXIBwH+Sqexx+5SxnD32zh7unr+tnp1qzksVfFccUHyuE7DfLQ5D2jqZpzzqN1
	 YkPDwLZCpQss56KDiP/5KqS+laqCK6tnOFbIVb/A5l4Ui9xLg2ZO99fCmum3elk4zOyrO
	 o5br1QaIbuMlrdVI4h/h+uoM7lIhgbWFAyYtEXCWhf68Kz/yBxn6LToZFXpBkg3WR3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9ju9cFSt9dlUiyM0DWQB9ilMJMyKwWk9WALZRa7bGzk=;
	b=07rQXEy5+pZw/bNiOS1IHZKxkR6yNxCx8N7t2LcJilAhZLNjai8yT7UfQRqys0k4TNZj
	 IWobdh1/2An3wl4+6pJkzX7X6lm3u0UzjuSvD0OPfcMpTYlAVqfDASNVjQyLGltjqiANc
	 WRpg62iOR/YtQF6GT6saM4INejDpG9355AgLq8loSDnG8R3MelixX8JmRFjjSSa2YrnQ6
	 QHPuh1FvPKKEdczh5lBph9KHREAjKa4wxe6Jx1yRppvlgQ1P0/H5syEsaGK80N3cznj5m
	 5bHw8wQ+5qj+lDijdns0uoc7GItviYbB05v51SokvnkchRvBdEYeRrz3pfucfBnUaMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpMd0IT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F710606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpMd0IT8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625F11F0089F;
	Sat,  7 Nov 2026 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049479;
	bh=9ju9cFSt9dlUiyM0DWQB9ilMJMyKwWk9WALZRa7bGzk=;
	h=From:To:Cc:Subject:Date;
	b=DpMd0IT8Nn+sERQB82cP1MWXdpeAbqo950cQ9eKoB0P+EHkolXQI3I4wSL51o92ly
	 lv7XionOhiIJLCUVuzxvdZSov3Ft8q7mYAJkGJZ57Op4vj4gpBYCCbJ3bAsZiXsNWf
	 5oz7q1QNyzAcs9cKNOs/Qq8JuQ9nnGqV2uJ8oXjgmI64n6KmsMFFq3q5SbPd23M132
	 30eZDNl/9d2cy+fJUk60xSoJncoeqrijGvK1MWY/BlUoFX1C6PhHeyWaMJ6hMNDE9+
	 eTry+sVZfW3cqK+AEdmwYrjr6jOOuGXJ+LbpeTYj+Vkqg83g6I6l8i8dCpvkn6MtHX
	 0s/Exs20vkyCw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:37 -0500
Message-ID: <20261107060436-failed-5.15-cec08aad3def@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060436-failed-5.15-cec08aad3def@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




