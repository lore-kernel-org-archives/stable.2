Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969854CF74
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875021; cv=none; b=Q98vmQ8ZLW59z4fTsb7i9TDVSCg6QUPYeSf+LXeCmAaCDtoSJ0W8OYvYBNI5HGjBE60PeOL0xUl41Uc6Ew3QlnvDSwqXrYRBxw5dbS/KP0jJ59vNx5cMVsiahfH1tzxGmEkkipOYDtvD4l9ZlOqtJIYSuvd3d/K7QuTIXHkFpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875021; c=relaxed/simple;
	bh=OG2NegPey70f4R49epnB3ZVJoOTr9LrS5QlBeWbWu5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tlA1XpBXDVPH+oZQ9PJiRdXKxxUpx24F9nVAQ/WQeVAo4Zv6BS1MNUJfA4db90c7wV0wxLU83SPJDQDYCFwbYCcxYrb8Mfd0rJxD9zWEaqMnwZwiMaUUOHXjKPEKKjO97PxIC7xuMNTPXlZgknrArDFbdL84X8sMkgfX3LFRyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTTsDqhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTTsDqhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9241F00A3A;
	Tue,  8 Sep 2026 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788875006;
	bh=HcZ4Wlk1L8YkpXQmW0JW+LQloyh6BClL6oC71XXwCnk=;
	h=Subject:To:Cc:From:Date;
	b=NTTsDqheoacMj/oiSkYdhFyVIcN3Gt8A2nA1Fm3WGVr/LmtSFGQDqeRLOapfxYmMU
	 N4wbi4Uz3aWlaCotIONM/Fg1YHgMjOuHPTz+G5+iDgrX0dBMZe62B1fiby0EELf0IF
	 f2fVLV6kJBJMi2ZbhA7hw2RUxxBzdHr8HhPZLQnc=
Subject: FAILED: patch "[PATCH] misc: fastrpc: don't publish fd before copy_to_user()" failed to apply to 6.6-stable tree
To: shoubaineng@gmail.com,christian.koenig@amd.com,sumit.semwal@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:37:20 +0200
Message-ID: <2026090820-providing-sleeve-6d20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a4a1a2bfcb29785292d634d7787edc6fb550714d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090820-providing-sleeve-6d20@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4a1a2bfcb29785292d634d7787edc6fb550714d Mon Sep 17 00:00:00 2001
From: Baineng Shou <shoubaineng@gmail.com>
Date: Mon, 17 Aug 2026 13:04:55 +0800
Subject: [PATCH] misc: fastrpc: don't publish fd before copy_to_user()
 succeeds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
Link: https://lore.kernel.org/r/20260817050457.1005285-3-shoubaineng@gmail.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index eb6c2a78d3c7..d7a9e12f5575 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1712,24 +1712,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 

