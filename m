Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334983;
	b=uyQpfgqKz4uyjwSiC1ESohv9YYTXYsLm5NrEFgATPT1n86RS92KxbTrLuDcyM7R561a2
	 KaVSBR6rB9wtIUpF2Po9VJ6sM06UnN8482/PDNh02VPtFfKNXEvrad1RuLvnzYVA9223h
	 tfsEHojHScDYjUALaRtbYePA4Szjil9vkMrnSzippDUUA+3j1rPRsZzLapP5trx5h4ioP
	 xny25/4EuFZxoZrIFGDGvsJ5GeYvHdTkjFg82jJjkC7KJzNkW3bHimkQFLqo7T0RUF88S
	 ymmTnOtKHk76IV9ctEf54LSj5KEh96BEd5dZXjxGlR38TYMIJ3XRLeIv2Xl0BDJ4Quw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RRnOF9I7w510qgoLJPN2OQRtZovm4BrGVSIoVxq04RY=;
	b=LtdCkregZQsQJXl2oCcXvMjw9Fi0/YwWSkJ55MRyQO6tKsWhI7G/05JIf9NvS3UtdbIx
	 /FC78JGUrG7DLx0O9IaATbbirJI/X56h0Nus0zuRUrepLYzHG2N1xxNmCP23ww7Ssloxb
	 g6G3HlUQHIwEOYmprDQLsZ5YOe17ArKnUBTUs99CE8K634GXfVW8I4ZJq389STxzxNp50
	 ufK95UuxsV1Ijp2fj+Re1/JXx7thIa1diPQYXRiZVBXR7iw43Pd+dBzVJJucuNbbFdeX4
	 sp5JrhzTJsLN3zDeDoVQFRjUiYpIyWGhkcR2NPNiEtGeb4N5B9OhJWwIMjBe6CyafzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQ2fXGPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40789606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQ2fXGPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6D21F008A3;
	Tue, 10 Nov 2026 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334982;
	bh=RRnOF9I7w510qgoLJPN2OQRtZovm4BrGVSIoVxq04RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQ2fXGPFOmEdV7+mrYg9bdQdHJ/lfi3cDJ/Z6VxeU+4yP10H6o1MqKzSfK9T508tt
	 frE6uRcXinpiTHeR6o16vGqrft3xmRXVVDNWjLJiR63GPfUib3+F0kSMW1emnCE2FW
	 qcKx+cdiTu/5c1IzC6qdJnX5Exud8URGWvVXGYQwt/6cnmn3KH22gTghGXyCtNLDzu
	 9bcGIz0L29xqm38Lj0cTuj+n1GUYE+TWAIXdVdKgNx4vfWI35UfeBvNDvcdYZEukTq
	 jrmegEniQYsorXBf0mOVLczLFKp70lZuI53y0FpB/arpcJHYyKPnjw6jgIn0/0rld4
	 QCcpsl08hMXXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 13:22:59 -0500
Message-ID: <20261110181229.3093764-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110181229.3093764-1-sashal@kernel.org>
References: <20261107052334-failed-6.12-5364d081125a@kernel.org>
 <20261110181229.3093764-1-sashal@kernel.org>
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
index 0d076cbd94237..16baca6943ffd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -720,6 +720,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -745,6 +749,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -752,7 +757,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -767,6 +774,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
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

