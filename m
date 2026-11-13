Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539853;
	b=l4SJQ98mSVq/afc0O/5udlXEcWalQb0t6qmm/bwb2YPqOCD6Y5k+7/hadzoy0qal7WXY
	 Hv9d4BqsdIup9M5huXsB/ulYFwHvZcLV3XAzk+yj9c/i13nULPNAFgI8xe8raKVJsxV9E
	 kZ2Z5xExvPbUn0QcWaSa/P2KDaAZOu1vuM36Ow3fNO0Votbw0FbBUVEY0MvE5qdpHsVx0
	 KbNxCKgPyJG/VC8UlpC/8j67vgoGKPJQaXMs9UOdBFD9bwPffEPNec1ETpaVfoj9WSBkY
	 yE3N9k40WjAvyfxnjFY1Kwzi6CN1+wtzpLXv8hIunEcNiwoULe7i5XQPskTxE7a/BXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=su6QkInDduO7gTs4FbYCOCjXWdimumwsA10hLvIlDiU=;
	b=RUqWQNl8Huhfc3WtPu2x2il8hzEuCox32/7jH3WiiMzN02fM62ippp6TX0egVNX6n9jy
	 FSusb0AxEPFc57/+g6ckZ4vvJ6dS8XZm1HQAzl9A0X8OxKs8JaHR1OHKDSf2IE7FzI+M+
	 Za1SSgGMFaLNlmDeuFzAh0DlkXbShs7fiqB0/7DnOooSUstng82G42WP4HhMHYKBDdrmA
	 VM8UlRa2CaxpJFe14ZM+C4Qhghp35vbDfxvEL4GIoCYXjP3/FOBTZGbGjL9o1O8DfkrHN
	 UxvWVeYPjIQLB7+prGOr5oUPDXUSDbQ3GM0nrmWSSI+TsO2a5DjZlRA23Yc89c3knVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEaavGeE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24550606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEaavGeE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393931F000C4;
	Fri, 13 Nov 2026 03:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539852;
	bh=su6QkInDduO7gTs4FbYCOCjXWdimumwsA10hLvIlDiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEaavGeEqit1so94kAFHjENADSujE+ryp8KQfDR/sPYnQLTpY3d/pDehQA1XX/8Kw
	 ajrkH++opmlt/Ovf03djk6KFtvHSG+TWsoq4kh7Q8UJm7N/IAuqKxee32yMd1likta
	 LmRWGYacxRGie+cz/BgzxbQHRNLCdQ5ZQukzBMk8F7+6GkjEiKKi8ISSP/GUCYeuw0
	 HwBo9ZjFG4wdx3TXqCw7ghdpYQt+tPr8ZpbRywSxftD/vkMsVIac30LIMm8UjhIzqs
	 aYnOsVdz2YXgI6nPX//uiZgzEAfl7XsyeGHi38hTptlDOpcBqQGqYxpbiPEbgyuaMU
	 nQ5MAOgFVsOVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuho Choi <oss.patchbox@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Thu, 12 Nov 2026 22:17:30 -0500
Message-ID: <20261113031716.982432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202243-failed-5.15-1f8efac19a08@kernel.org>
References: <20261109202243-failed-5.15-1f8efac19a08@kernel.org>
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

From: Yuho Choi <oss.patchbox@gmail.com>

[ Upstream commit 1f8efac19a0870cdfdf8477e447e5a07ddce9623 ]

viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs.  viommu_fill_evtq()
hands the device a set of device-writable buffers through
virtqueue_add_inbuf(), so from that point on the device may write into
them and into the rings.

If either step fails, the error path deletes the virtqueues without
resetting the device first.  The event buffers are allocated with
devm_kmalloc_array() and are released as probe unwinds, so the device can
go on writing to memory that has been freed.

Reset the device before deleting the virtqueues, the way viommu_remove()
already does.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261004182218.177343-1-oss.patchbox@gmail.com>
[ sashal: replaced virtio_reset_device() with vdev->config->reset(vdev) after the existing err_unregister cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80930ce04a168..f60a9d48f952b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1061,12 +1061,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	/* Populate the event queue with buffers */
 	ret = viommu_fill_evtq(viommu);
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
 				     virtio_bus_name(vdev));
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
 
@@ -1101,6 +1101,8 @@ static int viommu_probe(struct virtio_device *vdev)
 err_unregister:
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+err_reset_vdev:
+	vdev->config->reset(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.53.0

