Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F225293ED
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071127; cv=none; b=Z7G2hF6WZ1e/5gKwm9gU6Mtc6I4xS0c8/uclBdPMtM5+rnfp6Jn7VoI3l3zCyQNypqBPkbiq6fAI7djMZe+PulHNQzxtheQREV4NjvP8VQg9YBvEN6Oy3HFrZ05OuoQPyOVIoz36SmwuCO9Md0heo7Wm97Lh1ZLRzbVfU+PPMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071127; c=relaxed/simple;
	bh=yh7CxzzcgveUPvADfwlYHhL5S/vf5+PDVOFhtED17X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVqjiBCK3I3YaBM+7FG/7NqMvybT09WG6n5NwVibJiL0O2cP6RHm1E4EjWYfMqqQzxWdfDZwVrv2tSu4XfcqjY9A3Sqs2re0WYmsmtEvsq27a3gSCKzioD2vO4LNejd76pk+xEvTphYRZjaUABk8SwLvvpiDYv6th4WvoNGS8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i12Mmki1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i12Mmki1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4341d61fso580115f8f.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792071123; x=1792675923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyNEyKLQ/jrd+Lrq1caBuwPPaSfg+nPmt7eph+HDO7s=;
        b=i12Mmki119TiBMzzWABKcgv/bF16wdpD+BjGKFiR17jyuhq9js6IvVvP8d1u34z0qg
         e+Tyi5jaAiw0OLSGx5Onz+E20IE82EU2oyHOHCScyZQ/zTmnopCmPS24JMcR9+N+SbEO
         YUAymzgjFWlVM2GCnOtU1C//hf25Euc298QsU1yv4sHepmfyivjY0ejJSNN8ig/dENvY
         s8GcBz9wITmQKlteuzsaX7PXAQSK1k314h5dVifGJxVp6h99awA5I+ZKyROIxXFWbwow
         iJPPfq5N//UpN8XlV/ALFkjUWG3jrhzq0MjQFvPMX7Zy6CpMvfHDCwI6MQrrL7eA9yUF
         Xjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071123; x=1792675923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyNEyKLQ/jrd+Lrq1caBuwPPaSfg+nPmt7eph+HDO7s=;
        b=HjKfuupDF02WXZeiVte7qJyGY8vyt/P4ATzNVvEvwB9VtTFefkPDANFbnl1qcDyZwZ
         04/iRQK8D7FPEIRmxR3EVq4u8IeTFEDW+BTjfzb5K3i0Ax6GFPFtUl01tB6yznKEClf7
         N2FFPm4cinxs4zqKp056VWkMWVRsfHl2PRtc8HocAPn/czIFXhKg6IOD8pMhaFXtijYj
         xGFk/3o2bNBJIyGyGGtiuAT6S3ot48/OEpNHq02DTq78Vx2o6vLQYoybtkGbdIwXhi3L
         s1w2nVDlQ2VfBltA2rEIIGL8GAlI2rejX16WmfRqK/V+WIMDRNWo8fD6X6D0hkP+84bd
         TBiw==
X-Forwarded-Encrypted: i=1; AKwUvBzyXMLZ5WgXvbIdnpIu2v8TTHAXgWklPfzczc2NHziRCPxnuWw3CGUV9gvzbCThqjlzfc7EyXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqaacrnpVic2ZCypvSSyXbsAUDZr+RnzMvcETC9jQzjKCJnqL5
	wIT+8UaGfE/TYseee032hO9OdPgmq4Tgt1MH1cQweaaBfOpkcxuVprol
X-Gm-Gg: AYBFou1TwXBqpnXnJw75GfEUfEZyqkEY6gAnhNx6t3IRjifeDlVy+n7zbgr9tBfh5mA
	OiadyjLIQSZ6dyq93/t88pt66K847dEUbxvn62qoinYQ0zX+P3MIaxguAJjP8/nw1Ae9lczGT1I
	GutDL32vlXe184IWaZgH4tAkiCrG86S8V4KzgQ4xAUKGcZFgxKBEiF0QqwQ0V1tKQiObhPq71SK
	SZXbbfK/pnMsNwaKKs5N9S8yewZ/yKw+kZjuwib3m97zq+tLs4REdpraemlY9pXHa46OaRT7o7O
	F5gWdn0ZFppEdAu+Mx9NNYEn/74jf0Q8zyz9Je8tSZhKSHSKzM6mgSAxtKnclYD8HwYzpVI3/lJ
	o1ByTZHrO1vTLhwDJdjMrD3QMyVIyJTVzOZkGosuPOlguESmR1kuSZ+HNW9jcF62jH8As+MPN2M
	1ZcQydbK6DIHDJ4EUzh66EFP1y4y1jBcAbxV6cmSNV1TYK0GG7w+0WoYcc4fnXlhscwbHXeOKXQ
	mUi5jkDC5I3wW9T/GXh6+ssyMHD/R3J3skDp7/Lqkftc8mvVVMx6gxHv/MmQy/6/UWg8fiYPb++
	xFzLWHyTAlQ1FxQKa/ir58O0D7YC1KBmBipgDw4nmJnk9QOd9ll5KBu/exNU+96m+VPhoiaCrkS
	hFjuzdXM=
X-Received: by 2002:a05:6000:4106:b0:48d:f14a:9186 with SMTP id ffacd0b85a97d-48df14a92e3mr7001420f8f.6.1792071122317;
        Thu, 15 Oct 2026 06:32:02 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df5c3b89csm3301942f8f.23.2026.10.15.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:32:01 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	Haim Dreyfuss <haim.dreyfuss@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: cfg80211: fix out-of-bounds read in valid_rule()
Date: Thu, 15 Oct 2026 06:31:57 -0700
Message-ID: <20261015133159.1499728-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

valid_rule() validates a struct fwdb_rule from the regulatory database
firmware file, but bounds checks only the first byte of the structure,
the length field itself.

It then uses that length, which comes straight out of the file, to
decide whether the optional fields are present, and reads rule->wmm_ptr
at offset 18 of the 20-byte structure once the length claims 20 bytes or
more.

A rule placed in the last bytes of the file therefore makes the parser
read up to 19 bytes past the end of the firmware image. The image comes
from vmalloc() in kernel_read_file(), so with the rule at the end of a
page the read falls into the guard page and oopses, with no memory
debugging enabled.

A length of at least offsetofend(max_bw) but below offsetofend(wmm_ptr)
takes the other branch, so valid_rule() returns true having read nothing
out of bounds, and the database is accepted. regdb_query_country() does
not re-check the rule, and reads rule->start, rule->end, rule->max_bw
and rule->cac_timeout off the end of the kmemdup()ed copy.

A malformed regulatory.db is parsed by cfg80211's own
request_firmware_nowait() at init time, and on demand from user space
through NL80211_CMD_RELOAD_REGDB, which needs CAP_NET_ADMIN but no
wireless hardware. Both paths require write access to the firmware
search path and CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=n.

Bound the whole declared rule, not just its length field. The existing
check on sizeof(rule->len) is still needed, since rule->len has to be
shown to be inside the file before it can be read, so the new test goes
after it. A rule reaching past the end of the file is now rejected,
which fails the database rather than reading out of bounds. That also
gives regdb_query_country() the bound it already assumes.

Fixes: 230ebaa189af ("cfg80211: read wmm rules from regulatory database")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/wireless/reg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 11665e0a7efc..44226687349e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -679,6 +679,9 @@ static bool valid_rule(const u8 *data, unsigned int size, u16 rule_ptr)
 	/* mandatory fields */
 	if (rule->len < offsetofend(struct fwdb_rule, max_bw))
 		return false;
+	/* the rule must lie entirely within the database */
+	if ((u8 *)rule + rule->len > data + size)
+		return false;
 	if (rule->len >= offsetofend(struct fwdb_rule, wmm_ptr)) {
 		u32 wmm_ptr = be16_to_cpu(rule->wmm_ptr) << 2;
 		struct fwdb_wmm_rule *wmm;
-- 
2.43.0

