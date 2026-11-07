Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047642;
	b=F3t+ZRebDAZIBfA02Q9YV/VL2UGBV0XjTfjCjgNcxRjdsNtIQFykeK9a27ps33zIT4zS
	 JqXlG9ik+SSk5ZyEQsw1C5j5j+JqGZ095uWZu4/e1w/3ewknalR830b6Endlp/AVAswR0
	 63zrHjUt/DL8sUy4YJ0u5I6rxygXA+SX9MF2x990J4Zbt+1u8QTi7nQtK7H2g5p+wuL2g
	 DoEjrAYoITfERHDLd7DgpU8xZqJrb/R3V01+zHHRlOsd22v6ItGjQ0q3xqz5cR+HC+dj/
	 TKmwEdztHUj2J/OVNpYn9iYg9CrFSMzLccDLhB30nNJBTgS0taI4SGzxpWNZWzIe3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZEAZKmlp/XKFmk1+FRN9y6Fbi9Fi0/5a+CFce+dyo0k=;
	b=jI/Y+64Ql3rW8oAMavH5QgUKbn+FfuCHEBqCLjHWi3QoNBK0SqQ5EgLt5qoKzgorLRXB
	 LIBlDwhNxdnS1fFG9BJ+DuLxFXwlohaVzVnVc66obZHjQL3ART2HePKMwXblpGyQW7uaK
	 PbQQl5crHnMe2I+91fRIoxLDQrHUKBG2J4DhYJ8cBpiyzd0pFvi3FQIuOYtx4YsHcz03z
	 wrA+eQr7ZpwccoPbCTSjp4AveMsMIJwb83mnPD73LzLHgom2sF+HBHVDzpPrhTaAZvjor
	 YnYd5IHPCifpcMZ2rirqIjwjnTLuNfCqmFMq5IgZDsb4efURrZAUq+rD1ENMi4Xy9hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQJFglj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C383606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQJFglj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7931F008A1;
	Sat,  7 Nov 2026 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047642;
	bh=ZEAZKmlp/XKFmk1+FRN9y6Fbi9Fi0/5a+CFce+dyo0k=;
	h=From:To:Cc:Subject:Date;
	b=LQJFglj09mojfmMToXotF/7mmXF4/NZJtAh31dSl2XwK2wQmpDQmVoSv3TgE3i9CC
	 FrBq6s8XKTd//pvoNUu4Havdd88ldiLMljY/uDMdJDVY7HAoV7gJp0e3poDLokDrPy
	 CIq+VXAt2PqyCx1b85JvkRsI1MKQZu8Mb9u1myh1d+E3iFLn9PJi31ZTf6124oySdk
	 codxOOMiwf9SeYTxtL/GxACmfB+xkkBCtcaq4Q58h2OJen6WEd5Lch0fK3oydvn0KZ
	 EpbxLAJCvOeSrJZCF4SGpUbQBq1DjiYNz2NJAiO73C5I+2WSl6uQVSicY18B7ue1sp
	 sY8X4Sgux4J0g==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:00 -0500
Message-ID: <20261107053400-failed-6.6-1d2397b2c414@kernel.org>
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
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053400-failed-6.6-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:22 -0700
Subject: [PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg
 validations

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Link: https://lore.kernel.org/20260914142327.92510-6-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.53.0




