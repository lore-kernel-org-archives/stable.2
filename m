Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047016;
	b=NOP9uXPEV8TtLBObka5X5gqACIfSKPupTO3yIwLcMKCC0OMVb9wqm4yxLfX7V9zcGGJv
	 8C32bvZvnVg3s9Fntg4BWwBi6KWbbW2KKjg2p8kP9idhoT/bizbcS6V/LTvmavx9Bg2Jx
	 e9s9//MjjxMowLQqZ0O5EP2EdeFOaOdNkbUArsltTjTrZvpvgqWG4A3NJ68Eah27W0ncW
	 O+86PajW7sRQgq/zWpIcZMTMMdkHuC3wSftNuthosJ9lxcjGDkvyPv/VJrowngRGLSYRl
	 8/sqy2giBqTFDVkzVt4Lg4jEcMVULfi0P1+A59fRkI0CGh0lQkjuHKjZBL0qT4jdiIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qO+Ud6qISWvZ06OPCDG7TJ6rm1vj3sYB6FSL+PFk6qs=;
	b=rNAAExthfmfdXcxH+dXBJEtj44zsuhxT9nA3KoW8MHQY4dtm3/xUxgRadKzymXVHD2Pb
	 RtRhdVnNCZUdbvo5U9SWt19Z2cpb2UexjFJ1XCGA1OmG/969NMqqrk2cu+NnjFRAwa4Db
	 TTDQV0bnl2wZXA2jTQFf6t4klzPIsFCd7INNww9fbh+55vbDC1papgcjKBk9xfcL/uT8U
	 d9NMIsVkdqg7VSyz+vXRMLjxDA7LS6urbNVlhpuU7/dNH/+hXIFZFz/unQGXbysHBzpDg
	 ovFUt8Y+tWq22a04gGzPnqvDAQupkiBoQ90h3rPWEqaz0NTSQDvt1X7FlsRuEcOP3BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRH9V9Wq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02142606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRH9V9Wq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ADC1F0089F;
	Sat,  7 Nov 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047015;
	bh=qO+Ud6qISWvZ06OPCDG7TJ6rm1vj3sYB6FSL+PFk6qs=;
	h=From:To:Cc:Subject:Date;
	b=MRH9V9WqcRH49iMKYdbYQMDDrq6h+K2OvlrFD4BYBjtMGJpXn73siuOjN7zlYVzzM
	 QEI5pLbhD6xpTiFU5/c+J9opgEP6wAIomyabKgEv4C0uMbF6G2fgU/24O5yNObpFDX
	 Ao5Ff4BQla85QWJmJcnpLzIjX7bhae5Mlfj/ypQVCdnUanlmX9Oy2Qi5YtrAoCpLy0
	 DZBsPAnWj37bgrA+guE4ggz9tTMH7fyA8Lyx3e/M8KcBabfapcTlO0GZ2WrL5m4HtE
	 w99TZ4qPM76trXjosQLUuZMzYu9IxidQCealHi4I/nfYG9dB1K5ovrTgLOhnXOEky0
	 a4atlwIMp/dsw==
From: Sasha Levin <sashal@kernel.org>
To: tjdqudcks0424@naver.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtiofs: validate fixed-output response length" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:34 -0500
Message-ID: <20261107052334-failed-6.12-5364d081125a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5364d081125a34e90851fbb46ecc93f79339ce78
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052334-failed-6.12-5364d081125a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5364d081125a34e90851fbb46ecc93f79339ce78 Mon Sep 17 00:00:00 2001
From: Sung Byeongchan <tjdqudcks0424@naver.com>
Date: Wed, 7 Oct 2026 15:19:49 +0900
Subject: [PATCH] virtiofs: validate fixed-output response length

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
---
 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 674fd784cdb80..ba8d79c4bcac6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -727,6 +727,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	unsigned int num_out;
 	unsigned int i;
 
+	/* fuse_request_end() returns this error; there are no args to copy. */
+	if (req->out.h.error)
+		goto out;
+
 	remaining = req->out.h.len - sizeof(req->out.h);
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
@@ -752,6 +756,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (args->out_argvar)
 		args->out_args[args->out_numargs - 1].size = remaining;
 
+out:
 	kfree(req->argbuf);
 	req->argbuf = NULL;
 }
@@ -759,7 +764,9 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 /* Verify that the server properly follows the FUSE protocol */
 static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
 {
+	struct fuse_args *args = req->args;
 	struct fuse_out_header *oh = &req->out.h;
+	unsigned int expected;
 
 	if (len < sizeof(*oh)) {
 		pr_warn("virtio-fs: response too short (%u)\n", len);
@@ -774,6 +781,29 @@ static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int len)
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




