Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F544C64D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583840; cv=none; b=onMcsuGqTeltfMjH0JV6+YTUgVUcC3ki4sUt0QD4u2onUDUd4TPNAosUPzYSaEVWmZEKtbxZlQILZ30Dst8ylqH5LC9uKq+M/taeUTBYgdYtm+GMw3lAkS3sw27gNYcAPyTudd/ZOFYCMEEP27FNYpRSzH7CzcoflLX8DpSGP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583840; c=relaxed/simple;
	bh=LLSdxrdBIlOWymE3XaDiWnmwCtBtKAFnzLJf/2ak2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV03ENBnDLB3E2pqqjWLIg55srHj0VjmW4jVKSAQVxidByIIdpGLHHEo0Ckc5bwg+bdCH/0xrSWnoSd4dCfXMq+M8qiixZpVlPdTqfx2v8neymKJWkU8ScqmLxZu6rbBeFdAlD7chm0VPMW0kdKcmkiKO9TGSEOpfjnr5epGtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/mr6dvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/mr6dvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF21F008A4;
	Wed, 16 Sep 2026 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583814;
	bh=PLgMwx8+2blMv64ula93rN3KXEq2BU5rEaSx0wo8nCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/mr6dvoFYagLrEGyk3jjrEL23pD/1zCWvaqSisjSwqchVM38NIIRSLsFe4Weo0IG
	 VmyUkRsjUK6gGSt8X3J5o7g5Ln0fuWjV/tgKdHWWoxwtg0wGibt+PpeYmW7E2WxBJD
	 +uXT94YzPJmtmoqg+uSesFdPKnDmdgj8srsHlWNUgGyjtE9vJ6BesicFbzGbyK2FPm
	 2frB+G0XTTLHc0HDcAnZ3aV6szTbRBJvoisoKRv0iofFzpLJljZ9rKDYre3hNVN5Xg
	 7/+QkPdHSjxQvApILQl0HFJFXEG0c20rYKhOad0TICe3XApg1zJNUyrgIP1UQPpyXz
	 D+iSQV2Z2ReKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] tools/bootconfig: Print all error message in stderr
Date: Wed, 16 Sep 2026 14:36:49 -0400
Message-ID: <20260916183652.1772436-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-brisket-appease-387d@gregkh>
References: <2026091616-brisket-appease-387d@gregkh>
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
index 78b252ac3817e..dd51ee6f508c4 100644
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

