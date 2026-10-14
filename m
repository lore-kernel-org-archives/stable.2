Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DEE47D464
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013331; cv=none; b=TsBltKjOKigEgH4ryxFvJUr8AViq/92XsdOGdvj36YZy3abiUeJRrU5CWTV1j0fT9uVFMmGINyr8m5lER7oczUCWZMmi4cN+mjRlH2+6EJ+a/fZKzglG39CpZlCFLAnOWciVRpHCTSXq4JaMd+ZvJE5/W8KqdXmurQHTVzDt+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013331; c=relaxed/simple;
	bh=R6wl2fGwWtmLnbg8EOaRzIO28mHOcCe3Uhvi8eqzJ6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oel4qK10mDGJpVfrfjnYexLS7p8Qrtc2L0GDdD/1cPdBMKnvaCFYwSFDtiPIv4B5A3zt3H6MMgVRl6rET33jk9aiKjpEMFEwCXdRRnPCJ/GJ7QTgRauTUUP17YSVb3KfLVyrzqOKv4jJ2XS8qkwB6XEPLow9Ez3KlMJI/2gKEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGvpqqqQ; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGvpqqqQ"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so1424121eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013329; x=1792618129; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=vGvpqqqQ7QFFib0SxY+pHjzDaH61eGdwfZEcTQZz9KFYlwOVvtqWbQ3Y8rNJCSOBgy
         Aot6qLUndzugGPHNKXCuj4IZybutJpPkVPuuRP0bwl6+QLr7Zby647IIQrlvJ2pY/r5s
         tloCo8kDN0FqutIfN1R3ykXccMyDZMDCzoES7UFOzMKFiP+bmtAoc7x69Pt18yA/wtNP
         GRsfl8weVAHkxVXh0zqYuA5P1glRxQXpd6NlM+Ix3l2gKZao2RE53GADcnrG153juH5J
         O4006wnFeaRP3cC4WFboUVPssV4IbAfhIivWJhmBrVtGGUPv33oD2KW0/J/sgNp9OWw1
         qsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013329; x=1792618129;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=jVtPHTV9CUAk27DJ3kSZZvnzyodlw4c81/+7I2M0toUB4+bkSBP6yNT8fVARXY/QeC
         4ZeVKU6mkMHBdugPSQ6bTTw+6zZ2eIenKtUCfqI7J1t2fB2mFnHi72XhUXyj5flve7h0
         stCVxaMxIu7+CS0wgMnZqfJZIJn6b2B45/Ya2By/Bu699jHn+w0KfjC/Y2G7J7VhvJ+S
         WrgeHh8VwXqVRPRaqbeK8OEfHICjkKPSEndiHFGLHuIi6SnbxKzMcNU4BDhs34Gy0Rvt
         l/YDDiedXUo7mv2Fy1nqhML8NXak7wCX+sZ8EjWvGr1QrMwVBZ3snp4SWq9Ms45cjOWH
         W/6A==
X-Forwarded-Encrypted: i=1; AKwUvBx/5osZRy9sQgWr0iaoeufcV2K3T05FrMqDSqFbFqM8QbkgC3KF9o1525jUryJkTYir/6XbBb0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIvn5dz5aUIdEhIs/E2eLMKGBS1YmBjSvop7xvKgYzK4x9WBqQ
	JTtVsPEII1xQy6Nx1JT2yapg1x09lhGvSvbGyiQEx2cMGG+piGUfKPo+1IEYhAdWeWaov8S7gy0
	GdJ+p8Vfuf6sIAA==
X-Received: from dlbro12.prod.google.com ([2002:a05:7022:158c:b0:161:df69:3983])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170c:b0:145:5c7:7185 with SMTP id a92af1059eb24-16a10f299a3mr21574008c88.5.1792013329102;
 Wed, 14 Oct 2026 14:28:49 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:41 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-4-aaltinay@google.com>
Subject: [PATCH 6.18.y 3/6] KVM: x86: Prioritize CPUID faulting over CPUID
 VM-exits in nested VMX
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit be7fd7c3e8bcfd3a1804567ce5cf9ca3b254c1ba upstream.

Per the Intel SDM, "Certain exceptions have priority over VM exits.  These
include invalid-opcode exceptions, faults based on privilege level, and
general-protection exceptions that are based on checking I/O permission
bits in the task-state segment (TSS)."

Ensure that when L2 executes CPUID at CPL > 0 while L1 has enabled CPUID
faulting, KVM intercepts the exit in L0 and queues #GP rather than
forwarding the CPUID VM-exit to L1.

Empirical testing confirms that this #GP has higher precedence than a CPUID
VM-exit on Granite Rapids (F/M/S 6/0xad/1).

Fixes: db2336a80489 ("KVM: x86: virtualize cpuid faulting")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513224608.1859737-1-jmattson%40google.com?part=3
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-3-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 97ef2ebc2477..3fb9a8205083 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6637,6 +6637,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 			nested_evmcs_l2_tlb_flush_enabled(vcpu) &&
 			kvm_hv_is_tlb_flush_hcall(vcpu);
 #endif
+	case EXIT_REASON_CPUID:
+		return !kvm_is_cpuid_allowed(vcpu);
 	default:
 		break;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

