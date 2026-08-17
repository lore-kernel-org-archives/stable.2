Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278A3D25B6
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969893; cv=none; b=diyGTXQlkeWWF6hru4JhbyemONZ8xhcJ/HjqxshWqqbI1tn30CccApOItDMUGN/GTGjoUiLmrQeh0OZKKDTYGZNGyBDyChPVfXtWcDubJNpEiWlyhu6JrGk1EntTNKBTqhpk0UsyE6suzncFtfOJH5IDmCMrJYw7+uB/ZxBV3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969893; c=relaxed/simple;
	bh=AuP10tOexuOSZAR1PfiUDpaQT0gFpS/552+xIEkRr0A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WhvcjzkiPLlbBd2qwjKHe8CyCH0ChQ3wUPt8MRNr8NJIgd/+jskJ8OeKji+HP26e/ZP5N5OZQTlN6LzgrxiqfhTJ7RR2gwdvb2sGdWho20gmGTKiJPvn2jf6I9HE/KtuTa2gmU4fRWa4ehkQHwvP8q0ElMQUclGtJr9PY1x1YZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2h8us0sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2h8us0sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70C71F000E9;
	Mon, 17 Aug 2026 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969892;
	bh=IR98+3LGulRYmQSFcDk0Bp7gJCSViQC0/uVnXGDt/sE=;
	h=Subject:To:Cc:From:Date;
	b=2h8us0sratXyqYRj+jMFEtwdtMdDzLd6+PAySzj3IDEkkC/z3m2FhuWMJZNC+Aa3d
	 ltJth8AYmGcDpEXrHQhV9+U8xTdeEgxUDL1O8y0ylrEpRRySNc4eF6dkDL4GMbZiry
	 rzTvEJFE3C5cxEn506C+JdIxYqp5m/XlCIJwy48s=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Remove buffer from list prior to unmap" failed to apply to 5.10-stable tree
To: ekansh.gupta@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,jianping.li@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:31:16 +0200
Message-ID: <2026081716-dandruff-marbled-a300@gregkh>
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
git cherry-pick -x 6102ceb4eab845743ee57acd3863fbd06e93c927
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081716-dandruff-marbled-a300@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6102ceb4eab845743ee57acd3863fbd06e93c927 Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 23:33:38 +0100
Subject: [PATCH] misc: fastrpc: Remove buffer from list prior to unmap
 operation

fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
getting removed from the list after it is unmapped from DSP. This can
create potential race conditions if multiple threads invoke unmap
concurrently, where one thread may remove the entry from the list while
another thread's unmap operation is still ongoing.

Fix this by removing the buffer entry from the list before calling the
unmap operation. If the unmap fails, the entry is re-added to the list
so that userspace can retry the unmap, or alternatively, the buffer
will be cleaned up during device release when the DSP process is torn
down and all DSP-side mappings are freed along with remaining buffers
in the list.

Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
Cc: stable@kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260724223342.629168-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4f01ebfa6f95..12dcd2e737c3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1889,9 +1889,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1905,6 +1902,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1912,6 +1910,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1924,7 +1923,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)

