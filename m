Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224224;
	b=Z19X3VxrMhYLorjur9w8WIv7l+eMkPS/oEhCT4vojt6sp+hMk+Wbv+MLc7j5KKHhi0y/
	 +5rNh+o957vX+E/12jqzqJS1WbfqaR/rl8DfexLzGmQdD45vWoBU+r60cW0oH/xerTxEB
	 JYDFCEhTvnn9RRIwUzr/efyrnEeml/13EjLyLbc6CRC8UQxl3tiFPuP7jfj9pnVsMn7D8
	 wlSFgcqpNJw0ETfTPen1/bkDW2YHYPiYdQdrDf0aGjxyCRlILVioz2Y+3ITCk7FzOKm8r
	 CcoacelAi3x01A/j0V/SA48IcfX9YBGsPtKOWC1kwdD2pbM/qxFPhxqLuImlR1e0RxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224224;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=m+VlDGgPqewytDFJzkukYRVGjYcIhGoZ1ltYP6SHrG0=;
	b=aERdPClYUCbdSnjOQO6VPP2YZ5kd7p6y2p7415ya3NOtLzxdXlRa8w7z+NDfPWjMaQ23
	 dF0mBfjEaoDgA/cOfEmxt8WreFtKebTsIq1Zt669MZbiYLh0FLFRxmptHcbeglo6wp9ve
	 cOC8YVeHDUb+bPurlel+JkG/YV2xYi4xosKJ52CHSGgkhjA3BbVJwtL04lvP0zDyrgDkR
	 PAWZEIwA/I4MUGzDE3As264oJV7WAvJh5pgCNSt+j239/QJZkpQh4SiXmj303zueFgkvP
	 ybZAfgJNWuLNdtkp8PL/sjQLdRWge6sK+i11VXV+hJrl7v47jjhlMhqSUqekROqkA7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1374606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1374606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jNSRD0H0nz1yph
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 274AD406F9
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:59 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3C9FQsPFqxNWIDg--.22880S3;
	Mon, 09 Nov 2026 19:36:59 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH 5.10.y 1/2] arm64: kprobes: Remove redundant kprobe_step_ctx
Date: Mon,  9 Nov 2026 19:36:45 +0800
Message-Id: <20261109113646.3140767-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109113646.3140767-1-wutengda@huaweicloud.com>
References: <20261109113646.3140767-1-wutengda@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgC3C9FQsPFqxNWIDg--.22880S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWUJF17Cry7ZFy7KF47twb_yoW7WF1fpF
	9Ikw13trWrG3Z8uFy7Aw4jyr1Syr40yrZrCrWUC34Syr13Zr13XF1Ig3yjyF98GrZYgw4a
	vry7trW8Ja4xAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbahF7UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

From: Masami Hiramatsu <mhiramat@kernel.org>

commit ba090f9cafd53dbabe0f0a8c4ccae44203d3731b upstream.

The kprobe_step_ctx (kcb->ss_ctx) has ss_pending and match_addr, but
those are redundant because those can be replaced by KPROBE_HIT_SS and
&cur_kprobe->ainsn.api.insn[1] respectively.
To simplify the code, remove the kprobe_step_ctx.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20201103134900.337243-2-jean-philippe@linaro.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 arch/arm64/include/asm/kprobes.h   |  7 ----
 arch/arm64/kernel/probes/kprobes.c | 53 +++++++-----------------------
 2 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 0a15d2329627..6d131318d577 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -34,18 +34,11 @@ struct prev_kprobe {
 	unsigned long saved_irqflag;
 };
 
-/* Single step context for kprobe */
-struct kprobe_step_ctx {
-	unsigned long ss_pending;
-	unsigned long match_addr;
-};
-
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
 	unsigned long saved_irqflag;
 	struct prev_kprobe prev_kprobe;
-	struct kprobe_step_ctx ss_ctx;
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 412afe22257d..215733a51f97 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -34,7 +34,7 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 static void __kprobes
-post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
+post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
@@ -68,7 +68,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
 
 	/* single step simulated, now go for post processing */
-	post_kprobe_handler(kcb, regs);
+	post_kprobe_handler(p, kcb, regs);
 }
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
@@ -192,19 +192,6 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
 	regs->pstate |= kcb->saved_irqflag;
 }
 
-static void __kprobes
-set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
-{
-	kcb->ss_ctx.ss_pending = true;
-	kcb->ss_ctx.match_addr = addr + sizeof(kprobe_opcode_t);
-}
-
-static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
-{
-	kcb->ss_ctx.ss_pending = false;
-	kcb->ss_ctx.match_addr = 0;
-}
-
 static void __kprobes setup_singlestep(struct kprobe *p,
 				       struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb, int reenter)
@@ -224,7 +211,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		/* prepare for single stepping */
 		slot = (unsigned long)p->ainsn.api.insn;
 
-		set_ss_context(kcb, slot);	/* mark pending ss */
 		kprobes_save_local_irqflag(kcb, regs);
 		instruction_pointer_set(regs, slot);
 	} else {
@@ -264,13 +250,8 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 }
 
 static void __kprobes
-post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
+post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
 {
-	struct kprobe *cur = kprobe_running();
-
-	if (!cur)
-		return;
-
 	/* return addr restore if non-branching insn */
 	if (cur->ainsn.api.restore != 0)
 		instruction_pointer_set(regs, cur->ainsn.api.restore);
@@ -387,33 +368,23 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 	 */
 }
 
-static int __kprobes
-kprobe_ss_hit(struct kprobe_ctlblk *kcb, unsigned long addr)
-{
-	if ((kcb->ss_ctx.ss_pending)
-	    && (kcb->ss_ctx.match_addr == addr)) {
-		clear_ss_context(kcb);	/* clear pending ss */
-		return DBG_HOOK_HANDLED;
-	}
-	/* not ours, kprobes should ignore it */
-	return DBG_HOOK_ERROR;
-}
-
 static int __kprobes
 kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned int esr)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	int retval;
-
-	/* return error if this is not our step */
-	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
+	unsigned long addr = instruction_pointer(regs);
+	struct kprobe *cur = kprobe_running();
 
-	if (retval == DBG_HOOK_HANDLED) {
+	if (cur && (kcb->kprobe_status == KPROBE_HIT_SS)
+	    && ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
 		kprobes_restore_local_irqflag(kcb, regs);
-		post_kprobe_handler(kcb, regs);
+		post_kprobe_handler(cur, kcb, regs);
+
+		return DBG_HOOK_HANDLED;
 	}
 
-	return retval;
+	/* not ours, kprobes should ignore it */
+	return DBG_HOOK_ERROR;
 }
 
 static struct break_hook kprobes_break_ss_hook = {
-- 
2.34.1

