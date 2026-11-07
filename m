Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046800;
	b=RDHxmCeLrt68IKxuJhR02gYf+Rz7PyvqWAvV4qclVX6lGe6EOI/XW8QkxPoapcco3Z++
	 fsgfYgWh20UHWlpkigdmBnOXArDZEcCwmewRRiLm1NvOehsPPyBx0un4VBOTJBx/skdjb
	 w/b9RDuBTOSLFMdA9ek0RLHLPW+kupm1PVyICQxiVJFywWPgy2ANayMJxIpPZdIXDu+mE
	 OFusJXLmZdPHjgURPDYlepSQkxe1JxaR5KICDbMno8eS9Mv0rYUHbY4L3B1picsmHPcp+
	 NOYPdk4FRxMI/0kvt78H2SOMRv5sI7liiCPmjySv7nKRXVKYA748hYxy++gghHmZdEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046800;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LRtLN8a4DxwJ2LKgf2oFaf6cgjAqtI23X1i4wWp374A=;
	b=temJM9qGR9aejS62aLmky1sKQxZfYbtZAr0sJyfxfgIKYr3OpqXdX0KHJB7tsBTilSdf
	 QRBumpfUaQm6Q5QxlNdAxQ71W6gZB7BHHqYQ1nWUS4PK0T73LIxl2S4aKSeEM/Pzzyt4w
	 Mwu4uhDQDA0uKgsedXgKNGAGEftgI3NrQ1QqpSPi0QPI1YHW5plCIYBdqmhCn1mztpCDQ
	 8BC5gim0MY06xgkDeBAWJ0ybLQFIZwAOIDtU1FtdLvkurzpW6Jd1P2U7ee6rvNxz1H2Ts
	 y16xGvAHvTyeAHXSw6Rc8crTAqNJ1CFFuoJAZ6eqN+V7g6KcLtOOGsTKe/szlzdeCLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0kGfheU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C6606EEBB
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0kGfheU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8B41F0089F;
	Sat,  7 Nov 2026 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046799;
	bh=LRtLN8a4DxwJ2LKgf2oFaf6cgjAqtI23X1i4wWp374A=;
	h=From:To:Cc:Subject:Date;
	b=P0kGfheUf28NW9xIo3yNEI42FHmbbMEYQjqxI+gs3xp0bwB2htKzwy7pqsxAsSrot
	 rGw656i9InuLuPfTru/k1o1FLRZ3WNE0dT8WUxgeuwTt19kfuGTXAkFUk9hJpBHF8g
	 3Ui/RBB7vVpAUL7dh/fqmkzii0Jdrl/cgtKhCRY4SxF/vSMDkqzQh7EGL2vPUHUfLW
	 WFuI2FTDOm/2XWkK64k1F3Egn5OUEZEOwAbX/ipZyGVpVTdD/eDVUIWSNYy0tJWZ+k
	 5kdUJuoRk9eaDzosNRw2H09Wazz3wONkbDKsC/WI1cUDIzH1xU+s2xxIkuq/2jAAX2
	 IycWpiTrtGkYA==
From: Sasha Levin <sashal@kernel.org>
To: fuad.tabba@linux.dev,
	yuzenghui@huawei.com,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: timers: Compute an offset-applied CVAL from the current count" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:58 -0500
Message-ID: <20261107051958-failed-6.12-49930b1b557c@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 49930b1b557ceb698e0ab7f985ea41c99dc8bf22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051958-failed-6.12-49930b1b557c@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 49930b1b557ceb698e0ab7f985ea41c99dc8bf22 Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 08:43:41 +0100
Subject: [PATCH] KVM: arm64: timers: Compute an offset-applied CVAL from the
 current count

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
---
 arch/arm64/kvm/arch_timer.c     | 27 ++++++++++++---------------
 arch/arm64/kvm/hyp/vhe/switch.c | 11 ++++++-----
 include/kvm/arm_arch_timer.h    | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 6ac3321f4c575..9278b5383c044 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -528,17 +528,11 @@ static void timer_save_state(struct arch_timer_context *ctx)
 		goto out;
 
 	switch (index) {
-		u64 cval;
-
 	case TIMER_VTIMER:
 	case TIMER_HVTIMER:
 		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTV_CTL));
-		cval = read_sysreg_el0(SYS_CNTV_CVAL);
-
-		if (has_broken_cntvoff())
-			cval -= timer_get_offset(ctx);
-
-		timer_set_cval(ctx, cval);
+		if (!has_broken_cntvoff() || !timer_get_offset(ctx))
+			timer_set_cval(ctx, read_sysreg_el0(SYS_CNTV_CVAL));
 
 		/* Disable the timer */
 		write_sysreg_el0(0, SYS_CNTV_CTL);
@@ -564,11 +558,12 @@ static void timer_save_state(struct arch_timer_context *ctx)
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
@@ -647,7 +642,8 @@ static void timer_restore_state(struct arch_timer_context *ctx)
 		offset = timer_get_offset(ctx);
 		if (has_broken_cntvoff()) {
 			set_cntvoff(0);
-			cval += offset;
+			if (offset)
+				cval = timer_apply_offset(cval, offset, kvm_phys_timer_read());
 		} else {
 			set_cntvoff(offset);
 		}
@@ -660,7 +656,8 @@ static void timer_restore_state(struct arch_timer_context *ctx)
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
index 7875911c05063..14aada311bac4 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -175,7 +175,8 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 		offset = read_sysreg_s(SYS_CNTPOFF_EL2);
 
 		if (map.direct_ptimer && offset) {
-			write_sysreg_el0(val + offset, SYS_CNTP_CVAL);
+			val = timer_apply_offset(val, offset, arch_timer_read_cntpct_el0());
+			write_sysreg_el0(val, SYS_CNTP_CVAL);
 			isb();
 		}
 	}
@@ -296,10 +297,10 @@ static bool kvm_hyp_handle_timer(struct kvm_vcpu *vcpu, u64 *exit_code)
 		break;
 	case SYS_CNTP_CVAL_EL0:
 		if (vcpu_el2_e2h_is_set(vcpu)) {
-			val = read_sysreg_el0(SYS_CNTP_CVAL);
-
-			if (!has_cntpoff())
-				val -= timer_get_offset(vcpu_hptimer(vcpu));
+			if (!has_cntpoff() && timer_get_offset(vcpu_hptimer(vcpu)))
+				val = __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
+			else
+				val = read_sysreg_el0(SYS_CNTP_CVAL);
 		} else {
 			val = __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0);
 		}
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index bc6f2fdd7ad33..80f96ea59f1ae 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -195,4 +195,19 @@ static inline void timer_set_offset(struct arch_timer_context *ctxt, u64 offset)
 	WRITE_ONCE(*ctxt->offset.vm_offset, offset);
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




