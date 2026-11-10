Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273716;
	b=gkSiZmesduTCeTDZzuwBwVFAKnNxWILjymlgj7hzFnUHFVE5rMV6sh3derYnWFYzBeOo
	 SiL/TMQRrB+LnwdnD/qIsvlQ8Dd63tiP82NIUD7p9RfFtinwPxIDG1YnpfxEUDBqRAsdJ
	 dwWuXySeFDbuIZDZJ4ciSJEdhM6+1VSg/J9UEPyiIi41CrM8RrQxuWrUokqne/F5jYed8
	 1qS3ToJvpw7CT/jW2DoXH7RHevs0Ql137I5+X26IcpLQPBprgBF9p3gCadzMyZAauyrW6
	 GJ0Eo/+QnodC340wDley2eJyvZFBMTolg7iuDvZQ0U7n43VvM9asVJOFc5XOUAiUE4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273716;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nVwzOpR43KUqEXN+I2H4gU6V+1Vhhf7Ca9x24Lp9Iuo=;
	b=iRikOzSMdHDbLmSJThucmOMLpEBZ7tHKm6dCUhS3x5OL0xNqxbg86d47x+9z2fJt55Jb
	 BHKmJjZBun5xY5IvPKa5kJUMYUa4RchvqjIqlbYpkx5GzFTpyg4ptpy6v14MlkNcs1jX7
	 Bi+Nee33BEXc3n6poQYtG0MhgmXz5Uh4k0Usx5uFlkaDwwOntXeHfscv2p0g0+5s21phi
	 /bzkhr2auj1ApJyK993WM+WJBtb29uzDt/jcmFbxjX+9tLrIO+gd3BbVch8nok5SfwPgn
	 nh0u3cm/8dOxq41DN5ZhdVMszC76DWdAHX6P+4vsFHRcjfkKRqjTAtfiGkRC1qnwh8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyZnODpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F160A260E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyZnODpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D121F008A7;
	Tue, 10 Nov 2026 01:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273715;
	bh=nVwzOpR43KUqEXN+I2H4gU6V+1Vhhf7Ca9x24Lp9Iuo=;
	h=From:To:Cc:Subject:Date;
	b=GyZnODpyCMuO4QC7w801/TgJOjUPpNOC+/HmNiwyM1UzfqxyZmEy5vXlUrCuNS7iB
	 4uTMoVErLUZ7kxyknPzjtx+ffsEZh9ZTp676hOAUULMBy9NDjaQpoSvbuc1k6vJ/Rg
	 Tu8GtfLSrfPGmcTP2HA755gFU7NTb2wcbmsiKquvejaX82sLFJWU5sotR90fmU/mm1
	 1DiUY61YXCVIKTt9UddjZ5xH0Oh6Po5kc11ebNbb4EeTTIJjLa6VL+jjmF/sYV5wcA
	 VBUXUxQ9QO0zACKpNbJtzPy+ePw5J1udVFLPg95ueuOdEkGNc/+WhXW33CswVosPQl
	 ANvCkgjuY3sRw==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	fane@google.com,
	thenameisoren@gmail.com,
	mason@kernel.org,
	yosry@kernel.org,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86: Unconditionally reset MMU context when emulating INIT" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:53 -0500
Message-ID: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c7c288d178cb0b78d3464a616b16b1aa0b316049
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202153-failed-5.15-c7c288d178cb@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c7c288d178cb0b78d3464a616b16b1aa0b316049 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 18:54:06 -0700
Subject: [PATCH] KVM: x86: Unconditionally reset MMU context when emulating
 INIT

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
---
 arch/x86/kvm/x86.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c4a06214cde69..09c6df00ebb6b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9731,18 +9731,23 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_x86_call(set_efer)(vcpu, 0);
 	kvm_x86_call(update_exception_bitmap)(vcpu);
 
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




