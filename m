Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673723BAD88
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627933; cv=none; b=PZSzYOfLAwWAvSjjXc9o7NAicy/SboB5VpHpM27lELj1vdOSRHJMP+kGBpbfE2dsdLXI5YrYle5MQdNvImIrmua9/ng6m+fp6wlvK59A7yJwPe9YdrasOH+7NjkwEwBwJYB8RQEjhAvH42mIwR+P9zq+s4929qIDJyFO6UIHDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627933; c=relaxed/simple;
	bh=rgqtZ08ESGo4HD8U3EgHnpgnxU1Ziu0XRdcagGuBXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQYC7QKYSnuPfI3IYEtysfGRKVl7VkaiLXdCvRsuvRGkRF2Vkm9HgOKkri/XEVT+mUDV72WiOji2c7lefHpFmlO+K6nMaQVXsq3iiGO6TXDV9YTWBUGtHgwrmgQyXW595s0aff7nrN8BhSp22t1vk6xf8s0ZgIAIzYnHDYUnjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKI3Sas7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKI3Sas7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08751F00ACF;
	Tue, 21 Jul 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627931;
	bh=QNo8HM0FOzi/XZvr913kQKbpJ67+DMtbx/kx6tAMOuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKI3Sas7WmIEXxmUzSwROoEdk+vforBuNtOdIlW9fzZA18fB8+CXjx85mzmHb4g87
	 kb6bqICReAFGxbVD0xkAR5gfkAYK6wO24gIDC0w9Z8rKp638Myo4zJj9dQRypJZoKa
	 JFZBn56qsYMOih/6EogoYqYZeraW3RQ0A7UbLEV1j6YvLl9n96gXBRZb+3PsJcEfAf
	 QwNhwYBtAdaTmp/wVSW6M95KCdrWme2EjQUni8IfsJVhw2S0Xxel2xLVCLgQHZLtPy
	 Ta4B0vnyY9wVnlw8iAvXmG89ahF+h9jxKUBPCX7t68umK/UPlGn8CSVD+6XeCAww5b
	 gY19cprGf0Ekg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7FR-00000007A0q-1Jh5;
	Tue, 21 Jul 2026 09:58:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH 6.18.y 5/5] KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
Date: Tue, 21 Jul 2026 10:58:41 +0100
Message-ID: <20260721095841.2845371-5-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721095841.2845371-1-maz@kernel.org>
References: <2026072033-frigidly-corncob-3b28@gregkh>
 <20260721095841.2845371-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, joey.gouly@arm.com, jonathan.cameron@huawei.com, oupton@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Oliver Upton <oupton@kernel.org>

When constructing an L1 VNCR mapping, KVM unconditionally uses cacheable
memory attributes, even if the underlying PFN isn't memory. This gets
particularly hairy if the endpoint doesn't support cacheable memory
attributes, potentially throwing an SError on writeback...

While KVM does permit cacheable memory attributes on certain PFNMAP
VMAs, kvm_translate_vncr() isn't currently grabbing the VMA. So do the
simpler thing for now and just reject everything that isn't memory.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Signed-off-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260618234207.1063941-5-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 4bd7dbe0b2243e6aa735cae4d5e1ff988b30b2a6)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/nested.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 0e418975649f2..10da38dff8b91 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1271,6 +1271,17 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
+	/*
+	 * FIXME: This check is too restrictive as KVM allows cacheable memory
+	 * attributes for PFNMAP VMAs that have cacheable attributes in host
+	 * stage-1.
+	 */
+	if (!pfn_is_map_memory(pfn)) {
+		kvm_release_faultin_page(vcpu->kvm, page, true, false);
+		fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
+		return -EINVAL;
+	}
+
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
 		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
 			kvm_release_faultin_page(vcpu->kvm, page, true, false);
-- 
2.47.3

