Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817850;
	b=VsC+WNqs5k8salsJhB5jnN9tzSJ7RidyGoWZ2Y5JusGzyr5BYtRV87vOdSrSDg12Lnl/
	 GKI+ufI0Tsyp5O+m/3z3OHd13Y4gXT3Z9quDrW72Q1pgdDY0pZ4dsGggRAT5/N9acCy6M
	 0HCOFAZtX66F6HDR6hOaYK5IGBe1oNBAVuRw/ZuE3bS/VmZRfK0SQRZvnFQjI08kjYf6e
	 W3tYtft7SdK0N4cd5Cr3u5GLZHTg/04ocWSCZybwadTULEW7A3wrHhb0GNvUAiQu9f8Ps
	 WzskZYm1rf0YkJZaz8NCjIgPG5GMRNyrvjGW1bqOeNFLeWRZSXmdHPUU1rPA5gWnDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xoIilvu2rTirIIGum0SSbm8sRy8C9o23FQK3VbYU0J0=;
	b=KHx8u2rK+TD7t9pqZ3SlKo6D3udBNTS+iMewyAVSWa0etvH2PTRfYIs98lpFbYYsYptB
	 KlDccEFDzBlUWrpqq0xY2ZWpg3OmyvMfmNMtRFf73dmQ+6ly3qAzsc+dsK/d1XvOTqMoK
	 ooaqlFYNLcpm+icggcXnhf+goRki77ldCUpfQLHidfg5/FF47xkUD93yrtH1pbWfF7dz/
	 N3MoWWir/1fpu2vjK3+oZk3arY+O/F5NkcgUo1Lh4MgA9Lcat1yGfrJs849DPPjZFm8gZ
	 2cBaKXxkyMx/UawQxEmDwhPC/uAv4oZKZPv5VYC6R1CI14zuuQfkoLZSQUmpiu2VV0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Od52n/R4";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1169606A33D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1169606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Od52n/R4
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82380b0f55dso464685a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817849; x=1794422649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xoIilvu2rTirIIGum0SSbm8sRy8C9o23FQK3VbYU0J0=;
        b=Od52n/R4vRHQWCY8bXiA8gI35vES77glrAwJKDjTVXMAhooWTI8/1jrlok6bCcYUc0
         F6/RT6Dv9uKK+7PZD4SKFXE8BbE6kV3B13LEBorMVt03jIX98VCuaVXv0x9Z5VM1j2oz
         ko/Qcp1u66SWLlR32bc+9pjP34RwyL3tDKxxMU85+1Vl5gAcKWtIoRbySzEtniW1G+b2
         Hxsio5HuwLBPTuRo196UiWIZf6/U0CQlBt3jVo0QTE0pXeFIzqOPdirwVAy9b7pZJL6m
         I8UN3T1xWswHNeNMpOc69JN5/3pHu1R0jkSBpr3pylihrKSsgtBCPpTmmtwfjB353mCz
         ml3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817849; x=1794422649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xoIilvu2rTirIIGum0SSbm8sRy8C9o23FQK3VbYU0J0=;
        b=XWnxrUqfdeOAfV7vqIa8MFDP3yiW+FH+MWnrZLArQGSzBjrhm+rBnfKvM6wLe7jN72
         7PdppPTLYnb0th3jH975BAFp/mTyalAPxYEWtZG0C/mbq5dbP11FBwcTYrGcxgiyRMNh
         f43fdKO5WuKT0xCyyw+vwL1rr0V15cjvzxxGXioQgAIE+ZoKK77ZLC54/ozAkw9g4WD+
         secTdnJyvfx9a5mqBgPdZFSQ5biltmH18cMa0FfC9YKgeZ2kN81cvJ4eZVCJQVWyY2uJ
         5AwT/AZH8l/pXfZloWkzWrRe5LapRCD/pwWSMzS00sLhDWZdqb4oIOTBKT/nYv6O2TnL
         fatg==
X-Gm-Message-State: APuU4Z+sAdzY0eXe+vVVRvRNkdt13Efe36jAe6wY+9fPJZK+PV1rP33s
	EC2IyITEOgFim3oCt00fc/jXNrvOZKw/HmNA9EJihJo3Bej7RrPFY2P53u+e/TwA+WFkEboa36B
	M8T9Xd50=
X-Gm-Gg: AYBFou2cwJOtX1zHEiQ0VgHU92G35xR0vEDrBxu5Ue3HwCE+rUCoG7Uzlcb0VBM176f
	8+7awakKSNTeKuDNgxaBoTGOk4pPminMqN1j+ilppPLeMekFZwfs8lPeD46j1ZusO07KoQE21RJ
	kh5U4mbUCEKDRoMKuWClcqXcTEnF+nX6ZGMGlhRDXRPFQsCu1QzcUyg+JSMz+lO8xkwPsl1+CiO
	333l/e0Kp9IDgXtG3w8W7yZHHI0U5T4vvJ5BDUttL0tlBDRBiBnhvBZkKx+CfKxVHlFjTfQiTxY
	CYfIPtJsfOrmIbzdI9XbZa4q/69QpfBofjtsuPCvttdGum1tyBp4ClnoP9iU/3P4s6M97TyuPB3
	twpqXgsqmPsz5GezWjQ58HhjUxuDnUJtkAmCdEVvveRMfcPXb3lEiO0l4vRSWE8MuaM991VKXcs
	T4M9/9PDEFM3WrZTCyaP8VKYgn9BQ9j624q8DTEcGm+Vt94arGI5dy9MNvhZSvYTeMGO3IJxeIx
	qq7NZpZm/yRVnzgTeromtL6KIfaR8+JymXsymQTwRLCeMWMzBD0UQD0SA3EA+VKViAiHiqkciVF
	sydu9P/M4vYy8L1UD7EtyxE+UVPy4Q3YWMRBBhuz4sd+hWZWd74ZGMdWL9G4sMKIpfR+izenFv7
	x88LfpmR9L5SnPXPAukc=
X-Received: by 2002:a05:6808:198b:b0:53c:5052:ea07 with SMTP id 5614622812f47-5640d917e96mr13518649b6e.5.1793817848722;
        Wed, 04 Nov 2026 10:44:08 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 8/9] io_uring/sqpoll: don't wait for the thread to exit
Date: Wed,  4 Nov 2026 11:43:52 -0700
Message-ID: <20261104184353.516403-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
index 1ea2e35e4ce8..696aba6bbf81 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -59,6 +59,24 @@ void io_sq_thread_park(struct io_sq_data *sqd)
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
@@ -73,7 +91,6 @@ void io_sq_thread_stop(struct io_sq_data *sqd)
 		wake_up_process(tsk);
 	}
 	mutex_unlock(&sqd->lock);
-	wait_for_completion(&sqd->exited);
 }
 
 void io_put_sq_data(struct io_sq_data *sqd)
@@ -82,7 +99,7 @@ void io_put_sq_data(struct io_sq_data *sqd)
 		WARN_ON_ONCE(atomic_read(&sqd->park_pending));
 
 		io_sq_thread_stop(sqd);
-		kfree(sqd);
+		io_sq_data_release(sqd);
 	}
 }
 
@@ -156,10 +173,10 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 
 	atomic_set(&sqd->park_pending, 0);
 	refcount_set(&sqd->refs, 1);
+	refcount_set(&sqd->free_refs, 2);
 	INIT_LIST_HEAD(&sqd->ctx_list);
 	mutex_init(&sqd->lock);
 	init_waitqueue_head(&sqd->wait);
-	init_completion(&sqd->exited);
 	return sqd;
 }
 
@@ -426,7 +443,7 @@ static int io_sq_thread(void *data)
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
 err_out:
-	complete(&sqd->exited);
+	io_sq_data_release(sqd);
 	do_exit(0);
 }
 
@@ -540,7 +557,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

