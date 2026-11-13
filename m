Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599593;
	b=uKVog0D2USLiTcw2L9ADYT7/WLiGguJIxKxqnWioyIBrotVLs7O1IhPkMAdD9IwhdJz4
	 g9xDn6TbDah9F44skWHaYFRxNRfy+5dljs/6t5okj3dIguFwdff4RtVHesCl13Ng5CG4Q
	 ZeEVZTBxz/wByp+e/fLFCFwwHrs8wcBBQEz7lYIpm4zFp8dJfkGdRY92yUNykg3CDDFlI
	 8MW55juOnW/r07gNPe68nVcu+OQih3UyGS2XLXhrSUVj1Ur0MQLsiOysyqJJrUdx6pRYa
	 FEQsfKMdq/AdE05FXTnknlj0WepXjrJHkEwFPMHn2nptheExhZViwtwC8UNbF9Msu5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9sGNd4OOoWLtHUW9I2AtmCF7qE7uTrad9opFoSIAFVg=;
	b=ylQcbDwhM85sxDZCjoPoQ4kgPMPGU/EufoFB59E4wAzAWr/cuLoUHx85HLOS8NQBYVCa
	 WhyLFx4XHHHNKrumNGqC2oRLhIPFlD0AiaARB2EbJJSvNLNH808rgdA3VQBfSAqNy8SJp
	 zeky2fBlnlZ3ZtwTJhKXt+JlZ+Lt7bYaW9cUv116jwZkY9gqW13y25SekPDNa4AyR3kYU
	 HAhBPUmrsTDl4nV3/wiz7dnJO9YUX/0EYFA5ImF48MhVZq/xUSm4zMAtxk0vHPhHXXz7c
	 abfQTzCWeGonRIASZAMn8cwdVTtnhDpOw3K/F1XTnhaRBEVvieHecvcSdINxgwgAGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN0VXL5N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9570606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN0VXL5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D96B1F000C6;
	Fri, 13 Nov 2026 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599593;
	bh=9sGNd4OOoWLtHUW9I2AtmCF7qE7uTrad9opFoSIAFVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dN0VXL5NRV+k4+qYNIm6u8XqvLLzWqyxC+ZbSY3+kszu4w1h2TDhHBKpTSZb/9uI9
	 KI1SY5IfdbWk23TV8FIm9TjPfLLabMeqt0Oyuyo0fjEHNW3xYbvI+4vwKHk028nBQF
	 fwplcIy9aBXtFT6f3iGQjzcH2fNRjdouSk+H9BWqytLGvVEa4sRnArFD6lcnKrNDMm
	 3sqTwRT+6arIDkihlDRjdPH5lmy07um6cY+sPTITlCmY6dfpTtSJBdtPcVFakFrk3R
	 8XHZDzTwYsKbIck4PWN7mdZ6OCyLOuQ7wDju3ttGx93lOj8gVRRTvV8jiC7hUCpFI8
	 wEyX92VdlbOmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] vhost-scsi: Allocate T10 PI structs only when enabled
Date: Fri, 13 Nov 2026 14:53:09 -0500
Message-ID: <20261113195222.2537874-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113195222.2537874-1-sashal@kernel.org>
References: <20261109201252-failed-6.6-01c3a5fa6d64@kernel.org>
 <20261113195222.2537874-1-sashal@kernel.org>
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
index 5fa9aab9279b6..f03170888a896 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1649,12 +1649,14 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
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

