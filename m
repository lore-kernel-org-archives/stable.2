Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC93C9EEC;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674602; cv=none; b=fNov29DiOJuy5imyijXPWC8cZEzkX4Og7kxAzY/leBVwnYhKHzI9zLtUVRHCeY7mavKO/N3/gXvJXftbNGOQqp8pteT1qGLO6evKMGP+nM/m7IIvFbUbUoQEHchwZuBLQOOGD8pn43MY/BAebZKIRjcAnVwRZRoxHhWUa4aoZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674602; c=relaxed/simple;
	bh=t6tAPcxoSxvLccjNgbdtGUrhfBckctxtLCprGjEY/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ5V5FwgIyFfsxERazrL0XPtS6T1QC0TXW7ILqe1TvGVtqvq5J7PmYeTxGUFBnTNX4fp+xCdtYYkW1HEeldM9OHn5XE1CN1vR3+RjG97RiaKk1t7x8swFVAh54Q7Uh5fWrwemEf1e8EOsTOFlCBjXKxrTiD+2eVOjytIBF54TT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfT70pSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfT70pSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4C31F00893;
	Tue, 29 Sep 2026 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674600;
	bh=+7vORc7fdZTgip4RumXbE7ra5AtBAZuP2iEiF6B3uis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mfT70pSKc3gXUTp3Fk2M+S8WN47Rg3CTTMR42zP31NuBHAXdtFPYfShOJaYr1SXaT
	 6xYJ1CHmKrxu4FJcItJ6pI2g6sK9an89SL5FqEM/lRrM61UJhtY0Omihn4FX7mxYt+
	 bmHDeQpDKsmtSnDT2uTv8CK9cPgShzLY/JuZ9FUcijMh3nGAfGcdczTak/ni2mCsga
	 vnXQx9Wcyg+o8Dv79p2FBaiQ9tjScc0N/j/ToDKuxNWt8htd0dsEgrodnK1DfNx0GN
	 uQxj8BjHbE+rFKg1v2ntHxoZMFSARncqn4oomNnVCuYb56mr1Iovitb0qdGv7U6R0J
	 WY+tGxnB4SS2Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGM-0000000ElEa-2Qcq;
	Tue, 29 Sep 2026 09:36:38 +0000
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
Subject: [PATCH v2 1/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
Date: Tue, 29 Sep 2026 10:35:42 +0100
Message-ID: <20260929093548.3598547-2-maz@kernel.org>
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

OUTSIDE_GUEST_MODE indicates to the rest of KVM that the vcpu has
exited. So far, this is set as soon as we return from the notional
hypervisor (which with VHE is just a function call away).

However, code that uses OUTSIDE_GUEST_MODE as a synchronisation point
relies on the vcpu state to have been written back to the in-memory
structures. Clearly, this is not what is happening

Move the publication of OUTSIDE_GUEST_MODE to the point where the state
is actually written, and give this write release semantics to ensure the
correct ordering.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/arm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8b080804bc90b..5f5dd8bead4b9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1352,7 +1352,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		ret = kvm_arm_vcpu_enter_exit(vcpu);
 
-		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
 		/*
 		 * Back from guest
@@ -1386,6 +1385,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		kvm_arch_vcpu_ctxsync_fp(vcpu);
 
+		/*
+		 * All the state has been synchronised, let advertise
+		 * we're outside of the guest.
+		 */
+		smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
+
 		/*
 		 * We must ensure that any pending interrupts are taken before
 		 * we exit guest timing so that timer ticks are accounted as
-- 
2.47.3

