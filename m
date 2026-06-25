Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9303E3D90
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391963; cv=none; b=OEJTihEgNcJ39mKoaJEIRiPh2l2DZsWsWBpEbpQH1fbrr51MBAxRm93jFKpLQOIUeqSAr+n3EAJXEJesBXLKRDghHAZ37GPmZ1VGXmhYNZaDRTdXL2WU4DaB5QK/btp86btJcFM7Fxa0UbppujPs9EK3ep8OuqrV9hEB+UziaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391963; c=relaxed/simple;
	bh=KwXxJMprE3ZaCA15T+eKC6YLBjtmJvrDlNpMCGYOkR8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JlEKmjxHLqGnKIh7Nm8+YhY/KIfO2rwLS5aPnJP7N7iCFryH6siEnexEDGMO7k2sQAqVL753NHKYeUtE3nphfASQDzSXBrhFgzsbB+K1Pe9IME1+AqqurhBfW0T9TIc+THcgbgDOo5iOxYpAjX5ZSIz8NomblJTYZBvv78IMYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPlIBs99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPlIBs99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8361F000E9;
	Thu, 25 Jun 2026 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391962;
	bh=oziBKwUN3/lKR3ImfIotSZBPe9Hu4yrTPCxpx4C1Z64=;
	h=Subject:To:Cc:From:Date;
	b=XPlIBs9967k8zS3++elDi1u4KnPbj+F44pr35V7qVZXXEf/GNDGslQKjsJJmTbucM
	 NaRmV/L11T12TSIoZlbn7UY9Rn9NsNgK/weZxsA67HeIsZ+qCS7FJt+0i6YTQlc2yP
	 1Xg6dNJG6Py/uRHTAVvEy9AZ4i1ns17z7ivDAwj4=
Subject: FAILED: patch "[PATCH] virtiofs: fix UAF on submount umount" failed to apply to 5.10-stable tree
To: mszeredi@redhat.com,abombo@microsoft.com,chengzhihao1@huawei.com,gkurz@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jun 2026 13:48:17 +0100
Message-ID: <2026062516-legroom-wrongdoer-ad3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06b41351779e9289e8785694ade9042ae85e41ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062516-legroom-wrongdoer-ad3f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06b41351779e9289e8785694ade9042ae85e41ea Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 28 May 2026 10:58:24 +0200
Subject: [PATCH] virtiofs: fix UAF on submount umount
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iput() called from fuse_release_end() can Oops if the super block has
already been destroyed.  Normally this is prevented by waiting for
num_waiting to go down to zero before commencing with super block shutdown.

This only works, however, for the last submount instance, as the wait
counter is per connection, not per superblock.

Revert to using synchronous release requests for the auto_submounts case,
which is virtiofs only at this time.

Reported-by: Aurélien Bombo <abombo@microsoft.com>
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Greg Kurz <gkurz@redhat.com>
Closes: https://github.com/kata-containers/kata-containers/issues/12589
Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <gkurz@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8d..9a0f5a8661da 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -380,8 +380,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * aio and closes the fd before the aio completes.  Since aio takes its
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
+	 *
+	 * Exception is virtio-fs, which is not affected by the above (server is
+	 * on host, cannot close open files in guest).  Virtio-fs needs sync
+	 * release, because the num_waiting mechanism to wait for all requests
+	 * before commencing with fs shutdown doesn't work if submounts are
+	 * used.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts);
 }
 
 void fuse_release_common(struct file *file, bool isdir)

