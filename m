Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA3B2D18;
	Fri, 28 Aug 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909810; cv=none; b=PBxqMxlAwBE6UgU9aTOjrDe2aOsK4jQycpF2YiSWqafTosdmAKIFmFeQwVYYupgLL76Pv6hL4hEEGCEnv6BC2kDwDUf1vPjyMZwtxKIjsmK0WGyY2qmYop2qq/FUsoWjvnBHdcsQWlt57/PyZf33EbGDqh8GRs1TV3ZTaELGDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909810; c=relaxed/simple;
	bh=CV5337KllrqzoibVYKGVHEwImKxG5nbm4g/avDe9flY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2u3v8TpTgcUzUD0HLZGNpFKYt+urtlMdO8XC1vgrvZTtL56zo1iBpV7lC8AXmeork9sOGsZz5sXx2bdHx59+duF/+Jte3WUm/QGk60vqIOlpWd20XbJ8BZGLGGwGcJ3v7MJQ8M29S/sw1FfUfrxknIgvmSmCOo70fXALRVjp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G6Up8Fd/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G6Up8Fd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=LW
	o5zQbL1k2n17EXASJEhxs5Bp+/4dt02LXAxbY6d6I=; b=G6Up8Fd/pwGPHmcmAl
	Px82zVC3pV6/8342SMlatKnZmUZTZA7kRUjQZtWGzJF9H10CItp8iEzCKPnOGxe7
	OmHU12jZ661RybDqdlBUzeomc6rSPUuC1nBgVKVM047Je9w2krHvLyEwNI20efL5
	LVbOUgz6DhedC4ZeB0bHE2roo=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXJzaGVpFqVvfGEA--.15969S2;
	Fri, 28 Aug 2026 17:36:06 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: yury.norov@gmail.com,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] LoongArch: KVM: Validate MSI data before routing it to EIOINTC
Date: Fri, 28 Aug 2026 17:36:04 +0800
Message-Id: <20260828093604.56622-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXJzaGVpFqVvfGEA--.15969S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15XFWfJr4kXF4UAry8uFg_yoW8CrW7pF
	W5uws8tF4rGw17ZFWvg34kW3y5ua1fXFsxWF1a9a43CFn0yF15CryrZFsrX3WYk3yrKrW0
	gFnIgw1Yva4DJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUVysUUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwAe1cWqRVoc-hAAA3S

From: Zeng Chi <zengchi@kylinos.cn>

pch_msi_set_irq() passes e->msi.data straight into eiointc_set_irq() as
the irq number.  The MSI data comes from userspace, either via a
KVM_IRQ_ROUTING_MSI entry set with KVM_SET_GSI_ROUTING (used by irqfd
and KVM_IRQ_LINE) or directly via KVM_SIGNAL_MSI, and is never checked
against EIOINTC_IRQS.

eiointc_set_irq() uses the value with __set_bit()/__clear_bit() on the
256-bit isr bitmap, eiointc_update_irq() then indexes sw_coremap[] and
the per-cpu coreisr/sw_coreisr bitmaps with it.  A data value >= 256
therefore reads and writes memory past the end of those arrays, i.e.
any process holding a VM fd can corrupt kernel memory beyond the
loongarch_eiointc allocation.

Reject MSI data that doesn't fit in the EIOINTC irq space.  The DMSINTC
path is unaffected as it decodes the vector from the address and masks
it.

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260531140921.1B1181F00893@smtp.kernel.org/
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 arch/loongarch/kvm/intc/pch_pic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index e7b77705c516..81fb534ce8dd 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -78,6 +78,9 @@ int pch_msi_set_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e, int
 		return dmsintc_set_irq(kvm, msg_addr, e->msi.data, level);
 	}
 
+	if (e->msi.data >= EIOINTC_IRQS)
+		return -EINVAL;
+
 	eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
 
 	return 0;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

