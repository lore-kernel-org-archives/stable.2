Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0D4F55C1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583830; cv=none; b=C4iGfid0L7a2mVvdKN3fd5nS8POXhNdYC8hEto0VrEX2LKcsLhm1AJLauuHktQbjI+2cD9SN93NVbf5JGjL7/EsKJyyTheOgvPtQK9XKWBP+IRn4Dh7vhiy4Oe7ym3c4dZJ2blnv3RxgcR6mI64G3UELebSNu1bNbqO6nH/iSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583830; c=relaxed/simple;
	bh=5QybzlqDtj8fyPDeOfwsLiGQcBTmXuLyhF58EjEVguU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdRnnuW0MS9VhGBvswYdBHmEy80wZ1zbnyw5vAw9oIqqmRBHQdhEvAM4xrTbL1vZwHpcD9A0kK5Sb28HaHo2vDbi0V5rU69zaFIvjfwCI91QqiH7uZn2DarTGajCi2UX+4s5+2Mw8gM1qQFcnBXfWnqcSKJui+G/LGyTNvCIXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWLDy5Al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWLDy5Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087CB1F008A3;
	Wed, 16 Sep 2026 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583815;
	bh=4xIw8ZQ+Y5l2wM6P6hQD9GKMVED0JIHOSGbYmNa02Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWLDy5Al1CiT3G1PhBSe5XCY0/oDWyqgfCShU+P4mzbc9Fq5IZfSvEed7HTS6EM/i
	 V332ZNezO8FRxon8FiTwvctFu02Jo9WQiF/FoseEbASClMUbNA1X1VAUaaNTH74gZS
	 YFluPQb4AnDsRSoEJf3M7Gj+m9k2AJT75UUp9L4vdZoTede2/qouB1F+GCT7+6NQcz
	 azkDYhb0vw9B4Asaxvh6wwKRx2HGeDD8EGlM/wun6UmO+aWUYFBubLDjS/tfreFmyE
	 yW7X39/dYMdMDVQaQw29K/1Lsvpz9MzSZOL10KPiSJBatrQOPSGTqO7yygOP0JyIsQ
	 1GVNTT3MnUIvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] tools/bootconfig: Cleanup bootconfig footer size calculations
Date: Wed, 16 Sep 2026 14:36:51 -0400
Message-ID: <20260916183652.1772436-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183652.1772436-1-sashal@kernel.org>
References: <2026091616-brisket-appease-387d@gregkh>
 <20260916183652.1772436-1-sashal@kernel.org>
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
index ba0be1679df3e..31536110699ec 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -17,6 +17,10 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -189,7 +193,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
+	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
 
 	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
@@ -202,7 +206,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(uint32_t)) < 0)
@@ -214,12 +218,12 @@ static int load_xbc_from_initrd(int fd, char **buf)
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
 
@@ -350,7 +354,7 @@ static int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - BOOTCONFIG_FOOTER_SIZE);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -380,8 +384,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
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

