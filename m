Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669263;
	b=CCfObUaCFnCXi+c34VqBeFedrPxkGywVF2az1jpFsmr5rhxIfunvQVDQM+y58Wcnjjub
	 DppBMXt4wHNQZVfYZ0pYBOhP6M32UCGNM613x48uGZXS/xzvNVnJJRwIAB6C8oECRxGrT
	 U17/Z+pluqnk55WCYqfUedmLVY4Sc/pBzyrj6mmZt3DZQsKTtXbM7X6npzW4TBS7K4PEe
	 trujbQGgNxG1o0ErkFex94Nc0A+1Phstw2dcBmttlIWhrhCgMJNxGP/UBkZ3UiuqJfcmu
	 CjjZWcBd3VGXr53TydVmR3wC1STouLrbQXQdbTDDrA0XqttbBsPO5V7nlmHA7XvtQZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NtJ1wSUAOoFiCMe299Gl/OC9+hyJ5qlVsrrInyEAvn4=;
	b=Cp+XbP5y/Aw/QbmR6x92HrMXflp5ydCFxcRnTxDMpfL63jWMphm2oY9zkcM3mXsoejal
	 1ov6hbDsXgN8sT3dIWTy2rFGnyK3KCn3NSE1ifvK9TQ2z1WQUfb+nhII7Hrn6RBjewjpe
	 2b6Y+W12DGksuquGFpe4vmoKFLo99G2jC6hbV5bv/5CXmCMbk+p0pTEJCS75CNO6i2u0t
	 rN9mDaS1qQV4/A140gViP453muc649maxcep8wHSCRU2qH0cyGPGFpgg6XURiBQCBQrgv
	 aDgmRiUpJH0eCBaTXEh6QxEkbi+JcOkybaqZxPWelRxjcwIYTcwjrZn5XeclwbIs/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mw60T2fn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963A606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mw60T2fn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287F61F000C0;
	Thu, 26 Nov 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669262;
	bh=NtJ1wSUAOoFiCMe299Gl/OC9+hyJ5qlVsrrInyEAvn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mw60T2fnQ8sF53ulkVP3/Pq4zG+k21W+KL5C27RIicNnuBGrkTGBE5rupQIdx+VjY
	 jLNLBNQiwnNcL9Z8nHtier4ZKb+E24/pc49Kipx8ArgHaBlK5KbSbELT/v21EGitXC
	 4iUm80LDHMAXsh3UXifeHO1h/woSq3FRTGcE7lCBbzoFXY04imFiZKwkHtITWyPRWt
	 5VTT7RO4Z5q1BX5SOelLY91wZJYqKBZHRbpRQkgLhZ2qT+QVEG9IE48CyYbKlEjQ2n
	 9B4wGKk+8w2oGp5jvBURfBW+s8Jec0oe1gkvZhmZPYApufKF6ROhnoBKXpmEr0oCsR
	 6/hZ+qORRMNJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] dm cache: parse invalidate_cblocks with kstrtouint()
Date: Thu, 26 Nov 2026 00:00:59 -0500
Message-ID: <20261126050045.2080405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-mama-skintight-d6f5@gregkh>
References: <2026112510-mama-skintight-d6f5@gregkh>
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

From: Samuel Moelius <sam.moelius@trailofbits.com>

[ Upstream commit 00211ede62facec2915a7e6cfc17f8ce987a0078 ]

invalidate_cblocks parses cache block numbers with sscanf() and then
stores them in the narrower dm_cblock_t type.  Values larger than the
cblock representation are truncated before invalidation, so a request
for one cache block can invalidate a different block.

Checking the parsed value after sscanf() is not sufficient because
sscanf() does not reliably reject values beyond U64_MAX before storing
into the destination.  Such inputs can still be converted to a wrapped
u64 value and then pass a later range check.

Split ranges in place and parse each single value or range endpoint
directly with kstrtouint() instead.  This rejects malformed values and
values that do not fit in dm_cblock_t before they can be converted to
cblock values.  The existing range validation continues to reject empty
or out-of-cache ranges, including the single-value U32_MAX case whose
exclusive end wraps to zero.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Ming-Hung Tsai <mtsai@redhat.com>
Stable-dep-of: df8daa4d916c ("dm cache: validate the discard block size before narrowing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 56 ++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index a9e54bdd378bd..6dc177c51f8f0 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -16,6 +16,7 @@
 #include <linux/dm-kcopyd.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -3304,42 +3305,46 @@ struct cblock_range {
 	dm_cblock_t end;
 };
 
+static inline dm_cblock_t cblock_succ(dm_cblock_t b)
+{
+	return to_cblock(from_cblock(b) + 1);
+}
+
 /*
  * A cache block range can take two forms:
  *
  * i) A single cblock, eg. '3456'
  * ii) A begin and end cblock with a dash between, eg. 123-234
  */
-static int parse_cblock_range(struct cache *cache, const char *str,
+static int parse_cblock_range(struct cache *cache, char *str,
 			      struct cblock_range *result)
 {
-	char dummy;
-	uint64_t b, e;
+	char *blocknr = strsep(&str, "-");
+	unsigned int b, e;
 	int r;
 
-	/*
-	 * Try and parse form (ii) first.
-	 */
-	r = sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
+	r = kstrtouint(blocknr, 10, &b);
+	if (r)
+		goto bad;
 
-	if (r == 2) {
-		result->begin = to_cblock(b);
-		result->end = to_cblock(e);
-		return 0;
-	}
+	result->begin = to_cblock(b);
 
-	/*
-	 * That didn't work, try form (i).
-	 */
-	r = sscanf(str, "%llu%c", &b, &dummy);
+	if (str) {
+		blocknr = str;
 
-	if (r == 1) {
-		result->begin = to_cblock(b);
-		result->end = to_cblock(from_cblock(result->begin) + 1u);
-		return 0;
+		r = kstrtouint(blocknr, 10, &e);
+		if (r)
+			goto bad;
+
+		result->end = to_cblock(e);
+	} else {
+		result->end = cblock_succ(result->begin);
 	}
 
-	DMERR("%s: invalid cblock range '%s'", cache_device_name(cache), str);
+	return 0;
+
+bad:
+	DMERR("%s: invalid cblock range '%s'", cache_device_name(cache), blocknr);
 	return -EINVAL;
 }
 
@@ -3370,11 +3375,6 @@ static int validate_cblock_range(struct cache *cache, struct cblock_range *range
 	return 0;
 }
 
-static inline dm_cblock_t cblock_succ(dm_cblock_t b)
-{
-	return to_cblock(from_cblock(b) + 1);
-}
-
 static int request_invalidation(struct cache *cache, struct cblock_range *range)
 {
 	int r = 0;
@@ -3398,7 +3398,7 @@ static int request_invalidation(struct cache *cache, struct cblock_range *range)
 }
 
 static int process_invalidate_cblocks_message(struct cache *cache, unsigned int count,
-					      const char **cblock_ranges)
+					      char **cblock_ranges)
 {
 	int r = 0;
 	unsigned int i;
@@ -3453,7 +3453,7 @@ static int cache_message(struct dm_target *ti, unsigned int argc, char **argv,
 	}
 
 	if (!strcasecmp(argv[0], "invalidate_cblocks"))
-		return process_invalidate_cblocks_message(cache, argc - 1, (const char **) argv + 1);
+		return process_invalidate_cblocks_message(cache, argc - 1, argv + 1);
 
 	if (argc != 2)
 		return -EINVAL;
-- 
2.53.0

