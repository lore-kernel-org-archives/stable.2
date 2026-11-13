Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540791;
	b=ILsKERGqhSnGPhNpIyvWPgPym84JP+iuWPcg7YLuemGso25tUGLpS5xaI/JmRhBf1uBx
	 FBbJkUTTXAno9D8Y7ce3J2gml7lnc4ieJoIlbu7h7rgIETkHjCodhSWS/e0vMEfyomo4t
	 J5x01Jx9qRzBKyIDud1DI6zBaySiJYWKX9NlynA9QGJbIO4KuSurBfvObAWEj08nECfxb
	 8IfEGDSHUh3Na7zH+zLc29QwC081K4sZ5VyEkEpj5qdBaekHjpQrrWyi4t+zwqIO5uS3m
	 VPbekL8aXJWnrk9GbvSHqiYaOdmtYDJLRyIVoECjHwUH+Y5VQRqRqyuxuG+sspvoTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1mTRRQugQZyOGvJQ0L3APpVvq+GYLVJgMkssK2kPNyc=;
	b=MOaMIeiOqQl6A5tuZa7E3qr7CX8l012N9u/x65U6agqfWr+AsMTBgBDo+U1nRTWHZ9gH
	 Bvj/qEqQt9F1Sd58BQPYUVY+JGIeBEbVmDmoPgr26x93JmAKS3XismFFMkeV4C302v5O2
	 U7HZ3GoxfV3RQ17wjc4Eu6TQSEmslrMJdqo9cQ5yr+mjbPAh3XrodOgWnX7epx5qeWN3U
	 PQS7hG3DAFpXvC00Mj7Q7gvw7CN0Z4ZfsSRRxAOefq8E9z/oJoFk29lxgweupfkYcHQUk
	 GKNQeUMrrwYGQe6ffc3MNfpwebF3VfYG+GPBCXefm3XsG8q7YoTWtoTHKx35Og268Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGeCRKdU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4F606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGeCRKdU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5049F1F000C4;
	Fri, 13 Nov 2026 03:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540790;
	bh=1mTRRQugQZyOGvJQ0L3APpVvq+GYLVJgMkssK2kPNyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGeCRKdUtfuyr2AJ70VsTRBhbSqWrJGl/Dtvl4ECKMQDAKzu0VNnnh9bEDYofNN1U
	 57xn9ZSR4NTDM4NMDTXxDe/wBd7aePomMynD7t+FbkDs6fG+CGSLJ05+s1MTIGN3ZK
	 DnlA9JwpBmzmVnFbJ4Duggf+86Upsvj9ZssgyYVTEOGTW9OcndFE51uzkNs++iyQPA
	 eEh+nf0MF6rtd3rqm5U+g98W61MzDvSce4HR7mFGn8hLSmxYEn1Yi2pMGNlFCFpGzH
	 e2DB/1Ye1MplE8dgq7FdBOLXNGO3Yp+ffR+fEFHvKgqWVX3BvgqUfOg1ebo0r8mDED
	 98LU+vO2QX0EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] iommu/virtio: Clean up bus_set_iommu()
Date: Thu, 12 Nov 2026 22:33:08 -0500
Message-ID: <20261113033251.1042335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202719-failed-5.10-1f8efac19a08@kernel.org>
References: <20261109202719-failed-5.10-1f8efac19a08@kernel.org>
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

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 19d3607c74bc0332f0ee3a2d54ead6e792c0dce9 ]

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/0ff6f9166081724510e6772e43d45b317cab8c58.1660572783.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 1f8efac19a08 ("iommu/virtio: Reset device before deleting virtqueues on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 81dea4caf561f..0aeed650f5366 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -7,7 +7,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/freezer.h>
@@ -17,7 +16,6 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
@@ -1070,26 +1068,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	iommu_device_register(&viommu->iommu);
 
-#ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-#endif
-#ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-#endif
-	if (platform_bus_type.iommu_ops != &viommu_ops) {
-		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
-		if (ret)
-			goto err_unregister;
-	}
-
 	vdev->priv = viommu;
 
 	dev_info(dev, "input address: %u bits\n",
@@ -1098,9 +1076,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
-err_unregister:
-	iommu_device_sysfs_remove(&viommu->iommu);
-	iommu_device_unregister(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.53.0

