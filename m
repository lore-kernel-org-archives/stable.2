Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047389;
	b=uGwwYwt1Mr69jvdGuSzA2Wq5inkwCoySGfW6D86yVi1IhRb16S1YxlZ/ZP0sNz1r9nBx
	 rFUOFIa5kVSf3+GfyV9zu/Pl+EHl556yuMxvx8Nq/yAP3ZyaKZYYIB0o6Xk0RZ8Z6ZJc3
	 JFioLbGitmKaU0YDTV8ir6XST02vL76gKjwths+xSTaEBWeWHcQk9xRr0lxDqtMSTA/IH
	 TLs8QIPLcOiTMX7ej/RmT+mD7RMWnZfwJorOY08z+A03wp7dlNcisUveyuvlUX331eUSN
	 /zAqjKCo6wLvLnFYoCSFbqKhnlt434ILKsufebFQ2ShgixFjjEBbtEWbXYyqDhv6ffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wd2jTAvzD0W7/JE0gHK5BuvoTk+QLEBlqgPY6YK9kYw=;
	b=sz5Fb6XzCaM4oEvb32lDR6/Dw4o2rXnBJkb/MAXKqQYG7o5/qSWuwDjWXApBFDt7fNK2
	 wBtc5u98/dHC4oNoGPehrx1Ww1gBVP7r3xwIYfbe5j1aR3Qc4IwiDSjIVnysEk8x4ORov
	 aInDtzf96tLy4WTsgZfDX4fbIEN9+EusVDRVc2w7BIafmI52BrMAFXyMVDC33VuQfkO45
	 TGb9ZgVhsztGla3sqVS36opObPIyRAnWpQTdiFiF0YVSYHYkmBe/zIFVfoa71Cm3F/hg2
	 ga+fzOaYfbT5htebjLqAUN1Qcy4bJTanYt0M+YROfUXdi3LKGyVpBUJXZtdEgCu/G2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCq2iFI5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A7606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCq2iFI5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B01F008A1;
	Sat,  7 Nov 2026 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047389;
	bh=wd2jTAvzD0W7/JE0gHK5BuvoTk+QLEBlqgPY6YK9kYw=;
	h=From:To:Cc:Subject:Date;
	b=lCq2iFI5GTQHkFqzgefYv+nmVMaCgCUIDCdpC9p56DxNByk/OoyeH9hOXAOvsOWuq
	 k396AVcVac0L+dcZNc0KDRnAQJcSj6PdLIONuarVheP3TQvtFcaere6FpLQFm1WHhi
	 9KyR9cxyjL8thfG3WFOc9QxFATFQohtpMAYSA/sJ9WUq6NJK3sx5D5vITjzBIhjOcC
	 zgpROvQ145x+5gYnEt4ZDU3mVp1hCQBdmYD62FXxOANXxJyT8A69eyJGijvSV3JFhq
	 l5rMGwks8d6DEmH1melJRncVG92hK1wkjSYC2aCZez6mipkNs7wP5oOGakuUFV6eNk
	 iDsDCkkkfJObw==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in common VT code" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:47 -0500
Message-ID: <20261107052947-failed-6.6-f305fd31f52a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052947-failed-6.6-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




