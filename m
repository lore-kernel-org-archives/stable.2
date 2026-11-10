Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322798;
	b=i9kfSNLY199D8hg5zbAETzSrPy4N12M/iXBF3Zbou0PZIDW0KJwLSRwmQOM3nVT3bwxO
	 RSZ3mwnq1FNC+Dt+iAt86c9grZAOQIIxBojolilGWGpVx3ROMf/yZWJVzISplOqusTNDm
	 XlQ6gPl6+WaxiGS4cj89lPxzwjWK6jiKWFYli/6ZLkSVMQ3M/vpCs2fFVQui2U3c2QK6X
	 lPX6DGf7SlHDinOOInt/KC12jMwPsvbgHW+XxEgMAn5hLx5ifYiZYruAIT5J0Vby1frDp
	 n4LvY5bogfo3lGzcGNtt/FmkGRr6T7y+kr4bV4Uh68FvXMdeWPR8qHieAc6UseLevJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XUq+UmJH3uT6SO5B9os08H3G0PP3zi0agisK3tkfjrI=;
	b=S1JrkX+wCm/3KZ7nvcSBmVbv5DjqBSpqJnhZ3ae/LXsgKBkcRAXXgiiWjGr41N80rkO8
	 DyKzAeYccWniTElzhGBTzgSAwoAaFsIEs54cUgmYVcZbPb4Me/AyaQL1uHLf01tVWDiut
	 JvKay4lg25LBoL2Lam+ZQVr0GjmGlMesl1Lh6Sdj7HZ4E/v6ehle9IGw1N4YyhP3KzC6J
	 GAKqh8cn8rzKh4PZCb6ZGHmd8QskUNEgRd3xyhW8PLyiincZ9NZpjGkGrglbMXi2zVrtj
	 WUyxEaac7TFbKRbZBcSMpG/CMSiHr6/2hzff0Fk0wX56mMpQA8xS9ptRZOiaTexPA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxqVt7U1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B960A2637
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxqVt7U1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267D61F008A1;
	Tue, 10 Nov 2026 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322797;
	bh=XUq+UmJH3uT6SO5B9os08H3G0PP3zi0agisK3tkfjrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxqVt7U16vLudQJNSSvdGjBJa3/LpczkV2t5UPjXLiUdcwQuBsBGL5FW5q54drQJz
	 1Gsm9lTlcevu4QxznH9lgRb1kURKe/ykMVmM6c2M55bJ+dopYfG0FzcPU+ZW0OgvyN
	 OKpzmBPK1x7reeD98wyXbX46/gZOdG9RFXcsdcW6UXQNLb/N3s95lZHMxOZ7RjBOcU
	 1GGIWgVLpsEDwax5s+bGFa2i8FfSMXpgTT0IvwiWaQ3wP4wrsxlz726asXaKRz9/qu
	 tkO+7p8IN+Nff2tk4DIPp5WEIZgsrEpRmZBsq37LBFYCONrI26R9jZ+OsRPDt0B0bh
	 d6vB8Mu5N9Kzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] misc: fastrpc: Rename phys to dma_addr for clarity
Date: Tue, 10 Nov 2026 09:59:54 -0500
Message-ID: <20261110145948.2017214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052053-failed-6.12-09fa66ec1b48@kernel.org>
References: <20261107052053-failed-6.12-09fa66ec1b48@kernel.org>
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

From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>

[ Upstream commit 428b2f2b60c37f69e0723a225135da1f352d2602 ]

The fields buf->phys and map->phys currently store DMA addresses
returned by dma_map_*() APIs, not physical addresses. This naming
is misleading and may lead to incorrect assumptions about the
address type and its translation.
Rename these fields from phys to dma_addr to improve code clarity
and align with kernel conventions for dma_addr_t usage.

Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://patch.msgid.link/20251226070534.602021-3-kumari.pallavi@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 09fa66ec1b48 ("misc: fastrpc: fix double-free in fastrpc_map_attach() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 77 ++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 576cd9e5b8079..afafaa68e2bd2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -109,7 +109,7 @@
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp", "cdsp1" };
 struct fastrpc_phy_page {
-	u64 addr;		/* physical address */
+	dma_addr_t addr;	/* dma address */
 	u64 size;		/* size of contiguous region */
 };
 
@@ -174,7 +174,7 @@ struct fastrpc_msg {
 	u64 ctx;		/* invoke caller context */
 	u32 handle;	/* handle to invoke */
 	u32 sc;		/* scalars structure describing the data */
-	u64 addr;		/* physical address */
+	dma_addr_t addr;	/* dma address */
 	u64 size;		/* size of contiguous region */
 };
 
@@ -197,7 +197,7 @@ struct fastrpc_buf {
 	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
-	u64 phys;
+	dma_addr_t dma_addr;
 	u64 size;
 	/* Lock for dma buf attachments */
 	struct mutex lock;
@@ -220,7 +220,7 @@ struct fastrpc_map {
 	struct dma_buf *buf;
 	struct sg_table *table;
 	struct dma_buf_attachment *attach;
-	u64 phys;
+	dma_addr_t dma_addr;
 	u64 size;
 	void *va;
 	u64 len;
@@ -325,11 +325,12 @@ static void fastrpc_free_map(struct kref *ref)
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
-			err = qcom_scm_assign_mem(map->phys, map->len,
+			err = qcom_scm_assign_mem(map->dma_addr, map->len,
 				&src_perms, &perm, 1);
 			if (err) {
-				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-						map->phys, map->len, err);
+				dev_err(map->fl->sctx->dev,
+					"Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
+					&map->dma_addr, map->len, err);
 				return;
 			}
 		}
@@ -400,7 +401,7 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
-			  FASTRPC_PHYS(buf->phys));
+			  FASTRPC_PHYS(buf->dma_addr));
 	kfree(buf);
 }
 
@@ -419,12 +420,12 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 
 	buf->fl = fl;
 	buf->virt = NULL;
-	buf->phys = 0;
+	buf->dma_addr = 0;
 	buf->size = size;
 	buf->dev = dev;
 	buf->raddr = 0;
 
-	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
+	buf->virt = dma_alloc_coherent(dev, buf->size, &buf->dma_addr,
 				       GFP_KERNEL);
 	if (!buf->virt) {
 		mutex_destroy(&buf->lock);
@@ -450,7 +451,7 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 	buf = *obuf;
 
 	if (fl->sctx && fl->sctx->sid)
-		buf->phys += ((u64)fl->sctx->sid << 32);
+		buf->dma_addr += ((u64)fl->sctx->sid << 32);
 
 	return 0;
 }
@@ -743,7 +744,7 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
 		return -ENOMEM;
 
 	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
-			      FASTRPC_PHYS(buffer->phys), buffer->size);
+			      FASTRPC_PHYS(buffer->dma_addr), buffer->size);
 	if (ret < 0) {
 		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
 		kfree(a);
@@ -792,7 +793,7 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
 	dma_resv_assert_held(dmabuf->resv);
 
 	return dma_mmap_coherent(buf->dev, vma, buf->virt,
-				 FASTRPC_PHYS(buf->phys), size);
+				 FASTRPC_PHYS(buf->dma_addr), size);
 }
 
 static const struct dma_buf_ops fastrpc_dma_buf_ops = {
@@ -844,10 +845,10 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	map->table = table;
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
-		map->phys = sg_phys(map->table->sgl);
+		map->dma_addr = sg_phys(map->table->sgl);
 	} else {
-		map->phys = sg_dma_address(map->table->sgl);
-		map->phys += ((u64)fl->sctx->sid << 32);
+		map->dma_addr = sg_dma_address(map->table->sgl);
+		map->dma_addr += ((u64)fl->sctx->sid << 32);
 	}
 	for_each_sg(map->table->sgl, sgl, map->table->nents,
 		sgl_index)
@@ -874,10 +875,11 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
 		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->len, &src_perms, dst_perms, 2);
+		err = qcom_scm_assign_mem(map->dma_addr, (u64)map->len, &src_perms, dst_perms, 2);
 		if (err) {
-			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
-					map->phys, map->len, err);
+			dev_err(sess->dev,
+				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
+				&map->dma_addr, map->len, err);
 			goto map_err;
 		}
 	}
@@ -1059,7 +1061,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			struct vm_area_struct *vma = NULL;
 
 			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
-			pages[i].addr = ctx->maps[i]->phys;
+			pages[i].addr = ctx->maps[i]->dma_addr;
 
 			mmap_read_lock(current->mm);
 			vma = vma_lookup(current->mm, ctx->args[i].ptr);
@@ -1086,7 +1088,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 				goto bail;
 
 			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
-			pages[i].addr = ctx->buf->phys -
+			pages[i].addr = ctx->buf->dma_addr -
 					ctx->olaps[oix].offset +
 					(pkt_size - rlen);
 			pages[i].addr = pages[i].addr &	PAGE_MASK;
@@ -1118,7 +1120,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
 		if (ctx->maps[i]) {
-			pages[i].addr = ctx->maps[i]->phys;
+			pages[i].addr = ctx->maps[i]->dma_addr;
 			pages[i].size = ctx->maps[i]->size;
 		}
 		rpra[i].dma.fd = ctx->args[i].fd;
@@ -1200,7 +1202,7 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 	msg->ctx = ctx->ctxid | fl->pd;
 	msg->handle = handle;
 	msg->sc = ctx->sc;
-	msg->addr = ctx->buf ? ctx->buf->phys : 0;
+	msg->addr = ctx->buf ? ctx->buf->dma_addr : 0;
 	msg->size = roundup(ctx->msg_sz, PAGE_SIZE);
 	fastrpc_context_get(ctx);
 
@@ -1358,13 +1360,15 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		if (fl->cctx->vmcount) {
 			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
+			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
 							(u64)fl->cctx->remote_heap->size,
 							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
-				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
-					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+				dev_err(fl->sctx->dev,
+					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
+					&fl->cctx->remote_heap->dma_addr,
+					fl->cctx->remote_heap->size, err);
 				goto err_map;
 			}
 			scm_done = true;
@@ -1384,7 +1388,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->phys;
+	pages[0].addr = fl->cctx->remote_heap->dma_addr;
 	pages[0].size = fl->cctx->remote_heap->size;
 
 	args[2].ptr = (u64)(uintptr_t) pages;
@@ -1413,12 +1417,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
 		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
+		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
 						(u64)fl->cctx->remote_heap->size,
 						&src_perms, &dst_perms, 1);
 		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
+				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
 	}
 err_map:
 	fastrpc_buf_free(fl->cctx->remote_heap);
@@ -1508,7 +1512,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	args[2].length = inbuf.filelen;
 	args[2].fd = init.filefd;
 
-	pages[0].addr = imem->phys;
+	pages[0].addr = imem->dma_addr;
 	pages[0].size = imem->size;
 
 	args[3].ptr = (u64)(uintptr_t) pages;
@@ -1962,7 +1966,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	pages.addr = buf->phys;
+	pages.addr = buf->dma_addr;
 	pages.size = buf->size;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
@@ -1990,11 +1994,12 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
 		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+		err = qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
 			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
-					buf->phys, buf->size, err);
+			dev_err(fl->sctx->dev,
+				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
+				&buf->dma_addr, buf->size, err);
 			goto err_assign;
 		}
 	}
@@ -2108,7 +2113,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	pages.addr = map->phys;
+	pages.addr = map->dma_addr;
 	pages.size = map->len;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
-- 
2.53.0

