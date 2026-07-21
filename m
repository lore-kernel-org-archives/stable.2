Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD8433055;
	Tue, 21 Jul 2026 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619390; cv=none; b=hCoL2uW33r/RInqcyv0ZH7sDgvd/Sf3yL22bD8eEH6Ik4OxM9ZEKUXwffNY5YY3BEnhEluk9GvY7yCw26hQG/qhIBkn0D71YS0LOR3DWcRWNf9pVNiUCHPeB6ogvD5/6puj5JMGI86xEW7o8KwtvwxPKiww7LWn7+WY4cWMVmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619390; c=relaxed/simple;
	bh=Iv0AT2dhFmIxRsUgpYTSV9dCsy6ufgLF3smNBcHBA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9f7byBLDW5MsH2cAJPuDYBx/L6qQrWmCUY4zD5SQk/lYBkfUChswchT8GyFxXQyQcwvC8QBkqm/B+RYzqPtDcqrDXECmaQOyA57s/Irz56F9/8ryZ9N6CTnGKMRuZT6f/D/CSFZYvZwr9ZcEAMISKLFj/jKvy+VAjc95Bw6UPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=JPakA6HY; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="JPakA6HY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=5x1rA2f2vH
	eEloH8tmOOyMnyiRwuDQwFcjZOP1sZT1A=; b=JPakA6HY7ppl95cwipIyOPYLDe
	IebksX2t7jlCYJ9d2mKL1+/yKNziHF6dqvRU2laHhFZqOH2E1ilkInpxv4ZfnTuJ
	pEeyR3mCVU97vFjVx4kGHq/kS/6rz0lIavSVNJ/7e/jr84qtcwSmhLC6h4W+BZZq
	Sujzmktxn9Sap37Dc=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKJIV9qSWgUAA--.17346S2;
	Tue, 21 Jul 2026 15:36:41 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
Date: Tue, 21 Jul 2026 15:36:12 +0800
Message-ID: <20260721073612.137259-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUKJIV9qSWgUAA--.17346S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW8uw4xAryxJF1DGFy3Arb_yoW8WFWrpF
	4FkryFkryrAw1xZ39Fqw4kWayvkrnY93WYgr4Iga1fArs5JwnY9rn3urWjgF15GFykZFnF
	yF1rCF9YkFWUXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAOB2pdm1EAHAAEst

KVM device ioctls are not serialized against KVM_RUN. As a result,
kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
an IMSIC VS-file before a concurrent vCPU migration releases it.

The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
uses the stale tuple. A GET or SET attribute may consequently access the
new owner's interrupt file.

Serialize the entire IMSIC attribute operation with the target vCPU
mutex. This prevents the VS-file from being migrated and recycled until
the attribute access completes.

Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 arch/riscv/kvm/aia_imsic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index d38f5de08..2a4f88efe 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -969,9 +969,13 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	if (!vcpu)
 		return -ENODEV;
 
+	mutex_lock(&vcpu->mutex);
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
@@ -995,6 +999,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
 				     isel, write, val);
 
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 	return rc;
 }
 
-- 
2.54.0

