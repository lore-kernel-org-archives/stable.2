Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636756;
	b=d/To0gOJgOP53IvMZnhm/ko+jt6Gw32HTadrOP96VEDuZA6EiqWSMuUD+rl75C/pu4R/
	 V+nAtqkPnhmj2Xymirjl0FSDouPMqYV+5K6goqNbvTv1mVRuj13M50Y/ry+Xc9G1XrsKE
	 aWMkPAXfHz8ko6sO6Z78bKgQvg/e29AgBen8tDd3NdGjgrTqLLTLx0+cng8n89+Bg7hhG
	 3VMeCX22307khoQfIf85WcnNaKTZSSXr4xliDZtR/C/jiM9xKf9Q5uAfG5WWuUnqaYqcn
	 Cjc3z73eZj4TKJhYZfrqtmOgVGDeyIENkrcJK376+bjzBv2/u6u6c0T9E8EVk9y/2Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636756;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mke0cX5NsNqv44xmDDD3V1+ExoURp4jHrGKVazQ/pTQ=;
	b=bxfrvm/863F48H+8Qeqzp5NyWNBXcXKj3ui6Z44UcKcoT0iTO9Cuyptn2kBgd3dBfpOZ
	 0m332tttMv65lOE/T3SuzJLTT9FIY6fyvcvvCCHB6t52fkfOP1MTsH1M9BONUtbMgHt4s
	 btK4vEsbbyacWMM3XriG1IgQCOsqVvwcu5YoJk5/DxH18ruWTKl6KNbcnicXfs9ArX9R2
	 PKZXyZPgPDFFaWxfMFWJjFZkhRzyc6zsQDfIch0ClU+yMo2rY835gXJKb++qCykM22sjx
	 nh7oLNlqSty97o9YzaX+F4WhcHpCDgT+f5DlWdr1B7FsSwtsiuNYnptnAM29TDiQIqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gR/jlwk+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C03606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gR/jlwk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DFF1F000C0;
	Wed, 25 Nov 2026 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636755;
	bh=mke0cX5NsNqv44xmDDD3V1+ExoURp4jHrGKVazQ/pTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gR/jlwk+6mxRluQMgkVUKN7jp8tyDAX8ASQv0yLhO1XKWpRpkBPdcr+Pg5w6BlI3r
	 Y9TJMeNFEe2hqwsZqCsdbxb6QKTRJG/dR9gy8iGfQ0nzFfzx2OqJBvzmWc5PwAQ5Ux
	 ogKvaQFjzYDUqqJczoHypYEhU8rg+ULlvEIcefiptCn1/7tZg5I0iINOK/GS6lqVa6
	 fV0DYC4tk4XoVhHXLICuwQuFJa6o9xVCW1xezO8SCGQkjVEhqzQDDFR4yp0mBOYvpW
	 aJqCU0Y8V2FZZcTGdJENnrlmp+nZHfHmKswTrfvIzhvTx1LEPgJHRSXdX5u7hG/Kjp
	 wgTyfH8chq3Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Wed, 25 Nov 2026 14:59:14 -0500
Message-ID: <20261125195843.1331348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112522-gorged-prevent-b494@gregkh>
References: <2026112522-gorged-prevent-b494@gregkh>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 9b6e9d6a11090ac34516c45f48663b37ac94a9b1 ]

BTF bitfield parsing in trace_probe.c assumes a 64-bit (8-byte) container
when computing FETCH_OP_MOD_BF shift amounts and basesize, whereas the
preceding store instruction only allocates and writes the field's fetch
type size (which may be 1, 2, or 4 bytes when kflag=1). At runtime,
fetch_apply_bitfield() performs an 8-byte read-modify-write on the
smaller ring buffer slot, corrupting adjacent ring buffer data or writing
past the end of the event record.

In addition, signed bitfields with bit widths other than 8/16/32/64 fail
to resolve a fetch type, bitfields whose width is a multiple of 8 inside
a larger integer or spanning a byte boundary fail to emit FETCH_OP_MOD_BF
or select a container wide enough for bitoffs + bitsize, kflag=0 bitfield
offsets >= 8 bits are not folded into the byte offset, and big-endian
architectures use the little-endian left-shift formula in
parse_btf_bitfield().

Compute the bitfield byte and bit offsets consistently during field
lookup, select the smallest unsigned fetch type that covers the bit
offset and bit width, and calculate the FETCH_OP_MOD_BF parameters from
the selected fetch type size for both big- and little-endian bitfields.

Link: https://lore.kernel.org/all/179455850711.403392.10512730891220678403.stgit@devnote2/

Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Inlined the field-walk changes into parse_btf_field() because the get_bitoffset_of_field() helper doesn't exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 61 ++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index deb47ca572bd7..3fe0771730271 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -397,6 +397,18 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 {
 	u32 intdata;
 
+	if (ctx->last_bitsize) {
+		u32 bits = ctx->last_bitsize + ctx->last_bitoffs;
+
+		if (bits <= 8)
+			return "u8";
+		if (bits <= 16)
+			return "u16";
+		if (bits <= 32)
+			return "u32";
+		return "u64";
+	}
+
 	/* TODO: const char * could be converted as a string */
 	switch (BTF_INFO_KIND(type->info)) {
 	case BTF_KIND_ENUM:
@@ -434,10 +446,6 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 			case 64:
 				return "u64";
 			}
-			/* bitfield, size is encoded in the type */
-			ctx->last_bitsize = BTF_INT_BITS(intdata);
-			ctx->last_bitoffs += BTF_INT_OFFSET(intdata);
-			return "u64";
 		}
 	}
 	/* TODO: support other types */
@@ -575,6 +583,12 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			/* Add anonymous structure/union offset */
 			bitoffs += anon_offs;
 
+			type = btf_type_skip_modifiers(ctx->btf, field->type, &tid);
+			if (!type) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return -EINVAL;
+			}
+
 			/* Accumulate the bit-offsets of the dot-connected fields */
 			if (btf_type_kflag(mtype)) {
 				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
@@ -582,12 +596,15 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			} else {
 				bitoffs += field->offset;
 				ctx->last_bitsize = 0;
-			}
-
-			type = btf_type_skip_modifiers(ctx->btf, field->type, &tid);
-			if (!type) {
-				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-				return -EINVAL;
+				if (BTF_INFO_KIND(type->info) == BTF_KIND_INT) {
+					u32 intdata = btf_type_int(type);
+
+					bitoffs += BTF_INT_OFFSET(intdata);
+					if ((bitoffs % 8) ||
+					    BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size) ||
+					    !is_power_of_2(type->size))
+						ctx->last_bitsize = BTF_INT_BITS(intdata);
+				}
 			}
 
 			ctx->offset += next - fieldname;
@@ -719,13 +736,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
 
-	if ((ctx->last_bitsize % 8 == 0) && ctx->last_bitoffs == 0)
+	if ((ctx->last_bitsize == 0 ||
+	     ctx->last_bitsize == BYTES_TO_BITS(t->size)) &&
+	    ctx->last_bitoffs == 0)
 		return 0;
 
+	if (ctx->last_bitsize == 0 ||
+	    BYTES_TO_BITS(t->size) < (ctx->last_bitsize + ctx->last_bitoffs)) {
+		trace_probe_log_err(ctx->offset, BAD_BITFIELD);
+		return -EINVAL;
+	}
+
 	code++;
 	if (code->op != FETCH_OP_NOP) {
 		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
@@ -734,9 +760,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	*pcode = code;
 
 	code->op = FETCH_OP_MOD_BF;
-	code->lshift = 64 - (ctx->last_bitsize + ctx->last_bitoffs);
-	code->rshift = 64 - ctx->last_bitsize;
-	code->basesize = 64 / 8;
+#ifdef __BIG_ENDIAN_BITFIELD
+	code->lshift = ctx->last_bitoffs;
+#else
+	code->lshift = BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->last_bitoffs);
+#endif
+	code->rshift = BYTES_TO_BITS(t->size) - ctx->last_bitsize;
+	code->basesize = t->size;
 	return 0;
 }
 
@@ -760,6 +790,7 @@ static int parse_btf_arg(char *varname,
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -1419,7 +1450,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
 		/* If user not specified the type, try parsing BTF bitfield. */
-		ret = parse_btf_bitfield(&code, ctx);
+		ret = parse_btf_bitfield(&code, parg->type, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.53.0

