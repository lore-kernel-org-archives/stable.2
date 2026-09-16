Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425E412C1A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602169; cv=none; b=PZewMDa70idXZbDNVhjxHCKGTncUHV8EWAn1vh7C3oobF8FDiP743Na7nOVF9a7ZfxoroDHTXID/rr5zubvorT5+CMj5V2scxYOOZlqUUHD3kyZbZ/a3WwnNSVI/154KFlL+BixSyqUHeaagIpqm6ZVHpZLusUB92IMRqeK2O1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602169; c=relaxed/simple;
	bh=LbqydgrP7O1so+HHWyOJFx7TdlbhMpHqBEt3VOrsvKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/dgKIF64jON9KMkRCJiKEGp+eG8Ak0mokIBCGa+1Iuxq7y+dyFpG+FW88rxxy56cthUZyvLyBJhfPAF7gx3rSQcYU2Ur6ETE2P1wRORyukc8j8ZUShy1wht2a+dQ8tFZK9JTzX1Y5i0vfkZUWeK6WgdC/zdbbgnLKHoEMV3anI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+3C9wGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+3C9wGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE581F00893;
	Wed, 16 Sep 2026 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602168;
	bh=OhJ6cB/aj911P1UA/Q0G8oJyMrwQpBuf338bHrmcnCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+3C9wGKnYwmQHpnDwlcIUPhS83A/6+azudpLKmV9I1M22+5IGr0AGzMt8pxuQO2h
	 y6SDt1lBeus3Eft3C4WyE54QjuUB55UW8IWo6Bm3rYO+BvROS1Yt091LnQgKYWTrOM
	 qG7G73F+TNaSq6rgwj7eoD3UWQaLDKJSnRjUM0vB/q4YMZe3zBOUXjz3xFEeAv1Aby
	 oJGYuKD8qAW7qZp861vXkkoaXi0ZDcP/F1YFILB2IHzeLXRSH/YlLK7KzALuAsOtME
	 eQ5aeizGxdN2aVg7idPcGzyCDDxFpq1in/czT/q52PpuxIkKkBoEXox3PYntaKpd0U
	 EjRkJsovdjcUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] bootconfig: Fix integer overflow in initrd size check
Date: Wed, 16 Sep 2026 19:42:46 -0400
Message-ID: <20260916234246.3300108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-latitude-ecosphere-4ce4@gregkh>
References: <2026091616-latitude-ecosphere-4ce4@gregkh>
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
[ Adjusted context to preserve the existing u32 *hdr pointer and le32_to_cpu() header reads. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index 62d8f7610e846..1442f95d6da10 100644
--- a/init/main.c
+++ b/init/main.c
@@ -268,7 +268,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	u32 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -285,16 +286,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 found:
 	hdr = (u32 *)(data - 8);
+	if ((unsigned long)hdr < initrd_start)
+		return NULL;
+
 	size = le32_to_cpu(hdr[0]);
 	csum = le32_to_cpu(hdr[1]);
 
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
@@ -397,12 +408,6 @@ static void __init setup_boot_config(void)
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

