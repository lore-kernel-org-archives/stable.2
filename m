Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73E3F54AE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769545; cv=none; b=KbLoQLoVehUs3oD1hbfoOT45IsUZw/2vwGkzIoZKONhFAdR7QfzIgBWGROJhesoghSgG4QlLNtBAozPKWjjincnVVkStgRAIrG4I+4YwpieVnrEGADWAcHq85o7Jx4jdodiwny4eUYQqhmQC0dMT/bdU3YATtk/OCZUBYVRilSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769545; c=relaxed/simple;
	bh=Pq38pxeHfgPNq36kV2dwfYxcNIlmhKTBU8vrBDgd9R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZajzcfKxvYvBkM8O8nVy1a9af6DhrV/J2xTfQAAFGst3BawvIHeMie90/92WScARwyxarmlgDMjZ55fpr39KdSun2bjUHQOSodMmVPYo/+/AmOipo9GGVWRu3g5uLiye4Qy1JOtOgU2Og6vvZra2emSIcOpWhoCV23fUXkNVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g25YAEe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g25YAEe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDD31F00893;
	Wed, 30 Sep 2026 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769543;
	bh=VwcLznU3PcmNxvpElANmNsYBzkBl6oqyMvVRrwWPlks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g25YAEe32UqIPMOI4vG59+38nrPVTJUCikrxduJpWr89w8PK0Q10pcyAZRNwSpcy2
	 NIvdbgKXxBGNuv+fLC7c8XZgEOSt5KIwl8y9+3w2raOD2zCRSCPv6vtU77zwNpj0qP
	 95scQCmWVEbY9RQQjTvt0zERPOD+bsQWYU/yLsI3ORXsj33UDTJfXcJRdA0ztlqKo5
	 Duddr1V/cpWgoP+Tgyyoah2Ys679PIfSCTS20cnnX+HhikIXuX66wAoqewTmf8Pvwc
	 jXkTm05PhG0efgAbgRJ8MaG/jrI7bmrJEgXDEsUHHzeg3yohQV46Hy8DY/T4MUH127
	 mcECQ/RGm7RmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
Date: Wed, 30 Sep 2026 07:59:00 -0400
Message-ID: <20260930115900.1420640-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930115900.1420640-1-sashal@kernel.org>
References: <2026092917-extradite-anagram-9eaf@gregkh>
 <20260930115900.1420640-1-sashal@kernel.org>
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
index 562890ac5d0b0..22782b009e370 100644
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

