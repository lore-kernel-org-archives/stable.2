Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970961;
	b=r1yBJwT6gS/mvPt9pHbNiorjmQ+RmsH1DOsMrB4OaiL676G2AfiErBCZEuDd5A8xoCsk
	 0u9b0TKubUy7WMXrt2jJ4aifU+5ygbOwsGlMFpEmKJTltHUzsvlI+XgkjUEKgqILcTgaB
	 xlEYO0U/FimJRG2aXbYW5Lb3CumPi6u7Z3DXP9n+3O8yQOTLpa1Qv03Q2EUAu87cPhwxp
	 R1ymKJLF3DpZSON84RpDUyIehFTmaLVbsCeKD8hyV9Vjd7rEEGSbGMiwFSSAA8mz8RBsG
	 IcE/tydhOp2foe5TTqmBIk3LC6tTICqXXIBRzOWhL3UYgm7E4ui8K4Dm90sZ4/lPQiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970961;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QBDyWzDsJEXBE+HUMN83GaHrQvFEUg2tZXZUzLfc4I8=;
	b=AjQNKf+RGtOFAvNBEZk4vavRnDXufFJFwVpCKvkNrUy6mOW9lKJkq2c6VTBwB8e6Ms7E
	 P+3hu2Q2Wsb/o+BB5sewwrw5CKi/kbWJBE2ARgX5WJx9XRdqDMz98kAkm3p5/WBFyZPor
	 z/+bRZO73gwLngqVk0e41DiYo+VXwNbvGAiluzfl3r4P56rNP93nIguanPoWb1K3J/tjG
	 lOXE/Y5QX2sMcrFdtF2kKqbY+xU3KnmSDwDJUQzN9qkvaBciPAYDTmU1UaK32+MZK/g9i
	 +XqbRRLvbAzP0MzjWxikHkwBRGfU5LeDNwxTyKK5Ps4rY7MfFsP5dpM37rpxznLNvTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mbCXTH6K;
	arc=none smtp.remote-ip=91.218.175.204
Received: from mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB3606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30DB3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mbCXTH6K
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RfydaBjTvqp0ShnNlaeJnvlPZ3CZOLNGFmInsl50U98=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794970959; v=1; x=1795575759;
 b=mbCXTH6KEBNLQKqghEfJNW//WuPDRk1gq3mzbVQiepxryrwR19BTZbpaD+yrrTaGWbVxez/L
 PBU62/HDuLzCtPgN/9spIe1eEC5v7Zcch5tiZ9OQpmJjGxvZmUODNshuumHfZDQaTfe302Z4NDj
 4JvP4u9e7V2t1UqQsZ98L7ig=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18f3657c6622a384;
	Wed, 18 Nov 2026 03:02:39 +0000
X-Mizu-Trace-ID: 18f3657c6622a384
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
Date: Wed, 18 Nov 2026 12:02:18 +0900
Message-ID: <20261118030219.6230-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: George Guo <guodongtai@kylinos.cn>

When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
"ldst_offsets" subtest fails for word and doubleword stores:

  store_offsets:FAIL:stx size=24 base=r9 src=r0: byte at offset -16384
  unexpected ... actual 255 != expected 67
  ...
  #197/11  jit_insns_blinded/ldst_offsets:FAIL

This is because the JIT emits stptr.w or stptr.d for store offsets
that do not fit a signed 12-bit immediate but fit a signed 14-bit
immediate, and passes the byte offset directly to the instruction
encoder. However, these instructions scale their signed 14-bit
immediate by 4 when calculating the memory address. For example, a
store at offset -4096 writes at offset -16384 instead, outside the
memory range checked by the verifier.

Pass the offset in units of 4 bytes when emitting stptr.w and stptr.d
for both immediate and register stores. Use these instructions only
for offsets that are multiples of 4 in the range [-32768, 32764], and
keep the register-offset fallback for other offsets that do not fit
the signed 12-bit immediate of st.w or st.d.

With this patch, both "ldst_offsets" subtests pass:

  $ sudo ./test_progs -t jit_insns -t jit_insns_blinded
  ...
  #196/26  jit_insns/ldst_offsets:OK
  ...
  #197/11  jit_insns_blinded/ldst_offsets:OK

Cc: stable@vger.kernel.org
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 16 ++++++++--------
 arch/loongarch/net/bpf_jit.h |  9 +++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 15af1abb5cb6..16e59722620f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1400,8 +1400,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, t1, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrw, t1, dst, off);
+			} else if (is_ptr_off(off)) {
+				emit_insn(ctx, stptrw, t1, dst, off >> 2);
 			} else {
 				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxw, t1, dst, t2);
@@ -1411,8 +1411,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, t1, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrd, t1, dst, off);
+			} else if (is_ptr_off(off)) {
+				emit_insn(ctx, stptrd, t1, dst, off >> 2);
 			} else {
 				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxd, t1, dst, t2);
@@ -1460,8 +1460,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		case BPF_W:
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, src, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrw, src, dst, off);
+			} else if (is_ptr_off(off)) {
+				emit_insn(ctx, stptrw, src, dst, off >> 2);
 			} else {
 				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
@@ -1470,8 +1470,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		case BPF_DW:
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, src, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrd, src, dst, off);
+			} else if (is_ptr_off(off)) {
+				emit_insn(ctx, stptrd, src, dst, off >> 2);
 			} else {
 				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index 2bd0dc5b911c..5207ad30fade 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -52,6 +52,15 @@ do {										\
 #define is_signed_imm52(val)	signed_imm_check(val, 52)
 #define is_unsigned_imm12(val)	unsigned_imm_check(val, 12)
 
+/*
+ * ldptr.{w,d} and stptr.{w,d} take a 14-bit signed immediate in units of
+ * 4 bytes: they reach a multiple of 4 in [-32768, 32764], passed as off >> 2.
+ */
+static inline bool is_ptr_off(int off)
+{
+	return !(off & 3) && is_signed_imm16(off);
+}
+
 static inline int bpf2la_offset(int bpf_insn, int off, const struct jit_ctx *ctx)
 {
 	/* BPF JMP offset is relative to the next instruction */

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

