Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341391;
	b=V4BWGHGv4/uLfZoSenis/UKkyr0y1VNe+I1l8hUsXajwfVMCVc1RGsnHWlQihboq9/Rm
	 r7fJNmuVpfv4iKtjlroCzo9a3606kgu+aYREjgKbqbL7si9mc2ftmecDRv6e6yNjGI8bQ
	 XTbI3U2tSom32uMg4FXXxWAJqNFQBM98UL0rEqbOsWSlmFp9yTLyh5+jz9yBLYwjj8BRy
	 NjQsTGnMw/M8RgH79ZthcA1dG2koh5WOmntjR8jwV5EN4zOJQzZ5L3W18+CN7CDkJ25El
	 Fz5VMgAlvPDwOiWT3EnGAhnqafGaSOdOqpdn8As/eT/Una0MGsANI2g5qcoKnQaVbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0lUT8qoFUQi3Mn2PXHLIuyCnRmHTLmfyvmAKeX/GnZ0=;
	b=GsJjna+Ekv7tXHSMGeJI04pCSf8Ei96UGNuewp93Dg2IITwuEYyYalK0mneJPV/bu1bV
	 DhikgpC3NwCAoksTJZhXrJE183rqTO6f8ubK5RwmrHwHvb26Q13vw8WUtt8ahEo2+npGe
	 rhE/X/qoAfFWUvDdfpUXps1vnvzrdRORucmxt4HY0/fd+FGP9FXdEuHRX/AZc4zvauDT8
	 PJfiRRjb4Eiv8MS4LiVM0DbQEHBZb3R3shC2t1TaH+JK0iRgnZvp2VWvNH6e8ZLGPqSjZ
	 0RzoXYI5lk73c7aSj5mfSpNwnLAFS5y0BE30edSvbtdp3FRL2UIYBtC4qfMPjBHYBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YGX/goY5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9691606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGX/goY5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59941F0089F;
	Tue, 10 Nov 2026 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341390;
	bh=0lUT8qoFUQi3Mn2PXHLIuyCnRmHTLmfyvmAKeX/GnZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YGX/goY5iCns8bxRhhVKDLu3ZGHp330UOzaJTyzHgM/D/PDsLzbAb4+jy2CenWckW
	 GLTStJmmLjk0RUZ9v7FpS+9QYKBE3x+Os4Pjr1sKb6xdC6PCRFfR1ru5fZpNRIoCcQ
	 OpPbCtQ43MCOdJz03rQ2NYa8BWtB6XVrdYY0HxJGOS8699w8NJD83kJ0EAB6WBiH1L
	 qMQxtX2h50KtzJ8wSezqOSmxJQEKRo/gwNm39W9GU9Au/2Y9naaeHolwLtk2z+Sp3g
	 g9bQ6E6iVb3WWDRBSHPhNsDbvxwVrXlGFvkLox5tAnoc0/4vmTMWQ6GdFdS0boSB9R
	 9RuSanvmrzXkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 15:09:47 -0500
Message-ID: <20261110200352.3682548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062433-failed-5.10-5364d081125a@kernel.org>
References: <20261107062433-failed-5.10-5364d081125a@kernel.org>
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
index d405cdf36247c..96e6ebb0a4ee2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -556,6 +556,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
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
@@ -566,10 +587,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct page *page;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -625,6 +642,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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

