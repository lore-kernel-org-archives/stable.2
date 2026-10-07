Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBD3B4E80
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348144; cv=none; b=jnYmjM0hTKHH/oQKAlfzMmCHYid+9pejwXtaQ4tgg5ZXwr1P0T+GLhma3iYWpmkjqAYmSfNzS4+rB15I5hAiAD1DgjUSKajcY9BVZwNLMbHO6cY/CiLMQkGiWuQuohWKW1qPqE0JiZv88roIS8Xzq/VesRAoLehbE/Xt6Gt6zRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348144; c=relaxed/simple;
	bh=YGhxAADcEotoTVfYKaoxcxYHU3GyFBpSUeFejD+MY1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jA4L8W3AixkB3fphf+WbufmdN3mGLAOaoR+NWp/CXJhnSO2+Pq8Nf7sS0MwEECyGYvX46cEAvNusxPFc02tqJB/I/D/FrraMeYHLBRzFZXqL/zLp+YJNoaPDuqOPSH9Ks3x6vFg+VXzQZZq7oRF9a1m8jHn5J4i+FtV5l26LYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=sY6boH9I; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="sY6boH9I"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc73a80ede5so1567185a12.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791348140; x=1791952940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSDczV66AQ+p5p0pwY8AkyYRnXsj/iwZmPrpvck8VaU=;
        b=sY6boH9I3IHRDhUbbgZ9kJWhHlqC9oU/Z95lJmAt8LxA6jP57TSkvQqIb0d6xROxRy
         K+wFx6N8Erx5/QqAbKVI3qQc2i4w+9ATDoPcQOpTD0WHJHkJPHnutE3okr4AdkpvM4/P
         9ZW31PcZl5fQ3oY46WzpK6B2+vDv6Gfejb1wlI8c2eF45/qQgKGCyGbI16EZ+aX7HhAV
         VnLQo8nKjrhVunzLB6oCJVZ+l3XamkfMYP4S05y66U27ck9I4tass7kAbbAIqv6b+7WN
         M7sdhQt1VZi4bLvBcYdh/mpqHo4UFzSp3A88hZWliQXOkj4Vbyjphavqn9UOcJXNEON3
         JgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348140; x=1791952940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSDczV66AQ+p5p0pwY8AkyYRnXsj/iwZmPrpvck8VaU=;
        b=kFJDIMTBSyX9/K7ZRG0Vt5JbnHhG+m1WzRABdA+5E3g1OtJSObE7d1QN8nYIGPer8g
         3A1LYYkWI9tWzF6UypDGJDjOak9+qLltUDV+vEPmCQqAH6OEO2F58Zx6m9vpiR811oi8
         7/nLfAMm+7Tkm4zL6BAWh1fh61ANsmST5EWdqEDWuNX2v5fcuiEb1Ys2nQjqUnPoYeCB
         wmxGSqoCT5Obq67Vul9+YdPV6LUCF5ocm024emK9KySq/6QKbexUp5Vgldl/CAcSIfPz
         NNcXuEWARaW8SmQSNlYWvmHGMgPGaJB60UPdMotmZv7ZbjhRwYbEDBlKAWaCiklxwKa4
         pVqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvJoQSXQhYZt5B6R8+OacPzkoCP3+WnqF8UvOZgI8vc3Ml3flwTyypoVXyvJLh6G0Jd58RpDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC/njU7spPZwwUr56t+7CpeoSaYep40ZzgSLmaeDby0Kvzc7qG
	7agNUXMNtYtD0XcFzwDSIy5WbUgf3ULax5s4dvddZFpKXoZVJgrykxfWQ6unBmK+G8E=
X-Gm-Gg: AYBFou2muYDPZ4hldtqqDsHPvxPWJo/ZO4yw3RIssw0uIzqs0JzDKZ8tg8EyGHrFCRG
	MD7hs/3xH9HWZOWgrI9ewcJ1JGtQYkQeeIg7eqt/vSy7is/ObZpj6lGlt7RfLiqVCD82aUHu65R
	SJJqYbjtwnQ3tlXXzmBmkOeHoR3gT/2X3n7iCuB9yu5lkNxL7EyJ6DXnVFZB2sH4N/vW27TF63T
	WJAsaQ5LbE6MeNUAaexYy5ehsZNkTrAuyGLR8Tm/5jVV3IwAaOQpyFZua6NFyxMNuna0fO5go4f
	Qi2/+Fvr3IuSYcYbraWJiZSc48pF+B52Kc4zPsHNRq26NpILbkIAmGkRIXP2VJRNyPbs7Thxt44
	eoZQeOJcHnTzPtF/JPPQ3EKFIKQsWiEs+tjqrwwqvgmwYEO9GNTm3onFT4LxS3RXhAp274pyQN9
	B0P6YEnTEA0rilE7V4xTVIaENUwDzXVnASUsG+iJ+r7rQ32UR+LcXjEE1CQ0SjRGJKxprQmSP+u
	uLBZxBsXAh9kiHH
X-Received: by 2002:a17:90b:2f83:b0:3a0:97ba:cc05 with SMTP id 98e67ed59e1d1-3a8a1b5d36cmr889506a91.22.1791348139576;
        Tue, 06 Oct 2026 21:42:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm9213898a91.2.2026.10.06.21.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:42:19 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: michael.christie@oracle.com,
	martin.petersen@oracle.com,
	lduncan@suse.com,
	cleech@redhat.com,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3] scsi: libiscsi_tcp: check that a read got the data the target claimed
Date: Wed,  7 Oct 2026 13:42:04 +0900
Message-ID: <20261007044204.650687-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A target can finish a read without sending the data.  iscsi_tcp_data_in()
bounds each Data-In PDU against the command buffer but never adds them up,
so a completion that declares no underflow is believed and the command
ends with DID_OK.  The pages keep whatever they held.

Over a 1 MiB pread of a file that had never been read, 999424 bytes came
back as the contents of an unrelated file the same process had written
earlier.  pread() returned 1048576 and errno was 0.

Count the payload per task.  Require each Data-In to continue where the
last one ended, and at completion compare the total with the buffer
length, less the residual when an underflow is declared.  A read can end
on a Data-In or on a SCSI Response, so check both.  Writes are untouched.

Fixes: a081c13e39b5 ("[SCSI] iscsi_tcp: split module into lib and lld")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v3: only validate coverage for SAM_STAT_GOOD completions; a non-GOOD reply
    such as CHECK_CONDITION that omits the underflow flag must not be
    treated as a short read (noted by Sashiko AI review).
v2: take back_lock once on the SCSI Response path and make the counter
    uint32_t, both per Mike Christie's review.

On "was it built over another patch?" - no, v1 was generated against
v7.2-rc5 directly.  It stopped applying because c1dea15f819cd ("scsi:
libiscsi_tcp: Bound SCSI Response data segment to the connection
buffer") folded ISCSI_OP_SCSI_CMD_RSP into the shared response case,
which is the block v1's last hunk patched.  This version leaves that
fold alone and applies the check inside the shared case, so the data
segment bound stays in one place.

v1: https://lore.kernel.org/all/20260814121428.359541-1-yhlee@isslab.korea.ac.kr/
 drivers/scsi/libiscsi_tcp.c | 79 ++++++++++++++++++++++++++++++++++++-
 include/scsi/libiscsi_tcp.h |  1 +
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index d35f93451ee9b..d4ab9c65fa297 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -467,6 +467,45 @@ void iscsi_tcp_cleanup_task(struct iscsi_task *task)
 }
 EXPORT_SYMBOL_GPL(iscsi_tcp_cleanup_task);
 
+/**
+ * iscsi_tcp_check_data_in - verify a read received the data the target claimed
+ * @task: scsi command task
+ * @status: SCSI status of the PDU carrying the status
+ * @flags: flags of the PDU carrying the status
+ * @residual: residual count of that PDU
+ *
+ * ISCSI_FLAG_CMD_UNDERFLOW and ISCSI_FLAG_DATA_UNDERFLOW share a value, so the
+ * Data-In and SCSI Response paths both use this.
+ */
+static int iscsi_tcp_check_data_in(struct iscsi_task *task, u8 status,
+				   u32 flags, u32 residual)
+{
+	struct iscsi_tcp_task *tcp_task = task->dd_data;
+	struct scsi_cmnd *sc = task->sc;
+	unsigned int expected;
+
+	if (!sc || sc->sc_data_direction == DMA_TO_DEVICE)
+		return 0;
+
+	/*
+	 * Only a successful completion promises the whole buffer.  Any other
+	 * status is handled by the normal status and sense path.
+	 */
+	if (status != SAM_STAT_GOOD)
+		return 0;
+
+	expected = sc->sdb.length;
+	if (flags & ISCSI_FLAG_DATA_UNDERFLOW) {
+		if (residual > expected)
+			return 0;
+		expected -= residual;
+	}
+	if (tcp_task->data_in_bytes == expected)
+		return 0;
+
+	return ISCSI_ERR_DATALEN;
+}
+
 /**
  * iscsi_tcp_data_in - SCSI Data-In Response processing
  * @conn: iscsi connection
@@ -491,7 +530,7 @@ static int iscsi_tcp_data_in(struct iscsi_conn *conn, struct iscsi_task *task)
 		iscsi_update_cmdsn(conn->session, (struct iscsi_nopin*)rhdr);
 
 	if (tcp_conn->in.datalen == 0)
-		return 0;
+		goto status;
 
 	if (tcp_task->exp_datasn != datasn) {
 		ISCSI_DBG_TCP(conn, "task->exp_datasn(%d) != rhdr->datasn(%d)"
@@ -509,7 +548,18 @@ static int iscsi_tcp_data_in(struct iscsi_conn *conn, struct iscsi_task *task)
 		return ISCSI_ERR_DATA_OFFSET;
 	}
 
+	if (tcp_task->data_offset != tcp_task->data_in_bytes)
+		return ISCSI_ERR_DATA_OFFSET;
+
+	tcp_task->data_in_bytes += tcp_conn->in.datalen;
+
 	conn->datain_pdus_cnt++;
+
+status:
+	if (rhdr->flags & ISCSI_FLAG_DATA_STATUS)
+		return iscsi_tcp_check_data_in(task, rhdr->cmd_status,
+					       rhdr->flags,
+					       be32_to_cpu(rhdr->residual_count));
 	return 0;
 }
 
@@ -783,6 +833,32 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 			break;
 		}
 
+		if (opcode == ISCSI_OP_SCSI_CMD_RSP) {
+			struct iscsi_scsi_rsp *rsp = (struct iscsi_scsi_rsp *)hdr;
+
+			spin_lock(&conn->session->back_lock);
+			task = iscsi_itt_to_ctask(conn, hdr->itt);
+			if (!task) {
+				spin_unlock(&conn->session->back_lock);
+				return ISCSI_ERR_BAD_ITT;
+			}
+			rc = iscsi_tcp_check_data_in(task, rsp->cmd_status,
+						     rsp->flags,
+						     be32_to_cpu(rsp->residual_count));
+			if (rc) {
+				spin_unlock(&conn->session->back_lock);
+				return rc;
+			}
+			if (tcp_conn->in.datalen) {
+				spin_unlock(&conn->session->back_lock);
+				iscsi_tcp_data_recv_prep(tcp_conn);
+				return 0;
+			}
+			rc = __iscsi_complete_pdu(conn, hdr, NULL, 0);
+			spin_unlock(&conn->session->back_lock);
+			break;
+		}
+
 		/* If there's data coming in with the response,
 		 * receive it to the connection's buffer.
 		 */
@@ -995,6 +1071,7 @@ int iscsi_tcp_task_init(struct iscsi_task *task)
 
 	BUG_ON(kfifo_len(&tcp_task->r2tqueue));
 	tcp_task->exp_datasn = 0;
+	tcp_task->data_in_bytes = 0;
 
 	/* Prepare PDU, optionally w/ immediate data */
 	ISCSI_DBG_TCP(conn, "task deq [itt 0x%x imm %d unsol %d]\n",
diff --git a/include/scsi/libiscsi_tcp.h b/include/scsi/libiscsi_tcp.h
index ef53d4bea28a0..a6e63db75d674 100644
--- a/include/scsi/libiscsi_tcp.h
+++ b/include/scsi/libiscsi_tcp.h
@@ -66,6 +66,7 @@ struct iscsi_tcp_conn {
 
 struct iscsi_tcp_task {
 	uint32_t		exp_datasn;	/* expected target's R2TSN/DataSN */
+	uint32_t		data_in_bytes;	/* Data-In payload received */
 	int			data_offset;
 	struct iscsi_r2t_info	*r2t;		/* in progress solict R2T */
 	struct iscsi_pool	r2tpool;

base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.43.0

