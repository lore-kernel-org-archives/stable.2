Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB139A07B
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700577; cv=none; b=L01bzfQ4qsnM4TEcxC/vxQ3SP1feu/pnlYFCuwc48FvQUafLVYJ4+hbvo1Ce1uExc6/zJZokEx7LPD4LZN8EeR1pSTRXz5pPoBFDsiCT4kACpqI7jFMGgZ6rWZp7s6eS3/PF4DrpfQzNWF6qMFNeVB0MUmyE/4fZSaUujRcoNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700577; c=relaxed/simple;
	bh=y0g3zFmVhF2aVKegZzpXVDSCw324DnC/CYzl6ZBKob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMNQ6Ctr2+4qJri5TlCt3jK/tzOsMEg1MLUf8jC/9Vfb1YwV8S6DyWe/zFq68gZqEewmpb7LZj+YCkdxDiLrpOj/3fqgdWEbM7hiWGZO32g+Y21FhGUn3eIaAErN/Y16N6iB5QcyzGcQk+cRJqS4CwaJ2VTNCI3wMQ5zqkpwYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW6niVGx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW6niVGx"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82374c2d7aeso926902a34.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700575; x=1792305375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzOPAM/lioTAa/xQ1vNMF4p9q659rysGR0RBUOM3mWQ=;
        b=bW6niVGxZmOtDVchCb0h7YngYk0f2vuCOvnBi4XIdfOA3xRFddpjpVq4Puer5e0S1z
         Re3FrFhZGFX3cg1uYY9VrgGc5EIR8UCgMOEg2TZFE5iFDj0Zijg2kkNmdBfJZxea4PvS
         wvb9PHho1RNw3hbqxAztdtw8dGvd1UYT/es39xtMmhSvYrThGDhZBbhsITp4esNWAYUg
         MutfeF3lPSXz1YI2mhxomNEkHM0NoGxo2fwdmZmVzOjxF7xcYYvCDJiabxdJPJ6N4pEr
         Ucfxs022PhFZ72Uz39GGoHV+9XoxRiEhamxzDXOTWJeOWFt8Lvz5etUU4sl2huHFwznI
         lSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700575; x=1792305375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzOPAM/lioTAa/xQ1vNMF4p9q659rysGR0RBUOM3mWQ=;
        b=CEYjaGMakA6qzo5B3Sowk65q/Ceo5g1VTf7kw1T3rSya0v4/lPdWFymz527REcUVtr
         nLmGHjrsWxdxStITYFfEcQpcXexliqh0HyLPhJZSSrqZEzcVvhMZ6+Q1qOK1Y3exFth2
         j0AE+cxY1RkZfbRhKBoZ8uW96XAvPqGDQa/P192jpUfk9AH9AkLZU1kzAAng6sXHDfht
         MwHbuRpgll6Rdd1rx04ov7edkEZy/TNl5vRU8wDPakVynEsae3pi+s8N1wHYFdbgJ/hu
         iecq0mds6OVs1TWoNkDskqZwsB7HifvKv/0RWiCRFJ9a6a23ZSKP/OCLsLeVu4GuS9Ct
         PWwQ==
X-Forwarded-Encrypted: i=1; AKwUvByLORiuiKEe0auevey6//rzG6wHfS6IsWEMNAoPWlcv0LBEz0GySZ6GXwrJt6JAPPp22zdRT2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7Nk4br8FWIE5cljiaktQU0o06VyFp6EgFZLD7Y+xuOmB4N+Vo
	llkwHkCovmdxkdY9O8d56X79iqtTT1+V1l0+Qm5uA0pJKZrVVLyaK1TsfMxmP5VL
X-Gm-Gg: AYBFou1IcYn7L4VcfPfc4KBUYQ4hPS2L86SGcb+X+NcGskYSJMKSMgcbNt52dVl2q+a
	kFwSmmdtRrYQsF9XFSpgQ5upFNWMtNiQ016ohjJ/JZuoOskBq5tUwGKYGlUnZL9bZVttU2mv00c
	40sMdvucOtujOfvg0Cn3psqwYlhCYdu8E0RH8WcliA72di5AL/q0FJjbdPvb1beDx3gfFPJD2tj
	mWLtQTRQkhG851M6tJgjUEVRnS9f4Sl1C21FhWORRm/6qKiro0MWik5rU6xka5oHlPVbGMVrDTx
	qSIiRT85oePRuK5/c3RpEEs9E01CJwg3vyQ117wp06YFXolcW3sSx+tP2NT2RTak/ZKve1GLonW
	V28kCUo1FPvgmAbKM88PffzjvqPE9CLf2ymcVNSwjU5TUND8VJa1146NeQ5y4aXamJx/1zpiZR9
	5INlWTpvMzg35rKOnJDrid9BBNzMfw8TNpIwpvdQffPeOb4md6jCq+UKiBx7WSDRwW48OMn34HM
	aRmYh8XHd7AI/q8VPgOx8Av1FSJ8XzwgyEZYASFWWbd7A0MAnEQDrQPFCWIRqn+uhaJKknesxqx
	4q6wGkcUrg4BD/pMOKwphlFmdWc=
X-Received: by 2002:a05:6830:4127:b0:804:e0e8:1a86 with SMTP id 46e09a7af769-83090e21c4bmr4401174a34.1.1791700574966;
        Sat, 10 Oct 2026 23:36:14 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:14 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 03/12] ublk: mark the batch fetch command cancelable before linking it
Date: Sun, 11 Oct 2026 01:35:46 -0500
Message-ID: <20261011063555.1142277-4-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_U_IO_FETCH_IO_CMDS has the same order problem as the per-io
commands: ublk_batch_attach() links the fetch command into fcmd_head
and marks it cancelable only after dropping evts_lock. A cancel from
the control path (ublk_batch_cancel_queue()) can take it in between and
complete it, and the later mark puts a completed request on io_uring's
cancelable list.

Mark it before linking it. evts_lock orders the mark before the link,
which is where the cancel finds it.

Batch commands are not bounced to task work, so they can run from io-wq
without uring_lock, and io_uring's cancel walk can now find a fetch
command before it is linked. Two things make that safe:

 - initialize fcmd->node: it came from kzalloc(), so list_empty() saw a
   linked node and ublk_batch_cancel_cmd() would list_del_init() NULL
   pointers
 - on the -ENODEV path, complete the command with io_uring_cmd_done()
   before freeing fcmd: that removes it from the cancelable list under
   uring_lock, after which nothing can see fcmd

Also use data->cmd instead of fcmd->cmd after dropping evts_lock: once
fcmd is linked and not the active one, a control-path cancel may
complete and free it.

Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing")
Cc: stable@vger.kernel.org # v7.0+
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 054760f73c54..e57c0626b84f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -815,6 +815,8 @@ ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
 	if (fcmd) {
 		fcmd->cmd = cmd;
 		fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
+		/* a cancel may look at it before it is linked */
+		INIT_LIST_HEAD(&fcmd->node);
 	}
 	return fcmd;
 }
@@ -3914,6 +3916,15 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	bool free = false;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
 
+	/*
+	 * Mark it cancelable before linking it into fcmd_head, where a cancel
+	 * from the control path can take and complete it: see
+	 * ublk_prep_cancel(). evts_lock orders the mark before the link.
+	 */
+	pdu->ubq = ubq;
+	pdu->fcmd = fcmd;
+	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
+
 	spin_lock(&ubq->evts_lock);
 	if (unlikely(ubq->force_abort || ubq->canceling)) {
 		free = true;
@@ -3924,14 +3935,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	spin_unlock(&ubq->evts_lock);
 
 	if (unlikely(free)) {
+		/* off the cancelable list first, then nothing can see fcmd */
+		io_uring_cmd_done(data->cmd, -ENODEV, data->issue_flags);
 		ublk_batch_free_fcmd(fcmd);
-		return -ENODEV;
+		return -EIOCBQUEUED;
 	}
 
-	pdu->ubq = ubq;
-	pdu->fcmd = fcmd;
-	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
-
 	if (!new_fcmd)
 		goto out;
 
@@ -3939,9 +3948,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	 * If the two fetch commands are originated from same io_ring_ctx,
 	 * run batch dispatch directly. Otherwise, schedule task work for
 	 * doing it.
+	 *
+	 * Use data->cmd, not fcmd->cmd: once fcmd is linked and not active,
+	 * a cancel from the control path may complete and free it.
 	 */
 	if (io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
-			io_uring_cmd_ctx_handle(fcmd->cmd)) {
+			io_uring_cmd_ctx_handle(data->cmd)) {
 		data->cmd = new_fcmd->cmd;
 		ublk_batch_dispatch(ubq, data, new_fcmd);
 	} else {
-- 
2.55.0

