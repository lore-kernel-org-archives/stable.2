Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271704;
	b=qr9wHyRP9K2IliXP7Ck69OqTSiZuZJjqxNWJxE0ylco0ACu4TFVI+0BrR09NY2Oqu4t6
	 pD7BbH3NezqV12RoQP3jYOginfNLBVxQnXHigEBY9mfoHwA625gqXZTMWfciphXwxT4Cy
	 iJgpzxIBQVRV0Yj0BzbXshk0nWKlYnUOa0JiClEdPBYBkqfdBaPffz6SiLbPidgKm/gzA
	 AL7Tx2ZTTmYRjyKpRiIaK1VkXcvI578qrAukuooPj01lU6FsTH0LdKcZu6csvf06sandH
	 4SLapj1I4kw6vY0QQkTAO+Sf0apM4lEs8jmCXOU43jNnqVZpdOnXHcPwY+mXV+Ib7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Xo6pRfKtJUGUHdPK++9LnJKDE8puj/5ez9TES0+7xw=;
	b=kduJTO4YCIRgtSYYCa4fNL4ci/IDsLWi/FTJzgTmX+g9CuBc0bzJXpIOD1HlV4nhCq44
	 x2CecUZM8un87fmrdEID6UlGniDZXWD59zhygwMYin3jdWpfEYqHtENqtsgUclgJ1HM9F
	 S2I2o/wjYmuuF5RNfiv6z2nrGQr4lXc8yxM0K7cUFMNdwf69CF5XLfuMOG+tMj1XRhsX4
	 x/DzX87WWPTN3LWY5SkBMbI1Hz46subFsUge/4ALRe5oY19ex2KpLMFURswEEsqSLQ0mH
	 BxWA7gPqJfFU2sd4v7rV4WZQuUlHRW6Vl1nwppRyiHV2sQUpy5hgrRTp4nBsAVJVRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ecr7oeSg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13E606A325;
	Tue, 10 Nov 2026 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ecr7oeSg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53451F008A1;
	Tue, 10 Nov 2026 00:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271704;
	bh=3Xo6pRfKtJUGUHdPK++9LnJKDE8puj/5ez9TES0+7xw=;
	h=From:To:Cc:Subject:Date;
	b=Ecr7oeSgvsJKzDeMDBpc7QEOPzDe6UTbRKUtx0+XnFGQ4sMMlyG5Nopq9bwUm46VP
	 cLnLW9iB5UycYapqZA0RFitW0YvfVm4VzBfKhoU/MWtwFHVTRP66MBiD5Bh8cl6T+R
	 vugK3lQjpmOcfTxaiqonolaKG219lLKHAfC/GeZSsOHEl7xG1j23C4G4KP9TwI1dF2
	 b7pX8nfG4A3dFRdyWW0ftaayxauJ94zTFXlHxndzj6mYjMb8BlNyKL5yOcB3MB1B2P
	 rFIzvAGNm0UVDoUiQ5UX6lKvxtRECMn6HWJk6eXH+NUUFjuuFRjGuFwuHZRo4HJOWa
	 vLH5y4vEcl+Pw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Guangke <gkwang@linx-info.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable v3] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Mon,  9 Nov 2026 16:48:14 -0800
Message-ID: <20261110004816.100066-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

From: Wang Guangke <gkwang@linx-info.com>

estimated_memory_bandwidth is calculated by access_bytes *
USEC_PER_MSEC * MSEC_PER_SEC (= USEC_PER_SEC) / aggr_interval,
and users read it via
/sys/module/damon_stat/parameters/estimated_memory_bandwidth.

On 32-bit systems, access_bytes * USEC_PER_SEC overflows unsigned
long once access_bytes exceeds about 4294 (U32_MAX / USEC_PER_SEC),
so users get a wrong value.

Fix it by doing the calculation in 64-bit and splitting the division
into quotient and remainder.

The issue was reproduced on a 32-bit system (qemu-system-i386): the
parameter estimated_memory_bandwidth reported 362 instead of the
expected 1926150; with the fix, the value matches the expectation.

Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wang Guangke <gkwang@linx-info.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20261103034034.7978-1-gkwang@linx-info.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
Changes from v1:
- v1: https://lore.kernel.org/all/20261101180001.167198-1-gkwang@linx-info.com
- Clarify the issue and its impact on users.
- Add Cc: stable@.
- Rename variable bytes_per_interval to bytes_per_us.
- Use USEC_PER_SEC instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.

 mm/damon/stat.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10d..e44f5bf3645cc 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -32,8 +32,8 @@ static bool enabled __read_mostly = IS_ENABLED(
 module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
-static unsigned long estimated_memory_bandwidth __read_mostly;
-module_param(estimated_memory_bandwidth, ulong, 0400);
+static u64 estimated_memory_bandwidth __read_mostly;
+module_param(estimated_memory_bandwidth, ullong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
@@ -55,15 +55,18 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long access_bytes = 0;
+	u64 access_bytes = 0;
+	u64 remainder, bytes_per_us;
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t)
-			access_bytes += (r->ar.end - r->ar.start) *
+			access_bytes += (u64)(r->ar.end - r->ar.start) *
 				r->nr_accesses;
 	}
-	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
-		MSEC_PER_SEC / c->attrs.aggr_interval;
+	bytes_per_us = div64_u64_rem(access_bytes,
+			c->attrs.aggr_interval, &remainder);
+	estimated_memory_bandwidth = bytes_per_us * USEC_PER_SEC +
+		div64_u64(remainder * USEC_PER_SEC, c->attrs.aggr_interval);
 }
 
 static int damon_stat_idletime(const struct damon_region *r)

base-commit: 09f140d2cb078edfcd08a40a23ead0bdceea30a4
-- 
2.47.3
