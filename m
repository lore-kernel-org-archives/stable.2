Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.46.229.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158558;
	b=B349QglrvgF2O3XcU3ohs3aGMKrghVtwPtepW7IgzUq3Uw60aqB5jZ59zkirS/c53r/d
	 uTgu0N5gOd/FyJ126g1O2NBPR1lit752iKi7JoJKRRI5G2Ln8F8EQVV/YS1YLWNxpqv3y
	 W/eBNVnAFAt6n2l1fowVOtI3gwoIksPligrVTmUQx6UX6bOgOp7gl0g6lfcLsoOntn2o8
	 24QiZo/pC/lIHh+o8Ub0cKmakxmTwvMlZeAh9Vf24mGveoYrEJTKBywIZ8OaRvGqElY2Q
	 QS/irwMTfNIQrRmBVIamjS28bcSWGrzCgkopW1C25bPXks2wOWELJpYLsZm5mGoVRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158558;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1g00Z6gc0jKWEBH3y928a6aryx0kBD5/KzHExqvR7e8=;
	b=d0n7N1J7+NS5o6H1U1+wf1RnjSFLKYdWjw534TJrpqgG4wGHliPGXRkQD9JhqOXjhVhL
	 yBLPWjiP0FMxYoiVd70XI1T6SV7GAoNS6fo/iekb4cT2wKZDYARGF4vqjZYqmJ0iAZTPA
	 4BM4pG2WX+LS4R6ETvJetC4IqBfzRaIhvF6orC4Z8IteqdRifkVFZieGjbC/YE3J8yy3u
	 gnGhP9hqvuBE75ttb3imSweQ9IFhd/wLEJ36m892eZ09cBRyH84QctSSjDwO86+gu6rAr
	 REp4zXDpa7URRKFIGY7S1ShEErpG4asvF9txElRE9n1zgP6AKAsd67/nUjgptmtd7UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	dkim=pass header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=NH4yi1OH;
	arc=none smtp.remote-ip=207.46.229.174
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CC606A325;
	Fri, 20 Nov 2026 07:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=NH4yi1OH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=eswincomputing.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=1g00Z6gc0j
	KWEBH3y928a6aryx0kBD5/KzHExqvR7e8=; b=NH4yi1OHYvolZYXR9tvk8yyp1b
	fh6TxNUWWBjeuZJiYLr2snd3whPmec+THRo7kr6LiZvKlRWA06zh6WWV2mZQbfyG
	FdhyVZmmymOD+d9+lKnaA8x5cBRyD8MYy99ik07UZa4xcntz6U8Wc1Hw+C48BSl/
	NO9EUD3L4L2LYIltI=
Received: from E0002472LT.eswin.cn (unknown [10.64.96.163])
	by app1 (Coremail) with SMTP id TAJkCgCXhuUB8v9q1FQAAA--.2533S2;
	Fri, 20 Nov 2026 15:08:51 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] riscv: kprobes: free insn slot in arch_remove_kprobe() to avoid memory leak
Date: Fri, 20 Nov 2026 15:08:49 +0800
Message-Id: <20261120070849.1239-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCXhuUB8v9q1FQAAA--.2533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4UXr4DXry3AF1rCFWruFg_yoW8WF4fpF
	s8uwn8G3yrXa1fG347Aw4kW34FyayrW3y2grW8A343Xw15Jr15Xw4Ig3yUXrn8Kr98Kr1a
	vF90vFWFqrW7Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43
	MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
	6yI5UUUUU==
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgERE2r-JS8i1gAAsq

When a kprobe is removed, arch_remove_kprobe() does not free the
instruction slot allocated by arch_prepare_kprobe(). This causes
a memory leak every time a kprobe is unregistered.

Other architectures such as arm64, x86, and powerpc all free the
slot in their arch_remove_kprobe() implementations. Add the
missing free_insn_slot() call for RISC-V.

Registered and unregistered a kprobe on kernel_clone in a loop
inside a QEMU (RISC-V virt) guest: before the fix the number of
kprobe_insn_page entries in /proc/kallsyms grew by one every 512
iterations (each insn-slot page holds 512 eight-byte slots), and
after the fix it stays at 1.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Cc: stable@vger.kernel.org
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
---
Changes in v3:
 - Add Fixes tag and Cc stable (Masami Hiramatsu).
 - Add Reviewed-by from Masami Hiramatsu. No code change.

 arch/riscv/kernel/probes/kprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 9e2afabf9..a76eab297 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -128,6 +128,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
+	if (p->ainsn.api.insn) {
+		free_insn_slot(p->ainsn.api.insn, 0);
+		p->ainsn.api.insn = NULL;
+	}
 }
 
 static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
-- 
2.34.1

