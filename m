Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550712;
	b=o4MoE6nlNaa5O+inVj+9qUu/e4+L41AneFVYp2SbfgQoYyjRafj3Iw220JwaEXL1IQOR
	 MIe8wqAXlO/6gruhnX0TtO434yAbCLnT2Aeg3xyVe+cHykZXcvsaft670rNWQPGrId7/x
	 RT0WS6eaL/rREjhIsB+yH5xkZjpkb7yIBKFzPOTDq1px8TfgYp3AvgFzmy5XXiGn128p3
	 K8LA64RPlSNjXGGFSJ98qO2ftqOtu+h3jk67Ck7agx2Vyg4g6MpFLRJ9/nQWnaY3iQa5F
	 OgYjbeu3MCbcE0NsPBFeeUTANyIiLPCHsJe9MLwme2UxE48PzZnPapBqCOivRWTQlNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+tauiOqnCXDgcbvvq5Bl94S/eGCeAxzqV2Ktb1RLFsI=;
	b=CnVuh71rMc0YKFNZaCxNw6c42BPtyID5m8nE62ySpQc+NxTJCnYwXyEG/rvXmhVXSEQH
	 b2pcuSI+CgzLQx18zqeS9P7njh+KKaW99icWm23dbAcKdjqMc/kcg83g/A9v93+fBTexh
	 gndvv4+QKvARJmn12WC6HdEMiFMLr+TmsHZPn+A7OWW5Q4qZ/WBHEKDDZAyJh8pmnH5lH
	 HgRqs6YOxKG9hfaSGP2K6UM/QxOAr8rRf9ubHlweQVREErhz+rxo9JSGW+UL2tw8OPqbj
	 L4An2IxC7/MnQz8+PNxsA59IB+5IuZfh5uV8ujjEHxOhvF1WI5MkdA+ye+zZwK+nwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VhWPS872;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28905606A322
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28905606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VhWPS872
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac16335199so289425a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792550710; x=1793155510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+tauiOqnCXDgcbvvq5Bl94S/eGCeAxzqV2Ktb1RLFsI=;
        b=VhWPS872V3SaJwVsvLpovRvdXmv2n/b1pm+f2t4ZHPMT0W32bYjU1pIVoGtgR/7gQ1
         /8M7E9K1Cq+3vlIVhNeV05VJMruyKTM65w0Uevy8v3dRzw+q7V3437mhXzYOtXUkPTAu
         OcgcxU67faGioRy5a+mPK2lfv5ZuZScqImz2X8rjfNk34TkR9l+x8pIUWwNC+T0/GjJ1
         yJqNu2hI7fTWCfBtdNk+dzRCiizJ4AdibZr4tsrOr7PUN6S5ZThm5/U7/e/BpNegSsnj
         ruocIOJT8tF4QXG+7RwT84Nc1fdG1BHtQZr+6gF4aOatBAGqdp0NApxFPUwHtkNaK5g/
         IKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550710; x=1793155510;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+tauiOqnCXDgcbvvq5Bl94S/eGCeAxzqV2Ktb1RLFsI=;
        b=BpXhR9yxShgcsQ3pUCQ66NFxATBeUNpjtf9gp81X3zEQUUg2oX9hbMr9KebEP8zuQ1
         P29DFo4kw9MtpZKFwsKyasDZNU8Pa0pKfIJWw0ndYwmcQVo3V9zBNg01o/MU3KigaeAH
         K0ZmW4X/KrzE9UuBqtQJ1sk/faUZwCQgkrfTMLqGY7+nCVCQl2NSx1rP/wEjNg/8v7mt
         K5eJkFclga1pthcgUXphSEfDwK3gj7a2zB6XLZJnx0yb63JduKX3pZFKJv8m14q93KDB
         v83/OvquF1e0FC7b+b0AK49udpFGXfdVL72pzMam7MmYbe14lL9d81+sVLdYb4Qd/llS
         u92Q==
X-Gm-Message-State: AFq9FYIUcL5S6IryPhK3ErXfNMBI/ABj8r0Tvm5A7RvJKrGwj2D8lmeY
	EkRxPOYI6ATEfFBTB/RCeoGtay0Ks3QzrFuQtRcsYPqlYCWBfaDi2MCNgV3fuGjHTH2i7t2jVsQ
	cvsvJLo71PjxQAaEXQXt5D/DZRfIAv/A+cdIxZSzNuuUcwDCh6QE5CCseNpwrh36XZAILVx15Pu
	a5L+SeoWxAfbt/tSSIWEs7+b1Sz1+eo+IfzeVt
X-Received: from pjwx12.prod.google.com ([2002:a17:90a:c2cc:b0:3a8:cbf9:5e52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1847:b0:3aa:fdad:7d6c
 with SMTP id 98e67ed59e1d1-3ad86d675a6mr596941a91.58.1792550709934; Tue, 20
 Oct 2026 19:45:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 20 Oct 2026 19:45:03 -0700
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
Message-ID: <20261021024503.1732165-1-seanjc@google.com>
Subject: [PATCH 6.12.y] KVM: x86/mmu: Preserve nested TDP shadow page tables
 if they are used as roots
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
[sean: resolve minor conflict due to lack of lockless aging in 6.12]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1a4d5fa11922..9acd7225c0ac 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2500,7 +2500,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}

base-commit: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
-- 
2.56.0.218.g1ec904b173-goog

