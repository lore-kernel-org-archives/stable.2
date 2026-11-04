Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817935;
	b=LLpy8v9scZAnLEbR/NgiLqs2jt+wnX2q87iFxYMI1NSgboRPtwiUhkmEexcmG/KJwnoA
	 02Qpyxj5TR0tdgLN/4ZHbV6RUTKtL1O2VzTJKYvmo9sLFk2ie84fFHksR2c2IWt5RIprr
	 8gJkeP2r3eT3kvSNEoYA6LfqDXILrwATy3f7bVgUFXd1bp8Y/uAQv2rvVm/gqfhK86DEn
	 +bHi0rsNYTEqtKpO0hLIG83ZeLrdoTkileDSkHVooRqCVz97GnmU5qkIYFRRan577ghNs
	 meIl8HXTIUuXWtCUta88MF/CyxuhSyHsSVdv/vpF5+uzUVAy2nI/E+EAtCxQDr68P7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9OQph0jAVZeKRWO6RrMZz/p46DO9MhcGziRv+wPL3Z4=;
	b=PPOLGCeVqLwyUUVpHXm2oo0UY+2OyKSV053wOflV2KEmst6NgtE6AzB/7/OUxxt/BN+W
	 nppvRFKCGzzu/ga/neV4VYPYV2+XMvozdTgc46vPqnrjDmViNcHEXM5EIhgrmeCN2atLo
	 wxgwQn0avtIxTzRIK4qajHvXRYNMryEPGjgoMtFApdPpQEtj4bgJBlFOmDF3ahoE095Y+
	 gKiy6r8CvWAVUbOLdUHoU0hkIU+RkLGE1fByVa6MfTIkmrhBjZA6gCuyso1kxsAkHVe1O
	 Yqtl1o5q2YPpk9AXi63226osb7YtmRl0wshl3/sMHq74tYW+Ewt1jJYjjvF2PjxWnTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HdP7HOKX;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979F606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3979F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HdP7HOKX
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a71d0c4233so540801fac.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817934; x=1794422734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9OQph0jAVZeKRWO6RrMZz/p46DO9MhcGziRv+wPL3Z4=;
        b=HdP7HOKXI1y6YLUtuvxUbzxmZ3/OYEdnw+Yn7iHvZPJKtYQzChft0NupxE3dn1IPo1
         AnHgLKTB+YD7uVxU08cu0Du35q/eAlKtXGSOQKO0c6R/MjccLGNsS9z4T4Bp9tmuKedQ
         BBDLA5bZMfmz2WW9nVjlVge7fX8BE5hzK8pBhnomEXtQiLAux4fnazPr2o7XBDgXXT/W
         YLWNKo7HTrIc5oBoFxTPlAuOhpKHFRxIFz2CNloAjj+iGRRwYCttNVSz5KdNa4NF9sn8
         LFXQ8a7u40AatI4s8rrN51ffmhTXc96A0RChqHUmDwhzWB1RzNccIvX+tqc5Mq46o8en
         qcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817934; x=1794422734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9OQph0jAVZeKRWO6RrMZz/p46DO9MhcGziRv+wPL3Z4=;
        b=GURcBqEVXH7qKzAlw7iY4/GrISdmHp3hMeT2tdVqq6uZmRAu87xKim+6wxyFn6HRqa
         gh+uNTNCZFQ4Lgbt+EBqHr6b8nBRPA0Yl/YV1sFv1Z2Q5lrH6EjgqCjflBdac3OqvzOt
         zvCZ5hQj3hUAYe5prAQeSDytXO2r1gQ1wrNNAoIThZyBD3VISG/GDIBfUgAegvKyVshL
         cjOVhdNdnF5ALaMFtULLVPzAE2VLh0tcvsM25szluGean6ng1UiYTMsif28GpfYv7lZO
         wi3W+AAh3g2yyqVrAdx3nB+vehP5clyjZCDZW+J17hM44jnY+ITud9fRvBFDmhQoqWN7
         Q+AA==
X-Gm-Message-State: APuU4Z+6ntscCQaQCVxZCbU1OjWjsDW6L9OEh5HeOYx0GpsMhmJmz6M1
	Vb3Qr5sOX31FgfMB8isOYaD1piKqIGo0tQZag7jmBgATtFKnWu/OkOwVFWn6l0ZG5QN3KLLJN+w
	KszOqnug=
X-Gm-Gg: AYBFou3dD2QzkPXAvA3xP/N9inn+WZzdPR3mpM2LeLia82LTT2aq3Yj126DHSQgP4XO
	MUqvIebZoAfhMUIUjOyt4KDMEoHVK/64lNThYngtv5ipZrC5u+2tufEydTq99bzvmop59MAq397
	ARYRvXSK52yNkBuQA4bJgj6JJ0TJhaS3uhjPkvR8OveTuBJw+ZPuI4VDblJKFZFigpT1CeGEnax
	YzAy2wfT805yNZcbZi0gQ/jhLf+ASn6Ofxyg3EnWslUkMw8GSgtqzAQ/qKaKe4T1L3aVFhOb7Ta
	QOtXTGUFkDR5b2KPR/NXTNGOtUtcs0fGYZmB1oEtmT22z1ocYGZ2QWLSopNh6ySQajt67++Jbdr
	XHxxFZHmMPvxwLdKwQdpG0tuXxZ1BAsT2YjwMiCpVXd0Ovzk0vus5WXMURa9srrSLmdwZSMAHbZ
	44WOrrjvwejnMzsLLxYfakrJ2zggPMurquZamzTDje/ix4HshMGW2iDWwujJPfg9jmqB2dU3D4X
	J747GFzGHKLm76bRDHYqBWqHqFqG04uQoHLP0d1vy0MuWG2d8VCgXMCeNBgSfRZPNEqokTaH3Jh
	Wfr9w/zVjJhMumxG3kqY/p4bwHxJFdvspAboB15UYGGDvdSSDleVQhg/KgvNIVV2EeeNGMP18Q=
	=
X-Received: by 2002:a05:6870:b3ee:b0:4a7:2ba2:61e4 with SMTP id 586e51a60fabf-4a90767d276mr10836615fac.32.1793817933624;
        Wed, 04 Nov 2026 10:45:33 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 13/16] io_uring/sqpoll: don't wait for the thread to exit
Date: Wed,  4 Nov 2026 11:44:44 -0700
Message-ID: <20261104184447.516768-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit 360395e8dbf9d23579f74b84a1af11190813b0f8 upstream.

io_sq_thread_stop() wakes the SQPOLL thread and waits for it to exit.
The thread belongs to the thread group that created the ring, so a
SIGSTOP or the cgroup freezer holds it in get_signal(), and the wake up
doesn't change that. io_ring_exit_work() then sleeps in that wait until
someone continues or kills the process. iou_exit has 64 slots, so 64
closed SQPOLL rings of a stopped process keep every other ring from
being freed, for everyone.

Don't wait. Set the stop bit, wake the thread, and let it exit when it
gets to run again. The sqd can now outlive its last ring, so give it a
second refcount with one reference for the rings and one for the thread,
and free it with the last one. The thread can't reach a freed ring,
rings leave ctx_list before dropping their reference, and the io-wq hash
is refcounted.

Fixes: 16efa4fce3b7 ("io_uring: allow IO worker threads to be frozen")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h |  3 ++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index ee97808a065a..49c52284ecdd 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -63,6 +63,24 @@ void io_sq_thread_park(struct io_sq_data *sqd)
 	}
 }
 
+/*
+ * The sqd has two holders: its rings, as one, and its thread. Neither waits
+ * for the other to let go. The one that lets go last frees the sqd.
+ */
+static void io_sq_data_release(struct io_sq_data *sqd)
+{
+	if (refcount_dec_and_test(&sqd->free_refs))
+		kfree(sqd);
+}
+
+/*
+ * Ask the thread to exit, and don't wait for it. A thread that is stopped or
+ * frozen exits only when a user lets it run again, and the exit work of the
+ * ring would keep its place in the workqueue until then. All rings have left
+ * ctx_list by now and have no request left, so the thread can reach none of
+ * them. What it still uses is its own or counted: the sqd by free_refs, the
+ * hash of its io-wq by hash->refs.
+ */
 void io_sq_thread_stop(struct io_sq_data *sqd)
 {
 	struct task_struct *tsk;
@@ -77,7 +95,6 @@ void io_sq_thread_stop(struct io_sq_data *sqd)
 		wake_up_process(tsk);
 	}
 	mutex_unlock(&sqd->lock);
-	wait_for_completion(&sqd->exited);
 }
 
 void io_put_sq_data(struct io_sq_data *sqd)
@@ -86,7 +103,7 @@ void io_put_sq_data(struct io_sq_data *sqd)
 		WARN_ON_ONCE(atomic_read(&sqd->park_pending));
 
 		io_sq_thread_stop(sqd);
-		kfree(sqd);
+		io_sq_data_release(sqd);
 	}
 }
 
@@ -160,10 +177,10 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 
 	atomic_set(&sqd->park_pending, 0);
 	refcount_set(&sqd->refs, 1);
+	refcount_set(&sqd->free_refs, 2);
 	INIT_LIST_HEAD(&sqd->ctx_list);
 	mutex_init(&sqd->lock);
 	init_waitqueue_head(&sqd->wait);
-	init_completion(&sqd->exited);
 	return sqd;
 }
 
@@ -424,7 +441,7 @@ static int io_sq_thread(void *data)
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
 err_out:
-	complete(&sqd->exited);
+	io_sq_data_release(sqd);
 	do_exit(0);
 }
 
@@ -544,7 +561,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	}
 	return 0;
 err_sqpoll:
-	complete(&ctx->sq_data->exited);
+	/* no thread was made: let go of its share */
+	io_sq_data_release(ctx->sq_data);
 err:
 	io_sq_thread_finish(ctx);
 	return ret;
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index fd2f6f29b516..024a51dc3069 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -2,6 +2,8 @@
 
 struct io_sq_data {
 	refcount_t		refs;
+	/* one for all the rings, one for the thread: the last put frees */
+	refcount_t		free_refs;
 	atomic_t		park_pending;
 	struct mutex		lock;
 
@@ -18,7 +20,6 @@ struct io_sq_data {
 
 	u64			work_time;
 	unsigned long		state;
-	struct completion	exited;
 };
 
 int io_sq_offload_create(struct io_ring_ctx *ctx, struct io_uring_params *p);
-- 
2.56.0

