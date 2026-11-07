Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049016;
	b=0VIIjnjBM6vG4grOdu+EAFtTxFaqRqvpS9bC6yS60hndyqDBS3xcQQKke02iQz1bEXv2
	 i08O6ybA5yumxBQc5eVaY1Of38GOxExoEFmvEHx7Yk7euywHcz5LT42uVCD9W/HcbN3hp
	 EZ4J4xC0xE0C65oSc9Uh0FP4+tPBB1+YFgSk0j1ReHHAqfporCAeUy6H/EgEjOhFRnXzk
	 9XFz5RMyxsmTfXn9bC2jQ8qTyDnx1fGbutEwWiMBPkJRWuwH4U/BlfU+d9lR3Lnd49nFT
	 GMKPgHq+s9inIwCAI9fnIcTwIJ8xqx3NlQE6JmApfzs56ZP9JIaEjNYJcofrflXHtMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xXgXB8lhKk72+PsmjdcJM2AFT6E6r8pM/bwluDey7W4=;
	b=f733aOwDQKFDfLcZblGs4LZ7dzN5hCaAx13ROV9yZGMid0FVfhoTDveuu2b/iNSs272H
	 NF6JK+r2747KdFWifycQmXPiAfNfeK9DNtI+vjXFk0c6jx/2jRHDX9s9iQwi9ac6LjL3+
	 BZ7Z9+ErFEpKErKw0mmGNd9KMDVpQ0iJzcJJvc5koeRKepi0IlxmBQG/lpQlOze49jmAy
	 s/gOV4qz01Kf2eH4/bHFE/Rq2Nz3pjS0CBn49I5hQqUqcH/oiZYjmv/EvbOygRPuMP25r
	 6+EC6Krxex3YwjAJtRfaI9bAdwUszPPmB+ZrSdLmY7690TntkpvvYcwxSyIPLzBmVyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+0NhHZN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+0NhHZN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D91F0089F;
	Sat,  7 Nov 2026 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049016;
	bh=xXgXB8lhKk72+PsmjdcJM2AFT6E6r8pM/bwluDey7W4=;
	h=From:To:Cc:Subject:Date;
	b=A+0NhHZN6aY7pqG1ciDkQ+0C++7ZflHcyynkcJmTb/BMt0epH9jaYkxXZy4qXNRuA
	 bbxkGngkcxHXvJYx7Avc4QADad4XmpUU5dp7AWlegPg2JWZ6zdDdquBIHY2uwGoGOF
	 4qR1wKTnxa7jq+x9F8k3YHryFtXVaGK5dF5OeklAwtmEYmEuAPDB+JJME/fyTejO3K
	 OXmX2YB/prZ5kruG0b75uyGur5zFyFY59HICfZkbDR/QZ2/rEbY6KLih8oSbCZ1t37
	 /Y++HJ6Z7UOeg49PysiSr4f3IwXCWUvyBpgagoQy7yz3L6/gEJuoVYyqy0pVxKUl/k
	 tjfsH6Zvzd3hw==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	amir73il@gmail.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] backing-file: always end a queued write" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:54 -0500
Message-ID: <20261107055653-failed-6.1-627cdcbc2a2e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 627cdcbc2a2eceb0452078a0c14370f9f1f17a91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055653-failed-6.1-627cdcbc2a2e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 627cdcbc2a2eceb0452078a0c14370f9f1f17a91 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Thu, 29 Oct 2026 19:03:19 +0100
Subject: [PATCH] backing-file: always end a queued write

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
---
 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 2424dc38d21ac..ad573f5153c7c 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -96,6 +96,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
+	bool is_write;
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
@@ -136,7 +137,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE)
+	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
+	if (aio->is_write)
 		kiocb_end_write(iocb);
 
 	backing_aio_cleanup(aio, res);
@@ -251,6 +253,7 @@ static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		return -ENOMEM;
 
 	aio->orig_iocb = iocb;
+	aio->is_write = true;
 	aio->end_write = end_write;
 	kiocb_clone(&aio->iocb, iocb, get_file(file));
 	aio->iocb.ki_flags = flags;
-- 
2.53.0




