Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068202;
	b=ytI3O8Jzsk5FxCgUxCW6kGZcI3nqdC0lwlECyNTVIDlS/92MMdjL8+PteSWcNxsfdEeK
	 goZv1TR0ufhfr9/3P1akVui6TS6NN5ViDiySmC8LabYmtkfYI+on1X3A/7B2ZIIoBy7ID
	 +S4c257ZdTR0XWhcyx+Dr2ojc1legH4DDpXf77A90AoD3LRNQAj/QmSeSqOWqZ+zt/FrY
	 LNRyWm/yNV2J/78phnGgyTymCDcV15ZTWyuptmv7QYqsQeG0Lyh7IwMx1ez0aB4oI9BOr
	 QiiucxbrvsVLPE0WKD6vj1j1e7mj118ElbqQM7SxrRQNfL6guUH5TNv4sUQucNbHBiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bM1hTVbW2nweBH/A6UcgC0OeSKooruA4eo//lcpz250=;
	b=w13y/fQKeLeuy6yQ4pd6qgKA982e3LSqDV9dSKpRw2zowm/oMDHtly57FBkc/C299+Ih
	 UTFYHhr+zuEIZwMn+XcjCVfBF2qNbC4eTO/xQaCaJOQLS7ge6QCgw3FlXjSlT/B0edrEH
	 v57wCT2XO+KeZXsd73P6Iq5box8COsaN/8ZwxQQI+EwUb0tViO3yOv3gYtpcKjfYObg+f
	 G6pabdR2DC+aysCSylC448+5fMRbbjFonjRVYGU9Dr+uElyj7jfmENaH1aJgNhzj2ipkn
	 gX81ShyxrJDqU7oEeys6QxmH0l0yHs9w92KmB31X3CVFG25v1B3l+lD8qtCKDC3yTeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DULWFsHd;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9A606AC32
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED9A606AC32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DULWFsHd
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso735420a91.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068201; x=1794673001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bM1hTVbW2nweBH/A6UcgC0OeSKooruA4eo//lcpz250=;
        b=DULWFsHdf6ZSwSCSgnl2++lNc+Q0x2h6m4oFeLD1wHT6I2O3rl+pysZI9RLPwBzke4
         aWBjOd+La4mhabaF9jWVbX8/JVa3UgRYa1LMhefThfK/k2fs5vxPsSHWiH/mjvx4tg+U
         vlHCX432QqXQeb/kaZ/w19jRL7GLuNHUTOIILFl+71+JBanm162hSb/f1JL8iHAG1prt
         PZTLPFS7ROX7j9H14WcSwfq1G+RH0RgU50CxDjiCvJmVYEAMlbGxhLd9sohSHmNQjm3D
         MdqlA9YK43hDoJ3BHRySznKTsydgMpYjWW6IYpZAqlLLTpk3E8jvDuvkJGMd6WD811Cy
         ulBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068201; x=1794673001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bM1hTVbW2nweBH/A6UcgC0OeSKooruA4eo//lcpz250=;
        b=CqIl8Hq4N6HLb75480/gyR3rwiGsQlPPelsDbVkF1S9ScvA/vj6VbtAHS8mQ3aS5Ao
         SvyVWhlmQg/uvYGxXXSlZs0jS9AYakgXWLWSN/lpUgsBhM2sSzAW0YOwCbbyFO+mvau/
         0rl4qjm5AsaqoUFm9ZmrnpZElzTq2BoFgsJB38gUW0EN2p4bcMdgfELopZIgN73NFuVB
         /gyiRl338AoeiToUSMRHrYdHHals9zZK72kipw730ZFO4Eo2Nvb46XTfdddfcv4bC/Xo
         4UotKbzs17/5CX6JB3eudI6c9RGsRiMk69GsZtIyqjqpT5ViK1wCierCjvQ6m2Bkc7W2
         hX8g==
X-Gm-Message-State: APuU4Z8dMjAyO3HW9yC59u4eW50pXW6yLQ6UVszW9v7hj9VP5T0A/CqJ
	26L3f6j/0Zq0/8UvUE89E7IzPy4FQs30Ngrly4CqLGTeOIgpnmApjxJ6QkblpYc9Xu4ZQCOqOt9
	YUJd8
X-Gm-Gg: AYBFou3TuwQ65jR9r0Nx35pTSEeH2GAupXdX1OAdtxKYpfGjUqlStRywg8J25TQN76K
	ImwGF7RAmGWAj4Ha5cwQikV8dH3BEs9kbT5OzUvQw6G6zTK1eRsR9QCHs5olD4Ote+TizFuoUq4
	/728LSzCctt0TpqbHFQmFZwYYTcyxc0oXbPSODv/qrDbILhZfaxuQNSV7zfczDQgH+f/KPBdLmF
	h2X6rz7vOaTYyqGXNFwe8xfw1VRPxcvx7r2GAMhru/52DZzVQfptTi3mj7hMaYCZdv06hF/jc+A
	f99L9krqhbOp3jxyjbGwxoLPAnXttc5p6/6Va3g6XxRUdKnKtmSfYE26vHCSN4wykcWrBsdeEDC
	Bnq4JHjTYY8oQ3ce8DTnqA54SdXJluWZ1J5HJOI1yX8VQ04WzahIzB6xy0udk33F6V5BksExHvu
	jN9Hp/buaJtulKtXYAbI/K1XatW97dOcFNiouEb0VRNeMLZk85cciXczSb9GB0TUqLwIMfERz9g
	hA6yIgXeyK2zdyEGNombEtTofu4L4JAvNoxYV0Qxghutp5RWZF6GSdssvbRbRfCKro1ZPZux4Nb
	yixg+FBzXko+mEPvsmq2S7D3Cf3rXKSKe0Usx7w0+Hborq5ectb8Aa/XhTU0FgUCNj6yQZItRFE
	KyjgHdgKUIvd4lBt80OP0
X-Received: by 2002:a17:90b:270e:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3b0db6d79f6mr5138851a91.14.1794068201339;
        Sat, 07 Nov 2026 08:16:41 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 3/9] io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit
Date: Sat,  7 Nov 2026 09:16:28 -0700
Message-ID: <20261107161634.2500557-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuai Liu <847807867@qq.com>

Commit fca3ff9e2eee7d285585daf51942e0b5e2be354a upstream.

io_sq_thread_stop() carries a WARN_ON_ONCE() asserting that
IO_SQ_THREAD_SHOULD_STOP isn't set yet, i.e. that stopping the SQPOLL
thread is never attempted twice. Since commit 22d9db9fd64a
("io_uring/sqpoll: don't attach to a thread that is canceling"), the
SQPOLL thread itself sets that bit on its way out, so that
io_sq_offload_create() won't attach a new ring to a thread that is
canceling.

When the thread exits on a fatal signal, the bit is thus set before the
ring teardown gets to io_sq_thread_stop(), which now triggers the
warning on every such exit:

  WARNING: io_uring/sqpoll.c:88 at io_sq_thread_stop
  Workqueue: iou_exit io_ring_exit_work
  Call Trace:
   io_put_sq_data
   io_sq_thread_finish
   io_ring_ctx_free
   io_ring_exit_work

Introduce a separate IO_SQ_THREAD_EXITING bit for the thread marking
itself as on its way out, and check it in io_sq_offload_create() along
with IO_SQ_THREAD_SHOULD_STOP. IO_SQ_THREAD_SHOULD_STOP regains its
original meaning, "a stop has been requested", and the WARN_ON_ONCE()
holds again.

Reproduced with an SQPOLL ring and an immediate fatal signal: the
warning fires on v7.3.0+ (22d9db9fd64a present) and is gone with this
change.

Reported-by: syzbot+675af112519ca34f5502@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=675af112519ca34f5502
Fixes: 22d9db9fd64a ("io_uring/sqpoll: don't attach to a thread that is canceling")
Signed-off-by: Shuai Liu <847807867@qq.com>
Link: https://patch.msgid.link/tencent_BB08960D79E0261B5C1EB1E589787734E907@qq.com
[axboe: trim excessive comment]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 1c7f84192c0a..1d31a4b1a9aa 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -28,6 +28,7 @@
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
 	IO_SQ_THREAD_SHOULD_PARK,
+	IO_SQ_THREAD_EXITING,
 };
 
 void io_sq_thread_unpark(struct io_sq_data *sqd)
@@ -441,9 +442,10 @@ static int io_sq_thread(void *data)
 	/*
 	 * Cancelation drops sqd->lock while it waits, and a ring could attach
 	 * to a thread that is on its way out. A fatal signal doesn't set the
-	 * bit, so set it here for io_sq_offload_create() to see.
+	 * stop bit, so mark the thread as exiting here for
+	 * io_sq_offload_create() to see.
 	 */
-	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
+	set_bit(IO_SQ_THREAD_EXITING, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	rcu_assign_pointer(sqd->thread, NULL);
 	put_task_struct(current);
@@ -514,7 +516,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		/* don't attach to a dying SQPOLL thread, would be racy */
 		ret = 0;
 		if (attached && (!sqd->thread ||
-		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state)))
+		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state) ||
+		    test_bit(IO_SQ_THREAD_EXITING, &sqd->state)))
 			ret = -ENXIO;
 		io_sq_thread_unpark(sqd);
 
-- 
2.56.0

