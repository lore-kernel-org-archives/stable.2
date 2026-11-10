Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333209;
	b=16EA69kF/Wu9IPqyLHFCd4RY+/loLmAhXdOv9TIZR1VH3EQxgQluFLRZeZta9SYn6Fgi
	 lb75rqQhqF6M8zu20dVSLjWtArxXW+qL8R5bcJKl0CSgKaRObCHDBPKw7a0fUrhsY8bkM
	 CCShugtYV9fGmEjXW02Mot8PsN3B+QCZJ4/ocnHTlKFR3FYDkxTyObCvueys6r0Oa3ZLu
	 XahaoztvkXwKdN8lpbHnZVV0yMzmV7dp8PXwke2Jq0G4MrzOB8/nHP4l+xAfjxDv2uPka
	 PtaHaD+zVCLHJs6TEjMXMkA7FgYdKQUWOWhyYr9vAcFSSYjJSH8ZiYPG7RET9ZtXogA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YUxnKepvt8zDi1KGDeb5kFJu5DPyj7lpj+1u5+kBYFs=;
	b=wc2Y0cWPukSwiyagZE4MF0KZ4ktjG9bvrIS//4N3GP/lBsAflMtZFl/vYzYJIM0P9vJO
	 8jIjSCQrPB3H8ujLo3kHGuOr5L//xjy1EDTsxVB6MUo9buLQa5TE8zggBhYQJfZWs85FE
	 DvbHgkzfK2rtjVz/XqlP2wu5Bz5IeDUFFDjKFXzY28SlmysAEJsglSPcvKGU8if2pN5+Z
	 CkUyY/eZoHQkuoXZGfP1uR7xDICbstbmcnleSZEhDPlJkUpvdPFA2VMjZGER5rQPCQSf+
	 FVhtlOvdnams5UIlVb4TKSGD1qKNLHy++26upKvQUBn8/NfDklykm17EvsLBwTjK3TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTuCbd6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BA60A3816
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTuCbd6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25FF1F008A6;
	Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333209;
	bh=YUxnKepvt8zDi1KGDeb5kFJu5DPyj7lpj+1u5+kBYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTuCbd6a0jjNEint4fSYhdM+nlvpSm8ZPdwdcQZ2TDVi1a5Ozyn8qj/5v/b3S3yCB
	 Umv5LDNuyJjJS2m1sxApnnTIWRfJIIEY6qOdrFbXaHhldpfZ3b8V7Z2cJV0WUQ+HdS
	 OuJTnJ7WBajheeMNa+jpZ39YqdgQZpziqQiYoPCvALHHmnwouci1njavREiZL9NEDX
	 EElfHFZ0EOXttqufLHbp8unNY540vj/sVJp7TYPQ/NFFkVVSjcFVRlbL1BjMFDWxTJ
	 /vRq/fX1WEfWgsHgA2NXEjgujGUGOfG3+Y22gndRJC2veJlUKB3lc44eJ9QWGCR/e2
	 dk/4+RFHhDIDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 12:53:26 -0500
Message-ID: <20261110174311.2970583-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110174311.2970583-1-sashal@kernel.org>
References: <20261107051218-failed-6.18-5364d081125a@kernel.org>
 <20261110174311.2970583-1-sashal@kernel.org>
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
index 33962e1ad8c12..7075984a89aad 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -726,6 +726,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -751,6 +755,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -758,7 +763,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -773,6 +780,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
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

