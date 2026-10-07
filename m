Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278C47F76D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378260; cv=none; b=ljQh9/oj8+BEPT4UNNuF6ptiFfPcYC+TmkDtXid40GB6cuwkIU37XOH5bju26uDOYM64IPqfpJckcZq7XsVW1rfd6d/tx6gd6rCkgDWgveUZjnRTIBDPUavcMTETETtdlPkkP3FYUNIDy9CWkuroEPGTM6JsjWBTBIg5DAdhfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378260; c=relaxed/simple;
	bh=Xeblf6RefeP4xLbOLjn3rcWi09bg/RvtTBMwTZjkW2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Id3rQqMw1Rj2KFxDEYx8XrGc7k5nbzDef2i4YAuHu5fJYo8ocGZzN1PbnuTlO0YUq79o+sNMyS8bpV7K9YgEcTab/SrZs9sxkOHh3KBjOwq/g2ZkRS/H7hN/K7Cx9nP2DLBWdrw4oiWnEGqv9vnYyWgZlNq8pPlwwExdFKPUWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5sepHvx; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5sepHvx"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe4ca1052so8287745e9.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791378250; x=1791983050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wtfk6Lo3EsHBs+T8tzPIBV8ntCV/DDfwOlEBXJdzuvY=;
        b=B5sepHvxgzc1zxlfj1WMRiYgxAZxttvlQTIWHk0duXAP4JDWGKhZqOdMC7E6MFtzxp
         K5Rask59t9Zkes7lsqtbhExe39gIqjG0kVQgKSY3z0BakMdB/tHio5TrrK+sssqo+Egl
         aqLZgNlUhPcMYY4kDqSg1nEe7G6MThoVZcFmmjGKiidr2kLFsWuPskJn9LJWi8SDVv0d
         L1Lzlsye5bDonyMZBfygcACFw6hDnGotAMpznMZrCN00rShkrJREXtErNajzCA4qg5zq
         GGXk/ILuwiyC+GCNViZcNd7sW+9yN+xHhz/l4BLguHS7VNLwy4GkTKrO15OeUGgA450b
         hp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378250; x=1791983050;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wtfk6Lo3EsHBs+T8tzPIBV8ntCV/DDfwOlEBXJdzuvY=;
        b=IE9PzQanK8m0Wv2oVXHcrIGgWWKCdh3T+3Xi8kTB72tkpHKX0C3vTp1ifHjZHUh20t
         WiHRAM7HdpqrrxYiV3ML5R03at4DRfvE3ZPfuTIUGU16jYIrzRKTQeiC2fH1H8oeIb2y
         RcCo/cvJTAh5t1KxEbz+/Vm1J+v/C6kry3QpHsaA4Gr6WtTRHDg1H9bN+5gkzlsgIzih
         7Nn6N/5yIq7O5dd9OxQBmL8AgDdGx+1siYpwzz4AKaSL2mGofE313b13M0h8WZGCAWH0
         9J6GysV573fcpCgWtseRW8OhY5McmwWnRN9x0QehlpPCtxhL7nN4cwfmt+X13hDmGfpa
         s7Cg==
X-Gm-Message-State: AFuF++lCrWM5d49pBDyjYxuqv/sEfoqSZTxv+m+J6gizt60ITumue5PO
	lDLclJUu3v4eNhMY1HRJCYsveqnqI/9/DYcjbsp4w8/iUKR4ga98YtTPFoyiqVul
X-Gm-Gg: AYBFou3kZbeNNg2I4QQkIYbwttEbPdbkLMGXUiBaM6S3Nb80ivPL79/ijLmyaTKc+ry
	4kvffcDxpdZBiZaP6403zfkei/5PaA7khsDZyp3Nai9Qk1uOwceW87+ztO1lCoD8+nOnqh1Va8X
	YOejQZ+sMFYC6iofGDnDrm83A4b6ANS+mdjveheFHvQE1QI1286RRPDAEDHjdAKjFdguWJ3BgoV
	byt6FmAf3CyvetM5slVrkGaE/nEy7DgRxUq484jm5bO16rhuz1iWhaCLyr0UNA/WrJNxCJ2SWk2
	iGRGdvtzkyAvN78lInhaQuAWCoLj5P+zHzYAbpqpXvZOVxXbVemM+A0V42qDX7/sZuBDJA/azOY
	oK87yOIBwqqn/qBP2lin0LagMj1fAND+MUQVa6WQygk/FXqHrbTW21bvlkizlQvflmDM/ZnSmNh
	iGD3NvwSOvTbGC3/wAELfi9Hrl10covMZRW+VUQXphqm1QGyZrp8yDav6oHNWxWYWp4Ai3qBGun
	t3ISDSk3u3GXFxp
X-Received: by 2002:a05:600c:c166:b0:49f:ce73:5e94 with SMTP id 5b1f17b1804b1-4a18065ab85mr38007345e9.34.1791378249855;
        Wed, 07 Oct 2026 06:04:09 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f4482c4sm120825195e9.0.2026.10.07.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:04:07 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10/5.15] bpf, arm64: Fix off-by-one in check_imm signed range check
Date: Wed,  7 Oct 2026 16:03:54 +0300
Message-ID: <20261007130355.119579-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 1dd8be4ec722ce54e4cace59f3a4ba658111b3ec upstream.

check_imm(bits, imm) is used in the arm64 BPF JIT to verify that
a branch displacement (in arm64 instruction units) fits into the
signed N-bit immediate field of a B, B.cond or CBZ/CBNZ encoding
before it is handed to the encoder. The macro currently tests for
(imm > 0 && imm >> bits) || (imm < 0 && ~imm >> bits) which admits
values in [-2^N, 2^N) — effectively a signed (N+1)-bit range. A
signed N-bit field only holds [-2^(N-1), 2^(N-1)), so the check
admits one extra bit of range on each side.

In particular, for check_imm19(), values in [2^18, 2^19) slip past
the check but do not fit into the 19-bit signed imm19 field of
B.cond. aarch64_insn_encode_immediate() then masks the raw value
into the 19-bit field, setting bit 18 (the sign bit) and flipping
a forward branch into a backward one. Same class of issue exists
for check_imm26() and the B/BL encoding. Shift by (bits - 1)
instead of bits so the actual signed N-bit range is enforced.

Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260415121403.639619-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53036

 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e98fe8c006cc..b67764f8a5f1 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -494,8 +494,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	int ret;
 
 #define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
+	if ((((imm) > 0) && ((imm) >> ((bits) - 1))) ||		\
+	    (((imm) < 0) && (~(imm) >> ((bits) - 1)))) {	\
 		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
 			i, imm, imm);				\
 		return -EINVAL;					\
-- 
2.53.0

