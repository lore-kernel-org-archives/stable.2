Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138EB33B6DC;
	Wed, 22 Jul 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700675; cv=none; b=k44xD1aA2mPjpQUsaUUnLvqyAZ/6TiNWqld4az2CRk+wKpY71Fg3JrLXrgU9lqPKcOMb7Qv2/KNJYkPXu13GKwviCVX2vUFVYHTtLDVHXH81iYnQsr7fHr77QUmYP32BmMNbpfRc57ueX2rdf/nM0k/weWkhBJ9hFZy4luzzAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700675; c=relaxed/simple;
	bh=aK88JeHoSp3zjTatGviKfa3rpJW4LZZv4zXhClJNACI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXzzEkfh2JU2TEou6oxLktHlssUBZ1LxuqP6BKVHoXvIj5KB08PpNRjWnjhZKqCUixMCZTcbRAIsXEveS4O04iHP/zASyY7g1o4gX99epMmgPLVXF/4h8fDDcvtkRPsHfxBqhUU5U91Vd88tFz+B58+u12+IldV1c2gbuuBMOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d72d312859411f1aa26b74ffac11d73-20260722
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:63bfb3db-28ae-4e6e-bd9a-aae3c5fd195c,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:63bfb3db-28ae-4e6e-bd9a-aae3c5fd195c,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:129ab0f01193ae5a0ff8df994114b601,BulkI
	D:260722141104QYMZ1CUH,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d72d312859411f1aa26b74ffac11d73-20260722
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 209540309; Wed, 22 Jul 2026 14:11:02 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] tracing/hist: Prevent overflow in histogram expression strings
Date: Wed, 22 Jul 2026 14:10:37 +0800
Message-ID: <20260722061040.112747-2-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722061040.112747-1-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

expr_str() builds a histogram expression in a fixed-size
MAX_FILTER_STR_VAL allocation with unbounded strcat() calls.
Synthetic events permit field names longer than that buffer. Constructing
a trigger expression can therefore write past the allocation.

Build the expression with seq_buf. Propagate construction errors to the
parser and reject strings that overflow the fixed-size buffer with -E2BIG.

Fixes: 100719dcef44 ("tracing: Add simple expression support to hist triggers")
Cc: stable@vger.kernel.org
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 89 +++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..2b2547546360 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1733,86 +1733,99 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
-static void expr_field_str(struct hist_field *field, char *expr)
+static void expr_field_str(struct hist_field *field, struct seq_buf *s)
 {
 	if (field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (!field->system)
-			strcat(expr, "$");
+			seq_buf_putc(s, '$');
 	} else if (field->flags & HIST_FIELD_FL_CONST) {
 		char str[HIST_CONST_DIGITS_MAX];
 
 		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
-		strcat(expr, str);
+		seq_buf_puts(s, str);
 	}
 
-	strcat(expr, hist_field_name(field, 0));
+	seq_buf_puts(s, hist_field_name(field, 0));
 
 	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
+			seq_buf_putc(s, '.');
+			seq_buf_puts(s, flags_str);
 		}
 	}
 }
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
+	struct seq_buf s;
 	char *expr;
+	int ret = 0;
 
 	if (level > 1)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!expr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
 
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
-		return expr;
+		expr_field_str(field, &s);
+		goto out;
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
+		seq_buf_puts(&s, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
-		if (!subexpr) {
-			kfree(expr);
-			return NULL;
+		if (IS_ERR(subexpr)) {
+			ret = PTR_ERR(subexpr);
+			goto free;
 		}
-		strcat(expr, subexpr);
-		strcat(expr, ")");
+		seq_buf_puts(&s, subexpr);
+		seq_buf_putc(&s, ')');
 
 		kfree(subexpr);
-
-		return expr;
+		goto out;
 	}
 
-	expr_field_str(field->operands[0], expr);
+	expr_field_str(field->operands[0], &s);
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
-		strcat(expr, "-");
+		seq_buf_putc(&s, '-');
 		break;
 	case FIELD_OP_PLUS:
-		strcat(expr, "+");
+		seq_buf_putc(&s, '+');
 		break;
 	case FIELD_OP_DIV:
-		strcat(expr, "/");
+		seq_buf_putc(&s, '/');
 		break;
 	case FIELD_OP_MULT:
-		strcat(expr, "*");
+		seq_buf_putc(&s, '*');
 		break;
 	default:
-		kfree(expr);
-		return NULL;
+		ret = -EINVAL;
+		goto free;
 	}
 
-	expr_field_str(field->operands[1], expr);
+	expr_field_str(field->operands[1], &s);
 
+out:
+	seq_buf_str(&s);
+	if (seq_buf_has_overflowed(&s)) {
+		ret = -E2BIG;
+		goto free;
+	}
 	return expr;
+
+free:
+	kfree(expr);
+	return ERR_PTR(ret);
 }
 
 /*
@@ -2556,6 +2569,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 				      char *var_name, unsigned int *n_subexprs)
 {
 	struct hist_field *operand1, *expr = NULL;
+	char *expr_name;
 	unsigned long operand_flags;
 	int ret = 0;
 	char *s;
@@ -2625,7 +2639,12 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->size = operand1->size;
 	expr->is_signed = operand1->is_signed;
 	expr->operator = FIELD_OP_UNARY_MINUS;
-	expr->name = expr_str(expr, 0);
+	expr_name = expr_str(expr, 0);
+	if (IS_ERR(expr_name)) {
+		ret = PTR_ERR(expr_name);
+		goto free;
+	}
+	expr->name = expr_name;
 	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
@@ -2691,7 +2710,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	struct hist_field *var1 = NULL, *var2 = NULL;
 	unsigned long operand_flags, operand2_flags;
 	int field_op, ret = -EINVAL;
-	char *sep, *operand1_str;
+	char *expr_name, *sep, *operand1_str;
 	enum hist_field_fn op_fn;
 	bool combine_consts;
 
@@ -2837,7 +2856,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		destroy_hist_field(operand2, 0);
 		destroy_hist_field(operand1, 0);
 
-		expr->name = expr_str(expr, 0);
+		expr_name = expr_str(expr, 0);
+		if (IS_ERR(expr_name)) {
+			ret = PTR_ERR(expr_name);
+			goto free_expr;
+		}
+		expr->name = expr_name;
 	} else {
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
@@ -2850,7 +2874,12 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 			goto free_expr;
 		}
 
-		expr->name = expr_str(expr, 0);
+		expr_name = expr_str(expr, 0);
+		if (IS_ERR(expr_name)) {
+			ret = PTR_ERR(expr_name);
+			goto free_expr;
+		}
+		expr->name = expr_name;
 	}
 
 	return expr;
-- 
2.43.0

