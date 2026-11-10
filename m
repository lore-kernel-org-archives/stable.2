Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352392;
	b=TkLqI5XyU1+f89WKERDzXfCHRxKvSB+3WzGnn3uzmXpxW4bPppNDO8wjYl8nzusBANxS
	 MuVCUzgZEOrGG5Hr3j0na3g+h173uSvzOmjjX3w/krKW3I66KK/TBhcBYnGSHomPdBa+g
	 BPxaPXoEjScJv5HvvybR6ykLmF2+WSM4ixXhAm5IeSnlub4UrUNUQUeupTQxlHgYOZ46b
	 0F7vE061THKbhR28xMlyVR9xBKj4X3UqQsYzXEUW1/jqZKSXbVLIYM/XzgFxVGN32fpMr
	 uwLx9sp0owqYLKWV3fvNH0iKEO80b4EfallzM7zCvQFm3oMXgphfZ0fRTt+i4zoTBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mQNSbAy/UczgGILOzDvsHnA+WoapF2BiH0kYqI3U9bI=;
	b=w38eZE8icinguhKLD/GAzducHcqMQfrPkVQB3r8y5QwhjZIvPi/SEc1z/1MR++4vTOUQ
	 aZvHcjfK4bgkce2uqSixmacY2NB0QcPxavYvaCNXojeLhC9gOp9lFR92Tob4gHLXAj9lK
	 tfWdmqDeEeuZQO0iVR8+jtwodQmxehgF0Oq3IBtBlg5l7OsDOFLcSpnslBAEG7c7W84pg
	 HOoFFvmLLLU2KXbSH6PJmET7ClPTlm5CiFv6kduEF8xHGVkrlmYy9RQyLBAi22vCNJOX9
	 lZRpydW9koWq6rhbVjGH7KOMa6Zrds6tz1gY8RGOQDz9WiQZZ+MoQmfz7ilbIkOPadw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vif9IjXW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vif9IjXW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCA41F0093C;
	Tue, 10 Nov 2026 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352391;
	bh=mQNSbAy/UczgGILOzDvsHnA+WoapF2BiH0kYqI3U9bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vif9IjXWOvZFr2Bxr1gFFPssvEGLQHYyGht4+PTqHzzYdf1FBLLqwlikRRTb6xD3e
	 TmkoFOnNBUH38yn737iSbr3aG2HBs6aNhHdmTFby5SOlRnOGt4f3p7XZLdSCeLfKSu
	 IJMrleg4BJX9DWYIG0XwVwoElljmwNTpAKkcEjle3bcWQTrIOzojworsGAUpI6vAl1
	 T/LIRJRVv3UASzTOpO/Lj8mWBN3sGo7abl7MNZ1MTJ9oZotb9r3VLnAoZyNO70f6PC
	 q8QuizACZ7c7R+GUT5sBTlI8UeDY1JZHtFDJwc32C/oAnc9YYOmufJrVbK0/Wf2Rwy
	 8/Vc4JiJqABNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs
Date: Tue, 10 Nov 2026 18:13:09 -0500
Message-ID: <20261110231246.13787-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050454-failed-7.3-a1b4bd2c2c26@kernel.org>
References: <20261107050454-failed-7.3-a1b4bd2c2c26@kernel.org>
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
[ sashal: Replaced per-vCPU pause/resume helpers with kvm_arm_halt_guest() and kvm_arm_resume_guest(), which pause all vCPUs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5ab789accc9d4..9e6200c5adcef 100644
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

