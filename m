Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889323BBFBB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769008; cv=none; b=fCH2wtwKvaGLhWI8H+bniJAr3/LTRcNtbMqJh6Et2myquphMCHD7m4tmOq4BqHgibkMQjHeXHwc1WX07pwFaoDSS6NG/UouJ+cph/ouyg5EVdJPJbxzBXJ3+D2/sSk2Ufx55HwHr/nUBLMHFDWabivfFGYEckHAayuZpkr8rbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769008; c=relaxed/simple;
	bh=YqTSpS+cikBo8pQ3tcBMSzgeVX5qeW0BeYSrDwutN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJE8wmBWW8w8c6Ju+tjwfncxNvKW5ogVqbvzLA5kEReVc8nctSpzXs8mHQze7f2YC/Vpg29D4f54Vg4sPjvXlqjJXIUmjGpc2Vjkicrc9PNNbG4Bk9SpxOAf4RdkJN9u6ExxQDiN1dNMAd0rSLzCtSPe/j7NqbE7JI1ytMahS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrmej9hx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrmej9hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E861F00898;
	Wed, 30 Sep 2026 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769006;
	bh=0vL5vO2PRYxEOvY+Pw6vB738p1bOBg5DpS3KZTB29ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wrmej9hxptldV3Mv4ULQNy+2COdKmsRBswwNtNBxe7FCcwJOMNknxSwxBlFFhz0hx
	 v7zYdncBn64+3zid6c/lh2YPkYVZ75Eb0gDgIQVUoFUTFBdBv4UULj3mB2OOPMVPTJ
	 aZQqsV06Eb+Dc9OEIAHxEZwW8yKGatSA73K5OBIjQQUNJ6E1QN5Fs+iPp4tTu0ZE5E
	 c6y5UZ70ZZl+ESdUW4zjef4sm58ezfO2UagF79OcOA9VdmPdMZuZguyjUoUnC+QAMG
	 UF4yI2RhoheGvBScUtAomUcJaZ9Y6k7i8/e3oAHz96pd46cNGZquQqJuSgKv5lkAhX
	 2JrythDlZNa2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
Date: Wed, 30 Sep 2026 07:50:03 -0400
Message-ID: <20260930115003.1386871-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930115003.1386871-1-sashal@kernel.org>
References: <2026092914-dreadlock-impound-a776@gregkh>
 <20260930115003.1386871-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xie Bo <xb@ultrarisc.com>

[ Upstream commit 8ae12ccaec6ec74945d8c1ef39f2c1b8df779abc ]

KVM device ioctls are not serialized against KVM_RUN. As a result,
kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
an IMSIC VS-file before a concurrent vCPU migration releases it.

The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
uses the stale tuple. A GET or SET attribute may consequently access the
new owner's interrupt file.

Serialize the entire IMSIC attribute operation with the target vCPU
mutex. This prevents the VS-file from being migrated and recycled until
the attribute access completes. Acquire the mutex killably so that the
device ioctl remains interruptible while waiting for KVM_RUN to finish.

Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/aia_imsic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 751b7ce356068..abc247f7c9034 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -895,9 +895,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	if (!vcpu)
 		return -ENODEV;
 
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+
 	imsic = vcpu->arch.aia_context.imsic_state;
-	if (!imsic)
-		return -ENODEV;
+	if (!imsic) {
+		rc = -ENODEV;
+		goto out_unlock;
+	}
 	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
 	read_lock_irqsave(&imsic->vsfile_lock, flags);
@@ -921,6 +926,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
 				     isel, write, val);
 
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 	return rc;
 }
 
-- 
2.53.0

