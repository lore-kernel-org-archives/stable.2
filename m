Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668976;
	b=mJzcsd2GnRWZnubo7K/sdaiH0XFLVof+1jsMI3J16yloy+QMIxOAapeXm+L3OoXWJOuH
	 h4CMAMjnlJwPGbFBPwrtrOkBnlAItubtrDfGlev16KkfcvZbzbaw73NwazUUCYHddQbVo
	 JRmVu2VPKaKW6iVWHL+JNDuXptARIp0ANggc/EhSqCBJUHfsYmg3u2izFm8R7WZeBb/Ht
	 o454D+Soh2sUnXNcGEN6UkPDdhdq/ELsYdtaOB4xy3LfKOi6YySdXMi+w3rTHsv7llyP2
	 y8+2IpD4TtKeMFaSL+xbV+FJn+f0eumYL+j1uWTQ2Tt2mbMCFiUuNL0HNJsSVn9WffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6t/jSigq0qYRzdixr1DTyc5F1mbF+Lsd8sqPFTfTbDw=;
	b=0/FoOIqAVY7RBwv/NyLmZJFQHFi8uMqq+haPOG8pNUpBnMQiCJKnylFukGxY1Avk+JN3
	 nkJqIkpTucK9kMtXe4EtqvVYeRFfaxQtkw9xYgdc4DZMZKCrTszmFeZ1bwewiKJW/fgup
	 hKktKqH9HuiTggHS+ra3eM/6VCYlc5rNPzbpKavVseHvAAJfBTEm0grru/jUPG4e9dpsb
	 g1Ok42hY4S51VN2Hgw/IA+Y8B/qoyThpCzBRVIRGS8xF1TxO+iYCiC97n1CqR/sNgRJWG
	 +GUW9eiGi+Wd7iMI/gaZwKg3ZeU2Aidew3PjP2B/tQDC2ZFV3uqTqp7cK+uCN1e6gMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqHoCakn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC23606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqHoCakn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE341F000C6;
	Thu, 26 Nov 2026 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668975;
	bh=6t/jSigq0qYRzdixr1DTyc5F1mbF+Lsd8sqPFTfTbDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqHoCakn99ZmVcMGAn8gDyKoDcyftYOU1Icuzn4e2NFKqBXWF0RgebVRx6pCI65GZ
	 Vv/I4ij2lvhA9p9H/gdxa0K7gE1/5w0bltfCbPR2yYaMfzOJBnAl4+zIjH9g3PHRPf
	 gQTpIPhvLb0k4L0XP1HpjtXLhrTJptJZJ+Caf7TuqmagHmQnKASaypcJZdF+/CKINV
	 IKV2V08fwnoEJGZLlpOYTD6eVODi+gvH7nXQhHfSDYgT3dZCpdsMVK2lky+/1vW14R
	 hVf9srqT/WYHqJ6ZqAAkkR+lc0kED80UuLKDX4lPYzbpUMNFKLgNu6wSRGfs2tZDpF
	 h3DN8lKLC2tKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Ming-Hung Tsai <mtsai@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] dm cache: parse invalidate_cblocks with kstrtouint()
Date: Wed, 25 Nov 2026 23:56:11 -0500
Message-ID: <20261126045549.2060110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-relish-capitol-9ef2@gregkh>
References: <2026112509-relish-capitol-9ef2@gregkh>
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
index 663b1c0fa41d1..207dcefbfb636 100644
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
@@ -3305,42 +3306,46 @@ struct cblock_range {
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
 
@@ -3371,11 +3376,6 @@ static int validate_cblock_range(struct cache *cache, struct cblock_range *range
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
@@ -3399,7 +3399,7 @@ static int request_invalidation(struct cache *cache, struct cblock_range *range)
 }
 
 static int process_invalidate_cblocks_message(struct cache *cache, unsigned int count,
-					      const char **cblock_ranges)
+					      char **cblock_ranges)
 {
 	int r = 0;
 	unsigned int i;
@@ -3454,7 +3454,7 @@ static int cache_message(struct dm_target *ti, unsigned int argc, char **argv,
 	}
 
 	if (!strcasecmp(argv[0], "invalidate_cblocks"))
-		return process_invalidate_cblocks_message(cache, argc - 1, (const char **) argv + 1);
+		return process_invalidate_cblocks_message(cache, argc - 1, argv + 1);
 
 	if (argc != 2)
 		return -EINVAL;
-- 
2.53.0

