Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4573B38B8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565397; cv=none; b=ua+yWOJmIBnuBqz/Z8ceofNyHj7gEeB5HYHefv9z0TgvXbx4kIfRdFU7DHMsOnnY/1twPpHlM+IRqGox5S3TiDpHAKcHZK4TjTpLwwadZuy63n+/FQq+sEBobGV3tTRhBZREcu72xmiAg9g4aygkCEbFuUlgdpiB/FzICWbB66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565397; c=relaxed/simple;
	bh=vuKGzxgW/XBiSO4Qt2jEKZH7mvgxzmhtPc2dSKfHiPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlIt0GnNbjF7APAfrGvIHXhdFufMRGZfhoB3VdGfBmPHCWBskjAIeR1nGAD5GDmwPBF4pXkgJ4pBTKdP7tvqGn+kMtfjDzS8CyY+a+GZD+PzmUDWkgnhTkNXxXdsP4ZHCTkRu7V+fhnxvPawopK9/M+5YBDujfyO2vsKA7AVnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuAU071a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuAU071a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01251F000E9;
	Mon, 24 Aug 2026 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565396;
	bh=7sltKVPW4LmAnPoaKjJ9Po33K7kPpZQp6Y2CgY7rZeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuAU071aVRoVeYeK6pRUDo+06oXKxSbklpy8RlnxYCW8tJTPNOneF7VEDZvqLlhgg
	 YiYIsjKyukUBZ69hJG+hlT3HT6so4huWnu6qOh6NH/+bQCxcDnVz3nWyqMn0fAHeSP
	 OyaMxxy+yv62dQRp8QFMsV6GXZKA7YZmBStu+bBx1tpvxG96aK8A+/FKvTlQx664Lk
	 WlYZgv1L8Ug9YIv5gTgaFbewuVOw5PVytkSiotbUQVFAhTfFiGjELjkg7hTEOka/Mt
	 bT25SD5jRDTQjduz/7V1LpboqTiRtojrlna+4VF4Ebq/xezIfKgltuf4Ewk91aBsDN
	 aq8QtcTEuT9Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] s390/vfio_ccw: Cancel existing workqueues
Date: Mon, 24 Aug 2026 05:56:33 -0400
Message-ID: <20260824095633.4066853-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082041-cheek-expert-0782@gregkh>
References: <2026082041-cheek-expert-0782@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_drv.c | 7 +++++++
 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index e3c1060b6056c..2f080e7281f59 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -241,6 +241,13 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	vfio_ccw_sch_quiesce(sch);
 
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 2280f51dd679d..0d9ac3293fe32 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -204,6 +204,14 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
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

