Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E393B27DB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166868; cv=none; b=JzJVRx1JyPjFZlnWx5Zc83ledKCT60eO3dRnQLqaEfOzuTJ6yDm2rvM/onbBpEzyO9LS9AncNClSzS25loKhYB7u6qWEHzQNBmrRqjlUDYzF0QAkrfAMvfjW0lYTSkSLZ8R5rg/jRdvWj36hOhuwUIuCl/F71VUYsw6nstJY/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166868; c=relaxed/simple;
	bh=aLdebKuqpPjYyiXqING6Kshh+B61ZgePmcotJBZ75GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUHh61Fq0dFo+hIJLmMf/SjHIw2j/lVAeVQgJgZQhdw/e6/6w7M0HMJ4G8Vfsf7h1CCftiq+6IsnU5pzrK7QlwEtz3Mys1y2igq1QhdE/Yv+Yt3qy0gAk9S4hz6Uzx/nT0TvYpG/wo+wFs80Jqt8Nc2X7kF0FzT859pi/ertHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVSd9pIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVSd9pIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB541F00A3A;
	Mon, 27 Jul 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166867;
	bh=dMHu5FZRUYJfyOt2A9g+6xGqjXFHc12zfGiobjTFjO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVSd9pIFZYMlWeJzWDMjrK71gQ2kIzJZmKtUrrmllzekNyyMcKBZDpiPvjOyrVFLe
	 wd1CJibScggthzn9OS0cMyr6n60IvtL9QYSFFPuIPRgEMGVjepTJCOZMX2IcdjIa55
	 VIKr0Fa2qAWprvLdvEZm52LOyCvQnAX41DY3jtaGki7LH4YGGTnq+v1f9pudgcj/nt
	 Y0tXgiv4bZC1EKEl0j0BnCjp+qnPo5Tu0xits+r1rKfpGDOYyzN1ivfVsR/ML/IvbA
	 hb/2L2SgjUS4hlmXcZ5FVyRKjwlP7R3RxaKlZQdIEeGlDjto85OSaVkrN+HIQ2nwDG
	 LPBXLQOflq5Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Mon, 27 Jul 2026 11:41:03 -0400
Message-ID: <20260727154103.1515347-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727154103.1515347-1-sashal@kernel.org>
References: <2026072011-poach-marina-ef6e@gregkh>
 <20260727154103.1515347-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 5e0b273e0a62cc04ec338c7b502797c66c2ed42a ]

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260622230123.3695446-2-tristmd@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 373e6a2326946e..38436a2708e564 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7219,6 +7219,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.53.0

