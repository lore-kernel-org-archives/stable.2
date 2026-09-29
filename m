Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE847208E;
	Tue, 29 Sep 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674603; cv=none; b=XvK8GA33GJf1CplGTxfqQDONKzkAuDQqSQPyLKo3ttc+McjyKMXyzCn9jDH9kLOoCUfCvUPp52DZ5BAyy+rRDXLcluFyPVnzILHax6L6ZzZN3+oYpy3ZD9wItSSXHt5UUZ/uFZLzi6au1mSjwT2Pu/01SNZ5fff//oc11SE3XVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674603; c=relaxed/simple;
	bh=K3ON+PSIYZ6AcgA9jqDCpbeTLOL6MADP9ii0sndb/kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgqosihrVt7mupyy90Cca358JuwSxUXme0/qv0jUaLAfGAWtby3nQfTPZWgioOnpwtbmfTi24rhxOzqGq3zVFDGaaRapJtKFoXq/v84FTNFxDpjLZQrIUez4OpuYNbn/Fmk5Qpg+JirHGy9Bi2zWnrzuZFqwf9VCml4tp+i5laY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuMtNosN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuMtNosN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6FF1F0089C;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674601;
	bh=JI7EXFtD8nct3k80/WZ56pI4cZh/f9aZ7DXMwMK2D/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RuMtNosNqVo7Pz/5AF6jENaNlrdPjvQBwDFHaCk6Q4l1+iw4Lo0IAhD0NoY5m3Rv+
	 ouQa14a3LSCQQ+jTuvT1Asq3V5eXZvv0sJKL9nodIy7BwdfdlqlMwoPqTI6yH44DPD
	 btViPlSjrm0DtwxLTeAdjW0u/L1UPPR6JdyVopf1pMnh4/I+t7s/Qwm157hIdfDOfX
	 Ter8Y0h4dmYnnKAl4cK5mVIVXzyJNLFVzTPMJp6wBAriin7lrxxxg9e1/YLIF0NYnJ
	 E7gqONXH6zOWvV9HOJOT6/HQORmOz9PeiLGKmhe+Sa/0msQWAFusGuWBpWLZSanxcJ
	 bwPTT0jXxtZcA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGN-0000000ElEa-25iC;
	Tue, 29 Sep 2026 09:36:39 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/7] KVM: arm64: vgic: Stop the VM when disabling LPIs
Date: Tue, 29 Sep 2026 10:35:46 +0100
Message-ID: <20260929093548.3598547-6-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929093548.3598547-1-maz@kernel.org>
References: <20260929093548.3598547-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, ndaugoing@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Disabling LPIs is pretty nasty, as it directly messes with the AP list
of the affected CPU, which could be running... This has the potential to
lead to really bad behaviours, and we should not be doing that.

Take example on the way the Active state is handled and simply pause all
the vcpus so that we are sure they are all in a quiescent state, and the
state be safely manipulated.

Nobody has any expectation of performance for this anyway.

Fixes: 96085b949672d ("KVM: arm/arm64: vgic-v3: Retire pending interrupts on disabling LPIs")
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..adefc42964732 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -303,9 +303,19 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 		if (ctlr != GICR_CTLR_ENABLE_LPIS)
 			return;
 
+		/*
+		 * Yes, disabling LPIs is painful, since it can be done from
+		 * a *remote* vcpu! So let's not take any chance, and make
+		 * sure that everybody has written their LRs back to the irq
+		 * structures, and release any reference they would have.
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
2.47.3

