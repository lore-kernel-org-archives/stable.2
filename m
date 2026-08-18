Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F313845A6
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040877; cv=none; b=GnObA/bviYzvAmMASwn9aem8T3pCP10ybtB4tvkqK7LcSLp08OWKY4NEgwckbetpSlyQwP9twLSLsPYVTyeyd7av0JNs7rhDlmOzgCZnlPkI2rewVuQr6fnigWBQx/MJB+NToqd0zCkIG+QAH9MBZIABmen46KkCLl5Q7kR8N3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040877; c=relaxed/simple;
	bh=LGEEYwrDDjYlI4xq3y3au/4mSR/WgnhKjANJvWo0y+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifZ4vs444Zloa7hiiJtL2uSj4es+09QYUnDZsnnrqe3aya6Gt1NWlLs02kRDbUbSS4Npab0hBsVdHxJEvkSrX4rhIV5Q/KepeaxxPb6qPS18o1GD2OwfP9BIQoYQE/vX460Xd5Yc+0Ynr3c6Ghqv+xbQshtpqUF20CPp5rKpCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yadjh3MM; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yadjh3MM"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498074920dcso18401265e9.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787040874; x=1787645674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pAmmE6k6SRufhwVUzL6Niq7/iJdZAFyLPpQR+7pDuk=;
        b=Yadjh3MMXBKE+//RsUKOKlyK7zP9LfJDXprDePZt0hS3KzdevEPLAKwRTZbv79W3R3
         r6rBYgCFYSkjE8v1UdwwYNlVEitSOYmZAPtbzDV50QvvwopEi4gT6UCz4fy5Gaxh62ac
         ABMgMhtiBnH7DQw6xiKWi+V4v8r9J2RU3ogH5mPviQTeq9Dbdd0qg8xJqRbu3NoQzXBf
         FphaRA32HuETZzWrcAFlbhC8OkkNgPLGtx6ZQD4+/XrWI5f5p/mk/8aJ+X3bR4KjfqYu
         rf93Nbe75zHzWOKhZDWEEh8AJCNXwGsjkr8A5LGrwICEbPAdRSeqfdYlZnF60R9hZIex
         tqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040874; x=1787645674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pAmmE6k6SRufhwVUzL6Niq7/iJdZAFyLPpQR+7pDuk=;
        b=T5yjTu13ma08hkBhpkb+OuKSM9UIC9sizxJjJVdggi3qECaDoipaKfwDTDr85qN/qF
         HaDd6JtYmx9ZvCTi5vzd5BcSkAnS7HQQ+iwP1HdeYZp2iFNpSaGJ8Twe8fwziUeHO+U7
         Dv/YVGtEp8+sU84/eCMpi07Jdb9PpNyUQPEZbHipVPlqhWWETXGJQGA6sijRYRICX7m+
         ncEj0LO4senunTbnk0nhJDZOp2VN35A5+MHqkJAAyR/yFTbYXhPmtSbCZMEV2G59P9Ar
         +hxJdQyMYBaWiKijQa1c6dVwRqTY2b+XXdDF+V9k+3ZyWs+IPhnFYPkeVq8U3ry1/47g
         X/GQ==
X-Gm-Message-State: AOJu0Yz1uc7cU4d77Q/vQuZNhap9zsCKSsZ7ScMMbzAw8/ZXyWe/v8w+
	bgvKLYYxRLiIzxHOb4/bAbiFztlkAJNXcQDsmpBg5ATu5zw7ESA/RbKCrAsHpLgl624LSvGn9GU
	MequFcSrSgxrZ
X-Gm-Gg: AR+sD10urruK+8xKx85usZqx7xbo3YTEdiDAckTXppQd9w4PZScKlZb9t3aKGF3zsPk
	7R+afrU721rJGiPKSB6oM6I+XsAUAwvzs2XVVs/gKpIHwgqJyDBngQNBRu8xo+D3IF4gnHGVN5l
	KxHJ7VF+kynpRCvhLIGvWPyTSxOdyo1pnAK2pvtNVNcREZEL2yI/b9u3vN53Q5DBoGE15RjNwhm
	hPWgDlWL3Zum1rrvcN735mxOOUGwOPJG/3f8sgsAI+fNJC7UpFZa4adboIOMeGJ+lIbmWaz+MOd
	mhQL+jyOLToqfeNyznJzcyOKtwVTPqmelEAHS2wwLEL23QPb9fXvcXwCVuNPwuizZVOp0I5PeKv
	EjyqQ6kfHzg0Fe0IQmKN5aev8MXwn+IrTYp81mFa0j+2bkkn/zXUmSQUTJrrSd7c7z3mndTexFQ
	mt7kV730L2Li7gKTAi5w1qKC7d9ngLSbHof1mRubB7rhv3h01bPG9U0XDzg6xWf7+IyZxdasO12
	87UqXOLUkZM/eqLeg==
X-Received: by 2002:a05:600c:c171:b0:499:7f38:d77 with SMTP id 5b1f17b1804b1-4999fb2e1dbmr111259955e9.6.1787040873602;
        Tue, 18 Aug 2026 01:14:33 -0700 (PDT)
Received: from localhost (27-240-49-235.adsl.fetnet.net. [27.240.49.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b3b91sm5227715a91.13.2026.08.18.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:14:33 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 1/4] bpf: Fix linked reg delta tracking when src_reg == dst_reg
Date: Tue, 18 Aug 2026 16:14:19 +0800
Message-ID: <20260818081428.57938-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit d7f14173c0d5866c3cae759dee560ad1bed10d2e upstream.

Consider the case of rX += rX where src_reg and dst_reg are pointers to
the same bpf_reg_state in adjust_reg_min_max_vals(). The latter first
modifies the dst_reg in-place, and later in the delta tracking, the
subsequent is_reg_const(src_reg)/reg_const_value(src_reg) reads the
post-{add,sub} value instead of the original source.

This is problematic since it sets an incorrect delta, which sync_linked_regs()
then propagates to linked registers, thus creating a verifier-vs-runtime
mismatch. Fix it by just skipping this corner case.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: contextual difference due to commit 7a433e519364 ("bpf: Support
negative offsets, BPF_SUB, and alu32 for linked register tracking") not
backported. ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Checked that after this patchset is applied, no new test failure
occurs[1] when compared to baseline[2] (which currently has some
failures unrelated to this patchset).

1: https://github.com/kernel-patches/linux-stable/actions/runs/32108723314/
2: https://github.com/kernel-patches/linux-stable/actions/runs/32061193394/
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77183b436da5..eb84924799a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14543,7 +14543,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	if (env->bpf_capable &&
 	    BPF_OP(insn->code) == BPF_ADD && !alu32 &&
-	    dst_reg->id && is_reg_const(src_reg, false)) {
+	    dst_reg->id && is_reg_const(src_reg, false) &&
+	    !(BPF_SRC(insn->code) == BPF_X && insn->src_reg == insn->dst_reg)) {
 		u64 val = reg_const_value(src_reg, false);
 
 		if ((dst_reg->id & BPF_ADD_CONST) ||

base-commit: 25c09b42358e73e1476e517b296edb6344f2e4bd
-- 
2.55.0

