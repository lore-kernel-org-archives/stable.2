Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294987;
	b=bdbhGTV1BAdWpaW/Q/tf+QmKD5hC0aTnaF3OlmeW66UiUiSVhuNfafOHRSvyHKi4NjGi
	 bCh2/+cSDggAj8xqIwpz/Len1SdYi4P4bsL/LeA2sZiH6/GNd3w4Dig0NVqYkol7245HT
	 Ijiv0bQcup08tcJIMX5XaDht5bvREhZ8v1cMeVy/T/WsQJt/saJwPA4cG916HxjkS68ju
	 73lFJ1ZNDPvbGW0UwWcKwB76R0bi6jiym/JfyhA3CA109QljFDrX7jWD47chW6plcZPLW
	 XyDInqe4A+bONv5ikMQqD7oY/JBDdj041EX9Nndn4Q8nL4E8L+sTnZpBD3V/otrUGVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qVxMWlkdth9GEbSOybn+FgbOIlEoDpe/1mMOwCwFIJE=;
	b=NUNW/Rpe4Ze/wztxBQUh2L0F7tx9k4XAlYPJppM7GbV8COBuR4r83Zjhv9PWDFXzjCJb
	 9/wGT9JmS8mwUuR3gh1L7F0EI+BmeFJ3/kWEpi/xlN9OqOteCDI9FBNuNB2Pg+hlarBQs
	 q1reMzXXWQzIOyAQBtE6uaW9LaU8TSk8eUO9z8sr2NBu09gslg0MkiqirScKN2cGYWoJ4
	 fObEVDeEC8bsdbSQL4GQMmBn/HRVeDN0aYRnBQZuB+Z5XMN/YYYzSAwNDhvrcMvNeS66K
	 7gZDPA+kGEDiuZKhyr+tTCraQy0MrSgh5/krCTRCW3Cqdf1H9+MEiV1LLj02JRtUsAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3ednz2H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E47606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3ednz2H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E831F008A1;
	Tue, 10 Nov 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294986;
	bh=qVxMWlkdth9GEbSOybn+FgbOIlEoDpe/1mMOwCwFIJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3ednz2H1PhEWh9O6gAf/8aNoqmqnq9QY7moy1Ec9D98GBNwUMafTEhszjy5NqRXW
	 wn1tVvfw9cTzL5ObBbvNDzrZPyEF6iCXfDLMCY2vu+Ifz6Mdq2rH+FmZKg9lsCiYiM
	 eJAr+ZvAA38zm/bxSPe6MGwBgEzJP3Ez0wL/3sTHbZbMkGUplBSfRASmNyuvpR+YLO
	 Q7fP1KDwFgdb+ZR6IKP0/yRH8YBlgv1Y7fU1EwmpM5kfsbZMXQREAoCv/rWdHBnjTd
	 /3NuC0QFS4ICTBT53obbNjnE9+SYcBtusUQWHEJ7JGbJmn2o1/6j4xZsUeS8gow2LK
	 4jC8LvzLhGxGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
Date: Tue, 10 Nov 2026 02:16:23 -0500
Message-ID: <20261110071607.546819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061523-failed-5.10-1c4c84a643b7@kernel.org>
References: <20261107061523-failed-5.10-1c4c84a643b7@kernel.org>
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
[ sashal: adapted cached EFER access to a local READ_ONCE() snapshot of the guest VMCB in nested_prepare_vmcb_save() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a87df5804a766..854c0d2e665ec 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -403,6 +403,8 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
+	u64 efer = READ_ONCE(vmcb12->save.efer);
+
 	/* Load the nested guest state */
 	svm->vmcb->save.es = vmcb12->save.es;
 	svm->vmcb->save.cs = vmcb12->save.cs;
@@ -412,12 +414,16 @@ static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 	svm->vmcb->save.idtr = vmcb12->save.idtr;
 	kvm_set_rflags(&svm->vcpu, vmcb12->save.rflags);
 
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

