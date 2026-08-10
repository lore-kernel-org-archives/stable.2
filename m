Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3901DD9AC;
	Mon, 10 Aug 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786324889; cv=none; b=e5gQAnQUArQlmThoyYEdmnnafCFNEDr0YZdPVZB/TzcaoAg1ItrWTN/4/Tj4ONacMV94nwlHo57yEYX3LY2XkKq/mVMlo88vxvUEsErsfucCN8cjCh8mRDPUjn0f6QPZOV/aRz4AKXhKB5b7pGUEcfnyOco9MlBwZKQYz5UdGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786324889; c=relaxed/simple;
	bh=wtmq7XEHRea751PL39TRlvgDocVMtRKCug5O3oxwNMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=ZI5onuNxhJ/xq4OnAe8TF4G7BB3w0hPiV6rYVDIgabapqQU+xLvoAfVp/F4ZBGY3YpqzFOcoopHiDVjoy6sCicYa/phjYJh3MIQI0cMCUq3YTHXqXeFjpZHrcKevH1mvokZXtpEFXj9e/rQziCxMLINbhU1+Rhwog8F0SM4eTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOIyANRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOIyANRj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F6EC2BCB9;
	Mon, 10 Aug 2026 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786324888;
	bh=wtmq7XEHRea751PL39TRlvgDocVMtRKCug5O3oxwNMY=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To:From;
	b=jOIyANRjChkfhnf1TDDEp/25gy56crXsNumbU5wcaE2xTv66tOov7+p7/1xps12xs
	 /hpsHXPrGs0dFHe8ACIH398ZnUbHR5OtEgl7kSMTBVPluPfLNPtl6UxQihbNx9tzg7
	 kpRet4p4abikc64Q7fA7zcUjcvF5HlIbi7Tk70j0wNejWfn8LBoX8OqHAvEi+ldbW0
	 PFnskIr/3JKYxDBhF1GyzwvfAO6Nmc6pusrttL/SlMIlUTxvRufmCTFH/+Ys8JC/qY
	 c1P45RyWDQRECqGU9xBF9ibxUAnUewOvQazThPPsLNk4lh0GrcD+eQD4wJ63nkExRX
	 /tQmQhq7YuUwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFFC5AD55;
	Mon, 10 Aug 2026 01:21:28 +0000 (UTC)
From: Xie Bo via B4 Relay <devnull+xb.ultrarisc.com@kernel.org>
Date: Mon, 10 Aug 2026 09:21:15 +0800
Subject: [PATCH v2] RISC-V: KVM: Serialize IMSIC attributes with vCPU
 migration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
X-B4-Tracking: v=1; b=H4sIAIoneWoC/43Oyw6CMBCF4VchXTukLZeqK9/DsKh1kEmEmmklG
 NJ3t7Bx6/JfnC9nFQGZMIhzsQrGmQL5KYc+FMINdnog0D230FK38qgk0BjIgY2Rga1DkK0x2sq
 6biSKvHox9rTs4rXL3bMfIQ6M9ucYraSpWqVLVRndnEDBcru8n5EtU3Cl8+NGDRSi58/+bVYb+
 P+8Syl9AfhrvaPdAAAA
In-Reply-To: <20260721073612.137259-1-xb@ultrarisc.com>
References: <20260721073612.137259-1-xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Xie Bo <xb@ultrarisc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786324887; l=2118;
 i=xb@ultrarisc.com; s=20260810; h=from:subject:message-id;
 bh=FN+s+dZU8x/9zYsAqO7dZdJ8/YEPF8j1I2LUPLYxSPg=;
 b=At33xJ3dHR0j9wXFxdIzEYGU5MBM29ywdU+QrQSNgCvRQNCU4eMc6niylLaA2OdmR+6z77Yzu
 7ObKeiaeOz/CkmbCVfPYMdMk6cLpWur30kpe8VcTE2Kd5XihS+Wycvq
X-Developer-Key: i=xb@ultrarisc.com; a=ed25519;
 pk=Yb4TfiqO0TRwfKy3wvnt0+tbk0/QQQ42+O1jBrVaWq0=
X-Endpoint-Received: by B4 Relay for xb@ultrarisc.com/20260810 with
 auth_id=933
X-Original-From: Xie Bo <xb@ultrarisc.com>
Reply-To: xb@ultrarisc.com

From: Xie Bo <xb@ultrarisc.com>

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
---
Changes in v2:
- Use mutex_lock_killable() and return -EINTR when interrupted.

Link: https://lore.kernel.org/r/20260721073612.137259-1-xb@ultrarisc.com
---
 arch/riscv/kvm/aia_imsic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index d38f5de08..74f520e57 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -969,9 +969,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
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
@@ -995,6 +1000,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
 				     isel, write, val);
 
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 	return rc;
 }
 

---
base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
change-id: 20260810-imsic-attr-race-06772a04450e

Best regards,
-- 
Xie Bo <xb@ultrarisc.com>


