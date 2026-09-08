Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5B5452B6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891670; cv=none; b=NvawX3S2g9OdAhmC/cEzlzbdvg5yIIBCf+6rPQ1BRYjSJl2m2vxsaVvJjtLE7LBBMuX+DJjdi/P3BlcAW1aJu6kV9vu+Rvbm+I0W1tRCMtNMxv8QwpMf37obiqjik4Q7w0c/QOAUbgcFBMITaUOVCnrO1dN/3J0kJHJgsX9EkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891670; c=relaxed/simple;
	bh=qncFSyQH/sebvtbJ0TmM1jfPbZK9qezR/JrlNbvUBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhzuu4tNw+LggbPkTkKYTKiScs5nVu7nA20ow7deLjh81MPZWAmOrj9a7Fwa8L8RF86L5oyvVF+7DAp0VPzUiEV1LtUyW0M+wCY362NMZVTKQoNM/X1a5wQzq4sokcvvkpD3tFvDwnPkw1nX+/jBZUuX4kOmaOnWsu6Gp2Y8Vl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji7bENSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji7bENSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE761F00A3E;
	Tue,  8 Sep 2026 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891668;
	bh=0bnZeaZQcYG4px+xL77RfwIwRWwwStKFLYfy4kXIU2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ji7bENSD1dVFS5ycfsBbJpHvpi84cqRvZwjxQ9ufhCVb6rCrzFxCgf57VWuoJHsMd
	 x4fG0ldwExa8MPoMygNjAY5HYkGaE6ZyGL0inl2JU8WiMrKZfojwNDiHl58BkPm8nH
	 rhb4TiUY/WlJpKFv2+mAnQ3hyVoANdgviJmaFitPVCJcNnpNBTXW08cuqupTXKkxcz
	 vAPeG/ZuiZf67RkavVu4YcKsam40LM4wzIWqZ+DpV+VcGsV/vX5pZkTg0m6ZgpKXUw
	 FCa8mFIrdCDyyaxpANq+SJ8SQnzOOzLMlQ/fJRmw/M+bHbK9CeBeDFL1abZnTCBI7R
	 RQiC79fgwNh4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] params: Do not go over the limit when getting the string length
Date: Tue,  8 Sep 2026 14:21:02 -0400
Message-ID: <20260908182106.202353-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182106.202353-1-sashal@kernel.org>
References: <2026090332-lankiness-same-e48c@gregkh>
 <20260908182106.202353-1-sashal@kernel.org>
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
index b904bd98dd01b..55541483d6d36 100644
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

