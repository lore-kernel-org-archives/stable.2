Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1F3BCD1E
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700573; cv=none; b=R2pky72l2yB9cyW7u4LUNQGSDsXN20Jvr5MKALx8YHADOYcXooLPlPN7yooUt7G4JS317Q75JO+iaATUSpP5Jv7H4gZVaHBRKYdV6fNqwGgP3rKeMj+cmtlDnGQ6ignzckDnmxpls7Q7Ki+C9ax7ePdMcPkMiOQM621heaPVKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700573; c=relaxed/simple;
	bh=37Jb6dEnVEdT7QzPLPQ336ELgePStuxCB0wrufLul40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/MXRilb1N/BWMJIhupisdD4kqMnQMYpofDx4ILPCcR6mQkz/uPtSNI0QhUXcNHAVHY3CvJ7JumPDwIdYbUXbGKnXFG3VZewK/Jvk+WYkj4MXWd3MRKfY0lK3XWlL7LqnG5gpa9XpxBo6ePCc7VNPL/sB07Cg9Zj4ow2ac9qegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJoR28Aj; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJoR28Aj"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-81c5aac8478so702802a34.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700571; x=1792305371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z28gAIKikwAduVSPCuQDDqAt9RT9LELax30/8v07S3o=;
        b=bJoR28AjKJIw+dRPG6mABNROTt4jrQ3FlyC3I/qRRnLl5l2yDhPGS4/BvyGI10XlDg
         qABT9CV0oQyeLJBQ6Q6BzjanKMU25U1Z1pkKoQ2pFdaZbyz77X6cee0JV1Ebdns6Aod1
         bVnr6GUD59+mVRShw9EM/v07LAAKTa2IuKNr+sMAiO4PdVMKQKyB3Zx8Ky8Nm8Af3Q/G
         bhSpoJxW0wQyUuJhUbMgn3/8f4ueXoftz7aBULmJ8omhpdDnftapK/GrVqtI5spwk8O0
         WwnUKxRgXHQpZOps6EuvmHl+j+bcNZyAxYTdZkdEH1NMftlgQ1tlNhN/TPUqlAVCvTZ6
         CGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700571; x=1792305371;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z28gAIKikwAduVSPCuQDDqAt9RT9LELax30/8v07S3o=;
        b=MqlHrhPaHlVgLdmeSIVoexRaEgqwgXtoqtB8gfBtHNBi510OxJElgnDQLpvDyYXZe0
         ERNP8ptMphTyGZqiWHzrGEkwFkz/3fzqpePbhAtDnEZOE4CkoK2k4ps1l0quK5Khd7f9
         An2Sqq7EnEAT2rr2T9AHQ/rdXhkhrKoIif1zxv4lqiSqVp25mMjqERzTYZDdwJEYOAck
         oC/tQbfL9564G3UVUyZ5ccF1oFPpaoDrkWiaHorFkB0Levy/lRnxKQYRq7x6mn5+WCp/
         uFH3hYyOFgnT14Ev2e6svPt6DEAKqD9Jmh4oTZJNHxybznKPKXd+PEViqBowEVo7cHdx
         kxRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsbrluJchE6wfukFLeEZ91jg2WjyqXpPRpXwXbY+9Pz96loMW623tDeBemFEJPKtQzbTSFhUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlROYfo02g28coD8gCGlqDIEbNjY9kzbonR8f/L58AvxWzPiAt
	YvRAj+C7+q8y8hcXei2KnsyQIbS4SHHAz+iga5OA3uEHnW/LC+uroW52
X-Gm-Gg: AYBFou27z7AmtUUSpYTKOrrn2cgCSWm2I6vAgifle3nbn1z71PJQXrG8oSb0y1ggx3S
	dl35tlkkfX76YqpTmrxQunxlKFafVo72KrcazNOfmD0D51UBKgE7CPHmnNZbZfMQcOMUY/YKuP5
	wea9nFFwzkaWVLWY6pGg7O4uNalHRq1jYNSB3KNlRqHWt8Od+RD20/paj7Vr+u9CW0FFK/wqxfQ
	P7gzi0wIZWtkQlBjKbSOZKP+Rz+0MCM7J08VokDwxdVwd+0//w6lequoZtXWtX3SQusSTWulieR
	56S5bjg6DiAePrXMgd9E96UvGEKH4AXIHtRvdTooL7OJ5QxgCc2xeUL08lMJy/NPusKeIN61cFR
	wy9goR3+g1+dDEWoRQhSSRobKHzaNlnn/cthUseIZLBko7cziR/4NkUInPUy8XD694h2US821zq
	LKxqw//zMvlqStOKcahyQoSVyPPRXtdXAh4WRz4FFj8HYCzbclWbesEnq4/WNtvi++dR3PDiGpt
	0xjEQiGILFQcJNb5u/nlRgwEaxW1Ed0RttYFfc1WJdfzC5k9WHEARw+JgoyJFMrNLCkKAtwg+cU
	stxOszqf22FqIcbH4acm+BSduwk=
X-Received: by 2002:a05:6830:6a14:b0:7fa:ab72:9df9 with SMTP id 46e09a7af769-83095f0fbd2mr6361787a34.17.1791700570690;
        Sat, 10 Oct 2026 23:36:10 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:10 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 02/12] ublk: mark the io command cancelable before publishing it
Date: Sun, 11 Oct 2026 01:35:45 -0500
Message-ID: <20261011063555.1142277-3-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b202d97f0dc2..054760f73c54 100644
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
2.55.0

