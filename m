Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353983;
	b=4C42Nei3zRLMaX3pyZxbBH8ifegaabmJcqdCOFIkxlq5Yns+Iu+D47Zj6cMi0cYDWpWQ
	 bFmKhkjHrdU5hsilTqU0ydhp6gEGfYUXOjCa1ewqS4LFsI0jTzatTlPgBzjpK0H1zZcxB
	 GqhU24wKOFn4XBLSMhV2B3skfGFa8g6cFsBvpeQDkr9plRdlNFdO+F5kADZaMJKwdD25Z
	 uR8dyTgB+SSi++HiYRNW+UlBZ3NE6fGAzhhP7ZYFbp98ygXlEq2igFPwShdtD8FEyWelR
	 LvY/zLEEJjCJ4adeDrY0//7CyvYi/6gGCPC1TXb9rTVdMEaOv8PPFNA+rwp6iX7KL/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QGGMpBCsoEcZzTz7lp62vNld0psDPiE7D0Ql/EgV7Gc=;
	b=EwVvXc5kDOjV/+DfisX2/w4jYFopqy5LyBO0QyfHtnsBK67H0nCS3Ib5yOxTIvDHz34y
	 NHVZJ5tEKHp8mM4wDuSR2M1mXuicDrxrjKHUB4kB4Jv+v+stdsYKjibXs10wq0k2OasLq
	 9ms+6N0QlKT9ZbvA79Blv87qcCGKcxTh+FORNW4JVl+r+Ojok+q+DpIn9psTUgCkrCMdp
	 I4Yqb0IOfRrj/equEI4lCE7Us1kOvfIo9QYjSOtn1spJCQPCscKMbnXR/g7nLSweCAIxJ
	 fOKADg1Y2UcGyERsbYST9ItVhtToLdGySmwuWCc6h7fgcffOuPFINckt24Zn0M2WqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgW6eOfU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589A606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgW6eOfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6C21F0093C;
	Tue, 10 Nov 2026 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353982;
	bh=QGGMpBCsoEcZzTz7lp62vNld0psDPiE7D0Ql/EgV7Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgW6eOfUfC7yFz977SKb8ULcSPmnb1ncQwaLrFeenW2VsC+KWk069YyOIYV63KlgT
	 gZPbGJE88ncMX9NOjnV+q32ooiEDZ2Wvml5glPoConP3dTh9UQv8lW5uAdqzYgNjde
	 fgXukOXf+I+REtzaL6UmHmCy7d8X8cdb/AdfxpXycuvqe8zbNVKrLHe6KqSDdHcylQ
	 Rsdu2blxDI5Rqo5Wq864//46tQZVRHPtcf2swv9StzYEBtnJLjW6U/lfpb31Xz4tEZ
	 Nxx9YcYEMVoNfbQmPDL9fF8rAx7RK74GCEUcczIkxolLX1LZ539NDYzQQ7KDvnQl8V
	 JuUupiH1PKV+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: atmel-isi: release unregistered video device on remove
Date: Tue, 10 Nov 2026 18:39:40 -0500
Message-ID: <20261110233922.175379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061646-failed-5.10-c0a6d78dad3a@kernel.org>
References: <20261107061646-failed-5.10-c0a6d78dad3a@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit c0a6d78dad3af1def80f04df82bfd70456ec406c ]

atmel_isi_probe() allocates the video device before registering the
V4L2 async notifier. The video device is registered later from the
notifier complete callback once the remote subdevice has been bound.

The remove path relies on the notifier unbind callback to unregister
the video device. However, if the remote subdevice is never bound, or
the complete callback fails before video_register_device() succeeds,
the video device remains unregistered. In that case the unbind path
does not release the object allocated by video_device_alloc(), and the
remove path leaks it.

Only unregister the video device from the unbind callback when it has
actually been registered, and clear the driver pointer afterwards.
After unregistering and cleaning up the notifier, release the video
device directly if the pointer is still present. This covers devices
that were allocated but never registered while avoiding a second
release of successfully registered devices.

This issue was found by manual code inspection.

Fixes: d12c9088c0b2a ("[media] atmel-isi: remove dependency of the soc-camera framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[ sashal: adjusted context for the int-returning atmel_isi_remove() callback using older V4L2 async notifier calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index d74aa73f26bea..925dcb30818fb 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1111,10 +1111,13 @@ static void isi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct atmel_isi *isi = notifier_to_isi(notifier);
 
+	if (!video_is_registered(isi->vdev))
+		return;
+
 	dev_dbg(isi->dev, "Removing %s\n", video_device_node_name(isi->vdev));
 
-	/* Checks internally if vdev have been init or not */
 	video_unregister_device(isi->vdev);
+	isi->vdev = NULL;
 }
 
 static int isi_graph_notify_bound(struct v4l2_async_notifier *notifier,
@@ -1335,6 +1338,8 @@ static int atmel_isi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	v4l2_async_notifier_unregister(&isi->notifier);
 	v4l2_async_notifier_cleanup(&isi->notifier);
+	if (isi->vdev)
+		video_device_release(isi->vdev);
 	v4l2_device_unregister(&isi->v4l2_dev);
 
 	return 0;
-- 
2.53.0

