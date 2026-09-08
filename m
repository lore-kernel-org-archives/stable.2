Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CD595726
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890147; cv=none; b=Mzv81XkEQ6vvhz6zWXD6PTG8GfruiEO5mTu279VSORvi1H0Nsz9zbT/QVqrt8ZLoM2BplJaWexbKrEZP5P6IFZC7PnKDln5dnh+bflIeu3pltSUVSAEdgIB4dQjfANIXhJpX6vvcYqbkOuIOzmFILYHKf4bzIelzPLgFqo70x6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890147; c=relaxed/simple;
	bh=xKhl/7/P5H0Ze9mI0/xrydMyPII471kJ19WYqX0LNmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZMHL602v2hWkGOZyLigkiQQIcL94TuJMgJCPXxo9T/h+lqFCfsS1yfteuj1GB8vi9WzT1SfNt5Bequp6QtlpQXaY10PEnAqMP0V3AFUcWehWpxcIsjF+dnX7uvMxz8y/4YcxRFSVJP0NQuv/KXc6rMdEREL0FzzHaLa1BkmjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auYZsX73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auYZsX73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46E21F00A3E;
	Tue,  8 Sep 2026 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890145;
	bh=Ge/1yOd94Oto4KgemOkGEQGuuc9wRM6wigzvrr6eO9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auYZsX731TqDTwbS6odtDRXiS2RyMSqaWrItcmL7DQqLVKWbdbLnWS5itibxJWa0+
	 +Hiou9hPefqbyLqx0QWUcq8Fr7pQBJ4hACIbWQRuNLXqx3G5YSXPalwYEy3Wir9zeZ
	 fSRWzCR1svzB6T5tignbaRdNykw5W1GjzLBgOIRU/2nIBcvbyRldeZ7hThuWUUVdml
	 ALrAda+NnpIJMIjzeWZGR1z/dBrLduEqXzkUYmQiOjtAXCkyf0fNiHmddWMe8RpwL+
	 nmBV5eFg75ojjUE+0cVz62wUmg9M93qfUryvj1lyYay3m3eGN/ExQjTJdlrndyZwuJ
	 3WKHeF2um7jLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] params: Sort headers
Date: Tue,  8 Sep 2026 13:55:39 -0400
Message-ID: <20260908175541.151692-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908175541.151692-1-sashal@kernel.org>
References: <2026090331-stays-casually-f049@gregkh>
 <20260908175541.151692-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a05f096c2c0ca52e8fd34740c7d4b53ab3e7123e ]

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 1efc083b651c9..8e085de8551c3 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -3,18 +3,18 @@
    Copyright (C) 2001 Rusty Russell.
 
 */
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
-#include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/err.h>
 #include <linux/overflow.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
 #include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
-- 
2.53.0

