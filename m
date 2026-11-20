Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181039;
	b=t30WyaQO0SRGXwLI4badCLKCtesNjC4ACOALeqfeQoSVCCrfS3jxIOT1f7DKIG/d8QAz
	 DDIKG/M/Z4ssBHQxVM4FV2Tp4TbrbaFLcmLROq+Dqt2HImnNdiNRTec0dN25K+0L5I31+
	 mPTgxsVlPXt01KocW6+TIQryyWdYVtqDBYJ7xrjr0MNJzj5oNi+JbEidDIGPvb2Xm4vjg
	 1Y3CUHveKpY/0+C5txA5YtbtCyXbywHoUwxGNNKTlXTOguJ0gWrSvdpTvXQfW7NkvM6UD
	 vN0mc9RX9eQvqkkStgnliO6qirCViycqnXH1cIPK97Br8Jq0+GKfjgmLJdOZF66A3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181039;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=hTE6+QRY6OOVR29ouM37g0QVI5C2qsf7YT7gWZCXDrY=;
	b=vCTDp6vbHJ59voiZHg6NX/ukehxDrR0xoMb/aWxDOfxjJHpNY7P0kpwC/XzDRvQcat47
	 S6/sl/Fin3sTFRziQCu2tS7Bzxv/HlNaG0iNjG9FO6BPhcKBFqrxEWZvzGIGYpGEKPnlt
	 9uKkRW0pCCm+mhSwAUbJ2sYsUVZ8ramvXAV5Vp1Y1ANyksn+ZjzGoMPENtxAnNV/8E1nB
	 AQ7XVvI3VuU5YQd5Cb4PfK5Try9zzQxa7A6hmrYayoEzJEXnYa+LgAVxp0Cn+Si8UK92Y
	 I0a9hy1vPtF2kfKgdB1ZbLpLEc38wn+jBVZlk+wrMIpS/UTKil/4+PTKLC66olCGhcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=eqXzPxtD;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469B606A338;
	Fri, 20 Nov 2026 13:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6469B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=eqXzPxtD
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1795181025; bh=hTE6+QRY6OOVR29ouM37g0Q
	VI5C2qsf7YT7gWZCXDrY=; b=eqXzPxtDg4/jPq8jNmjvD/W2pcF6Sb0y2Y0DaUi1zm9aFy4pxS
	ZTHIW+FnZPsd+N0709o/wCblCQYkMV6F6JCaoLIed0bJG6y+OO5Ru95JWLiEcVhlWI6pIsu/55E
	JvS40GT5y1uOnpmh7gDDoo2hsYeT6G2Gxf1aPULzlnVc66lZF9hrNhz5TzhO8B2HbXtdH+IPD/l
	/4LnDD92Y60FUlIpdfFsiVo9DuXxtslbLz7lydMkUt8w1AN6iqlfMMsZ+GxejP3mxi930pA81l6
	3JWuxhs7fs+03glw2eFucM/79s8zr6jlipXpWX213vWyermTx0AsHj9w5DalyDUyH1Q==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Date: Fri, 20 Nov 2026 14:23:44 +0100
Subject: [PATCH v2] vdpa/mlx5: Bound the KLM count of the user MR
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-b4-mlx5-klm-v2-1-5b37ace483ff@dfb.sh>
X-B4-Tracking: v=1; b=H4sIAN9JAGsC/22OTRKCMAxGr8J0bRyC1IIr7+GwaCHYKj9OgwwOw
 91tcesii5cveckqmLwjFpdkFZ5mx24cAmSHRNRWD3cC1wQWWZqdEdMSTA59t0h4dj2ostCnUCh
 LEmHj5al1y267VT/mt3lQPUVFnDCaCYzXQ21jq9c8kY+BdTyN/rP/MWMU/D85IyCoQplcYi4Vl
 temNUe2otq27Qu1etpdzgAAAA==
X-Change-ID: 20261109-b4-mlx5-klm-798a398a159e
To: Dragos Tatulea <dtatulea@nvidia.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nikolai Kalinin <nikolai@kalinidze.me>, 
 Vladimir Petrzhikovskii <vladimir@dfb.sh>
X-Mailer: b4 0.15.2

create_user_mr() builds one indirect MKey that covers the whole vhost
IOTLB. It fills each gap between two mappings with null KLMs, one per
GiB, and never checks the total number of KLMs against the device
limit, MLX5_CAP_GEN(log_max_klm_list_size).

With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
forwards each map the guest makes to the vhost-vDPA device. If the
guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
more than 2^28 KLMs. create_indirect_key() computes the buffer size in
an int, which overflows: the driver allocates 336 bytes, and
fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
the end of the buffer.

For a huge gap the count is also wrong: the number of null KLMs of one
gap does not fit in the int that holds it, and rounding the gap up to
whole GiB wraps.

Refuse a map that needs more KLMs than the device supports, or more
than fit in a CREATE_MKEY command, before any key is created. A normal
guest is unaffected: memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.

Found by an LLM code review agent auditing vhost-vDPA backends. We have
no mlx5 hardware, so the fix is untested on it.

Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
Cc: stable@vger.kernel.org
Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
---
The guest kernel change used for the reachability check is available
on request.
---
Changes in v2:
- Shorten the changelog (Dragos).
- Use DIV_ROUND_UP_POW2() for the gap (Dragos).
- Use mlx5_vdpa_warn() without rate limiting (Dragos).
- Drop the kvzalloc() change and the comment on
  MLX5_VDPA_MAX_KLMS_INLEN (Dragos).
- Link to v1: https://patch.msgid.link/20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
 drivers/vdpa/mlx5/core/mr.c        | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 42f2f44b383c..1d84824ca429 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -32,7 +32,7 @@ struct mlx5_vdpa_mr {
 	/* list of direct MRs descendants of this indirect mr */
 	struct list_head head;
 	unsigned long num_directs;
-	unsigned long num_klms;
+	u64 num_klms;
 
 	struct vhost_iotlb *iotlb;
 
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index b0c5ff23d022..d902f7ee9ab6 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -206,6 +206,15 @@ static int klm_byte_size(int nklms)
 	return 16 * ALIGN(nklms, 4);
 }
 
+#define MLX5_VDPA_MAX_KLMS_INLEN \
+	ALIGN_DOWN((INT_MAX - MLX5_ST_SZ_BYTES(create_mkey_in)) / 16, 4)
+
+static u64 max_klms(struct mlx5_vdpa_dev *mvdev)
+{
+	return min_t(u64, BIT_ULL(MLX5_CAP_GEN(mvdev->mdev, log_max_klm_list_size)),
+		     MLX5_VDPA_MAX_KLMS_INLEN);
+}
+
 #define MLX5_VDPA_MTT_ALIGN 16
 
 static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
@@ -501,6 +510,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 {
 	struct mlx5_vdpa_direct_mr *dmr;
 	struct mlx5_vdpa_direct_mr *n;
+	u64 klm_limit = max_klms(mvdev);
 	struct vhost_iotlb_map *map;
 	u32 pperm = U16_MAX;
 	u64 last = U64_MAX;
@@ -508,7 +518,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 	u64 pe = U64_MAX;
 	u64 start = 0;
 	int err = 0;
-	int nnuls;
+	u64 nnuls;
 
 	INIT_LIST_HEAD(&mr->head);
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
@@ -522,8 +532,8 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 					/* We have a hole in the map. Check how
 					 * many null keys are required to fill it.
 					 */
-					nnuls = MLX5_DIV_ROUND_UP_POW2(map->start - pe,
-								       LOG_MAX_KLM_SIZE);
+					nnuls = DIV_ROUND_UP_POW2(map->start - pe,
+								  MAX_KLM_SIZE);
 					mr->num_klms += nnuls;
 				}
 				err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
@@ -539,6 +549,13 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_chain;
 
+	if (mr->num_klms > klm_limit) {
+		mlx5_vdpa_warn(mvdev, "map needs %llu KLMs, limit is %llu\n",
+			       mr->num_klms, klm_limit);
+		err = -E2BIG;
+		goto err_chain;
+	}
+
 	err = create_direct_keys(mvdev, mr);
 	if (err)
 		goto err_chain;

---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261109-b4-mlx5-klm-798a398a159e

Best regards,
--  
Vladimir Petrzhikovskii <vladimir@dfb.sh>

