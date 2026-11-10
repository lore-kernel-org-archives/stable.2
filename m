Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316601;
	b=YnHuGvCgqsquP992R3Gtsks2wDHdZQ5wIdpzRSzVVXDO0/aVC474g9MEPpaULE+f8ZkN
	 daqlhowXVmIZBSyX4izr1Z4wzXeHw2Af/lz7U8yN6CDgfPFVt2PYpksa9HnAa3pk3NYAl
	 jQLZxiRCnUmPsVbvxuvTXDn+tlwbDBINdoWPIIiVUj8VfQGTM4tiifInrul6606Z5cDcV
	 caowtYjP8IejE8nUDv67dkv9ma9QY9HBy4A1ej7wALzm8Bj05edlfHWgygN33aTt+HpkO
	 YTCJiees2qH1B1eSsQTw4Wf5CbNKBvPTHjqqVrmyaMscALTbUJEmcM4frV+sWbYQcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IdUOBAB42dmsFo3ny2Rs/VRe7Dj+IKocsI2/0SqP2ic=;
	b=Vz8ZNHkej5zSLfg0ZDlZ53EexYnJNaBCFOpIudyKEG3jGaeyH2NvtNwSxe0vad9dcJoQ
	 u9QAuRYmo4abHCJ1/7nxb2kFQfu1BeVnOem2u3AV+bUZINu8Huv2yKGS/XOY4Dhs3JLXX
	 hG1CdRO9RJ0Rmnr/FUB3ek2J140myYSN8Cpa2zBlrSkYMWrQoP9dgJAJk5kzQKL+3DPj2
	 +Z6knXR69oGWNrXO4zYC7VP/03MW8Y/KLxWROVOiqmAI8xEaXfIDSy7bjsGljb+NIdavn
	 M9xwpkpu9oUlfK2DH9yIVtnkQeEnUu8X10di508/u6Ui/QCeunF5A1Ik+ewuTICnqww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8bHDf8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57B60A6F47
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8bHDf8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC61F0089F;
	Tue, 10 Nov 2026 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316601;
	bh=IdUOBAB42dmsFo3ny2Rs/VRe7Dj+IKocsI2/0SqP2ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j8bHDf8iak+SHAWsYQR6Kmu/uV0nWnK/ltrqJQIwoETknJ2ZOhN2GRsTnhPZYUC7O
	 9AMcyaugAVan1yUcZ+sHjQXphu+KCggVRDvDV1DGD6dCmBEMxtCeEHC5zQ7MBVcLjb
	 eyd8tb1PHB3ry6qDu7bdUlMzKHk0H2sbBZcPbVjWmyYQww/3SQwas68vEc8mn/Wp/+
	 vuEMFSdQRzcEQrlg09s9tJfGtaGdomNqD2kLt9dACKhhvzZLcSvL/aRsU94A6So/eC
	 s0j+yH1K8eBFmHI78qokYkM0wjKWBWa1sxdPeZBjVFvCwzBP5M539G6UPVKwj/jN1o
	 TSJRFIWnqnYig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
Date: Tue, 10 Nov 2026 08:16:39 -0500
Message-ID: <20261110131604.1666660-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055829-failed-5.15-34dacbe7ae93@kernel.org>
References: <20261107055829-failed-5.15-34dacbe7ae93@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 34dacbe7ae93f2d3c26cd0bf3e08200b1fa2c180 ]

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
[ sashal: Moved the guard from the unavailable kvm_calc_cpu_role() to the paging-enabled branch of kvm_calc_mmu_role_common(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a768cbe23808c..887a9d4a1e8bb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4854,6 +4854,9 @@ static union kvm_mmu_role kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu,
 
 	role.base.access = ACC_ALL;
 	if (____is_cr0_pg(regs)) {
+		if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm))
+			*(u64 *)&regs->efer &= ~EFER_LMA;
+
 		role.base.efer_nx = ____is_efer_nx(regs);
 		role.base.cr0_wp = ____is_cr0_wp(regs);
 	}
-- 
2.53.0

