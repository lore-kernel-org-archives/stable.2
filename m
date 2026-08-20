Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07C37B41B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264892; cv=none; b=fCzhYQDSxTcL8wpVeG6KKKW83gz6b74Sl1y5O335wB9Eq5QL+kx6nSI7h9nn8Hruy29IMWv619VoSp0HiYBaPp7Vb8mAFJD/ucZQzzZleXGZFN4yxbeDfKGjd9i+NZGIEx0KbyGKGskzVXiEDW/VKupm4Rhaxlp/KBT5OICMxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264892; c=relaxed/simple;
	bh=Csqp8dTkp3dP0Gxbl8Tvjyr9htDm3CL3vpVHuaLMtD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5CxINppBZLujAJVcNa1/E2i+itqFdA0/azVkQ1wyGHG5eEXKd4MDZS8NEHlgCODebfkSVpOokAyceqot6vT7l/VudzRysneq+ai47BNscYv6OuCQI9xRkNIFyM3RY+nrzhVDoBC+qcmS7+THQ9jd9IAFdZRdasDTsJUwX1tZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmiBG5Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmiBG5Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA66F1F000E9;
	Thu, 20 Aug 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264890;
	bh=oe19wGZMhKeXI9gmCCiULupTcIhvdpynfT+ivh8lc+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QmiBG5VcPH9r7ESxRPpj479QdKnTaRx1+/roN6iekpU8JQu/OLEUny8lSa79dqGM2
	 c8So9OpNO2rNXCm8bguaAwq8vSFYj8D/AiS1NPR8wjkDFI8sVHvsazkGVt1v2zdyw6
	 VUl7UG2wkE8WDtOJC8DnNBE4j1irfYNlCNwuQMK7QjG0TUcYhaU9mkGawcv6G8jXxk
	 lhC1Jxa7k3c1j+2b+zBB5GsTlPeRwVt4kfu00WnVahaNJ6IDRIRcrwTh1cxo5I3gjq
	 eX29n4k41U6e9P3M9EKCJY/BYoyMiru5cBmlFSA5Ktgil4IFpO2nduiABwdVDoYpiw
	 f8r4S7QwnkjnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Jianping Li <jianping.li@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] misc: fastrpc: Remove buffer from list prior to unmap operation
Date: Thu, 20 Aug 2026 18:28:06 -0400
Message-ID: <20260820222806.2320324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820222806.2320324-1-sashal@kernel.org>
References: <2026081716-dandruff-marbled-a300@gregkh>
 <20260820222806.2320324-1-sashal@kernel.org>
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
index 6f4b66735aae9..6f1787e83b65f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1407,9 +1407,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1423,6 +1420,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1430,6 +1428,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1442,7 +1441,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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

