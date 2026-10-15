Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA338F64D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080253; cv=none; b=Qu4zy85ku4Ogn0glYV7PwqjV5eTDaLU4yd3s6kLPQA37ae+RkBRv0ESonV0Qtab2dLewc6ITsU4ZvNuFQjxxf01J1heOZnOPbbcM8V+fw4bizYy3E9H+NzKzvIJYGHiHEwBgUICB64a36ssVBwsXU9pa14GEwqxnbQGab1xq7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080253; c=relaxed/simple;
	bh=R6wl2fGwWtmLnbg8EOaRzIO28mHOcCe3Uhvi8eqzJ6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3Bvnx8EBCzbh5TF4ElqUhdx5VJTr814bdY4AJTLgM28hBXzIkAvweX931LXH1fmD6UAvXds5NfDVxf+uDQul06STnUQACzNIT9UTL8Re471Gx3vTDZb/RQdICHcBmMWbut3fVuJRZoRWBC2QhbwvYF5mddzQBxcjI7jvH/Dau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3W8dUiM; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3W8dUiM"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1665200f4c2so7573244c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080231; x=1792685031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=b3W8dUiMj4wgWG04nTkt7SxeUZzn9AljdG+bKJ+7S5DtZASr19UfFuP/hcXCiQKjtZ
         b0HLABLA+qCB7UojPpWMg78tsFEi7D3B9xfpyEylhjSVQ6kTIL2oS7sSPzhYcyAN3fVV
         Y2oyNf75dkzAlQS6yaqwQSVZeBF8G1E0moR3XIenz6p66KeQvb5pucdBNMmabsxWulEk
         SBUmE2KIdeG10LaNbeebvjFcLuuF7HWO62hNf/9GeY0At39h49xxK6ai9BMtKZS7Rwf4
         YWv1TwVum0WsL6AxnE4l4fQsrpkRGuYxGgsF8CIN/rBMiPYJQaZAt5dojSxBcFptrkgj
         UumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080231; x=1792685031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=acUWx5qTIT9J7X4cjHVO/v/VkSTv/pr7FauG2Txpg7t/zEzMKeCqLIPH/cfX0xYBoI
         +a5oYa5ozs7WXWbJEhEMv4T9pMI0Ys5r2/SgCNOAGWR/1rORIeGwp09z3/hlVD1v9+mD
         MJLIoWKRsezYV1qp8MOCnGrabN3ftIo8eIqPeTDShuFj70cFJgV5EMwMzBBhkFt+f1xU
         AuiVjO37/JTRi2q+oAlLbw82Z0VJW7dQMZf6OrEtfjSQAO/rqTbwWmey8AR49nXOM6Ha
         avGXELrIedPYteuYeQ0DL2YzXXkpchih/kwmQgbupsx599tsyg+CVMZxF49+BTr4xmGa
         81iQ==
X-Gm-Message-State: AFq9FYIrcvBmT8Z/Z6CbWTTVYpybfaAA9h9NXvTrclhs5BW6YllwtU/i
	kaWqyoD859g4ssN7C6/QIDkGGGz/jvBAGVngNuSFY65JN4a2E9FLEkFs1PMmJ7jT0BmFTN6TnxE
	N28jIA8t3KwceGDcRnrqx4EQJwoK9Spmyb8/wy9BOmMT7Q2egLgaMAG8IPFBrUqjsNAj/tOVday
	IyShwSG95v5FDvZ3rpIPqXUlc2CcHGh0DqqkBMvBj+B5IbZAs=
X-Received: from dlah4.prod.google.com ([2002:a05:701b:2604:b0:17e:b14:46c])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2605:b0:14a:5284:1bf5 with SMTP id a92af1059eb24-16a5adfbe99mr28872690c88.13.1792080231021;
 Thu, 15 Oct 2026 09:03:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:43 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-4-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 3/6] KVM: x86: Prioritize CPUID faulting over CPUID
 VM-exits in nested VMX
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
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

