Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D103E5589
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946554; cv=none; b=MT76MwFk46vR6+PrUf9Kf0QKVtRn2aCFsyr3d9DfAg12HJ1jgBB6vG6vFNJ5vRKxLmRn9wR5DdoqYvZBU1hHfnfzHKS32PKLlbzH2n07VjyhNOoXTCFXrbbuzM3ApDbKgjH5v1+gsP3dNt30akX/mNFIsq994bH2OnjjGxuefMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946554; c=relaxed/simple;
	bh=xFF3lSSBF4PfSIr4aBdQGr5g5KVYRTIexUn5lDRaoFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSvIrIVmKTNY1GsKRznoyxJqcKlnhyu+WhUXRLoJV3NoSp0lZPnaxmZCjTN5bUX7vjC6iCR8OZAvaSS9UjN4qg5q7TKXg1C675hHvQNyl1m4YMIKaU774U6X+931zb/126Ksm0LIPTS76gOeMjHYNXwNkhwafVfQTXnlSA9KLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu5bVZFy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu5bVZFy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso3044895a12.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946553; x=1781551353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE+QkRviOm15Lrq7IHBkUE4kg+YsYqKqrrbCDpmsEMQ=;
        b=Xu5bVZFyIhWTSLFiAPaM41AubUDIJQZ64DzFbtLFav0a0gqmsMaehsW+fJVNNmwDDH
         lAftKfb4TPbomPj8LyxJU6Xr/ZUynXUxlM8VLvoXtfDAvk28YsEMkiZMMrUjH+si3k1i
         /gxNpDeSjaATHzwNAyS9yDFnArs6oP4EJXfKTvvFxPb6Ze7V0cowqq5jjRnAgBwenQW/
         HOMF+GnJgyOtjIg3+XpyXVQvlB8jhvZ25moZT1krQ3SiOYAHzTef08a9ddnAKr0aB3fN
         dV8R+nyypxnuvCvnXMh160By6kM7YEyWQmlEB19jOu3RE02tDFGmR59iee6imxdqEdGn
         kvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946553; x=1781551353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YE+QkRviOm15Lrq7IHBkUE4kg+YsYqKqrrbCDpmsEMQ=;
        b=SC4ix8dabtC+WiKVj+46tyX6JH5ldaFeKdRhW7XGUqWn4NCFopiliAGUdohu39i3nX
         8tHuaSpVSZcu5IJr+A63bjQBSpTHBrMBAkBisqi/XqeX8/DhN6ohmo5qNIPH4bHXuX85
         sm9e2+PTp6hfMmWQGK+TuNNhANmNE0fV+7q4p51jYnou38OBGh9aMbg0czr/RZvu4b1l
         5FWyxGcnawKj7SqmzczJqHO24eg/SBY9RiLnEMf5izGh4wSR+Gx2ocOVoPO+GyQ52QAY
         eFGI9a9N+G3bjvVPJeXDaALuZx59qXlgTBBf+tMvrIJL6IjWE/0cZlqAExT56mQefQzm
         borw==
X-Forwarded-Encrypted: i=1; AFNElJ/gUFs8xXBWf24QMBbDt+VaqU1IMoMr9ZsnHuBYJbAqdPFOZqUXOPYXyvYSOYJItHTVdNcJEuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7P/zazLNhzd7Hve5tAf76rAwRTK2JiOBESZ5zHwNbriYmujKP
	kvB1zMUK5mfj25XTt2EqWOPVaDVdeQPSY51OZp9tVB3zgvCrf1laISxF
X-Gm-Gg: Acq92OHEZX9HHUBXPpuM48t7L6gqgLGynRZp0ZmpGKzduydqCBY3X/3kMqT0lNhp5yJ
	kB6wjIfJGRqftdpcvDWvom1ffifsP1h/V9RZlHzWpQ5DAnl+MFeUbg6IwSk+UugN7ol4139ZH/H
	6Kk0OUkVKZNPTiO7CqKLZzBNbEzcTfGHd+xynRYn34+RqmGjEXPR6BaJhd1JEDqYED9tR1fxajb
	gqHSYkqH3J8+ITTEl8iMEf+AGNeNBzXqa0HeHKC3PaMlCepGPKvxfAAGucf6UbwleINzzdhJTn0
	lxMrIklXsHW6uD3ubv7gCLwuk0u4gKZG3oioAN9tFqrjVw5L5y4GpqjZl6fGksaKiPQyZ/K5L07
	bFVkHIZ6WkIprQoO35ZPs5LuHtJqEb5GbJtgEL+sxqXEL6TC5ioJfponl2yEjEIC0+0SMW00M+h
	2oYJY0ImUk+bq0uSysLtwtPiHmsMum
X-Received: by 2002:a05:6a00:8d82:b0:842:46a6:e2db with SMTP id d2e1a72fcca58-842b0e88fe4mr18535319b3a.19.1780946552582;
        Mon, 08 Jun 2026 12:22:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821c5sm17637440b3a.32.2026.06.08.12.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:22:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	Heechan Kang <gganji11@naver.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] fuse: fix moving cancelled entry to ent_in_userspace list
Date: Mon,  8 Jun 2026 12:21:49 -0700
Message-ID: <20260608192149.23294-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608192149.23294-1-joannelkoong@gmail.com>
References: <20260608192149.23294-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_uring_cancel() moves entries that are available (these have no reqs
attached) to the ent_in_userspace list. ent_list_request_expired()
checks the first entry on ent_in_userspace and dereferences
ent->fuse_req unconditionally, which will crash on a cancelled entry
that was moved to this list.

Fix this by freeing the entry and dropping queue_refs directly in
fuse_uring_cancel(). This is safe because cancel is the cancel handler
itself - after io_uring_cmd_done(), no more cancels will be dispatched
for this command, and teardown serializes with cancel via queue->lock.

Since cancel now decrements queue_refs, fuse_uring_abort() must no
longer gate fuse_uring_abort_end_requests() on queue_refs > 0, as
cancelled entries may have already dropped queue_refs while requests are
still queued. Remove the gate so abort always flushes requests and stops
queues.

Reported-by: Heechan Kang <gganji11@naver.com>
Tested-by: Heechan Kang <gganji11@naver.com>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration check")
Cc: stable@vger.kernel.org
Suggested-by: Jian Huang Li <ali@ddn.com>
Suggested-by: Horst Birthelmer <horst@birthelmer.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 6 ++++--
 fs/fuse/dev_uring_i.h | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d9108b5b5db8..f4ba64a1796a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -511,8 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	queue = ent->queue;
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
-		ent->state = FRRS_USERSPACE;
-		list_move_tail(&ent->list, &queue->ent_in_userspace);
+		list_del_init(&ent->list);
 		need_cmd_done = true;
 		ent->cmd = NULL;
 	}
@@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	if (need_cmd_done) {
 		/* no queue lock to avoid lock order issues */
 		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
+		kfree(ent);
+		if (atomic_dec_and_test(&queue->ring->queue_refs))
+			wake_up_all(&queue->ring->stop_waitq);
 	}
 }
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 368f4d0790eb..22ec67e39ee0 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_chan *fch)
 	if (ring == NULL)
 		return;
 
-	if (atomic_read(&ring->queue_refs) > 0) {
-		fuse_uring_abort_end_requests(ring);
+	fuse_uring_abort_end_requests(ring);
+
+	if (atomic_read(&ring->queue_refs) > 0)
 		fuse_uring_stop_queues(ring);
-	}
 }
 
 static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
-- 
2.52.0

