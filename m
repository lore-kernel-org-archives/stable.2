Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD23BB9F3
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201007; cv=none; b=KI5jRt3JXXJPq6M7Ys87ULilJlx9I6kknxTkSOAzz5q0I/P4wBusrjVfX6g3Mk6bM/MdwbSYh21AHQSfVMNcQApsArb5iBEM2lCLbiItrGVKH+MrhW8+362i3R7N7SKrUe2EPl4W1uVc/X/ecGKZ58trZr4KqcXD0raNKN7IG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201007; c=relaxed/simple;
	bh=M7wvg3m5W+10SWmBXFSMNSrargExtq6wC7CsCshS1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAYuSPDc9WLy0T6naqWInS2H3BXyWlAk/I+5PgNIhNfjG3zwQmoqHS392U1oYdH83guot5brFfS5j8dyJK7+qaBQE4wguKcIyC2jOlGS8VTtMxFH9SLuSENaI4IPSZzHwkD+PlLe48Cxf9/s26/rJCrLBadeujU1+8Oao0Laq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol8sMBhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol8sMBhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2ED1F000E9;
	Mon, 31 Aug 2026 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201005;
	bh=dgJjHhe4Fz/zBeIwS3RW4EUTx8Yn4UxWhvXPuJojrmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ol8sMBhhUm6IxMnfcf8ngvHSHtO5ObEdACM4oXgyfjPxxXvTHXVVwSGevJT1OIeOR
	 I1+ApwbmHuV8W3By5lLA1w7wfLk2/925KTUcBMzKrvh5XZkQZAE6B2S5lnwfEuxOL/
	 17nIwNeCgOqhNqaFMxNgDIdsaT+WVA+k0r9xVciThj5mvhRbR544TiXW80TlJn5TgL
	 Yq2IfAAkEEgQ5+bt96z5yeOAU7JyVOqk6VjuslMzDll7kyoxyA5ns7g0gMdPxmYdOi
	 10/xVie37317WHLl2k/uE0vGnDP3h4X4EA1ajKsLKRkcUv5fwcnWrbfYZplpMxPSIV
	 7JipYkgjWlsJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] fuse: decouple fuse_ring creation from ent registration
Date: Mon, 31 Aug 2026 14:30:01 -0400
Message-ID: <20260831183002.1670211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083141-juicy-elated-cee2@gregkh>
References: <2026083141-juicy-elated-cee2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 6330b1f61ed1d17850fc61bdb8920ca1056e2cf9 ]

Currently, the connection's fuse_ring is created lazily on the first
FUSE_IO_URING_CMD_REGISTER command. A server registers entries from one
thread per queue (one per CPU) and those threads issue their first
REGISTER command concurrently. They then race to create the single
per-connection fuse_ring, which required open-coded handling in
fuse_uring_create() to detect and protect against concurrent creations.

Decouple fuse_ring creation from ent registration and move it to
FUSE_INIT reply processing after a server has negotiated and set
FUSE_OVER_IO_URING. The ring is published before the connection is
marked initialized. fuse_uring_register() no longer creates the ring and
it instead uses the ring set up at init time.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c         |  8 +++-----
 fs/fuse/dev.h         |  2 +-
 fs/fuse/dev_uring.c   | 26 ++++++++++----------------
 fs/fuse/dev_uring_i.h |  5 +++++
 fs/fuse/inode.c       |  4 +++-
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37f..9ab1f1f551ce0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -75,6 +75,9 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 		fch->minor = param->minor;
 		fch->max_write = param->max_write;
 		fch->max_pages = param->max_pages;
+
+		if (param->io_uring_enabled)
+			fuse_uring_conn_init(fch);
 	}
 
 	/* Make sure stores before this are seen on another CPU */
@@ -411,11 +414,6 @@ void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc)
 	fch->conn = fc;
 }
 
-void fuse_chan_io_uring_enable(struct fuse_chan *fch)
-{
-	fch->io_uring = 1;
-}
-
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
 	spin_lock_init(&fpq->lock);
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index aed69fd14c41d..8d25378c09183 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -22,6 +22,7 @@ struct fuse_chan_param {
 	unsigned int minor;
 	unsigned int max_write;
 	unsigned int max_pages;
+	bool io_uring_enabled;
 };
 
 struct fuse_chan *fuse_chan_new(void);
@@ -34,7 +35,6 @@ void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val);
 unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
 void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *param);
-void fuse_chan_io_uring_enable(struct fuse_chan *fch);
 ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args);
 int fuse_chan_send_bg(struct fuse_chan *fch, struct fuse_args *args, gfp_t gfp_flags);
 int fuse_chan_send_notify_reply(struct fuse_chan *fch, struct fuse_args *args, u64 unique);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c6..55e0ecdb20582 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -238,7 +238,6 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 {
 	struct fuse_ring *ring;
 	size_t nr_queues = num_possible_cpus();
-	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
 
 	ring = kzalloc_obj(*ring, GFP_KERNEL_ACCOUNT);
@@ -258,12 +257,6 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 		spin_unlock(&fch->lock);
 		goto out_err;
 	}
-	if (fch->ring) {
-		/* race, another thread created the ring in the meantime */
-		spin_unlock(&fch->lock);
-		res = fch->ring;
-		goto out_err;
-	}
 
 	init_waitqueue_head(&ring->stop_waitq);
 
@@ -278,7 +271,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 out_err:
 	kfree(ring->queues);
 	kfree(ring);
-	return res;
+	return NULL;
+}
+
+void fuse_uring_conn_init(struct fuse_chan *fch)
+{
+	if (fuse_uring_create(fch))
+		fch->io_uring = 1;
 }
 
 static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
@@ -1176,15 +1175,10 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	struct fuse_ring *ring = smp_load_acquire(&fch->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
-	int err;
 	unsigned int qid = READ_ONCE(cmd_req->qid);
 
-	err = -ENOMEM;
-	if (!ring) {
-		ring = fuse_uring_create(fch);
-		if (!ring)
-			return err;
-	}
+	if (!ring)
+		return -EINVAL;
 
 	if (qid >= ring->nr_queues) {
 		pr_info_ratelimited("fuse: Invalid ring qid %u\n", qid);
@@ -1195,7 +1189,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
-			return err;
+			return -ENOMEM;
 	}
 
 	/*
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 55f8d04e4b0b2..d721a4fc0215c 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -135,6 +135,7 @@ struct fuse_ring {
 	bool ready;
 };
 
+void fuse_uring_conn_init(struct fuse_chan *fch);
 void fuse_uring_stop_queues(struct fuse_ring *ring);
 void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
@@ -174,6 +175,10 @@ static inline bool fuse_uring_ready(struct fuse_chan *fch)
 
 #else /* CONFIG_FUSE_IO_URING */
 
+static inline void fuse_uring_conn_init(struct fuse_chan *fch)
+{
+}
+
 static inline void fuse_uring_abort(struct fuse_chan *fch)
 {
 }
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d975073c60296..ce4891a04a378 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1272,6 +1272,7 @@ static void process_init_reply(struct fuse_args *args, int error)
 	struct fuse_mount *fm = ia->fm;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_init_out *arg = &ia->out;
+	bool io_uring_enabled = false;
 	bool ok = true;
 
 	if (error || arg->major != FUSE_KERNEL_VERSION)
@@ -1402,7 +1403,7 @@ static void process_init_reply(struct fuse_args *args, int error)
 					ok = false;
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
-				fuse_chan_io_uring_enable(fc->chan);
+				io_uring_enabled = true;
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
@@ -1432,6 +1433,7 @@ static void process_init_reply(struct fuse_args *args, int error)
 			.minor = fc->minor,
 			.max_write = fc->max_write,
 			.max_pages = fc->max_pages,
+			.io_uring_enabled = io_uring_enabled,
 		};
 		fuse_chan_set_initialized(fc->chan, &cp);
 	}
-- 
2.53.0

