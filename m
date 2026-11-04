Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817867;
	b=umFUmAuNORgtDKtGHsnUbzSBYwqZB2H8qni3I7pEu5fTx3JWa8HYbJFQsvotnv96MWZR
	 +8BXgYsJemOU7wdHT5HM9C8WHfDbO/gx/cR5bg9vXAy8MXjlTWQ/cGo2Fc5M3oWXSflUn
	 tnO19cwz7UHVnzthYRjDBqZbBwSyri5aE7EXfQCYACHgroBtEeoCd7b1MSjDMOWX8dNER
	 C6AC3Z/JK70L5UuLveL/ZX90HquQYKROqpGS9A9H37C9+e4cwoCYaG5BreUJFHobWu9GF
	 wQX7it13Gsh/BIxtH07nvZbX0eNvEFnzCjYSAd7DSMxT2krUyS9oJofuZiRQRUo+qxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5syBZKLUx9uKpNVuKwAxHsN8HOGohL4X5wPXQdLXKsw=;
	b=p/l2DIerHIVVTv63PTLtqD1wmwW4OzCWo8oW4QE4PM7+gXZ21F3BIv25HIrNhJkHk9DU
	 cIP+TKlr/mmrKXME/olrLMovhJ6H3ZsL8AbdSTP7YIp9pm6ytq914ANLWUxcx3+aJ/IHn
	 cxkKo65OyX3LxubbglxPQ9pCzcuzzimrBDGRjX8jb6wpoU4ygsCu4cm3F2uojwT4Gv2Gr
	 Y7ln19PWigI7DidyQ6IxGKZ/3C+4bqvuUEE9S/YZvNUk0Ba0Gxbe05GetScoL6kUPWzGv
	 lHUJGLSyjxDbXbHK2vxM9AJhwdNC8sIWStlxMtcrJoboiZX3BU2CtAPdxBEzCvZgHNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C1kBuxcw;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97C606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D97C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C1kBuxcw
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-854b6e2e41fso592146a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817866; x=1794422666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5syBZKLUx9uKpNVuKwAxHsN8HOGohL4X5wPXQdLXKsw=;
        b=C1kBuxcwxfnZ2sN9faEsxinhT+grvjcHVccXFOv8W3qjM0thG6RyBzp/4wNkFRy5XW
         6VuJzNP1lqNr5WTGOtcm7cCPKuLNjI/6Xprri+SZ9wmDjxoQPnINi+zXt3dMbhD+9Mjj
         z3Jts1aRtiFgoNQPdJBtOEi/vCDqEkCMSATfCAmovyY5dsZMBh7S50lCpt6BoidjKNpj
         dYPVUTgYU35wpbytqJSrEWsaziF8eScnyRL3j63t83r8vSFMI1lIl8vyfZi5ffYmKcER
         0BMotL6/k6zYhBhBHa69MqfadNPxhUrG58W84ZW2CrSz3MpcMsPpv6typy0dzw70Y8bG
         Vz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817866; x=1794422666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5syBZKLUx9uKpNVuKwAxHsN8HOGohL4X5wPXQdLXKsw=;
        b=YDzfFBnwMbOD5m5DdUrLYlfq8IlDnW+djxTuK0Ffai4xN+gwcmnv8pBBk60ttSv7cn
         yeqOHgQcuNRS/OM7BjEh7JBqkvLxXtlbNsKMLO+nUXZwAfVXBHDjBVZGEAVH9p55GM1q
         3QF5DTRtISJWeCRsOZTxXwd1p7HIEofezci9FTofD53pgskmC/UQEdefFZuEEaJ71Hqv
         XHHWFBRJGExsJveFdUy4jPLo3Kz6H7OdQNyuegvGnn3VvWJGcqd8Hm9s8Fl61t94Z2fp
         Uf0juE9b57QVs7w6Dooj9+t2uJoT+FcMAPhNjxdcN7vXCorgYKTIv2n87LYAcRfqbB2O
         FEtg==
X-Gm-Message-State: APuU4Z8H0knSUWHH5cFonUGwuSPilfHPK8N57R+z8LEb82565fgyhJTi
	VE8JLAvt7FjuwbdyhHZ45Zjj1bJDcdO4KnKXU7Lo7e/1QD6uzBY6QKuV3T/xFAqga1ZrjndY5UV
	nrdOPmF0=
X-Gm-Gg: AYBFou3wS9XKZ76gFGH+ypRKIiLRDdk7jhszWw+GW3Ek94ZP05gAFDjajMQqZPSCtRm
	/2IX9m+oMhjmyL4YeVxJmAnLbgjR6HJTNNvdDWt3VGBQ5+8PvlfnjzkTGfqLmQQ+6Ek6zDAokop
	Fo1Rhn+nXpHDpswjCvObeTrO2MxqqQTkozfPlLpqlbS1RATR9IeZtm9Ki3xgpGCmk8aYO2b+ASC
	Z5tHCrlo0yE6vn2Q+2tzf6w3hPODQ6s/R7+ICiRJaSV2DTnrp873DxMFhwESWhlnZ+7QPY1QQvU
	4r82yBZzU9hrFjjtaLgPz5bEBv7da6Lav9XvtV7gf+awqFXpN6IxWo38G44meN+2Pm/NL6DNatS
	jralY3JvKpCb39oHyQW0WWEBZu7AqrhVrPJ7I1M6f+apSuQF4n1BettGDiPj+Glf4bPHp6IY/3J
	vU1762lX+hZlRlzPz3XuCGw+pOCf9Y2DPULlhaYU6qQn6jXBr6PwMmv8YOzrh2SrVkqgwb0SrKs
	st3l+Z/oag1kWieXB2ARtAeHTBaV40LhwnWTfV1tyi13Tr4OyseGT7KVA0LmAbDF0gyjBiDbH4d
	g3E2qZMKZcTfbs43MTvAdyz+oWicf23Qh9ZUzIIGmGCgjswt1lgfN2ukfr9SGnaGg9FNQPSbGA=
	=
X-Received: by 2002:a05:6830:8286:b0:85e:ff79:a340 with SMTP id 46e09a7af769-85eff79a4c3mr1498788a34.11.1793817866439;
        Wed, 04 Nov 2026 10:44:26 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 08/11] io_uring/sqpoll: don't wait for the thread to exit
Date: Wed,  4 Nov 2026 11:44:09 -0700
Message-ID: <20261104184412.516558-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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
index 448fa81ed87e..406029c14fbc 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -62,6 +62,24 @@ void io_sq_thread_park(struct io_sq_data *sqd)
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
@@ -76,7 +94,6 @@ void io_sq_thread_stop(struct io_sq_data *sqd)
 		wake_up_process(tsk);
 	}
 	mutex_unlock(&sqd->lock);
-	wait_for_completion(&sqd->exited);
 }
 
 void io_put_sq_data(struct io_sq_data *sqd)
@@ -85,7 +102,7 @@ void io_put_sq_data(struct io_sq_data *sqd)
 		WARN_ON_ONCE(atomic_read(&sqd->park_pending));
 
 		io_sq_thread_stop(sqd);
-		kfree(sqd);
+		io_sq_data_release(sqd);
 	}
 }
 
@@ -159,10 +176,10 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 
 	atomic_set(&sqd->park_pending, 0);
 	refcount_set(&sqd->refs, 1);
+	refcount_set(&sqd->free_refs, 2);
 	INIT_LIST_HEAD(&sqd->ctx_list);
 	mutex_init(&sqd->lock);
 	init_waitqueue_head(&sqd->wait);
-	init_completion(&sqd->exited);
 	return sqd;
 }
 
@@ -429,7 +446,7 @@ static int io_sq_thread(void *data)
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
 err_out:
-	complete(&sqd->exited);
+	io_sq_data_release(sqd);
 	do_exit(0);
 }
 
@@ -543,7 +560,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

