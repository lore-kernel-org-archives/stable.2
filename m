Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3D13AD1C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047839; cv=none; b=LYd40rYqJMAfF7wJllvyEgc1cVFzriXkgdc36n4r7DHk9YUce/SmbSzdWww7pyA4t8qx2snbbznl/hPBzMlhJAPzfBBbf4GH43x/joaN68jXtcg1mXspWNy7Lkll8D2n++nizohuMeHy+kbElwbIGI80S1I8hjypeM1y/+qgmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047839; c=relaxed/simple;
	bh=S8ebPQEMEjhBZzAehV+hm7vplPe63sQwu+prRfMpMfI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tbYfF9LhiZMTHItdjrGrejpvk9D63HHXdJMr497e0BT8kkYwfOGjGBr2krU4xh67SjhvWmxeXJQYuvOFWu/vIGLi8BBKSxe4h1QWYryQr8ehFyqvHkk6Y4tGhdUF5djVpKGO661OY8KIExA6ueCu122E4MzGYBU20cDpx46DrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nb2T7w+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nb2T7w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A34F1F000E9;
	Tue, 14 Jul 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047837;
	bh=7IpAyvTMXlPhCNoinPYJJ2GjiTjvt9SbGcqfpMvLxCM=;
	h=Subject:To:Cc:From:Date;
	b=0nb2T7w+G+YWpxTlHvgeVISIGlrKk+YWZWbDyTLlQPwUKQdwnscFzHqzvQ41KaUPy
	 Q7jgGbn9cCKlLZKEcZVNRQvfeE7P3MSQbMQqfYpXdintak9i9LgHMLXtZoJe3uUknw
	 /Nex56f1IutqxbIEmvap5ANzAphGdX3/UA0JxXV0=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile" failed to apply to 6.18-stable tree
To: nkapron@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:50:25 +0200
Message-ID: <2026071425-shield-overhung-4ba9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 8bdcf96eb135aebacac319667f87db034fb38406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071425-shield-overhung-4ba9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bdcf96eb135aebacac319667f87db034fb38406 Mon Sep 17 00:00:00 2001
From: Neill Kapron <nkapron@google.com>
Date: Fri, 19 Jun 2026 04:06:04 +0000
Subject: [PATCH] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, ffs_epfile_release unconditionally frees the endpoint's
read_buffer when a file descriptor is closed. If userspace explicitly
opens the endpoint multiple times and closes one, the read_buffer is
destroyed. This can lead to silent data loss if other file descriptors
are still actively reading from the endpoint.

By tying the lifetime of the read_buffer to the ffs_epfile structure itself
(which is destroyed when the functionfs instance is torn down in
ffs_epfiles_destroy), we eliminate the brittle dependency on open/release
calls while correctly matching the conceptual lifetime of unread data on
the hardware endpoint.

Fixes: 9353afbbfa7b ("usb: gadget: f_fs: buffer data from ‘oversized’ OUT requests")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-3-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index d9b95fb830df..44218be1e676 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1375,7 +1375,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&epfile->dmabufs_mutex);
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -2393,6 +2392,7 @@ static void ffs_epfiles_destroy(struct super_block *sb,
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		simple_remove_by_name(root, epfile->name, clear_one);
 	}
 

