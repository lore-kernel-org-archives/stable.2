Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1651DB07
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789646; cv=none; b=Kqn4Mcb6n3mC1Ixlz9Q7BclpFNO5qwBVrkz5iexz/nn2yEuOcQiRCbYThDLE+lj/h+ePGRKqq5vZ4b5ZI6RHJI8pLz3HNLze6a20gRgxGqhuyuXbkws+kMLuYiuQTnsCf8JGpCB58v8+yHWS1+9LCvAyJzHcPFntLppDAMuib5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789646; c=relaxed/simple;
	bh=RnOVzFLiB+298MwAQY2q4kt46pou0/mlphcj2eQfK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp4Mvk7VcXsRm1L5DdG2ZLtkNKEzcnJjm5Aqk4Jpck8j1y/yOsK8PLOK/XhcBnAx6p0mxC3PbwKGguL5uk0whhA3T8807Zh4XTc1l0zfj+swfm2ua5Xw6EoqZDTXNl5avO+kjnthiYqThzGtQDQYXdZaRTjobyGw4qtQqQaHOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deBmoWpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deBmoWpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053631F00898;
	Wed, 30 Sep 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789644;
	bh=0Ju5BgPCERrGAXyhpxcLW7X6jISbABwnBrVEoO0s+Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deBmoWplPQzP/DtHhROBEM8kTqLPXiw8xT2vzVlcQ9oOd9SiPZtxIhUvbUvd64uAC
	 a0zjAMYNzfAn1XrZIZDiojbLGT5Hv9xSLPJF14OQbNsOn8yJuFy0akgDaRtLz3SR97
	 OBbJTToFCYwJQGiANMSpx6Y5U8L4pxJhaBgNlj7AFo9aQcEJhvwptGopMxLH+2i+fr
	 NyNsT2GmVWhcGQKiQkJm7Qhz+hQssv9i8IxOWGr2UHoIThOax7Em175e2DFezCtWrm
	 lvYCxOXkDRSxISBo3cKjZOSHSkc2oLGvsjTqLVzQZ5G0Pol0BcEyd6C94BECHrYgjr
	 rijpQ2dIu7MHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 13:33:59 -0400
Message-ID: <20260930173402.3642110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092939-nearness-debtor-eebf@gregkh>
References: <2026092939-nearness-debtor-eebf@gregkh>
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
index bb04de781b69d..12a7afe2518b6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2259,13 +2259,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
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
index 84420bfbcb1bd..adf41ef4a1d67 100644
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

