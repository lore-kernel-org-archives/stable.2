Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D03F54AE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781011; cv=none; b=Ylphs4wEB+wWJOIsFUrl27yMO+A6f1g501GYXByyV+kj4Xj/desYF1gAWl799jELAamQaqMe/d/szMexTI6w3J0dJrPOV8jP9qcUltPKR4M2K8dpSRTSDYWdgUBjRL56mNLV5+lAOzccNbW66v1puxqnMXTjGjm6wVXZj5IXtVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781011; c=relaxed/simple;
	bh=WX8AwCKwu9xIRsCC66SD8mgSeAWrftZJk3NbPzOydRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEJhKv4WRxvwQQr92iCTiI0mNYTkCR4qONaFbaa2rNpoRaVCYSAE2ML78BIBrAv8H6Z8wNIUbpm12F8Juztb9ZNJX9FIepKCjay+jnsId/o2fTKg770KMYAkDbh0m+sgYD6G+Gq8KInBCH14QfNMKYZKWM4AJ+GUqPiLA84RGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGmdgSJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGmdgSJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77201F0089B;
	Wed, 30 Sep 2026 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781000;
	bh=ThZ/5z+CgqM7AqoEcKq418rWaR+rhoezIFM35AtUmag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eGmdgSJLgxKLfOuldpcD6fJA7LHNcioAEGfW6N81kaKYNfOK55v/39lNrN7utEzAr
	 SveXZRTN6WXQIjMyebLMLouNwCJ/9W5MQ42b4J9OKG1gzg/Tu4mJA7oM85MMeWcmhb
	 RF/EI9DP7blG+F/x1brRVRixsFe5H4RFKQwBqxxaw8RprsN8xr1mWlM+FM8sx6+klU
	 WD+CtpvzOJYK4ki5mLgsTBUUpIEl3PiaxRSxO90IOP7lIl25sgCjhOpwq/NmAG8o+t
	 3H16rQ3wKtfH/1Un4j0kh4467rPTmFEs56rE6g854JS7ltqwa48apRlIVsslzSWrzo
	 aOeeGr/pQ5Xaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 11:09:54 -0400
Message-ID: <20260930150957.2359214-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930150957.2359214-1-sashal@kernel.org>
References: <2026092945-breath-candle-8e2c@gregkh>
 <20260930150957.2359214-1-sashal@kernel.org>
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
index 5f1ed8f88ec7c..1f2dabd7dbc92 100644
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

