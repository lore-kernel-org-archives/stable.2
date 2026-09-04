Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C854DA52E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537221; cv=none; b=rPXCdzkL0LfcLKec0htFfs3g4BZzTWQ1UtzO9Q8Wf1FTXod6ohGag3YQEFjWKwCjqcsomEZUGBc9EZtP7Uy7SsTITWejQkwpY0FNpvZVcuAfUe9ltoNnE9U6yQFZdKjgbP/mzufOIqtjuQTIH/deVK5iHhcvLLg8m0GcGxyuxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537221; c=relaxed/simple;
	bh=lhyZ+fQFBI2Jg9LLFkx+SuZyUxSN3dAtA7SPpZKzvSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUGlV34IImSmpMxo6/tkowJhjIfUL6MU8rajWOggp7UFbgAV9upBrElpKga7vFpCf6DUqEJjIevauc0VIuc0pf+ww9gbxcxM9XxBCsUGKjGhtOSlSfU+EQQNIc8BH2oQak/Dp14CIb0SXaqiHOC48D80A08mLK3PRfLT4P8A2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfpHVqFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfpHVqFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BB61F00AC4;
	Fri,  4 Sep 2026 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537220;
	bh=Qr8HN1zGIImDdwM/tN18Su/k876N5TyK3TevHXWNnpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfpHVqFFRo0yuAoOAeXAlUfv6Aj//rDKyme0/R3voe25zPWHuBJ+SpkPxR3TAHQBk
	 d/8LGDNdxXWtFPkKcZTB0i5jLbJWZYIND9WNnqXRMTrFCIzazSi56CruQ3H0VZRdtN
	 rXkYsnMNc+Ootn6ZLAbbTYqUT73Z8MF31rTeFy1v9wN193BpqRRHFsB19JfEind74G
	 eBuXbhs6m96KghE3aE8GbDG+3wsw16E1VdbYqwEuIjihfHtXcJpLBJmGsCtvJLJm9k
	 OJNJ5gIYXPaGLnNNTYqVSQbH+hTyMtaj48BDME2H/kNtLRWK+932Ca0cf5k2BL+0kS
	 7CsA4fdnP4xBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] usb: remove res2 argument from gadget code completions
Date: Fri,  4 Sep 2026 11:53:33 -0400
Message-ID: <20260904155336.1042108-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155336.1042108-1-sashal@kernel.org>
References: <2026090333-willfully-art-ea0b@gregkh>
 <20260904155336.1042108-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 4c3d8accdce26afa8089609593aa92965b500f72 ]

The USB gadget code is the only code that every tried to utilize the
2nd argument of the aio completions, but there are strong suspicions
that it was never actually used by anything on the userspace side.

Out of the 3 cases that touch it, two of them just pass in the same
as res, and the last one passes in error/transfer in res like any
other normal use case.

Remove the 2nd argument, pass 0 like the rest of the in-kernel users
of kiocb based IO.

Link: https://lore.kernel.org/linux-block/20211021174021.273c82b1.john@metanate.com/
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: e78dcb1f7ec2 ("usb: gadget: f_fs: Fix Use-After-Free in AIO error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 drivers/usb/gadget/legacy/inode.c  | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 7800f3b881ed0..bb1fe2f37289e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -841,7 +841,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
+	io_data->kiocb->ki_complete(io_data->kiocb, ret, 0);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ed28aaa82e251..e6ffbc82d48c4 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -473,7 +473,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ret, ret);
+	iocb->ki_complete(iocb, ret, 0);
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -500,11 +500,9 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		kfree(priv->to_free);
 		kfree(priv);
 		iocb->private = NULL;
-		/* aio_complete() reports bytes-transferred _and_ faults */
-
 		iocb->ki_complete(iocb,
 				req->actual ? req->actual : (long)req->status,
-				req->status);
+				0);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
 		if (unlikely(0 != req->status))
-- 
2.53.0

