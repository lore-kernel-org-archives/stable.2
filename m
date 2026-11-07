Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048151;
	b=riGeN6EGucQ0i99UJU0KbORW12cEPjFNfG972MvkfJEPct6sIjaLpu56SCE29tM4UeoY
	 PhsOEnTPEOLh3lzLMnJPmHck7A2HecJZOeSevJxKsELqCc4sNZ3yy35sGHGRvG224rvt4
	 /6iq0dfQMEanL0yCQZyK3TooZAHS4IOeUnNLJB14fxTOZi6hdI7SGbwmRjVjYdh57I0mA
	 tiZdr5hhNKO0Z/RXbeMDL6H21iNS+fVxBKB+2c4zaoGVIkEJexXunrcEgeaoaYmo4gQDO
	 vc0J2PeKvBnGitE5T9igfgwlpZsGQ86SsVFwzpUJ2SddM6V+HVfEWzxCChYS4l3wqBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ogy7BEpe0Cos+9DnG0MpHmhsz4L/KnN4TF3oNmmESKw=;
	b=NYwGdjwbbLywLEW8zLsxu+4cUFMH3GWBNkkVoAmHUXt+80tuMHbYVm/FlTmeBlEDMGZu
	 W2ROo26EVkc2SnsbadFpSazn0W87FyxrTLjacA2vwYluMEBpZqnFSakjezoIk89bfpEP6
	 IKo4NnCBPT3sThNl4VezZzoZkCh8pu4P2XqBiri2qv7REnMeuXBGvSADu3650V/LkQee2
	 bNEqM6JGIBPuPKwtTBOds2duS2PmRBzSOPflLpPCPhuMR8a7xTKYRWFYdRJVtZa/IJpa3
	 0Y50u8nPmLD7IYwxWLzEMtVqaOZQMhGFFVJB+N+pBL5b0rDOy0q9t2w9sjzrVXOH2CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LamJymh/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F12606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LamJymh/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804561F0089F;
	Sat,  7 Nov 2026 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048151;
	bh=Ogy7BEpe0Cos+9DnG0MpHmhsz4L/KnN4TF3oNmmESKw=;
	h=From:To:Cc:Subject:Date;
	b=LamJymh/deD/+XJmVjGSS2J6uU8nqxRRaQQYZKqunmbEm1fHb1f8A+n00QP6gnG82
	 8XZA2NrdkfK3c3Xcwm6vtugbJyppHoUQggGlLcl25cItbkZpnQ2X3DyIZaj9/RR/B+
	 nEmOC7jI23nD97fFy88HEGUgWf9C7XvOhRdEjKc8d6iJceEbKebb/gdWIi4j7DjR8C
	 5Y0KbJLwfBfpEl6RQP/50Jei3L60TXbA7dYrL/wG8DkAS4uu2LB1q0A6pr6i6zo6nV
	 0j8DOk+41kb/0V9Cf9hA05Y6e5PWG1yqXPTW+yFpxUOsyD3Z7dUXaatdNEw3NOjPvD
	 qFUF8+e6TJ+3g==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in common VT code" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:29 -0500
Message-ID: <20261107054229-failed-6.1-f305fd31f52a@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054229-failed-6.1-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




