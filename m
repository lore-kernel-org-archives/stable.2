Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1982F87B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093213; cv=none; b=DquD99tHLuw8S9yZnXPA16SYHw33dTRwpAFCvVotC8mfQmUEkitt3Cm1s9oc4ukMt/wT/SaFRGVJ/Yn7bqYpvpQqW/XTWkZbyWGO49AC8yAvFyYmFDZR5/qqbWsSa4Cp8mpaLqRFfXi9E55WiBh1DexCe0CvPuN0PHYCM9qN1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093213; c=relaxed/simple;
	bh=D855O1T2sLT64KN98vTApZW0xL9D2MGJchhQp84M3Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfvkFrO3BKW6RWbGMF/k/mdGyA6VVjKKyuhb7+x6SyLDSbF7lNl/QlaRQDtQi2STa6rEJzVoRKsDL9a7g/1NgeTNanDq1NYFdf+aKsVTc08woj5ulBiHL1Bk6928XyJIrUiOjzBgOM7qQ8bMTEzEZCFNGIAjW3K9zsEDtdxViNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqVxmwFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqVxmwFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD491F000FF;
	Fri, 11 Sep 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093212;
	bh=Ayikjz/wVXdq3L5cv1iLEAPVLAROFvRbgqL1TKFD18s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqVxmwFNN47qbu//OeOBD96AUmIUMR27Se1RfYeET/stvoOBI4R1P7QT/Xy5RR14Z
	 joA0dAfoJDBGTGJ2SOJ5Vw7jkudklul8CP5mpPTFooodI+e21IjqCpytUzuyPfFoeB
	 h6zSaKUEuUZXO9gCL3zSwcgs8EesgvDhH/t8/z/1vK60T0iAJiJPq32ZEZ9N7GInnd
	 mNDv5LymWLbD3tgvrQ9mpxasV0EFaxXL638wvdRxSS7V8x9E2AOIXhxF2+r3dddK6g
	 GmtM5c/aHa5dn2X6TgsbNAT/31OOwzhPnv4odvu4kCZ0RFlgiFDCtLsZA09JPX7cbI
	 5J+7ju8+Hur5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] powerpc/kexec: move *_memory_ranges functions to ranges.c
Date: Thu, 10 Sep 2026 22:20:09 -0400
Message-ID: <20260911022010.51146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090925-sliceable-cold-552f@gregkh>
References: <2026090925-sliceable-cold-552f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit f5f0da5a7b18fab383bac92044fd8f4f288c9d38 ]

Move the following functions form kexec/{file_load_64.c => ranges.c} and
make them public so that components other than KEXEC_FILE can also use
these functions.
1. get_exclude_memory_ranges
2. get_reserved_memory_ranges
3. get_crash_memory_ranges
4. get_usable_memory_ranges

Later in the series get_crash_memory_ranges function is utilized for
in-kernel updates to kdump image during CPU/Memory hotplug or
online/offline events for both kexec_load and kexec_file_load syscalls.

Since the above functions are moved to ranges.c, some of the helper
functions in ranges.c are no longer required to be public. Mark them as
static and removed them from kexec_ranges.h header file.

Finally, remove the CONFIG_KEXEC_FILE build dependency for range.c
because it is required for other config, such as CONFIG_CRASH_DUMP.

No functional changes are intended.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240326055413.186534-4-sourabhjain@linux.ibm.com

[Stable dependency adaptation for fa40f9dbdd4af53e7445d9135b5b207eb8adf372:
Keep only the linux/memblock.h and linux/crash_core.h include additions in
ranges.c. The target inserts linux/minmax.h between these headers; without
them its header hunk conflicts, while its range-merging fix already merges
cleanly with the stable implementation.

Drop the helper moves, visibility changes, and build-rule changes. This
stable tree predates the KEXEC_FILE/CRASH_DUMP split and keeps crash_mem
under CONFIG_KEXEC_FILE, so importing the broader refactor is unnecessary
for this fix. Retain the existing functions and configuration dependencies.
No functions or runtime behavior are added by this dependency.]

[ sashal: Reduced backport -- upstream f5f0da5a7b18f touches 4 file(s), this
  backport carries 1. Not backported here:
  arch/powerpc/include/asm/kexec_ranges.h
  arch/powerpc/kexec/file_load_64.c
  arch/powerpc/kexec/Makefile
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: fa40f9dbdd4a ("powerpc/kexec_file: Prevent kexec range truncation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kexec/ranges.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 6b81c852feaba..4a3ac17263c8c 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -20,6 +20,8 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
+#include <linux/crash_core.h>
 #include <asm/sections.h>
 #include <asm/kexec_ranges.h>
 
-- 
2.53.0

