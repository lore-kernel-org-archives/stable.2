Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE35378811
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179384; cv=none; b=KTtukmD4X73rZp+g2llgRv0EjE8gDk6GRmbSGCEFVzMvS+ILr+v+9q6GoeRK++ilQkcWz6/P/Bss0MFuw50InVTWbjidx3xknnt8IVjBfuLSzOS5g23LFrME+axCn3l5WxGhReWdG4d+nDCnrgXDZQv9euI3ErJNJAuqemQ0W30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179384; c=relaxed/simple;
	bh=QtGuQD6Y9WhA9fpXpeTIYaXrx/WTjnsW3HXx6vlkPTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIyhsvCSNVqZn1UrTVBAQt9vcsJZasQ8bvDFj8JN65KKnJiefrfMPR01sRgsC/NNAdt5A5HoiBvaeKEuaa7dtdUGvZ0hNKI3hV+OQpMm75nDUaDvr+tHB4+4yhrOeCN1s1surFOaY6pingzh+MMrFeGjveuyol1aj67H0Z3C+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL5Y4fgD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL5Y4fgD"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fd66a094eso569722f8f.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787179381; x=1787784181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spw3TDdOtLdIsF7CwDxVZdY48WpWL2JF0u4UNC1DfkY=;
        b=IL5Y4fgDFWyiRspiAC3IzaArnIbe0/C3oXYLNLXgCiM8mVafW6NjVBo2FxqhYytFbt
         4s/PRDB2B2dRS4dVopAy7dTlF3qxFqBhwi0pyOI77WeN7JWPAl/yojoe6MPWE4Iihb59
         8BW6Y1AKJTM9ttLmECrg9lNKuJ7l//DcFZjZLuR00yYAGqvOMHBWWDalkNxFRhZJ8PzU
         8y2LloLIWFG29LgdrD4zuBEZm3aShizCs5mgE0Se5hYltRMPP7akSEKANr92wcut/LTH
         hsBtP/xuewh4VbYET4sfeQEpojfLbEDYwPihw6Wj99Tx8MZXwu1D9BL3Ix8jdwYpfmJL
         SCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179381; x=1787784181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spw3TDdOtLdIsF7CwDxVZdY48WpWL2JF0u4UNC1DfkY=;
        b=gGxdymd1EjS9MuUwmti5b8pJ2qGaUDYIUK5cCX67s+B6nJOVD4iObf9omkRVOvAcM3
         0Dbx2FvxC2WkCenHbjEzqFWyW1cgI+rILBVn5TNn+CIAPEEbTQd337ZwfmthBuevhsQX
         M8uUELlmgCo7qAI1rPyO4Q0IutX9t8TmSex5gKt7REChxo4rBt6m+rXqSis3FjGYjF+c
         2s9dwBOZ6dqH986vCUdTp3mhrG0yNWIU6KHLi1Vjt2Gg4UUc4QsMTrcNScdR8yZSP0e2
         EYXkxR5VCf0dkw9V5vLHwcXnHh0GuHjjHp3CMEgG6vcs0l6MyELZNvH4KLRdA8l8dHb+
         NBww==
X-Forwarded-Encrypted: i=1; AHgh+RqHTdCJJ4dYWFTmi+K42cjkDIfBlNPHyXrO2vehqha90D+as8HU4+y6Bho5j76o8A50DNgZ4A8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+DKEJKqwjIHde6w6OCUK3ySRXE7+3CTu0lTml/v9CuOgZPctR
	Bo5kEM9J+cEXoriczGEjSqjt2iIL9gaUIOyAdwx29Ul6rJEdwqdpBydF
X-Gm-Gg: AR+sD13wGc7d8uAywuGMRs6X4r7z6sJguuTYxT+ghPS7ltp49iNZY+fqzbJzOMacxoi
	cZ8pkTQ+i9gjHM+Xh0uNy0IX96m28rVokhdT0UwlIeGVaUkzw/dVBaHXM69H6/qN1wltfefW86y
	agBHiNZ/lfrkn4gofp0fGdJQR1sldJw68N0F2tKtikUACkG9DLy9Bs/D/WMUCChDmZyieRHk89O
	HLvpQCZHK79rqmt1u3vORIQtvyMGBRIHC50OwHwMmwV3zlgxrtR2dCU0zc0x1XY4+9ptEcalcao
	2ajjnbnjlgO0GN2JQ0LZRB4Of7QEowjNZu9jodzRGQN9hobURJ2OU++hYDuMawoVf9uU+pwjSBz
	xP4s9VeK4hQfShr3JVzvbSUVunaplmBHRLd81uctz+HCeBNTVou5VzOdZ6cA1iC/DAjghot9Fbt
	cs2z/wF1VTdoovrDnsnQZmjkqx3o1EGxGA3H6xHJGNr/XU9wN1FlTAK3IBpEy/JSa2eWoNl+qts
	YQn9+3ZSE/NUMwKCv1by8yPehfUfs2vA4VoHejgSfnaPWWPIulQEaJkS4xcm7uFraWZPYEIBmec
	6BdgIMMQOaYhDusewsZHUaA76ELWx96wh741tt6AEjepmplxKEGd0s9fU9DF0s8dy/E=
X-Received: by 2002:a05:6000:27cc:20b0:482:bb55:8bdc with SMTP id ffacd0b85a97d-482bb558d7fmr23879f8f.1.1787179380523;
        Wed, 19 Aug 2026 15:43:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm8553317f8f.13.2026.08.19.15.42.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:43:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
Date: Thu, 20 Aug 2026 00:42:25 +0200
Message-Id: <20260819224229.82948-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260819224229.82948-1-kmehltretter@gmail.com>
References: <20260819224229.82948-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vgic_register_redist_iodev() assigns a redistributor region and base
address to the vCPU before adding its iodev to the MMIO bus. However, the
region's free_index is advanced only after registration succeeds.

If kvm_io_bus_register_dev() fails, the vCPU retains the assignment while
free_index still identifies the same slot as free. A later registration can
therefore reuse a slot that remains assigned to the vCPU.

Advance free_index when assigning the slot. On registration failure, return
the slot and clear rdreg and base_addr.

Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d8301..c75caadbd1d3 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -766,6 +766,18 @@ unsigned int vgic_v3_init_dist_iodev(struct vgic_io_device *dev)
 	return SZ_64K;
 }
 
+static void vgic_unassign_redist_iodev(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+	if (vgic_cpu->rdreg) {
+		vgic_cpu->rdreg->free_index--;
+		vgic_cpu->rdreg = NULL;
+	}
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+}
+
 /**
  * vgic_register_redist_iodev - register a single redist iodev
  * @vcpu:    The VCPU to which the redistributor belongs
@@ -818,16 +830,17 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
+	/* Protected by slots_lock */
+	rdreg->free_index++;
+
 	mutex_unlock(&kvm->arch.config_lock);
 
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
 	if (ret)
-		return ret;
+		vgic_unassign_redist_iodev(vcpu);
 
-	/* Protected by slots_lock */
-	rdreg->free_index++;
-	return 0;
+	return ret;
 
 out_unlock:
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.39.5 (Apple Git-154)
