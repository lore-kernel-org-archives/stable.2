Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFD3C1D4A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598809; cv=none; b=mQwflPJEXGGWxA5yXcWhsTvix2s8hWzTS6pwATsjPtWz83ADUqwAuUK88F2gHvhHN6jfMYDOXRJSw7b9+eX7wR8+E8urwYMKxHqGpxi3ptzA0hqGQb8rNCH/PF69ZuaJUZeypcy4dYUyTwwny7mPa2hX9k6dmaAg9r12SDS+HUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598809; c=relaxed/simple;
	bh=9yJasCiYaRf7RJYnO5TkFG76S9z43HiaKHxgBny6iAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUEEr0BW6w6EEhwdvbao7xNfDIO2c7rk5rlpTNLsiH/I66m4H8v4D1ujSvOB136n5+fdDtHu+ZXeBwC31kiJWNLhVzwxhj5SH9WAFsXzuqnzGMgdb93tfCaHiVQKQEVNebzcnDGccUKDdyIofFlBPAqzjqj5zTR+htW97UfembI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqsuMymw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqsuMymw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7BB1F00899;
	Wed, 16 Sep 2026 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598803;
	bh=r6tUTEF5Sseky+tuDAtG16hbjlRhXN7vuVi9VvJ++As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqsuMymwt5rxOqqChYiEzh0m7znhBf4QCrCgTyp/UEApp0oahC4drdTsSe5awEmM3
	 baz68s92zs17JOt8kVfQhd3XPCsuZk5Sqe4VSibz+s9j9qBN1D7wY3kpG12BK58+8f
	 rZVRUA8A+rmPLtY5HJPdcEbmfXySOxlU6CS527f9Xm0CSilUYFLIJKYY1nfsSfw2wB
	 CleJfTRBowX9skn2hUL+V3hzlTdLGRK1KgSvXYSGiu/dv+6BpGxsbkIAWFvo/ZpfDE
	 W9wocSiaA9gIVhHUo5XikLyk4PP+6vvwmE+at2BxmH90FjAz1JqqTICszUHDg1CAmZ
	 sV4V9BqagzlMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] bootconfig: Fix integer overflow in initrd size check
Date: Wed, 16 Sep 2026 18:46:41 -0400
Message-ID: <20260916224641.3199092-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091616-ricotta-character-82bc@gregkh>
References: <2026091616-ricotta-character-82bc@gregkh>
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
index df9db4d47868a..638e16048cc3c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -270,7 +270,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	u32 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -287,16 +288,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
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
@@ -399,12 +410,6 @@ static void __init setup_boot_config(void)
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

