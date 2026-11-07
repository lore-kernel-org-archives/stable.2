Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046340;
	b=Ivh6pOA/5roskaYlAXctIROA7KJo68r+3xSSx9dyPKlsuDv91kk+YnKOd7f3+ci8CHv2
	 jALh91ErDIfi7QFPUxuBnV7Dhoswc72ZXk/Y/TkdgdTNpvUVjXaxdeZa4l+Du2RX4xUZC
	 6kmFgWG4JBTe5EJMnctj89Lf/0fuQyq84/PJx6829w5Dnl+Mc6D85y+dd5BbUFugp8uq3
	 sbeEs2AM5wqQiF9+d72pNtVC6NPL4nA+mB7M42Y//cjq4TqGtAEnuhCmVnoWgU05nWF5b
	 q3BrmrfqZvF70NdsH+Tjg8VWg4n61VOFjEdnPC4aZbdyo5nXNOuzcV/3MBKTcOn1fdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iit2wBkFpFdNOcNceJSCguwjc8jF6iBb9N7gFnHZ/ns=;
	b=zyI3PQFJeH7XKgadoVDRjPMGQpV+e0FMKPhjrK531d5V3x+8miksA4ENoNhFlDYXdxAR
	 ZTS1u6z+slzHJ8qFKCpZvncGl9JpBw9Ry8iJAt7XvftQYf32S3eKfzZhKTNiwOxD6zUF6
	 d5hJequIBj6//rTrIfaK8DWSaQKyfgk9ZxY8TboD+t6EAVnu62E4WcmCMA484fa/1ve7H
	 R+kxt7EFh6YOwYcnM29ad7tqqhNeQpeg4teVvF93/8oDiUAYR5r2Z8jCQmecK/lkkwWnh
	 kwjn2fTx1Fzm6AMwa71rSuEtPSUwk71K4QewF1PYN9Vi3SPfK45jut6YvKKxqxcnKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9dntUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9dntUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82541F0089F;
	Sat,  7 Nov 2026 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046340;
	bh=Iit2wBkFpFdNOcNceJSCguwjc8jF6iBb9N7gFnHZ/ns=;
	h=From:To:Cc:Subject:Date;
	b=CT9dntULGxBg29AFhO0FW2U5Lcz0tHW00fA4RSk0StB+Z09wGMMyaO9ldifAoRO+M
	 eMM8Qfdo6nRshvtXTx2DdWZYaobWyuAkPWofoFjCcdf9UT/2kwm3KKr6GB/73M1nXa
	 kzSZwtM66tL+XIJSdx40zXN6M7FI6p8IS+2z8p2pODU4VXqbrmYAgxQOzC7q34iHS6
	 YAyiIMMLvWa/QonEYkdxlmy/ydQ1giCng3UpIt2MrzxqAwxCiW873H7rIUXhS0APFM
	 ofNMClIxPKn0m0RnrfXtXQ6QNVwejBaYjoMc/vWgDu5s7bCB2+w1P7zYHm1vMJSGWt
	 VHIraLPsCiLOg==
From: Sasha Levin <sashal@kernel.org>
To: tjdqudcks0424@naver.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] virtiofs: validate fixed-output response length" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:18 -0500
Message-ID: <20261107051218-failed-6.18-5364d081125a@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5364d081125a34e90851fbb46ecc93f79339ce78
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051218-failed-6.18-5364d081125a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




