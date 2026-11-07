Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045871;
	b=1N0subRYWaPx0vIwthZ2GckKnInLRbFdMEvr96Ujw3gVHIol/yryW9eiuzJIkF4l6IQB
	 DwEnLqIcdxaiDujBrHhGBYmNnJNC81jRC//RdUDMG9psFmC6iG95vqHOSW9d8Z5HB2rTx
	 eoijnPV6KEKUZhaJQTUqfcT/DpXd/XtMFRUQGfOrM6GiHHSzg/lBV+DUJyF8IZkUcgYXG
	 7x6at14b4k1A56dshTpl5kVY41MLmClYcr/PuGecNAdkyiURXDMyaCu/W6QUDAW3PmsTh
	 RkM5qaU8g/PLohTSL/HImj4E17zQgRVCqC0ugjEY1oryEUTx0q13YciWQYJEcC5r8xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yWb/pQ5Oee6wfTWPA7kvhoGE7hdaM6i2AfziwIZmclA=;
	b=c7JzCckdpXWsqOym3+ynvSMgjg7D5KD/HC1cpR5RPJnnvwZpoHjyq/hUGqMFz20HyZew
	 24vJlDwTQSHkaIq3dOTVDVP6b3mbGyYk8vsPW60xgpFv7RhNK8SlyD07I701MZKccEWgq
	 jchE3zeVeRlolbjUG+/LErCbiMO3CkQp94/ij0KanSIs571x2HtTNsjbFICBgapXep90E
	 aE9pZObsFJJEQvB78YMq8dFgLdmFxQCTzKg/3/H5AaBA+j3c1165elq7YlEMakhf1sw7c
	 3AVEPiS7qgIc2lB+m8So89wIiClrtTZp0DeGCHL+Xi0GnwF5xzeNBwsWLZpA/5HjiFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XS9zIFI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B20606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS9zIFI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECE51F0089F;
	Sat,  7 Nov 2026 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045871;
	bh=yWb/pQ5Oee6wfTWPA7kvhoGE7hdaM6i2AfziwIZmclA=;
	h=From:To:Cc:Subject:Date;
	b=XS9zIFI/UaJhQ4FPMtEFbGBAVjUmR5/lzhckaOjgCcz4gg7krtUQ2aWPwJznBcdze
	 m1IgDJYVrOEYiSE8Qv+5AM50ktXsco6tBgb4GohQoCsZjVrZ9P/WetxhYsQmf16EH3
	 eanpUJ0JqXRnGYWvVWNoGrVjc2QDoqVQlj6cv1j63gPNCFsG0+vltFbPlCqQrjUgGP
	 yPaVLz5gmMmGrruKorfYLhtK65rlhzQGAOVzH1R8jhH56z2A5TAY6b0hEggM1s3pKx
	 FvxYu/PWsFfMOfJ8yqzZsqG1zgL4z1W+nDZ8ysTvjwabGvUBi2kUrz00KfthCkpzlK
	 AxWBpjnWdI73A==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-schemes: drop centralized filter range arg validations" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:29 -0500
Message-ID: <20261107050429-failed-7.3-1d2397b2c414@kernel.org>
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
git cherry-pick -x 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050429-failed-7.3-1d2397b2c414@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




