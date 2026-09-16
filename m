Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C34BD366
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585684; cv=none; b=hcPo4QiPbW6vRL02mfM9PPZSELVwUr2KSiY2osk0pg8GsY1XsptABbpTeLhXE47OEH7JKJ3BXyXzrJjC1cFxY89KHf2HJm4GG+vJK9Zk1WiU7x7pCoExamkWMBvUbeIPzcJ3mn6dIgC5KLpR0xvx4ELypwPA7bsGdgAc7GeDkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585684; c=relaxed/simple;
	bh=EruYCrF+EIiY4l1YFK5ES+elJwOQRM/a2ExYiw7EZus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCWudPhHeBeEiXfORIj1nc7NFtQJwXWe318sZSJy8WuiW/j7rpvUs7qZ4t1U+2bn34RnQuz2Mia3HEYz5hS8++TKh0dwgZ45g0Y1EH0xQxLWBm+8RJuYS1TG/Am/cegfV9UXetwCjb5hbZl1t7GjWmQdlEQb6sFc1qtxPcdfHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpKAk5aK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpKAk5aK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A271F008A0;
	Wed, 16 Sep 2026 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585661;
	bh=tKeBugkdN2ORoNu1x0ZmfF+EPDAd2MGcFYm/I4oTQJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jpKAk5aKguzowz+7lgrEcZx7vqs4ILb6BqCpq3KLrcCeb/DtUYyqcwQ8OkqfYTFpr
	 G7iFNC62gu+r1HhkT098ayLqmYrFmmPvBEyEQUINS2SF+CX7iRjOZVQz4T2EfkaqXD
	 ysOEXFrm4xs+Po5WTw1ZJSFn/4J2IZAHFGJMy9GwdlDWo9G8OTqSJ3jhkfnQUgRNQA
	 4T+rQFQ6Dszb65UdqOJoenHbuCKsKUjNk44vcPmwd638A6njPS3P7LEEPWFkmqv39v
	 QcwnG//VNpsLKKEyDffptGqd6jlzZ17LQCd9LTFJfUj7uqTnqZHKoiu4zF36lPjz+O
	 Pt1HU+dsL2jsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] tools/bootconfig: Cleanup bootconfig footer size calculations
Date: Wed, 16 Sep 2026 15:07:34 -0400
Message-ID: <20260916190735.1968203-6-sashal@kernel.org>
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
 tools/bootconfig/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 358c7007dfe8c..717aa69473a60 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -162,7 +162,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
+	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
 
 	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
@@ -175,7 +175,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(uint32_t)) < 0)
@@ -192,7 +192,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -E2BIG;
 	}
 
-	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+	if (lseek(fd, stat.st_size - (size + BOOTCONFIG_FOOTER_SIZE),
 		  SEEK_SET) < 0)
 		return pr_errno("Failed to lseek", -errno);
 
@@ -323,7 +323,7 @@ static int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - BOOTCONFIG_FOOTER_SIZE);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -353,8 +353,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
-	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
+	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -401,7 +400,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + BOOTCONFIG_FOOTER_SIZE;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 
-- 
2.53.0

