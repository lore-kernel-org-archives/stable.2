Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817832;
	b=5t/lKwvJkj8jAuXqih9eqLywYc+3SOBQiYZvQST7y/7eHNRdprlIE/T8C9ARe+qp/nhM
	 O4jqra7a8trhGP40QUGuzKK7VpoqHclAIMIWyOIoRhmIhb4ovpx6/LaWZ3iPHHIhW4v4b
	 9S5QW95Y22PLPwK6RDbFtM8Q3PvXVgm0taKA86IO9yDx5eIgi0RkOVKB1ypuBPUQuqtUE
	 X1eJyLxV/wvIpqgcqFMTzYwZoodAHUBzKRJRzNGmMLXCSpuhzQnta3A6MWNnyyucSM/9/
	 5M9VvbD/Or4AfpMd8CEbeNLhRjDraV3I8hxZUtdmrITUR4s2Bweam2VniunOQ9dzyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mywgPhGzUVt8EHl6WxnjSBDUemfQJrNeqoS9KdVNKH4=;
	b=tO30WGzOuBgsRniQCvekPj+hk1dWLnR8ITISP+1H1OF32ZK2yz5buhidBMocIg2seobH
	 2ADlcJyLctXIWUAalJ75qOMLvZW+ygRg1i3TLhH3SS0QgpPd7oWDd4OKU0Fg3h2xmE9Uf
	 bVEnhNA/3+kKa15KwIe4TZ7UpXe7nWMkPLwPBhbP5TvWxT2yBoRGVD/Ia7xdtBZA+AFyL
	 XcpUrs81c8yCASf5d8WBh2Y/Fxwk0cbc6DXu5vQTcNKhjTZXMOYI68Lh4IB8KA7P5jlzc
	 1RzfVcKZ+Lx4YjpGr26Ko1lmJcazkk0RYR7cTFpzvrTGn/MGwCheEdKDwf83/n3L0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e+lFTaQ0;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06570606D826
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06570606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e+lFTaQ0
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df0b02fe91so1415645eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817831; x=1794422631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mywgPhGzUVt8EHl6WxnjSBDUemfQJrNeqoS9KdVNKH4=;
        b=e+lFTaQ0atUnuxykBsWC/ywZjA/XU8Dn21JIH4LQTfpfUPc9DE8pMKaW4remxGDQpT
         Jumw1bMa81jfw9wMlO1cVnrZBFjXBaQw4elb8FUbyrGVHDkgTxGgM3YXG9kgbHIukQh7
         sh1Kjddyax+HB1hz/gtdNcK+Tzxc6RJ+p3Njsv/s2c+951ef7LmVMTU58hSr/0WWTRRA
         0+aNUciNuZVd/xEfuNrAC+esa1Qrfo9VFiEOBUEWQkGld2EqXRfsp6fxYiU8H1CBdZn9
         z9+QKhWJv2sM1NXg2YvBSo4lMmF/JEoYzNB9OYObagTb3VrA8XEKXn+wMOKPEOLa9/4s
         Atwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817831; x=1794422631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mywgPhGzUVt8EHl6WxnjSBDUemfQJrNeqoS9KdVNKH4=;
        b=HEkqREzDeY51FIGre48ngXaIjfewk4LVuBYxIi8Plk+tRNArg6ysE6KwAgtJttgsIX
         Jv0g3/DXGxWcfYqLpGngnz44u8XFXoIIy+zTSBbcTjwSStiWcp1OTVJlG0j9etZ/nGD3
         okV+dCcH8Ehsq7aukFOWKh3MSGYSNlkghDdyXeq+VFaEZ11D9SVG5QePYI7FRACEAhLJ
         PoOzKYDR7lcIAnJWv8tIFvEUHaSbjo7Ec3oS8PNUwl9pxX28zMaZU3kdGubj7Vkzslbl
         dBZg6BlLpVYuIHU2ZCfQPfACr6Qamn9y2JHH+wkdArd60acDYGnLxYJ3yXY6WFXOtnu4
         UGFQ==
X-Gm-Message-State: APuU4Z9d59jKiHLDfjVpOd7GjoRgVU28IE1lWtwzmznOGwOOpQCbpnNm
	m3SVMG57gX3KQvZD0hYwY0h/Dzmr6BXq2hNFMdnhxyfqAWBs7lzOJMW1G70ZCMO9ySUV4wj0Wgw
	TLqQobuk=
X-Gm-Gg: AYBFou0L1U7lmyQlX19OQhxN21mLLL553dULuf+fSvhkfYPcAZgLeXwa+9GfpaWo6eE
	r63vMw19fgZgDaz3faruPpiazesJyfkAVH7PEWiIGVnMiXqg9H8Pacf2036CqzMy013qKPy3dbZ
	/m9eR+nsa1tBSX6BbJqhq5OdfhAeEWiChzYFCNCPqSEQxpjIk0K9wfCr7knwVzz1jDHRxI1gg1l
	xwGNXxFikGuBGYb+Eu7smAwFOLUMo7bOEIJiu8s9YCqN4PPgoIdE7HpL2uVFneP9d8mAObgp/D8
	zcYcnAUmjcB91BucD/Wh62NXCAVZFfPMQw495KRBqv+Em/irRex6aFqwBw6+COh5pTmGDRdfNpU
	ixsiYbpX50jb7bML4gGXcJels9gs1rNVJSApx1o6eAg5ArBDlgq7yPrOuWHuNEcSPG5ntckFRg7
	ZJdQKC8294XA11m4qJWXw4AWI26z/lO7CDG4uFcTlLYx9DbEn00u8XR42XQgKxS+DI0KJv4FYYT
	zEs7wveVhOXmX55qO+DPQAaQg6eZLAKx1PpVW+BksPnCT+ug4urguOkKd57rys3bjl62D+QJOQU
	hpFGlcABISH254LGjM9CJIKX3sXjo5gG/qXlr688rp6ClFOcExCoTKOrlJGr/fkIGmNKdeg9ow=
	=
X-Received: by 2002:a05:6820:4b87:b0:6d9:c309:6479 with SMTP id 006d021491bc7-716d22b6bfbmr189386eaf.58.1793817830883;
        Wed, 04 Nov 2026 10:43:50 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 7/8] io_uring/sqpoll: don't wait for the thread to exit
Date: Wed,  4 Nov 2026 11:43:40 -0700
Message-ID: <20261104184341.516297-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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
[axboe: 6.6 has a single exit path in io_sq_thread(), drop the thread's
free_refs share there]
---
 io_uring/sqpoll.c | 28 +++++++++++++++++++++++-----
 io_uring/sqpoll.h |  3 ++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 76643b4a08e9..f458c1191e2d 100644
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
 
@@ -335,7 +352,7 @@ static int io_sq_thread(void *data)
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
 
-	complete(&sqd->exited);
+	io_sq_data_release(sqd);
 	do_exit(0);
 }
 
@@ -455,7 +472,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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
index 8df37e8c9149..9e6d44095017 100644
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

