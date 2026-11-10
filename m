Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340259;
	b=Ka8lLfbOFLRl9mfb8nB/8xLV5cfal+/W09673HyOkBrGmNDxfREm3SREtv6cUM6pQyJI
	 9nximgNc547carCeQC1sBtufu3wsZ6VpgKPq05T5E0ZVBdCSHEPtUodYjcoI6Xnb6gQAR
	 LtY4wSNZhzkH6UuUXmy72m02ztn7cY/do1nNq6TKOoQGurU0yPgyws3fPu6IOp00iE/U6
	 pmzknl2tmgGbfmZkPdlQWBCqJrilJG8OtH2JuBBj5+Ko6lJ4uZ/ZUvmQ3wHVIeTG/S+Op
	 GgyUschn5fVFYGtmKPSfBuXAID6hudIN281ptKql60ZrcKz0ldbM9yAxS9NynRM0WCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pEVjulOGJkpyWrsEyn3njWgpdgVbGI+AU5xIIwfRk+s=;
	b=Df2nONhIWNrU59j1+MzW6GQLsGatDh+Y01yLYVlsz/jRQqYUSvHMk2+1qClqN+gaLFP+
	 +zRgX0hJNmC0ITGEnFQqtYHQwUO1/dqSzQ2Vx3ArVmnWYR3NWZEdnb2Nn2jRptJTxs2X6
	 F3GIEa85kq3x5SfNf44My4k8R781IFv0QM0Zhau07vZJd9SqixLTX3bWR9bsdHu6/Pucy
	 cFVJrf9NVJClgzxsLrbSajbuqvZWLxj/DeDsKVQi6w9Z0mi/s+CvFBi+vDU4P00ESoJRP
	 6OzV2OPEkQ+fi2eEWZtwrL64+IFbc8532m+PhNFL+cKfquUlCGq4CYMqIAU5Oxg1rtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuzXRpMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFF606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuzXRpMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE9A1F0089F;
	Tue, 10 Nov 2026 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340258;
	bh=pEVjulOGJkpyWrsEyn3njWgpdgVbGI+AU5xIIwfRk+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuzXRpMyDRCx3vFiV9RgKNQsH0Vdu5Aob+sE97AABeGzRTlWu8dUNl78yjery2OGP
	 TwHhBj96/YxjVNtGNvjhNQrhb3vSRU/nD//xdeG0/21zttnn3cdRmy6LtzbNRZG5pz
	 D5U7UcYJtKKz9rS3Gsxkpgx6YApXDfaOs7KPRE0VqHpUdJhQ3ZvEAQGnnMjepYvtBd
	 TyfajSqUVu2xGWZHAx4IVTwkfwUAgdBeGJXd/xdiD/ED8NRS0XzWZFP9d395zn/AOS
	 AJFvQarP3XxBsfWiJ3pE6NIoa2JNT7/1UxLjgwFwzz0Bf/YB8FDXa1nCTiyPfyzccd
	 4A/M6z97+7erg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 14:50:54 -0500
Message-ID: <20261110194003.3568480-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110194003.3568480-1-sashal@kernel.org>
References: <20261107060741-failed-5.15-5364d081125a@kernel.org>
 <20261110194003.3568480-1-sashal@kernel.org>
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
index c375a5f001056..14c1ae5075938 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -522,6 +522,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -547,6 +551,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -554,7 +559,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -569,6 +576,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
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

