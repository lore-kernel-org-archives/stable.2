Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447734;
	b=jgcFHyFbKfkl8dxpZmsR0Mq/S4+om6D9XHp3ULwfZOFof4ayZ9h8IQhFlFC6jAQh40OQ
	 5WPprN64bvbFsKqb5zHen5UOWeI1kAgLRaoCR/L4MnfJ5Iud64rOgoMRDHIQvXv3JBMeg
	 ZXQDH3LjQCxYFAJOxWylZCg4SAnqdT9wjvL3T6LB2JmNbWoEwfaji7xBpoNfXhwTxIIHk
	 Yt/SzleWQm/QKo+JDqaHtEe/CV2ZdklAFE9lmkd7yzZeRWRie5zpX9f7DvI6ImdgQrjYN
	 ANl24N4sA2AiNUe7ZGGFfleWEH6x2MVZwoKUdGVH25rB0uUY+AS0etleM/sTrOISkSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KHpn/P3Uv/wzqM0a/TP2OmjFVWONL7dr6Sl8aG9H4wI=;
	b=I/iZtp7N9vYUqCwg7XjXffrw6eiV9p0HvynQbxlsQ/X9wy4dT3+RmmYk70jYtLVa9rA1
	 DeXGhU2s4gIpk//zRrnXHOtpAsJodfNHJHnlWuj/e16YiiojekHIQL2GQ9Eixjn/0AriA
	 9ijwOmIIOi3picrInW6RHjT5CdbZChCo7x2zfET+VNq6UDlwmX6e0FY49XEm/nZ7mOdDC
	 qJ/yrx9/QJSM08zRRgiPqakIzpjibxvA5limQIPvr1tOp8gEUwyBluLGCH41zeo2wyfL6
	 zbqaqEWDk+2Q9KT5uuxb/OwIX2nrAUrrniU9Q+jRT1YgxT6BzGGDXHV3g6Pyz2DEiUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhIqfDkD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF5606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhIqfDkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1B81F00A09;
	Thu, 12 Nov 2026 01:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447734;
	bh=KHpn/P3Uv/wzqM0a/TP2OmjFVWONL7dr6Sl8aG9H4wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JhIqfDkDPwRJmgetYrcJIT5TMZRQOldZga8YtpIv5r8w5BKci/WINNc6Ks7lHUa6l
	 vyF02vPpbNxkHZfN98Xv74/khKejfgLyLkuPD5TwFpfx58fXED+Fop9s/yllxU+uFT
	 oKlD5zNe0hpobegAS7MIg/ajMBMN8VZOehR0VtNt7NnC9TdGgTChYIwVAnp1UKEGbT
	 dgKk8zHh2nPVJ+33nBUDIEJCiInYl654wamS4XHLLEx2UPp8QKKHvk64tv7KE0vfyc
	 SyuLv8Rg6xcxmMTg/NJi57B8L8tL6coBumBTQ4v9fUN8ITMUMTJlxnvYsi63ou4Yqt
	 WlAePrKFoDO/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] backing-file: always end a queued write
Date: Wed, 11 Nov 2026 20:42:12 -0500
Message-ID: <20261112014017.423676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061359-failed-5.15-627cdcbc2a2e@kernel.org>
References: <20261107061359-failed-5.15-627cdcbc2a2e@kernel.org>
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
[ sashal: Adapted backing-file write tracking to overlayfs's shared cleanup handler, preserving its existing freeze-protection release logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 49d3feded593f..3fb7bfd00b88c 100644
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

