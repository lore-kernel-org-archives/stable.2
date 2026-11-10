Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294514;
	b=ksY+0pRMr8sBm17uvQZdIQsnzjfKvbehN5+ttHxxkswhswIRMe7/8bjZba7VgmYgci1k
	 PP0yrguv5tdN3R3TnDpwECFm6QvWw4bEhaOqwfq27Eg5LNsUqO4yCOMl3PT0BIzmBOHg4
	 RhrSf5ejWVZoMeRUEcyhkQoznJvT9zpVxKl5AtVFFgwifWfcdqTxozvHtTIWK1GOUuMag
	 i3GD+Tl15Hyi+f25YMwwCQykjmAPzX1RlKTloVIKKcNUv6au5eAF/Pyq9LXgvfGTMDwDf
	 PB7Y250+ErrrstR5j3DDPoJ7J1RSDO5DC9jnLc/rapePvRTPY5pppDgyaoLw2Q9ZBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w437GzwOockvC3xkB8f58dk7J9WwfI01KOhFsiwAtI4=;
	b=lpGMS7HwXLCH8UkG8Gv/TmDH1GfKfgAFh4Jw1IZ3g/DTIWq0h87U8KC8ypRhRjQCZRpm
	 N3jP3hFD24TD+gkZo9CgTEwotM0CFIp7OKYXfB4bmHjiR8fidkziy5VOKsFQBBAN52JwA
	 kr1DmdfAu1z0abNWQsHjE2CMZNcbtx+fNq0ceqXNWv26my4ZNTUFWG2HaruBHPMSPhhDD
	 BWS2D6TCvlE9bsMWnFs4Y3cCMJ5ZOdkMINXTR5LVAk08EvcN5o9DDs0gltuJJ7SsaTxck
	 bhRYCEES9JQsDlGVwyxJupn32couvxVCLoiGZjj0ULCp++tbMBvYH2QIf0VZYEFtyyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpil7kPz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpil7kPz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8581F0089F;
	Tue, 10 Nov 2026 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294513;
	bh=w437GzwOockvC3xkB8f58dk7J9WwfI01KOhFsiwAtI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpil7kPzgzfEFlnJB/+KUpQs3kz9MKH56XdlqhDkjQNAMJ2mVPQAdTADz/nNIlsTY
	 LC0ofYWVIeuCDvYkpYhlIqlsKHngfi533gQN/gH/fEduiEVrE3TTKuRFfnrMgfd8a4
	 OGrcdWiVHUPlU3q5cOFE7pGZVS0LY877/h/Tf4REAWsmNRrLo/XwL7jOgGN5sbx9P5
	 NkLncNO3K+gMXhLjGYQlSLjIKpsNr88EmOA2w74Yzdzr5dyNBn48ZiPQYYU004wzf4
	 xzPIAJw4PESGG0PGzyb+xdAbFC0zPB5N0Or3/09L5WN0kVUrMCFMBM/0CmhTUI3xLC
	 p1/1i3c+ngghQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
Date: Tue, 10 Nov 2026 02:08:31 -0500
Message-ID: <20261110070815.541581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055826-failed-5.15-1c4c84a643b7@kernel.org>
References: <20261107055826-failed-5.15-1c4c84a643b7@kernel.org>
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

[ Upstream commit 1c4c84a643b704e473cb171f7b61359ff29b12a4 ]

Force EFER.LMA=0 if EFER.LME=0 when preparing L2 state for VMRUN, i.e.
mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=0.  VMRUN
unfortunately allows the nonsensical combination, i.e. doesn't fail, but
KVM itself has an invariant EFER.LMA can be set et if and only if EFER.LME
is set.   Breaking that invariant can lead to a variety of issue,
particularly in MMU code that keys off EFER.LMA when determining whether to
emulate/virtualization 4/5-level paging versus PAE paging.

Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260902232028.2767071-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: Replaced the unavailable cached EFER field with a local READ_ONCE() snapshot of VMCB12 EFER. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f5b9bac913d7b..9a3045d843fc6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -461,6 +461,7 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
 	bool new_vmcb12 = false;
+	u64 efer = READ_ONCE(vmcb12->save.efer);
 
 	nested_vmcb02_compute_g_pat(svm);
 	vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
@@ -488,12 +489,16 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 
 	kvm_set_rflags(&svm->vcpu, vmcb12->save.rflags | X86_EFLAGS_FIXED);
 
+	/* SVM ignores EFER.LMA if EFER.LME=0 (instead of failing VMRUN). */
+	if (!(efer & EFER_LME))
+		efer &= ~EFER_LMA;
+
 	/*
 	 * Force-set EFER_SVME even though it is checked earlier on the
 	 * VMCB12, because the guest can flip the bit between the check
 	 * and now.  Clearing EFER_SVME would call svm_free_nested.
 	 */
-	svm_set_efer(&svm->vcpu, vmcb12->save.efer | EFER_SVME);
+	svm_set_efer(&svm->vcpu, efer | EFER_SVME);
 
 	svm_set_cr0(&svm->vcpu, vmcb12->save.cr0);
 	svm_set_cr4(&svm->vcpu, vmcb12->save.cr4);
-- 
2.53.0

