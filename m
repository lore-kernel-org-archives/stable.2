Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1D466B01
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129619; cv=none; b=Yyz+e3/5hAdw9uZSXpqKpgRa2+npbtLVENfNkXw7NCqP6bGkaVYHu+XSS09weYHwBWH1LxpcddQbdqpMOIadtuPho6ENbFAWbivTNJx+LHydn2Sbq5warKq7037t21cPDemZIwMaD3gOon/4Dc5pW9DykvOIZuGToQVnqeXcd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129619; c=relaxed/simple;
	bh=IIEJQRZaSG9qhd4d3vzL6ntZPKLtcIVY82GvyXfEB5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG3UhgwbzYENAasuX60BZ0+eaK4URPm2B8NjFI/Rx95Aw4Q2TUKij3IKXSF1LOxnLxCgzQpJUMzvzpA+2vYahLSvB6jl1tsMW1ZlGFVL6XRM8ZjHBEow3fx4ls/LABWQuVyi1MDMMJkrGJ1lydokDw7lWtJgQO0K294YIdpvkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M28mFSeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M28mFSeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089BD1F000FF;
	Fri, 11 Sep 2026 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129617;
	bh=T1yEVHKXP4rH8UXH7h5CO8IKTdMS7FW/ruqJDXs6DI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M28mFSeW9OwrGnuzV3RXFTG5iYeOTxoMzvOmA+SBg+vgCIIKU3JByy2FvMMfQYFUB
	 1yz9QfBzgEq/YOT1lBYZ7M433xlNXCc95cwGbiKCUlSH+C0OtnQ3HE01oO5xCgaG40
	 dlGnVgL+fWFwN5YOGPwAJbtWXI1LqspCgO6RXhdSgvD8FugwFrxngijRrGe0Rftqql
	 BjbzAsA/HXpfaNQFyWaTNNgo+Cnp+HYhLvDpltVShCAR8yjhhRqIkcE0yUkP4fuH61
	 5TD4pvebszko5/vaL8aa8l88hRkIR2Ridthph8f3ldDOv5JiKp8Kj7I8w9yaOfiOmp
	 GZDexDg8l2chw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 08:26:55 -0400
Message-ID: <20260911122655.551444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090924-apple-leotard-1a9f@gregkh>
References: <2026090924-apple-leotard-1a9f@gregkh>
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
index 8d7f2c7da1d36..622a527158564 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3984,8 +3984,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
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

