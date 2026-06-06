Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B751917CD
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712317; cv=none; b=qkSdIBtrir84ikzi2R1c2w+RuKqRewHVmq9es0QdxuJdE1TefrunYYa1srMTuuFF1EA0Z5rzwx/CaJHrv9t8lnLWEUfeVE4f/1PHA4o6feeRxrmEti26bf+f8Ovton5RJm7z02b2aHouQ0y/OyDsxcuE8xEotxFPkiQ6248T5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712317; c=relaxed/simple;
	bh=XJI23fWgqKa+N4ESWg4H47vSt/oEqfoGmch2zju0qxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImSXb3+U7Od+zMW+OwgccD8lf2kfyGVkHrvFIbtB6dcKWLwe4XH8WynTfkqBVEY2RiU5rkT6SjmtStMyQASAj/IEWi92K5VB+wT5MOgTNypcuNKRcVTHWQxlEwoShgvYA66NU5xdD2Vm/B1mQPc1j6570+Nr7Qukl0Wxh1jbCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c45dj6gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c45dj6gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC991F00893;
	Sat,  6 Jun 2026 02:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712316;
	bh=SBYIabaq5KgGx64P/MNtfCdxdQN5u1yk1cqKKUTfugo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c45dj6gKefCFOzgZF2zYsURBCHCL9frRrkSU2uJwsMxUsQSqrlht+JqJHrsrQm8BY
	 PWw1CkhlbFQOj77wtWeMc7LQwk4SlptsRv4D6UBC08aZWSm39RPDX4zqSLbNfSLwlc
	 A7JFuDVX+hlNcnAfZZobQfgtLookz09vgFXfM0aBFDXVlZssiyBFnJ6VJMKm0u/rLU
	 HfBwJAkE0XyI/IhPURWRci5WMUG92vdRF0Z0Ubg0E+bMZV0wA7JT+2ciFls6lWO8Vm
	 EZ2FQwwItCIjPRmFMMnW2dfnrKxWleOFo0jQp2R6Li6HHoubCAfKbQmw9gU/SauGXP
	 vr/3x9yEt2SNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: target: iscsi: Bound iscsi_encode_text_output() appends to rsp_buf
Date: Fri,  5 Jun 2026 22:18:34 -0400
Message-ID: <20260606021834.2487480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060411-wiring-second-8e35@gregkh>
References: <2026060411-wiring-second-8e35@gregkh>
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
index 3931565018880c..ad60d28d703422 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -878,10 +878,14 @@ static int iscsi_target_handle_csg_zero(
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
@@ -949,6 +953,7 @@ static int iscsi_target_handle_csg_one(struct iscsi_conn *conn, struct iscsi_log
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 31cd3c02e51760..9c5964a77a45c0 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -1421,19 +1421,42 @@ int iscsi_decode_text_input(
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
@@ -1445,10 +1468,12 @@ int iscsi_encode_text_output(
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
@@ -1458,10 +1483,12 @@ int iscsi_encode_text_output(
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
@@ -1471,14 +1498,21 @@ int iscsi_encode_text_output(
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

