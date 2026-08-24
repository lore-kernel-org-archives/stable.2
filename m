Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3A8632B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530342; cv=none; b=M8nuoOnSbbR55alpG18SdHzFcqNHKcKA/AV+28ZCWjISnikKjOsqYKNEYfnlsd6EzXMO22BMLRytM6pkcWVKi2kjiw/KrOT4Pork5s05RnyrJAotqASljyhoKZXPwY9myBXui6J/hrG0JcTdCu8N5kk8fNGzpBxwn9RxIGRCjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530342; c=relaxed/simple;
	bh=9ScvAJ7WCU5L0bxlTLKPLkcEbhVh3a/Wc0KNfTzrGDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoKU58hOG0OxQVvjO9RQITB2Fy9Iwsp+q/meephnforj8Fyui0BMi4SrKrMOV282m3IJhzhmkvX/+lB2G82I9qM/HjFMiRC/gu41XzdN2f6Prd8ApLBqBbgmTX3nodyQw+fgdrb0CtZqXqAL9mpaMHva1+fuB6RWtOIml6qbaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdFHeqWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdFHeqWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69E1F000E9;
	Mon, 24 Aug 2026 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530340;
	bh=ID5G77nnDjzw69+a2rbNSAzK9TLQ32+DTQgBG3Bvddc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdFHeqWYkMJ4N4XxFdDyMIvvWtceqqU7tZcQmFswUE98JB3kkdvxwQza9Dvlmcbx1
	 xDAZig+xKaiFrDC15Pyrvk82uKR0YVj5+QoLiLSNp5BaW0bBqu3xc1ycHOZnW/FVc/
	 7j5+QocNELfZHQ1oHF0J8P5DturQLfGKrnZfed2AEEILjiIamWSFtdBzT0/VDOqWF/
	 0W0srvbPtstK6nGq35Ptwn+W5qIOpci1MAgrdGf7wv6QMQeaa/YgDy+joSZVngkN5/
	 RpCrsQgDzW//QiJI8HKeYE6HNDS/tOd6Omyi336r6dRqCbhIzfVSpF4RDDzPtCI0FQ
	 nXbHn8ljyrRhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] s390/vfio_ccw: Cancel existing workqueues
Date: Sun, 23 Aug 2026 20:12:18 -0400
Message-ID: <20260824001218.2687907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082041-rifling-motor-b6eb@gregkh>
References: <2026082041-rifling-motor-b6eb@gregkh>
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
[ dropped the `vfio_ccw_mdev_release_dev()` hunk since 5.15 lacks the embedded `vfio_device` release callback, keeping only the `close_device()` drain ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 7f540ad0b568b..f3958e31dad87 100644
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

