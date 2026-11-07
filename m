Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050181;
	b=VLfZR6ybhT1eg9ZZ32wozvmQhNY4qEqR106Iejbi0ytCrmen5BBv27ouvbY5gIzEliO0
	 NFskzDVfAagz/gFw0aGCAmLehEr+WR3hgnH++SEv5Z/T1uDeZv+s4kZgDcNZmI4uRbNK0
	 UOTUZHOig+kxYWOytpcD2jDQQBku2fCBCtiknFWPAm9FRmhLlfJxNQWagJmA00JmKdoMv
	 XBgG5GegocQCypfz9/NAkgUVkrjeQ6mTuqGvldyJI5kLIwBcSFdwM59k55G8Ll11nLmbA
	 JmCkgUjPkFaDcJBc7ZrNW93KfNpzpzPSb555/bKP5UGWfbI7DcNM2EL6vCUFX+cU8+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cF9nJqHp6NUl+uyh5ayqFkpBi/yvyibI92U6VOY8HKk=;
	b=QiMHcOukdHuvJ5pw5YQTPFocgW8dUia/Ylau/yjaZamA6f0SQ2HtOvUNBDns3E/n1cbr
	 0MqRWOH96ItcIVhLRVrHU3xL0u5FIbvK3qkDVklMtm4ia/GLdEo/R3ZOxQ3xvjEpReNzX
	 wqPfDF+5zKmZRMPAFMzYDNeB56qRiRwxzqOW9Ua7T0zKVZ3GJvMlzztchf6s+jtYaHZur
	 +Ipnf+gOYfxp2KJOWVdTG2RAjNFdRKrbl6mXM463UsyoXcG7+Gz5hs2nK2TkFu3NEuBHd
	 s1rgRqKl4/Az9Op2Ts1Lk0LiP8FxEPfESavU9BWFWPKJzK6Etjnt2LT9cLWyxJh3oXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5LX+Sk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B618606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5LX+Sk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02A1F008A2;
	Sat,  7 Nov 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050181;
	bh=cF9nJqHp6NUl+uyh5ayqFkpBi/yvyibI92U6VOY8HKk=;
	h=From:To:Cc:Subject:Date;
	b=M5LX+Sk3bgPlZyJiV5SweyXEcaJaQDBg9C6YCMbT2lO+qQgSGKmCFRL++O9LI2QwM
	 3fKAIv/Y9551E5QNT43pybAmsCzirKm4XEkazMJw6HelkxXDr5MrJ4+aHaRlcN916I
	 +80RFlhjTJZsJAa+F5xIAYAvxtHLY+wR7umUBXrRLOLZ6LCFUL9ctQookOm9FrtO7E
	 zdmzVQdPY4XoNVXXami4sIJ2mO158uPEurZB6qdE5Gk7O9Aa3Q33sQwCNdIojtpRff
	 VmcVNE4vJC/Ot1Ln4ec9Pj9ggNi0hQbhPxM/c1GrYpjAh6Xa4pK2ELVzAg2KuhP3MR
	 Hh9NXEK9ygMVg==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in common VT code" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:19 -0500
Message-ID: <20261107061618-failed-5.10-f305fd31f52a@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061618-failed-5.10-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




