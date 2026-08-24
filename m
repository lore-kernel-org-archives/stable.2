Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB0437861
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580359; cv=none; b=TbwwgEkYuEQ4zqPBWbf+mMgSuR+n4qNhVARZhMGDn4RAkaGRe7ee6svIlyC6NIF1nheG+0NoPEAyQiW7mbMz8r2iE/HsotuHFArOXs4v9cZ5SusgqzXsuUt5TzBok0tNePmBs5DSquSDYFJjeWw73/3eM4ofQeH4f1eD9YhvWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580359; c=relaxed/simple;
	bh=xOy/O84Vhwn1Km9dQwfsyrWxd4bdC3jdgMgs+Rk5KJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4wPWF1bD57J0RycF3seDOHTs8uZQVJGzvjhwInp7ZiEjysfSFh5E6E86aVsYLiiN5zB802+Kum9o/nf2HMS8oXrKIe9gATtr/r2upaiDFFdkP0OpArDamekDADc1eJgwDemGRujHoKcZ2yXij7nW1giTwzPnbEk4GQBCPLWRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXovBFNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXovBFNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E61F00A3A;
	Mon, 24 Aug 2026 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580358;
	bh=EzB+DvfBHhCxUIvomvaLXcfygXW7X7Z5XGD7DtR+U6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXovBFNd3YG2G0Fgim9Lw/dS7qzItszhOPvGuAde64lxC0Xys1Iucr88wgyhtlvDg
	 ytJptnMpauKvk2dSr9KEHpIXY86cwxOpYbuv/10/rJsfN1NTTca8p+NgsnopbAVHM1
	 cI6S1HT62TZUic+dmppuBYTer4l/AvLzm5fs/nA+frZVLDW37Z4bF3+vqtO5vPPOsI
	 xAQ7SRiXBk/WhNmc6+x5gECiyYBtMmyQ2tOTrpGzQ7gy9MNqdQ1cVv0bEVqidK92ox
	 ySrkDxbK2qxCe5t+TJS+hThrViFX6LCDODtJpx6qAiiEDGsmqzYocgb016LYCUkbRX
	 ma3eAv1FMRlsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] s390/vfio_ccw: Cancel existing workqueues
Date: Mon, 24 Aug 2026 10:05:53 -0400
Message-ID: <20260824140555.3097579-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824140555.3097579-1-sashal@kernel.org>
References: <2026082011-underarm-plywood-1b0f@gregkh>
 <20260824140555.3097579-1-sashal@kernel.org>
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
 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index b76b0521b456b..4c035a8f9691a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -207,6 +207,14 @@ static void vfio_ccw_mdev_close_device(struct mdev_device *mdev)
 	}
 
 	cp_free(&private->cp);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
-- 
2.53.0

