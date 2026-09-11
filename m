Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840642C50F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127620; cv=none; b=joy/w/Fech0jAwKYd2MAkAFh7EuQtqaFGpCCR+siJYod4r0Z3+R65aGqt/rtsqMp727txUQUAPjWzwlcVk0Qf3Oq5U4UFfGpdwjwjlvLq0biIbSPwPQ5SlDCjwurGsRTRz7V3Z69i/bKID2oXuKey5jFDq46lbto3qfrqruwTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127620; c=relaxed/simple;
	bh=u5ZMnKhUhMbEAuODpp7Ev/TlxT2w7iJIsoFEy5rn6ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqu7Ow7rIUB8X1nfAQcGYf61S/Jb41G1IoEZdZ84jsXk/cFiWooT49iO63XlSiyUyArTZgpB2rJIulcFJvJ1ASrtKov30AVF2yZ5X4YQL7nn2mXnutZlRZlKUNmK7vFyvDFk/t6JjpYMwSZcCgg4/ZCntsx6oTe7ELxJ/hhuJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUzBVv9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUzBVv9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F8B1F000FF;
	Fri, 11 Sep 2026 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127619;
	bh=eTdaXo8FWRAmp7yeTpazvgP5q6Y9E9Kc1wtViwImRb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUzBVv9ZeGf3PgCmEaTUr85KU40vNGxk0FPkdc3IzpCe8PwCkMBq1R4ipZI/6S+EY
	 NOrsGToefHdiiuiBH/3JlrDzkRvF5PG4cS2xvoB5R/dOJIQVtaQ9UNimdghdUAzqPj
	 Qn5KzlPlihLFoOFZdyBJwWX7jiaDwKZrFo3ZzwCjiMI1+POsuE5Ws+cWAelExJuawR
	 mkgh9cKve1cwoKXLtKpa8E4sQyu8kFsQ7lJpIikJWiZbQQmLCf8RdY6KVmK+fwTqRz
	 3JOTdUiHrguoDNirAuAPeA8lwLCoxwqWXx76wBj7AUK0Y9PV9nZrczxk8i/NskaTqk
	 rhYCwYlwgATSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 07:53:36 -0400
Message-ID: <20260911115336.468271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090923-boondocks-sulphate-e6e5@gregkh>
References: <2026090923-boondocks-sulphate-e6e5@gregkh>
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
index 70d7bbd62120d..e4c9081a317d5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4598,8 +4598,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
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

