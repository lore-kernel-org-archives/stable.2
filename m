Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF541F5D8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586900; cv=none; b=i3WWl3J2FTCe1AAuBT1EGuzKLuWJ2KzBKTOLIc54BytyPPfVTck3Agccaz1W3QzHBOp6dfxwiQNtBf2P3OlGqIJSVRkHdiHx3G5p31tn9SgK0H7OZxufua4YrZVhMfBPkmStLI6nD+RkzdMCNBjoooWB6T7hGCBQt6Avu8ZzUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586900; c=relaxed/simple;
	bh=ygcLlKiY99/IWZ1pwJIJf74NDuO8bB0oHW5m8BLR3hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knEAPgJH6wSf3KEZmXXgH1UD75vi7JJ/wImnQ9rrmEIIyt2b1J+PJ4ujicplwonr/Et/d6M4ryMscknAs1GzEMG9abaxeUrkCmMyvZYLzWJZceH9G4pGTfe72OjCFjopvqO/fXqm04AmSJzhkwoe3OObvoDoF3pjq75MvBFn/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQHEhyKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQHEhyKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AB61F00898;
	Wed, 16 Sep 2026 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586878;
	bh=qhd+SiSjhjhfSVSExreugr5LYE9O6U8it5aeT4MOPiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQHEhyKx9fgYtRk0m3kp79laTO3hwKJk5T7vXB6EmDfh+v1Xxe+QP4FjAMSu1dAfa
	 UIGHZ4v1+EXgNM2rR/woAUPzMRinMc3iDGOFQWIiDwOOX9MdO2U8CbyONcnJUFhJtR
	 g+S/hDgEXQlkNR4Az9rDO7+ff+JoQfpO/3RFgTsHgA0OGAPHq27jmL6/J8WmMUWRrg
	 oeP5PAg2CLaW6xiwG4NtLvs9b3iJ+WVOmE3zT4sLpp4ZtHGK9+95vxRwgWqlxcW/SY
	 V7TXyhz7C/vmz9WEJrJlzoIU4cKCpRSCIIgSjqm+ZSoqzhd8qZekZcu2qfqwPhrF/H
	 R1EvoWm6oNVyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] init/main: read bootconfig header with get_unaligned_le32()
Date: Wed, 16 Sep 2026 15:27:54 -0400
Message-ID: <20260916192755.2146743-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-curry-barracuda-b99e@gregkh>
References: <2026091615-curry-barracuda-b99e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit 499f86de4f8c34e19a57daf2b6f0cba848e91994 ]

get_boot_config_from_initrd() scans up to 3 bytes before initrd_end to
handle GRUB 4-byte alignment.  As a result, the bootconfig header
immediately preceding the magic may be unaligned.

Read the size and checksum fields with get_unaligned_le32() instead of
casting to u32 * and using le32_to_cpu(), avoiding potential unaligned
access and silencing sparse "cast to restricted __le32" warnings.

Sparse warnings (gcc + C=1):
  init/main.c:292:16: warning: cast to restricted __le32
  init/main.c:293:16: warning: cast to restricted __le32

No functional change intended.

Link: https://lkml.kernel.org/r/20260113101532.1630770-1-sun.jian.kdev@gmail.com
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7812d6dab069 ("bootconfig: Fix integer overflow in initrd size check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index e3ef1eb34aa3e..b254678062c72 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,6 +104,7 @@
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
+#include <linux/unaligned.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -269,7 +270,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	u32 size, csum;
 	char *data;
-	u32 *hdr;
+	u8 *hdr;
 	int i;
 
 	if (!initrd_end)
@@ -288,9 +289,9 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	return NULL;
 
 found:
-	hdr = (u32 *)(data - 8);
-	size = le32_to_cpu(hdr[0]);
-	csum = le32_to_cpu(hdr[1]);
+	hdr = (u8 *)(data - 8);
+	size = get_unaligned_le32(hdr);
+	csum = get_unaligned_le32(hdr + 4);
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start) {
-- 
2.53.0

