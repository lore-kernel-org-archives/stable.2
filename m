Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4933E5A18
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946548; cv=none; b=sTqLVRVFVdPaj6fRCwoZ8QopD+zmDZCdtmnoIiMLRJyx6NJB0+NdvjC88l226eJ1WriQ/7dh4sfpqpXDL3nY17nDs07NWzeLUR9btOmxsJb8k+LHqFSWd6Fb135wtE3xnp7k5icWuqEAQgsqJJc8ea0yUnBDX4oyhP//89Ubv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946548; c=relaxed/simple;
	bh=AHd5YeVtutAbZkxadD/aQY5HB+EyJsk8qeRwSqLawfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNzQgaOWJluMuJYO5Ie3jP702ZTeRlgswdH8gtpPttm/HVSg9KCoPogcjZ92JhhaQB2Rc3cCPmnotjXe0NJnbe+gTOtx5kbOpes7tGYM+uzlOZRonDIqgS8CsSm17egSFij5CzWr9CfCDcwL/TNxyB6ekDXkP22uSfRtdbq0thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKM8r0xy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKM8r0xy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2872036a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946547; x=1781551347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwMIyvXLF7QVH+M7je+E+kLYonxVYHkOjT0cHPKyEmk=;
        b=TKM8r0xyNkVzpCK+91xEelzie3435ZR5AwjScygnhjG5j2zoTBi5ofsxika2NU0D1b
         x1qclK/L/Hj2av22Iscm2hQVyb8OVYM5dTJte9C4TxjtCDQiK3maXH0EpN2P8EHCm8S+
         OoNTfJg52ffDxXY6mi1rO0E3UT/85v0phsguF59/4hjo2ATjJACqrN6EmzwIqdwHXiW5
         CjeGcXKxUagMiVpBhqRDs2Rd01Ag8DjRc+o3Kz/v0HoOoM7BZJ6JHzxvral/Kx2S9ngn
         uHdv87+FUhY8lTGiPIG7/hWMf8/WXS7LZvg7aqnULe5O93rRMfRrzVXPqE70avRFTH5a
         fU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946547; x=1781551347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwMIyvXLF7QVH+M7je+E+kLYonxVYHkOjT0cHPKyEmk=;
        b=jm8Ha02X/T3oNK8LUmCVcEHo8R8lhfzTINXdMx4vaNZBBqaUq0IQaj1eQ+RizyU5Fi
         16dj1g9aGACOgNRC1pslZDkIL3nViPKsZUPz7KHFo0CiSL4oOTRk1D7TLtxdLFNY5Ro3
         /c7kwC8XRgGajYVSrINu/Mzc+SYPdRp+j7+YgZg9BgXcv02bn9eda0og6thRiYVOa6LW
         ON6318RiejqEYg95gy+J2LkFMzt5lfawDF6SsF4voPTJNDaKBrx5FAW7G41srOJ68X3F
         UBp+VvEQrKdjSd33l8svPMODbzFgvt39sadw9iqlw2YdBhaWfkcieAVYxjU0fvuVeRa9
         e6Eg==
X-Forwarded-Encrypted: i=1; AFNElJ965tdizBvrtLR1JF1KZirK0kC6p8d1U0EWDU24MybxvxUTId06DjcPLcujf5e7Hbtcrvkk2JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSk/AnpM7mDAHHzyle1Zx+ByMoASHMjdm+yicSvwzCvTH7+wW
	oqdpT8n+i73KdVE8KqIbzQVxwSEPby1hQTpZFwkS18Mf+K7iRhROShBmWzCOCQ==
X-Gm-Gg: Acq92OGCCw86tsYy3lLbqwbIt7voY0yfBeHSPEV6w8pgUdNB08GiReowTep8/NYO8Wa
	tuwZYVIsMvyK3zY4pA1wDEhBOVUZY39Gxr+L0ftWCoprgH0/xogpQUd2BGO9Coj2fh1993gaJ+p
	wqCrJ7+4YZqsN+3684pSiVkNiJSX6aEKNUAOTxvXKI9GdrZL40uiCsJN1RrZCso/h3VxmpjG2X0
	LaKWS8d9/TC8IgotxvPpyYUKADe8Y6ckP7iD8Ub8sbJ7XE2JQL/+8B7+7rUyXCUAN5FW9y9UHzg
	H6AipVIoJjNaxTvbkPGCEnHRxOL6L5g9gks+n0MfB35q67Sz59p79KHkzaR8TuRvs+/20gjyxC9
	2DFQd6P+by6nfcYsmVMVmlBkDk+aRhi35HZTXg/gxMdl7SB5CWVlLoUCfDzHKS4aTJZ5DWkXUAz
	OXEYt7qu70doYHJyvb5HnoPbyWdS0=
X-Received: by 2002:a17:90b:514d:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-370efda7abcmr17435561a91.17.1780946546919;
        Mon, 08 Jun 2026 12:22:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm17045538a91.12.2026.06.08.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:22:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] fuse: fix race between registration and connection abortion
Date: Mon,  8 Jun 2026 12:21:47 -0700
Message-ID: <20260608192149.23294-2-joannelkoong@gmail.com>
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

This fixes this race:
- thread a: io_uring_enter -> register sqe ->
  fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
  yet
- thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
  fuse_uring_abort() is a no-op due to queue ref being 0
- thread a: grabs the queue_ref, queue_ref is now 1, rest of
  fuse_uring_do_register() logic executes
- thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
  and calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
The abort/unmount thread will hang indefinitely in unkillable state as
nothing will decrement queue_refs or wake stop_waitq, and the ring,
queue, and ent are leaked.

Fix this by checking fch->connected under fch->lock after the created
ent has grabbed a ref count on the queue. This ensures that in the
scenario above, it is guaranteed that we either release the queue ref
and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
waiting) in fuse_uring_do_register() when we detect !fch->connected, or
if the connection is aborted after the check, it is guaranteed that the
async teardown worker will be running in the background cleaning up ents
and decrementing the ent's ref on the queue, which will unblock the
eventual queue and ring teardown.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: <stable@vger.kernel.org>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e467b23e6895..99ebb7c9cc61 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -973,15 +973,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
+				  struct io_uring_cmd *cmd,
+				  unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_chan *fch = ring->chan;
 	struct fuse_iqueue *fiq = &fch->iq;
 
+	spin_lock(&fch->lock);
+	/* abort teardown path is running or has run */
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
+		if (atomic_dec_and_test(&ring->queue_refs))
+			wake_up_all(&ring->stop_waitq);
+		kfree(ent);
+		return -ECONNABORTED;
+	}
+	spin_unlock(&fch->lock);
+
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
 	spin_lock(&queue->lock);
@@ -998,6 +1009,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fch->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1114,9 +1126,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-	fuse_uring_do_register(ent, cmd, issue_flags);
-
-	return 0;
+	return fuse_uring_do_register(ent, cmd, issue_flags);
 }
 
 /*
-- 
2.52.0

