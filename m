Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333208;
	b=JwwYnLtx0GF+vsVDlZTZdOx4lcTghroZ/P3AtIv8uq3Vz+8jHTTbBzZYJjxAM+GgGDAO
	 WNs0RqaBSSnOfUV+EgMbGoN16U2rmuR+oROg7eSg2AZibqzKorp+y+mcpUAH2CzjjHU71
	 hwegp/jy/kYoHyy5lXEJHyHJuYIePcqSucBYg4fXaIG/vDln4F4Yx5VtUN/c2RceaDnHO
	 GgmsIgVRNGwgIskoL/KYUyY4lQWY04f+mP+M1CCkg3j09r3D1JuehMKwiwAx+r0FCczBJ
	 z04VXbCYNDmUnDt7RNaVs6qsd2DmoiUlnhPQaGVVTNn/m9errsAUIoOpaOL+haqktgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V+QyLjj9Qn+SQTguQDTEqTIwEnb2NnxGXVIOMYl9RFQ=;
	b=3Xql4U9oK/G2kwqmcdN/ZFirVsE3Oy0Hwcj7I698xLL1OAtGA4RLPuQAQVVNLCtMCmzC
	 yPABbutOwIAy0RwITGhEmclT1rYI1DhuXHs41eXftoDm6P5IShXfmSqBc+Pow0hX51KJ7
	 5qc7LAC9asA9bqA0PJWYvqnK08zN34GWV8/kPrf5QpHAj4KdOc+3TomcdEgFrBJ1qNlnU
	 vYxdGW07uPic0qXWe+HVW7qRJ6boIdZpyo6MSvCy/gQnP+3+DP/Sh6yjN3urNn6IHxKX2
	 o0fdhGmQqzsKJDJjo7xTKPUSaQPE7E+K50MvQEynb+DHHdRuIdp2lb/Fl/Cd7/UfpkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZVLH3IY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B260A3808
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZVLH3IY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF76E1F008A1;
	Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333208;
	bh=V+QyLjj9Qn+SQTguQDTEqTIwEnb2NnxGXVIOMYl9RFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZVLH3IYjpCJg3Lqi4MTQ+B/xyhx9CRKRWY6/OMIY4/y7b6yJ8EMPM2YSNPZtCrwe
	 XS48Ncb65DU7cOsBhdMzo/N3d3NzgVdaV6u1vHoQNZ6RmQrJ7Yk6LRNI2YfOKt6yOj
	 1z1zyTzaPHzuEtiJXrA8qOaeWY39lKT5Tonjjk1HFwSxfiKfG8PP0stHElGS/y8kIw
	 1BnEj/HyMfXTmW/rTz8qSNKrh8JkjOVrRgJg3al9VsHjpoxHaQykea1mpfjf4EGyNU
	 dtVOrmR+dJLNT0k6rDkXKyXUCKvVdVY8KCwTlVKKaeHDGqQnHW/1iEjZffcz2gYJyv
	 hyXgknhM3xJNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 12:53:25 -0500
Message-ID: <20261110174311.2970583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051218-failed-6.18-5364d081125a@kernel.org>
References: <20261107051218-failed-6.18-5364d081125a@kernel.org>
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
index e475f7f9e83d4..33962e1ad8c12 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -755,6 +755,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
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
@@ -764,10 +785,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct folio *folio;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -821,6 +838,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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

