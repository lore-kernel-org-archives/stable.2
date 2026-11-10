Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341391;
	b=N591ktys6PieddWBehgwEmKlu78vT1hEjSqFIyMbZkBZCOhhmVheW5t1gCyG/n/Wz14f
	 SOICthPLBZytXuo0y+scq/G7YanhUss+Oj3HK2gze2g614VW+1C/7HrLSLGNZjnvzGl21
	 hm06RZiSRQ29Og8AW44msUDaYItF6BL3MoiCp7DYiJ+Amg2sWV+k74ADWViN0wYGQVmrj
	 fKYMDHfLJ57IGfbgVNimVr+RptKCqob0IL5Q6jBqHgO0J3q2LAnGoLTmmS9gbwKxDjekH
	 GlmPbuDAoxrMjjrTTau9BS1nXG0ndvL5hXQbI+Wu1PT6Exf+OGzb33rxFtkjlp62A5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6KE4kVS38NnaRzTk3MB9JBRYlKbv5O+vBftgtNP6n0Y=;
	b=TJnMjEaT5XL8ExLjYvFq9pqbfjawvNJWRFlIpKip2dQRc5WQXDmkrUC3UDMQP0PwhQTK
	 GJa7u2KYQSkfcXnB71jcuMBqXvNkLb7iO4JfhbBv5z6SpYoFVa9Jw4llc3hBYxddKnCFf
	 THAX+OVmMKWR6HYhAKDVG9XGIbYWb2mlTQdLwOFIwlGkCFb7aJRASSRQXtyl3jsZ8TgJ3
	 goJPZeUSY9ar0jvIWKMEnOCx2JcwszXIUq+qpC8csn/fnk8+ZCb7Hw3xKMwwHOggAQc8I
	 1qzchYUkMv4ecLqV0kld6uYWMQBWI62XDp+S2uW5q2xKQWlIqygJ2QSf20F8Ig278gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+WZKm4j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A18606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+WZKm4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2A1F008A1;
	Tue, 10 Nov 2026 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341391;
	bh=6KE4kVS38NnaRzTk3MB9JBRYlKbv5O+vBftgtNP6n0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+WZKm4jYXRRx5Pt60a6aHzTi9e/aZmfKNd+/LATIQpUF1YbwR3dnvRpcS5zRUkAa
	 YAsLjlZ+i1zDbgIjE9t3Es4OkzstV/J0J0Uow3fxjjcwtmWSkb1btVIH8HEmFEaI00
	 nQ9nvnzcEvJ3+r9N2GbFgJVRknH6lVoopNHEmf4gJhaN2NhfGU2j4loOEHDDGzLf4c
	 GotNLzgaXuy8cJXvKJTdFvZHX/1Gz0pbjn6dQHg4cB7XK/jc2OFXWPXEQcIPTvPMEo
	 uYzYrcUA7u6s/RrgPBdsmUqB5LPaWiVq3XqL3cxq1qsWXWoSlIdWX1HBYugR1a1uJA
	 K+dL3qqnAwwuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 15:09:48 -0500
Message-ID: <20261110200352.3682548-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200352.3682548-1-sashal@kernel.org>
References: <20261107062433-failed-5.10-5364d081125a@kernel.org>
 <20261110200352.3682548-1-sashal@kernel.org>
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

From: Sung Byeongchan <tjdqudcks0424@naver.com>

[ Upstream commit 5364d081125a34e90851fbb46ecc93f79339ce78 ]

A short successful virtiofs response can leave the fixed-output portion of
the request argument buffer unwritten.  The completion path nevertheless
copies the full declared output to the request destination, allowing stale
allocator contents to reach callers such as fuse_statfs().

Require successful fixed-output responses to contain their complete
declared output.  Continue to permit a shorter final argument only for
out_argvar requests.  Reject positive and internal restart error values
and require valid error replies to be header-only.  The error already
stored in the FUSE output header is returned by fuse_request_end(), so do
not copy output arguments from an error reply.

This was found by source review with AI assistance.  A header-only
successful FUSE_STATFS reply returned stale fields in nine of nine calls
across three boots.  The fixed kernel rejected the short response and
preserved complete replies, valid negative-error replies, and
variable-output replies.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 96e6ebb0a4ee2..1f58c4adc2ae2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -527,6 +527,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -552,6 +556,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -559,7 +564,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -574,6 +581,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 			oh->unique, req->in.h.unique);
 		return false;
 	}
+	if (oh->error <= -ERESTARTSYS || oh->error > 0) {
+		pr_warn("virtio-fs: invalid error value (%d)\n", oh->error);
+		return false;
+	}
+
+	if (oh->error) {
+		if (len != sizeof(*oh)) {
+			pr_warn("virtio-fs: error response too long (%u)\n", len);
+			return false;
+		}
+		return true;
+	}
+
+	expected = sizeof(*oh) +
+		   fuse_len_args(args->out_numargs, args->out_args);
+	if (len > expected ||
+	    (len < expected &&
+	     (!args->out_argvar ||
+	      expected - len > args->out_args[args->out_numargs - 1].size))) {
+		pr_warn("virtio-fs: invalid response length (%u, expected %u)\n",
+			len, expected);
+		return false;
+	}
 	return true;
 }
 
-- 
2.53.0

