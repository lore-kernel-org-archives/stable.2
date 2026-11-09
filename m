Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224224;
	b=PXw0ryJMuYL75U+1PZw5wfb4r0Rt8mFZQAeXx+LqvJ2qaKNhd7qI8riXw/BWdpch+QY4
	 o3pOHwA7eDFbObujwfIbMC+dCcwNM94SIkKqbqILYW/4ZH0buZR9p57tWZ5L2nvWFCk9u
	 SgYAnmrXGnLtWwS9nG3TnHJ+rGNqJrnnVevERetBDyss1nMsKOCuZbLbZbV6ZTtGIbeBd
	 PPxkRpMnEmz2ZnagGq4xTSp4aqBCzdB9LFdD3ars0pwAR5IPLaBO0QSIlK0gw+jLA2ny3
	 P76H9GeQgcXchQ1GbefzcjSXws8Scj52gI/Dul14NH2MbruttJR8YxNwbngABvjXpcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224224;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yTR8yCAgo4xj+1Gvbui6n2IsRJmt5LR4YLnNBbblzGE=;
	b=vs6yiAkeQxmWuApGc0khqkJfV60woNiCu8uc/Yu/784wz87N+II5fXXySl9YrIRxctxc
	 pkeJigYfwIaSNOfSbXXO7VIqVkK046rADrjG/mNSGMK+DZc8xw7shyWuXoa3Twkueei6A
	 CtAONB2zu0GeG1J6AdV5vTzd6wvetwx8jEqi/Yg1L+v8aUcV8F/+d/Jnk6wQqs8rXFeEE
	 RJMRIR1AWaQmssvD+trx4xC+fucU9gJkwp0dKBuhK+dkqKiCo68HelYt72/TuhPEvcCrv
	 glV/FJ6b5xbuVRAXRtYEt7eJqE+0O5ikeu3ks3FJen3xYNR+3g4lVZyqXP4QBDwc/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62907606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62907606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jNSRB2PkJz1c0TC
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E178B406F9
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:58 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3C9FQsPFqxNWIDg--.22880S2;
	Mon, 09 Nov 2026 19:36:58 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH 5.10.y 0/2] arm64: kprobes: fix KPROBE_HIT_SS reentry regression
Date: Mon,  9 Nov 2026 19:36:44 +0800
Message-Id: <20261109113646.3140767-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:cCh0CgC3C9FQsPFqxNWIDg--.22880S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW3Aw1xWF1xtF4furWrGrg_yoWfZwb_Za
	yktFyDGw40qFW8Z3WIyay8trZ2grW3WFW8JF1FqFZakr9xXr1UXFZagrs7X3s7Wa98WF9r
	CrnaqFs5ZF1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Backport bb0fe9121aa0 ("arm64: kprobes: Allow reentering kprobes while
single-stepping") opened a recoverable path for KPROBE_HIT_SS reentry,
but 5.10.y still uses the per-CPU ss_ctx to match the single-step BRK.
save_previous_kprobe()/restore_previous_kprobe() do not cover ss_ctx,
so a nested kprobe overwrites match_addr, the outer SS BRK no longer
matches, and brk_handler() ends in die() with stale current_kprobe.

Backport the two upstream commits that remove ss_ctx and match the SS
BRK against cur->ainsn.xol_insn[1] instead, which is reentry-proof.

Masami Hiramatsu (1):
  arm64: kprobes: Remove redundant kprobe_step_ctx

Qais Yousef (1):
  arm64: kprobes: Fix Uexpected kernel BRK exception at EL1

 arch/arm64/include/asm/kprobes.h   |  7 ----
 arch/arm64/kernel/probes/kprobes.c | 53 +++++++-----------------------
 2 files changed, 12 insertions(+), 48 deletions(-)

-- 
2.34.1

