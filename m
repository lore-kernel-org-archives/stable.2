Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206067;
	b=t8XXVH+fP/EZqg/7MYJJMXmC1l0dE8NPlEQsb9C9vAs7OaHrRR/mnO+mfq6uZYQDYRQy
	 4SBzaCo0p8DE9lAouyfbU4SAjA0Zy3YyyP3UxOp8qZYh0g8Pc9YaSqYnU9+sDiLwx9h3E
	 lqGhUUb/lGkGYcCUHU8nolwBrAw0+Wwk692aaNtFNa/MLt8VB5Tm55ZRICogALM3YPKXq
	 7USTFuKuPpQ81GlQvL2QMtr0B2TlQMy4vBPvKl+awdQhQwRHJxFSy0nu79+i44fLoa3Tu
	 BcABsIx65X+0xw/CkSWlINyqIQFgzFOgydj9T+KbdO94Wz2wVF9RuXm8J52FIII/EnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OAzx0q/CoMCzcW5ipl7ejGrSoA9Q4FjKiqMCcWPSFUY=;
	b=Y+ukHEgqBKpJR7i/YQIXsPVVZTFfIIiJEenn0AU5FmTRHowmOuu4RAOVBtY4Y19gKog1
	 hJvKH4ANLzubOMZhYSwMnTYIpzTHGtj+Cr4fpPjYLo57OBJDn8GRyxXH3RuyLU4ySmMZ7
	 t4B3yaEV9B+JGmbALWPnRwGcaoaQaYeifSc0yj+52IIWyNiUXyDj9L4+04kXkM4NYO0e+
	 x6ZY5O5bVOBzSdonJlnprFxNk8yeKHhsJ9yRdwg0I06cjJJg2vCmpjtO6UyG4R6f6MSLg
	 bYWWyRJbFhoXOt2pkrGG4xgJhlEFhoZFBq5W2z1jzznnEz8tfMd5GurSw/JN85IZ88Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TUWgivuO;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B09606A32D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05B09606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TUWgivuO
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-703be215729so671635eaf.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793206066; x=1793810866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAzx0q/CoMCzcW5ipl7ejGrSoA9Q4FjKiqMCcWPSFUY=;
        b=TUWgivuOt4Ise2icyBdNufGJc9dEKhELhqNN0b/icqgsgQ1W+Vp5vIcDmi2Tvrcq2x
         98oPtbYVSg7Zye7cMNTzwHw2iP+FjgpP1hV2he2RRK9w/uS7kn72W5ULFMbPF2xnyvFq
         Q+AttdmB0MNwuoAQn26nzp0iWVDJc5gE6IFhAqKSGIpMKDqrg2Nzhj9OMv9OeF8WtvlA
         YqYkKSG33l1LVOCg7SjfUgUKeWUkXZWYP5aFTZvV2HPPMG81pv1IpChzO2v00BGuJ/B+
         YnmWb1McMhNrt8ftzVYJ5AEgS6jtVhyPm2ThikcG1j4X4SZTVka1HloB1t83fk86ZxQj
         uWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206066; x=1793810866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAzx0q/CoMCzcW5ipl7ejGrSoA9Q4FjKiqMCcWPSFUY=;
        b=yPEY1m9RcUQw1hsvAQYhYC7iQsyXvwQfew220tyLEaMdy0pvZNyUqHHXzA8QgCnBhD
         k/LZWSzeWDzW50DPTY45UOm9GAapuUp3RJr5zlsFsYLOUUtf/7xtOhq/HwpullPY33W0
         1Xm/IvvwVX7snexjpK+B2ula2PPpvpaGqtkExhoiNE5JGEEplO3rjMokpYo9G1F5w9J7
         WBaRgxvHYUbkYxXifsKZJ2WNogJC05KixXhgsvo2x74TWZoPmHT3VSwv0V/e75WGcOAM
         rzTbXgvz+LMQMKtViJNhI6swxI/8LCxvEFd/exXTFB7cqbUQpAeq6ZSXI9AEZyu/OhST
         39vQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOdu9F4mqy6kmKpn0j7dvgaB/+ZCwmXMH84EzUcRWxVp/LxlsW+orSTWERmspXxrA5H0lf+oY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjbxuMPUCyzpub35mPBQ7gS2Uneqq7kEYiK++lBFDB1mFK0ZY1
	GJ/omAeqwqOzgZAS/3rYpG4dAz+jKY8ENa7a8Ppmh/jbpg9D/iukl/CMMft1QqXBkYk=
X-Gm-Gg: AYBFou0iRw4W1N83lMgBEK91RFoyp52EqhhEbUSr3VLSikhyB9Bwxp2PX3UvPfwfVrk
	P1R9JDvdn5bfSmm26WkJh6kMBWYf4AdO3ZSWU8sDLDF8Olhrj4yBNph7X30eBu0waiG/HRcIR1l
	N2FGom6UwS8mgXyi3C0F5iUfiJ7OS+lND4/R5qC5Z2LqjTx+Xp6Sgodo3XZSiZAt0nJiDhKTvDF
	tGm7nr/QpoQTjNkxSViJvhzr5PjGZDm2DjnE2AOf8BYZw59WCyfJzEaP8sE5V7Rwk+1Fm3IWc29
	0+bVfVnTqzM3/yklqdajbWnRZ13jfy0JyD4MyC+mnBTrvojoVrxQejnc7HgRMEzIWsLG86chWWH
	YtWJE67++8orcKWqRBNnl7sUqlgA4sVTF9GVSdBqrYXDlbrToeJ/43pzCLAqQPdV2/XtN4ZlcLt
	hhab/QJ97CWhGnBLK92b7tmSSXLnkVDkSpvd+GXbRPBLtCoMTu3xyWlsUmoKLzgFaB1eGBqJGdK
	Z3mck9R9Rha5UssLqAsw6w2XFOLnuoPHRBwG/fPbQfPrwJJF38pJditiJzkMFc/yLVOxOeMRE4Z
	0hxRz/MkEOz8Ctn+H/tUivxASlbKacqcBNfqOaB3fm8jhkt3QSHNmR0VF2p+H8+56E59b2CO4GY
	DwWRuJpH3xvYjNVA5j3xK
X-Received: by 2002:a05:6820:807:b0:6f7:6416:a33 with SMTP id 006d021491bc7-713ee66d85amr1672874eaf.39.1793206065948;
        Wed, 28 Oct 2026 09:47:45 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b206f8a41sm2019182a34.25.2026.10.28.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/10] io_uring/io-wq: save worker type before dropping its reference
Date: Wed, 28 Oct 2026 10:46:57 -0600
Message-ID: <20261028164732.1264069-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164732.1264069-1-axboe@kernel.dk>
References: <20261028164732.1264069-1-axboe@kernel.dk>
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

From: Kyle Zeng <kylebot@openai.com>

io_wq_cancel_tw_create() inspects cb->func after calling
io_worker_cancel_cb(). For an existing worker, that call can drop the
last worker reference and wake io_worker_exit(). If the canceling task
is preempted, the worker can be unlinked and freed by kfree_rcu() before
the callback function is inspected. KASAN reports a slab-use-after-free
read in this path.

Save whether the callback belongs to an unpublished continuation worker
while its reference is still held, then use the saved result for the
conditional free. This preserves the existing accounting and frees only
the worker allocated for the canceled continuation.

Fixes: e6db6f9398da ("io_uring/io-wq: only free worker if it was allocated for creation")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io-wq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 28533174d0da..92df54c6f50c 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1434,14 +1434,16 @@ static void io_wq_cancel_tw_create(struct io_wq *wq)
 
 	while ((cb = task_work_cancel_match(wq->task, io_task_work_match, wq)) != NULL) {
 		struct io_worker *worker;
+		bool free_worker;
 
 		worker = container_of(cb, struct io_worker, create_work);
-		io_worker_cancel_cb(worker);
 		/*
 		 * Only the worker continuation helper has worker allocated and
-		 * hence needs freeing.
+		 * hence needs freeing. Save this before dropping its reference.
 		 */
-		if (cb->func == create_worker_cont)
+		free_worker = cb->func == create_worker_cont;
+		io_worker_cancel_cb(worker);
+		if (free_worker)
 			kfree(worker);
 	}
 }
-- 
2.56.0

