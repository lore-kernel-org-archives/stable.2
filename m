Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362187;
	b=E5BcSsINdPpA2kjZl85VMj83QIuKfjO4Pmf/8VMVgR4wXFbSSOvb0UCX6yOGEHWQAc8u
	 yZrfrdXkZr8c2fnXdYOpgQDxqGwbUaGcOH4L6Bi8XCm5BGwYGqDIEKa7SI4IxKVy1ckud
	 Hx/9kaeJf6LjDub9m87GJ++M5YmCNaQEOEpwNFxRo0R3TsBbDj1Y5fZmgjdcoVQlH8zev
	 XM39oorowaIdGyXm2PbmHvBoHVw9tF+qNDVpF+Tcpm7hPUVXKJGgPfE8TdktRAxT3n8Pc
	 UpNIGSMnMyEfZVv5R/DhI6BjrWRiuSzrS/rVdL0iAaSSnA5IRBnOWOG/p4EVs8eefGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gBK4AzbJ7V99AKIMhNAxS+NdtmVyqniQz6K5yYyjo90=;
	b=cRAluLYMoIDiLt/debjTzsB63ZrKtRUaxJyOx7fFTziKytIreimc1wa82rb9HU51UXyX
	 TGRpAoRAmNXDHgrev/YdicfG3PxW0ho80dg58PIaa69gFlEbdrjf/zld5BiuJ2tMxwVFC
	 5BoJ89Qlq1GpsL4s8E6BstVcJ7Sk46tEKxR5O3yqDPI+exCGLruLN/jRgFk3tkstVSlgD
	 lYAJpGA88wL5rFtjV0pS+tOztI8RzsM2uV2MIfxbXh/67zxC312dRADOlIntitMpG+CG5
	 YKt634UX4Vojr7FaKD3hrD8qQxdw7FQf3A2aoeFsLle6/sQIw2Y6cIAgnuWoJlI10lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUhVxLW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA605606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUhVxLW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0881D1F0089F;
	Wed, 11 Nov 2026 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362186;
	bh=gBK4AzbJ7V99AKIMhNAxS+NdtmVyqniQz6K5yYyjo90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aUhVxLW1hqM+uaZOZg/x2N8z1NCLQx9pyWPKE5mU+2ydi0ohyOFSaV1Q/U81CB5LB
	 imKFOc3q9uPbw3gB4tgC1nSwnWuST/2RUBq29AAOOQfzWc0ZsJj96HGoYyVTDHA+8n
	 Bk8yPhZRCAdSAJ3V2NKse38aK3GMuHZdzUlm15EUtEAf6yE+EV+dPE0/6YNpo/hyv/
	 g1tEqbAIbBmeDA6JtgUEb0T8ICXvyno1dKIQFux2l9BimWu8QsPMOtjSvuq2UwL7BD
	 IaDia9pD46LjXWjZip8Qi5qJJ5bMKpPuk7wvR5WLcX6xLv9QQOZoP3laekhQfbG59S
	 TG41ok0zccJ/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ublk: mark the io command cancelable before publishing it
Date: Tue, 10 Nov 2026 20:56:24 -0500
Message-ID: <20261111015604.451739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052320-failed-6.12-a261f0cacacc@kernel.org>
References: <20261107052320-failed-6.12-a261f0cacacc@kernel.org>
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
[ sashal: Omitted out_done because FETCH validation precedes cancellation marking and NEED_GET_DATA already completes asynchronously. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3e7c3b1f0b8a1..f89b36017d979 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1589,8 +1589,10 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		io->flags |= UBLK_IO_FLAG_CANCELED;
 	spin_unlock(&ubq->cancel_lock);
 
+	/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
 	if (!done)
-		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+		io_uring_cmd_done(READ_ONCE(io->cmd), UBLK_IO_RES_ABORT, 0,
+				  issue_flags);
 }
 
 /*
@@ -1807,6 +1809,12 @@ static inline void ublk_fill_io_cmd(struct ublk_io *io,
 	io->addr = buf_addr;
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
@@ -1820,6 +1828,8 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	pdu->ubq = ubq;
 	pdu->tag = tag;
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
+	/* pairs with the cancel loading cmd from io->cmd, then cmd->flags */
+	smp_wmb();
 }
 
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
@@ -1899,6 +1909,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		}
 
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
@@ -1925,19 +1936,20 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		}
 
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
+		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
 		goto out;
 	}
-	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
  out:
-- 
2.53.0

