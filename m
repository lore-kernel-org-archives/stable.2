Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629604;
	b=Hu4IOZkxOCwf/hUFoj50GFrshAYHZioa28sBFMAeMTvVbNtJKp9xmX+gk0pqR+WDbB4N
	 mLtW/1jRKZ7NRsJJV/r/XkqxwT1YCkTFxpkgO631bJY5e/FRqwCpmacHof97Jd1Y3wY9M
	 xsByx6O5U77ayhhedzYTtdteHlbqaaFCeTE2U+Uv6zFP+L8Oj0XbraGfyYa5nj2TtIau8
	 FHqN3lOXT1sjKm5q97sAVQUwMUnO3tAiF1jSjuBClPLASBA67kJvfgfSIV8ENs7GbkIVw
	 0d1fovdDO6jJeH1rcRVYpfgEChDvLwwk3fkeZwKeGmXB9EWH+IoVjt3sH6+9LSNuytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629604;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6qsK2r9h3Zo1EhDqEAi2pP0PpDw9rT4YRBSAys5kjRo=;
	b=G5tQQh7+3nf2JmXgu+jqg31ZiHMbWU5p+4V0rtdWgeQsYduCBTEA/wCVpsFHUGsWuoTX
	 +bmeS1I9fp+X+ei4OXEJpxThqO352P1sBP9TsikHU7m0O9/BHR3VuBoouQOE0BCZepFei
	 zFK1hPVuZdICsTyvaaP+7nL9nTF2WOZAaUg+KqvHjynOPnuITIIgp5zP07urc8g7Oijpg
	 H67cosMfZNBngwEGxVtlkHR8UsZescr7PAsRuei+V4jTfiRJVr4wOE0Bj/HcNLZa2w9Kq
	 TLn9OaDvVN28keZlUJ2UhYOkaAfx/bnLwpVxciU0kOSyUZcXI6X85+GZyAGxetd9OJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDVzi+xU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAC606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDVzi+xU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C131F000C6;
	Sat, 14 Nov 2026 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629604;
	bh=6qsK2r9h3Zo1EhDqEAi2pP0PpDw9rT4YRBSAys5kjRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDVzi+xUAonVCM0jC6EsWqsTeSjOYWZL+yWzSZjheY5l9XgOiITocSbbIW3TJOMVl
	 vdpxl7quVdh2bek9OIQA9l7XssQgHJt/FOeSka76WQal3z01+hLSwvWS12DGqgYGxZ
	 9x7ZdIzIAa1DpK83zQWlXtEdK9//4TVrPgAwadCZUQGxCTyMXYRvSgVeLoY3SmmOtl
	 YnxslQ+OrqvXhyOWTl42VCCFHI5sl/UPSqZpmeHgLp9eEwc54gkBgC88BeBldJ8QQC
	 K0RF+3sLq1fAwu7H4CebodiH2snSuomCuStIiNV53IfHdMUY/A/S2xxaPhkBUIxj+q
	 qYHjT/U1BdSQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Oren Yomtov <thenameisoren@gmail.com>,
	Chris Mason <mason@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] KVM: x86: Unconditionally reset MMU context when emulating INIT
Date: Fri, 13 Nov 2026 23:13:19 -0500
Message-ID: <20261114041301.2801291-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114041301.2801291-1-sashal@kernel.org>
References: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
 <20261114041301.2801291-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit c7c288d178cb0b78d3464a616b16b1aa0b316049 ]

Force an MMU reset when emulating an INIT even if paging was already
disabled, as the MMU page role includes guest_mode (L2), i.e. an INIT while
L2 is running with CR0.PG=0 will result in KVM running L1 with a stale MMU
context.

Alternatively, the reset could be scoped strictly to paging being enabled
or L2 being active, but SMM is also encoded in the page role.  Even though
it _should_ be impossible for the vCPU to be INIT'd while SMM is active,
there's zero value in not handling SMM.  At that point, the only scenario
where KVM _doesn't_ need to reset the MMU context is on an INIT with the
vCPU running in Real Mode or Unpaged Protect Mode, and while INIT in those
modes is somewhat common, it's far from a hot path and re-initializing the
MMU is not expensive, especially when the role isn't changing (KVM elides
most of the re-configuration in that case).

Note, like the Fixes commit, this bug only affects nested SVM as INIT is an
unconditional intercept on VMX, i.e. it's impossible to emulate INIT while
L2 is active.

Temporarily keep the guest TLB flush when CR0.PG is being cleared even
though it is fully redundant with the flush that is emitted on all INIT
events (KVM itself only does RESET when a vCPU is being created, i.e. when
CR0.PG must be '0').

Fixes: ed129ec9057f ("KVM: x86: forcibly leave nested mode on vCPU reset")
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Oren Yomtov <thenameisoren@gmail.com>
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261022015407.279870-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0529a4b417415..e2b8dc1dbb39d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11422,18 +11422,23 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	static_call(kvm_x86_set_efer)(vcpu, 0);
 	static_call(kvm_x86_update_exception_bitmap)(vcpu);
 
+	if (old_cr0 & X86_CR0_PG)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+
 	/*
-	 * On the standard CR0/CR4/EFER modification paths, there are several
-	 * complex conditions determining whether the MMU has to be reset and/or
-	 * which PCIDs have to be flushed.  However, CR0.WP and the paging-related
-	 * bits in CR4 and EFER are irrelevant if CR0.PG was '0'; and a reset+flush
-	 * is needed anyway if CR0.PG was '1' (which can only happen for INIT, as
-	 * CR0 will be '0' prior to RESET).  So we only need to check CR0.PG here.
+	 * Unconditionally reset the MMU, even though super strictly speaking,
+	 * a MMU reset is only necessary if and only one of the page role bits
+	 * is changing.  All of the CR0/CR4/EFER bits effectively get covered
+	 * by checking CR0.PG=1, as CR0.WP and the paging-related bits in CR4
+	 * and EFER are irrelevant if CR0.PG was '0'.  Subtly, if the vCPU was
+	 * in guest mode (L2) or SMM (although emulating INIT in SMM _should_
+	 * be impossible), an MMU reset is also necessary as "guest mode" and
+	 * "smm" are both encoded in the shadow page role.  As a result, the
+	 * only scenarios where an MMU reset is *not* needed is if the vCPU is
+	 * in Real Mode or Unpaged Protected Mode, and micro-optimizing those
+	 * paths are not worth the risk of running with a stale MMU context.
 	 */
-	if (old_cr0 & X86_CR0_PG) {
-		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
-		kvm_mmu_reset_context(vcpu);
-	}
+	kvm_mmu_reset_context(vcpu);
 
 	/*
 	 * Intel's SDM states that all TLB entries are flushed on INIT.  AMD's
-- 
2.53.0

