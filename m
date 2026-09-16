Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35847521215
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577334; cv=none; b=n1U3U+TB3rmA8PWiYaRJ4+lDSslS0rwU3mmOBA2wO5rEwoq+UWtEKJjozce758IITDtrI+YK16tbcuPsj7WfEwt6/0i9a749/APG/qzRfDAPoZ6G5f9KvkOMn0t/xYzEUbIsRCwlgx5u+jhX5D/olvOAHkaMG6E4S7noQEHBLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577334; c=relaxed/simple;
	bh=3KnsZcqOzcdnveDafiBN7vQK2Edk5FuvQg/xPZwrRlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMSRvl7V7Hi7eYE9xewRaV5ve4JMR1ewH2UYaMqbAuaXMT9GWx0cSzky18Ur7qN49+R+XBmXDyc8Xckf90PpVLTMVzVztXDrKg02JZty9lxam6dEp3ZoP0B+aChLwEFk3z3eI2EtSJ3X6MZvlXYGYFWgzvtHCAwf23Ckcums7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHqbz5TK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHqbz5TK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B041F0089C;
	Wed, 16 Sep 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577328;
	bh=1o5iZrbb9IWTT6gaK/WLFrauJxYRPSo5+4a+v/YpiVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHqbz5TKtzu36MJujWkPQcTmjj1cwhVg8iP3NDZL6iqNPIRScELyHfKeXmfOb2nB/
	 Cd1iFUJqSublQOo6/J++A9EaPfsfa7hrA4hbGQ75ies6xm0MnAHpLxXqSeoJ3WrqjA
	 2LMZMyXRVFfNObDNG+cdxEB97Kr2yz2V4pOKAJHMqPPQRFCjRZJO9vuiTzFbF5H7Sp
	 n6IAQLustc91fPjdiyqiuAagjF0tiYZ+JXshQHX46yDp9em98DyQQVT+TqKmp/vjFF
	 2mMB2pYXhqZ1AHFbfvwm/TiJGozeGpGrbt/IWGlPUrMxIY8wB4B1st0ccgfIypYUMI
	 CjmxxGEOlblsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tools/bootconfig: Cleanup bootconfig footer size calculations
Date: Wed, 16 Sep 2026 12:48:45 -0400
Message-ID: <20260916164846.542398-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091614-overstock-purist-0d71@gregkh>
References: <2026091614-overstock-purist-0d71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 26dda57695090e05c1a99c3e8f802f862d1ac474 ]

There are many same pattern of 8 + BOOTCONFIG_MAGIC_LEN for calculating
the size of bootconfig footer. Use BOOTCONFIG_FOOTER_SIZE macro to
clean up those magic numbers.

Link: https://lore.kernel.org/all/175211425693.2591046.16029516706923643510.stgit@mhiramat.tok.corp.google.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bootconfig/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 32cf48f2da9a1..d302235f6b974 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -16,6 +16,10 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -188,7 +192,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
+	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
 
 	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
@@ -201,7 +205,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(uint32_t)) < 0)
@@ -213,12 +217,12 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
 
-	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+	if (lseek(fd, stat.st_size - (size + BOOTCONFIG_FOOTER_SIZE),
 		  SEEK_SET) < 0)
 		return pr_errno("Failed to lseek", -errno);
 
@@ -349,7 +353,7 @@ static int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - BOOTCONFIG_FOOTER_SIZE);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -379,8 +383,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
-	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
+	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -428,7 +431,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + BOOTCONFIG_FOOTER_SIZE;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 
-- 
2.53.0

