Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AC3FC5AA;
	Tue, 28 Jul 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232185; cv=none; b=ci/EzFXNnvBeBjgUXSoCl43q+xGV6STpjjHgQjDSJddaV+ufzYA7Ws0HSsUXLUo4DKWnsvKm7+L1HewforH6nEEfmfgSk+POQvj//9cUtT+YWAL7wA1iosSRDJOcSKyx+ZZdHmXYkILPgqlIPEFUJeCMaSdRUDxX3TyEPL7NtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232185; c=relaxed/simple;
	bh=6or20IU79xTDgm+IcDbfmRzZacglswNd59SSccjDCCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixIttQ0Xkr9UtfSvoF82dehatH99gZ+BTfvEunyQ/tSt3Mjmly4SgnFPKVtPvVg+2pUHLjS5pCuJy0mMcb2F7H8V1asZ39tTZoNAP0vwkZWVeClqCfz7V6e4QjqwWB+tckn4CyAO/nUCt71IcRBDIwHGu8rB2jwsxYDSDqhMvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VfuGlwNz; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VfuGlwNz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785232178; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sRPaGr5rv0RH36z/KNR97N3UhZAlwXsA3rL+e+XB4oY=;
	b=VfuGlwNzR+j796mHy8FPgB2Vfp0CQKPZZeC+Ujmg5SaWXa5/zv+B1sLCtx5NPghLofqSRJOXSetz7GfsbAve4WuSl2lLb1uKzslfdsPgHuVxMCRRxkYbjJ8eq3Wb+76S8z6dGxjJ5ChQR0fiLYCagiJE6IAnC+25Nc8/I1dD2nU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X8-LZEs_1785232177;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X8-LZEs_1785232177 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 17:49:38 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: daniel@iogearbox.net,
	info@starlabs.sg,
	ast@kernel.org,
	lulie@linux.alibaba.com,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.1.y] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Tue, 28 Jul 2026 17:49:37 +0800
Message-Id: <20260728094937.110393-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit ee861486e377edc55361c08dcbceab3f6b6577bd upstream.

Usage of ld_{abs,ind} instructions got extended into subprogs some time
ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). These
are only allowed in subprograms when the latter are BTF annotated and
have scalar return types.

The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=0 +
exit) from legacy cBPF times. While the enforcement is on scalar return
types, the verifier must also simulate the path of abnormal exit if the
packet data load via ld_{abs,ind} failed.

This is currently not the case. Fix it by having the verifier simulate
both success and failure paths, and extend it in similar ways as we do
for tail calls. The success path (r0=unknown, continue to next insn) is
pushed onto stack for later validation and the r0=0 and return to the
caller is done on the fall-through side.

Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260408191242.526279-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Dropped visit_abnormal_return_insn changes: depends on 7.0 symbols from
 e40f5a6bf88a ("bpf: correct stack liveness for tail calls");
 Hunk1: adapted IS_ERR/PTR_ERR to !branch/-EFAULT to match push_stack()
 NULL-on-failure convention. ]
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4380082f321c7..4ff1d5007a23e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10751,6 +10751,23 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	mark_reg_unknown(env, regs, BPF_REG_0);
 	/* ld_abs load up to 32-bit skb data. */
 	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
+	/*
+	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
+	 * which must be explored by the verifier when in a subprog.
+	 */
+	if (env->cur_state->curframe) {
+		struct bpf_verifier_state *branch;
+
+		mark_reg_scratched(env, BPF_REG_0);
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (!branch)
+			return -EFAULT;
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		err = prepare_func_exit(env, &env->insn_idx);
+		if (err)
+			return err;
+		env->insn_idx--;
+	}
 	return 0;
 }

--
2.47.3

