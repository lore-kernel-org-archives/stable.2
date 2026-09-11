Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323253CD8CC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129193; cv=none; b=BSTXNSoUKkDXseDg377Dqh52N74VHKTDvI90l2gjOMc+LuXE3B+KDFiz+SLcxuRClbsG9qLFXmwYSpndRwyWLH73AOpM9xZs08egcwbGVUHbVTj87UdourzKV+5wVu5CLWAWS3LgBy3kLaY4jniKrD9x1kK1tsLk61drEq4CszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129193; c=relaxed/simple;
	bh=kHF4aq9z4VIdgnHMqOiEKjsIgkzYQP3kEy9rPdsckuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPO6mAlgF1Qes0ych5QiidDdS+Hv22G71x3WGw792LNjB4PVrUrGov+kx5+UVx9z/MCpF4sFrdRIIFJsJPIzcgnPsJe8m4z8aKd8nsLTSncEyYlbWj+mg7kgG0whoQ5ZhArpPmjW6poe6fBaqYt26+tbkWwZsdYAtAQSFPw7KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN4iPcxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN4iPcxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD01F00893;
	Fri, 11 Sep 2026 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129178;
	bh=YfvMYDWY/cgYSXj+Ezz6El8BWyU/6+WI3B/14kniyGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VN4iPcxVduNYcP1rqo2EHAXr24pOVeCdP7IU05gcJqBQleqpejfAJd46e0rGl9cBz
	 Fj7vi9x0eZy6CWlJM1adEnkO5RDdqNkfgU3OslOmA6CmTdmnPfQPjPyXDgPxxvL9ze
	 nqsVGnWgPmlhVhU4LAByTpT0C+cdwoj4zvtoc6/z6lUKwDdlj/XUU+P9WcVe0CS8kl
	 GyEqI2As9DfyIhbhYYHSx72yaaVEE/bBZWHe3Q9VBIajLUwZ7W5LTeDASGA34RbzAz
	 IUUgf+4OGvXgRhwIfWq3ybHWdqHIDdUoWUGDaYQYsR8ubz1ftS6brTNYkCRvHOXmQ3
	 XvvUIHdm+/7kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 08:19:35 -0400
Message-ID: <20260911121935.514679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090924-endurable-recharger-fa78@gregkh>
References: <2026090924-endurable-recharger-fa78@gregkh>
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
index 2a1a3117a5b23..55525b425a96b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4427,8 +4427,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
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

