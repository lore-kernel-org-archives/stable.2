Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D24D796D;
	Thu, 17 Sep 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647633; cv=none; b=XZNKsVTzML09txKuTc+Mu0upz8VWh+H57zFDRhdkyHEQHZ3p66qmR0M+4JZKGySG7tJmL0cVPpV8AIUH4TkG+B7HbpJC3emvFlcOk2SkeBXgJM/78vgQE2OE9wxlKB/A3LBacFmEgUR2nCjlH57+unnfc6kjo7A1KlzK70PvCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647633; c=relaxed/simple;
	bh=zwEsoX2plWXY8euMusWjlTAAM+k2vXLgA5NaG70RI5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTuiAFE7evesWfhJhMz9Z6SDoW2QJabwuubBpMUTUo44OT6B1rAXMcrhdRdXgJkd6vwy2skG30uW4dV4crSQtnwlhx9yCi4ohvlg6d0y0RcS1n9bRAPMva/w60sBznebntnNd8ZyjZb5awr7BLx3a7D1kGNG2mnObvNP+vyooNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app2 (Coremail) with SMTP id TQJkCgBXbaD82qtq+5iDAA--.55770S2;
	Thu, 17 Sep 2026 20:20:14 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Subject: [PATCH] RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
Date: Thu, 17 Sep 2026 20:20:12 +0800
Message-Id: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBXbaD82qtq+5iDAA--.55770S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyftF13GrW7Ar17ZrWDurg_yoW8KFyrpF
	WDKrn8ZrZ5JF1UK3yUtwsrurySvr4kKa1rZr97J3yFkr1Yvr1rZr4vka47Cry5JF9YqF1F
	yrZ0qF1kuFn0yFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUoWlkDUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQENE2qqxK88TgABsG

The SBI IPI handler walks vCPUs with kvm_for_each_vcpu(), which
iterates by vcpu_idx (creation order) rather than vcpu_id order.
Since vcpu_id can be assigned out of order by userspace, a vCPU whose
hart_bit falls outside the XLEN-bit hart_mask range may be reached
before vCPUs the mask actually targets. In that case the handler jumps
to "done" and stops sending IPIs, leaving valid target vCPUs without
an interrupt.

Replace the early "goto done" with "continue" so vCPUs outside the
hart_mask range are skipped without aborting the loop.

Reproduced with a minimal userspace VMM driving KVM inside a QEMU
(RISC-V virt) guest: three vCPUs are created with ids 100, 0, 1 (in
creation order) and sbi_send_ipi(hart_mask=bit0, hbase=0) is called
from vcpu_id 1. Before this change the IPI is dropped and the ecall
returns SBI_ERR_INVALID_PARAM; with this change the IPI is delivered
and the ecall returns SBI_SUCCESS.

Fixes: 0611f78f83c9 ("riscv: KVM: Fix SBI IPI error generation")
Cc: stable@vger.kernel.org
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
---
 arch/riscv/kvm/vcpu_sbi_replace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 506a510b6..c2f1f7f26 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -64,8 +64,17 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			if (tmp->vcpu_id < hbase)
 				continue;
 			hart_bit = tmp->vcpu_id - hbase;
+			/*
+			 * kvm_for_each_vcpu() walks kvm->vcpus[] by
+			 * vcpu_idx, i.e. the creation order, which has
+			 * nothing to do with the vcpu_id (hart id) space
+			 * that the SBI IPI operates on. vcpu_ids need not
+			 * increase along the iteration, so harts outside
+			 * the hart_mask window must be skipped instead of
+			 * aborting the loop.
+			 */
 			if (hart_bit >= __riscv_xlen)
-				goto done;
+				continue;
 			if (!(hmask & (1UL << hart_bit)))
 				continue;
 		}
@@ -76,7 +85,6 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
 	}
 
-done:
 	if (hbase != -1UL && (hmask ^ sentmask))
 		retdata->err_val = SBI_ERR_INVALID_PARAM;
 
-- 
2.34.1

