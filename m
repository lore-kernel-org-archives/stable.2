Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046232;
	b=V4hgTMOHZEaz4iisAsLFLxOoiY8lR1CKQK8YGrUBHckzAJGoc4LAuRDRXgNHW3FPOr0m
	 +JPX3NKObHGRO9lgW6tXuQlqtpDqfurNll85bWFkNgEHEheWslWiYmbVqIGBC4fXwKXaE
	 EAF9DZoIK/VC8+ByqWCODO4Xpllzt/jL5+O3GeCfGgRWw6U874ugzXnBy/tBNZVwe/J20
	 qtAnVCH6I+8ocqvNA/ibJgJz4cjH+e1kgOk9fjKMRKhwE5d/d2eLR041BqqWcv9HGeXBw
	 JhmsYI+OWxDFNqNPxJp79YlexQ2+YMO0LwaI8JflKGiFM5sGe0EEFWFzlegH0G8VeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ogFKrlmDBeMibgwgreNTKLy4+4s/ll73Uk6MafmbZ5E=;
	b=11/2vu9ttyTRz8IxFVh9DwpOSBnWVzU4MtaemSkNIuBF4pS/IkHRFcI6Gc6dw2rCvt/+
	 alirLpKPL586EuwuXfArqF4S6867Gnw6rm2uKVvhz4kxbdewM1Asc7lxnByAJ20P0dugz
	 FP5i4Dd82Zp5LhsSnrmzr3sashRXRvtQRqnyhQ3+DUqLWA7FVNYJ+tFQIokiuUPgZnJZB
	 6nhOcw3S2cZaB6+daGtst9y//JqzEMZjZD6YdeBXN15aj3+ew8OiZfFFNjGa3NU+rqfZy
	 2+UGnzoCSmOTPCGSywwQr4f9vpClvh+9p59gfwCZclYcw2kz8aUxxUAsksvEbjJv4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuEc3X8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EB606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuEc3X8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED881F008A1;
	Sat,  7 Nov 2026 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046231;
	bh=ogFKrlmDBeMibgwgreNTKLy4+4s/ll73Uk6MafmbZ5E=;
	h=From:To:Cc:Subject:Date;
	b=LuEc3X8AsIIFiYf2TcNS+mydEvP4i20egfVEOQGLLzTdId/TAS+tj7/juuW54ysqY
	 coCPrGKbS0AlvkpP00L01bFtDJE8IC86YxDKdY+K/6jMLC5sDXITHEGmwYRGM1csJw
	 40+GHfeTMN7YTWB0RqVW8PjYIVzu/6vB4SQto77TiggCCisc++7Qd+UGTz1f4O7qD4
	 5disHyaFGfj6ITgmHuUFie+AObOGMn7nS16TIoyrw78V/oh3Og6Cx7UY8NPS49TbGk
	 Iiq4Bz0fMZ9/0E1UtPBg/j8Z8pCs39/t67+c1RvLAvyIxq6vFNPFCC1c+SKN4fBgDb
	 W3pms3Rhygowg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:29 -0500
Message-ID: <20261107051029-failed-6.18-cec08aad3def@kernel.org>
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
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051029-failed-6.18-cec08aad3def@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




