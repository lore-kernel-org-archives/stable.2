Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637134;
	b=JvVzBQb7y5qEbM2Uz39iQgZxlTOo1bcTnORcTcHRV2Il+kuOdFP8WLWj3a7kxwcdcdky
	 SeiOR/elwi+k5HAXyemdhu6eqWY5i3jYwTIF3a/oWby2MORo9wHL9GnXPEBxReSrklE/f
	 fLW1yMnaVI7ctgMmp/mQ4qG8p0qjNcx6sXPQO5SoDorN9YA3S89HX+CQrGFe5ck2nbSL/
	 pY8Zr2qoiKwQnDEA4152Y8lcrL3sYZdCh7VfEd7sZvOX30eokfvmIUlxeFsp3SwQfK4n1
	 tskxpFQWZJfRlOT1eW4HKGneeppvHmLomTDqI24fKJ0Z9ULn1/HTbly7W/qQijPzvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UT9YQEcKIpkRoEzVRw+8XrIEedJ9Tye3Afuslkg44n8=;
	b=ofkJTVbncVWMFfWLCqPKZRjhTqQufRa3lxZTPB3X38ZHn3uQPh/hhUC12MwGyipwT+nC
	 Q+fyAQAiWHedN2XzG9zTux1lO4FCDirbr6iShOWbx7EQpeJSTDCMm+EDZBnA0F99TQkhj
	 ndtnX/UPSEKU5v8MSkxB19IdfZ/N39gXQ2Yhb97T7AiLO2clCYHKwkvoWfFQ/pJa/Vwdt
	 qCLt4Ck2V31WieI2JanTpRvNOjAB4jPd349uKQEAwUc/lu2eoGm/SvbdhCGxANxcsWaDt
	 zk7p5G8fUXHv35La2y035m6Nz3Z3QbQc9duBGj1Ce+EG6iHtYcfTClblm5keAwo3tpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXwBq6X7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CC606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXwBq6X7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F4D1F000C4;
	Wed, 25 Nov 2026 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795637134;
	bh=UT9YQEcKIpkRoEzVRw+8XrIEedJ9Tye3Afuslkg44n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXwBq6X7iZPoDgj9dcMJ6LTLHKjKHW8q197V6YA7hBFfImDqYA8p45n4LIovEZTZV
	 IULyj9pgwJTguWa4j9tVIdB+gJqJ31NKeBuLiqVM9fF5YXsR/6+gZSrV9pgDYqXeZj
	 j1S1YESLwP2ZhPsn9KsBJ8yvsL4Z8zDuiew80V9A0rB1/IX/PWBbjRYVNjiXIx396g
	 5QKcNGP3h7pdTVesB82d3oMptLZWvn2kliG4WbuFdtM6gzXv796y4yBe22t68m4i2L
	 qg5a4H/25Ecj/5grcmQ1NPe4yFXGEtyM3ckGo3xDmLi5e93cpM2fXT3CDCPuLldNER
	 MwPVRndNneEpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Wed, 25 Nov 2026 15:05:32 -0500
Message-ID: <20261125200449.1362278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112523-subtly-saucy-1ef7@gregkh>
References: <2026112523-subtly-saucy-1ef7@gregkh>
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
[ sashal: Adapted the upstream hunks to the inlined BTF field walk in parse_btf_field(), since the get_bitoffset_of_field() helper doesn't exist here, and passed parg->type at the call site in traceprobe_parse_probe_arg_body(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 61 ++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4265518ce967c..6503bb867305f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -396,6 +396,18 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
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
@@ -433,10 +445,6 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
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
@@ -574,6 +582,12 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
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
@@ -581,12 +595,15 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
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
@@ -718,13 +735,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
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
@@ -733,9 +759,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
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
 
@@ -759,6 +789,7 @@ static int parse_btf_arg(char *varname,
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -1454,7 +1485,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		}
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
-		ret = parse_btf_bitfield(&code, ctx);
+		ret = parse_btf_bitfield(&code, parg->type, ctx);
 		if (ret)
 			goto fail;
 	}
-- 
2.53.0

