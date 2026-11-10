Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340257;
	b=ybsv2kMNHXzYrASrXnjMFyKy/BSwOqL6H1rFSrWtnpvl0u23wXtn9L6oIRh5/3rw6xoP
	 1tELOgAYjq029TmvrCUKg9lV+OHkhXwVuX4rvcz0uxkaW9MfEniCZ/da/COpiWU/fwqAZ
	 ZIRNdxRQyzHQt2otbz3gXFmo6XSfhBUvQsTa9hqrXcJKB62enTNLpODtu9ICb0jMGTSaN
	 JCfLoOwe/HHAGXrYzmlgYiC7zkzeuKjCYQCpxcJ1s0SjLqkL+qVGrykdvDiwREI1a8ES1
	 Pl7UBhiC+ECKGeutbZogq3z8rT1R9lKqZfEZuufyXNwTox9VJj+cCh/x99wRhUFZg7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7gA0XK2dSpHfQr7F+RiqV5Im6Wmq0zmVJpkM2ZwiFUk=;
	b=Ed2bGr1968gbpGnWNUT19Gfdka6D/rhLoYLHTK4aVaF8FVUaVIzU2F23X/KU5JW7uYw1
	 X7i8qnpvvGpbCkmaQCH9Qp0O9if7UvjGtCGIT97hh8w1eeJ5haa0eYDlxbnBgkKpfiQE/
	 6Hm2Svov0raDQL/W03niGzZ7p5PklmBBIcRz6y47o28MukYyVbdvSIu2Q/jxQjLmbyhcw
	 R6p6BjLhH3G+0ZR0/D9yDaNxUDw1EcoR/43BSLU++gXFXlRhW+Gp3kKgs3EOyCRasZSaB
	 Rg6lbYbyP43IQhc+32ZOK8pikOqogrT6oqhiU3YdwT/abx+DrcPXWbWAE1xGdU/sWXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbn1St5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C70606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbn1St5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D557F1F008A6;
	Tue, 10 Nov 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340257;
	bh=7gA0XK2dSpHfQr7F+RiqV5Im6Wmq0zmVJpkM2ZwiFUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbn1St5xrsgs93VapqrzIq+cbCCVlxwaz0Chsn1cgK0mTjShyU7llNFxJwwo56llk
	 DNm7xuqVwXnTdv+oZekqEAfXW0ijriVy2bXl2e/lFct/o633kCe3AG0FCnB4L/cAW5
	 Qi8sYWj1PaubLJvbN+aNFU1zRyva9AZUsfU1Y7uaBdhRvGWuIbiiZ364z/sQGCuLpL
	 pKBb/nc0E9t4F9NUAw4bDVNxiyMmgmyJ9nPtzmbIqcfatKOmVVClCjjmzK+VDIz2TU
	 j2pb5jU+6+OLJn8OvgVM1E7CKJVJJtWbIjgyM6vNqtUicgacb+J/MS0dh/AWKN0WoF
	 mSEhyZZVXsLgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 14:50:53 -0500
Message-ID: <20261110194003.3568480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060741-failed-5.15-5364d081125a@kernel.org>
References: <20261107060741-failed-5.15-5364d081125a@kernel.org>
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
index ba8d5f5dbeb01..c375a5f001056 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -551,6 +551,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
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
@@ -561,10 +582,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct page *page;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -620,6 +637,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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

