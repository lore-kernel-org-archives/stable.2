Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603187;
	b=SxJf9O57PQdFP5W5rfKr9qhJMEzNQ70cF5NY16Kbj52lRhXKl2ql6HTytxFbdJFi1Q6X
	 J3HSYxS+rbQFwMyhWpPr0Ij7n4VIeb3ZjeobN45u33Fjmdnrw+bk37HjQP2t4pnsFbgni
	 6Sk2IzOBcKNYL5GGFMcRvJfV6aY73JBb+/+BNDv/O+wtMUtVl97sTiVlyazBRD12nLZD+
	 XM/in4dw+P4Ep8c+leKLzLaq6kIa4/fovLycBERi4x28Jr8heuuEyyXQGo4Ef5jXjl51t
	 RB6wPAFHKOZO8d4N4rDFqgXXo1dvLk8uCilp8qa785A3C75bAK5DZTZAsaElfohRk/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603187;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dLXYa01lLbNXC8w1PRGvwCmwT4jyAm2F1rR6RNmxyM0=;
	b=For8HJoy1fk89LIUDFeseByNacqiwn7YCeb3sbB22vEeUrXe3N+r+ayhSXZdgueSuwQg
	 fxqGZ7vCxeEjcuW/4BOEceY8hsnorEzXc6QnHTQerPdYlSp63j+0QQa6dl+qS9Tln4Py/
	 LqpVZn3FSjNXvBi8BI8+R4wonBD+r75ugAaOjc8bwgi++fULjoTbb5lIX8d/ICIYWN8iS
	 HtBHVREbTEQTmMqaVJsbOWNfmFrFFtyXkC4dtsIUcbTbnttdjdRYRDrD/Djhso7OnB4r7
	 AB/aNRZK6MDyHN5qG5/wQjZMR2iMmjLwhIP4+QCBRsoz6mnOC36pWcTTX/CEOsBO+rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gF1FWjkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gF1FWjkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D533A1F000CA;
	Wed, 25 Nov 2026 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603186;
	bh=dLXYa01lLbNXC8w1PRGvwCmwT4jyAm2F1rR6RNmxyM0=;
	h=Subject:To:Cc:From:Date;
	b=gF1FWjkjnXCrhA6HKhtjYzkBPgAgiNEY+RhNJhD1LtEvpNhVT7chEsTKMnghOQo2k
	 OXTaN00jBggcRIJ24Q7Nn2doqpHaLRTIbD7wXC8N5IUc4kUTZrKL9E2tsJ5zgxuPC9
	 WmmHoeDmoS9HpdBdhURB+t5oJ5ntc4lJcY/DHgG8=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix BTF bitfield parsing and out-of-bounds" failed to apply to 6.6-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:23 +0100
Message-ID: <2026112523-subtly-saucy-1ef7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b6e9d6a11090ac34516c45f48663b37ac94a9b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112523-subtly-saucy-1ef7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b6e9d6a11090ac34516c45f48663b37ac94a9b1 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Nov 2026 17:28:27 +0900
Subject: [PATCH] tracing/probes: Fix BTF bitfield parsing and out-of-bounds
 buffer write

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

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ba580d0d0f6a..01e499fdbfdf 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -486,6 +486,18 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
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
@@ -520,10 +532,6 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
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
@@ -653,6 +661,12 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		/* Add anonymous structure/union offset */
 		bitoffs += anon_offs;
 
+		type = btf_type_skip_modifiers(btf, field->type, NULL);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
+
 		/* Accumulate the bit-offsets of the dot-connected fields */
 		if (btf_type_kflag(container_type)) {
 			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
@@ -660,12 +674,15 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		} else {
 			bitoffs += field->offset;
 			ctx->last_bitsize = 0;
-		}
+			if (BTF_INFO_KIND(type->info) == BTF_KIND_INT) {
+				u32 intdata = btf_type_int(type);
 
-		type = btf_type_skip_modifiers(btf, field->type, NULL);
-		if (!type) {
-			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-			return -EINVAL;
+				bitoffs += BTF_INT_OFFSET(intdata);
+				if ((bitoffs % 8) ||
+				    BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size) ||
+				    !is_power_of_2(type->size))
+					ctx->last_bitsize = BTF_INT_BITS(intdata);
+			}
 		}
 
 		if (next)
@@ -858,13 +875,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
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
@@ -873,9 +899,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
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
 
@@ -1085,6 +1115,7 @@ static int parse_btf_arg(char *varname,
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -1995,7 +2026,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
 		/* If user not specified the type, try parsing BTF bitfield. */
-		ret = parse_btf_bitfield(&code, ctx);
+		ret = parse_btf_bitfield(&code, parg->type, ctx);
 		if (ret)
 			return ret;
 	}

