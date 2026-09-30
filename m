Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716D3E410D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769544; cv=none; b=si7VJcBPTzWVHd6s7lrz/iCGlNJvoFLihKJrEhptoADf+y3j+r9Wv4h4y20URFn+3w398ehwBx04BcmXL10kA5NVl29W6CIM0bDAuandmi9QR+AATL7wO5ypF/gfn7WJsl99B3NhnBIbPRYrwj3GBpiL/wJzxsxaQXBO9f0dTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769544; c=relaxed/simple;
	bh=cJTkiPZCms0RjfDWv1vqr7YClWkekTT483qDSIR2QvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqW91KVUkExIqvSLc2Ju2719XtPGsDp4+8+LQFIe6zqJsyi/eJkZ9kAG00I1VjSQNtz88IEoN+iXbHzlxawKsVOWeM404RNBthJ0EoadKlPegjwWDIQJXnfQhHfXWI/19ysWBoEbXgKAIxzA9RTbyw74GGPpKwqzKULTqUvFOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONofE3To; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONofE3To"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0551F000FF;
	Wed, 30 Sep 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769543;
	bh=hHIxS8XXLto5PBC7apmumAxLaicekTAYVrVNprFbF+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONofE3ToAqW/q+BhhWBSMYx7QxJ5hF68tk9+EBe0K9hYg5wcwAOctpo8S98gTPCtA
	 4KbYQQ1pYGqsJxHV4L36nB/+mdjaysrVzGpKuEfEcTZqy06Zlt9wKyKcE/yRvqeELs
	 DLZvcL/tRXjA5EU2yCi8mcFcFHoALd25VYNDAuktTItibxpMWjy4zJyq0J4SaZ/b1l
	 0EoaLwhgOixQkvHadKCdyuob4n9ja7/2aF+JPj+tUuVGtKodVZ+zSyPkP6ZAIvR+7V
	 XZVYpqHNU67HGKqbWohka65yhw0DSIekMPbIl6oSVhoLWr3px2fqZcUNYWQ1uJXlAR
	 4UrjVAi7IkMMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiakai Xu <jiakaipeanut@gmail.com>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()
Date: Wed, 30 Sep 2026 07:58:59 -0400
Message-ID: <20260930115900.1420640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092917-extradite-anagram-9eaf@gregkh>
References: <2026092917-extradite-anagram-9eaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiakai Xu <jiakaipeanut@gmail.com>

[ Upstream commit aeb1d17d1af5924f7357d7204a293bd8fc06ea13 ]

Add a null pointer check for imsic_state before dereferencing it in
kvm_riscv_aia_imsic_rw_attr(). While the function checks that the
vcpu exists, it doesn't verify that the vcpu's imsic_state has been
initialized, leading to a null pointer dereference when accessed.

The crash manifests as:
  Unable to handle kernel paging request at virtual address
  dfffffff00000006
  ...
  kvm_riscv_aia_imsic_rw_attr+0x2d8/0x854 arch/riscv/kvm/aia_imsic.c:958
  aia_set_attr+0x2ee/0x1726 arch/riscv/kvm/aia_device.c:354
  kvm_device_ioctl_attr virt/kvm/kvm_main.c:4744 [inline]
  kvm_device_ioctl+0x296/0x374 virt/kvm/kvm_main.c:4761
  vfs_ioctl fs/ioctl.c:51 [inline]
  ...

The fix adds a check to return -ENODEV if imsic_state is NULL and moves
isel assignment after imsic_state NULL check.

Fixes: 5463091a51cfaa ("RISC-V: KVM: Expose IMSIC registers as attributes of AIA irqchip")
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260127072219.3366607-1-xujiakai2025@iscas.ac.cn
Signed-off-by: Anup Patel <anup@brainfault.org>
Stable-dep-of: 8ae12ccaec6e ("RISC-V: KVM: Serialize IMSIC attributes with vCPU migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/aia_imsic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index c1585444f856e..562890ac5d0b0 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -895,8 +895,10 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	if (!vcpu)
 		return -ENODEV;
 
-	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 	imsic = vcpu->arch.aia_context.imsic_state;
+	if (!imsic)
+		return -ENODEV;
+	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
 	read_lock_irqsave(&imsic->vsfile_lock, flags);
 
-- 
2.53.0

