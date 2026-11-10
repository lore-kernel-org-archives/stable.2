Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353128;
	b=0rs+QN2vf7MQCdtCt+1QTP0aamQmZBIS+IKmDjnjcrM0eJRrujSZsLjfV/PFHnTi6mKy
	 PXOlSp/x6fBntB5bkJ18nBMeYBRBod/yHDSyDbyi5bqcDNgyPRd10BtDt/HdN0TJsUBto
	 2lUxjgwTeu2HC49z1UB30FtgKItEOwW4rchbf9NU/88bGl8s3scFLyqA7xPRpPoKOEj2o
	 Nx98ZqAHJgAZFulQFYNPGfa3k2hBYT8hoJESdUd+ETFvPJomGZyBfja7CsIeGIC38sIQI
	 v7InKPZ95rOkB9xkU5q38waY+CbIuCgzRtyKsxlG4kw106UvfhkrkqGkOE6mpEbhOZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UVusRAco/hqBGKYA0IKJzoBLKC0cYH8tRgfdbmMSCbE=;
	b=Qw0NCOfD9DZrZVCdxdErz7EVZR7v+voYe5GPLjp/uyH2AWXioL9SqGxkIfJa6MJToWtn
	 NkyCO+S3MRBEnZOlbwvorcs8vMkzx0uLppdrnJt6xJsgeui76YPEQitkXAYdM4OJxCrqT
	 8yB9GyI4V49tmipgm+DUsv35oGbnrod3QiHhr5HdFe6C1YMcANdqFQHHfrwPIk7fc5IlW
	 v78N0F7XNs6c2U6uXE60M457SOQvxTPkQLURVNyJLsNg/ZUqC08e7SJwfwi63mPVsVMNN
	 m83EW6OLWRMrn/ORjELhS7idYPDkjPqNrcAVsTXyW1QxgegjAOMNDkv7syVukGriu0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDiRxvN1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDiRxvN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC401F0093C;
	Tue, 10 Nov 2026 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353128;
	bh=UVusRAco/hqBGKYA0IKJzoBLKC0cYH8tRgfdbmMSCbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDiRxvN1bok1rP3mCyhfF+e7T1WPvsHhdzcJskbp3td8Mv92py7vHWVWf5UN9qW76
	 ZyKNwQv6+3ppImViouVawzofnz/spHhjNMIKY8XeT8wKsEf3ekZD/h87XDkb/XRyuk
	 m4l7/EHxSdA+cZTUgvmEWCsrpkIZ8oUj9kNzlCxevcz8siE5C7HJITi5MUVD77CJtZ
	 +6c2Jf805CT3bMG72Z1+0RfmBTO3wAEEEZXuQSWSw8Hy+Y128aZhAVVG8zhFaiGxvu
	 /erYK0hA98TegID9muDVnOWVFiGphQgBmsfkObS9jyKA8ShACbrhVYoqfeayXovhtU
	 bphN5G3+UHVWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs
Date: Tue, 10 Nov 2026 18:25:26 -0500
Message-ID: <20261110232509.108826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051145-failed-6.18-a1b4bd2c2c26@kernel.org>
References: <20261107051145-failed-6.18-a1b4bd2c2c26@kernel.org>
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
[ sashal: Replaced missing kvm_pause_vcpu() and kvm_resume_vcpu() calls with whole-guest kvm_arm_halt_guest() and kvm_arm_resume_guest() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 79e018cec0f96..5ba3bb576bb15 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -303,9 +303,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
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
 		vgic_its_invalidate_all_caches(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_arm_resume_guest(vcpu->kvm);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0

