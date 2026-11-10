Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312436;
	b=E0tkWuwNjMmbAz3fm/o3iKSyOl1tzWm4Z6SiM3MgmVcNymZ2teqDN+pCt9/mhNj0AOxZ
	 IZkosfb+YEoGjEvcj9Eb9DEv9cMXjgw/FRyeKO9kilxccrVpeSlkVVKM4vHL8QuAgil/0
	 V09KhPIuaNSdzunsCPGycoDfSSdaAFjA8NPeUYYnYg2OX0wVePDskDAtxAIFxuZvco28+
	 V/DzOYJ3xFb47FojY3Y740iapquu8M9v2NQ6qTgxZ2TskBooIhHP/eB07FJJ53NerawrP
	 Vip/RGN+xLPeD3IpQAci50luKiXex4zV6PPaI9uR/zus+4L7bk9MrxbkMSQDdX8qfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jx3SLt7x3xgQKoZ/g+VwJ2+pQlnVF++EioCk4UVifB8=;
	b=jQI/kEPVlQYU0BRLefLTgF5O+lYtHv4iFx5b78HixvCQ3WPSEPVmOSVVoJ6f+FqCHu1W
	 9V1W6zUorD9qillqOvV+B9ouj6vqNuKIcr8/z0edLeqfvSeHHQhsVFBoZTzy481ln5I/L
	 UpbXVsC3B7h31cZodOmL/XI7HbTht2zEh2GaR1s7E/E/3fY6rKGnSuP+y+el7b31PAbFl
	 USBnSauvx0LVTwzxmyN1UTCMPIQXATIwlgJj6BqOXM6Zumm7obfeesgjKsXr+LOYLF0aQ
	 saencDktFo1fjPLgMGPWI+FiLDQ6MoI/sFjrxa6eAWle8AH83CM3YhJIrhUSLjQ7qRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz2M4JFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE99606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz2M4JFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5401F0089F;
	Tue, 10 Nov 2026 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312435;
	bh=Jx3SLt7x3xgQKoZ/g+VwJ2+pQlnVF++EioCk4UVifB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mz2M4JFeO6FCDI0mRsm79X/OJPv/54LRBvCaFecAUQPISO1ikboZ6u0jnT/naKBVN
	 QNoszicgEO3k00JbqYidHwg/JAiZgC6enY61SqquNr9TSyyTzSQKFz4fbGVragg4Pe
	 Cp3S4OZjFMuIyb54b+97QxB3CMSvmRfQ3BuHid09vPfCk+YPwEpcVDYs1PSs14YdOb
	 w32pAiir0rquCTk6V93dT5DwlC+fTwcW8uuh8bXHAe4PIQcTVStHZvwFKHBoq2mXuc
	 2uMnvKda0ebK5rNqQ0PK2uqUV0vIbHk4TeqsPICIFZ9JsVXO7zOQLI2EfkxbrnG1CA
	 +n6qs/47T3SYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Tue, 10 Nov 2026 07:07:13 -0500
Message-ID: <20261110120652.941189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060136-failed-5.15-8a88a46b86ca@kernel.org>
References: <20261107060136-failed-5.15-8a88a46b86ca@kernel.org>
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
[ sashal: adapted locking to rely on the caller-held kvm->lock instead of config_lock and guard(mutex). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index fd1fa2561520e..c3c0204b3eb1e 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -739,16 +739,21 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
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
 
 void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
-- 
2.53.0

