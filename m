Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045874;
	b=GNQVUHlHYImcZ40cDJnw9bYUrAbupN6pBOfe4Xvimk6gPDducDv+9tXn0EbNiKMxR9vH
	 nQdaq7NkhfMbhnCtOdkIe1UNjAAK8IpDCT17I+A5pltuaCSrsw6QRtUUEb9JQvyy25DZM
	 4Gl404Vi4u7JhSZST/sdapsYhymuZOO+D0gcXYZM4GwYh1v/2Yb1LTKJ0EUKrBLCgSQQT
	 5PZJ5NqUE9K0EcGpUNyJguPrxwVE4cdyIZotjN2fZHY8oCPF/VItiRkAfHfhJtzVMHnq1
	 w/zq5mOaPbO0NYd5brXpl9ZaJ8AHNroyA/TOtXGnD6w/u3l5lfGp+qlt49h2JOk/bRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1+d+vWGDYXtRsD/uu/AyQg8l0o+mRkjflMLY2bZGhuI=;
	b=Tea+xW7YHOxVnZeQslaP9IzoUDYlhxtlADft//nd/497mVwckxGHIC9KDZZdxnBCyczY
	 uI/8f3efGx36tAzsZp39+48TzJuxEyOckUrtEDtqQ7bomTAJLVM4UtxPtEeEZ+3tVIcu6
	 /GC1GpfDVM4dkqbkHPfh5kCPyU1tA/hLIJUjdJR/gC68fbdZxf4wmzZ+2NnK510PXnsDx
	 Lgz7mb+89GVC8GaKKsCQuxwei9RwlzzpcPmnZazlh+gdIvMNMnJSpudjZcbVWVlA6SGhz
	 xAwXGPQZZXO/h7Xri9VYsAHNpkssxvnS6V/XzUZbpv+bQd3EBcUQ3SJcqAYKwA3GIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnX2F7YM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A059606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnX2F7YM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD61F0089F;
	Sat,  7 Nov 2026 10:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045873;
	bh=1+d+vWGDYXtRsD/uu/AyQg8l0o+mRkjflMLY2bZGhuI=;
	h=From:To:Cc:Subject:Date;
	b=PnX2F7YMycn9HLAk1nfFAbWYB9odFGaCvVxtwVbX6eiJMDX4xgKUUmTUYU5mfdQZs
	 t+Av9OFeF+0XI+7tLQXKE17GEXtsidJ398t5rwvoOwJFz4IpOL7WLaiCQ60ulrrrkT
	 UlK2yWShgaJ8VnmySgki9801oEpoy962HyIdxwZX+IxzDsd3UkEBv/eM4FUKwYVvb2
	 7kNieeXy7sLhNU4T3r+ZwILxpS9I7HDmYxBvbCEECQ4n55IBN93b7DtWB8qdkgbsMd
	 GIiI13fEXXmGZSQDDQ52AuYvuVdrOMQjGzj8P2aqlwigoGkFhGbt1DrE/wkUWFLFYO
	 PRLuuJCb801IQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:31 -0500
Message-ID: <20261107050431-failed-7.3-cec08aad3def@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x cec08aad3def79bdb7a795a05e7c9a11d577b4f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050431-failed-7.3-cec08aad3def@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




