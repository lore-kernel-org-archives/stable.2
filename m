Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669771;
	b=e9Q2a/tpnLsxrLJgOdsJOYxHH7a9/wTQ/SJwS0EJZXGRx3NIibk4jY55P2UuGwgRkjO7
	 uPpQ41VYIP3VM+a1TZabHWMDsgUliNM/i+OnQSC+UGpo/TQyzZMOg/inFMjusPxR9/rTc
	 CjMhrj/Tv24Jm5F6R0KZ1D7gHePEBxg/zv/8HxrA8K0BIrfMQhQxVQQzeQsRag8Onn+Is
	 M/ieNaNFPBxmfx1Ids9Lh13VKutyOZ2JcH0H5kEAOsoNhJWWrxt0uXERnn3G/sSfU6khm
	 E2R5rpvzG5zD18lHocIOS+AgGUoXoqTQknMfmFmS3n7xJLuc3v9B5UjgQ6TJP7fkbDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=osE3/eOhEkL+VjTp2OEjMYKItmA7z0rMcUS/IUtcuf4=;
	b=CeZPjOvFazRhO2xZG7g+YQI6UFUMZNSBkNyM1JBZ5w5AJR7D0j9Y9p5YUpOQ8U0BlqT+
	 luRe80oCdquV7boEbRzyvUyE21Sv7PTqfRFEY7/4KGKvW3YDoc7FJelCyxjjgL1fgDbai
	 fp8C573Gusiw46ikRDG5blv+tJtRnlQsxXnbTePq9gtvxZUw8tcVbw6bbiD42WzpFJ/W2
	 t+3mNRlz4OGf2I0M5EjAu2mdyRZAOPVh/lqRz0ctWKqVzcEE/WNKqNrXIsQpxLxAR5obW
	 T074T05GS3vf1TZoZoF3FuvpJXT74CMmGCwPmld2XLTjlhmUb3zCEGTRv4TMGE3agww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Go48e9/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589D606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go48e9/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772B1F000EF;
	Thu, 26 Nov 2026 05:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669770;
	bh=osE3/eOhEkL+VjTp2OEjMYKItmA7z0rMcUS/IUtcuf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Go48e9/GBh6vq5ThTP0OCK+3lSV38+RYck6FwBIlV/Sv5CE9hVgsnKZbZ+CzveOWm
	 pt8Y0/qXh9qhXg+6jUTUlssJxb1+1RlQRV39GfTkIBEmLDiuOBC0ZyANWJwwkD8iBY
	 NxDB1zEaLZKakXjJtV33qTkrY1JCTArEP/Gm35i4bjAZYz/YNwLK0neHKcwG077AP1
	 DToMJ6CGmtIIoJpaSBCj/eicSDRCxxsOtWGC0It721mDLKajO+VmvzIDPBSkjlkUjq
	 4IFA7PO5YifEySlYaNXIeWXfnIC5q/irP+u8bn06cbQ7ZshmI1Yvm1c6zMZGrEoN9l
	 AxZdL134SP7RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] dm cache: parse invalidate_cblocks with kstrtouint()
Date: Thu, 26 Nov 2026 00:09:26 -0500
Message-ID: <20261126050921.2111286-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126050921.2111286-1-sashal@kernel.org>
References: <2026112510-mandatory-improve-2cc3@gregkh>
 <20261126050921.2111286-1-sashal@kernel.org>
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
index 69ab5f9a33483..d304e62fe2cc2 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -14,6 +14,7 @@
 #include <linux/dm-kcopyd.h>
 #include <linux/jiffies.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
@@ -3306,42 +3307,46 @@ struct cblock_range {
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
 
@@ -3372,11 +3377,6 @@ static int validate_cblock_range(struct cache *cache, struct cblock_range *range
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
@@ -3400,7 +3400,7 @@ static int request_invalidation(struct cache *cache, struct cblock_range *range)
 }
 
 static int process_invalidate_cblocks_message(struct cache *cache, unsigned int count,
-					      const char **cblock_ranges)
+					      char **cblock_ranges)
 {
 	int r = 0;
 	unsigned int i;
@@ -3455,7 +3455,7 @@ static int cache_message(struct dm_target *ti, unsigned int argc, char **argv,
 	}
 
 	if (!strcasecmp(argv[0], "invalidate_cblocks"))
-		return process_invalidate_cblocks_message(cache, argc - 1, (const char **) argv + 1);
+		return process_invalidate_cblocks_message(cache, argc - 1, argv + 1);
 
 	if (argc != 2)
 		return -EINVAL;
-- 
2.53.0

