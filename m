Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361670;
	b=2qbjn4dHhJKcfDCtzsPf7NMz1RKh6QZkfLgnDlvHwrGzif/A4+ranhH3dgxtc93G9Xl5
	 BwFGWLoQwA2yx0lUjRm56oJMXXl8u3QK4XepDtGLYtnNKt4inKQEnBfovG2YNeBO4tzgj
	 EQ5MjJbn0iXacDXPKG/0Uwp/qjGstS7E1vzWJH9w+p5yyYSBaHcw4+YNcoHQC8GlW8/C7
	 hXE2/bN09CjQ+qCo3XEEniitbGmXyNSDk74fzJqc/opuhkY6bGPrFxv61lYV1CCrG9Jbd
	 v1r5i7XNGzn2FCgYleKxCExCdztZfX2pcpriY9KTrHC574lfZ3bPcnMJo2xpDsOiF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=my1r9kVMJeb4mL18Fc9HCqSCZER5bSbizT9L0b9wLJc=;
	b=V1In0vl8hnKC7KB5f8PPTGbzpCOd5iKzvBph7uP6EX5gFqc+DPDfYKY9Tp6dRlT+I+jP
	 S9XP8x8k6KECEuXs+wpWibOMKg6XP1jXX5ApGlQQeXu9trLjwaiCogvxDpG+GxaRGE1QB
	 ZweoAYFKhmrWQvZ8i0b9IiW4x/ntdz0KPs72z4JFWEeN41Y295/43/ccSZogzrNjvuC8/
	 FTS5pyr9JNm+2P4H4yatJqCrWo5gWQnYLcbqZh5TD03Jt8k60AsOFydWW3SjjwKT9sT87
	 BGzl8rh4fIXfyUG37tUVOHWR2cRS1XFVgn935cGPyct/+ryv6ADn4SsDYgyyd62QRuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bnr45jHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47847606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bnr45jHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F961F0089F;
	Wed, 11 Nov 2026 01:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361669;
	bh=my1r9kVMJeb4mL18Fc9HCqSCZER5bSbizT9L0b9wLJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bnr45jHgHYKjv1dkKY8keP/Fnki9vIp8nF4ZRMRaxCkoak5epyW2f7R5PwADiGZ+H
	 WjzYga3Gyovj2bupbHTKoE0dwMU6srheXkWT/RGoj5qjz5c31EnPWjjbF/WoYY9IU9
	 PnqQJhl4UUGNjaBAGrtR4Svx3t9UqKtez526pui6xCZh0mO1yW0K5Whkoqdw5WXIpD
	 JA2lkPkD1ZjmcOvJ8mkPkOL6QB+0WygfpWC3nkVAAwtoNiRG+bkF9CKL1K73vM8Cpo
	 4WuFxHdlTBihS56HzCKZQrLYExzXS38SsHQyAzwbxCgjLJiCdUO+uUys7FfQL0efh5
	 +DFybujKC+Fmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ublk: mark the io command cancelable before publishing it
Date: Tue, 10 Nov 2026 20:47:48 -0500
Message-ID: <20261111014722.402629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051207-failed-6.18-a261f0cacacc@kernel.org>
References: <20261107051207-failed-6.18-a261f0cacacc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ming Lei <tom.leiming@gmail.com>

[ Upstream commit a261f0cacacc022e4fab5b8e38c59f74ce4942e8 ]

FETCH, COMMIT_AND_FETCH and NEED_GET_DATA publish the command in io->cmd
before marking it cancelable. A cancel from the control path (STOP_DEV,
QUIESCE_DEV) can complete it in between:

  issue path                       control-path cancel
  io->cmd = C
                                   take C, io_uring_cmd_done(C):
                                     C not marked, nothing to unlink
  ublk_prep_cancel(C)
    the completed C is linked on the cancelable list
  ring exit: the cancel walk hits it → GPF (KASAN, with a delay added)

Mark the command before ublk_fill_io_cmd() publishes it. The handlers
run with uring_lock held, as io_uring's cancel walk does, so marking
takes no lock and the walk can't see a marked command before it is
published. smp_wmb() orders the mark before the io->cmd store; the
cancel loads cmd with READ_ONCE(io->cmd) before reading cmd->flags.

A marked command has to be completed by io_uring_cmd_done(), so a failed
FETCH and the inline UBLK_IO_RES_OK of NEED_GET_DATA now do that. The CQE
is the same.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20261011063555.1142277-3-tom.leiming@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: passed READ_ONCE(io->cmd) directly to io_uring_cmd_done() instead of storing it in a local variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6b2035c46daa3..70493dfdda41f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1993,8 +1993,10 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		io->flags |= UBLK_IO_FLAG_CANCELED;
 	spin_unlock(&ubq->cancel_lock);
 
+	/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
 	if (!done)
-		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
+		io_uring_cmd_done(READ_ONCE(io->cmd), UBLK_IO_RES_ABORT,
+				  issue_flags);
 }
 
 /*
@@ -2258,6 +2260,12 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 	return req;
 }
 
+/*
+ * Call before ublk_fill_io_cmd() publishes @cmd in io->cmd: a control-path
+ * cancel may complete any command found there, and io_uring_cmd_done() only
+ * takes it off the cancelable list if it is marked already. The handlers
+ * hold uring_lock, so marking takes no lock.
+ */
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
 				    struct ublk_queue *ubq, unsigned int tag)
@@ -2271,6 +2279,8 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	pdu->ubq = ubq;
 	pdu->tag = tag;
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
+	/* pairs with the cancel loading cmd from io->cmd, then cmd->flags */
+	smp_wmb();
 }
 
 static void ublk_io_release(void *priv)
@@ -2511,11 +2521,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
+		/* before ublk_fetch() publishes io->cmd, see ublk_prep_cancel() */
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ret = ublk_fetch(cmd, ub, ubq, io, addr);
 		if (ret)
-			goto out;
-
-		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+			goto out_done;
 		return -EIOCBQUEUED;
 	}
 
@@ -2559,6 +2569,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		req = ublk_fill_io_cmd(io, cmd);
 		ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
@@ -2578,19 +2589,24 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		req = ublk_fill_io_cmd(io, cmd);
 		io->buf.addr = addr;
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
-			return UBLK_IO_RES_OK;
+			ret = UBLK_IO_RES_OK;
+			goto out_done;
 		}
 		break;
 	default:
 		goto out;
 	}
-	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
+ out_done:
+	/* marked cancelable: complete through io_uring_cmd_done() */
+	io_uring_cmd_done(cmd, ret, issue_flags);
+	return -EIOCBQUEUED;
  out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
-- 
2.53.0

