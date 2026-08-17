Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067E3C8196
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969879; cv=none; b=T+oQ+2gktfp4KrYfkAKJKYhIglbb/WuHG5lysOKcDqU142WGTyDI20dyHJ00WJNN6NO2HJvmaFFFJWK/MYgFt5Bx3MTv2eIZJW9t2auvJWZxac8QcffPSaR+7lOZJqDvHVFnY+h3q6gItSR6COObQFw1zwnGlH64t3kef+5lxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969879; c=relaxed/simple;
	bh=pRMepsmhIxmafLvTlNRSKcaTg7XG2h6hKbzufg2VaLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q+WJCe+SKxUumZVvwpYEgBIErj9hhcp3RvFlWxFmf8t3Ra1vPd0B8CpTcP+TZZd5KvmUaknyac18sVp77SeHmg1jWTe4ovtr9/u2fGscJ9MPjxmkmclfaR0Jw2BvNvgScQdVr4ShPwfOu/NjKnpnAxML2t0CXbY+z/XCUaG/uSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxGo4ZEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxGo4ZEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873A41F000E9;
	Mon, 17 Aug 2026 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969878;
	bh=YqpZho93bKxiFhCwvLH95Ejv/uRhsGwlRCKSwFBwUL0=;
	h=Subject:To:Cc:From:Date;
	b=NxGo4ZErLms2yZvHLiPD4SlUJjhcZH4iG2sUjb1dBb3XYXtVcyn4DcPodU35n+/b7
	 Sza9UIByxNdrnSf9jJlnoBq2fKip0RfPmeVZnyVEsqICGrksZSnZq5hXyFhGnZc1HT
	 P2IBJCYQ2P6D5z9T2BJQIF5Oj+ppBT1NfzUMsYBk=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Remove buffer from list prior to unmap" failed to apply to 6.1-stable tree
To: ekansh.gupta@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,jianping.li@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:31:15 +0200
Message-ID: <2026081715-barbecue-galleria-588e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6102ceb4eab845743ee57acd3863fbd06e93c927
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081715-barbecue-galleria-588e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

