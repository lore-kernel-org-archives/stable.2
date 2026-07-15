Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEA3AEB49
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137410; cv=none; b=Jt+bHj4ZgWpIU3kYLhW5EylbuVCn5zyjxqN6US9ZkdP7wwqMMEJW27WmZTDTRVjo7FsoUutNJxN01aVftxTwZ9TcGVitj7HD38imggVGNeM4gLUKyKLysudA3z/XBbGd0aYkUmuPjbWERoynBPkjfo67bWoECXfOxoargCMVRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137410; c=relaxed/simple;
	bh=NHNR9MKOzKYImCQUQZNPPlvA4wqlB+NM6RJgzl6eQCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk2O2umav6j5RI/QXuAKaV9TiQpUcABKPhvgMWRvNQoApKDIk+TvoS+AKS5tKSVKhRJdEYP/RkE+nkfxHMU729RHkAaNqSZrrW1YqAmUxae+FnCnXCWnvp2BA9JpqGsCBpapifN8MKrt2JKSDmVQelG4LoE9gNtW+HVKjYWHiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC20fK6p; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC20fK6p"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1771527a34.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137408; x=1784742208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4h9AQKqH7OWc4BD3uJy3+HI4wlXgrocnJFgRfCOCii4=;
        b=UC20fK6pG+JJbYte3WY6fdcmZ+pDvfeJMYMNqRO0y28nNt/EGCUqL8LfEt2Kx1qsKT
         32UgD0ZcSvBLiEGS9Lkh65gGp6LwEI1laGB/nQiwSXKK72EDM9wTMQnq5o3pHOIUIAnN
         Su+yFwElWFPPAW9LaQnQ3Xr7VDwHfz60TtutDt9BGnLb3gpOUGFYu7y448eweKNqCH8z
         7PU/bSptUVA1YbvTNMzSiGNZLIEqXlsSZb8g2NemOv9x83pkg04V8ULRZZFZsV7nppHC
         5eFiAR9Kyi3fQWgEULXFbCgFTefxMlmzU7SqI91m6qhwySpk0+685RkCdY4XIG6lJhU8
         rOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137408; x=1784742208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4h9AQKqH7OWc4BD3uJy3+HI4wlXgrocnJFgRfCOCii4=;
        b=KzTabjKfvzr6eoLGAFlwyEcZoH4dHXVG4HnUqGUt4dnT0TRk2Sb5wA09HdZLNzsFe7
         rZZHy/OoYd/75Cmuo8Lgz3e0+8faUjXb+EDsGwO+VY3ubgkEoA/VCyUg9FcqYmX5Y3/X
         v4EtJP1LVsLqWVZRA0VwuLrrcZJ69BiBd5BlwgCjbV2tA1hoddh+Az5p3IY0cFD1TnQN
         yNSfft0yc6qYYQ+PjCZu0MTH0QqZ5zi4CDQDIK/cCYFcf9YVy64SIel5JwUaIe5VMY4o
         Tw+3JaDQFztfCNeCUvThrPfnlCgWYDh5cEQBp3Cjol7WRvho6fwyMlqsfB+IQ2AuGwnF
         vjVw==
X-Forwarded-Encrypted: i=1; AHgh+RqchdmNgtff8QUHdk/+xzCLRCUo6VMiZ6h4loCv24/l6D67KG0gVJqNdc1GzajYJD4heUpGbZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaA8slqgAxt8b7S72TBRGR0psUD79tHYp8WQvACioYg//xcnD
	H9trfSXly80HD7P3CFht2z2MBmPokHUtres+F06xnhLiMqA5TFNxstuxZszzjQ==
X-Gm-Gg: AfdE7cmC9/QUuk9sZ7MwlVqfnu4nuo4fnHJOqPPLxLHjklZ4jQ8oILKR61/bG72ipdC
	CxIo8x2nH+bjXidQLf2BjgAd5kWkJwnYiX4K4g6G4We+jIOm8vGowq2lDAsJ136h9mCyoVwQHs5
	kFVAI815FbWuWRo/6Nwkh2ODfMYvVtxel15zIt+qDsJst0TcNiwyJc7FVdn6T+C92vFqppmXm6e
	fkx0RsMCPh4HdryTKJ/+xn/6KYBbpXWhO9F4Hv7FaxO3M84oOw4yDpaTpYn5Bl/fcQu8q2pFUs5
	pXqMqyghBBNDaVpVTTCl4unSeHfwEGDoNLtPGKbMg1VQHPbCOFv86bwGY2XuuH0iaZ5lJkQ0PWo
	Ab99cXamCH1TKbnz414AhodNRFoey5HtlmcSE0Jy5cDuxBSTSB+USNMHQUN6yPaHYZeyBYV7PV9
	RrHc0IhOKUErKbQRZsL9QC47Szh+NUuSo2Xd4WSWvahoemc1ud+m/ZOmIXJYqQp3J9
X-Received: by 2002:a05:6830:4190:b0:7e5:68d0:462d with SMTP id 46e09a7af769-7ec423299b6mr5191121a34.19.1784137408225;
        Wed, 15 Jul 2026 10:43:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec14489139sm9884551a34.5.2026.07.15.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:43:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] fuse: publish io-uring queues with release semantics
Date: Wed, 15 Jul 2026 10:43:05 -0700
Message-ID: <20260715174305.336261-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715174305.336261-1-joannelkoong@gmail.com>
References: <20260715174305.336261-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_uring_create_queue() initializes a fuse_ring_queue and then
publishes the pointer into ring->queues[qid] with WRITE_ONCE() under the
fch->lock. There are several readers that may concurrently be fetching
that pointer locklessly and then deferencing it.

WRITE_ONCE() doesn't ensure ordering of the queue's field
initialization before the ring->queues[qid] pointer assignment. The
queue must be published with smp_store_release() so the field
initialization is guaranteed to happen before.

Readers in paths where the read may happen concurrently with the store
need to use READ_ONCE() because any race involving a plain access is
undefined.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 51f985154aa1..bf9d51f2a508 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -321,9 +321,11 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	}
 
 	/*
-	 * write_once and lock as the caller mostly doesn't take the lock at all
+	 * fch->lock serializes concurrent creators for this qid.
+	 * smp_store_release() are for the lockless readers who must see a
+	 * fully initialized queue after &ring->queues[qid] is set
 	 */
-	WRITE_ONCE(ring->queues[qid], queue);
+	smp_store_release(&ring->queues[qid], queue);
 	spin_unlock(&fch->lock);
 
 	return queue;
@@ -434,7 +436,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	struct fuse_ring_ent *ent;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
 			continue;
@@ -967,7 +969,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (qid >= ring->nr_queues)
 		return -EINVAL;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue)
 		return err;
 	fpq = &queue->fpq;
@@ -1035,7 +1037,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 		if (current_qid == qid)
 			continue;
 
-		queue = ring->queues[qid];
+		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue) {
 			ready = false;
 			break;
@@ -1191,7 +1193,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
-- 
2.52.0

