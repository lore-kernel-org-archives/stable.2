Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F717DFFA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093852; cv=none; b=s8ftCXTOACY1Nt9vi6nkVEdEFSvdPBswcXkr4tycCJYoPZfshzdYB5JrEi09Oiigxa1p4QZ/+YarRXOcsZ8l3Ldi+iL1NUAJ2HZh84NZvuRRCFy2U9elaJbuKTVKpYa+SALVK6NQ2BK8EAwE1BIiDIcFW1BMcMTZ3vItlLAGnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093852; c=relaxed/simple;
	bh=jgFIa31waZKo4ePRUgWArCHnqOoKapTM2eo+ZmkuOOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkt2ZpPDLV1GA7QC4RZ/0CY5Cx7jTbOO1TfVEYts2S6dwPIa/yfGABx0tNk0Q78eYhM/Fn6mLQ1joT21a0FWhgWe70JZ7vKAeWYTwlBJZ9tvnPSjzFxfe2rhOcawIyTqWOTGwBqbVV8nUjRaR5Ty1vablpU/bquFLMw0j4s5MT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0+aUslH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0+aUslH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5771F00898;
	Fri, 11 Sep 2026 02:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093851;
	bh=BYIKteZuQAJNen7OvbX9ucRSrjc6OfnAcL8/eZJfwbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0+aUslHfUJ7BcyzNUpKRzSH8/0RvhsxacAG6tWmIhqLsWEpeoyfBKlaDObK2Z0tj
	 NB7hPOWCxbMxCBQ0CBVQGqH5TZ8JtAiZF515gNEBQ0KXTY+zJtO4SrzRSgHVbL7FnX
	 gpez5QB1u9KO5IHRLB1uMt8PZxMI7mrnqOvicerGNuLLRXTpsUPLAn92UiQHLl3Rh0
	 S3T3doRUohjPVYR8XdiRRxVHUa0zdj3g6flEFPMYw36H1tilqqxs+cdiwy+UxdUaDI
	 C+w6Vy+dRbrfKmjgC/9at3ZLl4ASkLFvOuVzo9Ft7tDKU6w4JeLkYEvFpNgEv1vfXs
	 w28W3sNDK77Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] powerpc/kexec_file: Prevent kexec range truncation
Date: Thu, 10 Sep 2026 22:30:48 -0400
Message-ID: <20260911023048.75314-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911023048.75314-1-sashal@kernel.org>
References: <2026090926-voltage-around-ae2b@gregkh>
 <20260911023048.75314-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit fa40f9dbdd4af53e7445d9135b5b207eb8adf372 ]

Sashiko AI review pointed out the following issue.

The __merge_memory_ranges() function incorrectly handles overlapping
memory ranges when merging them. Although sort_memory_ranges() sorts all
ranges by their start address in ascending order beforehand, the merge
logic remains defective in two ways:

1. It compares the current range's start against the previous element (i-1)
   instead of the running target index (idx)

2. It unconditionally overwrites 'ranges[idx].end' with 'ranges[i].end'.

This logic flaw leads to critical memory truncation when a larger memory
range completely subsumes subsequent smaller ranges.

For example, consider a sorted input array with three ranges:
  Range A (idx=0): [0x1000 - 0x9000]
  Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
  Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)

1. When i=1 (Range B):
   ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
   The code executes: ranges[0].end = ranges[1].end, which erroneously
   shrinks Range A's end from 0x9000 down to 0x5000.

2. When i=2 (Range C):
   ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
   The code falls into the else block, creating a broken new range.

As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 - 0x9000]
are completely lost from the kexec exclude lists, potentially allowing
the crash kernel to overwrite active memory, causing data corruption
or crashes.

Fix this by ensuring the start of the current range is compared against the
end of the active merged range (idx), and use max() to safely prevent the
outer boundary from being truncated.

Cc: stable@vger.kernel.org
Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for getting memory ranges")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260729012948.2797865-4-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kexec/ranges.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 4a3ac17263c8c..975b522f0d6aa 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/crash_core.h>
 #include <asm/sections.h>
 #include <asm/kexec_ranges.h>
@@ -103,19 +104,16 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 	struct crash_mem_range *ranges;
 	int i, idx;
 
-	if (!mem_rngs)
+	if (!mem_rngs || mem_rngs->nr_ranges <= 1)
 		return;
 
 	idx = 0;
-	ranges = &(mem_rngs->ranges[0]);
+	ranges = mem_rngs->ranges;
 	for (i = 1; i < mem_rngs->nr_ranges; i++) {
-		if (ranges[i].start <= (ranges[i-1].end + 1))
-			ranges[idx].end = ranges[i].end;
+		if (ranges[i].start <= (ranges[idx].end + 1))
+			ranges[idx].end = max(ranges[idx].end, ranges[i].end);
 		else {
 			idx++;
-			if (i == idx)
-				continue;
-
 			ranges[idx] = ranges[i];
 		}
 	}
-- 
2.53.0

