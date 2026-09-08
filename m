Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27859D612
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891345; cv=none; b=uc+b0qoAErQiixpSosQjbLEBejrVlOsowDlfqwd9OW4fN8qjA3bKb7Ossbr4tZFrUepVnTHx1ulBr1gZriB4sVlBT74kVQJIbcWDeedA5Im2qwsQVVH4+XKCiRpciBto2EZWOXMrtF70oSehCwzCTFIeq2XK/Jz8/mUHJWZeLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891345; c=relaxed/simple;
	bh=KNE/Hig0bFcNSlGLOokOB4I/Z5pDYVqw2tbsvUQf78o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvLQ3skmC333s05d15pFPqJhgNGfPesCZwtKKgVAregCTfoMlmu3o3VppPYojFvhZHCEvca9XZ37gGtkZiHqUAdA6UO8/J6Qz05P9Ht1OmqtOsuc1CRh1VOiHvf5G7u6JcpSbKAINUuexg8TDYElqyq21SL3gmS6+ap2Wk1zsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZWBsDuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZWBsDuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594F11F00A3D;
	Tue,  8 Sep 2026 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891342;
	bh=DXN5W8aQheicVRMNJpHRfA23QTa84V8MTwkWqsr0r4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZWBsDuXFYfVC8GJ2qgLZGIUeXlpRmsDqB5XxysJZe+UDw02xBitCFjQmMw7eMEYx
	 RrNxTVjGRAJU1tcwv5OuhsA0TBOEf/M80W6JWEWyla86Ulr/8Hhb44rmZ0Z/m5Thl0
	 9viMxt80UHZtiRcqb4dlHDAx5wsTDyJn4JSlyMvIVMbgCBxQwtn2bYfhy+JUW6Jp50
	 yjRpWlpE0vnie3U2GMPs61CcnrxQWRtQqHLTQTAuJx3OwgL9x2E/chLWgF3tTeKz99
	 F8YuShwtuE7wDuDrxpNZcI0E1KQomIKO4PN5Y2c3693Ghc8i5m0NDVdPk+ZJb5gInm
	 elhmuFJD2Xj1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] params: Do not go over the limit when getting the string length
Date: Tue,  8 Sep 2026 14:15:35 -0400
Message-ID: <20260908181539.191940-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908181539.191940-1-sashal@kernel.org>
References: <2026090332-blazing-handcart-8248@gregkh>
 <20260908181539.191940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit fd0cd057a1b7351604daa6ffc91dfe28adf7225d ]

We can use strnlen() even on early stages and it prevents from
going over the string boundaries in case it's already too long.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index e6df4c2ef097c..89c139e861faf 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -264,7 +264,10 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-	if (strlen(val) > 1024) {
+	size_t len, maxlen = 1024;
+
+	len = strnlen(val, maxlen + 1);
+	if (len == maxlen + 1) {
 		pr_err("%s: string parameter too long\n", kp->name);
 		return -ENOSPC;
 	}
@@ -274,7 +277,7 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 	/* This is a hack.  We can't kmalloc in early boot, and we
 	 * don't need to; this mangled commandline is preserved. */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(strlen(val)+1);
+		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
 			return -ENOMEM;
 		strcpy(*(char **)kp->arg, val);
@@ -512,7 +515,7 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
 
-	if (strlen(val)+1 > kps->maxlen) {
+	if (strnlen(val, kps->maxlen) == kps->maxlen) {
 		pr_err("%s: string doesn't fit in %u chars.\n",
 		       kp->name, kps->maxlen-1);
 		return -ENOSPC;
-- 
2.53.0

