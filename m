Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483D35975
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508261; cv=none; b=G/oFslbFgNtT7HGQwBhTxg5o6cm57qOLe/q5qnFuOUwGIr89Oqab5qSu86b9GlnMBTRiQHZlPGC5iWfcmLCFup9HPArdIfijXrCyK+19iYipO6atgp87V7rnt1+ZEyobDh56PesqFRIbphK23bay55wXVDoRMhIGDim20NaovIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508261; c=relaxed/simple;
	bh=fzq16ylNVIYvwPDDtJxB3DNljEbdrV7N7Dt8oHpwy0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5SU7rY8DTfkMUkL8rnU7m203tzp8bB2ideq7qfo9PCAVj036EbSmwLE6lamZDFt9Q4PoGMvD0sFK8qc3eMtauRFvfPqRRsZxi6/Lo8HjGytXDIJbJd3lU97CBTjtxSLmcMMYRWBdwSq7Lo01bVoqop8cDrFuQwwzUC8BkGPC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGdj3UZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGdj3UZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABC61F000E9;
	Sun, 23 Aug 2026 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508260;
	bh=pH4kgOARsHUt1tsyxn6lB2GoyJdoWES0A+D6ntrV1/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGdj3UZx6Fdd30tw+7PsHrNpwAdJpdrlqDho6KehCYzd3E477+8NU0lVS5zHy6G/+
	 liOW5aH9Yk5WZ4W2FWqkcjMAbizJDi78EGzJdd3n7RzocGeSqJcxG/YE/AQzLbV5a+
	 OTYjg1+XZFsDBCYCI61w0Ogb2T6iUnMbmY2bJP883TJw+7U00eJmXfE/MLjaaY7gFM
	 ATG8eckJGniizgrHydhS9rQdGGQzBye0mkj2SjAG36BoznLyuFITnpIw+oaP+oxsaW
	 Tz8CUHf25h4NANYFvLS7pBUXTINu5M8yLODrJILwgIeRmPCCB4CRAFeuBxoIksiZsT
	 2sHvg0JUMfQDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] s390/vfio_ccw: Cancel existing workqueues
Date: Sun, 23 Aug 2026 14:04:18 -0400
Message-ID: <20260823180418.1425395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082040-refried-cilantro-b696@gregkh>
References: <2026082040-refried-cilantro-b696@gregkh>
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
[ Inserted the two cancel_work_sync() calls before the memset/complete pair in 6.1's release_dev instead of upstream's destructor body, which doesn't exist here. ]
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

