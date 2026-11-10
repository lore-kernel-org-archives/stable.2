Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323562;
	b=kMkoMnLJFrnWWn6sgG93FvlrFpIzx8vPcoOLzoNWS9uj9LVDEMP4aBEFciNR7vU/umlL
	 Mgx/mErUny9FN1cSJwLlb2+LTtfqJ+HRdP+8dPhFAC0YdhvZ1pjoGpNpY30unB3eOi70b
	 3aV/w/8ifD9q5UJLEH57yzKRhs+x4hk0rJwsThGVfaIxrS+QI51ABRVDjIh03FSopaVzS
	 5TWDWp5OVzYCrv/1j0GYUyRUZuMN43QUtQYV/fhOgKEFyaHqOtWYEMU3Qy8pDe1QbDI5a
	 UvwA3MQZR5SsPdd+qi90kMPAVV7eTvp0GvLIWkVm7PXlV35sz/BsJJLZWAMn5Lrp2hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323562;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3ycj0X5RrYKeShp/N/nyaHUN5bopHiUvutRQXr+Ohy4=;
	b=lufMcJM08dJ9aFBf/r5tLipl/A4VnkvL5M8XKVAOPWBXjiud5UAO/KOF2swCDgxczdDx
	 wWiBcHbXkWaqbgV2vBVD+5h/KiZUktKOAT113DjD1uG9WRS8oJn0Jw1wOq/Xdzkt0zPjj
	 1x+FHKciGMbGJwNsmfZIEGNwIDYqxtFnpm8hURu/QLdmnbVZrT80ugQy0/zlrIe6UPpX8
	 6f6zhS9tIHwjnNljAFtTomEqj97daRlFFgwDGePvHcCVVs886cDR52t24yrjyvpethirZ
	 POcgZWyCtW+Ml4FYv0VXt+Rdzf6rKbc+OC6h5MTaZclvuioahHWafQGUGrYhlS052kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMKI1ag+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A4606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMKI1ag+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91981F0089F;
	Tue, 10 Nov 2026 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323562;
	bh=3ycj0X5RrYKeShp/N/nyaHUN5bopHiUvutRQXr+Ohy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMKI1ag+aMq+PQrxwC9xdfqzrHONYmpq1HErVOdcBEcEG0A7nRdeny2SIMLi5ZAER
	 qYOR2uAcQ2upxSFy0d0ZF6pSHO+E5dDN1BP5R7ciekysYx4yaJvBHnn22/1a0tCrul
	 TUyWCaXgJrxfK7nFu4vxGOKWvuatFONq84LNbAt+IRhdg/dS28esgZpyNaHOGkvu50
	 v1dLay6KBN7OlkvjKU2tmTxOFYjFwEzLABC5C25kJtyIro+GUUJSxOrkhlBVJGT207
	 XwzJd/pQZHEoUUBbjTc0mLda+ERjOXzqA42OwlYaNz5b94EuRkb3ms4BURf8AMl2x/
	 EHoD2R44xJBSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: Pin the host vCPU before adjusting its PC under pKVM
Date: Tue, 10 Nov 2026 10:12:40 -0500
Message-ID: <20261110151221.2022005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050808-failed-6.18-a2bb5f5c67a9@kernel.org>
References: <20261107050808-failed-6.18-a2bb5f5c67a9@kernel.org>
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

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit a2bb5f5c67a95ac97fcd6859dab51be421cf26fe ]

Under pKVM, a page the host shares with EL2 is mapped at EL2 only while
it's pinned, and the host vCPU is pinned at its first KVM_RUN.
KVM_SET_VCPU_EVENTS with ext_dabt_pending reaches __kvm_adjust_pc() at
EL2 before that, and dereferencing the unmapped host vCPU panics the
hypervisor. Any process holding /dev/kvm on a pKVM host can trigger it.

Pin the host vCPU around the adjustment when no hyp vCPU is loaded for
it. A loaded hyp vCPU implies it's pinned. A pin fails only for memory
the host isn't sharing, and the request is then dropped like any other
bad host pointer.

Fixes: efa1368ba9f4b ("KVM: arm64: Commit exceptions from KVM_SET_VCPU_EVENTS immediately")
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261001135711.1640520-4-fuad.tabba@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: Replaced the unavailable __get_host_hyp_vcpus() helper with equivalent inline checks in handle___kvm_adjust_pc(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 6e7547b7ca432..1363758035bd1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -385,8 +385,34 @@ static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+	struct kvm_vcpu *host_vcpu;
+
+	host_vcpu = kern_hyp_va(vcpu);
+	if (unlikely(is_protected_kvm_enabled())) {
+		hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
+
+		if (!hyp_vcpu || hyp_vcpu->host_vcpu != host_vcpu)
+			host_vcpu = NULL;
+	}
+
+	if (host_vcpu) {
+		__kvm_adjust_pc(host_vcpu);
+		return;
+	}
+
+	/*
+	 * With no hyp vCPU loaded for it, the host vCPU may be unpinned,
+	 * and so unmapped at EL2: its first run pins it. A pin fails only
+	 * for memory the host isn't sharing, a bad pointer, so the request
+	 * is dropped.
+	 */
+	host_vcpu = kern_hyp_va(vcpu);
+	if (hyp_pin_shared_mem(host_vcpu, host_vcpu + 1))
+		return;
 
-	__kvm_adjust_pc(kern_hyp_va(vcpu));
+	__kvm_adjust_pc(host_vcpu);
+	hyp_unpin_shared_mem(host_vcpu, host_vcpu + 1);
 }
 
 static void handle___kvm_flush_vm_context(struct kvm_cpu_context *host_ctxt)
-- 
2.53.0

