Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338669;
	b=JHN2VtTeco6B/TVnLzm4CcOrr6qOcbsmFDUp8yrLQN2qVuRh4cM9YluULs1YnQl8qn2Q
	 +1o0cEfPN+MgZyEwGA6S7Yqy1gvYLW2yEXEp+G/fInC4UURDxrZIlizEsvVQ1UfBiaVSf
	 Bm0XeSYqAinEFOwTqtSvo9fCq+RUv4STUJvTmq97+KZ5l4ph20p+x9N6fHVBA4vP9L0vD
	 KGyVJzNP2tnsKKbVJJrl0bWlsKC0ydrmg/pB3em8sXutZswv3Ciwaz4Zk/YY+8L6jUiV7
	 bjyVJlr8TPiXn/sndZE6a6p5evRTmXVPS5xLITA5tQC/yXcqW7d2bV9iHlUfAQN+z9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ajvbwhi0+aqEyn6SAbDvhcDNEQMuQIj+O4whjXx+Q8c=;
	b=UQX4Q6hqY08zBEcqHiyvidb7lZ8PWd20G2YNwWp5ot5AiolWGIKybtrqFELcq365yAIf
	 aCQToDESDtO4arPN2xdo3QjBBagMXIlS9NN5wDvBPZdApYRbo+0limdHLWWgfirKJc6wn
	 cY/VNoT9rDaXwlP8/LHcJ7+0jkfD5hKnexOlC88Uv5yg6I2sE21wITQfrpQgD3bKN5+4Y
	 uLzR13VpvH2Lzse5hBzm0W5W+WH9WiS3SSBVRoMZ9LSK1wCUJTyFk1UObPygr5Gs+fqX/
	 fbGO+GLMy7Clju8U9zbypjeDxbi/MQqthusJCUURtD6kLN9/Y8US6IU4BbJYAE5HdOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vf/23+XI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf/23+XI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2229C1F0089F;
	Tue, 10 Nov 2026 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338668;
	bh=ajvbwhi0+aqEyn6SAbDvhcDNEQMuQIj+O4whjXx+Q8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vf/23+XIlCZL9lm+zxYxB2GWOf5p9e/cqvYivPLrfTsXnl0PPCBXTklFBscKYBnvM
	 NgDD/ho2RCY0Kx7u8ySCakG4i9WAm7sMMn3T0Y264knFpdTOoG8KTXYcasGOYZx41u
	 Knk1A9+fZ6lsmhsFe3DvSCS3wRB9lFD/pbuA84RzCicdzFE90WPnXe+hkqHV+JrrBJ
	 B+62lLXwKEL6By+LDLlNlZ6C3QHeBcdwmwQmNsJhsQfjEsiRYjTvJxJXoQ7cPHeVQx
	 mVLqtMPN2MvxiQoJcqeNtplNHJ0z96I/YyIGnHNQiDhjLeABTcXrSP/JeX72ID98Q6
	 vwSHukNtmzQpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 14:24:25 -0500
Message-ID: <20261110191324.3460613-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055034-failed-6.1-5364d081125a@kernel.org>
References: <20261107055034-failed-6.1-5364d081125a@kernel.org>
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
index 9e4f2ba0ef9d2..ab410ebe7c304 100644
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

