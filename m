Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185855;
	b=TPLYcHj5JjN3KLiYpP+UmDdSxVNBpM9k8n+yOqETI69fLj/Xq8/lViT5GFS8yh8K5Aq+
	 bO2ylAYZcGRbj4MUP4eQ1dT/U0zBmsjC60Aewt3HslMyj9POQkXnWcpmXBrQsCsFwg7jS
	 gf76CjR+CTsYyQurwGp07cImUgS9qqkEzKZU/w19XA0rNWpvso3hzSt3WWwy6qndYJfEJ
	 VJdyE9XS99dLDYQNEXOBFwDdlq8Npv+jN9mAclERMx0HaYfFoM70ZJ742pe+gu2NZatj/
	 lYpJT8CqI+ETRKg0zx77z14isK1EkdSeSehrtIpBhq3Kxe7kvjbX8wSNvVpkxldAFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TVqtYiqSwPZNpSdKWc9awbF4sd8jxXYHB5l31VZZLIg=;
	b=tXh0i1eyvK7+31MHAkKZmslPaqVi1mkHGmcQRCz+8ynNiml5VT6kVSEhi6NWclHtDDOv
	 n7+sBPa0DUueKa3X0yhwjg+RRxQkWsNyLzZs/ZKyA6nwY7aZZDGUUaAIpIiauGOthu9YC
	 LhxcVikPhTFZd7TlEz25HKvu1y1HU+Q+UZYB264TNNIsiJq+z1u1lRjHMP8aORSAXn+Cp
	 efxNnBH8EYT8+6wIdgxuESUzRmOElc4o+vn+Vf39mUZi91X+rK5Fs2xm8sHEKVP+Iw9fw
	 vLp1WMaTOGp8vaHc5cTlbozI4mBEDS8+9Kq8D97+8iepmKYmMujjADolc7OqOCKP+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eW/Q5yjJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BA606A320;
	Mon,  9 Nov 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eW/Q5yjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDFC1F008A2;
	Mon,  9 Nov 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185854;
	bh=TVqtYiqSwPZNpSdKWc9awbF4sd8jxXYHB5l31VZZLIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eW/Q5yjJKJgDSV6Zw8qB76K6xE80QTQWWJNQqAHQjQTkWzigkxu77rs7rTjMhhEf5
	 mI2x9UTxqfbj8jQcQpj0oqunGWw2Sr891V7gIY6c0xkACyuH+FQKWKJNnudxtd9EFO
	 30Z5cy1tBF5MYqdhowTjOG3bNK3UZxaVB1Gk9RTJELqJD+yG2bH5alq1XwxdVmSXRQ
	 Dhf02GPSbChl6fKSm2CQBiqR70Fks2S2ZBJKjAFS7HGNaA6Mulasjgof3CIA9PWCdJ
	 65HJtELu0KucqlucIF14mcMBT20bSGFg9vsxLtBIJQFDcG/R+nftC9UOYwsLv7Ea86
	 PoGKos+t3FsKg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 7.3.y] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 16:57:24 -0800
Message-ID: <20261109005724.87550-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107050434-failed-7.3-af19aff38d6f@kernel.org>
References: <20261107050434-failed-7.3-af19aff38d6f@kernel.org>
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

DAMON sysfs interface reads the user-provided size range arguments for
hugepage_size type DAMOS filter twice.  Once for validation, and once
again for assignments to the variable that will be passed to the core
layer.  If the user updates the arguments in parallel, an invalid size
range could be passed to the core layer.  Avoid it by doing the
assignments first, and then validating the assigned variables before
passing those to the core layer.

User impact of the bug should be trivial.  From the core layer's
perspective, the invalid size range is not really invalid.  It just works
as having a weird size range.  No critical issues such as a crash or a
leak could happen.  And sane users ain't do such parallel arguments update
anyway.  If they do, such racy behavior is arguably somewhat expected and
deserved.  That said, there is no reason to keep such races.

Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos_filter->sz_range")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
(cherry picked from commit af19aff38d6faea35b10f26cca32d0e54f8aea5e)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 32f495a96b17a..c3a5b12648498 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2831,12 +2831,11 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
-			if (sysfs_filter->sz_range.min >
-					sysfs_filter->sz_range.max) {
+			filter->sz_range = sysfs_filter->sz_range;
+			if (filter->sz_range.min > filter->sz_range.max) {
 				damos_destroy_filter(filter);
 				return -EINVAL;
 			}
-			filter->sz_range = sysfs_filter->sz_range;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3

