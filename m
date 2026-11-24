Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516569;
	b=Qmq/fwuHDaTLAKxRtjYisXsAGJ/sF4Y96YJVvUyMctvCHlYyyY48MTXJ1JefdFGoB0i5
	 tQoe8aI7kPWvbI8j9gQGV6IyeE3jCKDm6pzdGkOj4QVOilWtCc6st0ifIapqGbBwEKmn4
	 PbF8x7ePTmQ/Ilq9VqYE/LDbEqpHuYRfb8bKqh8NwqvvYtxiX1+SQB3FXeMKaAW4RI3ot
	 eL5qTVBaoiDa75MIbLzGMa35FTaDTzdOtiGA1IyHpZLo2Ucd1lW5IV9tjGMF6W34LyymS
	 3CFSwQ7ZegiE1+yggXB0XQyosEZ0GxAtajF/Nw0TMDRWYdsk2c/nuqyTF36KMVEwYQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2+HSkOtOU1kljM1v3ikCzTVJIjfkEJGNjipK7N4p86Y=;
	b=M+kNQEab4uYIWnXnQz2krSJeA4FkVlo47VI0zgLrB06fUTnzx4eL8lbMS3r5fa2QkxEI
	 lRFrb5OMmDFyyBOJ+/FbODutjz3acpXH7OiHMceDXVWBPsqDETZi4uG9icK196VMjA8XV
	 EIvCVhpVyk/Wu1G7hAZafgA1bcJoq6S1/yaaEUl6xJtp1vCDcqGz7YdibOodbHsOkg8co
	 soAAA5LEM8bONn6tP6YLExvHZclV6tmbvtwwScqQA2pGxNrZDm8SSpioGkYEN2mY+BX4a
	 y3LLfDN22oRuS0S78FdACyMxYrKSCRh/vupcN+D/eGTpQmfMIkSo+kTg0B73mWUtjfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bu28w/jw";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98641606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98641606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bu28w/jw
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso47424295e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795516567; x=1796121367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+HSkOtOU1kljM1v3ikCzTVJIjfkEJGNjipK7N4p86Y=;
        b=bu28w/jwTIfb21GVEMo0GqvKyj4hNRPCml04a4XI2W5+iXWoj/Lp3u+KDc+cbsFwrX
         ZzKLgH/kC12yGTZL2iXgaRjqU3oDCxUiskS0ElFrMMemS+jL3BuxsCEn4pRuE5LkngBP
         caKNy70UyspHh3iaCbyB/QjxjBy9gQcdYIavQUuy+wyWLNMaH/ijIOx4OedGKLxdOsHT
         yZ18Vd8m2oMeBt3bJU7wBs0YKThrTyZ1juo5im5DNd+eJQx8E9dbPqzWxrTChVYt1QxA
         mE7gKEllcyFTtI0Jxk7KGBUwnYEdKIsAimV4yfWt6i71aWl7Cu0qF+g25rs5UXfJxc+w
         MS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516567; x=1796121367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+HSkOtOU1kljM1v3ikCzTVJIjfkEJGNjipK7N4p86Y=;
        b=oOs/56Ok2HLzMsRfOgQjqLJc3dycOWmucfmSrpJbIhbTp5L3kjxQOhgIQWoXGuMlxd
         Sq6icswA5BYz3rJ6310kfRoAqZv90ypgjN3KCk/eRGsBk62TuQdUEKzdyTZIpLthzsbq
         52LO5EEnFXY4ywKmmmTSfEKzGP6xmzADr7CxQkOfXFciflJ6Vv2n8XZWMt/3IFWaJE+z
         RCXqahlcNpxsvlpOgVOMHpULn993lBJ6CNxBOlF7VY5wBlc9fXEinUEDbG/v4Z2t9zGa
         wquJO5tNEMQJXwwpawfkNZ66fhwttoRpN4AsVD5uZiSsmc2SFiLcF4ClDv0NYlvaA9wn
         67iw==
X-Gm-Message-State: APuU4Z+1uUv1BqBfodm5lAs8tNYzCaF/77ywGv5jsvaSY23VkXnZNrC7
	iFzoGGlX0X+qZmMnKS1+8vgy4QfzXcuXXWszG99AwVQxVThhmkEVzl5UaTT/eQ==
X-Gm-Gg: AZFdTZf6tHN7O+7ZFtCPDd+KUXPcPQ7qRxooh6sbZkGC1/Rx6WFqAiigjAmZAfqI2wX
	0Vd7S+sm0yzJZrq6WLaKYWtvGfED5EOQugtcjJ4sfElvfLfDjE0ctF8LJYoMTy1ocFNklg4T/tR
	zBlQJep8apoUopjeZggVTOocK+MeuTeamMexGFvGfW6VrsmErvRnE3XFVwpvbgMKkDmrc4KsFW+
	6TeT3/FTkCESJrEArrY8Q5NUuiyFy1JVS4q5NyQeJ9qfOM+wPZy35Z9n1Nx0SbLuvEBsAFuaeK0
	KsyXUaEYwIkin+O2C2I5ATxfJmGcURm9CWyRniyg9nzcUQjQjWtx+Hso5hAtdLwbIzlBK4sA/Ii
	Mqhj11PPt+UEi1UzUtaOec4A2PfPIJXlzAiWw+f16Rkh6LZlwg0l6y2FP2LZ+gWcqiQ9G4KaTnh
	udNahrDbm8CySV+oSjRiVtZuCFl2cnOyATfzJkvEPiqukVExNJdSf7d8f0i5+gTNitQv0CWAwKh
	SbuPUYllXJv7IKqGhZvREdM34x3jztk545skUpLQIVzbCSmvgR3Jitc8UZNhjzhGwNsDphRHKK8
	tGxUngqEAXRqUFYOQ7KQ7JunE4YaXExJXiuwRTzCwiyP0nRupf0EhL5dPuzRKqkipyVdm60i8ZO
	wRK6+nxH+cCGalUJvQ+4=
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb88805902mr275755005e9.7.1795516566777;
        Tue, 24 Nov 2026 02:36:06 -0800 (PST)
Received: from grower.termidesk.ru (ppp91-78-12-234.pppoe.mtu-net.ru. [91.78.12.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm165954765e9.2.2026.11.24.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:36:06 -0800 (PST)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH 5.10/5.15/6.1/6.6] io_uring/io-wq: save worker type before dropping its reference
Date: Tue, 24 Nov 2026 13:35:59 +0300
Message-ID: <20261124103600.39642-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
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

commit 37e425460b7c41687e51e3254b1eb1d799da9614 upstream.

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
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-99804
 io_uring/io-wq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index f57743d911b4..2692f5ef387f 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1232,14 +1232,16 @@ static void io_wq_cancel_tw_create(struct io_wq *wq)
 
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
2.43.0
