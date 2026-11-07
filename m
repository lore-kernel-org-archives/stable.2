Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049299;
	b=lTMq2UMjTZRQBcL+TC7GpY6LXcZhwe5HFqErjQ97jv54/LDcZj0aAeT5cRxJqVnsI0e4
	 IY1hAcuLpx4cNWJrbMTkOeBTS1Z2DDN3V28GC6r2dpYfFPMqQx1zMydGOURz0VbRQLMKn
	 YvB1aMBqX1PpBWw53X6wCYB8zf93yY6kch/TF50PyNe9VLLJtv4EPQYL15UgAu5SOSl/w
	 eU3SyHSEEqTBLuzvVoHOnOIi7HFutPb2k76opgo36Y19SF8QwNHHjCyF84qtlDuHy9K+e
	 I2+Kz7UWhXPNyKiFX7TNdMb20kG+T3kdHJnMoyCGawdIzdmDVoAcBv8OqyPHgniRlqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6LffHaWp8+VTKRFPVHrAvJH//HMwfnsF1bArfo2xu8E=;
	b=JlIsoBRsiBWWrggeuV/1q83HUyTy6il5mLXwLJAGWjwNkcxFMDICY48cgrNBUW1n5gfI
	 nMoNYpLVOA6CJ0y77vEl0NpAvHEzw83tphcnCFUfFKRmTYrNa830PKK+PWxzFyEaF5WNA
	 y0epJSVvZJGUnyLo1KohpGjDwK61u5vlP/D//G9P+WqQU3nkYzcuONX6LBU6Vze31RRAa
	 jmswnE8apQk1ZtT28yhBeS9BfxKMgRbnoEmaSt8pMzf73iY9j5IgsZSs5PRdGpajTHW58
	 E/NyRyxsYBlW74K2pbi4mlZjv553dMm72xiGdYHNzY5HTkuvF2ErV1+KY0XmuVB+dUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnCG33k5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4235606D82C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnCG33k5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD41F0089F;
	Sat,  7 Nov 2026 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049298;
	bh=6LffHaWp8+VTKRFPVHrAvJH//HMwfnsF1bArfo2xu8E=;
	h=From:To:Cc:Subject:Date;
	b=PnCG33k5WPVE0ZbB9uZYhZ4djMm8MNvbetZNJQAKTwS7XlyXwZyxzeRiNvk2aBQhN
	 2W7z/4QrGdo0V6e2tlfZws0/2fyEZm08n66XTGeiwFIbSAvAV6n3tYmZeP2Q5TaUpQ
	 dVmZy4EWirzESgSuNBaMkhWPuwsjGKodxtA7edSD3sQtLILCoUPhu+Jgqs/Kmc7e2l
	 OfE3K0l+aH0c7ZhOtDwoTp4UXzIidRYcgZu8QrRSks423cZ8FHApL/oOGnanqfEMF0
	 EmUZzkYe9ECEA1rpQq8KGDfK8HecsLsya/ZWgWveLz91bUT5T66TyDKpTZ5fTP7ZIa
	 WCbKvXFsWGHhg==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	fuad.tabba@linux.dev,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:36 -0500
Message-ID: <20261107060136-failed-5.15-8a88a46b86ca@kernel.org>
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
git cherry-pick -x 8a88a46b86ca3dbbd24522760d29edfb3f24ac2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060136-failed-5.15-8a88a46b86ca@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a88a46b86ca3dbbd24522760d29edfb3f24ac2a Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Mon, 31 Aug 2026 10:10:01 +0200
Subject: [PATCH] KVM: arm64: vgic-v3: Undo assignment on iodev registration
 failure

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Reserve the slot before registering its iodev. The caller holds slots_lock,
so a registration failure cannot race with a later assignment. Undo the
reservation and clear the cached assignment on failure.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20260831081005.41346-2-kmehltretter@gmail.com
[maz: moved helper into the sole caller]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..8fb0a3eb3457d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -818,16 +818,21 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by slots_lock */
+	rdreg->free_index++;
+
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
-	if (ret)
-		return ret;
+	if (ret) {
+		guard(mutex)(&vcpu->kvm->arch.config_lock);
+		vgic_cpu->rdreg->free_index--;
+		vgic_cpu->rdreg = NULL;
+		vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	}
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.53.0




