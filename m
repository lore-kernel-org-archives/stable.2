Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B4FD267
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782781; cv=none; b=bnyxw6X1aUVrTGDP95KDm4aNU5ezKBsnU82ATTKhc652fjHZQagrUeZCMrXCsEDCuEIhZnWGkeh1B85UhP/oLYKip5qHP15YRJFV1eXiRDRPmMh+u1pX2aGQT7YoTb8WKVmAkkmU9KPihAalj+GX3WMvYRK2V2En3i5a/C+5nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782781; c=relaxed/simple;
	bh=LvjzvtfJjg9fJTVFTMi5qSL01MzhQiYHR9Mj0xQ/LD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HykDr5TjbgLfiXVBmp1hVCjUM7suWnx6f74x4HukPL/irVTNj7YMQqMHHuEuMW0uIm/uKaTg/FaR6i/qFT1EMuHtuERwqxnYqkOZ/SRfZX6LweV5hwE8abFCMl3+gwB7B0kPoGxQR9lYc1s203JWdj+BhIjPLwo5BaGJRObeueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIAvb5Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIAvb5Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B97D1F000FF;
	Wed, 30 Sep 2026 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782777;
	bh=ogHtbTBiOG1Itn6pXqQLM1Ldwdw8NIVoJEudUm2BkAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIAvb5DqvNifS/OdDPAS6b5285FtMF1aiIwu/OUV3KgbJGBsWxu/RPxezKirE6jr3
	 yH1TT95MwyVdNHMpkspT/RnpLfL5YwdMcMExIDuj7cyg2CiO4Qf+lewvCqVLa3caWU
	 RuBUdFNXWxzeF/F7rEzjAdRT9EI63uo4c5+R/Nu29eD75lefNEfy0ae+621v2oiC5h
	 VLE4bfF3UVRSunB0RJheDhIM5yMA0XmrmPHmSrQtmwMlAGIYLjJzShj/E3TMIypb0h
	 tVkHEsq2802B891juKser1GbK2EZS22C5wEZ4UgE75XOcumsjYw9sgUm8J8TSfk4pd
	 5qh3XsmLZYQ5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 11:39:31 -0400
Message-ID: <20260930153934.2895211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092938-celibate-sarcastic-e56f@gregkh>
References: <2026092938-celibate-sarcastic-e56f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 35fdfa632e7cf8271189c7ae6f97e7c4b55f7f80 ]

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 7 -------
 arch/x86/kvm/tss.h              | 7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 03866683ac336..0008a3c4fc452 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2350,13 +2350,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
 	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
 }
 
-#define TSS_IOPB_BASE_OFFSET 0x66
-#define TSS_BASE_SIZE 0x68
-#define TSS_IOPB_SIZE (65536 / 8)
-#define TSS_REDIRECTION_SIZE (256 / 8)
-#define RMODE_TSS_SIZE							\
-	(TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
-
 enum {
 	TASK_SWITCH_CALL = 0,
 	TASK_SWITCH_IRET = 1,
diff --git a/arch/x86/kvm/tss.h b/arch/x86/kvm/tss.h
index 3f9150125e701..117bf8bec07dc 100644
--- a/arch/x86/kvm/tss.h
+++ b/arch/x86/kvm/tss.h
@@ -57,4 +57,11 @@ struct tss_segment_16 {
 	u16 ldt;
 };
 
+#define TSS_IOPB_BASE_OFFSET 0x66
+#define TSS_BASE_SIZE 0x68
+#define TSS_IOPB_SIZE (65536 / 8)
+#define TSS_REDIRECTION_SIZE (256 / 8)
+#define RMODE_TSS_SIZE							\
+	(TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
+
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f65081330c8a4..6b51f352d2826 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -71,6 +71,7 @@
 #include "x86.h"
 #include "x86_ops.h"
 #include "smm.h"
+#include "tss.h"
 #include "vmx_onhyperv.h"
 #include "posted_intr.h"
 
-- 
2.53.0

