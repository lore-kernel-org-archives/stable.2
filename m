Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04104FB9CF;
	Thu, 17 Sep 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654111; cv=none; b=nvRkI3TtSRf3gWv6qPcfj//fJJ3q9EaHjlMqC2+QHOz8OYgRCG4oLlC/yaJNGwJTHHHUDkPLno9m01S66gGeom40eNrSTv0CN4EzdvWtP4QIj0fRReKoISBbYP2TJ1ZdTMIBA0KnoofqAoSY29zjQlb0gJu3t9G0WMeSYXYbI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654111; c=relaxed/simple;
	bh=UXS0gWmIZol8VBZff2wUbE3FNTIji7/ANcODIWLIp8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sQD4vElYuBwsdCA5URC9/+eCYOJUpnkj8qtPXRRTnx43dfexY9EpCgh3AYO3f3uyOhQz3VW0oEXh+KtXQ69LTLh6sRc23eNdag3QK58BclUHlPFpL+BhJ4P9eBxWdKIwIGflL1kzpULYfbY5GOhYGLTpYDltR3hDDF5MBoMWe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA4fd1Pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA4fd1Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47918C2BCB3;
	Thu, 17 Sep 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789654110;
	bh=UXS0gWmIZol8VBZff2wUbE3FNTIji7/ANcODIWLIp8Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jA4fd1Pa8CoQ/Vhsj+iEGE5rZz2S2Wfy8VkCpuT73fDx54jpJ6s0ku1m+qtSiyXNu
	 0hC3ter/Qf7XDjUHyjfWNBBGN8mMg4kRVq5d6qh5j0W9hX4JLWDeAZJBHta/x8BOE3
	 gtEPCU+hyf++ODpBaM2ygzEC7CMEV/mUx3ExdFimXTS+HGh6qEu+lNnbrC7ZcwkRrp
	 Yvyh4hkg2C8As2woeSDcjN31gyTrlYBDyNWzfEG7T7Co+FGQgbOb+4HbPZARfH/Y0q
	 pC6Gnq6OnLePlA4mQZRkh+rkMiUBtZK9w4CpUfwJeLvMw+CEWDhbvzL5uPM4T88odz
	 hMe7Va5CnILLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22504C88E72;
	Thu, 17 Sep 2026 14:08:30 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 17 Sep 2026 16:08:23 +0200
Subject: [PATCH] media: v4l2: Clear subdev devnode before calling release()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-v4l2-release-fix-v1-1-acbac7f9b78e@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPrsQg2i3Vyk+xDhtt4iWrEpBv
 Htj+/gNzL+TISmMrsVOCZuazlNGVRYUn2F6gHXIJu9846RqeatHzwkjgoHv+uGLOKmlafsoA+X
 bOyHPv+St+9vW/oW4nB06ji/x4DysdAAAAA==
X-Change-ID: 20260917-v4l2-release-fix-89094967bc9d
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=5slSMYxuBgDGXyuAtqR9ZCxY1A7kKnqQ6WHaKf7aEdE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqq/RcWM2WD6KyRB8+zjxUZYzmG1/C75BD4j7aY
 9ZhxW9qKxyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqv0XAAKCRBgAj/E00kg
 cklTD/9No50I3OOiXFPmYckznONdpAqdchnb4ZchY8TRvZGvSVtYUw/GO21RGfsGS0eyb6iLiJe
 yIxkY/XIuajzv1rkjJFZMyfjukXYMIt0xnX+R6ImsnGazF5jD1CEQrilNtve4tkqARsdPEfeUTR
 okvTSAS9fWuQsxeOR5NmgKSc2a/sC10NmiSuU9yicYt84IoA5DXqw2qNLa1FM42qZIPDQQe6XEK
 lWXDiWhJnu+fxiAz+Jb4Ce0I646WA7Qyukp4PTrzAOiWjZuD2tNuKl8mqWrns+AYevzpY6xzBbJ
 AnWU/F1Dls8AMTVmwBPnDwlYX7u1fAlFLgSdUdQRSdwq00XG7soww6JKcNQtzENye6c5O1ndIeT
 psO37LfoWqSMGCNv+suTcuQS5Zfhko/gbkzgmtLMRZ8Fi4/h0F/Z1yUKYp5ZuyGKg4kILJgjhEy
 RQpfXNJYPO/H+3b1UjwaOa65K1BsWC1OJZD92RdzfycqI4I8sab+DpmkOiZDMEHAb/45FPFDj54
 6gEWIcEr0o0Ql2N/oPrJnn1SDfi/Uxzw4MO8IylEZbqna8d+CWphxcsLhEiJpqCvSi5dg0nRYN0
 wUg/5/ayTN1Uh5vZY4o99/8DWc4IJV5ucRXSuUMQnbcCdVglC7ULRJYQgY0QkuuMiicUECVGAMt
 PYpmPka09zkrzEg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The subdevice release callback frees the memory that contains the
v4l2_subdev structure itself, but v4l2_subdev_release() wrote
sd->devnode = NULL after invoking the callback. Any driver implementing
the release callback to free its state would leave that write targeting
already-freed memory.

Clear sd->devnode before calling the release callback so the callback
runs last, matching its documented purpose of freeing the subdevice
memory.

Fixes: 6990570f7e0a ("media: v4l2-core: fix a use-after-free bug of sd->devnode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/media/v4l2-core/v4l2-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-device.c b/drivers/media/v4l2-core/v4l2-device.c
index 67e3073de1321..b4036105c2d1a 100644
--- a/drivers/media/v4l2-core/v4l2-device.c
+++ b/drivers/media/v4l2-core/v4l2-device.c
@@ -171,19 +171,19 @@ int __v4l2_device_register_subdev(struct v4l2_device *v4l2_dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(__v4l2_device_register_subdev);
 
 static void v4l2_subdev_release(struct v4l2_subdev *sd)
 {
 	struct module *owner = !sd->owner_v4l2_dev ? sd->owner : NULL;
 
+	sd->devnode = NULL;
 	if (sd->internal_ops && sd->internal_ops->release)
 		sd->internal_ops->release(sd);
-	sd->devnode = NULL;
 	module_put(owner);
 }
 
 static void v4l2_device_release_subdev_node(struct video_device *vdev)
 {
 	v4l2_subdev_release(video_get_drvdata(vdev));
 	kfree(vdev);
 }

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260917-v4l2-release-fix-89094967bc9d

Best regards,
--  
David Heidelberg <david@ixit.cz>


