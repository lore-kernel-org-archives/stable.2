Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599196;
	b=mC8TrAkwHJc+VSbXlD2/Rcb1YdcXs2gjCqrLEKxsOBwhxuLTGXvHg9iZqTyA/o8wHRzE
	 r0gr9mmbBmCslLKjoKLKRbqm/CnbLv6z0Omtt/ciLFvwNFgrYuQeHd0DGxfWxXStlQ2q1
	 cTAhUqmMjRGLwhipHTEjAh9jxeKLraEuLW9eBk1U3KG2llrxrIacwLG643W92//C65H5K
	 v0WX73JFIH4NoMDUD8n29xgx1NzSIuFBrc6VeWM0QFGRM6Tagav35DbTPW5apDcn2iOHY
	 ixzM9XdJhdoBHiMcJWKhWu8HL9/cmVNNqRtcT2PBR1X0qYvedLmppcLJanB7uLX2vlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RqYD2QLfrmT+JXiqe1Z/dfWogE3ic1qMt7bQPXQG+q0=;
	b=zkK3oueiqfL1YqR2dJs23hQan/YUu9z8jwWiWftflnOoGYOsZ59BwxrHEob8Xrh2//qK
	 CQ8uw/LAbJxKZ10dVvaaqvJLuCSMGhedLpXmnDhbY/w2Uc8/z7tRTOPBzf/DICS/wIFQX
	 ve/Xv0yncPobGI/B2oFtIDCdR3t8eIjPU0igoEYKeezvDDiUL6AA+OYDlV1kzBcJS3bDP
	 bWlYdKXwoT7+I1ZrFkWKQFPvlto9ehFyeB5nXvmXLA0U/WQbH5V/EpqVXTaLkr0YY977e
	 9cVX+Fv+LC3irCuhccKFzjp8wjlseiY14+XVuCvqr2JFD7Jyxl47jFvcSVAUm2ATAfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UToSO8u5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31127606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UToSO8u5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3391F000C4;
	Fri, 13 Nov 2026 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599195;
	bh=RqYD2QLfrmT+JXiqe1Z/dfWogE3ic1qMt7bQPXQG+q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UToSO8u5zq0wrLjSxCpsOPvPFiQ3Gvhzmt82Tl8hqLaBnFr8eZH9zawOowvI+Tcew
	 nybPA6mYTc8Oq12kiexv9YF6vAlRrl0rhybSVhefXAWn4ROtIoRDIyNDtEY0UJb3X+
	 wjPiPkzOdZb0sBlcBdEJSGTcjSt0OzDwa5TmngHwe2G7TRkVt8XPFawfdanXsIcKZP
	 z3IjHEo6n+Ga16sVPEmxFiXY3fTSdxpcV7dKwffPcXpTtqZuRmLauFvpXLUgLBH03f
	 42LRbR8iIcKP9Laz2JkrHIFdXnF1mo821INTjfNGjTKN7NWV0c+tcF1c1Nbg8iT5XJ
	 uwMw1afyPOFJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] vhost-scsi: Reduce mem use by moving upages to per queue
Date: Fri, 13 Nov 2026 14:46:31 -0500
Message-ID: <20261113194602.2463861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200826-failed-6.12-01c3a5fa6d64@kernel.org>
References: <20261109200826-failed-6.12-01c3a5fa6d64@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 4c1f3a7d74277903b290dd989cbd2ea8627fc925 ]

Each worker thread can process 1 command at a time so there's no need to
allocate a upages array per cmd. This patch moves it to per queue. Even a
small device with 128 cmds and 1 queue this brings mem use for the array
from

2 MB = 8 bytes per page pointer * 2048 pointers * 128 cmds

to

16K = 8 bytes per pointer * 2048 * 1 queue

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20241203191705.19431-2-michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Stable-dep-of: 01c3a5fa6d64 ("vhost-scsi: zero misaligned I/O bounce pages")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index fa0d407442914..725166d4cc79f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -83,7 +83,6 @@ struct vhost_scsi_cmd {
 	/* Pointer to the SGL formatted memory from virtio-scsi */
 	struct scatterlist *tvc_sgl;
 	struct scatterlist *tvc_prot_sgl;
-	struct page **tvc_upages;
 	/* Pointer to response header iovec */
 	struct iovec *tvc_resp_iov;
 	/* Pointer to vhost_scsi for our device */
@@ -187,6 +186,7 @@ struct vhost_scsi_virtqueue {
 	struct vhost_scsi_cmd *scsi_cmds;
 	struct sbitmap scsi_tags;
 	int max_cmds;
+	struct page **upages;
 
 	struct vhost_work completion_work;
 	struct llist_head completion_list;
@@ -624,7 +624,6 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 	struct vhost_scsi_nexus *tv_nexus;
 	struct scatterlist *sg, *prot_sg;
 	struct iovec *tvc_resp_iov;
-	struct page **pages;
 	int tag;
 
 	tv_nexus = tpg->tpg_nexus;
@@ -642,12 +641,10 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 	cmd = &svq->scsi_cmds[tag];
 	sg = cmd->tvc_sgl;
 	prot_sg = cmd->tvc_prot_sgl;
-	pages = cmd->tvc_upages;
 	tvc_resp_iov = cmd->tvc_resp_iov;
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->tvc_sgl = sg;
 	cmd->tvc_prot_sgl = prot_sg;
-	cmd->tvc_upages = pages;
 	cmd->tvc_se_cmd.map_tag = tag;
 	cmd->tvc_tag = scsi_tag;
 	cmd->tvc_lun = lun;
@@ -674,7 +671,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 		      struct scatterlist *sgl,
 		      bool is_prot)
 {
-	struct page **pages = cmd->tvc_upages;
+	struct vhost_scsi_virtqueue *svq = container_of(cmd->tvc_vq,
+					struct vhost_scsi_virtqueue, vq);
+	struct page **pages = svq->upages;
 	struct scatterlist *sg = sgl;
 	ssize_t bytes, mapped_bytes;
 	size_t offset, mapped_offset;
@@ -1659,11 +1658,11 @@ static void vhost_scsi_destroy_vq_cmds(struct vhost_virtqueue *vq)
 
 		kfree(tv_cmd->tvc_sgl);
 		kfree(tv_cmd->tvc_prot_sgl);
-		kfree(tv_cmd->tvc_upages);
 		kfree(tv_cmd->tvc_resp_iov);
 	}
 
 	sbitmap_free(&svq->scsi_tags);
+	kfree(svq->upages);
 	kfree(svq->scsi_cmds);
 	svq->scsi_cmds = NULL;
 }
@@ -1689,6 +1688,11 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 		return -ENOMEM;
 	}
 
+	svq->upages = kcalloc(VHOST_SCSI_PREALLOC_UPAGES, sizeof(struct page *),
+			      GFP_KERNEL);
+	if (!svq->upages)
+		goto out;
+
 	for (i = 0; i < max_cmds; i++) {
 		tv_cmd = &svq->scsi_cmds[i];
 
@@ -1700,14 +1704,6 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 			goto out;
 		}
 
-		tv_cmd->tvc_upages = kcalloc(VHOST_SCSI_PREALLOC_UPAGES,
-					     sizeof(struct page *),
-					     GFP_KERNEL);
-		if (!tv_cmd->tvc_upages) {
-			pr_err("Unable to allocate tv_cmd->tvc_upages\n");
-			goto out;
-		}
-
 		tv_cmd->tvc_resp_iov = kcalloc(UIO_MAXIOV,
 					       sizeof(struct iovec),
 					       GFP_KERNEL);
-- 
2.53.0

