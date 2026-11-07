Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046329;
	b=1VhWiYZwFJkne0fyTRFkkqLs7GdbTLupDj/hMvSKUpS8fGWufrlHmd+MZl4pcIcLJDlQ
	 R55RNU8Qnps3Czo7GubNxUbT6cFeynGjk5fBIduG2qeFfdDDjzdT9kzjL0TrcOhG2EOnb
	 3RTfcMN0WzpBLVShyt37BeWwb1HaXwhOob/R7KAGYp3Lut+RMx+62hQinnX1Jh/6c0DTZ
	 oM11bStiIMKQkZxW6fiKZ5LnF0lY6i4uguxvZRJmEI0Jg+ZLsxzR0fzLg53dMxGlquAkH
	 gEFyiEnYB2+zNAm/QEgQZ+OjFkKb45c2Ecdcs6ZYucOTfMYvqgKbf41Woa1CbNF36Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5Nnr7/MJHCfX3DhKqlYgQEvVQhIKg3KcsyWjJeWd5YY=;
	b=zQGqbY0loLqpEBSlus3Rjjz7yXlrBmrI7Op43E2JvujF6XrzAd9ynxGOPyXQqTlPrwIW
	 EWxi8lWCmAQxYZpQQDZz2Alw2OcJVW9QXyV/FQtlRYINUT0Smh+J69Kdxh6FqKVkuaa6G
	 G86X+wXO2eYfSzlHIyQwNvRkBEqlSOh0BmsDkm1waa95hOLsydVy5qqddxsAYgExQnLI1
	 myfFnNu42qEeeLQ8gA6wlmbsz7jtwPIY2Sm6TPOe0qZ3N+kABRYlFJbu9tsv47X65uOTG
	 tIhYGcFDk64VsibwsCvFK30kGKRKW/X+Vx8km5LO0vbSBncLRj8v5lBTgMRBJqdXf8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc8dx4Ut;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50733606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc8dx4Ut
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A71F008A1;
	Sat,  7 Nov 2026 10:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046329;
	bh=5Nnr7/MJHCfX3DhKqlYgQEvVQhIKg3KcsyWjJeWd5YY=;
	h=From:To:Cc:Subject:Date;
	b=Tc8dx4Ut1Ue+202C5hBu6Pf4E8XR91bKd1L6ZN6QsTiPRyZPD1GfZQDyKxwA2CKZu
	 TTpXaqlNDiQylihYshNRP7DzfhGLqoebz10X0rwXJ660qICsbu4CK7S6TGrg+O5VSc
	 LERaQUumRoonH+KFtTQMWEsPMHY//iDsBhTOqOqJbEZwi1ZMmObMtb4tJCsVTfQOvC
	 Plv9ewShh6NkmZglYjHcJLnlIHFs5sTeiuMITq3GyboFpPrgA7tpu/H1nfXvlfAAPg
	 I1orHKVHamt3GetyhpNmizz2QKaa6Xn3s9tClT7r/07K1s0AJUqDlRL0cZf8BS+Orq
	 Y2nzG3Y0n38vA==
From: Sasha Levin <sashal@kernel.org>
To: tom.leiming@gmail.com,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ublk: mark the io command cancelable before publishing it" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:07 -0500
Message-ID: <20261107051207-failed-6.18-a261f0cacacc@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a261f0cacacc022e4fab5b8e38c59f74ce4942e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051207-failed-6.18-a261f0cacacc@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a261f0cacacc022e4fab5b8e38c59f74ce4942e8 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 11 Oct 2026 01:35:45 -0500
Subject: [PATCH] ublk: mark the io command cancelable before publishing it
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 125f45ce0392f..c105826a095bb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2800,7 +2800,8 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done) {
 		io->flags |= UBLK_IO_FLAG_CANCELED;
-		cmd = io->cmd;
+		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
+		cmd = READ_ONCE(io->cmd);
 		io->cmd = NULL;
 	}
 	spin_unlock(&ubq->cancel_lock);
@@ -3162,6 +3163,12 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
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
 				    struct ublk_queue *ubq, u16 tag)
@@ -3175,6 +3182,8 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	pdu->ubq = ubq;
 	pdu->tag = tag;
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
+	/* pairs with the cancel loading cmd from io->cmd, then cmd->flags */
+	smp_wmb();
 }
 
 static void ublk_io_release(void *priv)
@@ -3422,11 +3431,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
+		/* before ublk_fetch() publishes io->cmd, see ublk_prep_cancel() */
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ret = ublk_fetch(cmd, ub, io, addr, q_id);
 		if (ret)
-			goto out;
-
-		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
+			goto out_done;
 		return -EIOCBQUEUED;
 	}
 
@@ -3470,6 +3479,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		req = ublk_fill_io_cmd(io, cmd);
 		ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
@@ -3488,19 +3498,24 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
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




