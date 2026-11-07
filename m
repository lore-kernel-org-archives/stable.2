Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050128;
	b=nnESZQtwXHM24vT8I/hZfci21Y866bQTIC6nKZALoN4YCB2quO06ibBZQn0gT+aZqmjB
	 hd1EwZ0PK/GOXRXgXinLsYiAui0D7qY7/OsvgB6TQDgq6t+KhblbkVXN5zco4Yyqw06xc
	 aBziY5R1dtdKoLWBkWih9k7vNiZ3a4CUPRtzC3IDmSO+oLuzTga0oWaZfF4US/9THp/ms
	 pcwceFbCj4SkZBlL1PWeLp2SC6+6EZ0Y0YeqttyoIsL1AQhCO1zbdBtxotiLU0AzVEUqt
	 Co/eTATOA0DxeGfPs1K6XKDA0262L9C/WhalGllywvibo1qLlIqyoTPHxaHnxaQyCpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mP5/KWAKDFUhj3+uEVA2ZnpzTjHojNx4SebI4eP35BM=;
	b=KuuavcjGbvICBPLQEMq3VIMrP0nUoLL57cclWQTuItI5AAjphlFdBaAIopNgOPUkXoti
	 GKvlp1GuWCIEinDAUiKdICYuiGEntLdj6291PjNZdVUrFQIGORWCTO9mTPaNRODWuqSsr
	 1n2T54SufyPogui6b+qI5c4iOoFFGM06Rh7LjkvjDCEU34HWgQklPgB/WO7d0+xFeCV5x
	 DDtqenjUEJAM9qDGkBH44oLI7gTE6KLslyaFfflEI1ud5T204u13KCwx/FpvHeNuHpyDX
	 5cMV7pFrLk7cnbPI6a8o9UO6mCwh2lWDlEtRojemQ5cU/vOCERdKVsF/LI05PMC5Kaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2dopRZR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C12606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2dopRZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297321F0089F;
	Sat,  7 Nov 2026 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050128;
	bh=mP5/KWAKDFUhj3+uEVA2ZnpzTjHojNx4SebI4eP35BM=;
	h=From:To:Cc:Subject:Date;
	b=C2dopRZRrKav2bsY2SCNuOZnhmb2eKAMwvTyr1Tt+V1czcfiI4URUcVXbqr2J1r4L
	 NLeslrKOO3wrOedN9Z7Ff9E0HPC6sLKL4KsxoeYjNjaq6tb9YrzeVFAnGqWRBXE4TU
	 4zRugkkzyH2XCW7vm+S4F44BEK1C0dPwbybqaXshxr0m4BJ23/dOfFl8YQ6LiPIUaK
	 UmQf7caSjyCLfeq/iAJBQ8HvjS3NFhCeyE0+9w2GYix93YOpn38iSMlLlQIVN5guvb
	 vrUXZCSzDIrBwP3OZ4sCsoh3nE/QedmHe1DiMVHzeEJyoXEV39krs/qlMmGB2pq9Sg
	 PoBHAeoMwyepQ==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:26 -0500
Message-ID: <20261107061526-failed-5.10-34dacbe7ae93@kernel.org>
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
git cherry-pick -x 34dacbe7ae93f2d3c26cd0bf3e08200b1fa2c180
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061526-failed-5.10-34dacbe7ae93@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 34dacbe7ae93f2d3c26cd0bf3e08200b1fa2c180 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 2 Sep 2026 16:20:27 -0700
Subject: [PATCH] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0

Bug the VM if KVM attempts to construct a CPU role with the should-be-
impossible combination of long mode being active without PAE paging being
enabled.  KVM's MMU construction assumes that EFER.LMA can be set if and
only CR4.PAE is set, and will create a completely invalid MMU if that
assumption fails.  FNAME(walk_addr_generic) already has sanity checks to
try and mitigate the fallout, but attempt to catch such bugs earlier, as
this is (at least) the second time KVM has had bugs that escaped into
FNAME(walk_addr_generic), and it's entirely possible the bad state could
cause problems elsewhere.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260902232028.2767071-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d43b8b6c3b179..0601964934a15 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 		return role;
 	}
 
+	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm))
+		*(u64 *)&regs->efer &= ~EFER_LMA;
+
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
 	role.base.cr4_smep = ____is_cr4_smep(regs);
-- 
2.53.0




