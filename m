Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409091;
	b=HrmEP8Fvl4sDIIYMea6jxQJWUgcosdtppvkx1Iz8IkF88fJupwpJIMkaai8noln8drks
	 uI55isrnwRKPhYG/ZvMgxhJoMurCDkiKT8/TtHqIGRyqsUiWBLzbUrilXaEJ2enlaYq6D
	 sJ5SaLUqDHVw3zFLfCtvljyya4CsYNuoIpD/VI8N4v/QH/8Ty9gRZ24lZfvPvVyLHStWY
	 bW1lWFIXdbIyB7p/rZRlq4/mF4lttvoFwUgqgONDUBEyirfLyb8L81XqQugmAugo6EIuB
	 W+p9f48Mki1lmOzWeh9gLZx6sUwmF84xnxUmEdLxilCdDwWHWUPNxO8RkUQXJOYX6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409091;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=3UcmAD2O5M6J4W2MnDVVK7WCpwTBcwfIWTbYAgmShto=;
	b=NUYMuPD9Ji7v7TNT+5FT7cdRywI+IV20ozrYpIy75BxTYIKJst/eOLhyZ+N9osKqTWwt
	 +EWG4WvKUoZlIV+dsWsBwsfe/9EAHHOOmozvIA93k/RDXrDhk07l5vgBWmNxFzcJRwMwo
	 a009fOqOAW/OZUeh7HdTZP0yvsKgtryq2VL0A6QKvAyHQtYxFhhejtgn2gyAKr+AfD53H
	 mOQ8RRuQI+Gw91FuRL2WI+OBLdEarD4hlogxFpHHlfhmwv4tfZUuqg6MrBk14EsMS2DLm
	 PtmEsrAaITuoDINo7dbCY3RCUH2O3n+AysoJZME+2Cs6CgR/Q4TgJ9U/olIEyQoi/aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=dSaDc9gC;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EEC606A8B6;
	Wed, 11 Nov 2026 14:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EEC606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=dSaDc9gC
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jPmpv0Wcfz4xPSp;
	Wed, 11 Nov 2026 22:57:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794409079;
	bh=wQvKiUyO5od0WgKA+S14UEB4DR0uKqEqs67IGBDqK5Y=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=dSaDc9gCovkB34zjXxN/LnupcnCQ5nsurDrqvW3GRz2JfOBIdvYA9A6gC3KAgNXJg
	 S5SnGGejkmRxhGqMvYB2gOdwcddFbUGO+rCwJZUvdW7MoGAFL20RVx54sG0k1PFhKO
	 dXtjBSJWGhklc8Cm7M3wqHVB3fXeX9Mg/L6wTt/S4QP9CvxegI2JVlDZdXD7hm4D+Q
	 2a11uAksLmleO9A21uTRgBxKjTXDhqv7FEEq/G4i4gRQhOasCIftVo1cV96hDr8Cku
	 RM14PYqOqDIJDDzYUT0iwCW3+acrMDBhs7xYoOwFwvpCNLkWyRBHGyN0PaaIVBTZYR
	 iXUVlngg1f8uw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ABEvvxq073370;
	Wed, 11 Nov 2026 22:57:57 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:58:01 +0800 (CST)
X-Zmail-TransId: 2afb6af48279b97-70a73
X-Mailer: Zmail v1.0
Message-ID: <20261111225801025TKHDW7iZbMR4sFQAc8af5@zte.com.cn>
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: 202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn
Date: Wed, 11 Nov 2026 22:58:01 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>, <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNF0gdWJsazogY2FuY2VsIGNvbW1pdHMgYXJyaXZpbmcgYWZ0ZXIgdGhlIHF1aWVzY2Ugc2Nhbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ABEvvxq073370
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 22:57:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF48277.000/4jPmpv0Wcfz4xPSp

From: Shao Mingyin <shao.mingyin@zte.com.cn>

QUIESCE_DEV marks the queues canceling and cancels pending commands.
A server can still be processing an I/O when that scan passes its slot.
If it submits COMMIT_AND_FETCH_REQ afterwards, the newly published
command can remain queued without a future request to complete it.
The server waits for that completion and the device remains LIVE.

Share the cancellation claim with the command handler and use it after
processing a commit when the queue is canceling. The cancel lock and
CANCELED flag ensure that the control path and command handler cannot
complete the same command twice.

Fixes: b465ae7b2524 ("ublk: add feature UBLK_F_QUIESCE")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
VM (4 vCPUs, 4 GiB), using real ublk devices and fio. A test-only server
hook held one COMMIT across a successful quiesce, then released it.
In two runs per version, the original kernel left the device LIVE until
a second quiesce; the fixed kernel reached QUIESCED without that retry.
The paired runs used the same userspace probe and no kernel diagnostics.

The four original recovery scripts also passed twice with this change
and a separate batch SQE initialization fix, without C or driver
diagnostic instrumentation or reduced fio load.

 drivers/block/ublk_drv.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1b..082f105f1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2792,14 +2792,33 @@ static void ublk_start_cancel(struct ublk_device *ub)
 	ublk_put_disk(disk);
 }
 
+static void ublk_complete_cancelled_cmd(struct ublk_queue *ubq,
+					struct ublk_io *io,
+					unsigned int issue_flags)
+{
+	struct io_uring_cmd *cmd = NULL;
+	bool done;
+
+	spin_lock(&ubq->cancel_lock);
+	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
+	if (!done) {
+		io->flags |= UBLK_IO_FLAG_CANCELED;
+		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
+		cmd = READ_ONCE(io->cmd);
+		io->cmd = NULL;
+	}
+	spin_unlock(&ubq->cancel_lock);
+
+	if (!done && cmd)
+		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
+}
+
 static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 		unsigned int issue_flags)
 {
 	struct ublk_io *io = &ubq->ios[tag];
 	struct ublk_device *ub = ubq->dev;
-	struct io_uring_cmd *cmd = NULL;
 	struct request *req;
-	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
@@ -2818,18 +2837,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 	if (req && blk_mq_request_started(req) && req->tag == tag)
 		return;
 
-	spin_lock(&ubq->cancel_lock);
-	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
-	if (!done) {
-		io->flags |= UBLK_IO_FLAG_CANCELED;
-		/* dependency ordered against smp_wmb() in ublk_prep_cancel() */
-		cmd = READ_ONCE(io->cmd);
-		io->cmd = NULL;
-	}
-	spin_unlock(&ubq->cancel_lock);
-
-	if (!done && cmd)
-		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
+	ublk_complete_cancelled_cmd(ubq, io, issue_flags);
 }
 
 /*
@@ -3560,6 +3568,10 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
+
+		/* Quiesce may have scanned this slot before this command arrived. */
+		if (unlikely(READ_ONCE(ubq->canceling)))
+			ublk_complete_cancelled_cmd(ubq, io, issue_flags);
 		break;
 	}
 	case UBLK_IO_NEED_GET_DATA:
