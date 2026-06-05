Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9E426ED8
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691649; cv=none; b=b+LodUrQLK1em2b4y8xXRd31kjtvTJzwTjKXqSnhpzqlGavcM2hTa1N9IgFpcEEvTw/6BxQ8FsQL4bJSgShq7fo/gNMULqNpuu6D7fYmwXdVCTrfYFwRojdj5jEFBjRZ0LKiWddsCfV5OsgYHRR0lJxxJeV4p1cccW6pCeyqRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691649; c=relaxed/simple;
	bh=gzuRP/n7pxQ4GuENHZDal5QlH7HLDjaJOQ1+SE5ZIxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTeEJQuwroFGrwhlYpZVv2dcnfPwZU0mnvv4xw+i4eHuiQCFxWyzxaD8CuaW83VLCP+ttzj9SVdBlSUq1cxwW+HbshHmS2wjJcWC4XRZAMZ2XNWbR5r4wCXl1Juesgn+OcN3NsaWhngEDvex5k1V7aqEO10Gyuz/hEZxAE66vLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIDPIrhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIDPIrhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27561F00893;
	Fri,  5 Jun 2026 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691647;
	bh=kD+ncupLfJOvm5SjXhqrw8P4hlBUMTXzdfPZUhnKOzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIDPIrhOl3qtX2SuWbMU9eS7jDl0YgAQOIK0Syb6JNE7AtQtv5IJr6r8a1TE70SH2
	 2L1qbNnrKZt/YYt9Ktm2P4lrDxxxMWDGzJlduLQFfBQepo09TAQYQ9BD2QfKXNNLlj
	 wNwH7Mee7zzi754xRCoDd8J1YAzFrCxKksAOvB/vUgH8wxAiNRzt7Hnt0vfNhY5SjI
	 ERVcqypW9SuVxU46ahaD3TyMLoeIIFg88pIULsHQwtAcV9AfVzcIIhNZH9VyuX/1Nq
	 Z7aTk93yrRHCPFznAXDF15ZnLzAoNT/vClUNA+YckgC0p56Pkp/eY6N6mEnnRdIZkG
	 KGnZ+Ronq9etQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
Date: Fri,  5 Jun 2026 16:34:05 -0400
Message-ID: <20260605203405.2224281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060410-slam-conch-e2f1@gregkh>
References: <2026060410-slam-conch-e2f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit bf33e01f88388c43e285492a63e539df6ffed64c ]

iscsi_encode_text_output() concatenates "key=value\0" records into
login->rsp_buf, an 8192-byte kzalloc(MAX_KEY_VALUE_PAIRS) buffer
allocated in iscsit_alloc_login_setup_buffer(). The three sprintf() call
sites in this function (lines 1398, 1411, 1424 in v7.1-rc2) never check
the remaining buffer capacity:

	*length += sprintf(output_buf, "%s=%s", er->key, er->value);
	*length += 1;
	output_buf = textbuf + *length;

The 8192-byte ceiling at iscsi_target_check_login_request() bounds the
*input* Login PDU payload, but a single PDU can carry up to 2048 minimal
four-byte "a=b\0" pairs, each unknown key expanding to a 16-byte
"a=NotUnderstood\0" output record via iscsi_add_notunderstood_response().
2048 * 16 = 32 KiB of output into an 8 KiB buffer, producing a ~24 KiB
heap overrun in the kmalloc-8k slab.

The fix introduces a static iscsi_encode_text_record() helper that uses
snprintf() with a per-call bounds check against the remaining buffer,
and threads a u32 textbuf_size parameter through
iscsi_encode_text_output(). Both call sites in
iscsi_target_handle_csg_zero() (PHASE_SECURITY) and
iscsi_target_handle_csg_one() (PHASE_OPERATIONAL) pass
MAX_KEY_VALUE_PAIRS. On overflow the encoder logs the condition, calls
iscsi_release_extra_responses() to drop queued records, and returns -1;
both caller sites now emit ISCSI_STATUS_CLS_INITIATOR_ERR /
ISCSI_LOGIN_STATUS_INIT_ERR via iscsit_tx_login_rsp() before returning,
so the initiator sees an explicit failed-login response rather than a
silent connection drop. (Prior to this patch only the PHASE_OPERATIONAL
caller did that; the PHASE_SECURITY caller is converted to the same
shape.)

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Tested-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target_nego.c      |  7 ++-
 .../target/iscsi/iscsi_target_parameters.c    | 62 ++++++++++++++-----
 .../target/iscsi/iscsi_target_parameters.h    |  2 +-
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 32a2852352db1c..2ff2cbdd2598f9 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -870,10 +870,14 @@ static int iscsi_target_handle_csg_zero(
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
-	if (ret < 0)
+	if (ret < 0) {
+		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_INITIATOR_ERR,
+				ISCSI_LOGIN_STATUS_INIT_ERR);
 		return -1;
+	}
 
 	if (!iscsi_check_negotiated_keys(conn->param_list)) {
 		if (conn->tpg->tpg_attrib.authentication &&
@@ -941,6 +945,7 @@ static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_log
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 62004e3fe1ccc3..74624c67d189d1 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -1419,19 +1419,42 @@ int iscsi_decode_text_input(
 	return -1;
 }
 
+/*
+ * Append "key=value" plus a trailing NUL into @textbuf at *@length.
+ * Returns 0 on success and advances *@length, or -EMSGSIZE if the
+ * record (including the NUL) would not fit in the remaining buffer.
+ */
+static int iscsi_encode_text_record(char *textbuf, u32 *length,
+				    u32 textbuf_size,
+				    const char *key, const char *value)
+{
+	int n;
+	u32 avail;
+
+	if (*length >= textbuf_size)
+		return -EMSGSIZE;
+
+	avail = textbuf_size - *length;
+	n = snprintf(textbuf + *length, avail, "%s=%s", key, value);
+	if (n < 0 || (u32)n + 1 > avail)
+		return -EMSGSIZE;
+
+	*length += n + 1;
+	return 0;
+}
+
 int iscsi_encode_text_output(
 	u8 phase,
 	u8 sender,
 	char *textbuf,
 	u32 *length,
+	u32 textbuf_size,
 	struct iscsi_param_list *param_list,
 	bool keys_workaround)
 {
-	char *output_buf = NULL;
 	struct iscsi_extra_response *er;
 	struct iscsi_param *param;
-
-	output_buf = textbuf + *length;
+	int ret;
 
 	if (iscsi_enforce_integrity_rules(phase, param_list) < 0)
 		return -1;
@@ -1443,10 +1466,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_RESPONSE_SENT(param) &&
 		    !IS_PSTATE_REPLY_OPTIONAL(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_RESPONSE_SENT(param);
 			pr_debug("Sending key: %s=%s\n",
 				param->name, param->value);
@@ -1456,10 +1481,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_ACCEPTOR(param) &&
 		    !IS_PSTATE_PROPOSER(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_PROPOSER(param);
 			iscsi_check_proposer_for_optional_reply(param,
 							        keys_workaround);
@@ -1469,14 +1496,21 @@ int iscsi_encode_text_output(
 	}
 
 	list_for_each_entry(er, &param_list->extra_response_list, er_list) {
-		*length += sprintf(output_buf, "%s=%s", er->key, er->value);
-		*length += 1;
-		output_buf = textbuf + *length;
+		ret = iscsi_encode_text_record(textbuf, length, textbuf_size,
+					       er->key, er->value);
+		if (ret < 0)
+			goto err_overflow;
 		pr_debug("Sending key: %s=%s\n", er->key, er->value);
 	}
 	iscsi_release_extra_responses(param_list);
 
 	return 0;
+
+err_overflow:
+	pr_err("iSCSI login response buffer (%u bytes) exhausted, dropping login.\n",
+	       textbuf_size);
+	iscsi_release_extra_responses(param_list);
+	return -1;
 }
 
 int iscsi_check_negotiated_keys(struct iscsi_param_list *param_list)
diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index 240c4c4344f691..6d02d19eb8cf0f 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -46,7 +46,7 @@ extern struct iscsi_param *iscsi_find_param_from_key(char *, struct iscsi_param_
 extern int iscsi_extract_key_value(char *, char **, char **);
 extern int iscsi_update_param_value(struct iscsi_param *, char *);
 extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsi_conn *);
-extern int iscsi_encode_text_output(u8, u8, char *, u32 *,
+extern int iscsi_encode_text_output(u8, u8, char *, u32 *, u32,
 			struct iscsi_param_list *, bool);
 extern int iscsi_check_negotiated_keys(struct iscsi_param_list *);
 extern void iscsi_set_connection_parameters(struct iscsi_conn_ops *,
-- 
2.53.0

