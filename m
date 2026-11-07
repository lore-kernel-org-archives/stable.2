Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048437;
	b=zlaHVKj0G000CHZUy+mwRHR8bUpiJrexthEYimJPVpfVq2YLJOMwu36zX5R1Jzrgb+mB
	 U+iIlnp3Ra/7ihRA/mPgc23Mypaz+78EYbG8RoIOM4o5EaRbWLdQQcW5ClEeGVE7Vocxl
	 rY8oqzh4OgxJf/bLefPuvWUMMepuY9FzQiOYRJYb26ufkTRQTWWqxzEHmvlLmsfPCOXeC
	 lVO76m8u2pYW4rhrEQQlkShhII5lH+pw5vjctdqCLtONz3D/QeKxjMmJYepFWyBiLApVI
	 mHK70ShhauImfLbiSThcrKzBRNqsI+BmLlhTciftExLhKD/yElt8u55nb2nHkIQS8dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7KgGsoiW1AIbZLA9Eej15svkj16Mb9IPeD/1CkPBonM=;
	b=3FE7kEQy4/zH3CKxJDm/cgKnxlPCIej8P48kKCnR5Xnh9E9ylJd5d9aiSpxYevPKWqGI
	 L9ZrjX+9nx4e1uGMUQeepfzpPw5L3ICX9xYjn3p5E5GKUH3ukznyD1A7n2e/BEhkc3vlu
	 uGYVthsEMw4DAR5b9/NxGxcZBBb2xeZrwPrp4Cs/HrsjZNFD/NCCLC0TV0M6UmUZwl30G
	 BiW3pPHhtfVBDMEQ1gR4s81Ow3IIsDlznPVKhvXVF3nzAQukA/P+JQcN1SviWqbYwQC3p
	 eM3ncw5kSXnFqi00KFU2Eu8nxHXWiAODv0opTL/gwSu0KEqD5ZRgP1+ymsGNIyqGl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYdQaGtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYdQaGtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473251F0089F;
	Sat,  7 Nov 2026 10:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048436;
	bh=7KgGsoiW1AIbZLA9Eej15svkj16Mb9IPeD/1CkPBonM=;
	h=From:To:Cc:Subject:Date;
	b=gYdQaGtXH0+n6a4j86G5CDwjg/MjF3UUs6AwI8uWWzgHfy4QEnGwqRUNRoBytUPjl
	 /DMWxvuI0EpDgx/iRIEbmovBYjEK5C/9WyufoBqThG64dCtmVmQ8kDiyVbRgbm7xxV
	 9DT6VOdstYU9zRTA4XqYoLK5kMzUpgQOXiUM2ls6lgIm5hr2Myp0xmbXsRRFfKCNj8
	 3fTvS68NuQUj0ywC8kCeGWX3VFlchR4XlYrjNXfw/Uia+/7DqJykuYBQAnSAOXx/ew
	 EmNvuB4xYH4repK5rZoEbgBwsP5NAr5V+Yr9Br32P/DaBRYc2qvw44XbJlVv6IGAyG
	 M7xQec0V3Pdkw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:15 -0500
Message-ID: <20261107054714-failed-6.1-1d2397b2c414@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054714-failed-6.1-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




