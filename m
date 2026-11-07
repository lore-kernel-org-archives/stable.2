Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046897;
	b=FA9ZOMKSc5xxDiz4iejbvYmPKVA4xc+TWPuoDlkQ3Y6ugrVnxUNENU4+FxiWqV3FmJbH
	 k8Xm6nRNStw4v5pJRx6l1rKOPQckDrRNOCjLHDjPwfAq43JlcX4A8tEn8hmTtxO8cbSTp
	 feLKcAGlQGNFJP0jQfykX9YwISPni2RKQe4uahj8JJSfP4CqqlcEu0rEOgsVoGBsnidHj
	 uXE/WRYrN737fXWnA9YV6PS/DX7fRcXE+kHuoBD5biy09Zq7UuSgFToAZFIN7NcGtZoxj
	 K3umG2PQ8/Ow3QVg8Fvp3wSgTUEJskuWZQughVRL/Hlm3hXpozFaKgRb9dR9lM3nwNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046897;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BruUbg2n0w8KsKG2RyKrlTR9SyDlngu07iISE/nxq+s=;
	b=OYYhrh5oNZ7M5+7nid1fPEPMegnRbWA53+SgCe86Ccfx4wWlE9xGfmmNAZO4RstgZOzb
	 S6/pRwV7sJ/0oTGnB18wTl4s9DPdF87uRrjSrwF8n+rs4HM7FzbWAmCLSE5citn9toWn7
	 VkRGQqX1YRGGdfJIkBN4IOqI9eIsSlACHGvpkCCvJaSi2UoIJ40YuKhojWx+aemP8PaKs
	 sRn5UnvaAVJhytH3tcr0EX338BKfLHZvegWh3ucze6ne72OuvuKgJKoBVOR0Td0to8zKz
	 HCQ6rsL9PkWVy2VzKugwkFQWvtSivrwALqZlWA+kvRdXt39ZQxfcab5tkrGUW06M/eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mconnyrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDC606A33B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mconnyrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7791E1F008A1;
	Sat,  7 Nov 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046897;
	bh=BruUbg2n0w8KsKG2RyKrlTR9SyDlngu07iISE/nxq+s=;
	h=From:To:Cc:Subject:Date;
	b=MconnyrpaOwSblnVKC6Aot2pQCnGQuzGJK5PaRZMvcfKb7Xpp9LVlw2fJo/ilnCny
	 C8+WicCY2l+tWF4IT/V2xAGkwyJ8zlzny95Z6MZklROs3QuNvAtrtmaGvWrB9P8Pbo
	 aYtJZIvBa35EFDiHSZzqzjQqX5UCdicT6bYANSdqjbohDTXYBGS8CCpZagSET9l9Wv
	 m//l98LElncwCL6ErbMJq4gaC1AdTl2gE99gjNdq5TGTr+ajMFk1TjFmXhzSvf7ZWi
	 URQZOrvPdd/zdTUO1adxK2FhnAwwc1gs8HvPTwIyNQWjwlj5AtFmPSjTjFV4iJpavK
	 wM5C3BLhknaAQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:35 -0500
Message-ID: <20261107052135-failed-6.12-1d2397b2c414@kernel.org>
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
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052135-failed-6.12-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




