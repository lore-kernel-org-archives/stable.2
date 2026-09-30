Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CD4EDCC3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776095; cv=none; b=BV03PxvWe7bdjq0HbRjKeuK53BzbzxpvTYwQsIa2emRhAcDlCCmbhk08EIHjKq2L7fdtJPn5n9lonIGQPbTkAxB0o/VGwH/bi/MalQz7dZOa4bWI83Y4SyHzpnIc0m00DYSRGUdhRDZNCT9eJz6QXLbabb8bbgWXWkeQN1VJDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776095; c=relaxed/simple;
	bh=ktyYkB1ezgt650xT19nbQ+iV4U1egzwv/6HgGmPwYb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfxRcl9Sl9TwGT7JZPxnN06kZ/BJd73iZ+c4IddaG1guzA5l4XNakTbiFtCml11Q2mXp2b5lmsD+ftNUDJF9X6duFa0yv4lgEs/rkijYOuHffrzB+kP7h6Q50aeqS6JMtvX5y/Srtz77NTJBThJlHDZn3ZtByXMCQbIagyqNK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0PA75W5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0PA75W5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389081F0089B;
	Wed, 30 Sep 2026 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776081;
	bh=QIuqba/8/5PNsWFbiH6yf7E1FTff64f6LEbRQxPPtSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0PA75W5wy7L32yWMU09tVlNDhOwCoyKRwLR3n2A0sanZL41Ge7Nn3vEgjMs/lPpq
	 O5vZfHJHq6GfX7IaU6hnY2BzKuna3gLVhhGKAbU2AxdgP+XFq5+5FsMDLitNChWxBw
	 g2vzriO6/7K9ChPZtDbl0eAo9++hKpB/LGfRc1jMlye5KwS3eVW/zLLaKVAEox5WHB
	 wvYPyTsV9DXIL0uzmf7cVAwcC06G8FkqIGaPBHoHcMbgWvoNNssYMDfM62ctOZ5v2r
	 7ogyTNdIV/bXV/rGIhBNbfYf/OWtjn/tM6B0124V0PwpljD2dBmM3NyS2z8cypK7za
	 3Sxracc67P2Gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/6] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 09:47:54 -0400
Message-ID: <20260930134757.1797371-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930134757.1797371-1-sashal@kernel.org>
References: <2026092938-mantis-spearfish-5a96@gregkh>
 <20260930134757.1797371-1-sashal@kernel.org>
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
index 2dfd6199a10c6..a1f756ea0172a 100644
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

