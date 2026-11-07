Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047289;
	b=fKRv/gA/jOwHc5Pd6DLoOkDXHe9xQ9oZ0bhPGvGW7rZboIYgtJJ/xKZJoSzw7g2N0++j
	 ZYXOl6wD3sEKusAVzJp6vaWp5SIWOetVLvDu94S+MrXyXRU89B0j8TKzx3UX0q0J+22pX
	 UbfT7cWB17jFH35MulzYnqUyUWlfCKKLsQDaNzWFokRJjM+GQaJHnT3YEcs2Pai/ztR9I
	 OxmewB5CP3m4xUhglKJOqzwXy2dEJMxpzDjTfpEbcOSI5+EjJJusq156qatfuqznNhQjF
	 Zm5u5BjRfPeRULRjMcSOKJmUsfOTdSahdhyJ1TyKLhoSO1XHvDGKoBVT+wcjPOM4SOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wugvbVVcACdPOsgRawQ/rGFGKpYA650b3XMofs9EFVE=;
	b=HBSf6bVzvIrsrJFmocv25HMAownZVKtEHRqAOrOXKeQYiZWlIeiVVVnVHifb9yb6kMzy
	 tnKBBv7msEX4IYfDpJxu33FDfG+mmT8THAqOQlzO/RYdLLXsWrTYGtzecOLUhnLSkfMS9
	 4j98kt3IeoyONb6GX5TX+kfJaDrkg6muN5CD8YdWFj7o/K9gGXbEZvqoEX/uWc+zrrH6S
	 8wmfDWCD+0KGNdvSVoMBVkgNCGCAhz+p7agZwsh70A6rQ0lXKKxRfXEG4YzeVEYqoMeID
	 TiHMMqS3MNRoBRt95ADBRhJlt/ZhDi0ROzEN1tkNmFg609GWyqwyJ6IX08zc8Q0L9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBsucNkn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50367606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBsucNkn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E741F0089F;
	Sat,  7 Nov 2026 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047289;
	bh=wugvbVVcACdPOsgRawQ/rGFGKpYA650b3XMofs9EFVE=;
	h=From:To:Cc:Subject:Date;
	b=kBsucNknIE4KSkSIvS+/pzo8cvIw9Z+UJhBoUhsbJwdF3g7/e/551Vae8Dn0dFcoz
	 bgg+1ojthSAIopftRHw5lcqNGJy/zQrHTXgLkRFQUJpj0/w7mAqPkF5MwtWsbCdagN
	 FhFxpe7RtjMDUYlrCzBN/BazQRG8wZCyfNgqIR7NnOv9woqjI/mvWsBYyly8/XeONb
	 5d/6KexLnvQTOPDF3f0WXCdBmHBJNoYqhGiBo0wydUMoyiPy7P6HRyCptq/6vPDX3c
	 AN5WVjU7JitJj//ii3fQGU6yjk75EM1/3zCAHoX9/BS9RWxwvqz4M6aFp5aMNms0N7
	 OvKxCCQVJUgQg==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	amir73il@gmail.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] backing-file: always end a queued write" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:28:07 -0500
Message-ID: <20261107052807-failed-6.12-627cdcbc2a2e@kernel.org>
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
git cherry-pick -x 627cdcbc2a2eceb0452078a0c14370f9f1f17a91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052807-failed-6.12-627cdcbc2a2e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




