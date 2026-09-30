Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1272D0292
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768656; cv=none; b=Io1eWBPExWgUsrsNyAl5Hzux0t8XGfW0XdAgtTQAtZ33HbHRQLtlkdchxRn792ph5OeXdqFokUDQXkmnMnUxR089Y2P7rboPyhCn8fyNCoMZKCxNdmJG1Whlhmasc3VK5xT7IqvLQaqdqIkGUHHoF9FvbUni6OVloGeEaJEWq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768656; c=relaxed/simple;
	bh=1OhviysVI+4r+otQUBg9bXpwA51lmd39cC9AZSI9k3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMsUZMTGgTF8ZK37fDHqjyzOq1e8TlgL85+mbHpqDU8uvpD0A6TJLYQSHbqdYpIhn080isXTH0MUhd17iIRKcWSWsrKxqEDf0BYeJfd9xLMELlz85Wf/fYj6BX8cXA+MesqGM5wYuMjE6D1gt8TJl00s0k0WMISzSegQAXOBsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7rN4uTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7rN4uTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AAF1F00898;
	Wed, 30 Sep 2026 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768655;
	bh=ubJ+3ee5nwFFjmE8iwyJowUylYYWcXCeNKEahJlGJP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7rN4uTMqtPNtExluc2znadG5F2+7oCgMLDjnROfRW5McnPdTSGEDgI/o92wXNLoC
	 hnYRntzR+lCpbIypn+I8o3Wil+SIGfkZM2kzm3HYoQYCjIrWhQNaKZTKCNNXGu+JHx
	 EVY2v5NNeRWhu10bSgwtH9O2uSJYCbHVQb1w9A8vsEivl5zhZPA4GSNn1IsrLhWF6m
	 OK0WCiI6CyYNKd9w7zn6pauTBVUofxKnY1F1G18Vbh91PhPgBD2fjpvQYFChInrToZ
	 drIiEEZvvvBt5AC7YOGSY13YmVYfMKcEJt2vBFmFrYc9TPE0C5Aqe861oZApxGYiO3
	 3hk/j6z4vyg3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiakai Xu <jiakaipeanut@gmail.com>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()
Date: Wed, 30 Sep 2026 07:44:11 -0400
Message-ID: <20260930114412.1342046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092914-nifty-tackling-3b69@gregkh>
References: <2026092914-nifty-tackling-3b69@gregkh>
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
index 11422cb95a644..0579c02ab02d6 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -952,8 +952,10 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
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

