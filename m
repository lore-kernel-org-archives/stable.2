Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04F3F4100;
	Tue, 14 Jul 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014366; cv=none; b=sdm37E4hR0s/SMY1r5w0BIM31wvH3vZ1z7mcBiy0rl/W4kxqDblqr7Ykgg84VRX+X+UdKqMHPmbolEr0GmuTo0KJ6Y2Fn3+FEvPOuatYh9mXo4CcjpZDeAwfi/nViUdZ9t+v0yXCwMxctaiMPabl6gGZeJnydaKF5DxKjiGczDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014366; c=relaxed/simple;
	bh=5QuXQTRY9zoxb7Rfm/SQ7/4XLEGBNHIPI5V1y8znjfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAXqoX913DUvzGRwXwMelyajsSl9/jlJqtz+t8XvCifEAkJZvUjDIzTf3pMfiXytC+QsqvO1VFgeDRTj62L9GDHvPd+VG3qqxuAC1b6uwJ1oyVeObZCHnxnUnw/YoJBXHq4XmgRm3dzH1TEJMG8gSsMhMyXFb/fvmLvxPO2luWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxOOsa5lVqqVMDAA--.13445S3;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxIuQT5lVqzZEMAA--.38917S3;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Song Gao <gaosong@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/5] LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
Date: Tue, 14 Jul 2026 15:25:16 +0800
Message-Id: <20260714072520.2745942-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260714072520.2745942-1-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuQT5lVqzZEMAA--.38917S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Variable vector[] is declared on stack in function dmsintc_inject_irq()
and sometimes it is used without initialized. Here fix this issue.

Fixes: 03de5eecb0f0 ("LoongArch: KVM: Add DMSINTC inject msi to vCPU")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index de25735ce039..0a8492c4394c 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -21,6 +21,8 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 		old = atomic64_read(&(ds->vector_map[i]));
 		if (old)
 			vector[i] = atomic64_xchg(&(ds->vector_map[i]), 0);
+		else
+			vector[i] = 0;
 	}
 
 	if (vector[0]) {
-- 
2.39.3

