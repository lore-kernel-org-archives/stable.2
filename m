Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330907;
	b=l2+nzUyC2L51jYSrXnvPRFaYQrurKxOy0H7SEn6LDMIoQXoaI5WazhkJXWWOnR0GS9Ej
	 WWnlCoMYAcLZWhsZIAjJE25i3CUf0Cf9Hi69q4TuinPfMabtGam/dDWOMDmw4W+Aou6VK
	 7QF9gYfG6dgsqOlJm/MWvbL1Plf5moNfpvmbb8INU9CSbkrgllHdXZ1xavER07uDXMl5v
	 Dpc9R6eUGaTl1mLwJzbizOLGhQdV0qGGjJAPUKb3L+w+f9MLqwv0Vs6oPPXrhU34gSO7x
	 Iuz4TKErvgo6PQ7ZGiicVmrPaIrbf+iluPGZC+NYt4FlbVMww38GjhG/G78gqV0jj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/KkxbaixgLioQdVVINLLonesDWHXl3xeXknKyEaLfIM=;
	b=I775aMi1tKdob5v0ymLwnJn+wQhEg28ieqEBY9W8J5pds5867ckd5diud2QJ2Xl6Z7IB
	 GzsWk1mKmifOYhGRvIjt/zyFwsJPMpIeJPGf+fEeFQ7eOyPCaXBgKAxfYU0bh7DI8a+y6
	 7Z5sX/5RbWqa7L2IpFBf7BRWIma/F2ngdSgigffcRxFeAzeYg4h7vdaZsvn8wIe+g3N/b
	 h0NoqekOrlXLmBx3xcq0gelB68kTteRfljM2YXRdxWlVrFXpb3ffBGWc3H431zn5xcC04
	 UqLuIymjvxV1n+BldmQep2LIFN0Fybc0+E5coDoOmpTiMJk3CTzQnf1rwyhC+joOwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoQ53nS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AF606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoQ53nS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF61F008A1;
	Tue, 10 Nov 2026 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330906;
	bh=/KkxbaixgLioQdVVINLLonesDWHXl3xeXknKyEaLfIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VoQ53nS3Khl38bkLviemO/IKI2VQadM/eHCSW1fY9O9DK1s7HrkcBiG5s8cTzbUHi
	 NZ2BagM2Oti+i52me70jCDvzx00ABStvx4lMzY14oNgXhL5vawfCZO95P77+rUGWq1
	 p4UOi7+GfeFngkfdOPOl2BbGn9XE4G4BUZ+jrs07kgFdWjfke/Bfr1M1lIBsAoVj7x
	 YiR9hzOkhJ+nvhFd0mepaGTX2gPGhFA3FqdFd5IgSRbZhZGSgAzFNBwZd/XhMB2a8l
	 tAS9rJOjL8RY4v1JcCHEUcSmbbkNqjUn4A/yeaq1Cy3Qwz0xfZRfgY/squmbhQqtjN
	 x9oZ9p8ZT5CTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] mm/damon/sysfs-schemes: drop centralized filter range arg validations
Date: Tue, 10 Nov 2026 12:15:02 -0500
Message-ID: <20261110171205.2600662-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171205.2600662-1-sashal@kernel.org>
References: <20261107050429-failed-7.3-1d2397b2c414@kernel.org>
 <20261110171205.2600662-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SJ Park <sj@kernel.org>

[ Upstream commit 1d2397b2c414e3f1fb536666ccc21d4065a3d9a6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a997539d0e816..ece53bd0d7fdd 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2831,27 +2831,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
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

