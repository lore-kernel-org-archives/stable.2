Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBD3B8BC7
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254594; cv=none; b=mSX5G4BBrjm+xeeKp5IU9hT3QIZ79a0WyjPo7q1njFGm/VpgwYoXPgN78aTxmscjOxzFhS+uk7MTlbRvTKJE6mOvZQ9NmpchoMs8ba8WlQndLrcsb7cAYr6xwYilwdVP4NRgR1O5Uv3yrHMFXewzacAXlh4nvTEyJ1191UhXzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254594; c=relaxed/simple;
	bh=8p++FPRRdPoDCOHZJpCTURR/hfK502I0deHaZW/0EHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjJDCPXyEzHFohXaao4RYFxMVtRBxliPQBFy6DOmuIkNuO4oIRFEDWewH+aMU1WcdhTQe1OtTY80HoNuMwgeZjJ4XvtjI2pE8gHUpa93VRo/qg17+TFTTfrYY7MsX59eaZXi4q/2bNvS8Z9KiG/JyANT36uBSnEw6UFrVU5yb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpjVrMdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpjVrMdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75C91F00A3D;
	Thu, 20 Aug 2026 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254591;
	bh=VoE0lQnG3BrU18EVFYfOiMclog0bKjjwHDYyQRKfKk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BpjVrMdLniuLzE/BNRKhhnH0kQKwh5SvSLtPJSJhr24uLy2MQTchVvG/qLUbCujS0
	 Y+ODa56io4W67Kt41txyvv7e2GGTO6rKk0x9QZUjBuvmkXp+HlyYSQpjMmHAzgWb4k
	 XcR7rhcgePDBAeK0usWVpub/cpTOBHfPPmvZtp1gcDXnsYXVJlaK4SrxcSHjQVewL8
	 uFs56DpWuNYOF/6XutEsX1TiTzI3bCW4sND9qj0bgr3l7PBdr7/tUiTAuaUWURAW+4
	 2xCXVocveLBh6fv/gXtqnPs1UrYdTNLQ/komFfB7ZAe/zZ4kWoKUFcdURKPksFEHTN
	 EDcg+uxEIwPCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Jianping Li <jianping.li@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] misc: fastrpc: Remove buffer from list prior to unmap operation
Date: Thu, 20 Aug 2026 15:36:26 -0400
Message-ID: <20260820193626.2274224-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820193626.2274224-1-sashal@kernel.org>
References: <2026081715-crucial-stammer-2659@gregkh>
 <20260820193626.2274224-1-sashal@kernel.org>
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
index 33b4d3bf54a8d..6df7f3ee7a742 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1409,9 +1409,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1425,6 +1422,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1432,6 +1430,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&fl->lock);
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
 			buf = iter;
 			break;
 		}
@@ -1444,7 +1443,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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

