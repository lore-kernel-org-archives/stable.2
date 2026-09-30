Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0A3546CC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769006; cv=none; b=Gfd9d//4/3bAYWvgitHIl8i3Ck2QVH+ur5Nvkt1CqMsOJwhVSm7XFPSgBYjmpNNNA3wGeMGhB5cRXdaGVjUqZ3PkUgO2PDbVFKoku3IL0WXlL8/LIUxPFlSD1sgh6j802HdrgSMMjN50lEJF4P9x8DZF8roIN2YedW1cIp5T388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769006; c=relaxed/simple;
	bh=q6LeiPIGhVDKSXQRqzQddasm24rJfcTiPX0Ej5fdyZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y78NgKXBoOLLE0BZiHUU4STuG6swHR2BQrZPm/EGxBTdBSw6RQJDTaMszazDWo6WkqTZo+M9/AjWWigydEsiPPpQoWXMNtIAeYEhW+AK59OKNHzzCh8uQModjfx9SnkPW2DKT2VnXhvd2bYkj95zIEdj8HL1Y8YrbqJ9pulhilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+wWU4eE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+wWU4eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0121F000FF;
	Wed, 30 Sep 2026 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769005;
	bh=1o6w0H+qMBB0i1tPB1i/E4NA6X8G3XG4S/kUuODplA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+wWU4eEiKMrqahnxRaA+YLRGS506Zbo0yS6MYZsKrm/7tU8dHzRpFcFi4F+OA+0Y
	 zDA/4EpfSN2iBzelbs10x8uHDMPa4ciebcGgQPodtmCatU8akxQxYZVTKDj30+Uwse
	 KZsJEVu3rw/sSCjLC/1Bnh3xj0ayGNFzxpsVAwmOioMxc2WD/mZ5IEPa09MIEERE60
	 eiMi/0ZYlhHsXpZHygzDpDr8emi+7NmhN7+79McvR5LeOqvhGnpsUwWz7yJtRylVAa
	 N5GDaVrFrkhHHKsDRR6ocaMkH6U1h4j4uWJ4Pja+icnIoUiyfNS+wW7RlQ+6P2cDto
	 T7dJYNXK0Weug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiakai Xu <jiakaipeanut@gmail.com>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()
Date: Wed, 30 Sep 2026 07:50:02 -0400
Message-ID: <20260930115003.1386871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092914-dreadlock-impound-a776@gregkh>
References: <2026092914-dreadlock-impound-a776@gregkh>
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
index a8085cd8215e3..751b7ce356068 100644
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

