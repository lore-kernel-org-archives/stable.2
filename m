Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049620;
	b=JUOVyka9F/wQSW2E5Nm4qHAyTULD3T37Y6rEBDw/hV/te1ZbO/qAWcAqhGNjcSyOvWUR
	 ysLv4L3222VIUUHs4W8hABfFCcPfqTepOxkILmQmLpYjPs56WGiscO0xdJ875m5tNEyeL
	 bV3/gYQ3hPHKlrxERP4LMEAG2jNhVk6JaG50jHnpFYkmgTRbMwjHrsNDj4rTjiZktDZOm
	 W/btOz6r13D2ARvPuyNzi9rFHrJId8Ax7PlJQt+G0ZV5v+H7HkvL6BgMX1lefo3MlB1gf
	 2y7s8DUTBm4iLo47SOKUWbTJc70ZEyNrYJgJSBxxZB4SHvF43566F8c/CkOAoWnrurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gicw5RJvR0Xjxi1fqBDOIWu6rhwM/g3H5iU9sLWuBc4=;
	b=IiAzUi1URUUdV2P3HlP3/NoI88raFYhLDx1+bdMdSsyeeGxiAbGXKv4R38Njnr5VvcCs
	 xA96MM5j0dSNULh/2Ia9x/v3Y0UJwnamUg2TjodxrBnRjdHxnBV/8/RAWybWPiynoCqB3
	 UvNaWaKJ7zY41yCqr8Fkz7kpg7Ldynl/FSS/4wPLq6xkjEjb8XuyXVhVBZe2QxA6Qi3+r
	 lfJcF6fGO1NLTMkn5ozQQOhOn2itF/x+B9jVlbQrFLaAgmScByT3ikuLd7DVJ58yNZ0U7
	 OEqJE1YTlZCSLUwASbgglju8jeBh1q9NeEFrL9Ke5SvG525fdrz25tDGgi4nUgV4UpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a3/GH+WE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A784606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3/GH+WE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D651F0089F;
	Sat,  7 Nov 2026 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049620;
	bh=Gicw5RJvR0Xjxi1fqBDOIWu6rhwM/g3H5iU9sLWuBc4=;
	h=From:To:Cc:Subject:Date;
	b=a3/GH+WEEHRD26RCa338k4758GhAVORCZx8xqYOTs3ZaLAv23gCa3X/CVdc+AQ5yW
	 N/9jj0NTvt4GZSmjk4DXTbi8iAthUK4RDXndnxzGf8miWWQJkk608//tSHDxh7kGvQ
	 2tyFpn+J7iW7ACO40c17RaG3ya1xibCRRZe+QoAVI7slfKJJ+jmquPGyHwpw0z7Ha5
	 f0Frb9HnMH8cgLBtU2tyGo0m1NxXn8cBDMZYXqJ7CVuG/TMOZwXwAg4fGz0vMwhoHs
	 5Byci7KV4b7Vpg8qBxHV88s5PT6xf1+0PN01cH/mmdepLY4CnNpaKoUPwGQmWGKm7P
	 p1lYnV9nOu1nw==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic: Stop the target vcpu when disabling LPIs" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:58 -0500
Message-ID: <20261107060658-failed-5.15-a1b4bd2c2c26@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a1b4bd2c2c262b8094c86afb99364d16ac08cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060658-failed-5.15-a1b4bd2c2c26@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




