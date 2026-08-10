Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C7237F75D;
	Mon, 10 Aug 2026 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339038; cv=none; b=DkN4h3TbaU88cByRO7uq+8k3Cd8EG/mbxrz2bU5kY1JOhYzn8kZXFgNjaa3IRJjXEsmEgrL7tgpbJ1FpwPwgAVw84jIQE2ayptM+vyYsyg68sjuwKSj5NoFYZ27BPfmI99tQ1Ho3cA35qfpA7o+vk1b10SZxnHWkrNTVWxtqKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339038; c=relaxed/simple;
	bh=9rEu8ZD4Qfh+m1uNRbrZ/7V6nv/rMfdIAWSkGKhEBXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMRgdRGCpvWHwpzH14w2SNJA0KHZ/Yzyz0pPSIxM0uDeesASWs2EWnB7x3cFUk1+aMI+RlmEDOVcLBY/s4uKrJC2/UeE9f5AXpJlZj9f342jx1qrBOdmH9SgMOGCVyk1QxWjP5byEXhiDOoc2rla+6Q8bCDIjOsV43/nReILyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ZUyjzbZs; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="ZUyjzbZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=g95oLQ7SjtKtG4RhAvYdPm09Nh5QYF1WOB
	P8Wpo/53k=; b=ZUyjzbZs9TcsgeyNyOg41AbkvXkCbKveLm1pTtKb8lR/PPsvgb
	OWd5jpLvAL4t4VW7effhrJD3kqcFvt8lwjgIjqpvB8kgcJHPyAlrGMpJUhKGQwOk
	p4ZYkqKFpXZIa3Ld3pq53BbGFdnZ9RoRbJ/HoMszXbytWJC6DNBd6cou8=
Received: from ultrarisc.com (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkOZXnlq2JYWAA--.18693S4;
	Mon, 10 Aug 2026 13:16:23 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>,
	kvm-riscv@lists.infradead.org
Cc: Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH 2/2] RISC-V: KVM: Propagate interrupted G-stage faults
Date: Mon, 10 Aug 2026 13:15:44 +0800
Message-Id: <20260810051544.3953925-3-xb@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810051544.3953925-1-xb@ultrarisc.com>
References: <20260810051544.3953925-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnEkOZXnlq2JYWAA--.18693S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyDZFWUAF15GFyDur47XFb_yoW8XFyfpF
	W7Cwn5Z3yFgr17K347tw4kur4Y9an0grnxurs8Zay5Xr45tFyj9wn5W347ZF15Gr1rXayS
	gryruFy5uwn5A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JUqYL9UUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2p1VlUAFAAQsS

__kvm_faultin_pfn() reports an interrupted host page fault with
KVM_PFN_ERR_SIGPENDING. RISC-V currently handles it as a generic error PFN
and returns -EFAULT.

Return -EINTR for the signal-pending sentinel so callers can distinguish
an interrupted fault from an invalid userspace mapping. Do not log the
expected interruption as a vCPU exit error.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 arch/riscv/kvm/mmu.c       | 2 ++
 arch/riscv/kvm/vcpu_exit.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d189fd5..3e955d8 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -708,6 +708,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 				vma_pageshift, current);
 		return 0;
 	}
+	if (is_sigpending_pfn(hfn))
+		return -EINTR;
 	if (is_error_noslot_pfn(hfn))
 		return -EFAULT;
 
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 88e0c36..8d36eb8 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -283,7 +283,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	}
 
 	/* Print details in-case of error */
-	if (ret < 0) {
+	if (ret < 0 && ret != -EINTR) {
 		kvm_err("VCPU exit error %d\n", ret);
 		kvm_err("SEPC=0x%lx SSTATUS=0x%lx HSTATUS=0x%lx\n",
 			vcpu->arch.guest_context.sepc,

