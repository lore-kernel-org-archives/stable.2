Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336946;
	b=JhRD094kdorMsIQS6wmhHaE7se0iYCiTvpzvVzmV858sJ/GBgVod5tNK35dnX7AWgMor
	 DKULDZcOBfqeTsvfbM/nvZB5HFvRx5fKZwxBM3UxrrNWzNLqN0QzaYWq+kW/i5fe2fLn0
	 +80PWpgD/Hk9i/NdLlfON4W62Nc+kkAPoO4ABjWbkaFVh4S3EfVQCPbZ0dV469HGWrYPw
	 by54sXdDp0bV/e8QwFGTnyEa7YPAGBcCxjubWvl+v+4+mVB5zYlMaI95k8j299HtBh2wm
	 eruSTuOZNw7Xs2QwGpgPy59pQDZS0vBknBJx94eb+WZ2oGUAKGYPKI4A74dX3j7jP4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AN4mPCR56QHDM1752/2Hrgh36DvjiEgA//B44NynvFE=;
	b=ElCLWMGLwXdLnNnjs8Jl943ecGnAw0TIeodl3n7XMV2EFp9jfw23XYLcrkm0po8XB+lf
	 DGW/EK/XiXlmZ4cI/Dp9Qog+IItaATnDDL/XNyASrb1Mz0DS+aikLY5S3P37iJzRQ1fei
	 1aeWGrZT5kebX+gXFoiI0HdT8ByGq6RjLn2VvbxQC4Cc5PHgke4djaueBWWnmkAjGa40K
	 nXVbXfApAG98EzNQQ7u56l0VgIBmnfGzfi1xHoRT327ece0z7dUaeHjgt8MjL3df9Kc4Z
	 nVVpiQPMtSYRSy5sY+liEUI3p9rbqc3WLV1Kp3UobuERaRVGdqE+bxoTfWERQm9nFqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLG52YTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE5606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLG52YTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F071F0089F;
	Tue, 10 Nov 2026 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336946;
	bh=AN4mPCR56QHDM1752/2Hrgh36DvjiEgA//B44NynvFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLG52YTBoHZxhDrnwlQKKrUFWjY1epGDQ3tebSIAGTqGMHogrWR0rQW1QEOgvuSRA
	 3ZRc5MQe4T8r0I6NQp/gp2swX3dls/Lj7j7A6jZocxf/85BCEFVCTlp2xl9An8vPFH
	 A2JaUmywk09PqU+aEHgEnBdbrou6Q41VJiEztf0I9FewdeSX/4nl0H3XycM3txsafO
	 JbepG546vi3dBNjLpR1CcTeWOhjz88Yg4d8b1gk/FwmIOT+Q9ooILow/wykX05FjH/
	 D/OUT+UDhXBBCagSRTJ1mKXb7xo+sw1n/nJYlOFwIuBZEUAv9S6rINatnA0oh4hKtD
	 l2ohPyKhAcGpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 13:55:43 -0500
Message-ID: <20261110184424.3240758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053609-failed-6.6-5364d081125a@kernel.org>
References: <20261107053609-failed-6.6-5364d081125a@kernel.org>
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

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit 68b69fa0edb241a946cd4c850110990f30705164 ]

Add virtio_fs_verify_response() to validate that the server properly
follows the FUSE protocol by checking:

- Response length is at least sizeof(struct fuse_out_header).
- oh.len matches the actual response length.
- oh.unique matches the request's unique identifier.

On validation failure, set error to -EIO and normalize oh.len to prevent
underflow in copy_args_from_argbuf().

Addresses the TODO comment in virtio_fs_request_complete().

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: 5364d081125a ("virtiofs: validate fixed-output response length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b1028a4dbb991..7b1e9291c3ef4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -564,6 +564,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	req->argbuf = NULL;
 }
 
+/* Verify that the server properly follows the FUSE protocol */
+static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
+{
+	struct fuse_out_header *oh = &req->out.h;
+
+	if (len < sizeof(*oh)) {
+		pr_warn("virtio-fs: response too short (%u)\n", len);
+		return false;
+	}
+	if (oh->len != len) {
+		pr_warn("virtio-fs: oh.len mismatch (%u != %u)\n", oh->len, len);
+		return false;
+	}
+	if (oh->unique != req->in.h.unique) {
+		pr_warn("virtio-fs: oh.unique mismatch (%llu != %llu)\n",
+			oh->unique, req->in.h.unique);
+		return false;
+	}
+	return true;
+}
+
 /* Work function for request completion */
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
@@ -574,10 +595,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct page *page;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -633,6 +650,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (!virtio_fs_verify_response(req, len)) {
+				req->out.h.error = -EIO;
+				req->out.h.len = sizeof(struct fuse_out_header);
+			}
 			spin_lock(&fpq->lock);
 			list_move_tail(&req->list, &reqs);
 			spin_unlock(&fpq->lock);
-- 
2.53.0

