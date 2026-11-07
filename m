Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046645;
	b=PWRl+7Rd6yGw49NZW5nb+c+pRQ2LVs2LQY82heqL9KK3YLLjheohn7rfmrpqOZasnPyL
	 WN/sE+CUIH3QQHHW2a4Zyoah6l9ENOC4pjszpkb2WH1AvtOfSrci4vYKk6OAkqA4w2KWl
	 ZJmbGhPBDhvpmDCnpH68lJ5zyBGF6JB8gcTK0V9YvHVI0ND79Tt/JNq0VI1x06HMw7U1R
	 kYVH1V557776eax70XjwavOvsnF2I54VsORh/uS94ES675wK0rvDepwsKryEFmGCxqiGO
	 v9kZYiKg7cBKioVLmpQFIzSMcamiICrJSfa/IziDAAFWjAoaIwnwuKGk+cnLEhggTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DLHjiRmBv/Djj2HmJM7NJOo6RKucVTYqYXXp+/Rxw08=;
	b=tYiHleZKTwskHyTdvDN+obDbIeELNczoeBSAnoYHv7/BmGZLQ4+7BVuK2+jp2mg2Khei
	 ol3Al15iYf/b69xqFqtRJMTv9HQxLMw1Ztf3hg2hMdYCqDHK9lETseVtIlZOiSa7Tubso
	 hpoA1amkgT5yIYtJs6tZg8VDV6CDEW8xcq1gSHmHLwZKwHOJmRriuz9XHZeX5h3vkG78u
	 Y/eI3+uV/Sb73iOB0pQ6LQu3QFu31pKBWVrZGWFs9rMTJ9+73B+KqNg/TVIUpoP4Ht2ch
	 tKZfgPNZzddKwmAbM3GfIRl384zUwyd6gcSBLy5LAuD4MFsAJLXqUu5me9n2ZFVVqTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c+XrHSV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95460A6F56
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+XrHSV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E71F0089F;
	Sat,  7 Nov 2026 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046644;
	bh=DLHjiRmBv/Djj2HmJM7NJOo6RKucVTYqYXXp+/Rxw08=;
	h=From:To:Cc:Subject:Date;
	b=c+XrHSV/j9s8pjcvE9tOvAHqlMVk8U0t/YL7pQzgcWXJOSu3d3gHQjX+E6RN03B1G
	 Q0bpv3j0kpnCr9sqp1ALOwx4kEBQ+XJH43XI7IjDcU0z7h8WVgWKX6D+Ff1W9X3Jo0
	 rJMoRUhAbV4PBu37Pio0Pn3OXp4polgcSybB6Nq1aS8tKum48ZxE9GyG1jnYL0ORYk
	 hhfOPk0QrGGCTw4bCjYjhj+vmYlmCzKKwubZXA1zzx7w/r/GyFEsjEI+MbXiKJZUAp
	 9wM0vgyvAGEt5M6x0y3U/SH5eXBfJtlH2KlWtblf5U1MzA8OTifDA9jD05kU/RpRcb
	 5gFTZjdPnRfng==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in common VT code" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:23 -0500
Message-ID: <20261107051723-failed-6.12-f305fd31f52a@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051723-failed-6.12-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




