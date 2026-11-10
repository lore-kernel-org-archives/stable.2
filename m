Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354900;
	b=SGopTU6+l2oakWkyUqeVO9+4qdcZakA+JYivylc/ynbm1RIAFCYUWRuev2seXy7FH61Z
	 xMx/0fqlyRN1bzOUsoTdDFnINA1ea+phFFdN0NIgl1TMIgNGTva1W85AlVWujrS+8r6yK
	 hEEjvgZh5urfnapBbEHJMYcFMgbpRTuPyHBuZiJ5WzZvI0Sf3pUAIjTImZ9ZfzjmHoQn3
	 poyCWXWusKcmYcZzQReqPgqZhTt8ebBx4zDw7ky9kpyz7kQ2w7M68L+T2VnQVs7X+imXr
	 dWfnb55HAinaqeWbenNJmrE4lgq+f0iTZBwYB8EQ3S6ijumRNASh25feFjLGueKPGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E88DP839KsO3q/PeGenCpw7k3nbCAZ3yGkwpK1bteWI=;
	b=0uMCYeHoJHPEf237YA7wn9I52Mvgxye72l6b3xWUp3YyS8RTr3oN2zvvzRX+/6RW+LK6
	 rrO/QrB9jtE+85Lc5O+yPPhU8DSaoVH7sHHJKeqN8Qdc7dq7qN3MGKBdIa8YugjONxDoA
	 xbqgMhdMEh8a+9A4u93yk8xJxeZA0QGCALsCga+x4CeSwesaqIu5q8my8RLRtOxWQ762F
	 AbCTPJmdBzGjoEsRZORm8reiivvCrdqqb1wmEYC161HILgHCVL7ZjNcBIHm+BbP9PoEK3
	 AA6UhNpoYwpDmiDih4kzcwzJhkFbFBtyjoFzh3oibHOFILDVqTDjI/TzZ+co9UvdJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2PFfjac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2PFfjac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FBF1F0093C;
	Tue, 10 Nov 2026 23:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354900;
	bh=E88DP839KsO3q/PeGenCpw7k3nbCAZ3yGkwpK1bteWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h2PFfjacqId4f7fIaEUZYK+0mpDVrO/j831gqqiUeOZ9Sq54PIleTtrbSsV+DbkJ2
	 5V9QyYZpPj0B62KPbdCDuUVEYlJkf7o5LffDKt0f9KDKGfGO5hQophjJjFzBjifWjm
	 WE7A3ZBF0+efzCUJOZdkGoCE9B1+WwKp9mjJLYe99znsx8leo9V8XmPIj8SgHwue0F
	 XAHuNfLPeGZ3FJJy0y5n62wnMQF5mMJWLSS9yFr+XudztrCll8NnV5td64kqgSiU79
	 FfNt07U/30W3yqsyqNaNxZkjDJ7fd64PiCDgl5Mavl9cfCX9/raTW/j+sm+EFB3zjw
	 Ldg9dPjQB5eWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs
Date: Tue, 10 Nov 2026 18:54:58 -0500
Message-ID: <20261110235439.186414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053536-failed-6.6-a1b4bd2c2c26@kernel.org>
References: <20261107053536-failed-6.6-a1b4bd2c2c26@kernel.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit a1b4bd2c2c262b8094c86afb99364d16ac08cb66 ]

Disabling LPIs is pretty nasty, as it directly messes with the AP list
of the affected CPU, which could be running... This has the potential to
lead to really bad behaviours, and we should not be doing that.

Take example on the way the Active state is handled and simply pause the
the vcpu so that we are sure it is in a quiescent state, and the state be
safely manipulated.

Nobody has any expectation of performance for this anyway.

Fixes: 96085b949672d ("KVM: arm/arm64: vgic-v3: Retire pending interrupts on disabling LPIs")
Co-developed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-7-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: Replaced kvm_pause_vcpu()/kvm_resume_vcpu() with whole-guest kvm_arm_halt_guest()/kvm_arm_resume_guest() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 33ff9fcfcfb08..1dab5298ae9e7 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -276,9 +276,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 		if (ctlr != GICR_CTLR_ENABLE_LPIS)
 			return;
 
+		/*
+		 * Yes, disabling LPIs is painful, since it can be done from
+		 * a *remote* vcpu! So let's not take any chance, and make
+		 * sure that the target vCPU has written their LRs back to the
+		 * irq structures, and release any reference they would have.
+		 *
+		 * If it hurts, don't do it.
+		 */
+		kvm_arm_halt_guest(vcpu->kvm);
 		vgic_flush_pending_lpis(vcpu);
 		vgic_its_invalidate_cache(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_arm_resume_guest(vcpu->kvm);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0

