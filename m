Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274041;
	b=QK/hzYy4blxjZzgkOhp4GsagfC9N18CjhRs9DZxWQ/xzehJcEZLpPNcA4DdAd4DzZS0/
	 xE0NEAp5broCv7TvN5AbZQbX4zQh6wJHO9AY898enpghyDcAnoASeMbmIFOFNnPX0KEQF
	 9eNuFp7zL4GYJXa4KSDdWPHFf7J/3k1cUPlcBK7UuLx4Lp/a1Qar9hcxj6s31wENjAvIp
	 PIcEt/v1IIbhFHR0v1WX6Hnr14kijmHppR1Lrcq9cKzRAPyTPMRrqSv/eaRvWDn8FJbj/
	 yFU4COc3QbS4PaPQ3eW3uPlQFiqBlN07XhiIOZZUhi+AuUDS/PpZjJTGH2t5xMHcsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PHcxV17WpDoJCTqRORTGJEiFiF1GQSTUcEmI+mhngwU=;
	b=zAt9o7OO6pLbRmCLJMgIjQRxUgxoLgxcyTZF5yOGKcq0Aksqj+FkCOoWreHP+Wzvni0Q
	 aL75him8cPBrFEiQgcIEPEt2tZX2KweQc82rC33dIJGxD5kC21GRQ/+0UvUQ03d7uDYmV
	 kBPNWEjjtaoLpA222GyMyosTeHzxpGEj2btIqnTVy9cfDqwkrBu53JWahT07Aj2Qk2BAu
	 lYuRdmQYeAXFIV4PoO4S1vJD43lCLMubfH/duHf7+ihVI2vnYecpa+ROnHjAxBNsf+Mo5
	 VNuie3VyAYdx5apNW8Vn2xOikbyAFSAAiFfeL3XJ6zV2t28JFoyiZgpHUij/rkawD4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPI6Fk24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPI6Fk24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F330B1F0089F;
	Tue, 10 Nov 2026 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274041;
	bh=PHcxV17WpDoJCTqRORTGJEiFiF1GQSTUcEmI+mhngwU=;
	h=From:To:Cc:Subject:Date;
	b=iPI6Fk24yRjQnyUUTEXyX/BT1Y7SyUi8tYv0vHjx2olxvRxEB31lPDXjAa77pOP8y
	 x590f2HchiQpNNSr/4VP+R/ZtRTr3gyI4PY9DW5YERA8XialQUYalYuD/0vjHEmrjf
	 AJDt5gQbda7Lygv0+HMh2fNdHC9nCm37UZbPsFnpq5yE3R2+Fb/1DLDOCDQ7KlOB8f
	 ToKg0WydGWAuFLD6n+B26xwtLRpflWwVCL9+XkFtobOjuNTGDiSTbfBon4vs/xbgge
	 R2hlwG79MS5TLMCbjdc2LONRD+EzRCUXQiH8qBjvTxcLmVeRaV0vaXIsJ4BbP+/g3r
	 eZfcs6jDjz19A==
From: Sasha Levin <sashal@kernel.org>
To: oss.patchbox@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/virtio: Reset device before deleting virtqueues on probe failure" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:19 -0500
Message-ID: <20261109202719-failed-5.10-1f8efac19a08@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1f8efac19a0870cdfdf8477e447e5a07ddce9623
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202719-failed-5.10-1f8efac19a08@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f8efac19a0870cdfdf8477e447e5a07ddce9623 Mon Sep 17 00:00:00 2001
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sun, 4 Oct 2026 14:21:10 -0400
Subject: [PATCH] iommu/virtio: Reset device before deleting virtqueues on
 probe failure

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
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12..fa72ae23b8afa 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1227,12 +1227,12 @@ static int viommu_probe(struct virtio_device *vdev)
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
 
 	vdev->priv = viommu;
 
@@ -1244,6 +1244,8 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_reset_vdev:
+	virtio_reset_device(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.53.0




