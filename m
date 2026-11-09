Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252096;
	b=K0KLbccdYep0preLkKqzlmXRT7v/BfkbQDrbdIXd4qX7qBD8EXQyWWmDrjIl6tUfs8aI
	 /PkUOHEJ268vVb67lvbquWKOf6nkOp+i3BNZJvdo/j3Z0eyGG1dnCl6a2dW2p+cwzk9mk
	 NV4JPM+KSlmYiXLxhC77FQwG80wP3oIhHdsuysOn9j6Z+bpUkuK0Gzq1C/nAisckHok6Z
	 BWWX2ognnqRoMvibi2Itv1/ynmMQZDuecrQtOwVg8Yiuep4grJqHmMbp/ywMQEiSC+Gxa
	 4peGDDgHUwdOm7jm1Awf2tQgowjbRcnD5dMzkKD4Keh1J+tdQIwYqXLSg6dMMo5DFrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252096;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=nSaxNJoqEqkrIFzNH5TInpbrikbcFyPUBF2JjDBni20=;
	b=dlgOucLHLBuqIvDy/t/CIlApeZnDSDS7CusjYXFFY55VX98/0mwHKArXFMjwBKioSzW1
	 korxRpjCi2VEOPs8wXcBK3c2aml6minVqBh7wEsYjfH2hm7Dfvtn2dCDBAbxufyi5PTtf
	 NDgU29Boo3fySUXzhkW2rCMpS6obATIRJr6BvFYvusuQnwjsGrNgvyBSzPAxkvYykTWM6
	 NITkIyZ7+aGENXVq11DGQ+WZSSIp+t9l16RI9DWAk+EPNfWbwgTBq8TaazbjMcmNCRe3F
	 noYla8+h9ONEw7WTLLVOnkZ6sVrp2Tbq0/DP4njL/UsySuUAw+78xgKuMvU8Hr54SLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=eJVHz1+S;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3B606A31C;
	Mon,  9 Nov 2026 19:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=eJVHz1+S
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794252093; bh=nSaxNJoqEqkrIFzNH5TInpb
	rikbcFyPUBF2JjDBni20=; b=eJVHz1+Si42yXRSxY4QMFC80Ghx8xUDOOVK7/i1mcJoTsi0OiH
	pUdn2KJi1JsQWPP41C4FjtpKHK3/rP1CC5+PPBjnpA7PojBMfY4eEj9Zu7BnDOXcJ3ACBeRuxpC
	GGwUNru1lDIqcJm7CcIrLGuUb4iti+BSsIm1kRbIQtreqYfByIdpD/MP2yYMzj1/Gslh4CWmKTJ
	pWJXxF6LdT8ByPyt7anGYr57iC3x00c0RYgGLJBzzzJsLsrNkCblgeAU2hLvT8blrZWNGIWh9qa
	cnC5iJjHH6ZF8Ipu7jy+Wkwa8B5xOyI1QXU9T90vRUQ2prV+tpf5h1w4tdw2AoYZUGw==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Date: Mon, 09 Nov 2026 20:21:28 +0100
Subject: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
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
Message-Id: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>
X-B4-Tracking: v=1; b=H4sIADcd8moC/yWMwQ6CMBBEf4Xs2U0oilp/xXjY1lWqtJhdICSEf
 7fVwxzeZOatoCyBFS7VCsJz0DCkDGZXge8oPRnDPTM0dXM0prboDhj7pcV3H/Fkz7TPMa1lyI+
 P8CMsP9v19med3Iv9WBRl4UgZnVDyXaki6cgC2/YFd7vRtIgAAAA=
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

nnuls is an int, so a gap of 2^61 bytes or more is miscounted on every
architecture, and on 32-bit the unsigned long num_klms wraps. The gap
is rounded up to whole GiB as (size + 2^30 - 1) >> 30. For a gap
larger than 2^64 - 2^30, for example below a page mapped in the top
GiB, that addition wraps and the driver counts no null KLMs for the
gap, while fill_indir() still writes one for every GiB of it.

Count KLMs in u64 and round the gap up without the overflowing
addition. Before creating any direct key, return -E2BIG with a
rate-limited warning if the MR needs more KLMs than the device limit,
or more than fit in a CREATE_MKEY command whose length is an int.
Allocate the command with kvzalloc(), because a list within the device
limit can be too large for kzalloc(). A normal guest is unaffected:
memory at 0-3 GiB and 4-68 GiB needs 68 KLMs.

Found by an LLM code review agent auditing vhost-vDPA backends. We have
no mlx5 hardware, so the fix is untested on it; it builds with W=1 on
x86_64 and i386.

Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
Cc: stable@vger.kernel.org
Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
---
Dragos, one question on the limit: the patch takes
MLX5_CAP_GEN(log_max_klm_list_size) as the largest KLM list an indirect
CREATE_MKEY accepts, as mlx5_ib does for fast-reg lists. If firmware
applies a different limit to CREATE_MKEY, please say so and I will
change the bound.

The guest kernel change used for the reachability check is available
on request.
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
 drivers/vdpa/mlx5/core/mr.c        | 30 +++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

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
index b0c5ff23d022..03db8345c1bb 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -206,6 +206,16 @@ static int klm_byte_size(int nklms)
 	return 16 * ALIGN(nklms, 4);
 }
 
+/* Largest KLM count whose CREATE_MKEY input length still fits in an int. */
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
@@ -338,7 +348,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
 		return -EINVAL;
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + klm_byte_size(mr->num_klms);
-	in = kzalloc(inlen, GFP_KERNEL);
+	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
 
@@ -355,7 +365,7 @@ static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr
 	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, mr->num_klms);
 	fill_indir(mvdev, mr, in);
 	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
-	kfree(in);
+	kvfree(in);
 	return err;
 }
 
@@ -501,6 +511,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 {
 	struct mlx5_vdpa_direct_mr *dmr;
 	struct mlx5_vdpa_direct_mr *n;
+	u64 klm_limit = max_klms(mvdev);
 	struct vhost_iotlb_map *map;
 	u32 pperm = U16_MAX;
 	u64 last = U64_MAX;
@@ -508,7 +519,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 	u64 pe = U64_MAX;
 	u64 start = 0;
 	int err = 0;
-	int nnuls;
+	u64 nnuls;
 
 	INIT_LIST_HEAD(&mr->head);
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
@@ -521,9 +532,10 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 				if (pe < map->start) {
 					/* We have a hole in the map. Check how
 					 * many null keys are required to fill it.
+					 * The hole can be nearly 2^64 bytes, so
+					 * round up without adding to its size.
 					 */
-					nnuls = MLX5_DIV_ROUND_UP_POW2(map->start - pe,
-								       LOG_MAX_KLM_SIZE);
+					nnuls = ((map->start - pe - 1) >> LOG_MAX_KLM_SIZE) + 1;
 					mr->num_klms += nnuls;
 				}
 				err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
@@ -539,6 +551,14 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_chain;
 
+	if (mr->num_klms > klm_limit) {
+		dev_warn_ratelimited(mvdev->mdev->device,
+				     "map needs %llu KLMs, limit is %llu\n",
+				     mr->num_klms, klm_limit);
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

