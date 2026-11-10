Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313215;
	b=449stvvPB149lr4iXMSuiI2ruj1TM8sGtc9uZE/yGp3yEE1XS6NDohA6rJqv1/XLkunp
	 BAnJDuo8R/vjsidOdTSUFoLS8eR+FTKziZLePpkuQUs8Fuvu7VXxffarceVmIDrxdjcTz
	 7mxyC3PdaW5E2ft1+5+3kumvYzcjibo0N85XJS8dt2q2QwMjX+DjXnYBpqTe3bHbDoT2I
	 xj64ORawPVwK6RS5jhx2IfoHJUd0tLzUe9qIqdZih11pXGSdQwXbNhwttNt0VCcAAP1pg
	 bvGOOEGEecZauTxHB5UH3OZ1MJo0/1EfnrLxmPExdfbIj8Vqh8GPZJrwounUMId9EXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fWhIJQKjwTv1oyWF8claeUik4vkJxgRU6P+NOlZRhzI=;
	b=ZBe4p0KZdFiU/B03VSQre/wmzMTJXN3iind5AveFzz/tpKz3RK9t7UsqynEcFEF5i5De
	 VrxlO/Y5A1kGGWQHp/pCl2svp/D3tygKwFjtPP8BptZ4qP3GmTnJhyoCvpTSoyU/TgSNp
	 RN+8ke7zn/VORpzZ8JpquNJiXU0HZ22CUU/ANpWEdCc+t1uhFqU2ZK5OkehmyYcVwR2ip
	 t4f0fbjgUojLbh7FNo8+eTeqCVo1wPDkUK3GhOcgto5nA1jw8AL7bdinTgDFscCGMrkes
	 zkhecTOwWMZS6FIMtutgSXab3xHzSYC0HaiPVjxADCWXn33ZLwWdJneVsHJCZ2SsaKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJZU4Ddg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A1606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJZU4Ddg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1101F0089F;
	Tue, 10 Nov 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313214;
	bh=fWhIJQKjwTv1oyWF8claeUik4vkJxgRU6P+NOlZRhzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJZU4DdgzBTgipHz2ePqoPo3q/WQ6QwwkQlne8VqOCxmgEP1yl8Wmxez1TwveVjrB
	 +bRIK9T4z7CuvFkvF47t6Abp2jHTJsqsra+TxDVRU/7hTBhCroOj98lSWop/2tIBnQ
	 +EyTFFfWotVDP35lcCNqiJW1Pj6WwBcX7py1UWvvRXQ8kfHgxT1BPRql1Lfje9pazJ
	 rOoI/cG9yUCiMxmZEjBQ/73hKzcKSaUjYbnCTVIaVytXc5LbHH3BzPv3Hk/sOS8WQD
	 FdpdNy9iJnaqxOFiSeaMOX4g3sX5jWiyxN/CI/2M8clWWtMuTCn0G+9/7edrpcxFa1
	 i8I5LIc6aDYxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: timers: Compute an offset-applied CVAL from the current count
Date: Tue, 10 Nov 2026 07:20:12 -0500
Message-ID: <20261110121947.951315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051958-failed-6.12-49930b1b557c@kernel.org>
References: <20261107051958-failed-6.12-49930b1b557c@kernel.org>
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

[ Upstream commit 49930b1b557ceb698e0ab7f985ea41c99dc8bf22 ]

When the hardware won't apply a timer's offset, KVM programs CVAL +
offset and lets it compare that against the raw counter. The compare is
unsigned (IsTimerConditionMet, DDI0487M_c J1.4.3.29):

  condition_met = (UInt(PhysicalCountInt() - offset) -
                   UInt(compare_value)) >= 0;

so adding the offset to both sides holds only while both sums wrap or
neither does. A guest whose counter is ahead of the host's by more than
CVAL has an expired timer that never fires, and one behind it can have
a far-future timer fire at once.

On a CNTPOFF_EL2 host the first case livelocks: each entry reloads the
guest's CVAL, the timer fires, and the exit rewrites it as CVAL + offset
before the host can take the interrupt. Without CNTPOFF_EL2 the timer
hangs until the vCPU is next loaded, which is what Zenghui reported on
a Kunpeng920.

Program the value from the current count instead: CVAL + offset while
the deadline is ahead, 0 once the timer has expired for the guest, ~0
past the counter's wrap. KVM recomputes it at load, at exit and on a
trapped CVAL write, and an expired timer stays expired in between. The
value can't be inverted, so with an offset timer_save_state() keeps the
memory copy, and kvm_hyp_handle_timer() returns that copy for a guest
hypervisor's read of its physical CVAL rather than subtracting the
offset back out.

Fixes: c605ee245097 ("KVM: arm64: timers: Allow physical offset without CNTPOFF_EL2")
Fixes: 9404673293b0 ("KVM: arm64: timers: Correctly handle TGE flip with CNTPOFF_EL2")
Fixes: 0bc9a9e85fcf ("KVM: arm64: Work around x1e's CNTVOFF_EL2 bogosity")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Closes: https://lore.kernel.org/r/460258be-0102-e922-c342-4e87cd94b9e5@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261007074343.324269-2-fuad.tabba@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: omitted hunks targeting the absent has_broken_cntvoff() workaround and kvm_hyp_handle_timer() fast path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arch_timer.c     | 16 ++++++++--------
 arch/arm64/kvm/hyp/vhe/switch.c |  3 ++-
 include/kvm/arm_arch_timer.h    | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 754914d9ec683..89ad3aee4715b 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -506,8 +506,6 @@ static void timer_save_state(struct arch_timer_context *ctx)
 		goto out;
 
 	switch (index) {
-		u64 cval;
-
 	case TIMER_VTIMER:
 	case TIMER_HVTIMER:
 		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTV_CTL));
@@ -537,11 +535,12 @@ static void timer_save_state(struct arch_timer_context *ctx)
 	case TIMER_PTIMER:
 	case TIMER_HPTIMER:
 		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
-		cval = read_sysreg_el0(SYS_CNTP_CVAL);
-
-		cval -= timer_get_offset(ctx);
-
-		timer_set_cval(ctx, cval);
+		/*
+		 * With an offset, memory already holds the guest's CVAL (the
+		 * trap handler or __deactivate_traps() wrote it).
+		 */
+		if (!timer_get_offset(ctx))
+			timer_set_cval(ctx, read_sysreg_el0(SYS_CNTP_CVAL));
 
 		/* Disable the timer */
 		write_sysreg_el0(0, SYS_CNTP_CTL);
@@ -626,7 +625,8 @@ static void timer_restore_state(struct arch_timer_context *ctx)
 		cval = timer_get_cval(ctx);
 		offset = timer_get_offset(ctx);
 		set_cntpoff(offset);
-		cval += offset;
+		if (offset)
+			cval = timer_apply_offset(cval, offset, kvm_phys_timer_read());
 		write_sysreg_el0(cval, SYS_CNTP_CVAL);
 		isb();
 		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 496abfd3646b9..b364d9319cea3 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -195,7 +195,8 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 		offset = read_sysreg_s(SYS_CNTPOFF_EL2);
 
 		if (map.direct_ptimer && offset) {
-			write_sysreg_el0(val + offset, SYS_CNTP_CVAL);
+			val = timer_apply_offset(val, offset, arch_timer_read_cntpct_el0());
+			write_sysreg_el0(val, SYS_CNTP_CVAL);
 			isb();
 		}
 	}
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index c819c5d16613b..c468e3d177d71 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -152,4 +152,19 @@ static inline bool has_cntpoff(void)
 	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
 }
 
+/*
+ * CVAL to program when the hardware won't apply the timer's offset, so that
+ * its compare against the raw counter matches the guest's at 'now'. An
+ * expired timer stays expired; one past the wrap never fires.
+ */
+static inline u64 timer_apply_offset(u64 cval, u64 offset, u64 now)
+{
+	u64 hw = cval + offset;
+
+	if (now - offset >= cval)
+		return 0;
+
+	return hw > now ? hw : U64_MAX;
+}
+
 #endif
-- 
2.53.0

