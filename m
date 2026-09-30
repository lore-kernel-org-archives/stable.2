Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB3318B9B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753907; cv=none; b=n0pDMFIILlLZY7r6GWqFaQwCBssqMQDdb1w1EFTNzPssVxl8VxGHuPV99o0x4YTdpfTeuzEsQ+8q3MCTeij9F8XS/8gxzETpefi35hYJwvSCFj7QxLmb49GjxJEruRaC0F8NRofdnnk55VHjkBE2+Qr15PqdO86TQ8mGCIuh66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753907; c=relaxed/simple;
	bh=JO89WVAK+rieJZqchoezwfhDm9NNYlXKlSusZJGtcPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZC5WeCPtqsf9gPh7LTCe81BnSWk1B/AXAC10R/C3jRxfUpqf59tkM5EYEJzDvtmC0/shYSDUnjKm9BWNcqGPnkk2Cqb2KwBU6+V3Twj7PugMzgoPdtKVlf3qH+hMU+sz14VeFS4iSTZAFGKePDdYVbjI1OFnmqKHXsalloQKJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfu6+QY+; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfu6+QY+"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so4584376c88.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790753905; x=1791358705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+W1UtWCavGQoKmykf6XiyA2cCnYTBdJNWGQdr5vgxPk=;
        b=Xfu6+QY+qKH6rbs2czbcIOeEp/CHlsz7t7ex5NpY/8JAA5UzxMTjAFdv9tWP3J+q6s
         rDJjzUv5n78ECZQN1ykzr2EUnYUsSdn3vCK7/uHSUOsCtSjtPzvH2PDaMfAItv/CYULr
         VorTt4Y8MmpG2Pv8W/SnBXAJBniqE8fzZw1ZxMXpzp9kOZEzKV/YfnJUVnU51xpDJ5hr
         keOT8+7W8SqsqWueTmcjwgJgXzzqlwvMahn52tiUkvb/jygGDnRtdRXlKAgJ3/87941N
         YfOphEccnKHn1HAz9ugoNKrjRLERpWgfG20jrPs+8Fc9cR+XE51AOHrbLXGHFN44+9Vm
         TEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753905; x=1791358705;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+W1UtWCavGQoKmykf6XiyA2cCnYTBdJNWGQdr5vgxPk=;
        b=H4H76i2IQro2FJU16klDtwskHsZXHM7j3BPRhwdcrgPLXwkyv9f0+GZZZ3Ib8k6Vqq
         8wKLvF6kkIqSgmcHXpuVqn28wXJwNjAzJXGfCvIXdE066Da34tHfz7c47I/HAuiCAJbL
         Ysmgp8DWqfhAXgroPafc2XoYZeVijiRv544yEemvvjyBcwwlraLVLQ9Kfg3jVPcu8u62
         c+H/BpdWzwCmy2AzO0h88BO7Ho4TJE206NUGljbPr9Y62gwnI0rkefpeN/lpny57jnsN
         FUxEyQtGfedJxqt6FZ4FZFjJmCAESkcC4gx/R5ngjsSZf5UrE3Bsu5bONLLUsoG5BW8B
         23ew==
X-Forwarded-Encrypted: i=1; AKwUvByd7NBKBYdUl3tjUSX8CXexuMla9av8/DBAxX+H6T7uNqero7HG2zU8AqYgsiDjuyNDcXjqFVI=@vger.kernel.org
X-Gm-Message-State: AFuF++kr60rWkf29vshtKu3GbBaXkVAr2DGFDEXNM90T34o/XHiG6W37
	8ovh9ZNcai9ZCNIoQbz42Ejf48t2aVWHxCu9c1ND8WB1TwB35Q6OwuRR
X-Gm-Gg: AYBFou1ycrKVMn1xOAjjphh1Juy+yg/1JjQtTkbT/rJFBVmpKav947NoJoVWNcMsgYu
	gp171cGZSCQYRazNjp0/uxMulXiBwcjMYtUKCcJs8VWSY8RN2xuoiAvlZjY3CtDAkYqKgeLM48K
	cVxmj8ssjbH5tU8OGPExW2+PNadcke1KI/T9bZY67whuNScBYHzUkfxoPFtTUh9b/8VruRpzu9y
	iyW3M4MyKdVZOKlZRULGO363bL4FIbsQi3HxFJA8ud3+QLtHvEO82yrkEXm5I7vfnFNuUEv0ryD
	SiElOPN/lvIf45VxYfMA9rw3xbgQtldMCm2gE/jCyw0ZFTdwm5fSRDnSmJMcp6IUPQSvLTkRED7
	NDhIEPp5j1z3QCwCyBJcHGlsN2ooZdTYgSb2gjUOvj6dzom0Vu0XRRm7RdwPlTLYB201u3HoQ/X
	WWsUIIb7KqMnQ3PpvcdNMT9bmudH1KWpYiN/ldyL8I3VjuDEzphxAkuk15W+3tzqQdkWw=
X-Received: by 2002:a05:7022:290:b0:130:7246:10aa with SMTP id a92af1059eb24-14d31d67898mr322143c88.12.1790753904531;
        Wed, 30 Sep 2026 00:38:24 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d083fe71dsm2257413c88.4.2026.09.30.00.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:38:24 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 30 Sep 2026 15:38:19 +0800
Subject: [PATCH] blk-mq: run the hw queue synchronously for unplugged
 scheduler inserts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGq8vGoC/x3NQQqDMBBA0avIrDswalHsVUoXJpmYQRvTjEpBv
 HtDl2/z/wnKWVjhUZ2Q+RCVNRbUtwpsGOPEKK4YGmo6GlpCs09olhnfH4xrWorUBnboRNO42YB
 3Xw9tR4aM76FkUmYv3//i+bquH69s1zdyAAAA
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
 Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

When the submitter holds no plug, blk_mq_submit_bio() inserts a request
into the I/O scheduler and runs the hardware queue asynchronously. Now
that __submit_bio() no longer opens a plug around every bio, this path
is taken by all unplugged I/O to devices with an elevator, such as
io_uring submitting at most two SQEs per io_uring_enter() or synchronous
O_DIRECT reads and writes.

Each of these requests queues hctx->run_work on kblockd. kblockd is a
per-CPU WQ_HIGHPRI workqueue and blk_mq_hctx_next_cpu() returns
WORK_CPU_UNBOUND for single-queue devices, so the work runs on the
submitting CPU and the kworker preempts the submitter once per I/O.
With fio (io_uring, 4k randread, iodepth=16, one job) the submitter
context switches about once per I/O. A single-queue null_blk device
with mq-deadline drops from 289K to 193K IOPS, and a single-queue ublk
device, which defaults to mq-deadline, drops from 265K to 113K IOPS.

Run the hardware queue from the submitting context for scheduler
inserts, as flushing the per-bio plug did. Keep the asynchronous run for
the hctx->dispatch_busy case.

fio, io_uring, 4k randread, 16 vCPU KVM guest:

                                                  before     after
  null_blk, 1 queue, mq-deadline, qd16              193K      289K
  null_blk, 1 queue, none, qd16                     354K      356K
  null_blk, 4 queues, none, qd1                     356K      358K
  ublk (ublksrv null), 1 queue, mq-deadline, qd16   113K      265K
  ublk (ublksrv null), 4 x 1-queue devices, qd16    290K      852K

Fixes: 9cbbac29d752 ("block: Remove redundant plug in __submit_bio()")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3e..54eff3cf45fae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3200,8 +3200,16 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	hctx = rq->mq_hctx;
-	if ((rq->rq_flags & RQF_USE_SCHED) ||
-	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
+	if (rq->rq_flags & RQF_USE_SCHED) {
+		/*
+		 * Run the queue from the submitting context, as flushing a plug
+		 * does. Punting every unplugged request to kblockd lets the
+		 * kworker preempt the submitter once per I/O.
+		 */
+		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
+	} else if (hctx->dispatch_busy &&
+		   (q->nr_hw_queues == 1 || !is_sync)) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
 	} else {

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-bug-blk-mq-noplug-sched-dispatch-4f19360b0bf7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

