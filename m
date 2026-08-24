Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BF3F86E7
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565394; cv=none; b=c7fKR05DAe9GFFutfmAMoAVk6WP3jrDFmDbTfPC6DGytgJngyOl9n8rbGlGNWcuwRcyTthOSYIASyx6zwYgDA8rqXWlnQ62zeqx/SwNF4CiJIg6llB6SG6HnQhwDOx0QFWZXXKP1yHLLvBBCnCj8RPxkLLTP/HIPXzlnmJz6PPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565394; c=relaxed/simple;
	bh=4ktEB+rXoog9yaK/B83lOcTvUPBxd7ZRKsiRn60Kexw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfHDH7WG+cDMZeyGmrtt4pxV90xwKK+PFzC50VAf3vJIL6kEi9Ee151Jn841kBCxjOJq023bjjHar5jd1zEwALJ4eYdf2wKXUsEDJC5fH9qX533xJEPzS5PtzPci2XLJxDYutL6aLTR9UfvvL3EPHNq9rz7KiSaLpIMIOaUkAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7VsfKlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7VsfKlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655621F000E9;
	Mon, 24 Aug 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565393;
	bh=WglSSLANo0cUgG9qmPoUK6x1ODWeNg5XHEwctPqnp9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7VsfKlbwgsnv2YwhAEClsMCl+R54aipQ7K2xP/O+Hbj08yWDDdiOeLXPNbcjKQyi
	 qSn27HQ03chpi+WHdBwo269Fuzy/k89eNio4muvaH2YIkQRkL2+6zE6F4WSWCQ58QS
	 8MH+H8No/SPrr9BIOcEVoiNMJXGpx8DU0TZKVlCaAE6Iw78VhJFuB59czR9eey349f
	 gpV5pQ8plLIpXV9aT7+TGOC6KxE5HJOSyVft4XYY9Lb2ztmrLqHCq3mznGjExfzQk0
	 Bjgk8dJ5SluUKsLsZ4x2mc48SYOn6UPYrf4e7M4bwiT/FIYh3rVBvSA6cLcHDHaJfE
	 YNhMfmx8eVmjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] s390/vfio_ccw: Cancel existing workqueues
Date: Mon, 24 Aug 2026 05:56:27 -0400
Message-ID: <20260824095630.4066777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082011-january-overcook-6d98@gregkh>
References: <2026082011-january-overcook-6d98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 79c60b2c61105368dcc8444eb45847e21734f7c4 ]

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Stable-dep-of: 16b0798024c0 ("s390/vfio_ccw: Implement a crw lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_ops.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5af74d3142492..c73f675ae29a1 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -86,6 +86,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	struct vfio_ccw_private *private =
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	/*
 	 * We cannot free vfio_ccw_private here because it includes
 	 * parent info which must be free'ed by css driver.
@@ -162,6 +169,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
 
-- 
2.53.0

