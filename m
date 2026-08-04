Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC13D3CE3;
	Tue,  4 Aug 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832156; cv=none; b=Y2odJSOhBFb4UjmTsB5BA7bSlgcv7wuE68HNxYTXy4odo5KY7/NMEXFlUibTOTAWYPRos8YdIhOX8+LuMfpoQCgfITDk9nN/sTV1LZ8bH3387LYkbryeqQ84vMnQZmtjQs2v70SUFvIU4AWGq/pO1WK0PuqLUlUz8vnEy0P4miY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832156; c=relaxed/simple;
	bh=k7yk5/b7qdepsPMCeaP36SdxlZvojFFonqwUNc0xcSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EoQIjuHcdoRo6/n+x8b9U21zaeFoV7AtWkD0rc5ZM4lBrQ4d9/YUbtSsJvDfWMHIeTFM5XgTCyapBTpVSHiOTUioF1MgBOB5tgsvZ0mryutS8EQL/ER2VX0KuWWQr6pFUKsfJukQMsnGgfZbN6RnqJDinjdUOskLogbibTJai28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxturXonFqizYKAA--.33315S3;
	Tue, 04 Aug 2026 16:29:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxfQfXonFqliwjAA--.5687S2;
	Tue, 04 Aug 2026 16:29:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Set cpu before IN_GUEST_MODE is set
Date: Tue,  4 Aug 2026 16:21:53 +0800
Message-Id: <20260804082153.1220709-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxfQfXonFqliwjAA--.5687S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In function kvm_make_vcpu_request(), it will send IPI to physical CPU
when vCPU is in IN_GUEST_MODE mode. And physical CPU is set in function
kvm_check_vpid(), and it should be called before IN_GUEST_MODE is set.
Otherwise IPI will send to wrong old physical CPU where vCPU is running.

Fixes: 2fc3bd86db4b ("LoongArch: KVM: Implement basic vcpu interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..fd0dd22a7162 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -300,10 +300,10 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		 */
 		local_irq_disable();
 		kvm_deliver_exception(vcpu);
+		kvm_check_vpid(vcpu);
 		/* Make sure the vcpu mode has been written */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 		kvm_deliver_intr(vcpu);
-		kvm_check_vpid(vcpu);
 
 		/*
 		 * Called after function kvm_check_vpid()

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.39.3

