Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D646D2BC;
	Thu, 23 Jul 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805397; cv=none; b=LQXC9/mABz6iB1x/yqnycWO+R642RKWNG4VlKzcVFVa2idaqmzaS2Kq0t4KrzsdJjxpmjBNznDkZpzjrmrmjIBqCrvZ5XDY8OB7vTjbqC/sztPR3B7Op41+06sl8eFz6IVo6W/KZABVrvh7rzbJkjMlG09iX2qHCJijD/pF9DDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805397; c=relaxed/simple;
	bh=0EyhSGBvNaXr+JT9oRD69WjNww+zIMrRyj9AzRk+k/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gj3+VDbqoxmn3doVAYVi1fMZO1EcZ2nW9rHLV0w0iDHFxiq1mkpePdhju6tbfAY5CmF+JYPOz+1p3ipikHhDQvjEsU0i/rcKKLpiZSU3ODREakrLXkiOTdiLYAo/Nv7sVTQnSWwwgMuKmP1T3jBPNlFgBg6zFHBqr5+xv3XpWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cWGIPQ8p; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cWGIPQ8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y2
	YSnZ99ZPUSqV4dxs313N5avYciHXzKZ131X0NdH0k=; b=cWGIPQ8p6JRYsksafk
	a3B9TelJGXdR+OOJ/ec3grdcNiYdJ4uh1qp/l8a0plIta44AO+8b+qdCs5rpL0yI
	rxeHFiObiOL348yluLNif6dGmcZ0PtlExfx86BUQc64cn9/EywlX7RH5FK8gxGmS
	lV+kzT+Vk9uw4Z6HWkAPUbHyA=
Received: from zengchi (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3Xovs92FqnqXdHQ--.60940S2;
	Thu, 23 Jul 2026 19:15:56 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH 1/2] LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path
Date: Thu, 23 Jul 2026 19:15:52 +0800
Message-Id: <20260723111552.1623996-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3Xovs92FqnqXdHQ--.60940S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1fWrWUuw45ZryUAFy5Jwb_yoW8GFWUpr
	y3u34rCF4rJr4fZasrJ393Aw47CayrKF17XF12qFsaqr4UZFn5ZFyFkFWDuFy3KwsYyw1I
	q3Wkta45t3W8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUOz3UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC5w0s52ph9+2vMwAA3s

From: Zeng Chi <zengchi@kylinos.cn>

In the in-kernel MMIO read fast path of kvm_emu_mmio_read(),
kvm_complete_mmio_read() already advances the guest PC via update_pc().
The explicit update_pc() call right after it advances the PC a second
time, so PC moves forward by 8 instead of 4 and the instruction
following the MMIO read is silently skipped.

The user space MMIO read completion path in kvm_arch_vcpu_ioctl_run()
calls kvm_complete_mmio_read() only once, and the MMIO write fast path
advances the PC exactly once as well.

Remove the redundant update_pc() so the kernel MMIO read fast path
advances the PC by a single instruction.

Fixes: 80edf90831a2 ("LoongArch: KVM: Add sign extension with kernel MMIO read emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 arch/loongarch/kvm/exit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 8572b63478bb..482ba17bcd3d 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -481,7 +481,6 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		if (!ret) {
 			kvm_complete_mmio_read(vcpu, run);
-			update_pc(&vcpu->arch);
 			vcpu->mmio_needed = 0;
 			return EMULATE_DONE;
 		}
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

