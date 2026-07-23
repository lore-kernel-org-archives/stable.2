Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7641D22F
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816366; cv=none; b=mYfARXsB75iG/5rBEXfcXe8Cw6lb8q+bXiN2uRUd/DX0Nqj2U19TJHZwyKxtWaZeoMFD48zCJGAGfDVrie2fdl6DD0xjnCViSnMoaVBQ8r7rUm2CMEHifgxW+xPavA6ocBxK+Awzq0ohmbGXlcPcE4ZxNKgtQWFpsfAqCIJQjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816366; c=relaxed/simple;
	bh=jE/au4W3OQKrW0T8lKkZ2R23mMOBVfh/yh8yTTbfqAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ/QidSpQyD63YRfikZxd8dBkd5CM/SfikxPjxx85+9KOn9bsxSEMSz7qEcEgr8jye68KdnzAMKBRnQM3lwPRBvmGSWiqgwcQBZ9M+ihmE7T/VOQKwToJCL7iAx+IJ0ZqKBMdAQjm4NUu6rnrdehkjnA8WjbfypEqiqquiYpnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0DC1F00A3D;
	Thu, 23 Jul 2026 14:19:21 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] s390/cpum_cf: move stccm_avail()
Date: Thu, 23 Jul 2026 10:19:01 -0400
Message-ID: <20260723141904.3218096-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141904.3218096-1-sashal@kernel.org>
References: <2026072026-chess-imitate-9c14@gregkh>
 <20260723141904.3218096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 7a8f09ac1850b17ca0cc9e1e4d6621a64661347e ]

Function stccm_avail() is defined in a header file and the
only user is one single source file. Move this function to the source
file where it is also used and remove it from the header file.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 49145bce5391 ("s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/cpu_mcf.h | 6 ------
 arch/s390/kernel/perf_cpum_cf.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mcf.h b/arch/s390/include/asm/cpu_mcf.h
index 387e169597b065..4b29c31c0e0435 100644
--- a/arch/s390/include/asm/cpu_mcf.h
+++ b/arch/s390/include/asm/cpu_mcf.h
@@ -99,12 +99,6 @@ static inline void kernel_cpumcf_end(void)
 	preempt_enable();
 }
 
-/* Return true if store counter set multiple instruction is available */
-static inline int stccm_avail(void)
-{
-	return test_facility(142);
-}
-
 int cfset_online_cpu(unsigned int cpu);
 int cfset_offline_cpu(unsigned int cpu);
 #endif /* _ASM_S390_CPU_MCF_H */
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 0e53df6d107215..3e6c46d9cd0851 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -821,6 +821,12 @@ static struct pmu cpumf_pmu = {
 	.read	      = cpumf_pmu_read,
 };
 
+/* Return true if store counter set multiple instruction is available */
+static inline int stccm_avail(void)
+{
+	return test_facility(142);
+}
+
 static int cfset_init(void);
 static int __init cpumf_pmu_init(void)
 {
-- 
2.53.0

