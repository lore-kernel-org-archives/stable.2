Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43B39989D;
	Wed, 26 Aug 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726585; cv=none; b=iJQ6ybQ+S7lWpU8eboCaeQISdUU8sxAx/+WVvvjGmmsaAuqLIpljNCdpE051S4xkM8GhX6ryEG+t6Ouq945aEgmg7sgpuysHwqcA5/kHkndn4kB+A/HgdzV9f0G6lahv5/5J1m6iEgTXlAXbZr9OtDqk55khohU+gkDfkd/M9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726585; c=relaxed/simple;
	bh=AHBBxUzsekOA34NzJKTET1M4i52W8poYryc+pn/grwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJnzbPmDTaOD0mNAw5qUTywIPQBMiDrmBSDTKeB5cdzx6rmzYD/slMGxijimLC+9J2x355CLvGUiVdJ4khHxExfclpa+fLfASNtJR+tTeHS00/eIkkSHPrd0wNpBTXzb5hFkIcAaHiR5Xv9b2cDCvhDxz+9enOoSxd3Giy07b90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nHhrjsvw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nHhrjsvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J5
	wmbMVjfWUBCfpN0Lp0qCoOGcsiprXR0qo1DrktL6I=; b=nHhrjsvwBUSCK4U7Zo
	14IX8BgmYz/ItK20Q3P7zRZeaPkt1JYLsDM85BYejRgvxoApM5qKzlNnbXkFBB/h
	EXFAIDDljjdqlmwLPseWnFwd27cRDikCbAeLk8OAP1ugD/ljcqCbUdWa0UXC2fY7
	iblWK/GFl7sqctbXmipdDPQ2Q=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHDxyPio5qdUk4OQ--.40540S2;
	Wed, 26 Aug 2026 14:41:19 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: ajones@ventanamicro.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
Date: Wed, 26 Aug 2026 14:41:17 +0800
Message-Id: <20260826064117.58029-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHDxyPio5qdUk4OQ--.40540S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUAF18AF4kGF4furykXwb_yoW8AFyxpF
	ZxCa4FqrWrAr1fK34avFWvgrWjvws5urs8Xr4xGa48Gr45GF1Fvwna9ry8WF4Ut3y8Xa9a
	qr4rZF98CFs0vrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbUUUUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0RAFsGqOipASBQAA3d

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call
overwrites kvpmu->sdata without freeing the old buffer (memory leak),
and if a later kvm_vcpu_write_guest() fails, the error path frees
sdata but leaves snapshot_addr stale. A subsequent
SBI_PMU_COUNTER_START then passes the INVALID_GPA check and crashes
the host with a NULL buffer in kvm_vcpu_read_guest().

Fix this by clearing the previously installed snapshot area before
installing a new one, which keeps sdata and snapshot_addr consistent.
The SBI spec suggests a single invocation but defines no error code
for repeated calls, so KVM must tolerate them.

Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Cc: stable@vger.kernel.org
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 752f1014d633e7d67f69c27b72088ed560c187ac..14f73490f12cbc5a8547859f0d1bb1170d89403b 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 		}
 	}
 
+	/*
+	 * Clear any previously installed snapshot area to avoid leaking
+	 * the old sdata and to keep sdata/snapshot_addr consistent if
+	 * the re-install fails below.
+	 */
+	if (kvpmu->snapshot_addr != INVALID_GPA)
+		kvm_pmu_clear_snapshot_area(vcpu);
+
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!kvpmu->sdata) {
 		sbiret = SBI_ERR_FAILURE;
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

