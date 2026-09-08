Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97C595726
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890145; cv=none; b=acljqO1WAoYqwB4OFa0oB0SW6HcrKeKchYqZYYJPf7qJ5reMv+Xg2TBsARoQvGaw4VMvcjl60B01/VFPBTeoW9eHPblc9SIIg4fEWSxrYTKVOJ55hO97UR2fPOkdzqs89OdxBiQJTHnok229Ng2VPfO/b5U08lAMAQiVqqyDYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890145; c=relaxed/simple;
	bh=TX8r1tAhGswayWtDEItGnY4qR+NlAOiuzHOvXPD0Das=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jcp1oo4lkcDPHjsDJi5/o1JEbMBBj0QXTQizXfAHGHgOUwohJJ2FNDVrhTDeqIS2Yf1ib6rf1ZEK5d+iWKcZEsAX6xaz1o5Ml4Ncc03iMpqvoIXOu10wW2RuU33uFtnIIKJPj4reYXrtkdUIM2p4quQciFoTM0l7DAwX3/NoBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWR3xVwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWR3xVwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D291F00A3A;
	Tue,  8 Sep 2026 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890143;
	bh=NJMpvAPB8nGdzAKYCLTzwm0XNo7f7ziTbgnmmuG+lME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWR3xVwMsrSkaTb1wcdaPpSnPqBKae7DtNKcpowrJBsEG377jMhP9p0w3G/z9coUv
	 IxJaVLPH7dtHFa6JP+MWzX4VY95TV4nihU0mTvdoJ543SIsZFHQWhBIIpBYrNmryyx
	 NEDeRtchzhfpTwRHkMYg5Q9NPtPKvCrI7X6s+fwZQ6aoynissR058CMJms3vZ7F9YR
	 GbqzY9fR0STMljXw2UQQ7Hve19EbONkLFl57pam0ZYwsqXaHydGa5S61mg8WY3qq7x
	 jD7Uo7IMI2ruplCqKZOIjwJqNXb9JfkUBzfdd66jK2fMdPvOqtVkFaYh3b/KhHEZVD
	 ACrU/QwyBficg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] params: Do not go over the limit when getting the string length
Date: Tue,  8 Sep 2026 13:55:37 -0400
Message-ID: <20260908175541.151692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-stays-casually-f049@gregkh>
References: <2026090331-stays-casually-f049@gregkh>
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
index 9d09ea99363fc..8992899996984 100644
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

