Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CF3F660E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533479; cv=none; b=Rnyi3G2xCfn0Etb1q5147n2JDw06paVZWrTbY6y0Se8+7gulI9jYAvLjqk8DBNnZKt0gwlJjjNBQnDlH5EDwBliOtJxeF3hBkZwf/kCrrkiNI1lAjibHoWA161pxfpRjx4E2sNOs2Xd0m8G+103U+fMn2lUmax6/gQ/fX8YPe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533479; c=relaxed/simple;
	bh=W05DEG4ciWjNpBuiKeXhAsu3otI/V1GvJBfeKihAMZI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AzmyVJML0BuySh8woSvlZHOmyoROSHnHzJhDyJiBtyeMzIWqqAgJU/N93dXKIYfAx+DJSsXjwPRxA5ePUdLoqRe9kPVNUhq4Db4l89DmVLVWlyEiMoIsCfZ7zVEnO7m9xqyigOBmBSqy5flevA3mPFjtuEX/fGpDh3NzcG0oa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYDAYdWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYDAYdWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B71F00A3A;
	Mon, 15 Jun 2026 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533477;
	bh=rP7Rmg8JqIh5OD93s6tItQJw9RVBmYVTSDLXtjd5KyE=;
	h=Subject:To:Cc:From:Date;
	b=sYDAYdWyPAarNYTRr7eL41NQ4z4p8MIBmbQ255r0xXndf7hHQ/a53ke2/xgEsxFnn
	 B2pHBokrIin9TuEEipKIk6kDL3kiQ88dZPUzRPTrPjtNt7rk97VpkKBkgTdEu6+yeC
	 r+JcTeIMEcRj3Qjeupshxram6WsM9BwtufPAgsQw=
Subject: FAILED: patch "[PATCH] zram: fix use-after-free in zram_bvec_write_partial()" failed to apply to 5.10-stable tree
To: shenxiaogll@gmail.com,akpm@linux-foundation.org,axboe@kernel.dk,hch@lst.de,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org,xieyisheng1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:38 +0200
Message-ID: <2026061538-plural-chance-d46a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 732fd9f0b9c1cdc6dfd77162ded60df005182cc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061538-plural-chance-d46a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 732fd9f0b9c1cdc6dfd77162ded60df005182cc0 Mon Sep 17 00:00:00 2001
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Thu, 28 May 2026 10:48:44 +0800
Subject: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()

zram_read_page() picks the sync or async backing device read path based on
whether the parent bio is NULL.  zram_bvec_write_partial() passes its
parent bio down, so for ZRAM_WB slots the read is dispatched
asynchronously and zram_read_page() returns 0 while the bio is still in
flight.  The caller then runs memcpy_from_bvec(), zram_write_page() and
__free_page() on the buffer, leaving the async read to write into a freed
page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the write_partial
counterpart was missed.

Link: https://lore.kernel.org/20260528-zram-v3-1-cab86eef8764@gmail.com
Fixes: 8e654f8fbff5 ("zram: read page from backing device")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 07111455eecf..e11ee1ed3832 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2337,7 +2337,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);

