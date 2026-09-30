Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B83BD22C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795719; cv=none; b=RZKNbH7U3Jj8SFdZDLnNQcN2Z0W2tLyn8dlOn/WoejHdVYNyTJYlWIMsMVDyo2WP2jLi1QYXORRODJc/LYtHqKO1Dl+gKsqkTtHo0Uvfsxom2W4tZoy2qa0Z2YCQi396AzFK/peFdx0R6h8U0wMf/YFqz26OgcfRgqvWrn0aqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795719; c=relaxed/simple;
	bh=H6yu28l3vrAYhuvZW8Ap+accefkeBnFb6NR5wYXZxCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9YdCeGfRL9DzEN/yKFWhy3GpgT8/l4lBDz94jcH/4Zjl8KqNuLV2I4DJ7+aPt4Pk9jtnrJt7Plj+eRYw8twXH3L/v0LclTzcKLgpQFf3Q5iJRY2WusQUffjMiIS8Y9lNtEVBjlB46ceAqTCI5ThTKs2GMGPs+b08s7bUuKquGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DotAxgeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DotAxgeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE8D1F00898;
	Wed, 30 Sep 2026 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795718;
	bh=Tv0bUWewcHN6buOpjFfJrmZspqsS6Q3HtlgmS/Ev0sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DotAxgeBN9ayyzVgh4SB22jM5k6oPJdixE2Gcpdr2qNBsO5PkZJDL7QdJOasoka2m
	 r++vSNcGyvYYowlMKB81W63i9Pia+10mi4Kk4l76mAbSG00Jhuytfh4MPwpY/lpwBz
	 nPKV5oAqTC7Nib78+nSiynKdBfQgam3Y01+fTvz/J/WEMEMKqAoyHF6xImkBl1fJD9
	 dycpEhxY84gyBh6p965lDxyEUitf+SCI8TEDFl5Alzd0eALMTVAfHBBsh6ObhnGU+N
	 vTAcfFqx2oxJHZn16H6h+6Kj3IuOWyiITKDgxV3UJQVVxDRbyeYFxVOeV/P2LHzSAr
	 rr+R0nbbbqXWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 15:15:14 -0400
Message-ID: <20260930191516.523922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092946-smitten-oversleep-efa6@gregkh>
References: <2026092946-smitten-oversleep-efa6@gregkh>
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
index d79b8f7a39913..9b32566f91929 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2125,13 +2125,6 @@ static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
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
index ebbb9f63beae0..9dec38b9b7615 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -68,6 +68,7 @@
 #include "vmx.h"
 #include "x86.h"
 #include "smm.h"
+#include "tss.h"
 #include "vmx_onhyperv.h"
 #include "posted_intr.h"
 
-- 
2.53.0

