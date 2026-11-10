Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336947;
	b=SJTHYjYExrQzUxaXiy6nHogmdIEV6SurJz5VAmcVCawA38yCcQoOSIXPI5YiFBU/4S14
	 w7vETQQCU2HAbxiDWL7479lrg7KEkNCpjKY9/OJ+/rzLHjtj7O02XB+vXraDzud9+bdu2
	 X9wPey+hWliMOGfxBYsW7WK3CAXoqnXtF4GZ1bnPkJKiguR6z3u32MF3XpvKH81cqM2Az
	 UYwXf0CWR2HH5aQViyiFRKj7ayfFIv7TwbQTw2rABvuUXS4t6Igu1L6qCuEk0e7sxzv3u
	 vISQtIydgAvoCkoKhm1HRxHErdHHA+PVChxf0KbZmbDdp8uM04bfG9JBtmai9W9/3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ICzbR2U37r15UfaahFqG0D4NcQ52MDEDvf1e+u1bKkQ=;
	b=5pmYdYoXgWpul8kXEjP24rdzLAQkbr6vxFY3XF8thSTlpEwriKdE8wrCZdU/dNvoj9o+
	 xCnOxuBFpalbn7ph2vKBKASMPOleuCBYx77e9vopndhrUZbmsA0onO/fpF/KSoFuU/IJM
	 9bhM1djJHkHYaES7jiHaI8O9G021/oISSAIWRRY1Vno5QPzeRsNlBEEx/QjLNSNaJZ1o3
	 8I8Dr2PfDo4kTB5ZMU7K1WaS9N75WV5IeLhh7Twc0AI+ImRxyJ/uC24GTGGOyoycirg8K
	 Eo2QW9Lf56InZyB7mddhwM4x29+9/SRnBIVDASmPFzFkFE/mSxDuSpOrcDNwQpFD0Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMGpf45D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20219606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMGpf45D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6809B1F008A3;
	Tue, 10 Nov 2026 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336947;
	bh=ICzbR2U37r15UfaahFqG0D4NcQ52MDEDvf1e+u1bKkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KMGpf45DY3ODdBZIVRmqjFZrrjVOVQm7qTYtHfQPURwhLH/WKbubWDnO3GPIAIk+z
	 tAD1ncv/eyF+Tz5W+IOVWOdWGUgF8VWP+Mb3W4HHz44rhlvJURxHAujVYywqKQbWyu
	 KVU3MJxZPAIi/IKqJjiadLra4c8LpNbdOBlzhjbbk8S0hCkQUWM1VESExuFhZXcooJ
	 bqAygB9u2x5OJ818RXUnHjYvKnAipDzxSdvtylChdPNcYGC113ccJSLpegK8hTlRP6
	 F10/GEwPUnp6mjrZ5V8Q5DC/YqL1HrDbQXWwYsotRXsqE0Ph7CyeKGC5P+rH+mIvvo
	 sn7OCpL524elg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 13:55:44 -0500
Message-ID: <20261110184424.3240758-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184424.3240758-1-sashal@kernel.org>
References: <20261107053609-failed-6.6-5364d081125a@kernel.org>
 <20261110184424.3240758-1-sashal@kernel.org>
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
index 7b1e9291c3ef4..b5ecbd146301b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -535,6 +535,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -560,6 +564,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -567,7 +572,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -582,6 +589,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
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

