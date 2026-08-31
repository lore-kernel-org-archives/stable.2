Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421639A7F4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210615; cv=none; b=VlZz/aJ7bwkZJrqbX6fh+i5uiUbMs0XVG2QQdvLC0YnNMMlfqN+sRnI9zRYyQooPdhRN7vX9Mj9RtQ0sIZX1GZ79raNfdXNosJ1qgh4yl3GDYKWrKk3dvYwJwO8Q4lOgcsTVTOf6Ekzl4UqzjizUPl2G3tBxh9H4UVUYW/IRVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210615; c=relaxed/simple;
	bh=Xn6A/F+LFO1cW2I/NnBq4vOIKiFq4LNAiiJdasXCynY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRnjSLcZDpemUtL1WuVXROQWTEw+1+D3AH3RtVrtgrVECilqi57o24sQ5g5aKmJnc/pREL7xZEVPcMBtsPV+oR2XWQM0knC1TnhYviMJc7EPQC8uFFM2q7x5/bW8CWldjnIRPnYLb/S7Eq7SLVAAIWrIZIEfsF+rfN5TDIOeuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDmRT5GZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDmRT5GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1161F00A3F;
	Mon, 31 Aug 2026 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210614;
	bh=23bKYWrLWIfPMyL+DAc6RBBqI8U9JXwd/vPFY3VPSuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDmRT5GZj5rhETbu72o6pkIEJSj5ESAi26LkTgIfIdt8RT0TcRhUyeSkyHiJaro2v
	 vCARspyg/sxFXZmconkDy0uFJ1wMTeyZZIgZA1U5P8+d2M9vGt/luA5YJmsLWrbbaY
	 Mlsvi6DDJ2KfQHTdhdPyNylp4+zdJJtYZccnPxV4Dz9upRXPhIBrQzeQlhtst3Ptp5
	 C3VWmwWk/S9Kce+XabRYkM9Qeb/noyk7Wdi8jwynsBcXhLvMVaRCMVEtJcaCeBMxHd
	 ymGqogAOL2v3mu2sD7yHd6P0ip6CRvSowHPMqIToVr6qwy0edhAvkIzHf1EC/ZScpY
	 rQbWlvbIXuNaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
Date: Mon, 31 Aug 2026 17:10:10 -0400
Message-ID: <20260831211010.1798943-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211010.1798943-1-sashal@kernel.org>
References: <2026083135-thud-surplus-53de@gregkh>
 <20260831211010.1798943-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7be27b481ca22..bf89f4d6e2e78 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3962,9 +3962,6 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	/* Mark the vCPU as runnable */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
@@ -3999,6 +3996,15 @@ void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
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
 
 #undef kvm_set_mp_state
-- 
2.53.0

