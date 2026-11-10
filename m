Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315640;
	b=o4sPgewGPrmFhW1zRzfFmykGCTr19EM88ePfF9+LwPkA7kVf/z62jL7AQsgeeiSNJXhQ
	 weicLtjagsGVmLNJvcXtcxy5Bb0hySv1dWwu9IN1GtUHitb1Z3WoEEw6xYxfvWbR+8YzP
	 a1m1JQDUOtuRxy+Neh6enKVVL+x37kJ2YTbqa9eBD0xMuqHjX9ZWNjPiFyID6ZGUDRmu+
	 RfNLurTW7cCsDAvBTSAKyCqG83JX3VwNdY+ZlM7Otvh9EOqFj8IesbshQHN2/6H6nO8Uy
	 paP2+wqRiGcMmVBA0zBLF5eNwvbXif6KZaBdLVPY/p9AHocnqkkYFA5iRHDn+cL2WlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iX23rykjprb5aI5vvf55MBNWIn+Yy4tzxs8f8URj+68=;
	b=OM95Iecg1HRpwesI/5F5bmgLWQHpDO7jhZiL6m1K9DpKKHYRkeu3IUOWQ0TdN0CrSlsn
	 f0TQg53oBj/VauSGrWFZ7ozklLFhHFaXgRBNAkOsjtjn2F7zdI7e+AATGagbcFnQZfurC
	 5cTwV8IcwPUcOXlrij5qMASLMysWMpM6zGH4Gzf0IwoWIBRb0XEzVsD+kJfACG23pVyqi
	 Z8MAhDN4qyQ169fjBgonO+iijZ2++ZpYwRkvjvX9JMCm698nRgIZg0pV84pclCXNWa7M1
	 ZluEL+AZfNBq7UbeveGBXvK11PmDvEY0vp272FwadSG+FEn/tyCx+EZNy7uyJHmUjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQMs2TAv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1E606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQMs2TAv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBE71F008A4;
	Tue, 10 Nov 2026 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315639;
	bh=iX23rykjprb5aI5vvf55MBNWIn+Yy4tzxs8f8URj+68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQMs2TAvr8jYeCXfwHiqLeUAn5STxBZcVaXlQ15TlKOL9Vr13dc6Iu7q1G50v9Stv
	 llRaymSqHMto/zSwgFMVO9RKEYusfn0QqM5ig3QsJF9BpygzP0MFYhJbLOw54P0s6H
	 DyGSq9h0SPMQqFuanyt9XnCzL3NnVzNJ2lkgP/+N25D0qE5/9aTv3CoDdlO/Mz05r/
	 x33Go3s+B9yi874PGyDWUxdcDtl0E8NeDIuiMtj7P/jc94N2QNMvakobkQT0OfjQ5m
	 7PBH3I1yLRR3WJlBBs09o9Zge81R8hxi1lW8b5vlxdmGu/1ScQVTqPDnJyQBxgDV1q
	 O6r+z27kHEJEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] kernel.h: move READ/WRITE definitions to <linux/types.h>
Date: Tue, 10 Nov 2026 08:00:35 -0500
Message-ID: <20261110125947.1497852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051756-failed-6.12-56c1d32323e7@kernel.org>
References: <20261107051756-failed-6.12-56c1d32323e7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 4ef5211ee68113070bd42142f06347866675055e ]

Patch series "kernel.h: Move out a couple of macros and constants".

kernel.h hosts a couple of macros and constants that may be better placed.
Do that.  Also add missing documentation.  No functional changes
intended.

This patch (of 2):

Headers shouldn't be forced to include <linux/kernel.h> just to
gain these simple constants.

Link: https://lkml.kernel.org/r/20250324105228.775784-1-andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20250324105228.775784-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 56c1d32323e7 ("hwmon: (tmp102) Fix jiffies wraparound in conversion-ready check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel.h | 4 ----
 include/linux/types.h  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index be2e8c0a187e4..01bb0fac36672 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -41,10 +41,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/types.h b/include/linux/types.h
index f1356a9a5730a..5e997dd8b4bbc 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -135,6 +135,10 @@ typedef s64	ktime_t;
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
+/* generic data direction definitions */
+#define READ			0
+#define WRITE			1
+
 /*
  * The type of an index into the pagecache.
  */
-- 
2.53.0

