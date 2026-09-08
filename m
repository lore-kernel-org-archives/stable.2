Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700855C1DE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892134; cv=none; b=ZR7RfzE4Vs0mCkjiWFWO0RMkdnPHLKf5MNks2521lZsgfcTpmnTO1cM1XL28vRcJs8Ko+RCX6822inJs8/r7hGlWJDtiEPQxFV4nwcOaBSsUKksiU4tW273tzvBXZnktQlemRXfQsEWWF/VcA938V7zOnFJsMGzASQLFbzEekNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892134; c=relaxed/simple;
	bh=+vSTPfwVCT2X4gzVcq/sbWilrOC6UfZBp1qn6gv3a+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ1S1WnnsjCgT0by3hkUlACPpLOap+6G835CuoeBbWbJSwj2qwpRtCco9ggpOA1WMliVszCUY9FNfCLuidhfchW5wOifV/tw7q08kjm1o+zCmEPyAzuXcxTVXzwSa3YMvEsGHtEBUcj0CvRs/BZhgSjKYNUMuzsJKkI59kzeLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feW4zUjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feW4zUjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928FA1F00A3E;
	Tue,  8 Sep 2026 18:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892128;
	bh=QWKFYJvaLds18VQbS96gK9KehCcriKIKlhJVj9xk/Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=feW4zUjYy7InewlsoFFXD67GNl3cUhFv8yujwDZxu1g8qOjC350gOPXnfksoundyY
	 coohmtzMUfpw4zne5AGBCXSyY/Mici0FSzk77P/sBZ8nKPgMYU8xfbx7x627rgm8at
	 cvs5S83WiHspRdOBVsHwJdXkgdtgeoX1Hrt1wt5mErK3QYOBveCWrEU+eWjJ4Ca4Ts
	 Vgfj/NGpTsqxPsd0dIIq9yRFXAsbffWLErY1ofEz96iL+RKlk+c5JERgKyGMf0hMX5
	 c5VmeeggEdVOIMmh9ApmGam4/FKIFFTB8xxgJrgOHCAp/PxNfUImDempbHxAbAFl7g
	 IJTBHDEmiczkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] params: Do not go over the limit when getting the string length
Date: Tue,  8 Sep 2026 14:28:41 -0400
Message-ID: <20260908182845.219246-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182845.219246-1-sashal@kernel.org>
References: <2026090333-barista-diagnosis-cdab@gregkh>
 <20260908182845.219246-1-sashal@kernel.org>
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
index 9f0f059571a0a..30c0a7388024e 100644
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

