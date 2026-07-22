Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FC471407;
	Wed, 22 Jul 2026 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705963; cv=none; b=nGMYxdeBLTb0YvWsgEjoIlpVbzXMmaFxEns+VFoyZhRwwYlMfwYzxiwv+2YK/m9EX0hxDJn3IksQ7O+6uHWN7ZznLq8IMHlA8ShZofNsuwjOUQFBQ0ZhcgKWRYkQNfEqyh5VYDQqqQ9+PntBU17vj/qxl/qybXFS+0A+ccM0INY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705963; c=relaxed/simple;
	bh=a9Zq8OOgq879KVWw9HOSp0Nz+1GSxcStwaPYiKlBNDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSCDaZ/YscKN2NV0MbbzYbQeCfQ2dFraHy/B1rczPvGgnKgCiLicf0JBHgkL/IAyEnCHxwO4SFwnAPdAiT4DadI5pne7tKAZRXd45fTzIMT7iDZdjvsTNLIPYj6DHbZXpAsuSEN9lY24E1WuDtk49bj0FkmDCjGsfkzVWDdA8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OY52RA9b; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OY52RA9b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784705950; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KFhDP0rpjHHvnHTf+FsxNvCsOEune71OHfE4op53CvM=;
	b=OY52RA9bCkf0bUcAKxMEzk73/A8hj0hX0rjyRW5+tUpP3CjPX08RsFFFMXESHJ0ebUVETmK/mAtRJY0MM+8dA/j1+J7hhitd7ml9VfCxg6rnsgqRnlFHWtjecl5kr9qsEwVvs9AzWy1c3nJjoQM/w1Ri1xGuHEKweAmt+Qo+ZVE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X7cdnx0_1784705949;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X7cdnx0_1784705949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jul 2026 15:39:10 +0800
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
Subject: [PATCH 6.6.y/6.12.y/6.18.y 1/2] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Wed, 22 Jul 2026 15:39:07 +0800
Message-Id: <20260722073908.72382-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260722073908.72382-1-lulie@linux.alibaba.com>
References: <20260722073908.72382-1-lulie@linux.alibaba.com>
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
index f638b2d3a42fb..3f74767e47484 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15119,6 +15119,23 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
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

