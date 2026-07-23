Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0E339396
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816364; cv=none; b=idvSWqRMvcc4JBGJo+QuomnQ1KLjc44n2h49ts9QpFmZkfRPepEApdSPC2WBcmqKI4vGUYOz6YUGLlK+Sk5MwE9+Ne9PDPSjXWVZRamF7lO6H+gKCGPYhXYHsQQNdFn9ZfJU7HmdN4wQ3Sn7pYZYEQ9LVELLrKqzPgrTCEjfOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816364; c=relaxed/simple;
	bh=VT5dU6yTEXa2grVn9xyj71bXmQlrm5IpPcH4vual9kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAYjqmXrdUz2qPitEg9Eypl6kdyAF1ferpZa00FfOVxsioOHbjQUhTCZJnfC/k0fI9vKUMbXwBgbwzAQF14mcrYzwFp69R+dlrRdFfs8GvEAUaPvqouOqSVQVGROPhOKJXBgfWQmEcpBSFm7Olc0KpWt4UXpxbytC7Bg7Vh6iYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C9C1F000E9;
	Thu, 23 Jul 2026 14:19:20 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] s390/cpum_cf: move cpum_cf_ctrset_size()
Date: Thu, 23 Jul 2026 10:19:00 -0400
Message-ID: <20260723141904.3218096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072026-chess-imitate-9c14@gregkh>
References: <2026072026-chess-imitate-9c14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 345d2a4dcdb7d0f33ebd990a19aeb3f3f458817d ]

Function cpum_cf_ctrset_size() is defined in one source file and the
only user is in another source file. Move this function to the source
file where it is used and remove its prototype from the header file.
No functional change.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 49145bce5391 ("s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/cpu_mcf.h        |  2 --
 arch/s390/kernel/perf_cpum_cf.c        | 47 ++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_cf_common.c | 46 -------------------------
 3 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/s390/include/asm/cpu_mcf.h b/arch/s390/include/asm/cpu_mcf.h
index f87a4788c19c8e..387e169597b065 100644
--- a/arch/s390/include/asm/cpu_mcf.h
+++ b/arch/s390/include/asm/cpu_mcf.h
@@ -105,8 +105,6 @@ static inline int stccm_avail(void)
 	return test_facility(142);
 }
 
-size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
-			   struct cpumf_ctr_info *info);
 int cfset_online_cpu(unsigned int cpu);
 int cfset_offline_cpu(unsigned int cpu);
 #endif /* _ASM_S390_CPU_MCF_H */
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index c74b047eda19b8..0e53df6d107215 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -112,6 +112,53 @@ static void cfdiag_trailer(struct cf_trailer_entry *te)
 	te->timestamp = get_tod_clock_fast();
 }
 
+/*
+ * Return the maximum possible counter set size (in number of 8 byte counters)
+ * depending on type and model number.
+ */
+static size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
+				  struct cpumf_ctr_info *info)
+{
+	size_t ctrset_size = 0;
+
+	switch (ctrset) {
+	case CPUMF_CTR_SET_BASIC:
+		if (info->cfvn >= 1)
+			ctrset_size = 6;
+		break;
+	case CPUMF_CTR_SET_USER:
+		if (info->cfvn == 1)
+			ctrset_size = 6;
+		else if (info->cfvn >= 3)
+			ctrset_size = 2;
+		break;
+	case CPUMF_CTR_SET_CRYPTO:
+		if (info->csvn >= 1 && info->csvn <= 5)
+			ctrset_size = 16;
+		else if (info->csvn == 6 || info->csvn == 7)
+			ctrset_size = 20;
+		break;
+	case CPUMF_CTR_SET_EXT:
+		if (info->csvn == 1)
+			ctrset_size = 32;
+		else if (info->csvn == 2)
+			ctrset_size = 48;
+		else if (info->csvn >= 3 && info->csvn <= 5)
+			ctrset_size = 128;
+		else if (info->csvn == 6 || info->csvn == 7)
+			ctrset_size = 160;
+		break;
+	case CPUMF_CTR_SET_MT_DIAG:
+		if (info->csvn > 3)
+			ctrset_size = 48;
+		break;
+	case CPUMF_CTR_SET_MAX:
+		break;
+	}
+
+	return ctrset_size;
+}
+
 /* Read a counter set. The counter set number determines the counter set and
  * the CPUM-CF first and second version number determine the number of
  * available counters in each counter set.
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 8ee48672233f74..4824e3461b5b3b 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -156,52 +156,6 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
 	return cpum_cf_setup(cpu, PMC_RELEASE);
 }
 
-/* Return the maximum possible counter set size (in number of 8 byte counters)
- * depending on type and model number.
- */
-size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
-			   struct cpumf_ctr_info *info)
-{
-	size_t ctrset_size = 0;
-
-	switch (ctrset) {
-	case CPUMF_CTR_SET_BASIC:
-		if (info->cfvn >= 1)
-			ctrset_size = 6;
-		break;
-	case CPUMF_CTR_SET_USER:
-		if (info->cfvn == 1)
-			ctrset_size = 6;
-		else if (info->cfvn >= 3)
-			ctrset_size = 2;
-		break;
-	case CPUMF_CTR_SET_CRYPTO:
-		if (info->csvn >= 1 && info->csvn <= 5)
-			ctrset_size = 16;
-		else if (info->csvn == 6 || info->csvn == 7)
-			ctrset_size = 20;
-		break;
-	case CPUMF_CTR_SET_EXT:
-		if (info->csvn == 1)
-			ctrset_size = 32;
-		else if (info->csvn == 2)
-			ctrset_size = 48;
-		else if (info->csvn >= 3 && info->csvn <= 5)
-			ctrset_size = 128;
-		else if (info->csvn == 6 || info->csvn == 7)
-			ctrset_size = 160;
-		break;
-	case CPUMF_CTR_SET_MT_DIAG:
-		if (info->csvn > 3)
-			ctrset_size = 48;
-		break;
-	case CPUMF_CTR_SET_MAX:
-		break;
-	}
-
-	return ctrset_size;
-}
-
 static int __init cpum_cf_init(void)
 {
 	int rc;
-- 
2.53.0

