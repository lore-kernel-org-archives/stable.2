Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599593;
	b=KbZqibRFY8SOlZKotcrxLon0l42pXGRe2j8xl7hfJQkYA8o0SPilr9i0s50IzR7ccgPp
	 CYniMhEuzoShBXEXjKU6Q9GHqlmXR4gz3twqxSfl4QhaFFgvnqUjMlRDK6YfGo+AoSTII
	 lEurA2OXaHn+cOoNXb+68ggxMjzR+8NM8XLHycWxBAGJhlFB6TLzFIKKto4XLAY1pO7V9
	 hAz+ub5xr3I2Fce3U2D8ENaLT8x3P8LJzQ2B671fTUZJS26y9WlgKwUTf7M0E81iAsiKf
	 EUXRVpfedZiUh/r90l6zPbexBnE+8RTqFWkk0FfyoECZNBmOssIqlsPKneL7QTHWiJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lPVapoNCY6fZVvqFCE+aP7nNLaMuE2QS0Bx8eZT3j4A=;
	b=ZRtNtxn1AVUQRbI8Lj5gqzX1CoiZ028X5GTvutLu2STpP+8X45mGDAkx1733vXH7HpgD
	 xSVJN56DVpgOXddhgAhe8fT+xwo0/pcqhFyLytIlaAdnFaZbiIyVcxjppXaPxx/aMNmC+
	 mxathOQ94zO3iB5BwMoOcJVjmMRTPosxOIdZr8Z/0Zddlobsz3EHhskTpk+B6cZzOR/Jd
	 fpAo7g84ECY+jz1LBTOCf7HjrX6eAU5loJg9ixPZ9GsVX6fasl8hgo7LFqOwUbbgLScqE
	 XGe0tnUqeS4H+x6+hyaQKl9jTWNp+Efxi/N+aPh6jDW3cE6OrthdN5cVfl0Y1I+zdpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsEPWf1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF0606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsEPWf1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1FC1F000C4;
	Fri, 13 Nov 2026 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599592;
	bh=lPVapoNCY6fZVvqFCE+aP7nNLaMuE2QS0Bx8eZT3j4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsEPWf1os/BfCJmwR0OHSjDdh/FMdyl65mmlpmR9234F/QkDlHr2gwdyHv4DII07y
	 BhZbgHwJ5v8BUW+9Sgd7P8xuUd0T+l9qWP3Iq10eolAIyJGqDeXEghKLNgnlvUBtBg
	 fHo1Si9gHyXnDUOzpcRk6AdHvfZDTqm1f5Rv3LJpIhDWIXVVemLZinQpFM3D03qDoq
	 pkJnHpyeIIlcV6Kocw8F+N46irmLMZVw4GBx8GyhbouBisDx/8KDPa39M24Vukrd6N
	 dj2vayWwZaJ7Ts/7T49ig8f8415Ja3kwA5vG8tbX5RLvVmwYaWWYwI9fExvlC0ehb0
	 DeflDT7zws/SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] vhost-scsi: Reduce mem use by moving upages to per queue
Date: Fri, 13 Nov 2026 14:53:08 -0500
Message-ID: <20261113195222.2537874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201252-failed-6.6-01c3a5fa6d64@kernel.org>
References: <20261109201252-failed-6.6-01c3a5fa6d64@kernel.org>
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
index 7603597efe5ef..5fa9aab9279b6 100644
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
@@ -613,7 +613,6 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 	struct vhost_scsi_nexus *tv_nexus;
 	struct scatterlist *sg, *prot_sg;
 	struct iovec *tvc_resp_iov;
-	struct page **pages;
 	int tag;
 
 	tv_nexus = tpg->tpg_nexus;
@@ -631,12 +630,10 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
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
@@ -663,7 +660,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
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
@@ -1596,11 +1595,11 @@ static void vhost_scsi_destroy_vq_cmds(struct vhost_virtqueue *vq)
 
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
@@ -1626,6 +1625,11 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 		return -ENOMEM;
 	}
 
+	svq->upages = kcalloc(VHOST_SCSI_PREALLOC_UPAGES, sizeof(struct page *),
+			      GFP_KERNEL);
+	if (!svq->upages)
+		goto out;
+
 	for (i = 0; i < max_cmds; i++) {
 		tv_cmd = &svq->scsi_cmds[i];
 
@@ -1637,14 +1641,6 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
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

