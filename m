Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607A3E024D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796115; cv=none; b=Y3N/Rv8lpomafp8xSbt5cQx6T4YAf9QrJZ9pkXNwJSeX/04nwc70wAt3Gn+xABsdxJVh+XRg+QHTcSrRX/nA8TSwm19lKzcF4qurIGcDIfa3T3i2L/NAeSsMGN82phPB1adj6FD7wSNaFGIq56F5Z8BaS95JaYDDF32m/5zMuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796115; c=relaxed/simple;
	bh=JbJOlSMXCqQtRHUZXmpvYqoWYZxdjvRvHdWwJmiVRtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUPdusxCoYZbHZcUase9kjUGBtr56usDdNZDoOFz0RIBlY31PnTxAxUcaNurLLTRXGq/RBoaJ3YrcIpo1669LmzHPvlBmLVY7Zri8FyhL11oJmzS0XJwWfj5wEOvMRYtZFJrRvhkz4P+278MqhWTigTKtTsc4srkGNYmpCZlKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0C5gSMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0C5gSMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5786F1F000FF;
	Wed, 30 Sep 2026 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790796113;
	bh=Mh8HHvK62kaPjQ3Xc8KcDGQZe36fTTFd8FfCe52E5O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0C5gSMI6csYBQxHlpnYotoAQadzladQVO5QqHqWNlEuJCgNoM/SyEhi9fXVxO48v
	 mUxxWAs7CXxRz8Unz7M+pM8fOqLS0NE+STxFiPs6wag50E/13DlOKOrveID+4+gMV9
	 LRO4BBfWAYUE9BKcNaNBebamL2eIGigAwttcdiS8EC97kBJDVrzWGsqWER4XBClEx/
	 YJgMo83m9zLDZV5KBoQKBXnUyjlp+NOND2n3P7ucfuiN/BngOxl46xWUz37LBjx2+6
	 yG0AchZ0yTwIGu98XD0XMmi3mBP5oqxOCdh8puOKJ2TQiFLKMx1N0Z6bkyTgc/avVm
	 F5+m6STpBjB+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] KVM: move TSS constants from kvm_host.h to tss.h
Date: Wed, 30 Sep 2026 15:21:49 -0400
Message-ID: <20260930192151.577023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092939-anew-saggy-f399@gregkh>
References: <2026092939-anew-saggy-f399@gregkh>
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

