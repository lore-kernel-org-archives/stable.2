Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E14DEC0B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774012; cv=none; b=WbpCpAcW7SkdvFbwOywn/X2vjVyi+5SVO3CtqfA08X4swQIR3O31DRY6WI57/E4bf0fSPYNDyg29trSQAoI0N66GIyZurAbO3apmghRjmb1PDfFl53a3X7xJWr56pQBj4EgFEl3TaG7UsoBe3MfP7ToffT1QR0IQHAFmfYgYukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774012; c=relaxed/simple;
	bh=UcEFCW5p7zScJCfC0M5hyvQ388AmUUX/XnrcDa/4kp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf4nXuvdX+ZoWzaNrumY7pHn7eg126fjdi3yLwfXAj3NRwoeBKeRvhrXch4wqPyy6VN7avoIWxzzcjmcHLHwNS/FiU3rf35LTVD7hKQlpm6K6pQeuHUJX8sWxedrdnF3ocB3c6/hs4PlriWZw8cUXX7YzNPZbNyFqcufxerbO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmUGG7zC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmUGG7zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C191F0089C;
	Wed, 30 Sep 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773981;
	bh=GJUa+kOL98z2f0+t/asgPIOqzwsHbGASneQKVZu3CF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XmUGG7zC/QBnwUhY5saJTXdCIaiSOtpfsHX27kyFeuKM2znjHjcerl+eUqJITE2Qx
	 BGMOUcxvByPSPGTmkDdkBeRh8vaVcdmAdd8RRRbEWUeRFgQpkOC//EAn5GBM5ekoYl
	 STcnzHM/19i7Y5L+IdB9wpeB2I0HkbmsoYlzR6tGWJqsiCMWsdM46viIvGGtcSVf1d
	 0bowAGqgHkZikp+a1AgsJ9Orx+BLkGSP0QXCScJDn0yzv9etjLQRiY6wTaF5azTK1G
	 NeHFvLel8YkXWUoUKva36ZTkS0G03d/g72hV5/1SHV/tq4Auy5C5VTL5p4UJFQynaL
	 806LtL+b72kvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/8] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 09:12:52 -0400
Message-ID: <20260930131256.1728861-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930131256.1728861-1-sashal@kernel.org>
References: <2026092945-unzip-pluck-7c40@gregkh>
 <20260930131256.1728861-1-sashal@kernel.org>
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
Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 7 -------
 arch/x86/kvm/tss.h              | 7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a89beb6f8eade..0da2268800f6c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2433,13 +2433,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
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
index b8d745f6fd221..8b75c70e60d26 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -72,6 +72,7 @@
 #include "x86.h"
 #include "x86_ops.h"
 #include "smm.h"
+#include "tss.h"
 #include "vmx_onhyperv.h"
 #include "vmenter.h"
 #include "posted_intr.h"
-- 
2.53.0

