Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502828;
	b=oToZaH6xQOs81CMDQn71bboOXsb1B1e74g0G09iov6ejSCmujq4CGcYdglbdP6cEvdCT
	 p0pTrTQC6mdp8JnX5X9gjuxLc5cbm3ChkNS1PwF0CBzfm2XcNjdQvIwstjEYYtLYeBonc
	 VIOB7Uyp+Uuge4h6ZhwxbP4comv8RAFPThsxpRutooUl+d7fVZl1p+DIH08ITZ5zcpr6W
	 5cTMmV6gZEeZAJnEi1SDt454HV7SwMYe2w9YSHNXeZlmjuC4vniWs8UYyIJGjLCuPT9rK
	 WroIiZaalrYbg+YPQIXlUuldUYxq0zh7p95yzXx14uvUi1ROBHywrAtZcsy3VeunuKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=indUOhe3t87O/YPFL5M9WKMmi7RqM1hyT94T3ZSLeYI=;
	b=vO7Pm6wMtFljAmuMF4rWNXUdiHF1wo/QH3MkvOySy2h2g3ua/b6Wj1+5FU2rh6ZmssP9
	 1Uh8AhdnJkaa8oWYZ0lu42uAR6atPVxYXssogUTA05PHNUVSI6xyCKu/Z+QiTTeXvXGCj
	 LTfDvneB/YIQaH5vTW4Tqmoghxh3brTmeuokJQ7+t0aa+8ruY1y0HVK5slNKT1x//PjAZ
	 XWu0Ka5F6IhyABWBsuiK4VTWq271AYYqQC8N1NAg30nac781StC9l4mPndR9YNXMJOlee
	 0/l1nqyuNjbURYz/6L8vof7HQIXg8PLFnsbVfNgSEo1yxL7GdAbOc53Gbvn0rnDpAYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4onsVJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA87606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4onsVJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5801F000C4;
	Thu, 12 Nov 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502828;
	bh=indUOhe3t87O/YPFL5M9WKMmi7RqM1hyT94T3ZSLeYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4onsVJD7lyDcdUKIMgBu43E4RfwNiR/juNvH5YvCxTb/kCFUQ77V0jCxahQ3EVs2
	 +EITbDefaav1meRYbay9as2k4X29gzJSa70HNN96X4ate2Bh1HMEEMeAoys4LYSR5g
	 LR6J9fvcm9VALUMPjYxMbhFVGeN9/nxIXjOlBo7/vivGmf8QXApKrJ85TllmttAEL/
	 vliWqgeS2egp7/55wV2lADa1I02DOTIPW0Ee3tYjvyzOPWyhNWuuGHiZ340r6OF5S7
	 GIQcXNIU9pIwPpo+131Huh91b7mLD9cF6EZ22Zz3wdzOi2xEMfvchG7i9uNA7KenRC
	 xzp0aDyD2H6lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] backing-file: always end a queued write
Date: Thu, 12 Nov 2026 12:00:26 -0500
Message-ID: <20261112024505.1257604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063109-failed-5.10-627cdcbc2a2e@kernel.org>
References: <20261107063109-failed-5.10-627cdcbc2a2e@kernel.org>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit 627cdcbc2a2eceb0452078a0c14370f9f1f17a91 ]

Writes to a loop device with direct I/O on an overlay file make the
next freeze of the upper filesystem hang for ever.

Every kiocb_start_write() needs a kiocb_end_write(). For a write that
is queued, vfs_iocb_iter_write() leaves the end to the completion, and
backing_aio_rw_complete() only calls kiocb_end_write() when IOCB_WRITE
is set in the flags copied from the submitter. In-kernel submitters
such as loop do not set that flag, so each queued write keeps the
freeze protection of the backing filesystem.

Direct writes to a loop device with direct I/O backed by an overlay
file left fsfreeze of the ext4 upper filesystem, and a later touch
there, blocked in D state. It takes write access to the node of the
loop device, which root has by default, to attach the file and to write.

The fix used here is to mark a write in struct backing_aio and to call
kiocb_end_write() on completion of every marked write.

Reproduced under qemu without KVM, on v7.3-rc6-21-g602042bf29f6 with
earlier fixes of this series applied, with and without this change,
once each. The kernel was not changed for the run. With this change
fsfreeze finished in about a second. Not run: the nvmet and LIO file
backends, which do not set IOCB_WRITE either, FUSE passthrough, and an
xfs upper filesystem.

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: use aio->is_write to explicitly mark a write aio]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20261029180319.2852090-1-amir73il@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adapted backing_aio changes to ovl_aio_req and overlayfs-specific write and cleanup handlers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4440ff43cb66d..2e74de6f4a563 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,6 +19,7 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
+	bool is_write;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -265,7 +266,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
+	if (aio_req->is_write) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
 		/* Actually acquired in ovl_write_iter() */
@@ -394,6 +395,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 				     SB_FREEZE_WRITE);
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
+		aio_req->is_write = true;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-- 
2.53.0

