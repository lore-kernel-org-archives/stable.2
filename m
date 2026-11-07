Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050614;
	b=H7kLb5tHUB7lhR26goqZPxAxWdAz05uHeuK4Y3KgBIbkfAAnujdWm4NUv/26kDWDc7kJ
	 i5aOspRbKBGjJ2QoNMefk/ygHrhBkBH68qXJHxXhQuUKcv7J0MKDufdXBx6gS4zFwIvsP
	 z1RfHmSXxWF+YDnMRafz1SglT+XluQri4w7+SL59GE4BpQgVChTEPsmlLtXK44YLHnli1
	 12+QarOqG0NG6cozPM1ocW+VrIjSQFsZOEhZfG4TtKT18Gonx6ui2c8GzE+yJbpVJjDAL
	 ig25LiosUTfj6iWttuCGRKIUMlDsqNVSqjEGw47uD4K6z7TYKK1djB8hT3OcvRgvuXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CngjlAiY/UyFo2HD/lTjcil93mLfph9vHB3WukLwLgg=;
	b=1kmESKe7qaXrL4ynzSxgswBH0WWTlgYgf90RCfLmczD1HIJqPeJApPjnsrzr4/qtyO8Q
	 Dck9Me6FfDOvf5oqV7HR9ZOxvhElfBDi8iTAiXxZOauNn1vykA/GNBRkhrblWSZllIwuU
	 nl8uI2GRzLO6TG26fwjRiUQ96X6OGaDMRT1KQgZbWfPNnmwhx31tUgT4L/BjpxVA53W7K
	 nvUmpSWYNCbZi7RW5X0hQhlnWfyNwXX4CXVtmRzk3Ig/ZHls55k5U9mTWU4M6WK2VJoEO
	 b1vFKis2SBYMir1vkUENZnb7vHgjjtLfzxuC+Y8ZcD9DC7ZQGq+7qfLqwQiB3cR7ejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/CxqB2w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86197606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/CxqB2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E561F0089F;
	Sat,  7 Nov 2026 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050614;
	bh=CngjlAiY/UyFo2HD/lTjcil93mLfph9vHB3WukLwLgg=;
	h=From:To:Cc:Subject:Date;
	b=D/CxqB2wMI3Ub129BYr1InmfWwzHg9FSFyiMzRxxTxsYGOUi6hzV5uFYUGpAznbUz
	 VC/3SA67dsBa92ZSLqV+8bseD4zaP1Bk5VbkgbbQpg7EsTtD4RWAvz0K3eh4R9x+LM
	 /wICNuo/VVv+KnoB5NgwpKknveSNJUdv3y8nXMk215qJkWaYuNQXvS9n3/BZ1gEQBZ
	 hI1UNb9h/D+oz8m+x9pbWsNIcV4F4ogj2lJQ7r5KywmBaI6PHuLssIPB11a0+oPlbL
	 ZbRR6Rxa+rEQa3TwsBW45bZa6fPB1NoPDuqeNX4JrG/nxwroHrTuF4VVJZfDZ3x6b5
	 hV8llGdCUNPhg==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:32 -0500
Message-ID: <20261107062332-failed-5.10-1d4ce2901f1e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1d4ce2901f1e25b06d447c0b02d105d6dd3550d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062332-failed-5.10-1d4ce2901f1e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1d4ce2901f1e25b06d447c0b02d105d6dd3550d8 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:34 +0100
Subject: [PATCH] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context
 being saved

OUTSIDE_GUEST_MODE indicates to the rest of KVM that the vcpu has
exited. So far, this is set as soon as we return from the notional
hypervisor (which with VHE is just a function call away).

However, code that uses OUTSIDE_GUEST_MODE as a synchronisation point
relies on the vcpu state to have been written back to the in-memory
structures. Clearly, this is not what is happening.

Move the publication of OUTSIDE_GUEST_MODE to the point where the state
is actually written, and give this write release semantics to ensure the
correct ordering.

Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-3-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 73706464d2653..7ce9f3bfa7fff 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1334,13 +1334,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
 		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
-			vcpu->mode = OUTSIDE_GUEST_MODE;
 			isb(); /* Ensure work in x_flush_hwstate is committed */
 			if (kvm_vcpu_has_pmu(vcpu))
 				kvm_pmu_sync_hwstate(vcpu);
 			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 				kvm_timer_sync_user(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
+			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
 			preempt_enable();
 			continue;
@@ -1356,7 +1356,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		ret = kvm_arm_vcpu_enter_exit(vcpu);
 
-		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
 		/*
 		 * Back from guest
@@ -1390,6 +1389,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		kvm_arch_vcpu_ctxsync_fp(vcpu);
 
+		/*
+		 * The state that was pushed into the CPU on entering
+		 * the guest has been synchronised back, let's
+		 * advertise we're outside of the guest.
+		 */
+		smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
+
 		/*
 		 * We must ensure that any pending interrupts are taken before
 		 * we exit guest timing so that timer ticks are accounted as
-- 
2.53.0




