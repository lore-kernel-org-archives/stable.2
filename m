Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353773;
	b=Hs5rC/QhMwtADRCfudvxxqroX7sglEwgp1UavKboNZfw/LgrzhdeNcMEpA3VEDi0KzOs
	 u5/ECNM/2yxaRebY+qtT3yJDgjqHO3Eps6E+e22krIW3I0vQn2XpSA9YBkTq3T1oFjrHO
	 5BTTGfpMs2Ki6EFI6XfnGLVSLVX8k7oq1XY/Bitu810uy4azF7AiUlglVP3ZERSZDytcC
	 rmIRB7F4y0IbZq3ES5JPrxtcZsBLOG+5EXuyKNuxYeCuXFtINxnOxYt0uUD/gKISBb3Mv
	 7nHMiqj9klRpOLI/jKW3m1RxBbjPuVVL2xLIeCoECjKl5/v5yG7KQP/iti1NZ825cnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aVz63R2oIRR2ex2cXWBzrN5nECOiDv0y7uUcM4z0mqw=;
	b=l79yuoNlqjBGM2wYA8LiFAH/wpQBFnQS7U8j/kYWDRrCLwqrYzx3i4WKFhMMXwinR8Q5
	 tKf2/EmbZRhNAq/9l18nj6HgGG3BJl7qp3GfTJSG0Gh3JeYhgrxSNl3dRp24/OoUHJDvW
	 +Um53hJEyQaWiRELazAMe7loneQJ84ADhgp/lytGVTB4EwUBEvVCpZ3BtKYljlo2mvczJ
	 olw+dzaUn94lCbuW+EwHaYuIhK4LEF8+HiH43TG4h+IgQcB40VtFznKoZOJr8XSAGud2j
	 RFWMXwbfCvZZpaF/68RMEuW8GwFbv+TkPQWIiGoALrETIvxbhbd6gWt6s5SBJDRoZ6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcsKMPVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E54606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcsKMPVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A281F0093C;
	Tue, 10 Nov 2026 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353772;
	bh=aVz63R2oIRR2ex2cXWBzrN5nECOiDv0y7uUcM4z0mqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZcsKMPVzaEzp7YYKOu/qilKbvd5H9gX7xrPunTiE6/mgsJ2UbU44wX9wBaSCVrrQ/
	 eIpWTcnkfMko/miiowwr2G942lrsbqQ0nyrU+93u2KBiLxiYeHIkQSgPyT8kxgRqwo
	 oJfOBN6uKlDEzVfb1EWC6rEaKx83xuW6N1uiTSMz5zegmpuNzmYitqFDAUoYBDKSBX
	 LhET8VGcGmT690ckvif30BPkWZvdqd1VDDhMcZp44YV8jrFK/BKeOg/RqsXyKWGvka
	 fPSFhNfDeTjb+rlsJTj0uWeoygY7xPqaXSWOAUMLsAZJHDcLfqgO4ylWHN2UV57MKh
	 wx7QoWrzdI0aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: atmel-isi: release unregistered video device on remove
Date: Tue, 10 Nov 2026 18:36:10 -0500
Message-ID: <20261110233349.140415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055955-failed-5.15-c0a6d78dad3a@kernel.org>
References: <20261107055955-failed-5.15-c0a6d78dad3a@kernel.org>
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
[ sashal: retained the older v4l2_async_notifier_*() calls in the int-returning remove callback ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index 095d80c4f59e7..1f6d28536f726 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1124,10 +1124,13 @@ static void isi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
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
@@ -1329,6 +1332,8 @@ static int atmel_isi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	v4l2_async_notifier_unregister(&isi->notifier);
 	v4l2_async_notifier_cleanup(&isi->notifier);
+	if (isi->vdev)
+		video_device_release(isi->vdev);
 	v4l2_device_unregister(&isi->v4l2_dev);
 
 	return 0;
-- 
2.53.0

