Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050479;
	b=f1tq5pD9oxZpKKhewe8nm6WtiZsKH4A+hUyQFZMDUsRqeCuz0Fxh55ZN/YINzQTRkB3F
	 8nzOj38m5bCVhTgXVv4bqini7d82P8UTJjt8VeWiGDCPtHUfKKrtplxomWQh3e0jw3xDX
	 O1LrfVRgetFCySQ1hlP8r/CNNFYTL5ps9q67rblGrwNrX89Gst5bIrzv/YcsrG3s4nxv9
	 actAkbd51X6TEB8+pe6TtHY14cvKVE146nesimbBknrPMCNLMLtgSsQ38UIvL1ZKqz8nJ
	 ke2bDhXGfpK1PFkBF9qHrlVH1DHhZ/qqjE5iDbyAuJGuBKP0ZHkip5xuvx8BbPD7+Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Tu/eZwQ5G3GnTWteF5c854g2J0L5nGzn4jL1NRgeRYk=;
	b=u8NsSwPQpfoUY/f4MwcjxqztDSqhvhSzXN2kQ/ZF8QjNf1lgQsdR3v4zHbX0MSe3uVja
	 maG04x/FIe8WXLa5AjdT0MGVy8bCEMDEzkgJj+ike94k0hnDVM4iXV5FvXXSsbO3CYV7d
	 ztR0BhXKPxslPPyRJSWKGigbfs/psXyyi5o74dtbeOC9oekbwUMQLShpGtL3H2hSmgXwI
	 MEPl7kyi42uiH0Kjp5brNNeAxP23vEb/OJkxZScgFoNO/ib9wenagCyGz9h52OOJR5x3f
	 x49G5Ssh4OAGX+0aijXxmGJTKQpe/cUWWju8oydzwRp+hsVfFdpsricUAkurHlxdOcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn7yw0Vx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn7yw0Vx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561B41F0089F;
	Sat,  7 Nov 2026 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050479;
	bh=Tu/eZwQ5G3GnTWteF5c854g2J0L5nGzn4jL1NRgeRYk=;
	h=From:To:Cc:Subject:Date;
	b=Bn7yw0VxwqIat5ocElMQpqCbl3f2p4MZIrZx3m1/BdvTLPDO88esbnpimffyaTTkI
	 ZmkctRartb5egjYyei9s3Pr0bfCaApMOhsNpKjlTXJiH2383QraFRZDvwRr3BrkrM7
	 Z/zGDgbsgzYtS+dYQAv86KbT2KZPmoRPF/Or3+WWgPIkjU8Z1o53WPoITw9CRbdLH2
	 aXCbhj0ozw1d0saUZnJApRQ/yHYg4hwmVmO7gu0VBYII9XKHqYXvqLQ9pTgyWo0NvJ
	 cSX8FZaO/5vaL+EeWG+cvgh8RT6G0IN+FuepiQSuov6qr16bdffKr2NbgOJNQtEGDX
	 k7yVMayPmsthA==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:17 -0500
Message-ID: <20261107062116-failed-5.10-cec08aad3def@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062116-failed-5.10-cec08aad3def@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




