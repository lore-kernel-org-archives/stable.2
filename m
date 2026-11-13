Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599196;
	b=ZHXqvaySEGbkfXQoiUfy1KXrBxE5nYMsoTf/3JSNrncsDSV/9aJwRDn+WPVBzzM+pQNr
	 WytA/LcnqECNcrcsidBoNGmvAglk7YThA+YhhLJfg1uDM2aTkUM0hbjO6zByLnpBRZA07
	 fn9NsN2AfmfV9zBgyPRfv6Fe5iKhkpXeCPMUyV37DZCXRS/2uIcicNcto9z4/HWJVywNo
	 sG5scobILznopLY5xBlf8p0QapJyY49aGR0kizIM+2hKI1qYjkR+Zzjz8mlRneGCqQL3r
	 WMWr7N7ZOhfPGtt1i5hSnGxIYuc5B6Es9tnyWKWdz54fKTGqTQAQPtMP68MrQwVvEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fa/biwkip4Dzb9mN8SQde8Cg1XghGInW3LNwWaBGi8I=;
	b=AUIBfIKpnQffpo4Tjex36YUko9BeaMYt36fh3KhHOPqBp4bd1MXeyJHF9ZuEmVj2Cr4Q
	 nBL/8WWU/5VjEehqs0mANhJqg8PVuO0Imc1ygXOsCw/uvnfzWVtl+AuVYLA2Zafbp0mDF
	 z/rW04UemEhbAzztM3JbLdgntCBAVN0YSyP01d6ecPni4lOQTqyOJVgKaokanG4MeXtnF
	 DlF5Ekx6hlVXriSA3uE85aUyLdK/prcKE/pAaIxlcsO2nCo/r43KCBL7v462TGdxlF7hZ
	 DKXC0wghDiNQNs1nFyBREdLMAUogv9QwQnj7Ne+cTmf8PaKNefgiVKpS9Xyf0aokYQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjfzvOB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE4606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjfzvOB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E111F000C6;
	Fri, 13 Nov 2026 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599196;
	bh=Fa/biwkip4Dzb9mN8SQde8Cg1XghGInW3LNwWaBGi8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IjfzvOB0N5C2wkeSFjC4eb8Nin7rcZKANNd6xpJiSjqmc8UO5ziGGZR9fX3RJQp/A
	 I/s03ixpzyNjwUIudZbpaeT29xzO9/y5aaKfQmSmG8GTpGVjB6wlb5RDxq2yoHzuWT
	 I00Ga/4b64m4zXTbzpETOIH9M6EOabxqxpHrZDwQtvTlgw3A+f0ZVyYTSKHkUQ2hrn
	 5aRGg4KIT0Hz8fpEFbdxyTvmmQD8Z7Jk2JTKed79SbKMkql7QZ+t6MS9/9e6rj+Qwd
	 GvsKlWqpFlpTyw3SEB1ZbxPD896xxwvwtpzhd1kR2VfpUXQxnD0srcL7KLQgB5du6X
	 9+nrp/ktymzbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] vhost-scsi: Allocate T10 PI structs only when enabled
Date: Fri, 13 Nov 2026 14:46:32 -0500
Message-ID: <20261113194602.2463861-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113194602.2463861-1-sashal@kernel.org>
References: <20261109200826-failed-6.12-01c3a5fa6d64@kernel.org>
 <20261113194602.2463861-1-sashal@kernel.org>
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

[ Upstream commit bf2d650391be508dd8b5e188b65ed32300cf3489 ]

T10 PI is not a widely used feature. This has us only allocate the
structs for it if the feature has been enabled. For a common small setup
where you have 1 virtqueue and 128 commands per queue, this saves:

8MB = 32 bytes per sg * 2048 entries * 128 commands

per vhost-scsi device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20241203191705.19431-3-michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Stable-dep-of: 01c3a5fa6d64 ("vhost-scsi: zero misaligned I/O bounce pages")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 725166d4cc79f..4e1b5184cf36b 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1712,12 +1712,14 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 			goto out;
 		}
 
-		tv_cmd->tvc_prot_sgl = kcalloc(VHOST_SCSI_PREALLOC_PROT_SGLS,
-					       sizeof(struct scatterlist),
-					       GFP_KERNEL);
-		if (!tv_cmd->tvc_prot_sgl) {
-			pr_err("Unable to allocate tv_cmd->tvc_prot_sgl\n");
-			goto out;
+		if (vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI)) {
+			tv_cmd->tvc_prot_sgl = kcalloc(VHOST_SCSI_PREALLOC_PROT_SGLS,
+						sizeof(struct scatterlist),
+						GFP_KERNEL);
+			if (!tv_cmd->tvc_prot_sgl) {
+				pr_err("Unable to allocate tv_cmd->tvc_prot_sgl\n");
+				goto out;
+			}
 		}
 	}
 	return 0;
-- 
2.53.0

