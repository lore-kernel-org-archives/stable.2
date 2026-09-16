Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704234A7CBF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585676; cv=none; b=fpAvsKhom6c+5GGBiWSs5/EaOZ75zF5pA6YUy3r66wYZ1gpH4/H2/h3fEs0JwZE0e7EJ2tZ1+LEN+jv4IqcwHZV55mXUk3+WAsP0fZigoFvBMNMsUJTMm9n1IoP0sP3krGmlxdTvH33oE2rUxRmL/XTk2sT40E81e/R6/JgF7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585676; c=relaxed/simple;
	bh=UNG4yxvPNXH7lITyNZOwCbLhLqn6wXfzKhVnexrWN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCgY82GoZgBe1HgtmIlaO/SQa0sdJZR3B8HwXsTl5KyB/E/59BJzVp7eSNf9MApC4DoKi3Mcw//RW8UqrR00wh8NAyCWGXkFzJTs07uSWPGWz45ep+j5KznVoQqUtKm4IevkFVBxcXF09y5LomXJ4Doe04t6R90d95EAB44XQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBhA6I4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBhA6I4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9451D1F0089C;
	Wed, 16 Sep 2026 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585660;
	bh=EWkTJ+K8SVeGhOJ5Rn0hGBtk2Z3xEPhnlX9q90aAbqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBhA6I4WSKvymrMTIfHjgTgYn34hJhx0TIVeG0xpAshVOx7+ip/3qF7EPpE0enkNE
	 Hej76/J9XORNXgsfnmHAaGGEJAPKco5H8PlhXx9rjaFYhkSwQ6tt6kJlw/tNEMHAJV
	 4q2CUaxPdkVgBSIncvhB9vp8KGw4YMrTCXx5+eVyqoDZwGSrMvzD+QtxH7dzX0oHSe
	 8Hq1fWwsDiRqyOyA2jcJcY1uCAGmukd8ASjbMJzfKwBO7/J2XdbE+UwOmsecpqhlAh
	 Pi1Ak9K5kg9FvagQDoxGPg86lNMo0J5lW0uC8nzfTc4ci3EjEQraeTdkFTV+fNphbG
	 piy6etfmFhVSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] tools/bootconfig: Print all error message in stderr
Date: Wed, 16 Sep 2026 15:07:32 -0400
Message-ID: <20260916190735.1968203-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190735.1968203-1-sashal@kernel.org>
References: <2026091617-cackle-deeply-2ea2@gregkh>
 <20260916190735.1968203-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 160321b2602ff8e42ea77a09f2e3f1b35e3acfaf ]

Print all error message in stderr. This also removes
unneeded tools/bootconfig/include/linux/printk.h.

Link: https://lkml.kernel.org/r/163187298106.2366983.15210300267326257397.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/include/linux/kernel.h |  2 --
 tools/bootconfig/include/linux/printk.h | 14 --------------
 tools/bootconfig/main.c                 |  2 ++
 3 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 tools/bootconfig/include/linux/printk.h

diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
index 2d93320aa3742..c4854b8e70237 100644
--- a/tools/bootconfig/include/linux/kernel.h
+++ b/tools/bootconfig/include/linux/kernel.h
@@ -5,8 +5,6 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
-#include <linux/printk.h>
-
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
deleted file mode 100644
index 036e667596eb1..0000000000000
--- a/tools/bootconfig/include/linux/printk.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_PRINTK_H
-#define _SKC_LINUX_PRINTK_H
-
-#include <stdio.h>
-
-#define printk(fmt, ...) printf(fmt, ##__VA_ARGS__)
-
-#define pr_err printk
-#define pr_warn	printk
-#define pr_info	printk
-#define pr_debug printk
-
-#endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6b212e9835e07..6dd8afb954e48 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
+#define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
-- 
2.53.0

