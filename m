Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548998;
	b=I5ngs65LAJP7RAAxz5M1Y3sodXw+XRR2FLLf63qQn0Who3PURcj/PhVkewGn3zG+5EEP
	 Bv2DSX7IcXBLOFnp3IAMGi8ahiQTDGgfCCVmmx1U/Q/vm5Z01e89nL91S1Cy3XSuEgswM
	 HOW6tuZYiVk2w66GMBONG4KunBoM8TzDNMJDkj1htq6AxtxxJYO+F5RlGV6vDod41gwcN
	 tdAus5xqsBqIu8Xk73cJWltciO2H0n83K03qUWlXa/qdAiZdAL+id94PBRFCYTZCfm7ax
	 usKYbVT7cR2InrmXgtS4OdT2tHNHUbU1a4FZRmictgNcBUdzJhKu2eQ8KTNmrnyb1bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=izwf5CPD1zXW9jnIF9y/hbGc4EqNTeFdST8JcyByKQg=;
	b=j50nlcBjFvO5AckHVwo0I0fyVC1YIh0+XLdaFoQXau6GyERqKyadTYjy40kB95TW3aWK
	 y3NXxU/S1JE/psSqywhtpVZRrjfGVLDOMOgZdHOwih8YZiAWSGlJx5I5vIWEvZGo244mt
	 sI7WZPP2yGUR/Z/cbA1EY2ryXv4ibaDU2AgNjDh2f62l6iryJOTQzPwGueETLkrdt6yGZ
	 +PfV1voqYKWLPh8p66COTqWcCzyoQEgMyP6Sk6hK+VwxVREdqN064D8kqO9/nDsMd7sVP
	 BnXpYFFGIWbAQI69MiXkl6MTYpT1Jry0PEntl/FT741QLh11OI9EO0AQ93XP74itSbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glMWHuDS;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53862606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53862606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glMWHuDS
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so1119607a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792548998; x=1793153798; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=izwf5CPD1zXW9jnIF9y/hbGc4EqNTeFdST8JcyByKQg=;
        b=glMWHuDSbbg6/FatTV4WtuAda2HH5Y8ia0oWU00Ru+dV10+ooiqpN+7PikmChNpmgO
         Lcx3hn+AnaJZRdm3QiKkF+eaFdnqenNaO9QY/G0LeNJIxuq5yHWrv/O9rNT2CmGj6W9z
         4mg0gs63dAr+oc+I+/dLpptQc5LB/vGFVZqKoMIRR4LMbCHR3n2xFvx644gyAilU+mJU
         wke/8ugW1DFcB5iIuFLCC8XGjle+1iyaCOhxdzKPPhnBL/ZPydfJ1H1K9RVNfB7Zjf3i
         Bx2RhF2oMLI871mlemB97tbVMPmKTuh6zPOrfZH6NvjWM8nyXg+VdF1WlIZRwaax04/m
         rmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548998; x=1793153798;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=izwf5CPD1zXW9jnIF9y/hbGc4EqNTeFdST8JcyByKQg=;
        b=15iZxlfKzrewSXKDRgqv4gpe0h+6GjJAdMxJdi2DbrLyHHWvx/NOlg9IbnbipxsTJu
         KmWc2nxBvS4HmrxwR1KJ4pYXVGHEVnKaNOP4sbQppuoIWFjsrjgLnxcKDlFwqDmouxf8
         OzG5HU0uyvprIyX7M0v/ECMmlLfyD0Eman+uM1TQXKWFsiq8wbKaauDNkHja36t7i0HQ
         cq9vMmnQZtR6DqjOCKNi/Z6k1YDWURHbRAMK8WUzeOi6d7dkNV/ynZ7xwWgS0wbnidJj
         cD86twWh1WX+3KLi5XB52g30fRYlNz0VLr9IOiWnw6XycXpNgfDYyf/p54RRp3QBy+sO
         DEEg==
X-Gm-Message-State: AFq9FYIjy9jkf+pJhw/W4nuBhzajBxp1uecskHiESYGGJvFzaA+fIHJo
	Rb0YcQY1CsAAsOfHHLamOGIWWsy8HOipI2c6GLOkz59H+W4SpEyk2L/LdH7GcIbUnPElYxRvFUp
	D9CP9OEQ7Fsg0vQ2J6Ll+Cs5VluVocOXJJkR1bsY2HcNIbZpv1Jm7w0h1qqfr++9x4v+gG3Rs7g
	Vah++QTR26dvohcXCp4SUqvGM061IYSbNU6ts5
X-Received: from pjbbr7.prod.google.com ([2002:a17:90b:f07:b0:3ad:825d:8e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3906:b0:3ac:b622:9638
 with SMTP id 98e67ed59e1d1-3ad86f71ae6mr361631a91.42.1792548997242; Tue, 20
 Oct 2026 19:16:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:16:35 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021021635.1710327-1-seanjc@google.com>
Subject: [PATCH 6.18.y v2] KVM: x86/mmu: Preserve nested TDP shadow page
 tables if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
is non-zero from top-level reclaim, because such a page cannot be
freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
nested TDP child has no such check. As a result, a shadow page can
be zapped even if the page itself can't be freed; as the comment in
kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
to rebuild the page.

As in top-level reclaim, do not recursively prepare zapping of a
nested TDP child whose root_count is non-zero.

Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 205d314a7583..1fa251ca4dcc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 */
 			if (tdp_enabled && invalid_list &&
 			    child->role.guest_mode &&
+			    !child->root_count &&
 			    !atomic_long_read(&child->parent_ptes.val))
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);

base-commit: 2ff600d29ee478d0a8d46ef8a58afb5e038fe692
-- 
2.56.0.218.g1ec904b173-goog

