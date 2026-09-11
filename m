Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9504582F6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128312; cv=none; b=Tq0fYJSgJ5TghsO86sTwSH1cl4LcXmmCPZgQtgosBwr5Sjzj6kiARJo7CDu8Y3dcVGXiqLg1EKSOmpXXUHyTS5GE5bmtANnk60k66DdqC44gjU2HHqCnzIOhjFZ4HbdupikwZ9FzyG2EXa4/VMpZFMeykDq6I25ZvqhNDkFe3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128312; c=relaxed/simple;
	bh=mRas68lB0TPjKjEYp3smMao7qfZQG12tp9YJ8HEk9Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLkTu/ZEdyEizNMF4FDPYfBYbnRuzDQ7qofZvhp6utFItqptPNuxdqaKvDwp5fEcKCJswSXWo1TdqpPOF0O69BBh6Fbg7A64B95rl+J2H6LgPYQB9e3U89BY9ZxNIb8oYQ5utzB+K7jgSMVpBO7sYENImrbBPGb1I3Hio1mhrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EziKg6GJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EziKg6GJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302231F00898;
	Fri, 11 Sep 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128307;
	bh=wD89GY18dho22z/rmT0ynilAyUeQqvZYQ3enNViUD1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EziKg6GJ5B8inmeVzjgmaB2vdGNl3LpkBAB7YMq14gqrfQlCLe8mfvVUeHPljyMiM
	 /3W7VQZt1vCk7ya4YjdfSYo/YyvcNSyxSdgmNjM9vVZMjmtQ/Edq8Wq2X/Op8XF83b
	 Ta4zGG1/VwRMp6C83xISxpvFmvqLO9bayHFPaU1oUUc9guBEMj6WL6c5qmI/L1vsZ/
	 GGRZnEx5PxnRfJRyoVSIh+6DdL3f2xvLWtOsPx/nqNNpFOsyY4pcMvHCcNYfAMc2+A
	 qG26ogvD4+GGjKo4SdVYoXbEf3oQYNny74rq7te305fsf3SEAB2diKeS36j4jtqxI0
	 t8sJ9tG50esyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 08:05:05 -0400
Message-ID: <20260911120505.489730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090923-egotism-glorified-65fc@gregkh>
References: <2026090923-egotism-glorified-65fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit 4e2c7f7cbc27418f9a290399b986c1b85ff93b90 ]

__kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
the on-stack struct kvm_s390_irq but the full ext substructure is copied
into the cpu local variable on inject. ext_params and pad contain stale
stack values.

Interrupt delivery only uses ext_params2, so nothing leaks to the guest,
but a host user can use the migration ioctls to get to the data.

Fix by zero-initializing the irq struct.
Do the same for the inti data structure.

Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260805110455.7200-3-borntraeger@linux.ibm.com>
[ Adjusted context for missing inti_mem and ret declarations in __kvm_inject_pfault_token(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bccbb84eb1be6..db1ddfb20a90b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4594,8 +4594,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				      unsigned long token)
 {
-	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt inti = {};
+	struct kvm_s390_irq irq = {};
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
-- 
2.53.0

