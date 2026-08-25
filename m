Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA433938C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672027; cv=none; b=DaOqrL93XG59qzT5bLXwATMzjF1qtHNRONecmgj1OZ+TzYTwrcGWoXR5FwNL9KRPBXYVhf5e15iYR2k8Ua8jCIi/uUpAcXUzpm9+TXmItKrZ/y66E3w0gAaEMwgXbTGhw5p0LWY0hGlc72+PoWEPMI24nkjCDHQMRA4WywwxCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672027; c=relaxed/simple;
	bh=S6ZX/HBoSUKBJznf9hOjS3If2fREhigiroI9l77jDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj2LPClCzdTb4mkuclX0EblI7x7gx+uQlWeWUnJXfCfPMHyWClfgXM8YyY0li9ew5aHaxHZJHbAW2viuJjvJQ8E0qixekE/2qAmcCBjMCPZGaij/p2WiUankLyQ2+aaeJ4pBzTlj3/Q9plvYQ+LQyR4gf3KWIMlu2zkKPrABEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohcok/mD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohcok/mD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF171F00A3A;
	Tue, 25 Aug 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787672026;
	bh=DsnEaCCW/hwtE/GwWoazTz7ynd78bEMSYNgqLXYBhqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohcok/mDLKo10VMyrgRqDXdMFHdQoy1HXety+uzS+pso2Fr+nECdBm056T2v8wvEH
	 g3ZPAKoSzoJTDMWfHnyB+pjD0uTQhwFd9GoRwc7tGZutU8JN+5RYqg8eSoOglhf3CO
	 HqMUgWbCtTiyn3s2+zI2UXK0XWOAeEaCln6dCB/GRkvceAWrtk1RoH47z6SRR3My1E
	 wdrGNAuNsZB94mruyow5EpmKrxC6P7Y0spCCCkMe1YjtJdqHf1qYZI7bycyWHyJxEJ
	 pIX5gIj4Vwf3eVr/z56bckjGvuUdrfxUw5b1N28ikEQTIaHz0Hj/cVR3zWT/geVnO1
	 zLEdpxGV/N2IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] io_uring/futex: only mark private futex waits as inflight
Date: Tue, 25 Aug 2026 11:33:37 -0400
Message-ID: <20260825153337.4067089-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825153337.4067089-1-sashal@kernel.org>
References: <2026082442-slogan-feminine-7a8d@gregkh>
 <20260825153337.4067089-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 4d327bbd1cd2485783553b6b2b401aa475f90dd0 ]

Inflight tracking of futex wait requests exists to ensure that do_exit()
-> io_uring_files_cancel() cancels them before the mm goes away, as a
private futex wait depends on the mm private futex hash staying alive
for the duration of the request.

Shared futexes have no such dependency. A FLAGS_SHARED request always
resolves to either an inode based key or an mm-shared key, both of which
fail futex_key_is_private() and hence always hash into the global futex
hash, whose lifetime isn't tied to the mm.

Only mark vectored futex waits as inflight if the futex is private.

Cc: stable@vger.kernel.org
Fixes: 079afb081c42 ("io_uring/futex: mark wait requests as inflight")
Link: https://lore.kernel.org/io-uring/CANGjgdn=R_qyUdE=j9za+vkmqcxacbP-84OHXF4nZ4ho9qRyVg@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ kept 6.18's `struct futex_vector *futexv` declaration and changed `ifd->futexv[i].w.flags` to `futexv[i].w.flags` since `struct io_futexv_data` is absent, retaining the `iof->futexv_owned = 0;` init ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/futex.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 57a17c6942219..cccd1244c4b46 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -149,14 +149,16 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	int ret;
 
 	ret = io_futex_prep(req, sqe);
 	if (unlikely(ret))
 		return ret;
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	/* inflight tracking only needed for mm private hash */
+	if (!(iof->futex_flags & FLAGS_SHARED))
+		io_req_track_inflight(req);
 	return 0;
 }
 
@@ -179,6 +181,7 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	struct futex_vector *futexv;
+	unsigned int i;
 	int ret;
 
 	/* No flags or mask supported for waitv */
@@ -202,8 +205,14 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return ret;
 	}
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	/* inflight tracking only needed for mm private hash */
+	for (i = 0; i < iof->futex_nr; i++) {
+		if (!(futexv[i].w.flags & FLAGS_SHARED)) {
+			io_req_track_inflight(req);
+			break;
+		}
+	}
+
 	iof->futexv_owned = 0;
 	iof->futexv_unqueued = 0;
 	req->flags |= REQ_F_ASYNC_DATA;
-- 
2.53.0

