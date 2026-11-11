Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362874;
	b=eLLJHLaRllHtRG33g3cti66XXsR1BuLIZAfQqresViX9JQ5XwsMTddiGRPKIau/aGev2
	 xDfku95XkmPXBNmHfbyzHfTzHYuZduG3U6UkpdJTFnldJobrs0F4QxuXAlMeOVXjFDLww
	 KQez2cENchbqh9twodlZ2na48TLtY7sMKAr5BezZJpvjQd/WozTpnbWtKO1rKEae2F5kz
	 tIj92VQranlqM7jGHTnkJSW2m4NywXI+KNYYLMyifolj0FBGx63NN088G5uhLiiE/Dui3
	 RloW9Mwjar4Gp1dEWlXrVv3v+Tl2ctrvzQlegv9z3IzTx6PaXRKHT8u+/qYi8cs0Igw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U9rtDobw5t5GUQufpPD0iW8/th2A1zW2YtqrEzwAW8U=;
	b=NXSlQ9SXjn52DhLqVOYEWH8eDexIlSyimo9/GoBMtRmBZoPjuNYILsp8wQgBBBImBJhc
	 deeMoWCoxtzb6X+JfOzwBWqGOmvebAmoCQAvtvsjviXcfFejikqCJc7fAMc463qsVsUYh
	 MAMItn7NxZ1XiI0+S0AlEq+s9QUgXXAaN2TqpOEwERWxbjdBWDeN2kBEeA3cJS2HUiHU2
	 Mkdamr7FwqZQGkrEBV9/95oUkbTFtmSGxOuIu+iJ/625+VfatUe3zXENCau6JMObpgPw4
	 Gw4L0Yps00UR7PpyTExkkW88NG+0PWfKOHjUkaiPJKmxwPuXMXf4Z/Urc/mWpkwo6nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZiGjaTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZiGjaTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B15C1F00A00;
	Wed, 11 Nov 2026 02:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362874;
	bh=U9rtDobw5t5GUQufpPD0iW8/th2A1zW2YtqrEzwAW8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZiGjaToeoPMpMKXjBGZoI+26hiKA1vjVop3NNCH/rLzdBIJA+ftkt/PFUCkhEHkf
	 ZsFcXJZAcYWZX+xsSpsCYX3jD1iK/P2j+wdhHOFHAQOIryWp9xxBtFpsI1vSQNRsEg
	 ONPbHRyo1Amn4T5kqwkIuXPWK5NYYp9jAE4LHBgqnPxoGRUm4qCAF2Vn2RA9DGyoM7
	 gsVzHLZ2APoHrN550YG4e3FA8qjVKDGBx8PhebB3PB1gRQKuEUDLK1/UJ+RHupGyd0
	 +NZw/gY56hVLSsxrfXdi3aE4JZmxgLF0Kw/qBDeq4F7FAGMq00wJu/iKsAMTOjg9T7
	 y6PAzsDoq5oyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming
Date: Tue, 10 Nov 2026 21:07:50 -0500
Message-ID: <20261111020626.487609-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020626.487609-1-sashal@kernel.org>
References: <20261107055759-failed-5.15-d8983c47d4d9@kernel.org>
 <20261111020626.487609-1-sashal@kernel.org>
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

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 314c96e5203de1bac744e8536ef20b195f460674 ]

The AWB workqueue runs in a kernel thread and needs to be synchronized
w.r.t. the streaming status.
It is possible that streaming is stopped while the AWB workq is running.
In this case it is likely that the check for vb2_start_streaming_called is
done at one point in time, but the AWB computations are done later,
including a call to isc_update_profile, which requires streaming to be
started.
Thus , isc_update_profile will fail if during this operation sequence the
streaming was stopped.
To solve this issue, a mutex is added, that will serialize the awb work and
streaming stopping, with the mention that either streaming is stopped
completely including termination of the last frame is done, and after that
the AWB work can check stream status and stop; either first AWB work is
completed and after that the streaming can stop correctly.
The awb spin lock cannot be used since this spinlock is taken in the same
context and using it in the stop streaming will result in a recursion BUG.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: d8983c47d4d9 ("media: microchip-isc: do not touch WB registers when not streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 30 ++++++++++++++++---
 drivers/media/platform/atmel/atmel-isc.h      |  2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index eeaf91d80acd7..565719fda13c3 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -696,6 +696,7 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	struct isc_buffer *buf;
 	int ret;
 
+	mutex_lock(&isc->awb_mutex);
 	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 
 	isc->stop = true;
@@ -705,6 +706,8 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 		v4l2_err(&isc->v4l2_dev,
 			 "Timeout waiting for end of the capture\n");
 
+	mutex_unlock(&isc->awb_mutex);
+
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
@@ -1696,10 +1699,6 @@ static void isc_awb_work(struct work_struct *w)
 	u32 min, max;
 	int ret;
 
-	/* streaming is not active anymore */
-	if (isc->stop)
-		return;
-
 	if (ctrls->hist_stat != HIST_ENABLED)
 		return;
 
@@ -1750,7 +1749,24 @@ static void isc_awb_work(struct work_struct *w)
 	}
 	regmap_write(regmap, ISC_HIS_CFG + isc->offsets.his,
 		     hist_id | baysel | ISC_HIS_CFG_RAR);
+
+	/*
+	 * We have to make sure the streaming has not stopped meanwhile.
+	 * ISC requires a frame to clock the internal profile update.
+	 * To avoid issues, lock the sequence with a mutex
+	 */
+	mutex_lock(&isc->awb_mutex);
+
+	/* streaming is not active anymore */
+	if (isc->stop) {
+		mutex_unlock(&isc->awb_mutex);
+		return;
+	};
+
 	isc_update_profile(isc);
+
+	mutex_unlock(&isc->awb_mutex);
+
 	/* if awb has been disabled, we don't need to start another histogram */
 	if (ctrls->awb)
 		regmap_write(regmap, ISC_CTRLEN, ISC_CTRL_HISREQ);
@@ -1829,6 +1845,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 
 		isc_update_awb_ctrls(isc);
 
+		mutex_lock(&isc->awb_mutex);
 		if (vb2_is_streaming(&isc->vb2_vidq)) {
 			/*
 			 * If we are streaming, we can update profile to
@@ -1843,6 +1860,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 			 */
 			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 		}
+		mutex_unlock(&isc->awb_mutex);
 
 		/* if we have autowhitebalance on, start histogram procedure */
 		if (ctrls->awb == ISC_WB_AUTO &&
@@ -2024,6 +2042,7 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct isc_device *isc = container_of(notifier->v4l2_dev,
 					      struct isc_device, v4l2_dev);
+	mutex_destroy(&isc->awb_mutex);
 	cancel_work_sync(&isc->awb_work);
 	video_unregister_device(&isc->video_dev);
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
@@ -2133,6 +2152,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	isc->current_subdev = container_of(notifier,
 					   struct isc_subdev_entity, notifier);
 	mutex_init(&isc->lock);
+	mutex_init(&isc->awb_mutex);
+
 	init_completion(&isc->comp);
 
 	/* Initialize videobuf2 queue */
@@ -2201,6 +2222,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	return 0;
 
 isc_async_complete_err:
+	mutex_destroy(&isc->awb_mutex);
 	mutex_destroy(&isc->lock);
 	return ret;
 }
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index b0211100a5f23..0c3a452dafe33 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -207,6 +207,7 @@ struct isc_reg_offsets {
  *
  * @lock:		lock for serializing userspace file operations
  *			with ISC operations
+ * @awb_mutex:		serialize access to streaming status from awb work queue
  * @awb_lock:		lock for serializing awb work queue operations
  *			with DMA/buffer operations
  *
@@ -279,6 +280,7 @@ struct isc_device {
 	struct work_struct	awb_work;
 
 	struct mutex		lock;
+	struct mutex		awb_mutex;
 	spinlock_t		awb_lock;
 
 	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
-- 
2.53.0

