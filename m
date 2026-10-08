Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707939F191
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441189; cv=none; b=KjrhpRLWeoC0C27bxoF0n9+hUr9gmCQxKMuZLmucZKtj4+RJK+4AUbK5vTsglU3/y0G1XODI2zDVLM3lQumZUhHZkK9uh44YbmTuoztRou8ygaeDh6s4lIeEQWmuAqjh6wL3Hgmz+1YLs7g4/DMz5/q+inRg+LFZUmnE3f4plvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441189; c=relaxed/simple;
	bh=/D0ycu1v69QOuQUwHpCj3K6ftjja01rpKGuT8nBU5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M25F8/+NX0P6fljQU9+jAZnuAo0lsNB0cmcOJFekMHVlYjcTs2h7jGJS8S5GCljqogUMWKDOjqXqo6RK8/z9b2c8d41CJkeQWf4kRI0OawOlvs4DU6V5ZZY1AT3pUwUoQsOqOCOxZV5DEwr8l5f27z2YD0X+me+3C7xEdlL4WYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=GqK1lu4G; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="GqK1lu4G"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-88834d30002so1318389b3a.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 23:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791441186; x=1792045986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVf18aFR4/BQtrzc4eY5YQE7fHHstX8jyD3l79GNENM=;
        b=GqK1lu4GB/Pv5Bl0PhVaFPwlhuNcaDQbxA44+4YZoAMhLExyYTESb1vrC8lZe+/Paz
         c058This/mwA/b3jPBwwmO3ZqlplP2UluayIscTbUTumoc6JTWeGOT4Ledj/ActdZwB5
         Zz+fv9mgCqWtbnJnKE1iUOmPPCUzFjSTXGO5cTwWTkOQbWRXzH26SFXojvESN2lzjT2Z
         C1CQ+Y+L63gl2shQOhT0NWPbhwsEufiLuO9g/xuCXD8goBjeWex3sYHzm/WjuEk4U/nk
         NZUjjMmSizE0zJjQvz1JnWDK28cvmg4rgP2Gh0J2c4Xhit9q72wgYY1E13vFHfhKIPTx
         3R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791441186; x=1792045986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVf18aFR4/BQtrzc4eY5YQE7fHHstX8jyD3l79GNENM=;
        b=rxjrNf2rUzK5BC9F+7JLbGcF9zbOyE8KBrtC/c4k8YeoBSuLGkHilw9p4h0P2kJKx5
         IOOjfojZIjuoRgksCdcjlivwhCv0AlZAA5QIHG2/jVy/mNmX0gbo51/kzZGuS1X4qJv3
         rCRwCRGuw6wLPYwWMSuqPTFY4nPidgQyLeZ84gVJB67PsuRISX1MAey8gO5PPVuSJED7
         NR8IRm7oPaBcUOvrpptiuhtdh827hBLHEaFyc6whIME2KdLU6apvBGy8pGCZZ4XI0HSH
         p78sJc29B5Qz47cSHCHLiT9mwOxylfF3+jhQ7XR1lx3u9mM2WhP8nXehI22HXtc0RvXQ
         fMNg==
X-Forwarded-Encrypted: i=1; AKwUvBzU+4UsTc7c1U7QHFjVxaqBR0BES0xwJy0mNzLvWrMChDhblS+VaOEReuesJBDCRnuai/o/UYg=@vger.kernel.org
X-Gm-Message-State: AFuF++kX5soWf1tf1K6ia3y7VmSaaoYHh3BJxV6iRg7ZnM72cywVq3CN
	1W7WA8tZpqopNZrOijvqB3UMxrX4/P9La9vo3Z5Y2BYNqp3LNAH8H/0vDH0YKtMxaKA=
X-Gm-Gg: AYBFou32wTmahrBFxiE8dfIKldDZpTVMA6dxZB+wy8LQV+tJK+I4abvXv8O8FUqj08b
	Jc+FdoMHwjX0LU0xNiUbRs7sMAXPHd9ka3MY2seg5CH9KxQ6bQs2foH/V7sn50dKUkGiG9wOPvD
	KyH14fVNn+o2ksTNk2d0jhyZV9JwKhi4M4TtyK7p+u/ZccsB2qJBkZAY6viNUD8uP2YpR3rf6C7
	MEZbkghA5fbDd8i1soqVka6B/PusodU8FKQsoydTaVOmPWpUVfPwGxIg+eNHtDQWuPShSnmD0Qp
	zHySAPUvnubbxkDt1LdwjyrmgRt6pApsBjlXxrQrcBQXlpNfYDrM5IpOADuFn4PvW6Ro70fmxuY
	FnJzXXmImqvHKTvRcWB4/MEtPA+OPizh6EVmgqEb3lI/5D3pJXxzCwcPk4JNzGACuFHVJwgkitp
	m3oa44RMdhsJ4/5EqP7pAkcks/XhkRnC2MZw9zhAuwJLvIlYBCfw+t4Y30ip4VeFyYepxciLYDN
	KG+MEc=
X-Received: by 2002:a05:6a21:3b8e:b0:3de:52c4:50bd with SMTP id adf61e73a8af0-3e133b5e12dmr3930596637.0.1791441186123;
        Wed, 07 Oct 2026 23:33:06 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a9e8d114sm2417880a12.26.2026.10.07.23.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:33:05 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com
Cc: michael.christie@oracle.com,
	lee.duncan@suse.com,
	cleech@redhat.com,
	linux-scsi@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v7] scsi: libiscsi_tcp: zero the unsent part of a short read
Date: Thu,  8 Oct 2026 15:32:48 +0900
Message-ID: <20261008063248.767676-1-yhlee@isslab.korea.ac.kr>
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

Count the Data-In payload per task and, when the command completes, zero
the tail of the read buffer that was never received.  Whatever the
midlayer reports as transferred the caller then sees zeroes instead of
stale page contents, so no completion status has to be special-cased.
Writes are untouched.

An offloading transport places the read data itself and does not hand
every Data-In PDU to this layer, so the payload cannot be accounted here.
Select on CAP_DIGEST_OFFLOAD and CAP_PADDING_OFFLOAD, the way this file
already does for padding and digests, and skip the accounting, the
zeroing and the completion routing for those transports: they keep
calling iscsi_complete_pdu() with the same arguments as before, so they
are unchanged by this patch.  It covers the software transport only.

Fixes: a081c13e39b5 ("[SCSI] iscsi_tcp: split module into lib and lld")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v7: gate the coverage check, accumulation, tail zeroing, and the
    completion routing off for hardware-offload transports (cxgb3i/cxgb4i)
    via CAP_DIGEST_OFFLOAD/CAP_PADDING_OFFLOAD, matching the existing
    offload gating in this file; offload transports are therefore
    unchanged.
v6: change approach.  Instead of deciding from the status, the sense, the
    service response and the residual whether the target promised the whole
    buffer, zero the bytes that did not arrive.  The previous versions kept
    growing because every completion shape that reports a full transfer has
    to be enumerated - SAM_STAT_GOOD, CHECK_CONDITION with RECOVERED_ERROR,
    and whatever a future upper-level driver decides - and missing one hands
    the caller the previous contents of those pages.  Zeroing the tail is
    independent of all of it: whatever the midlayer reports as transferred,
    the caller sees zeroes.  That also removes the need to fail the command,
    so a legitimate error reply no longer costs the connection.  The
    predictor and its three call sites go away; the per-task counter, its
    reset and the continuity check stay.
v5: do not check a response that did not complete at the target
    (ISCSI_STATUS_CMD_COMPLETED), since iscsi_scsi_cmd_rsp() already fails
    it with DID_ERROR, and treat a residual larger than the command buffer
    as a protocol error rather than a reason to skip the check (noted by
    Sashiko AI review).  The remaining case it raised, CHECK_CONDITION with
    a data segment shorter than two bytes, needs no change: libiscsi fails
    that with DID_BAD_TARGET, so the data is never handed to the caller.
v4: also validate coverage when the status is CHECK_CONDITION with a sense
    key of RECOVERED_ERROR.  sd_done() counts RECOVERED_ERROR as the whole
    buffer transferred, so v3's "skip every non-GOOD status" left a target
    able to short a read and still have it reported as a full success
    (noted by Sashiko AI review).
    The Data-In continuity check requires in-order Data-In and so does not
    interoperate with a target that negotiates DataPDUInOrder=No; that is
    deliberate, as making a safety check conditional on a peer-negotiated
    value would let the peer turn it off.
v3: only validate coverage for SAM_STAT_GOOD completions; a non-GOOD reply
    such as CHECK_CONDITION that omits the underflow flag must not be
    treated as a short read (noted by Sashiko AI review).
v2: take back_lock once on the SCSI Response path and make the counter
    uint32_t, both per Mike Christie's review.

On "was it built over another patch?" - no, v1 was generated against
v7.2-rc5 directly.  It stopped applying because c1dea15f819cd ("scsi:
libiscsi_tcp: Bound SCSI Response data segment to the connection
buffer") folded ISCSI_OP_SCSI_CMD_RSP into the shared response case,
which is the block v1's last hunk patched.

v1: https://lore.kernel.org/all/20260814121428.359541-1-yhlee@isslab.korea.ac.kr/

 drivers/scsi/libiscsi_tcp.c | 101 ++++++++++++++++++++++++++++++++++--
 include/scsi/libiscsi_tcp.h |   1 +
 2 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index d35f93451ee9b..b7827d52fc763 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -397,6 +397,75 @@ void iscsi_tcp_hdr_recv_prep(struct iscsi_tcp_conn *tcp_conn)
 }
 EXPORT_SYMBOL_GPL(iscsi_tcp_hdr_recv_prep);
 
+/*
+ * An offloading transport places read data itself and does not hand every
+ * Data-In PDU to this layer, so the payload cannot be accounted here.
+ */
+static inline bool iscsi_tcp_data_path_offloaded(struct iscsi_conn *conn)
+{
+	return conn->session->tt->caps &
+		(CAP_DIGEST_OFFLOAD | CAP_PADDING_OFFLOAD);
+}
+
+/**
+ * iscsi_tcp_zero_unread - zero the part of a read buffer the target never sent
+ * @task: scsi command task
+ *
+ * A target can end a read without sending all of the data, in any of the ways
+ * a completion can be reported.  Rather than predict from the status, the
+ * sense and the residual whether the buffer was promised in full, zero the
+ * bytes that did not arrive.  Whatever the midlayer then reports as
+ * transferred, the caller sees zeroes and not the previous contents of those
+ * pages.
+ *
+ * The continuity check in iscsi_tcp_data_in() means the bytes that did not
+ * arrive are exactly the tail, so one range covers them.
+ */
+static void iscsi_tcp_zero_unread(struct iscsi_task *task)
+{
+	struct iscsi_tcp_task *tcp_task = task->dd_data;
+	struct scsi_cmnd *sc = task->sc;
+
+	if (!sc || sc->sc_data_direction != DMA_FROM_DEVICE ||
+	    iscsi_tcp_data_path_offloaded(task->conn) ||
+	    tcp_task->data_in_bytes >= sc->sdb.length)
+		return;
+
+	sg_zero_buffer(sc->sdb.table.sgl, sc->sdb.table.nents,
+		       sc->sdb.length - tcp_task->data_in_bytes,
+		       tcp_task->data_in_bytes);
+}
+
+/**
+ * iscsi_tcp_complete_cmd - zero any unread tail, then complete the command
+ * @conn: iscsi connection
+ * @hdr: the PDU carrying the status
+ * @data: data segment of that PDU, if it has one
+ * @datalen: length of @data
+ *
+ * back_lock is taken once for the lookup, the fill and the completion.
+ */
+static int iscsi_tcp_complete_cmd(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
+				  char *data, int datalen)
+{
+	struct iscsi_task *task;
+	int rc;
+
+	if (iscsi_tcp_data_path_offloaded(conn))
+		return iscsi_complete_pdu(conn, hdr, data, datalen);
+
+	spin_lock(&conn->session->back_lock);
+	task = iscsi_itt_to_ctask(conn, hdr->itt);
+	if (!task) {
+		spin_unlock(&conn->session->back_lock);
+		return ISCSI_ERR_BAD_ITT;
+	}
+	iscsi_tcp_zero_unread(task);
+	rc = __iscsi_complete_pdu(conn, hdr, data, datalen);
+	spin_unlock(&conn->session->back_lock);
+	return rc;
+}
+
 /*
  * Handle incoming reply to any other type of command
  */
@@ -410,8 +479,13 @@ iscsi_tcp_data_recv_done(struct iscsi_tcp_conn *tcp_conn,
 	if (!iscsi_tcp_dgst_verify(tcp_conn, segment))
 		return ISCSI_ERR_DATA_DGST;
 
-	rc = iscsi_complete_pdu(conn, tcp_conn->in.hdr,
-			conn->data, tcp_conn->in.datalen);
+	if ((tcp_conn->in.hdr->opcode & ISCSI_OPCODE_MASK) ==
+	    ISCSI_OP_SCSI_CMD_RSP)
+		rc = iscsi_tcp_complete_cmd(conn, tcp_conn->in.hdr, conn->data,
+					    tcp_conn->in.datalen);
+	else
+		rc = iscsi_complete_pdu(conn, tcp_conn->in.hdr, conn->data,
+					tcp_conn->in.datalen);
 	if (rc)
 		return rc;
 
@@ -509,6 +583,13 @@ static int iscsi_tcp_data_in(struct iscsi_conn *conn, struct iscsi_task *task)
 		return ISCSI_ERR_DATA_OFFSET;
 	}
 
+	if (!iscsi_tcp_data_path_offloaded(conn)) {
+		if (tcp_task->data_offset != tcp_task->data_in_bytes)
+			return ISCSI_ERR_DATA_OFFSET;
+
+		tcp_task->data_in_bytes += tcp_conn->in.datalen;
+	}
+
 	conn->datain_pdus_cnt++;
 	return 0;
 }
@@ -658,7 +739,7 @@ iscsi_tcp_process_data_in(struct iscsi_tcp_conn *tcp_conn,
 
 	/* check for non-exceptional status */
 	if (hdr->flags & ISCSI_FLAG_DATA_STATUS) {
-		rc = iscsi_complete_pdu(conn, tcp_conn->in.hdr, NULL, 0);
+		rc = iscsi_tcp_complete_cmd(conn, tcp_conn->in.hdr, NULL, 0);
 		if (rc)
 			return rc;
 	}
@@ -752,6 +833,14 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 			spin_unlock(&conn->session->back_lock);
 			return rc;
 		}
+		/*
+		 * A Data-In with no data segment can still carry the status,
+		 * and it completes the command here rather than from
+		 * iscsi_tcp_process_data_in(), so fill the tail on this path
+		 * too.
+		 */
+		if (hdr->flags & ISCSI_FLAG_DATA_STATUS)
+			iscsi_tcp_zero_unread(task);
 		rc = __iscsi_complete_pdu(conn, hdr, NULL, 0);
 		spin_unlock(&conn->session->back_lock);
 		break;
@@ -783,6 +872,11 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 			break;
 		}
 
+		if (opcode == ISCSI_OP_SCSI_CMD_RSP && !tcp_conn->in.datalen) {
+			rc = iscsi_tcp_complete_cmd(conn, hdr, NULL, 0);
+			break;
+		}
+
 		/* If there's data coming in with the response,
 		 * receive it to the connection's buffer.
 		 */
@@ -995,6 +1089,7 @@ int iscsi_tcp_task_init(struct iscsi_task *task)
 
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

