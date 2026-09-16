Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A84E50D4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585688; cv=none; b=Q93LtV2zJGYqsU9ezq3Aqvig0h1k4UGTTyN0izVRQr5qBaVi1LBVVlDG9ViDXwWg97YrHN14ShERmJH9KraKroXLvPctJCBJi7GY6ywYsbjJev4QYi7zSQ3Y3q3V77Z/5ZKDNBmr+3TegTCVqOMU7LFn7UuiVmCFi0u3UiDeW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585688; c=relaxed/simple;
	bh=ZyrOFv+HPRXQ4cGXkj8EG6guHGhSeYeG4D/gUvglBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMiIaNzmypBbJ0XH5t3hIx5mq3aM2fbJVOCCdN814equM6zfJNWmTn4EC2LikFI44+2+r2ocY1KP6Uj9VpW9jNO1BlOtqYgUlshJi3i+mvarZ9aUG+KAkaOfpcNGMRe2W/h7F12UT7wFa7eKjbETopNfBBezfMbin/IXOygrdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSH+8RLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSH+8RLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBC1F0089B;
	Wed, 16 Sep 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585659;
	bh=b5JJz7c1lADlXCsWQL7HqkFHUXDsVxqEOCjvf/3KjVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSH+8RLxM1xIskP4XUShJbXoddb13FgO+Bu/98+Z4Onni46QlIXiV3RcVgFbx1Yo3
	 c2oyDw+PElN4gkSJEM5MT6BvH/wrUN8bPa8YPMI8gsbrxg9YAiCDcCvmlXTogg2vPh
	 N31z107IP6B/7iIk5tx6JkOSTg3R0ZQaFU4J+koBdAogDJ/XOqHcooL56AMfdHmLdR
	 KIWqSoFNjtgJ6PQkhMcXjcO7wA5g72sPm+PuYzrzrr0zxhhwrbz+WHVON4yNcRJSlf
	 VIYzadmevkxx2sFZopQyaJnpjfyKPZz6epw7J79hJF3qMDSxlU7NW4BEZa0VeB3cQ3
	 0dHccxJ2ujj/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] bootconfig: Share the checksum function with tools
Date: Wed, 16 Sep 2026 15:07:31 -0400
Message-ID: <20260916190735.1968203-3-sashal@kernel.org>
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

[ Upstream commit 99f4f5d62338cab9dcf45735344541574daedd20 ]

Move the checksum calculation function into the header for sharing it
with tools/bootconfig.

Link: https://lkml.kernel.org/r/162262197470.264090.16325743685807878807.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bootconfig.h | 20 ++++++++++++++++++++
 init/main.c                | 12 +-----------
 tools/bootconfig/main.c    | 15 ++-------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 2c5f0b2484caa..47d2116883b15 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -16,6 +16,26 @@
 #define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
 #define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
+/**
+ * xbc_calc_checksum() - Calculate checksum of bootconfig
+ * @data: Bootconfig data.
+ * @size: The size of the bootconfig data.
+ *
+ * Calculate the checksum value of the bootconfig data.
+ * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
+ * embedding the bootconfig in the initrd image.
+ */
+static inline __init u32 xbc_calc_checksum(void *data, u32 size)
+{
+	unsigned char *p = data;
+	u32 ret = 0;
+
+	while (size--)
+		ret += *p++;
+
+	return ret;
+}
+
 /* XBC tree node */
 struct xbc_node {
 	u16 next;
diff --git a/init/main.c b/init/main.c
index d23d1a8d5393f..fdddffa54361c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -346,16 +346,6 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-static u32 boot_config_checksum(unsigned char *p, u32 size)
-{
-	u32 ret = 0;
-
-	while (size--)
-		ret += *p++;
-
-	return ret;
-}
-
 static int __init bootconfig_params(char *param, char *val,
 				    const char *unused, void *arg)
 {
@@ -399,7 +389,7 @@ static void __init setup_boot_config(const char *cmdline)
 		return;
 	}
 
-	if (boot_config_checksum((unsigned char *)data, size) != csum) {
+	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return;
 	}
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index b276fb75065e4..6b212e9835e07 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -97,17 +97,6 @@ static void xbc_show_list(void)
 	}
 }
 
-/* Simple real checksum */
-static int checksum(unsigned char *buf, int len)
-{
-	int i, sum = 0;
-
-	for (i = 0; i < len; i++)
-		sum += buf[i];
-
-	return sum;
-}
-
 #define PAGE_SIZE	4096
 
 static int load_xbc_fd(int fd, char **buf, int size)
@@ -206,7 +195,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return ret;
 
 	/* Wrong Checksum */
-	rcsum = checksum((unsigned char *)*buf, size);
+	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
 		pr_err("checksum error: %u != %u\n", csum, rcsum);
 		return -EINVAL;
@@ -355,7 +344,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	size = strlen(buf) + 1;
-	csum = checksum((unsigned char *)buf, size);
+	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +
-- 
2.53.0

