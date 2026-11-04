Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817931;
	b=EtynVl5ZR5YnyCzpAD8oUqCGdpmzIQdkRg63WO6tOECgXJAf58USrX8gakPpaSNrBadj
	 JUfq0m5kEK7ByEFrunMr9FjHM7ACvR3TnOLw7XaQKQvgBFiYXD3LJqOHw8Wrp3MeEgMyk
	 sx1ACcL0UPEfoztUH6GQH+jTKzIECfe1LxZ4v9rlCOMddVZt8P3RK1zC+4ThHKLKWqY8u
	 Q8vn0cFe3QcUu2rTyphaP56p0UyuaRvN8dfYlWmuq5C0hrzYULFpjI+1flkXKab3wp68Y
	 se4cmKcTQu3s2RhrouBMPyG9SONv++79fVUWIUIfg7Ejmr876DINGFHsn2KHQ8q3B0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tBDgrg+DjfdtZk05lWBRK5LeS/PhlQeolKcogeU5s4c=;
	b=0HvDsuPipbLXrN2LIUFPThhE94ZqtE+SyPNv06q20YhWWHuKymYhfMI03zebgiBBkJHG
	 RO9GzoRREstND7tmNgW5mpcAn9Y7waMvRdmGklQuua7LQgCnDr3h6AhjAzyf19hZVnbM2
	 I89TqKioEfm3+IFQRa372gyf1J38E5hWw9jXpbLy1DzZqjuE8S9Xh2oCi6kMMXiuMUEc5
	 MqXgvxjbGJgdnAC9PEsz5PB5ZMaMp185DPVH96F73anZITp9qwycm4u5+PsiLIno1sp2L
	 9EtDK1fOgAucEOV3Rv1HfjoBhZynHc6EOuo6h+rWU3rqJvuWQ5rUoRKaa51OFYFU2lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dpnye4Fi;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D85606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D85606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dpnye4Fi
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-539a57a0b1fso454847b6e.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817930; x=1794422730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBDgrg+DjfdtZk05lWBRK5LeS/PhlQeolKcogeU5s4c=;
        b=Dpnye4FiPbjBqrP5Zwpln7mxjrx/7kepTCxq6tZGwoHmTgBw8ktcqOZKkBz38/T1Ve
         ZebplEk1iZS2VoV5S2X/BJbTRPDo7GK3tvbeiDFppz7MaAK010fIvxr2PHybAdJCrEvK
         mZxqdh8boNKAIDMexJ5ZTEjQqFjSn8A1M79ynL80PoISEG/Bq3kKRmx8QLPzOOUGrg9m
         8eK3tKz9Q5whUcQbEKU+jIaVnbCzFdiGBIReoQ4OWSG6xmdzLAQITdHsGICArbxnGoWj
         EGIKN2K4qVXGQeRgAmZP84J0t0gfv0dcjpyW/O90sS3rrQk8Lp/uav3zh08yBQS3igIa
         5zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817930; x=1794422730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tBDgrg+DjfdtZk05lWBRK5LeS/PhlQeolKcogeU5s4c=;
        b=BaZr3c5rm33YoIVx1XYcAxkynhbIJ9DUPEKpH/Yvi2B511qtBmaop1G81tyn4OgOPM
         7ZRr42uYhq4vzsjzVeVAmKE7tAT+yhZDyzQYe2Lc8qFH+fnkJTqBuSdRGKNdCoW+w56Z
         4OKwvmfvi8dsiPcN31Ec4u6hlGqKNP/kQz8YfN/c4Wmfzsl37abmQFSFW/iBSyr0eYSy
         LLI9ZuyDEJOFd6ptd6HWQSHF1MvvmC6HQnVo6JiYdL5oKcp1Rwor5wV1ViuQEDcbWrba
         rBpqW5LOv39UjExPBIkDtBFRuFb+xtwbJmFVtVz0KJA/r/cYO6WJpUh9G/BSAHgK9jG3
         HqDQ==
X-Gm-Message-State: APuU4Z/pGaF/2wvj6TFHDdCOCf9Y8xjhnjjiDD+E0h0EdWPoYPRLYmjz
	sG04kLl5xxreQBEXbHIdbaI7GU1qQu9LmcUti+MDr85ArjkHkFB/654TjGFx5qZYSe/pL1owAij
	NwOYZdGk=
X-Gm-Gg: AYBFou3KdiNJsl6sd9cLQp8rAbRKeZw74pRYW2pwaoU5R7lJCRdXteOpsGMCg0GFEnR
	1tArnmgh/YcBMvrJvTXVTWmEQA6+ZK6beF6hS6aJf4D4A4S721jDDHZT1MowR9rhb7S1tUR4yJ4
	poJx/5yavt7DPs2N24zXCUYpkG+czFFwLHrzhCUjbgNnrXj6kgdO5IrkcEKhdFSU0NzFo/35X1P
	Jh8fpUHcF5vWQbcmT4bbxmNFJW9cV/S/0R5sEHPXuvxyT7vrwURoywyRBiwlUKjbjcrac3zNZwy
	QoNZlgPbl1aXyJRdU6RJgcIzdksbSSAo/003FTc4lHxAqY5b9qbTSNOTvRGvJAR9WiXaH8OeM0G
	e9lXwWKXaWgNPB9ap40tHQ0uNJG1SWZyrr64Qgz7ZDg46JW/Up5KrTLxx5eW1/uboJi/smdiNde
	iET6+Kp0vzNwh36Eiob1AMVEy13KcKf0UK76SGMJYGUDE/vVygO4X3/wRT4bm1Jfh25GXVsWWFy
	8V8lXeECXIADY+3gMvnDoYf3zLHCXC1NpBF9g1MoDsh/NP7LTU4Clf8r7wu7WlIQi78o6eAWBQV
	KGZ2Uv08U+NHnbSnEiTuwXX1EZA4QHquxzyt3a/TroRK6eYAP2BcdKwlEPIArb6zOkaoXa5xmQ=
	=
X-Received: by 2002:a05:6808:1902:b0:53a:3533:10d7 with SMTP id 5614622812f47-5640dce893cmr12176434b6e.14.1793817930010;
        Wed, 04 Nov 2026 10:45:30 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 12/16] io_uring: free the task context after a grace period
Date: Wed,  4 Nov 2026 11:44:43 -0700
Message-ID: <20261104184447.516768-13-axboe@kernel.dk>
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

Commit 9f5315d3f4368590c9fe06d4313b7247470bcf15 upstream.

A task other than the owner can free a request, io_ring_exit_work()
running the local task_work of a DEFER_TASKRUN ring for example, or
io_do_iopoll() reaping completions. io_put_task() then takes the else
branch:

    percpu_counter_sub(&tctx->inflight, 1);
    if (unlikely(atomic_read(&tctx->in_cancel)))
            wake_up(&tctx->wait);
    put_task_struct(tctx->task);

The first line is what lets the owner leave io_uring_cancel_generic(),
and on exec it frees the tctx right after. Nothing holds that off for
the remaining three lines, the task reference only covers a tctx freed
along with the task_struct. It used to work out because
io_uring_del_tctx_node() took the uring_lock that the freeing side holds
across io_put_task(), until that moved to tctx_lock.

Free the tctx with kfree_rcu(), and enter an RCU read section in
io_put_task() before the count is dropped.

Fixes: 5623eb1ed035 ("io_uring/tctx: add separate lock for list of tctx's in ctx")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/io_uring_types.h | 3 +++
 io_uring/io_uring.c            | 2 ++
 io_uring/tctx.c                | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c5edf6246a4b..1c85ce0e471d 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -161,6 +161,9 @@ struct io_uring_task {
 	/* drains ->task_list once the task can no longer run task_work */
 	struct work_struct		fallback_work;
 
+	/* the tctx is freed after a grace period, see io_put_task() */
+	struct rcu_head			rcu;
+
 	struct { /* task_work */
 		struct mpscq		task_list;
 		struct callback_head	task_work;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 880be1fed3a6..c8aa6ca4a7cc 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -634,6 +634,8 @@ static inline void io_put_task(struct io_kiocb *req)
 	if (likely(tctx->task == current)) {
 		tctx->cached_refs++;
 	} else {
+		guard(rcu)();
+
 		percpu_counter_sub(&tctx->inflight, 1);
 		if (unlikely(atomic_read(&tctx->in_cancel)))
 			wake_up(&tctx->wait);
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 291e30e00e45..b4fecea3ea47 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -64,7 +64,7 @@ void io_uring_free_tctx(struct task_struct *tsk)
 		WARN_ON_ONCE(tctx->cached_refs);
 
 		percpu_counter_destroy(&tctx->inflight);
-		kfree(tctx);
+		kfree_rcu(tctx, rcu);
 		tsk->io_uring = NULL;
 	}
 }
-- 
2.56.0

