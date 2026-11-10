Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334983;
	b=DU4Vj0xXiXzMTJoyPNS87NruHeGf5IFlzEebanxppu/RrESq3K5UMevK0Rgxh/XnTasV
	 O6HkauRN9HejDUzKwhlMvn804yj6gWzmC71MyINpvn77VnF340H6Tv93/fe8FZnZpuJUs
	 /+Pp8LmIbi0uXMekImXRAdfHOrS4IK/Pk4PIwcACasu3DOjfCFt5XTFxxs3jjzFvsDm9T
	 wJ5SduiHAsAI0/bs0n81xA4/FyNdo+s8xWhv2UWzwwmZ6bjd0ubUIjxQ5E8Fz2p/m5HFL
	 rS9u8EYB7CJ/IReX9dZg06qlhHce/SQDa06kIs2S7TIr8KOkNHb+HG3sTxoyNSXd0KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=visWQWFV2YgBDd2OCbgz+fLkfVc/ewJNY2D2y8K75zg=;
	b=MhtFjWPBnKRJNR++gIwMXRDJ+SrDCOQs9AJK0M/YcWTqmSWW2M7+RlyTZslizK3eBqOT
	 498FzjJFFH4swLaiL+PXuTfC5NI25orqeUYYulqX3N+m7TziS1t0GCaSldB6nDk6nVl4U
	 81OgLDgnuzaZ+MTd97Negw3el5U9Sg1E5yPyr3VjNOedqBVzuRRAYp/+YYg3iTdTcPkVE
	 6WrYtqK12CS161KZkrqezzgCTFGTFN7ygSTx6uq6e6AAPPefFogDCvic8XeQyPNo7frpH
	 /hzbZuzZrVxY+eDySxKYJcqc5iRmqiY3h4AFPwRPECwDwlQ13UwmsKqaKf5X2U/XwXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntPQBkUR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D493606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntPQBkUR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677E1F0089F;
	Tue, 10 Nov 2026 18:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334982;
	bh=visWQWFV2YgBDd2OCbgz+fLkfVc/ewJNY2D2y8K75zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntPQBkURVbHseUxJqofLp18XjvpK3JEIEXUUXpgqAHmEsG1/Vxk300BgBsbcGuism
	 638ASWR17zpbixXg503VNQU/Z2vG+6u7U/oAIAuqE5LSax/KSBbKskCeAZndPyMyuy
	 ohdz2ZELbJ+GiaMgCXN0ZOMi5h/uwXgcGgJP/b/oDgWv6+L6T02y09UsSUtifhsFQU
	 KVA4QGRPvB35gexkeD8wdxp+88lUvmrGYvYiG8yhvsZJrichoLOBj1JRLcjGSn69Gv
	 PeQZXCTobuFVjwHFoN3vzv90KiYdg2P3FcCLmSRRGeRV9+axUfqh21G8Rmo2nYhOpE
	 hty90P1kGFfsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] virtiofs: add FUSE protocol validation
Date: Tue, 10 Nov 2026 13:22:58 -0500
Message-ID: <20261110181229.3093764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052334-failed-6.12-5364d081125a@kernel.org>
References: <20261107052334-failed-6.12-5364d081125a@kernel.org>
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
index 06e59b820ffa8..0d076cbd94237 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -749,6 +749,27 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
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
@@ -759,10 +780,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	unsigned int len, i, thislen;
 	struct page *page;
 
-	/*
-	 * TODO verify that server properly follows FUSE protocol
-	 * (oh.uniq, oh.len)
-	 */
 	args = req->args;
 	copy_args_from_argbuf(args, req);
 
@@ -818,6 +835,10 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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

