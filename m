Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B33CF698
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093215; cv=none; b=oUqBraJs85v6qFFdlRKJ2DBYO8dlFdAODOJTC0WiMFS6ElTRCIY/cSDiLrdHiXeHZKyCyk/XqD/boQJZt09ySHwVLE8oPbbxOoLSxsmlGaVZh0Xq0AeHEKy6GUCCrYRuFG+6D7GiL4Xkrlf7u6AwZRXwxaWXnxMkrzJw6qQhJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093215; c=relaxed/simple;
	bh=jgFIa31waZKo4ePRUgWArCHnqOoKapTM2eo+ZmkuOOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOpJx/T0sgN1xieb7FBaGzbxuRb1qB9PXjjSBfNVdJ9t5olcUaQX/qsGW4g2hPegwK26lYK+HUgfBDXBSqs0Qsu8c7UXBYrGu+CK4VAXu2dkQ012lYYC/zFzFzm4ENa4Q6XX3Qzcr5zk2YGnIxpLCMTrlEHYavhu4vA9P5SXVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgt7DFvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgt7DFvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEC1F00893;
	Fri, 11 Sep 2026 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093213;
	bh=BYIKteZuQAJNen7OvbX9ucRSrjc6OfnAcL8/eZJfwbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mgt7DFvdolV1BYRl7/o9cM2SCB9QahOA/UJX6dcivpooXlA5Kubgpb8uzos80vVlP
	 0RgRGeTDDCg33r6UWYsi9qGPy3oIyv0q1eED91Fyp4hAlcDxFrfxrWCrtRwUikNUDC
	 lMUgGLOLEiOK63k/e9Xlt1N+o/IfwGFqGje57CiF4uhbfvtzbez2GyPQlQjmdcoq/x
	 6CLS1YCjaWlyE6fe5bzL0sT7rjaIkFHLiKKl2xCJlR+14V64+Sv46JWp5KBrCxS+3h
	 zQQggYzNqAKvcgAovQuyUSaOtqBs8K9ha1oPgSeZNqzyGZJSA75mdrrq53JSzoJbbg
	 UxpdwVJasBhiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] powerpc/kexec_file: Prevent kexec range truncation
Date: Thu, 10 Sep 2026 22:20:10 -0400
Message-ID: <20260911022010.51146-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911022010.51146-1-sashal@kernel.org>
References: <2026090925-sliceable-cold-552f@gregkh>
 <20260911022010.51146-1-sashal@kernel.org>
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

