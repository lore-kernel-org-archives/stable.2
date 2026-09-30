Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B651DAFA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789650; cv=none; b=scaSrCgenezB2JznQ+h+yAecKvh2LQOzFg1+cQ0PiclbdxzQv13bUUq09c7Zc+GFkUIRJv+xPDDlF0RJE/DFa3rY8ltgAFIkLkUtcCFHgpbeq1fRradvfDeXMGp9Bt6x7xpdktKNBWd0vLpOHN8a8LQQyTwLhcP4v9f4DXSHtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789650; c=relaxed/simple;
	bh=ggtNLHiLU/pgzx4eCqO5r2bXpvUh3oboMtKLwdkAMaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw2JMW6ndHu9TVrirb0EzuPYROLH6IgTkMoUA8Kcff1mxhrwF2KTfLofKjopeqfK0C1WI2tO3p71Fk4AF9+koTCrxpQ1Cg3Zmh2jf/251P/dBu0/LWx+Y+qT+EHtrX34wHJZJ+zp3YNWKo5+yDLFIF29Dcf28X26oC45PaU1de4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmKpXNHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmKpXNHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EBC1F000FF;
	Wed, 30 Sep 2026 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789648;
	bh=UN2obVez/K8SLFbYb4MD9OoCXl908bv4LFUSJXnluWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MmKpXNHeTrMzOfGrkqiuLF1/bYdewT5hp/n9MdzjBf+xaNL+NjgFtAiL5JVFSBbGr
	 9TXd9T0YwPbpcIsRxrehLjfaGn8wn2ZUqiSSZNcWeVxvYBdqRU0rARIwLx8PuTDV/H
	 UCtS66jdfiKSTYEEfgYzOGyG3RCWE4ni4cYMpOaG+KguTUu0S7YvIXiT1DbZxzIz71
	 eJP5Aq6vSmKbJnW+kvRqaEmdRq7nlety5Rx4xZSpQfG7EfSIs/0WdEyh94HPsbHlB9
	 4cQmSvszr+cd4M0dtZlrBPj6rAT0Jor8XTvMPMPoHKzgW2vl9KASSmMMhm4C8najKK
	 gCem6iHgIzEsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 13:34:02 -0400
Message-ID: <20260930173405.3642305-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173405.3642305-1-sashal@kernel.org>
References: <2026092946-ahoy-spring-2e69@gregkh>
 <20260930173405.3642305-1-sashal@kernel.org>
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
index 2f76afa2f138a..bdea7ef89f402 100644
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

