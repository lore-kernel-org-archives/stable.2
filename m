Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF93BFAD5
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900579; cv=none; b=GYcKZK92oNko1qvntcLyTP7Y/cWXvLj1EAEgkCBkWllJ9UrsP8spNBpzBnMKvjzJlVJxkGSqzV0C+kOvcQlmPaPygzyuH2qc4GFqson5NBrgMF7ZedjFYz9NxpcHE2SF9OPuXlhcTmtiakcPGzbJYvSsForp/+4RK6WCTnjhPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900579; c=relaxed/simple;
	bh=lqeXZvwKd2+gKyapbikEC8uszALCZyZ/DkHgKCMSiHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQRvaehGlotT5Ix5dMzZdwrfpmrzK4Wy8h1fKVHTFMjfEHChL6M8JCwXxV28Win9BhohLMzKSzCmiKEavWwSNwp5X9YVI6QmSYf2smTX8qSsY1G0iqChiotd4f+DC2DE10aylmra2VMXc3Fas3FAcWFirHrlq9TF+2LU4bx3kWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTQkcV79; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTQkcV79"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5175b6c4e19so23251971cf.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781900576; x=1782505376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=MTQkcV79MPjafs+hUDlIe9UC/vYURCvWiigC0I7+E/5ykjhQulQyRlpmmAP0s+DM0w
         VtA8R8+zUlNUxWxrkfmllK47jJOYxKe4v+oQoKqstsdU8mhM6gbl8s4i0FWp/0wn96FX
         8BiJ5i/dQ60bBzS8oOqXJl8V7UAgBOTsm3awECt2VQAT20SkWV2bpOGIpKF8SXldJnYp
         KXtWSVatU55k5SMkeXhkj/otInbnN5klvhLNA7W0CrLlCvcsEJM+wkmc77IwGc7WQQpO
         fpHqNoQfvYG3FxklLfNoEyPM8915TNxwYlks5I/yV/9B1uNR0umht0QuDj8tr9zjZCK5
         h0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781900576; x=1782505376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Rfwd7WJck9jEb6I6f8Juo4t1Gf+3WTqdnf32I0mINY=;
        b=Uzkpt/CLY/o8xhavVy5XXd4/eUJsv29xAvmzqUiJkbfIQHIbVVl45UPwhuXMNJ33Jh
         pNRWlAIKgb3GCouQEZZ2gA+y21on/4E5ZZ+y9lV31zesBEqP8tkNGPBD71J73Ue5YOk2
         fS+TrtvWantO+uYC52rUiLY0la/fmZUPiPmbK4oSSYpBCw0TTuelKPnoVuVWuRjo7cS5
         7W2+2LWXviDGM06SUNJhXTrf5qrDkIUFS8TUySyX06f7aJm832nGRhlVyajn7yHqD60M
         PXbhoSaiqniYED828+nCr8hmeSMwt4tSJYbStGXEclxfctBnIUQKtdVQsZqvdoYSdEfG
         5uaA==
X-Gm-Message-State: AOJu0YxzDai059dR3xhUxuAwXstdNMp32c0H9r5aKTTWzdhAyvG1kQ5L
	WDVE04u5YdTXpY+SIKa79lhSoypL1bTNMBxslgOi2wfIEznDkcdYkD7y5SScY/rOTZw=
X-Gm-Gg: AfdE7cl9rjKbsKbsVx5R14uU4kLs/jfTIUgXCEKAngWO9e8L+LKEKjMshdyEjRoz+T3
	SDT1ROBqJbrqxjPXOCZVrBvOJ8gO3B3qdwR2ebWtNVyxXD6iueGXPOIm+jwWkrEB13U/guOZ8Er
	iQrCOGtF5SLg9C+wEBBhsEdme4paxzgwuJcwqMvOuDiLnNcEFBwIW5cFGIGDaCM9ncn5CA6lf8X
	PO2ybPPQOb2yLicpSxN4+RXW8a90+FP8razi7tpNJlz8fFwh/GGdld/j+pDT9z4kT+aPlVL7Jey
	/VrASGqHedIt0Nq/78FrLwUwXR3uSciGs1ObOtck3YiPRwnXUWsl7fDuFzR8rL9c+FcDXxYQ1eH
	4uMWroBGLnEaT8pLkFx3dBlXQ3GGLl3E4iNhstzzuZ6b9RPm1IT39+aRrNRzlY89F0dOcJrfc+3
	cbjuAe/QOpb2ftgCI=
X-Received: by 2002:a05:622a:203:b0:517:87df:d8ec with SMTP id d75a77b69052e-519e491ba21mr72925311cf.9.1781900576352;
        Fri, 19 Jun 2026 13:22:56 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0984da98sm3921561cf.15.2026.06.19.13.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:22:55 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: main.kalliope@gmail.com
Cc: stable@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1.y 2/3] KVM: nVMX: Check for pending posted interrupts when looking for nested events
Date: Fri, 19 Jun 2026 16:22:24 -0400
Message-Id: <20260619202225.2749389-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619202225.2749389-1-main.kalliope@gmail.com>
References: <20260619202225.2749389-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 27c4fa42b11af780d49ce704f7fa67b3c2544df4 upstream.

Check for pending (and notified!) posted interrupts when checking if L2
has a pending wake event, as fully posted/notified virtual interrupt is a
valid wake event for HLT.

Note that KVM must check vmx->nested.pi_pending to avoid prematurely
waking L2, e.g. even if KVM sees a non-zero PID.PIR and PID.0N=1, the
virtual interrupt won't actually be recognized until a notification IRQ is
received by the vCPU or the vCPU does (nested) VM-Enter.

Fixes: 26844fee6ade ("KVM: x86: never write to memory from kvm_vcpu_check_block()")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20231207010302.2240506-1-jmattson@google.com
Link: https://lore.kernel.org/r/20240607172609.3205077-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. Prerequisite for the next patch, which
  folds its check into the vmx_has_nested_events() body this patch builds.
  Applies cleanly. The for_injection path still returns preemption_timer ||
  mtf, as the previous 6.1.y body did. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7d8e18dbe..ad07e83d2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3953,8 +3953,40 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	return nested_vmx_preemption_timer_pending(vcpu) ||
-	       to_vmx(vcpu)->nested.mtf_pending;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	void *vapic = vmx->nested.virtual_apic_map.hva;
+	int max_irr, vppr;
+
+	if (nested_vmx_preemption_timer_pending(vcpu) ||
+	    vmx->nested.mtf_pending)
+		return true;
+
+	/*
+	 * Virtual Interrupt Delivery doesn't require manual injection.  Either
+	 * the interrupt is already in GUEST_RVI and will be recognized by CPU
+	 * at VM-Entry, or there is a KVM_REQ_EVENT pending and KVM will move
+	 * the interrupt from the PIR to RVI prior to entering the guest.
+	 */
+	if (for_injection)
+		return false;
+
+	if (!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
+	    __vmx_interrupt_blocked(vcpu))
+		return false;
+
+	if (!vapic)
+		return false;
+
+	vppr = *((u32 *)(vapic + APIC_PROCPRI));
+
+	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
+	    pi_test_on(vmx->nested.pi_desc)) {
+		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+			return true;
+	}
+
+	return false;
 }
 
 /*
-- 
2.34.1

