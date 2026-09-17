Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A463CB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611548; cv=none; b=mjuzeONTQReOsza/FZuZQdYcroBIo8f54WRI55dc4w+HE+drR9IrnLQbwdkTus963CgzxGRkbksBQxhXHJmD9JhS9t24iejifP28/oDXfWPcu3HwI1lJyFk8S9k/ie1U5FLpGfAtAqUOCIRkYlNBJiPVV55ysg+K8t3ECLaC+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611548; c=relaxed/simple;
	bh=foAzWDuc8q5pEED768fseTqmhavTKY/ERDgfxQKPuOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPppcEr3WTdIUBM/pvCTYt34xE0lW5aiPeTIioDaBkFABqrhLDe5OtCHSuzmi3fNIj6VguXo0jWVeRipTPv1JV5NxjdJtsTUL3PQHAwtkDHEgy1/LaEf4HHEzMD0Lj9A1SPfg1ZXGhYlIKq4GUYrc19MQ23ecWdPZXcscbsbLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt+sY/Ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt+sY/Ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564841F00893;
	Thu, 17 Sep 2026 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611546;
	bh=sXqBKijEEeCtP3WNOPDEUVglaCyr9DFRyWSJAVxm+M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qt+sY/Ril6Ysn1eZ7WFOse0kvdE3epNWgPqYAhlqtyzU9CeeAP4wnV5QX3mYjyTEv
	 twvNcq7C77Ql++lf8mtCTExYqw5rx14nSlYGdq1e7uRKywa2IgOaAKuT3xJqMmK8/Z
	 lmopAm2R6dt4CCG/fyxgiS07AKEl7UcpXr5VGYb4kfNdgtPJqwVEHGOpCokbv8XU0e
	 Ax0K4tEeU8UZNZL0jtVceIn++Wo6TZ3SKeadpXaNRlKvAOJn1kanpfsZI2yGzNfjtN
	 m9U2YCMa0Wv9B7KMjgPyunnYnwTSx6MfYtEwTIfrPtERYmMgygNB0g81/QcDO5i8ro
	 lmJeF3LMJIvkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] bootconfig: Fix integer overflow in initrd size check
Date: Wed, 16 Sep 2026 22:19:02 -0400
Message-ID: <20260917021902.3810750-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021902.3810750-1-sashal@kernel.org>
References: <2026091618-used-flashbulb-70ef@gregkh>
 <20260917021902.3810750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 7812d6dab0698001e50e8c2f901e17da3eb6f429 ]

Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
arithmetic:

    data = ((void *)hdr) - size;

to wrap around on 32-bit systems (or when pointer subtraction overflows).
Because data wraps around, the subsequent bounds check:

    if ((unsigned long)data < initrd_start)

evaluates to false, bypassing the check. The kernel then calls
xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
hitting unmapped pages and triggering a fatal kernel page fault during
early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
unbounded 32-bit size can similarly bypass the initrd_start check.

Fix this by:
1. Ensuring the initrd is at least large enough to contain the bootconfig
   footer and verifying hdr is within the initrd bounds.
2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
   the available space between initrd_start and hdr before performing
   pointer subtraction.

Link: https://lore.kernel.org/all/178905333479.213925.1358412668943562406.stgit@devnote2/

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4da396cc3af71..faf4eecda23e6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -281,7 +281,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size)
 	u8 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -298,16 +299,26 @@ static void * __init get_boot_config_from_initrd(u32 *_size)
 
 found:
 	hdr = (u8 *)(data - 8);
+	if ((unsigned long)hdr < initrd_start)
+		return NULL;
+
 	size = get_unaligned_le32(hdr);
 	csum = get_unaligned_le32(hdr + 4);
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start) {
-		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+	if (size > XBC_DATA_MAX) {
+		pr_err("bootconfig size %u is greater than max size %d\n",
+			size, XBC_DATA_MAX);
+		return NULL;
+	}
+
+	if (size > ((unsigned long)hdr - initrd_start)) {
+		pr_err("bootconfig size %u is greater than initrd size %lu\n",
 			size, initrd_end - initrd_start);
 		return NULL;
 	}
 
+	data = ((void *)hdr) - size;
+
 	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return NULL;
@@ -398,12 +409,6 @@ static void __init setup_boot_config(const char *cmdline)
 		return;
 	}
 
-	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %ld greater than max size %d\n",
-			(long)size, XBC_DATA_MAX);
-		return;
-	}
-
 	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)
-- 
2.53.0

