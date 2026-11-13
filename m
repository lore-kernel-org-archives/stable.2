Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540791;
	b=vs1I2/tqlZQBTcwQz/8dveAgkARxfwVKx+oXT607Vq0brALLwYDpvmCxJ3VKBocQOI/m
	 +ysZJjDys1HCIwwCT0Lk8IGRri+/MN61/cMVM3EJok+/uQejqTh55xectY6ltgjSwaq0R
	 VSSxyoIEPyvdAUZc83xHIR63caoNekA3VZtf05iVySpLyyH3cYeorqn7LGgeTP2eXShXM
	 XdqdziAMFxB6+DYnMJdzq9bD9W/74q7bstc5QND4Dkq4Ij1t9CzrCb/ZRGXhSKv+SCmKk
	 gmb+mnX76mfpgHy//lqettBddktcsRVv4uSvLdTesAGZA/1ZkIepS2Fy1W7mGjDKYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X6mFCGH/HchjzhEDX32ABwVrQHEv6r3E9/UhmFzYce8=;
	b=gGMA09bqvi8NwYiwsqkwrNNUWhhVI13wjMY65ilCOOIWdeI12NY0PftGEkp/n0xhacJR
	 0/WCbNLuOB4rdBq0Jn+ztKQTnV/G7I7ntknDCp81ZHCm9ciEP4m+l+uSxK9fxnPy7224Y
	 a5Z+ct50cGOSn3NmLw1/24jKY6/eexTnCyMmHM5iC/rKiVf3+Be3JOaDhWg9jc4u4TynW
	 HGk3hE4aP+9ARp8S53yRx3KrHMmF/FvTyKee6PGRrQiHzAy3Zg0FLvH9DUBPfPM1JrTn2
	 XwTxX/z7/5WJnh1vJbLTAkGmBu7qXI9W4kPLuCTRGO9HChu15xZtYhg45/RhEH1ApOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUSk2KId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB010606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUSk2KId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247931F000C5;
	Fri, 13 Nov 2026 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540791;
	bh=X6mFCGH/HchjzhEDX32ABwVrQHEv6r3E9/UhmFzYce8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUSk2KIdmlxIk2+toE8LrINjCMdQDL9zDdhmJQJjrNSHRUFxNC3Qk2u8NY7aFGicP
	 5MSU0BU/EMwUBumHjvhiLeY/bjqoYso/Du5gXxwWJFqIwLSZ3CNOTef3z8NVmBl7PM
	 rXyjJubrmR5/yhKNZFjnpUk23CxxzLMEUjNTVe4mhu/OMOjzKIVjnWndeOOQehDetp
	 4R3os9o4zlIJkP2Iu73cpLUJqq0OClILWk+gubLgOizdObNop3qnqXuDLwShxbrS9D
	 sKeRJoDYQDMS1PFiejEpQitr0VSdOrhWnFEOb7uzKUhsV4D37ek1bde26RAnkdtbYV
	 NqoKDCWxerhhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuho Choi <oss.patchbox@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Thu, 12 Nov 2026 22:33:09 -0500
Message-ID: <20261113033251.1042335-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113033251.1042335-1-sashal@kernel.org>
References: <20261109202719-failed-5.10-1f8efac19a08@kernel.org>
 <20261113033251.1042335-1-sashal@kernel.org>
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
[ sashal: Replaced virtio_reset_device(vdev) with vdev->config->reset(vdev). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 0aeed650f5366..d015a23c90730 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1056,12 +1056,12 @@ static int viommu_probe(struct virtio_device *vdev)
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
 
 	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
@@ -1076,6 +1076,8 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_reset_vdev:
+	vdev->config->reset(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.53.0

