Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07D379C46
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237706; cv=none; b=I6xd5Rh0rWdn4HqYxBUhUamf9boylVIxeLNmqtLoCTFx+tQma5LENWIkHzlIHP690weB9hRVIeYhkQMoB15l5sFHSKhvaOJS2OzE8+ZimEoPBByfoUSA0BQGTvxvwBd2/36fiFGdF8PYvVlyrnh7Y7LWyaiy1wzTR4Q8HobjsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237706; c=relaxed/simple;
	bh=9rCLvL/ORRkG8KXauP7gIVTrtKhFkRRBu+aRh66xx+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRymrnqVkYwh6nPQQkugzXBuZzomb0sKXpqHzIL0nYrTTdvyNFNQhdUW4I6Bj0t+po9xUqadDIpzOAuEB/6n1QXrMrwyK0fJI0sg45QuP8ApAmtujebSPxnsA0MCYE7YdoO1vwWKmRXm+waOL04NZYYARRpareil1NA0v8okL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCkjaiWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCkjaiWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48161F00A3D;
	Thu, 20 Aug 2026 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237704;
	bh=uM6SNAXuEQpjs9E9eLNsWTbaPx5ffpngWpWdOvP2ySw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCkjaiWZNltn2k3j8WNLnz7rvGvecD5Fe/u+DKwe9W55NfDOKxW2sLDQSfEvutrRR
	 5hRW0wXtwRDeW2dPNP2cYTeKneIHYRZsXY86SHldlWd0FZNes+MSO0WCDyyOBuo7yd
	 m1PFtKIs10XshaaQnycIEabRPFjHX7qv/frkJ8KtlVHwFN2W/vTtnNPsqkZJ0g82TH
	 YLCZVoQ8Ug3kKvDcTEMYFQVm5XsmrG0wh2hKXUwl6+J/GkVaelkw450SEDUzSLcom0
	 YG0CfCSp+p+xYXx9rPR3BepYjZWluzUefEmJpFVlEyYWtfC7WLYPaItXlSHwwB8mgj
	 oojX1Y538e+8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Jianping Li <jianping.li@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] misc: fastrpc: Remove buffer from list prior to unmap operation
Date: Thu, 20 Aug 2026 10:55:01 -0400
Message-ID: <20260820145501.1942628-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820145501.1942628-1-sashal@kernel.org>
References: <2026081715-barbecue-galleria-588e@gregkh>
 <20260820145501.1942628-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

[ Upstream commit 6102ceb4eab845743ee57acd3863fbd06e93c927 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 48efb71f95a8a..77c3add13b3aa 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1677,9 +1677,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1693,6 +1690,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1700,6 +1698,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1712,7 +1711,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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
-- 
2.53.0

