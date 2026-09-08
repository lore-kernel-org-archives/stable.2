Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C559D619
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891345; cv=none; b=VdfGXBSan722sU0gHArZekDvZyZxViC9Yxib6qnauATrn1Ws3UvO8DLouzGTwjywSM8/ufvPS+SgMtxh/aD+ra2OW9MPUP8/39IlnNFUTqTuLSQOr0dT3xwuSJ25is9RSv2fyjRfIdPiTcAdrNu6UQrQ2KeaWbmxr/zSbU3Vzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891345; c=relaxed/simple;
	bh=sDCXOukQABPVjpWTgveBI5Qt8GU9rYSKrpl9Hha27P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLzxVrMkltXv5C6HMrwdL56nJXEvonVGfn8pKueI4IxCdXQyM7PwOz5ejnnE8MNaPShgS4tlEqkpUigJVORojrmhEBvZtwO9+70IhEJo/IRLfqb61C08XtqBgiMpRNqZwZSsM68lnKK0k8UMm+uSMtK2kB30G3tZOzzOzAN2ehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEsMvmjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEsMvmjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA311F00A3F;
	Tue,  8 Sep 2026 18:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891343;
	bh=kdcJXsyIGTeLXtGe/jl/e5HmNigyFr7ecXg0/6cxDhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEsMvmjSFoOvntKg5KebycNed1GeAaPu4VGwreWfoAndhd5MlGdzomeHVXlXMZrqT
	 jgK8jMtamjzP0HcMplfBv8Q8lLITTHZEH9eHechK/ZLqIErovAAl4574sjwuz2XrFC
	 YsRqd+Oy8jQ+1AssD8JlEgvsUjmuROe3ETJwpSYOKVo3bNlWXKFJoB38CmDcLSCC7B
	 PAmnPw/wlnXXqyVcXiZJZaY7wA86a0NycqZimDUgDp0bjKzIw/fn1Ib1jAQy5eXOrK
	 C1S6UNPoy2aP+1da0k4nMY+kdM95Egom2qWWv1F7NKn82XFRNxtBfmv6V8l2FfpQ1l
	 dRQNNwvdg+FJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] params: Use size_add() for kmalloc()
Date: Tue,  8 Sep 2026 14:15:36 -0400
Message-ID: <20260908181539.191940-3-sashal@kernel.org>
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

[ Upstream commit 0fc79cbc937f2a754a302a710a94b68c61d0a89a ]

Prevent allocations from integer overflow by using size_add().

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 89c139e861faf..4d021ba9c677a 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
@@ -48,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
2.53.0

