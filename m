Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B963BFE4F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216263; cv=none; b=KJ7+sBk+UReVXedo8mDjT5xVKmhL7R63j3TKPXgOuIo/8iDMswa5cNEI87KyOLonIEoURlCWMKYIudEFyTkcmbhnxZhDoQBc7FVqpq54CRf9HozfRhrAlDo+Zak15SVGvr3i0PpJ58t5DFVPDTh3U97VqQE8OFr9uJk/k6SNor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216263; c=relaxed/simple;
	bh=+/acW2ho6jJ0QiFKQYYoHavxsRXcmNezhBjJ+W2mQoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGrbmVbTsxRNeKwThQf9RSKrwW2PR86jHLlmEaQV0XTSnoQAbfbup+23lssbPS0pYWdxR4lBGR0+K2nueztsRHYqMi5gRkqJ7AYIVH9O4FPlGcdX8au187/548X6zudt+NIpPeS7gObjhqaRB8Rp/0DlrIzIbo6Izoil5va+OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDfEWv5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDfEWv5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFC51F00ACA;
	Mon, 31 Aug 2026 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216261;
	bh=fg+0kIYUSweTjGo+K2c+Ie2K/eiDPF4QW6OPoy9Liyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDfEWv5XcpVeeUeSMUrJEcPSIAQUSPYdA1IW+Z3BOD8OFLCeRxDVG2QS8SuF7L+Mw
	 u2CBzahtIQLCoYFUT1VG3biw4afFazd+m8h8LSThbfO8nJaFCPPSLFRTrsJqrQRDtA
	 DWo5PGFBvR36dobJMmn224q7fDQohVgLBv5/xmplrgWgKotbmYTIN75RuWWgANwztZ
	 BfK7gN4wy2oi3Trnln2QRklJV1WJ13dwS+RxiJXcK6VUXtmlH8X9uBYkNbJGWdx653
	 pkhauFRQYXBXdUrD8ZowcBPeR+BIOQRrouq0iTE0Bivv6aeetYy90I+/LqPrWLa6gV
	 i2D2GPBozwqXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/8] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
Date: Mon, 31 Aug 2026 18:44:12 -0400
Message-ID: <20260831224417.1903154-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831224417.1903154-1-sashal@kernel.org>
References: <2026083159-request-customs-f573@gregkh>
 <20260831224417.1903154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 98ade8c48c28c227fe2e80e545ff0c57cd4712a3 ]

Always mark the vCPU as RUNNABLE after responding to AP_CREATE, even if the
guest-specified VMSA is unusable, e.g. isn't backed by a memslot or doesn't
have a backing guest_memfd page.  If the VMSA is unusable, leaving the vCPU
in a non-running state will effectively hang the vCPU instead of reporting
an error to userspace.  This will also allow retrying the VMSA load in the
future, to fix a bug where KVM doesn't honor guest_memfd invalidation
events, e.g. if AP_CREATION races with PUNCH_HOLE.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d9683d584f712..948cc3ab8f029 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4130,9 +4130,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	/* Mark the vCPU as runnable */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
@@ -4164,6 +4161,15 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 
 	sev_snp_reload_vmsa(vcpu, gpa);
+
+	/*
+	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
+	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
+	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
+	 * the backing guest_memfd page is unavailable.
+	 */
+	if (VALID_PAGE(gpa))
+		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
-- 
2.53.0

