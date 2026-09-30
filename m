Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149B4C226F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768657; cv=none; b=unM7aqrEjycQy4UqYk8ocpT+Sod7gO46ZReYXSUsQlPeg2mfWc0QDy0SWp+E66Kaf83uNoxY+VVY+tQ7H8HPLGjc9GC61U8OU9E8H7w7qYy9v+W+g61jUZPHdiB2brNCI0vmQXDT9YRCvYxmrEbgeaNXGOqtZ2vjyxUWr4ElJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768657; c=relaxed/simple;
	bh=agldRXgjEakWiJ8Lk/wifwzmC82f7lLft/mnppx06dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnVepZCgOw0G98gT77vueLuq8kNwdxWEVwZ/YmjpE2uwpqQDQv699wRV7CgC1a+TfWmp74/BYoe8HGsP8RESgY7eyLb9oq5v8F3tQPeG07K/Td1Uh3CT/8Ad8EeF7lTZz/aBoEb84i5rqY4XBhS58fE5FG7uw67wM6ej2uiHDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+HLpTx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+HLpTx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510241F00893;
	Wed, 30 Sep 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768655;
	bh=PGhovb1y8QPCvW600/Xxv5Vp3ajRs34Lq+pqpr7GxUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+HLpTx/9c6OgjdvdQQ7PNAaJxXVBrjyRyD0APZNGNdO8wbJI9VgrNyneI2tc+NMR
	 +PMGIgB6YYzQSpfpk842mAlZF36OA2oXAJeNwnExjUdYFqYzrCJZXaP6Q6cAdcnCcr
	 +JTo6gQol3JVY+VyldyCINlw8lUPlaouNa8LVRmlXsjLF/WQpBEQ6m1FYl+BnikXgU
	 BVZSZoBjL3OgVwqHTo0cWDm4XF2O7oOJz5FW3bZ+1w5UPaI0UsMyZuVukgGrwcLfn8
	 sSczqxv4dVO6v7P5whn2efzuoZgk4/PXgcCRGUFIyH+1yEa/zHNQNI5Tpw20tHw6p8
	 DoGuFaJNe3CHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
Date: Wed, 30 Sep 2026 07:44:12 -0400
Message-ID: <20260930114412.1342046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930114412.1342046-1-sashal@kernel.org>
References: <2026092914-nifty-tackling-3b69@gregkh>
 <20260930114412.1342046-1-sashal@kernel.org>
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
index 0579c02ab02d6..a357ea73516f6 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -952,9 +952,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
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
@@ -978,6 +983,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
 				     isel, write, val);
 
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 	return rc;
 }
 
-- 
2.53.0

