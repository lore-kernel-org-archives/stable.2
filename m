Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048589;
	b=NJ0JCvulJyu8VQPwBPHYY74eL0xXd2+Fyy8ENlVqSv9cVx1Xa6vlnZxyDl0okBas6kyS
	 Xz1e1dJFp1WM41HjWnUhGQN4VJYSvcSe5oQpyjofhU0uQqJlerApRf7tdDn+1UzhzBn9Z
	 3brXXvSn9PDhCrHm+8Xj99YEhBVmc9L3f+ihGjD/AOZ7Vt/3k0+XqEOo8NfX3Y5JggsEl
	 91hu+Vod7PatIlPfNjbbywfZva+cFXfELJeeXUl/+yy6+xSWpq1y3WMw+1bNbk129s4UP
	 2BT9BgNLf6WtmvpKSG559pLpp7ca48QoLMZSDBw0f/+To3Pqf7PhnQU7AskPWMhtnVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WPwXYPCRQu/psMcDZYc5SzLRWY4HLL0d34eFhDm7Iek=;
	b=0kUkqyUTtUWRkOP7jrYD+oeq7q1vLOGVwLY/lQmeVSKH9YzoTK7TKhG8OQ/zFzvMQZl1
	 vZpNQcYSptFMZTRoT+Zkhyk43g7q3aqxIK3XrLL2MYfaDEeMAkhK70WHqlrS2Hk7PAhdk
	 fzzRAJmh3knvC9sRuUFI2PEDKO6dSTbjVUhiGqXRkhcAzv+i8DQkGKZUCR7X/wzLvEMGd
	 gjiaC2wTb8KyXkJ99dUdE5kMuSNegQeYdsxC+dbDQhlngbu5ofWhmiSAIN3uDyK9FqtMJ
	 pElIQhX+6s3+j1Z/rTCHhzsUH+IN5wJRjSXhA8lsuuUZEja5FwIpyjDpn8L9dzTinhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOFE6Cdn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOFE6Cdn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E131F0089F;
	Sat,  7 Nov 2026 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048589;
	bh=WPwXYPCRQu/psMcDZYc5SzLRWY4HLL0d34eFhDm7Iek=;
	h=From:To:Cc:Subject:Date;
	b=XOFE6CdnWY27RgZz220xNS8GhQK/KbpMHjrBQcFsLi7PvsY/5fRahE5nQR3iuVoTr
	 jmZ6OcqIKdXUwixNNi2yt06hcUuffl6dsu7pZsW/BjkrNUHu3amQXRmp540nXnICN/
	 fzy++KEGBtV0fwJJQMLQh1uRZ0kBnv6m9BQ+/djBTZdzd+xEZpXQNffFZs4FpKC+SY
	 eBX9klGaJGDACs6gfFkFeeJ6ye7XESCMXLlPaQ236PIDMJWt9FHtw9Lk27Z2q29O65
	 B5AKn1xmSOfXN2+9B4aZqtZyahBUKUMov8lhO1ZrRG+7U4uTJLoaJTEcO/64K+dQ6j
	 o2N/gjTkAZkFQ==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:47 -0500
Message-ID: <20261107054947-failed-6.1-a1b4bd2c2c26@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a1b4bd2c2c262b8094c86afb99364d16ac08cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054947-failed-6.1-a1b4bd2c2c26@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a1b4bd2c2c262b8094c86afb99364d16ac08cb66 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:38 +0100
Subject: [PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

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
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..f5bd29fbe3a90 100644
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
+		kvm_pause_vcpu(vcpu);
 		vgic_flush_pending_lpis(vcpu);
 		vgic_its_invalidate_all_caches(vcpu->kvm);
 		atomic_set_release(&vgic_cpu->ctlr, 0);
+		kvm_resume_vcpu(vcpu);
 	} else {
 		ctlr = atomic_cmpxchg_acquire(&vgic_cpu->ctlr, 0,
 					      GICR_CTLR_ENABLE_LPIS);
-- 
2.53.0




