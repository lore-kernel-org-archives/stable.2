Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF936B922
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029143; cv=none; b=Nv96Psy/NgnuYB9vxL4GkDXsFpmJM0eEr4ezbb5tbZSjnoYwpz4o+BAzkzgMDUn0KYMlZ4PuldGm3SHIf3QcMhhMHEfjViBtH+RMXApRftEu5CqSOyvJk3t27WgH91x1iUP3pUPNTdYVXAGO8/0cuurX5EZ+fDMhU/Oi3Vc4j9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029143; c=relaxed/simple;
	bh=bFrgvj+de3selRQge+2zrsIXpmJFAWy1UibRaUF4G9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UuWuMc2+BUjqeyoLR44NLUllNf+1EFiQp6B/WO/rXb/mow3geduXnx1sPOHYLQtdZaAlk4qi/UNJl5Ko8mftZ3235XvaMSpfRZZZuKpFOg9QwNjzaxknLO82tyY/Mq2CvCaitQ071soTDs9P5X0G7uG3nmGnZ4XHfU79niQeAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWelmWL6; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWelmWL6"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5032748eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029141; x=1792633941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9hVE7odX7S9N5tuemqcf/5aS0JWCqfMdUhNBSrDt5k=;
        b=eWelmWL6W4Vlqh85ZXlyunXFmg0zdvQU9Yd3QqaLiFDaKAArANan7zDJGHU9hWmPs1
         vo7qEDP6gJf/OMdmy/sS3n4idpCwMLvrjK7G4vqhn914hlcZV/hBrZoH+gqALQKxB3ZV
         bpC+l9Ax1XGhswvifPyIgzJzh0x84qUOxkBeIlUcCuu2WD72XJ9QwmF90HrhI4pjqCWR
         QWj5I9by1z9UhAqsx3VdZcZ+4LiQgrxqcUC/Fl1hC9djbLUejGDx00dFXaq93pQdLUS0
         Y60OhPQq4TVmyauwmYI3S0ez4PlfySnkhiAJTCvId/E+h5O0yE2uuEgFgTc/qxCV5xbh
         Q1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029141; x=1792633941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9hVE7odX7S9N5tuemqcf/5aS0JWCqfMdUhNBSrDt5k=;
        b=qk7vZdRO4h2Lno90WgpCAxFOX/lwYlTbpYN8tXh84KIdypFYCA+Hat6FlHnNnpAvgb
         pr+BytSdA5Pm79xMwVOWUblYyLKH+lSYrryOhsvuKaCzKv1D1giXC9vDpgfUo6CL1Sz2
         5MAxxTwQ5pGHk/kt1kXKSmp/nt78E9UrXyXMkl9rmSrB7yArK8r9CzJcf8ECzzrr4aEH
         T90ejCjoKjzmOXj41AjphddgsM1VdiljjgJ4CYvR3tmYfrIKuLwXsSul1bpzv1xh2YSz
         hM+7jcpW+V0q4gxSPe0KxUpKbk6h2ZuBmW2a6ZKBn7JitcaJve3PqbAThOhNB6FYHQgS
         yXYw==
X-Forwarded-Encrypted: i=1; AKwUvBxrhO8CvvU98KDbBXz5u4YNeeftmm5lin7Fpv9A6bYyiKjL4VVyGJVi1+zHuuezTF61IuY304k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoQQ4HCwguKZWYajZUl8anj01z1H2O7BGb38/+wYMDg+UA8MmE
	pLNOPjo2Z9aCOgQUYtOE3kVc0DSl1bEVWNBB/9gh3h8Z7PtVPkG6/J0J
X-Gm-Gg: AYBFou3uB60BmOQF8yzfdjUX+fwsgfekJzT2cPlVMf2YoIsX58LxACniBT01iXud5zN
	VlK7ZlzhZHwY5rOHRnMekdsLtF3LJzRCn4+1UQC9zM8snTKkIIlIcWw14x59fNa+QBEWeTRWQm0
	AENAGHWvPiHDR6orta1Dok4gv3M+w0xbJB1LP7l2AHOd3wnHrE1iUI09zSJU+AyjEjinUllkM/n
	kNqT1kx/8/ZbArvItBkXgZsyuOrvcg3LOKPJXeXkyTow+x4wttMipMfDLES71v3Syc+qTlFnkjx
	0fK4Q4E95bwt6qt4IJbFc12gdAHU+Qh5qx8qsca0dRSbT+7cWTE/2Yi3NtQjmUyfW0uC7aLTjOY
	0MJmcXlOinPY2f7fjKSj+wS/WerreCaR62ADGIMad7y344of1Pd5viI+WhpweeBACLV+wigWkwC
	+5JE6DN7VPFRw/qEZbPOTysalyy/rxaO7342ghw+AtZZU2QrjL6Guh3bJr4AVNc3h+0g==
X-Received: by 2002:a05:7022:5f05:b0:144:eb46:be0 with SMTP id a92af1059eb24-16a5fc9171fmr21649087c88.13.1792029141115;
        Wed, 14 Oct 2026 18:52:21 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm50647870c88.2.2026.10.14.18.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:52:20 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 15 Oct 2026 09:52:15 +0800
Subject: [PATCH v2 1/2] block: don't quiesce the queue when setting the
 default elevator
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bug-block-elevator-init-quiesce-v2-1-505a2b0b1c07@gmail.com>
References: <20261015-bug-block-elevator-init-quiesce-v2-0-505a2b0b1c07@gmail.com>
In-Reply-To: <20261015-bug-block-elevator-init-quiesce-v2-0-505a2b0b1c07@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

elevator_set_default() runs from blk_register_queue() while the disk is
still being added: the block device is not visible yet and uevents are
suppressed, so no file system I/O can be issued. elevator_change()
freezes the queue and cancels the dispatch work before switching, which
is enough to drain dispatch activity from passthrough requests, as the
comment in elevator_change() already states.

elevator_switch() still quiesces the queue unconditionally, though, so
every disk added with a default elevator waits for an RCU grace period.
Commit 245a489e81e1 ("block: avoid to quiesce queue in
elevator_init_mq") had removed this wait from the default elevator
setup, and it came back when that setup was folded into
elevator_change().

The wait is paid in full by callers that add disks one at a time. ublk
adds the disk of a single-queue device from START_DEV, which takes 7.7ms
at p50 in a 16 vCPU KVM guest, most of it in blk_mq_quiesce_queue()
called from elevator_set_default().

Skip quiescing in elevator_switch() when setting the default elevator.

ublk null target, 1000 single-queue devices created one by one:

                     before      after
  START_DEV p50      7.74ms     0.68ms
  START_DEV p99     14.61ms     1.32ms
  devices/s             114        971

Fixes: 1e44bedbc921 ("block: unifying elevator change")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/elevator.c | 7 +++++--
 block/elevator.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2161b6eea680c..da9ba70ac9321 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -573,7 +573,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 			return -EINVAL;
 	}
 
-	blk_mq_quiesce_queue(q);
+	if (!ctx->no_quiesce)
+		blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
 		ctx->old = q->elevator;
@@ -594,7 +595,8 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
 out_unfreeze:
-	blk_mq_unquiesce_queue(q);
+	if (!ctx->no_quiesce)
+		blk_mq_unquiesce_queue(q);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -731,6 +733,7 @@ void elevator_set_default(struct request_queue *q)
 	struct elv_change_ctx ctx = {
 		.name = "mq-deadline",
 		.no_uevent = true,
+		.no_quiesce = true,
 	};
 	int err;
 
diff --git a/block/elevator.h b/block/elevator.h
index 3eb32516be0b1..3886d97427e33 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -43,6 +43,8 @@ struct elevator_resources {
 struct elv_change_ctx {
 	const char *name;
 	bool no_uevent;
+	/* the disk isn't added yet, so skip quiescing the queue */
+	bool no_quiesce;
 
 	/* for unregistering old elevator */
 	struct elevator_queue *old;

-- 
2.43.0

