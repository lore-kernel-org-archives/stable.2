Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1A292B54;
	Fri, 17 Jul 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296038; cv=none; b=DyWLfd+ljnAaCDAlcYZxIKX0R9xiYYYOfGiUTAC0HztRg3hOjqc9MAowhHpEmWd8yGopeU6ZRMhvnaGsbqGlMhYBVIFuFqqnljqDYXAQIu2lZk6woujGt0kSTl3sUGKhM68HH6F7nO/AfTLCD8wUCUiTtjXvtvxpCMS890Eo9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296038; c=relaxed/simple;
	bh=kTYRnfjDhY8tuvsLXMhcUfYLaAjs4BzmAwCL+frgLYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+p5IZ2GbGADJ+7jDfDZckYtbz7j28SLssQAcXThidBs40HXCc0XeVZRwz2cJ0hJ4sRcaiU9aGnWoEoxV/IzOu9TjToNTUkpb8mZ8j50BOq7aJRx0yLubeR0bACZZwnVU0pGGxpUpD4dB/8aAg8IwY3rRAetmqdIc61g6zzEobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMF/KSp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMF/KSp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A31F00A3A;
	Fri, 17 Jul 2026 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296037;
	bh=XPCGV5xtkbJdOl7D2OggvGt9h+BVrZS/noJ6rOCEFUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMF/KSp6YFZzBDGd3TJyq5bOuQWhOFB78wQzrArMizvuOBTxQv7nPAfug5UPxHsfw
	 HzFpSRPTCKkIpHWi7JNbXy/g9CDc8HHO0rM6c1PJuYuJMI5h7GfTUn9AbPO3evMXYn
	 CuDpaZ+irA+5RO30lneoB1Hw0/2y0YliFseBAw+ktjfgbnguXujfhUuvNmaBlWtui6
	 ge3DEeYbljj2z1188jScvsbCoIOY2SuW4lIS+gBhhyLHKL7cvKZDSO9y6wG3TdA+aS
	 R9UtnL4yjRgJD3tOzcudFa/8I6mIDp3v6JhKmlIpDf9Xyf2/TkZ7ipg1jx8TABx97m
	 a+beZpP8ZZDxQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Revert "media: v4l2-dev: fix error handling in __video_register_device()"
Date: Fri, 17 Jul 2026 15:42:45 +0200
Message-ID: <0b9987559a8f448af82ea22ba281c0bc0f462bd3.1784295766.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784295766.git.hverkuil+cisco@kernel.org>
References: <cover.1784295766.git.hverkuil+cisco@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2a934fdb01db6458288fc9386d3d8ceba6dd551a.

The intentions of that patch were good, but it doesn't work.

The idea is that if device_register fails, you have to do a put_device
to let the ref counter release resources.

However, the V4L2 API says that if video_register_device() fails, then
you have to call video_device_release(), which kfree()s the video_device
struct.

But the put_device() will already have freed the struct, so you end
up in a double-free scenario.

There is not really a good way of fixing this without breaking
video_register_device() into two parts, one that initializes everything,
and one that does the actual device_register, and then converting all
V4L2 drivers to this new model.

That is a massive job, and it is very unlikely that device_register
will fail.

So rather than ending up in a double-free scenario, just revert this
patch, and in that case we'll have a small memory leak. Which is a lot
more robust.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Fixes: 2a934fdb01db ("media: v4l2-dev: fix error handling in __video_register_device()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-media/20260520090624.1071139-1-lgs201920130244@gmail.com/
Link: https://lore.kernel.org/all/2026042058-charm-storable-4ad8@gregkh/
---
 drivers/media/v4l2-core/v4l2-dev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 5516b2bbb08f..d750bf10febe 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1071,25 +1071,25 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.class = &video_class;
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
-	vdev->dev.release = v4l2_device_release;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
-
-	/* Increase v4l2_device refcount */
-	v4l2_device_get(vdev->v4l2_dev);
-
 	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
 		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
-		put_device(&vdev->dev);
-		return ret;
+		goto cleanup;
 	}
+	/* Register the release callback that will be called when the last
+	   reference to the device goes away. */
+	vdev->dev.release = v4l2_device_release;
 
 	if (nr != -1 && nr != vdev->num && warn_if_nr_in_use)
 		pr_warn("%s: requested %s%d, got %s\n", __func__,
 			name_base, nr, video_device_node_name(vdev));
 
+	/* Increase v4l2_device refcount */
+	v4l2_device_get(vdev->v4l2_dev);
+
 	/* Part 5: Register the entity. */
 	ret = video_register_media_controller(vdev);
 
-- 
2.53.0

