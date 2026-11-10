Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312769;
	b=nlf/W8kYflN2kAUEewaPMgWCJKQlYG00RdpxueL3H7P/G0yS9gj3/uFZPjLzQUDxDfqA
	 Uur037WQL1ovfCjHyvQMcZYpL7poroGgHjE1yg+7Yh6F81O7sF5Pwqddo4iPO+M0dKoEm
	 nRsPpwbaJTRY5i6zCVk5qI0DSu2nEj7Gj0HNnxBM/Nvrfs+S9/87q6yKqNJRSPV6GG7n1
	 Y80oHRLPsZwQDEnHHV8q4GjmLwq94LH2HLD7JF4s+S844Ppnc6CCsKuT5Sd3p5M5+SfOw
	 6akFxrMTotKBH68gTDNCgKFn55IfBTMi6eEqyxZWa4temAm96jTaGPrzj2/ncrcuuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ll02ezm7Fpp+RmTiiEGTwTmsRI6ygI6F6NsEEHAdjvU=;
	b=Yvmk7Yi0IkfTeBNAxtH/+fGOHFg6GgnyjOAWKOKBnAK1CqB6KoCgTa35a3ovZa2Cew+X
	 aHPw1p7o025iQuyJMGQePFxKJO8Mk7JhvUQjfhYcQR9v8ml4U0JqgACOEgbaKP7XJqi2X
	 3VqrjhtBOpjefV8cPRJcL+bbE4+/54tyhnkDD/jBEkBBA/8iQJGBy3dO9xsWgLjaZPzSG
	 e/Hn2cfj3ADaV1P4bhWQHV6zr9E8tNkbEHcFI0ky/O7bVwDF/gjj1M7Bdp0xRT6qCl3TX
	 9w0dl4G5FKwV5myqvbq0RDgiFMbxexEOeFhlkiGr03yN+mi+8c+H2zA/aBFNWFLNjNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8t5ZhVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8t5ZhVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46FA1F0089F;
	Tue, 10 Nov 2026 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312768;
	bh=Ll02ezm7Fpp+RmTiiEGTwTmsRI6ygI6F6NsEEHAdjvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8t5ZhVdBUJT3AhJBE3ePD5GFjW6LY9RtpO7ZfELDxu2uybNW7tkFbmio44EAe8/j
	 uUybu/dOHuKcqB3x4iQkb7dPnpfKSofohMITDLYjj2cYB/oCMpr/ael32TXNAC+RsU
	 y371hCTHkFi9dLHTgG29cgcgxXTY1qZlsj12dm+u3WTe8yJSILyw6iAkQQAB4t8ylB
	 2nZPF33KH2cCpAqUZIKwQ4GEMVEvkss90CPt2F346Zw17Ty+tKNh7QafVSJM3Zvnnn
	 enMGQKBq4MFIOienwhwVShH6tAsjgqwyT6EQCEyvdOKCqSKt8yLVxhsn3lewtNwZ5/
	 s9e4Lh9YfS4qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Tue, 10 Nov 2026 07:12:46 -0500
Message-ID: <20261110121137.996763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061817-failed-5.10-8a88a46b86ca@kernel.org>
References: <20261107061817-failed-5.10-8a88a46b86ca@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit 8a88a46b86ca3dbbd24522760d29edfb3f24ac2a ]

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
[ sashal: adapted failure cleanup to rely on existing kvm->lock protection instead of a config_lock guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 7a6360eba3214..d7c06cf6dc0f9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -731,16 +731,21 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by kvm->lock */
+	rdreg->free_index++;
+
 	mutex_lock(&kvm->slots_lock);
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
 	mutex_unlock(&kvm->slots_lock);
 
-	if (ret)
-		return ret;
+	if (ret) {
+		vgic_cpu->rdreg->free_index--;
+		vgic_cpu->rdreg = NULL;
+		vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	}
 
-	rdreg->free_index++;
-	return 0;
+	return ret;
 }
 
 static void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
-- 
2.53.0

