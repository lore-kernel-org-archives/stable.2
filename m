Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046091;
	b=mFcTvEXjC5YzH61tE9RReQIqbzurMOcev4+86+ExLKpazS33021X4sf1i+eGYIckTPXZ
	 vDHnWKUZw4fK8EqnGVSrrbeTbUZCF3YAu9egIb2nCmnNulUckg45QKLMsoJ+tRDuVDu26
	 IOwhgC7TBn8wVmg7hPHIsqHi3gjwT6qeMtRHPCENpvkfvJ3KV2QWM3cGAEDKAeWDJGrnF
	 aMcVnNeidW4UBV5MW8TcUHxiXH+BBhFhTaO39E7MVQhYsjwKVOyU1Q+wGC3tcB7FCuRKr
	 ezT5lnbjFq6V3Kb/q4t8t/B9SwFpjR2JHHDoL6CVMRMBROgAja8h8lOaHHJSWsxlmCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=edvjr8eW6eRlyFsYT8YeSGYM9Zb0Al1ozvckj2fuC0U=;
	b=35zYxogNdtqTvxu6bJ4AImYjROyY45kcSZyI/bowbpVUcyNXt+r9/pN6FqmoGUcwX3HU
	 6wHPQiD4XiSZ6qLD0QILsZBaqYuEgJSs/pQ0FZboLVgMrGUtJjHP29R+lcZGFHrq9mEZY
	 jUMOUnnkLyJRu/pQkuABx+iRl6JIjuS+OjbycVzVO8idvpYxwR3rCW6O+Tn03D9UMPW5A
	 ZBjEvOaXP2/80uJSnsRc9I50j6hmKEboh/cH98QIth1bljO8T/BB2QqLVCLPq7aekUwEc
	 S0+6/3xZYaddaXlyKBw9tU5eF+0hXYWB3SJA1jkJClWuP3nljaiU6I/BdmqSICIA6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHRsDtie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF452606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHRsDtie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115661F0089F;
	Sat,  7 Nov 2026 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046090;
	bh=edvjr8eW6eRlyFsYT8YeSGYM9Zb0Al1ozvckj2fuC0U=;
	h=From:To:Cc:Subject:Date;
	b=jHRsDtie7WM4v9jzgruJVrS9Nfd/D5yHs+nkLZwWL5jtWHzAYLBLz0LTbu+J4ftDl
	 erHBQyB1OSUQzxiC5+ysyVFopq1GQ0rZT6OC2OQDVB/vFybmbiVkFqLmoYKZ3r60jJ
	 hSQwQGEDUT7IRqWM6XZgec07ICm+07babxlXYJZRK6KpQN0stBaPEWBgWILyTadSPN
	 tEmx6USKtRcDXVAOt+4qAoe30BrpZGVtR6MdIBgtLe0UtoSWPnJy11YhrGMUJoKHSI
	 7seN5QIK30C0/WkJGudzRa8MYDIali7DrKiitCll7e/dAQ2UMHIMwlRBWg/6DoHx4e
	 DWslHzooQj37w==
From: Sasha Levin <sashal@kernel.org>
To: fuad.tabba@linux.dev,
	vdonnefort@google.com,
	joey.gouly@arm.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Pin the host vCPU before adjusting its PC under pKVM" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:08 -0500
Message-ID: <20261107050808-failed-6.18-a2bb5f5c67a9@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a2bb5f5c67a95ac97fcd6859dab51be421cf26fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050808-failed-6.18-a2bb5f5c67a9@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a2bb5f5c67a95ac97fcd6859dab51be421cf26fe Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 1 Oct 2026 14:56:56 +0100
Subject: [PATCH] KVM: arm64: Pin the host vCPU before adjusting its PC under
 pKVM

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
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index b6bfe502bcd04..8b9d76e5336bb 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -546,8 +546,27 @@ static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+	struct kvm_vcpu *host_vcpu;
+
+	host_vcpu = __get_host_hyp_vcpus(vcpu, &hyp_vcpu);
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




