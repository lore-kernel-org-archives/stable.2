Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06962F83A2
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226727; cv=none; b=NFZpu8KArst0iKt/c9hf97A4/vuwgMVT97te8o3l4bqTAzwhc+OdTt471xydOEK+SGRXz1LyUhMmWFeSqosfShiL+4EcWtx1z98xVoRvWeVQ59pny3TteCVZv26dV7ZKHKTvWeMWyCvvkfi+W4L7O0WNv93LQKAqzNkQGKn2uaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226727; c=relaxed/simple;
	bh=auWZQCes1SYiM78Bx6ft/8N9YCMdvC6IGI3UHaeJiZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al5LDFyjD8xmMIKSbaaKoiZYQk+TNik2xwGE2w5tPUmUQnjU7ZLUSmkF+nltdMkTcnH+kDOIAUEumOePnXgBgfQAjo/YhHHuBAzzy6vRxiU9ioT+kAgLGyKYgOeZjws3MdVkU9l9doF5oEccnG/LnlAv3CGnxk+H5tdxLCYyXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKA+vLPT; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKA+vLPT"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2560340fac.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226724; x=1784831524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGagJXdwbk9EI4iOruUFfSJUOVbTgvDqNMG4+de3ekE=;
        b=nKA+vLPTjglMRbReFRDK1sz1ZRVLR2y5jK0JTqaCxK0M0wINoMRQZbo3BAnusw8DN0
         qOJ1xB0s8C/yyyT6Mma+uFIhUij70VA84qG6pQ9paN2o03RlZ4C7eQA0QaEHLoooBr6Y
         oCH1VyEgabadCPKBwOufCX8jNzYp0LLPotPN+8DLFZLiAfc2lCqGzdsIn1FS2/AoJ8Y1
         Ru2Q175dkJYBahhU8ACbci/MrjJNUxzb33w6WHBIA/wJib+kE2n5D9VHXPhltASYual3
         yB8OihUXlk5qIQLQdA1rdpdqhDx8hb4WkxeCoyDM3yvHKuN6N+NmoDOn14ksNhDmaC3T
         uefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226724; x=1784831524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGagJXdwbk9EI4iOruUFfSJUOVbTgvDqNMG4+de3ekE=;
        b=Ah37p2YshV+feROaYxLk+8r7QNh+IKUAANb1pK9H1kwZwudfv0JWtPXaRO7kLteE7I
         rfVOVgClMSWI8A+Eo1qNImHEHhTtbe9auJsrfpDsjzJg0JocVgbOQt1WJKPkNB2QPek8
         QYlwIrVlrkmjudV07kyxtur0apY8b87BsWesUHN46n4cbPpVlgj9XP6vzVXsoI1TE+WN
         Bps+t9LIAuuw1/kWkqiw5pFaGoDNioJ2hjSUYQ9U5zcA6+qRxdbH8YiOG6RYZCsrMCwF
         wFAPtpHhbvS64R8PWoOGHRGFrTLEasxBuO7d1TOI5Rc0HSftJl5N1jHSz/w/Z8u+knLr
         ebZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSRcL3tZOUd1mPk8IgLmeI1y8nWuSdYlRlgH0zT8oLlX0xMOZu0uWQ65nvQ/HGgEX9RfBg41E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EkqoJ0uee/2PrhVfl70Y/nAnrDFQLFECBMBU5tKF7MuPMy0S
	YCRMt90PBFsRHquzdxlLlE3XPIW0A7rRp9hVu0jowabNcpXsmeHmvQKK
X-Gm-Gg: AfdE7cngCwdl5ATvXGa7KI6LNBeGOfGWia7H9sLHDE7EGWajuSi4gznr3QGHPyBd1Bl
	g/r/7eaRdULfLhCwF5/rXyLpT2A2033xPqwvKJTUmA6/8hncCuQwPUsaiuGsBmCx0m6OIAHT7eS
	rDeWrtkbWb1AlZxbOyby38vIOuvikkyRNUb7JYi1G5jhg+oCqy+kPZArDjTV0qPYMsl8UYGBmwz
	ZDw11fwTLjA9b/wDTakdzryOqfoZma8YvrEl3DFSVzLgwnywX65iqYMZAMkrEFU4VS/6KReWhId
	60gsK6hq6+9G745L2S/IRyCQDZEsFak4mLIyU+d/8adBzOy5sQ80c1QhcVj+GvMNc9PiF2BFsV7
	Y6NnofhG/wOZYxG1cwV4gs98WMvxvCPJjaubhMNr8SggdxVe9DnucuIsDDQzSbGdGFUB7zETVn2
	3iIdCyBN4UQ8lRvCjgf7770+9YpC4wJGXURkP7sL136KGrKkbjtpLh7A==
X-Received: by 2002:a05:6870:ac14:b0:448:558c:d83e with SMTP id 586e51a60fabf-4562b5c0edcmr4919538fac.35.1784226724564;
        Thu, 16 Jul 2026 11:32:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451ff78897asm16645430fac.17.2026.07.16.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:32:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] fuse: publish io-uring queues with release semantics
Date: Thu, 16 Jul 2026 11:31:44 -0700
Message-ID: <20260716183144.2710480-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260716183144.2710480-1-joannelkoong@gmail.com>
References: <20260716183144.2710480-1-joannelkoong@gmail.com>
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
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 51f985154aa1..c8488ebc1d1f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -204,7 +204,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 		return;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 		struct fuse_ring_ent *ent, *next;
 
 		if (!queue)
@@ -223,7 +223,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 
 		kfree(queue->fpq.processing);
 		kfree(queue);
-		ring->queues[qid] = NULL;
+		WRITE_ONCE(ring->queues[qid], NULL);
 	}
 
 	kfree(ring->queues);
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
@@ -1332,7 +1334,7 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 		      ring->nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
 
 	return queue;
-- 
2.52.0

