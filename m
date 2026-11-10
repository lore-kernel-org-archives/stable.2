Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273765;
	b=Gu+6AUpCBFwR+9AhgfAg9Q4MiXiQNf2DU9ZuUcRL2vZUSR4lc1+dLHPkhU5dbRBAbAEP
	 IehFhEF7YVF1FqUGW+esNP5A6LZZNz49h/unm0GpwDTFprT9Fp3M/RxXh5eB6ghpynwpD
	 nGuRo/GKZIZU4waB6A/90PYz2MMkxkM8h2Xg9ZVcppLuZbd9b5igUgIWEf+1BWkU4hCDf
	 /eYeDX9cQ2okl10piwuan+7aGychNYfcsBJ9j2jIry5RWDe2JsaQpuSDvsrNv6Oke89yO
	 kSRy+j90drdoDl/a0//1PhcoMLwuQ6GSQZIlP8ObibN2Mai/c/i/CwFJtTUnDucmi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IMsSLWp/3Z0LWg2HUa+If2cEVpIReCYToHdTtELS8E8=;
	b=MjrcVYygjAvlgdZyG4mRz7aINCYhtxa+xAIqAoh7rA8hzfKJtYdylVWriRSxiYVGs53m
	 x6qWD+cNtOqRiYwfYLu5baO6ySEpgp20dMZhrGnLESn0X+4npHwLFiDnvaSpGLA8+8ybL
	 wbWeNgVVhCzTKOquuwMe1rsYs/xNLbv51kQ7nmsrgRayrrpMukZuRziFK0xvHwIMzpHSp
	 yh7xG1255jygGM4dJBum4XS0Lvaae50xP0F+UOalXxfDU34zLy9Q1swPtks7BGv4aoW3A
	 st7GZi6hMqZVS1yGm6aQiI+nCYo1tL9nzWQ6+YqqOovZy8O8JBoxlby1UXnVxcFjd3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQQDdQ8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDE606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQQDdQ8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF401F0089F;
	Tue, 10 Nov 2026 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273764;
	bh=IMsSLWp/3Z0LWg2HUa+If2cEVpIReCYToHdTtELS8E8=;
	h=From:To:Cc:Subject:Date;
	b=DQQDdQ8yvm3MFtvyy32D+Tcak+PrEllLWoHMXt1DdSeQKTJL6pNkEz+Ey8ZYLnkb/
	 eFwPnnA1/L6lilsWlJfLtTlKqI6u/6cMWifh8FwKQE0UH0i+bPLIR/ZK51UTKdeAlZ
	 Cm8RktcGVWMH/kFqKH4Abri11lZ9P6FMw4cugWI5YBAGBh7hHokjSgCZEVAyXA5cSW
	 5PZaFAJNxGa0J43WdNg5s0wKYgt9qxxTN2UBelXQ18Z4cYpooGOGYgj5S6Ofr3250c
	 8D0ITanKL7+XCGrzHIFIUuKEZVPCwOuqXUb3lRnUeOYC2t+p4RdqyKuqMi5k8jOZqm
	 XUkEz2eOXw27Q==
From: Sasha Levin <sashal@kernel.org>
To: oss.patchbox@gmail.com,
	mst@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/virtio: Reset device before deleting virtqueues on probe failure" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:43 -0500
Message-ID: <20261109202243-failed-5.15-1f8efac19a08@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f8efac19a0870cdfdf8477e447e5a07ddce9623
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202243-failed-5.15-1f8efac19a08@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




