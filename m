Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159333CBE6D
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704149; cv=none; b=TQCmdi00636O3tMa/ozAljUi4CyCF1pvQcYBmpL+vZls4duY2pQmtGwuol5Dnxd2xjPcQUl0DZ/JTCbXucVwqGY4GBbuMRsaf+BoADL7GNVN60oF8ADocUHa1off1At5YLDMAqxVXMf24uidAArLce7QrCfH3y4KU3UaJ9CJof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704149; c=relaxed/simple;
	bh=ZckKQ4112DYF0KI3JADcgajE6KoLSnrCaC10uo1xbCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epe4/wUUbYZXXIald1rUuOJhBAhAr6oJcpTmNdekg3tMvUwK6m4mOF09jmHdD9lo0wAc3x6Vrz5q8X19D3ziHZ3t9RoSjUcxKvRdqMcfk+B3yJ7nhQQ/JmMLvXh3bv1LV2dTvyjTlRbkVZTVNrk2lyHpAiw6PU/eB+Bd+D2BYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok7I1l23; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok7I1l23"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-470417e5b52so337161fac.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704147; x=1790308947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLHxgWDH6NZEUyidyM1IgI1xUcXj8vFEb1hVxsczrbo=;
        b=Ok7I1l23GHBKKjJHJPB38Zv+EpR5X9Mg16wryJIbengSV7CLQKY81nXcnLq8zfWdUg
         EPURHv76YEqw1n1LWTo8Rw2mNJbD7hKDxwyfO8sFOhkRXwLWbJ/fOVQ9Rk1h+ZwfdaZ/
         XNHyuCJ0yIDpDM32HlY58ijIVdywD1/fAUCbvxEith7yRLUq+2pJ545kaqPDRR4e/z5O
         h8LRMNIZXmy41hh6L3Tl89Ira/zanC1nCDb3h+YPRrlF8Yq7X2qWU1gd5DlzhyrbYnbp
         ZyzPHpCTe80Bw1A13wTowmCypjCzE5ny/P+qS98QgR/tznYOzki8VKlLstbzGOdnbLtq
         +7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704147; x=1790308947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLHxgWDH6NZEUyidyM1IgI1xUcXj8vFEb1hVxsczrbo=;
        b=HTw7OwMMmaJADedZZpaMpTlEwaioHASZT5QCGd3WJ6WtXikP2eCXMj0k5tqfRmQ6BW
         FI4GZSaqbddRDbe9RLeK0Dvv3j+wFdBQBpSEs2iBTEvgR6gi6ayDUnlkPEtjMV3GJJAR
         FTKuYkU86Dh/8F94Pdc2yuvL3SiPgBUXSejpJepN7HruoR6y//IYvkNC5e964cOy8iDu
         ID4Ysds1Eck0Wb3yr0qgYJjtD3y8wbcx0FgvqIdelLB/2vn+a9u9tUnFvdblOuDWXPA2
         G46aRqVJa8+5sYrR+ZRVEsJVmc1c13MhEsaPjZTOcxGZw9ubiv+T8qqOxQraSJ6zNx2k
         c4Uw==
X-Forwarded-Encrypted: i=1; AKwUvBzlodBX5qfeeAHv8ORLScj04A/aU0IPqPcMgWUV7V9n3UYcXNgyP59ab97Q2TNR633YQbu29Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++mBsGXC78QlXISXDP1/zmvVhMiYIvNgVu8AP4ZQGsCosf+mcVd0
	cPFMkoo24Ir4IZgoh6tU8Y0qgqvTmz8CQOKxAdvQdgV0iHse9kj8vhPQ
X-Gm-Gg: AYBFou1dVE5UrsbOczxklm2ZDxWIP494/jZrYnQFwFtFKzfR4kzYZznk5my8Xg+oY80
	OvEWBub9/hIUESX3xtpMOlXkLiS/AHNZG/05l4C1Gww9IimxvdLYtm1btgTzWK6XuL1hmoFZxni
	1b8ZIN6CZiaOlpML7PyZYR2ccTlqDlltjpafZCJVa6roCAwmtO/lsCjhBwlpJ80noSt5Ojuq+Sd
	12XuPap6OMJWovxFIReRfxgAvwM2bvgTB0nZMTx2P0Kkb/nLj/YcgWnOGc4eA0a0qlV+tGmV8mn
	sEV7RlY6vrQx3LAA7/IxgRWKAa+ay+7yDSQebZ2CIvTH26yDCI+xEG7R4m/X/Qe8wFtMe0K23/T
	AtPjeuZTnDmP6eSWMoM1xjwR/691O+0YIfm85AjDUxVn6aP5nCUzZYZdQwVY78kFhImJ+BLdz/1
	OXTa8FmgEJ7O5oNS9yAVsXKumDXu8HyVnkIR+c6fL9DKdoeKdEKorgeRjXm2u35xpmMHrMX+Y+c
	FBbA5gTTyYdqQKXwWZuWzDnOL55OHX7SFCj3eA=
X-Received: by 2002:a4a:edc7:0:b0:6bd:f333:7b83 with SMTP id 006d021491bc7-6ca9a44dc18mr1362602eaf.16.1789704146860;
        Thu, 17 Sep 2026 21:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:608a:778a:c473:ac82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287be968sm719908eec.26.2026.09.17.21.02.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 21:02:26 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: vgic: Do not remove in-flight LPIs from AP list on disable
Date: Fri, 18 Sep 2026 12:02:14 +0800
Message-ID: <20260918040214.85580-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918040214.85580-1-ndaugoing@gmail.com>
References: <20260918040214.85580-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

By code inspection, a race condition and potential Use-After-Free/crash
exists between remote LPI disabling and local LR folding when EOImode==0.

Commit 6da5e537f5af ("KVM: arm64: vgic: Pick EOIcount deactivations from
AP-list tail") introduced tracking the last interrupt placed in a List
Register in per-CPU host data (*host_data_ptr(last_lr_irq)) and traverses
the remaining ap_list via list_for_each_entry_continue() in
vgic_v3_fold_lr_state().

However, an interrupt loaded into an LR can be an LPI. While vCPU-B is
running the guest, another vCPU-A can write to vCPU-B's redistributor
GICR_CTLR to clear EnableLPIs, which dispatches vgic_flush_pending_lpis().

vgic_flush_pending_lpis() unconditionally removes all LPIs from ap_list
without checking whether the interrupt is currently in an LR
(irq->on_lr):
- It calls list_del(&irq->ap_list), setting ap_list.next to LIST_POISON1,
  and drops the AP-list reference.
- If the LPI is unmapped or its translation cache was invalidated, the
  vgic_irq refcount drops to zero and the object is freed via RCU.
- Meanwhile, vCPU-B's per-CPU *host_data_ptr(last_lr_irq) cannot be
  cleared by remote vCPUs and is left dangling.

When vCPU-B subsequently exits the guest:
1. vgic_v3_fold_lr_state() resumes using the unlinked last_lr_irq.
2. list_for_each_entry_continue() unconditionally evaluates
   list_next_entry(irq, ap_list) during loop initialization, accessing
   LIST_POISON1 (or freed memory).
3. If eoicount > 0, it attempts guard(raw_spinlock)(&irq->irq_lock) on
   the poisoned address, leading to an immediate host kernel panic.

Fix this by:
1. In vgic_flush_pending_lpis(), do not remove LPIs that are currently
   in-flight in an LR (irq->on_lr == true). They will be naturally pruned
   by the owning vCPU's vgic_prune_ap_list() after LR folding.
2. In vgic_fold_state(), clear *host_data_ptr(last_lr_irq) after folding
   so that no stale pointer survives past guest execution.
3. In vgic_v3_fold_lr_state() and vgic_v2_fold_lr_state(), bail out
   immediately if eoicount is zero, avoiding unnecessary list_next_entry()
   evaluation.
4. In vgic_v3_fold_lr(), do not resurrect the pending state of an edge
   LPI folded while the redistributor has LPIs disabled.
   vgic_flush_pending_lpis() cannot remotely clear the LRs of a running
   vCPU, so such an LPI would otherwise be requeued and re-injected
   while GICR_CTLR.EnableLPIs is 0, violating the flush semantics (and
   the architecture, which gives no expectation of the pending state
   being retained across a disable).

Note: this closes the primary race (the last_lr_irq node itself is no
longer unlinkable while in-flight), but the fold traversal can still
race with a remote flush unlinking a subsequent non-LR node in the
ap_list tail. Fully closing that window needs the fold side to take
references before dropping locks (in the spirit of the prune-side fix
in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
interrupt affinity change and LPI disabling")) and is left as a
follow-up.

Fixes: 6da5e537f5af ("KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-v2.c |  3 +++
 arch/arm64/kvm/vgic/vgic-v3.c | 14 ++++++++++++--
 arch/arm64/kvm/vgic/vgic.c    | 10 +++++++---
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7182f63fc938..7b6cd05ce32d 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -122,6 +122,9 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < vgic_cpu->vgic_v2.used_lrs; lr++)
 		vgic_v2_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	if (!eoicount)
+		return;
+
 	/* See the GICv3 equivalent for the EOIcount handling rationale */
 	list_for_each_entry_continue(irq, &vgic_cpu->ap_list_head, ap_list) {
 		u32 lr;
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 726e20a1da6e..dd1314f4543d 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -96,9 +96,16 @@ static void vgic_v3_fold_lr(struct kvm_vcpu *vcpu, u64 val)
 		deactivated = irq->active && !(val & ICH_LR_ACTIVE_BIT);
 		irq->active = !!(val & ICH_LR_ACTIVE_BIT);
 
-		/* Edge is the only case where we preserve the pending bit */
+		/*
+		 * Edge is the only case where we preserve the pending bit.
+		 * Do not resurrect the pending state of LPIs once the
+		 * redistributor has them disabled: vgic_flush_pending_lpis()
+		 * has discarded them, and the LRs of a running vCPU cannot
+		 * be remotely cleared.
+		 */
 		if (irq->config == VGIC_CONFIG_EDGE &&
-		    (val & ICH_LR_PENDING_BIT))
+		    (val & ICH_LR_PENDING_BIT) &&
+		    (irq->intid < VGIC_MIN_LPI || vgic_lpis_enabled(vcpu)))
 			irq->pending_latch = true;
 
 		/*
@@ -155,6 +162,9 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < cpuif->used_lrs; lr++)
 		vgic_v3_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	if (!eoicount)
+		return;
+
 	/*
 	 * EOIMode=0: use EOIcount to emulate deactivation. We are
 	 * guaranteed to deactivate in reverse order of the activation, so
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index b25303d9919f..0d7d75c3ac93 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -205,10 +205,12 @@ void vgic_flush_pending_lpis(struct kvm_vcpu *vcpu)
 		if (irq_is_lpi(vcpu->kvm, irq->intid)) {
 			raw_spin_lock(&irq->irq_lock);
 			irq->pending_latch = false;
-			list_del(&irq->ap_list);
-			irq->vcpu = NULL;
+			if (!irq->on_lr) {
+				list_del(&irq->ap_list);
+				irq->vcpu = NULL;
+				deleted |= vgic_put_irq_norelease(vcpu->kvm, irq);
+			}
 			raw_spin_unlock(&irq->irq_lock);
-			deleted |= vgic_put_irq_norelease(vcpu->kvm, irq);
 		}
 	}
 
@@ -873,6 +875,8 @@ static void vgic_fold_state(struct kvm_vcpu *vcpu)
 		vgic_v2_fold_lr_state(vcpu);
 	else
 		vgic_v3_fold_lr_state(vcpu);
+
+	*host_data_ptr(last_lr_irq) = NULL;
 }
 
 /* Requires the irq_lock to be held. */
-- 
2.53.0

