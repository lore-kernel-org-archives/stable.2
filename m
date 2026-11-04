Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817820;
	b=umUh7FH3VGA8UT5+y2fu5Stw/4StQR57CzLs+M58I4Kd2+d/5Hl/V5GnUQWJUNELdc2j
	 L/Avi+3HjjPnTqaa7d6JhJuu8CK3PB1lCgyFuu6PTxtY4IgOwAw0KGq62xeUcNM/tye4B
	 MK1ehkLeozq/P7beM+Eku+TXEafJtCp2llBxi8ebd7KqTYtGZuwtIdIe59SjXu5+snuTe
	 A7y7vNEGL6r1f2JqGiw1lJ/3rO2XMF3tG4nXn+cvWJPTPUDSPcMzptgZEZgG5yVZFzKDO
	 Wt6rkBxtaOURynqdhqQ9Pa3X8e0I0p8SGLfK04AaydLBdw6kO3eN5gpT6DU3xVnwkxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5AxT1BpVeSrLCiMqkpS9d0F1mloMRuaOQf9qAIdtG2A=;
	b=GbUgQF4ywwR3f7qwsiEzTVO2Y3vJGB3gud2AVuwDfVH7jt2bU5RndKu3YaCWqTI2daMI
	 TyDviNwVr4ki+bM39kS4wPl5Tjg8RM2J36FRR/QEUMoNhmS458YYlKCelHP8w2p/T3wNg
	 SrgF6K7KeUfEOttkJQgSx6PJeCkdEBnqOsWX9J+iLEkjk8iuhnaIJ4jG8kIdf27umU0a2
	 t6HB6ITDTZODfvFJb7kJPLEAyQMA8ntuL4vFiDacFHA3J46VSmzyBFsKEX0Hh/o3Ig21X
	 g5PVLWs+ICIZJBmPUDAzb1JQ1TmJTHPXfbjndtrGyxxx7Dlr0/Cobu43xLehfMKU6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="q/SplfxA";
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q/SplfxA
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-854b6e2e41fso591702a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817818; x=1794422618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5AxT1BpVeSrLCiMqkpS9d0F1mloMRuaOQf9qAIdtG2A=;
        b=q/SplfxAIei3hnuIiXFTAxtQmc9R5w5xYxC50hDiWHmXr0QxjqVBk/gXDxIR+GmgKu
         MroPTES0NPVBDgp6a07Wd9sib3QqrCSLnx22nSUCLGwVH46kARreeOLUquaZy9VSuF6V
         PKIM1ikeTBozrY0bprRurGbPo4kMz47jEH+cl3vphk8Keej29sNvmNjKeB2272yzHC17
         iifyey8auxhYMnHxG8EYMoI7f8jkII3YlJdLANRreoPDtGjvmKv/vdoOD1kXob2+qOzA
         FAT1xhUifPe6+AoZCb6LKjXDSh5wvpda8IBm6O+vvzPvsT5PFhDD+A/olS8oP/VkBFja
         BzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817818; x=1794422618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5AxT1BpVeSrLCiMqkpS9d0F1mloMRuaOQf9qAIdtG2A=;
        b=IMCLiAP0Bk26PV+VDB0x5RR3g/+y90Eow7cuQvnuVHbQ1RqZgtd3lIlhP1Is8l/WhU
         tnhMI60nZVQ4lnpgIhmb3drl6eYYj2579Or/hvyZ0SbhmhO0jaYexD9nqq205EQ2W918
         cOfJ/WUmiHQd9D8Rfe/JRjY25XdJ8qtY+gLD40EMPAFkSSU7hlGsl/ckNNeEZ+/oYyQk
         CaWKzvRossfRRx7cwaCoFo6abSjgF3b27XySG/JGkDL1/3NTFbbPgOcJY+JiA9Dnsiyc
         sO9MfjNNnyn9kLqmA0eLc1g4BjXiHVdbczvOh3eCgBxQFvFxUBijkFYofiXUvVro8v45
         vPZA==
X-Gm-Message-State: APuU4Z8uHM7LIpM6ERNMu+UChzaIP6MmTG7xm5h0+qxxIc5dSap3gtsp
	o/r3BrfoRmeEs/HcoK2jKvl9l/V/OdMVpWmx4NXIrdjFFtE7HfC/PvM8gJt5cgnSlMlUwoIYKH3
	1ewi+NaE=
X-Gm-Gg: AYBFou2D30T9OdysOO0ohGOxxeXTSMhFZnpMc20tPMRLkeFVQAP1swMUUxgeNPDfrd6
	qBMM2xHXdQGXBdTdFmZwSj5p/g/WyrFztcq+tL6Mckl0LyviasS6zi8fCPPittLKqNDaTJ6pqBW
	DCpjK2b8YhzCMZg5CBcFz7SCsFnKJML6V4VQfnkFEEMXucmRBUYpa10fLmPb5ipzveNf3UQSc6P
	BCDyn4tFqi7CV0Rs9/3k4zwTwIFjbVJx4Fe20R8+FL/FglKvJ7emI0xOvMyzTIqRZQus8T89CbV
	50AJz99oCMY64G1F2SeFJrZardt7iS8lE6KYyyDrZ0tJ6QzUN+0K57p1qZ+YDejN1m54cUESpzZ
	E7IQP0A93n7JcnLtwb+gzDKMmIxcGMn/B8tQdpUWtuIETg79oSwziQqgcoETnxHlvkuTEULQ3fO
	YCEsKKucvvxy1yYnpnNkX2uMXzJAhCGZVPYbODG/10lwKvYUVepGD3hejDB/LXy05EjV9FWb2T4
	590nEaO2YJ1CUJdwkhEFD8V1wZ+L5zASdVF0OBSoVvTEFMggRVHfLVM2ykvp1w8ScmDEnAdyCls
	ZZ0hs3BwrpoSoCr+avY+5qX3yWZ8hg5QbRvO2K6uQWcPalC3NhHYECgmCp0aiUFWq941/iAQnw=
	=
X-Received: by 2002:a05:6830:4409:b0:80a:b8da:2792 with SMTP id 46e09a7af769-85d364ba53emr13727130a34.6.1793817818521;
        Wed, 04 Nov 2026 10:43:38 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 7/8] io_uring/sqpoll: don't wait for the thread to exit
Date: Wed,  4 Nov 2026 11:43:27 -0700
Message-ID: <20261104184328.516206-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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
[axboe: 6.1 has a single exit path in io_sq_thread(), drop the thread's
free_refs share there]
---
 io_uring/sqpoll.c | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h |  3 ++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index adc01f65464b..2cbe580d76af 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -52,6 +52,24 @@ void io_sq_thread_park(struct io_sq_data *sqd)
 		wake_up_process(sqd->thread);
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
 	WARN_ON_ONCE(sqd->thread == current);
@@ -62,7 +80,6 @@ void io_sq_thread_stop(struct io_sq_data *sqd)
 	if (sqd->thread)
 		wake_up_process(sqd->thread);
 	mutex_unlock(&sqd->lock);
-	wait_for_completion(&sqd->exited);
 }
 
 void io_put_sq_data(struct io_sq_data *sqd)
@@ -71,7 +88,7 @@ void io_put_sq_data(struct io_sq_data *sqd)
 		WARN_ON_ONCE(atomic_read(&sqd->park_pending));
 
 		io_sq_thread_stop(sqd);
-		kfree(sqd);
+		io_sq_data_release(sqd);
 	}
 }
 
@@ -153,10 +170,10 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 
 	atomic_set(&sqd->park_pending, 0);
 	refcount_set(&sqd->refs, 1);
+	refcount_set(&sqd->free_refs, 2);
 	INIT_LIST_HEAD(&sqd->ctx_list);
 	mutex_init(&sqd->lock);
 	init_waitqueue_head(&sqd->wait);
-	init_completion(&sqd->exited);
 	return sqd;
 }
 
@@ -327,7 +344,7 @@ static int io_sq_thread(void *data)
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
 
-	complete(&sqd->exited);
+	io_sq_data_release(sqd);
 	do_exit(0);
 }
 
@@ -448,7 +465,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		put_task_struct(task_to_put);
 	return 0;
 err_sqpoll:
-	complete(&ctx->sq_data->exited);
+	/* no thread was made: let go of its share */
+	io_sq_data_release(ctx->sq_data);
 err:
 	io_sq_thread_finish(ctx);
 	if (task_to_put)
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index 36245f1afa5e..3e41db84014b 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -2,6 +2,8 @@
 
 struct io_sq_data {
 	refcount_t		refs;
+	/* one for all the rings, one for the thread: the last put frees */
+	refcount_t		free_refs;
 	atomic_t		park_pending;
 	struct mutex		lock;
 
@@ -17,7 +19,6 @@ struct io_sq_data {
 	pid_t			task_tgid;
 
 	unsigned long		state;
-	struct completion	exited;
 };
 
 int io_sq_offload_create(struct io_ring_ctx *ctx, struct io_uring_params *p);
-- 
2.56.0

