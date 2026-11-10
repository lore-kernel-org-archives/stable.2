Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338670;
	b=mJ4pfySRHKNf4KEv+urJCXu8hpecHhGU4es4yrG3iXyqU+oKJGMJzkYOApOPf6GfTkCu
	 LbHZ57HFE2ernwLkMEFFiHrZIN8WOC3jZhfTkLLwbpnuH9Rp7miDr2SFm9yZqyRIbR7OX
	 UORmLpaEhXKe4Ye7RdZ7Dx6tMMCLtcme4+SErsOcRBHA+SuyGxpRIUZhMCcgjkcDctudm
	 ju1iqgfqR6BHDltuiFTE8TAUUjA5SavTF2nAi38MkM9A54hxpQ3dc5Q8byN/GwnNv1mas
	 FTWw6E8XgVmLzW1oZkC0j3Lv9AsQnhkgS4eTZGSycUwk6/D5s/IxQocOhMDdh1yCLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tQk19YMtYBeGmvN4gB+chMvluL9estRQcxb71H4qKyQ=;
	b=XOkmpFaXdryJKTI+MAZqOrYT8GuO+03QpqR89XTn1Y0Ls03wmUpXBrHH9ZXXRGpnK6o6
	 Y9KZ2i0TD3rq398/oZAB6EWEwcs/QMNwQWhXGUA1naLPL/5NQIffaXOyRd80N6HyVN9uM
	 lVDHv9xTDID3pJtfH74cAuwIsGH7aqNvz2C4YhRaReLRYNAudvYCGL+FIscEY05goDuSj
	 87z2BLhSiE0cPzVodFeiPWelcywoPJPiv4GqDYTt8gkc50UTyZ4vqLpqM43XXUt4t6jsT
	 WzfxJoZLObdJVG0VBXm4dqDgtlNfKWlMBC8Z2dWXKlXadJCjGQaoTfVHegI74TOa7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPtA+HEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE8606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPtA+HEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2DF1F008A2;
	Tue, 10 Nov 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338669;
	bh=tQk19YMtYBeGmvN4gB+chMvluL9estRQcxb71H4qKyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPtA+HEM82Z0UwdqLrRdHaf4wlopTVbCySslXAlTn8eRI7ejDKZVAT7D2O51YP4OI
	 nB7RAXcjHTnKLXwh1dQrogdKDZXkHEzLcVW0RV307QKS1E43ssgRk5XdVANUMIoYzL
	 JJbiXLiJ4ZJqp5CL5DB7ueL9wY/VIGMFqiQwM+4qtTWZ9ekD73hnsTzj6zyEuvX79B
	 dmHCjMvgOJkyWCwkUjBIVqpJn71iKnTPxOG0f6uL+PrWUEgchQdEmutkme76xt45QX
	 ZNVmdZw7IZE9+wr5J5SZ3SPcatCrdaIniHg/fx1/tlmPBbNFDmaMzIvCfqIOW0SKGh
	 KY+RjxmjQsNsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sung Byeongchan <tjdqudcks0424@naver.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] virtiofs: validate fixed-output response length
Date: Tue, 10 Nov 2026 14:24:26 -0500
Message-ID: <20261110191324.3460613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110191324.3460613-1-sashal@kernel.org>
References: <20261107055034-failed-6.1-5364d081125a@kernel.org>
 <20261110191324.3460613-1-sashal@kernel.org>
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
index ab410ebe7c304..2a51d7b4d216c 100644
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

