Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049173;
	b=P1MgNNm1NsizPyKcp19nLRGLeuVaWQblygvGPNaXvbZDOlfKcSnRKVQUNkcTySBdy7Ws
	 j/O9s3mA4RMsVthRCohLNhM/o+apFONtzLNoQsz1O77n72AbdvYl0Ax8xlP4RucD8RP1c
	 tYdGbE6eDYhmfl+TAA9en1aYGza27B2BNS3JEamE3Axn7T8Or46qfTuGkoWaMsQpyXgaM
	 9q80TUWZGYbBmQKg29c7sP1Au/r2jQjpDvfh0dsMwK/Y1JRxG1OIBpTFLVZqIBRJay274
	 ZpDxP9RVswKfm3hc7p7/znKWm26eTPBS1xqMS18iMzaPItzGt7ZbdA603QE9CYLh+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KfqSNQyjPmiPSVUwmrcZfmbjAvBEOagtMNJkCQee0tg=;
	b=x4V6y4Og+hvrUHnyX5mO8SK2dTgG4bbdwCy2b96iO6dZB0t6GiC+DPYOKrAER9RzNt5t
	 zP8Id/eb0Swb7vDOH64GVqWmYeN4cHMdBM+iI4h/6864m9UHYzLZcIDZNvomSLMr36ykz
	 ZJZRLYpuTJPNSE/sIo8hSqhA75PuI1Zj+B62vIoe6I71esiAF/hoRcxXgo/vx+emAfg0U
	 c54vUgn8I2vyC+bNQhdpi7sseAC703rnizbkHW6jj3cZPu9omxrrPcg12wSS2TidIWREj
	 kntOr+ftT60gpVTBNyHCB4QVSa/GU/Q0p5qjlDheLURcXO8ARBr+/rpzR/JQDqjF+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6FYooz0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDC606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6FYooz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A0B1F008A1;
	Sat,  7 Nov 2026 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049172;
	bh=KfqSNQyjPmiPSVUwmrcZfmbjAvBEOagtMNJkCQee0tg=;
	h=From:To:Cc:Subject:Date;
	b=D6FYooz0Pi4GjHg+8LGLyzDyT4UL+EV+H4Fj8jj5cn1xjZ+Nxn37UfCrRjYUqSNt9
	 ven7gwJrt8TQk8177Z7TlPXREdzVqMlrXg8Ad3oc1DuXo8Cm0d4orr3HWojM+8Z170
	 MX4DOijy3pIO/0kVHGKw4vOofxA6I7fH6Q3idGoy6TZ6xYlWeg8kcweJej45ymHSpt
	 v8WUQUEY6PXVZszPHYB78n4Nrps2CciNAd4WF4cm3mTiQhTMnTchwqV8lbrMfos1jO
	 HmdvWtZE7RBD3jUS/rmfsJRwnGZjWnTIzm7ZvpRTd/2ojqqJqPQ1a1p0VN7FwpP+bD
	 V99CAWfnPl5fw==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in common VT code" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:30 -0500
Message-ID: <20261107055930-failed-5.15-f305fd31f52a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055930-failed-5.15-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 3 Sep 2026 18:03:46 -0700
Subject: [PATCH] KVM: VMX: Disallow using to_vmx() in common VT code

Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
runtime, or worse corrupting state without outright failing.

Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
doesn't need the same treatment as to_vmx().

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260904010353.3175819-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/main.c        | 2 ++
 arch/x86/kvm/vmx/posted_intr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d07869..ea0d825e556d2 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -10,6 +10,8 @@
 #include "tdx.h"
 #include "tdx_arch.h"
 
+#pragma GCC poison to_vmx
+
 #ifdef CONFIG_KVM_INTEL_TDX
 static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
 
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da238..24221ba553be1 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -14,6 +14,8 @@
 #include "vmx.h"
 #include "tdx.h"
 
+#pragma GCC poison to_vmx
+
 /*
  * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
  * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when
-- 
2.53.0




