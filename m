Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234045C6E9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125736; cv=none; b=S2v3T1rNn2eE5bmZcfqE6cvcAhgUqK/etTDpSZSKLd/EEEV/wXuahE0gECotDHV3pBWeyTHJ6RZob94blDG7qVT+uA0OZu+AnbdyA7MRkFqqTu11s1FlGH8RmP8dHKOq8I6++7rmykePKi3p7c2+N0WwlJsPkbPiPJ03GyhmV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125736; c=relaxed/simple;
	bh=hwztA+btlADmy9TLjKXHn8t117cJsHPT7/bAI9dGyWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsraSUOaFzrcnuPC+BF9UAFbHE6Fx9yDEfGo/B2vFVN19grxj9ygu482AxH9wj9HjY+tdlml9q4nAOXZl3DnpX28OR6QEMulyWE250DlEu5lNkL/JPUi01gAvuRwAMXQ4zTYJJ2oo7pzbOYYGbw1URgSBhkUF+RyKgTjNhpvwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocvIRd1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocvIRd1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C5F1F000FF;
	Fri, 11 Sep 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125723;
	bh=LGsTlaVj4k9lnOnI0+Rg2PFjWTXLTGKnqXApAmSVuXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ocvIRd1qOhUK0vZcTtYSVIv6uw7XCan01RLBuvy9KeW2YXoOEny8rNbSBheuvvD7c
	 +2t1MwR+XYonM12uOyw4vRuTUUyB4Ip+2tLK62XFCbWsk0HXRvAV2t7dqP6UGytUPF
	 flkxq5Gid1vnkj5KnTR22DZ2Ef1Jy4MkaCn0T/LyERZ7QAj9Jtm9DLyZCwpkwFO0kN
	 E2Za8Wu9OSGjM4BK+L6rsGpXzrmhykpQcHGLAn48N8pFK9PhDNoY/qD7tSRgs2bJL+
	 79IxRBzYi5qBouFq8O/8xz1NHJGRxJTl+OZE7exTSUAWHNkf4GhNJpIJi89R66b91J
	 NcPhs7UqwmeQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Fri, 11 Sep 2026 07:22:01 -0400
Message-ID: <20260911112201.351751-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090914-replace-unpleased-ddd4@gregkh>
References: <2026090914-replace-unpleased-ddd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit e62392bf39ebfdf60d1d082799397fe1cbf8dfc5 ]

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-3-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ relocated hunks to x86.c and its kvm_x86_vendor_init() because msrs.c and kvm_setup_efer_caps() are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a5a77dd0c77b3..867252433188d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -106,16 +106,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 #define emul_to_vcpu(ctxt) \
 	((struct kvm_vcpu *)(ctxt)->vcpu)
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 #define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
 
@@ -10157,6 +10149,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (r != 0)
 		goto out_mmu_exit;
 
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	enable_device_posted_irqs &= enable_apicv &&
 				     irq_remapping_cap(IRQ_POSTING_CAP);
 
-- 
2.53.0

