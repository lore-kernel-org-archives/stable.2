Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2962274FD0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965023; cv=none; b=jaWvMWCvWrRnVc3Av1jZMlK19fpNyTChXGd/3e4mMXFkNAFJLXeY+mS0HZ/t06lxR1mldygHVmmVg2doWH1XOVQzJ/JfXZJDAjbf4B1luzxAF3IY0lr+EdT05jbg4kw/3B19P5OmtJWVflrAGIHMKP8A3XyH9jBXzqRyZaTW8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965023; c=relaxed/simple;
	bh=SVHq+/kO02mzIskKkEksKkfsbEZwLNF9WCyiSZCeee8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs42FKGUoLNi3rYZsodWgu/3R15L/7dGiq1Oh/ykP+Qy3i0il604OAEFHXtd/FrbSP1xrU87VJrWkhnpDNz37M3fRPv3rZSZ6JLP2IqFtNtxZQAGv4YBrF8GR+AOfWcp0IKGisRfgG+EcQJXxZu/Ou7p7lMR56sVtCwQez28QrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioVeVbPF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioVeVbPF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c27fc587ebso6423935ad.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780965020; x=1781569820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWu3hw5PgVLWrMCQT6BQQXF2x1rCbMDcemQvj9Nivbo=;
        b=ioVeVbPFtxLrNtyuWRJ5ZJEjKX6xRlzBEZ4KrmH0zDlQ3JeEdaoGk2cdwspyntHUn9
         DdG4NnkINhpQpERE684m5OBXCw9sJq/UC/yDJXSVL3mYpMMCn5ys35gRO2BveRqu7HR4
         B2VBuh1vdo+q46bHmRFgPpDI0oO9ltUEJElh3HLN1UupF6w6jumT72MzMzMEFC0auBJK
         1ml6X+CLvzEPiITiHcB4t6tFRVsNIxNmlTMpm/03lfbs1pBosXGOTWzYlz8DtUxY7R+S
         hWUZJtzRpzKX6nwdpS4V2mjaKklC8MEMtMKrsP+4sz2zsG4REJ5tO1PdImKI3UWHZiDB
         sG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965020; x=1781569820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWu3hw5PgVLWrMCQT6BQQXF2x1rCbMDcemQvj9Nivbo=;
        b=eqrtf2hiJYX4JawqXocgWoe7KMTtx/xLfmOQMkz+t0ruIuYRJxYePxZ8sGgQUP54xJ
         PtjjPASzqVZjPMP7/cbV787GRuBvCb+++CHISK/O+/o5fVy3pw6l9topGD0APp3dbj94
         u6mzz9zVnlX/K/fk4mYfBJKhIlbEwfyEzb9Jb0jVzg7SV3moQSg/f9tRPFE6HaGIQKnE
         snUBkpn93rNsshrtgaJBu92Js9bLNHzx0pXmRfkJYtrlN9sTpaAHvz2RitnaeysMEJOq
         oDN1e0dOUh02/Xn/WBZA5oPoHbQeR5ySu+C30m0Y9ieC2ED3F2kpU2A8Abc2C7cCRPlU
         o86A==
X-Forwarded-Encrypted: i=1; AFNElJ8WcdWmeCyoeTyPOwN/qr1jEb4G3lZnBkfY35m5HiSdrVHO3WYP82GKYZpy9jW2g+/hjhpKc4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ6w9cbSdjaB1H8GrXCDsmXFI2ppo/fc4qwSVzQtPq7lPxC/t
	9otAowsMv41b10+Z692BhxPKEoAR/6kvcfPI4AH1YhDfRKN4t6+JLeBR
X-Gm-Gg: Acq92OG+7Zn8ODxuArhardH0OGq0Q10j1YcCc8STt1lDCvXO0mkyAJuWFCzK3DYqWCm
	hq/73/MCLyCcxqXOL9hMXZjvGhk5q5yt54ygrOibrtiCQnasWTbatxYa16xRKsiDwak0recVK+W
	rGmihj2ygjb4RKzbyX1SoJgxKjCzNbnyh8Z55+1ZbPlSqMjXV3oAQ5hu6ase+zO11/EqyHaZGhY
	QrIqFDTx7bK+0C9/r4/c/sUBRG5BlYsoZlvzwbKMBCzVzv0xvt59hHWLAjkM/fIAvKPr5jsTfuN
	rL8gPoRqOIDcVICvNR94Gtp8+hZviYrNo7Hhi2v8SF4iYIPsH4agU2jDnOUoxrflRF3sLX/Wu6R
	Gp1QkkRMMyaCkMzUBORAkSJVjxhSsQ1zD8u6SYgYncYRtd2qP9vBXxb0jjd8p3nP86N8scCbirP
	NFmECnynWfinj/7yOYr/kyyk07YQYaoqQ8GZ/2hDclxEfqFxEJ8GC663ezNlxGBdtAOk6WUHp8w
	Ejd8RZCXSRv4g==
X-Received: by 2002:a17:903:908:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c1e80ff89amr219953885ad.31.1780965019688;
        Mon, 08 Jun 2026 17:30:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa404fsm191265615ad.37.2026.06.08.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 17:30:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	fuse-devel@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: end fuse_req on io-uring cancel task work
Date: Mon,  8 Jun 2026 17:28:55 -0700
Message-ID: <20260609002855.3654601-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

When io_uring delivers task work with tw.cancel set (PF_EXITING,
PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
fuse_uring_send_in_task() takes the cancel branch, assigns
-ECANCELED, and falls through to fuse_uring_send(). That path only
flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
it never discharges the ring entry's owning reference to the
fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
dispatch time.

    fuse_uring_send_in_task()
      tw.cancel == true
        err = -ECANCELED
      fuse_uring_send(ent, cmd, err, issue_flags)
        ent->state = FRRS_USERSPACE
        list_move(&ent->list, &queue->ent_in_userspace)
        ent->cmd = NULL
        io_uring_cmd_done(-ECANCELED)
        /* ent->fuse_req still set, req still hashed */

The fuse_req stays linked on fpq->processing[hash] and
fuse_request_end() is never invoked. The originating syscall
thread blocks in D-state in request_wait_answer() until
fuse_abort_conn() runs, which can be the entire connection
lifetime. For FR_BACKGROUND requests fc->num_background is never
decremented either, so repeated cancels inflate the counter until
max_background is hit and all later background ops stall. tw.cancel does
not imply a connection abort (e.g. a single io_uring worker thread exits
while the fuse connection stays up), so this cannot be left for
fuse_abort_conn() to clean up.

Ending the req but still routing the entry through fuse_uring_send()
is not enough: that leaves a req-less entry on ent_in_userspace, and
ent_list_request_expired() dereferences ent->fuse_req unconditionally
on the head of that list, which would then NULL-deref.

Fix the cancel branch to release the entry directly. Remove it from the
queue, complete the io_uring cmd, end the fuse_req, free the entry, and
drop its queue_refs (waking the teardown waiter if it was the last).

Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
---
This depends on "fuse: fix moving cancelled entry to ent_in_userspace
list" [1] and should be applied after it. That patch removes the
queue_refs > 0 gate in fuse_uring_abort(); without it, once this cancel
path drops queue_refs to 0 with requests still queued,
fuse_uring_abort() skips fuse_uring_abort_end_requests() and those
requests are never flushed.

[1] https://lore.kernel.org/fuse-devel/20260608192149.23294-4-joannelkoong@gmail.com/

Changelog:
v1: https://lore.kernel.org/fuse-devel/20260605192708.141921-1-joannelkoong@gmail.com/
v1 -> v2: 
* Also clean up ent (Bernd)

 fs/fuse/dev_uring.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index fa807aa4bc2c..4256530281fb 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1236,11 +1236,21 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
+		fuse_uring_send(ent, cmd, err, issue_flags);
 	} else {
 		err = -ECANCELED;
-	}
 
-	fuse_uring_send(ent, cmd, err, issue_flags);
+		spin_lock(&queue->lock);
+		list_del_init(&ent->list);
+		spin_unlock(&queue->lock);
+
+		io_uring_cmd_done(cmd, err, issue_flags);
+
+		fuse_uring_req_end(ent, ent->fuse_req, err);
+		kfree(ent);
+		if (atomic_dec_and_test(&queue->ring->queue_refs))
+			wake_up_all(&queue->ring->stop_waitq);
+	}
 }
 
 static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
-- 
2.52.0

