Received: from outbound.pv.icloud.com (pv-2006e-snip4-3.eps.apple.com [57.103.67.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7164A6CF9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439826; cv=none; b=U0qoDvITL8hQoSN/O8lAO94xak0YFjoLOplpJjdXZF5yAeV1RZGXKGmWHsgdSxLsKebHt8sDDYhgsiuYZ0WgS/QErQaJ0vSnz1W66fS5vQ1wWWWi1EPBelysmLS/w1GQp4w/OezJ5zWPIjr2XvMM0R2R3P9To1vKaNGFuUxkviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439826; c=relaxed/simple;
	bh=cg9kWbceYx8PSNDrmZnXuLdqOPAnaRwef8Env6m0WLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPg6/4K60Nc+nbiuIYVvZEeJ3RV07rhVX8dgNHEitiFxf50K7+Ii7fXCzKz+NKrZmJJvhb2+lx6++EtRNugT4GMTQBs3hMBi1q4xk7VifCaALz/mugk/ZzvUeesddsCm9gZYCPezw56CHitK1Ocj4UOQX+478rKfFA7QdZHFjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinon1.fr; spf=pass smtp.mailfrom=pinon1.fr; dkim=pass (2048-bit key) header.d=pinon1.fr header.i=@pinon1.fr header.b=QaoRREhy; arc=none smtp.client-ip=57.103.67.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinon1.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinon1.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinon1.fr header.i=@pinon1.fr header.b="QaoRREhy"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPS id 86D4F1800C8D;
	Thu, 03 Sep 2026 12:50:21 +0000 (UTC)
X-ICL-RepId: 01a06751-fc9d-71a4-ba5c-a5906bfe3d3b
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBKHVwPXxxBDUkdXA5eEhVdRUMEUhlAFXkIWgNYBQNeXwoTC1NWQhlXF11cGQ1AUEsbDlUXA1ccVkVcGEMJXQVXHB0dQUVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BHAlwfV0kdC0VLXxldRQ9fB1kEQABIAFwFXgJBDVYFXAVbB0MUSR4dXg5AAlw4QwRZBFxBFx5BUxcfSwBcRVAYRB9dHWYcXABWAlw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pinon1.fr; s=sig1; t=1788439823; x=1791031823; bh=LUfe1pdcps0sFnIL1Tvqw6S2TvQ7uC51WrK64XPEpbE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=QaoRREhyqEfbb2rlIFjEZ3ebd0ZcDeZzrhqOCtPDHxykSESGcI0FWRIuy31XtbyanYxiFi22yBvE6G5+4RC9VXVM/8BIwXSoSe1IZHo0hWAFYaEGbGCKj2CyGIGzbVEx554Qt3hqKiY8rXZau6Ufra2V3BsTjXYjPn8lLFo9kOFDTMS7Jt6bZEBL40JGfB1u+VGMT/nfhHf3KKpVJhjQOx8YhukHqT9DeDENktYq/7QYcUlgpfTOd9bRbTcY1QgE860W8FhiwLPR5OLUYHTxdJa0MhKU0i9355T22oC3fiC/9GyHBR3du5x1XofM4zQmlyngFeNqorFCw7xYsD+S+Q==
mail-alias-created-date: 1575045973000
Received: from 2a01cb06d02d74794b6d6271b4dfc9d3.ipv6.abo.wanadoo.fr (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPSA id 32F181800320;
	Thu, 03 Sep 2026 12:50:19 +0000 (UTC)
From: Pierre Pinon <pierre@pinon1.fr>
To: Miguel Vadillo <miguel.vadillo@intel.com>,
	linux-media@vger.kernel.org
Cc: Pierre Pinon <pierre@pinon1.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: cvs: register subdev nodes when the remote sensor binds
Date: Thu,  3 Sep 2026 14:50:13 +0200
Message-ID: <20260903125014.612053-1-pierre@pinon1.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMSBTYWx0ZWRfXyV4zW7x64LCF
 MTTfdTJg9VXSYXHInBCLf/i6KIhx5CoSxjO26/2ZumqkO1fXLk7q6G0S973bmuokfGpmCRizr3R
 ARVFgFdRzYO0lZLRfm3vD+aCuov+FwoRagxtP0gOC4bOUVcbhcKgJkEyyyxudf8voaXy7Vo6ucj
 gn7PCWloTc+X/CtWlyIIe8zIvQJl2s7wCkt1cGv2qO9wSJn/xYxuNRzMqQqnBtbZTb3gNswr2jQ
 Tyv9Sbsot86IjzT43ogqnX76KbPGXJJe5kXttFqbjs4303beaMd4tawsFuBIKBwmD/h4mVPWBK1
 iLfJxoSoR+rY+tnjtylhGslnE9eaasEafDMm5BNUtpoadlI3OCOGhS0hN586Js=
X-Proofpoint-ORIG-GUID: yZFUPbM2yqc4hToncFDC8zf2S6oKNDOa
X-Proofpoint-GUID: yZFUPbM2yqc4hToncFDC8zf2S6oKNDOa
X-Authority-Info-Out: v=2.4 cv=SvydKfO0 c=1 sm=1 tr=0 ts=6a996d0e
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JOLwy3tAsX9ZQIJcA2wA:9
X-JNJ: AAAAAAABULCkW0hhv7KM7gLZlSGwSW6BzEq0dHFwlMGS27c5zke2yMDetmmUnmSntn177vAkU8OiGwOqCcCP98rG/nzyTwRDJeky7E3rQiASsCTFhfselCam3fqQebFWZTSjW2FnnqYhdpy1wx7tacQgkL37DrVwTbhD6qy5vHpDjItuieRqVSAiG6lCiytibu7yR5t89bsLjatCXkTXzN3/FunHtfABAGJ6a8Z+31ppruToN532CM+7DyqL3eL/krbP1lngCqJd9zP2oWsx5joyyXLNsrXjLtMi4FPOB8/HFdUc3TLwWs8E1Jckp9f6LeDq3su/Pu2807k9l0igTqYgI2P3ZIK09MT3f6pn4cCoZNDYbkL3ovckh8nZxHHU6MIYXzv5MTan7HZxzxgAhCu2dlVjMnNFwJf24jWqAog7fp9KaeNIi9Ytt5mzW29E6Tq1Z3FVOUV/vMbxFOU98kKx7GpIrKu6lWzSJO8dH9xyfP3uE72f+gYCFexkNpctjqLKzxg9+sl4CjYgsbhpAnN4eTNN73lAil7YWDPZLTT4uS+34BS7735ALdv1r1dXm43iQiqk9r0qaI8ABwv1VRcEf9nSWt4FHCRb9gZF3L1PD7sorMu+ycg0PoaO9oocTwEpVlhp3ThZgl4NQBBtBPRlixS7QcEkRgOdzT/cxXfv+Epxq7CYpUokBCdUL+YNKtIGgU/zsrQLet7SS6pjXkddtp/gdz2yu37w5pHAdWLEcZVmkts/nFoQk1iBOvm9v159GDGiF7DcZMh3NcZz+p94Xo5zjtlJYONaioXh1XkRJRD/8yqYnhlNvKV6QNXob14YRHqUxFgT13ZrAAbEf4AW6GIPxOJsXXjViWpWzcl9SpgkLSU6Ysy/NqKgHaKbC1sjfSiooA1SD+om5vOaXf7D7nRTDWqGgSifthhl2+mXtOHal8oC7rLltK5jxSN8LOAP5UfqkpZ7J2LkypeZtPGHNo+AdBR
 VVy0X6F6NtFTvJVnpXmbdM1m6NXXNFwxxlqKTulJilEzMdwAJ6ea04F4CRhosbzJoh1lTPwnCS2/aozYZunmEmiDRC8iyWVGcPMucbdauVKOqG0RtXxtcPR9oEfyEzsZnbQg0Dv9XT6Hg90Y/ouQ4qyLzXTCl0uKzp1TgEF+g0NZn+tjOaDELdD8ZHMR65xW3MBgyWo6ifPnvvMapfcvN7tYSiMIz1CoIZPAbleybGAsioOebaQzn/Nn9U18axGmhcydwBsd8hh1+5iKiR9F65FzHnG8uQ0cBHu41T6trZTTy0VD0+wgZ8gDeFHUXPfJ6q9MLp5de/UEUs4UBqhBiTdUQi5VzitrFjEC33y+3

The CVS bridge picks up the remote sensor through a v4l2 subdev notifier
of its own, but nothing in that path creates the sensor's device node.
The IPU7 ISYS driver calls v4l2_device_register_subdev_nodes() from its
own .bound -- which runs for the CVS subdev itself, before the sensor
behind it is bound -- and from .complete. The sensor's node therefore
depends entirely on .complete being reached.

That does not happen when another sensor on the same notifier has no
driver. On a Panther Lake laptop ipu-bridge instantiates two camera
endpoints, OVTI08F4 (ov08x40) and HIMX1092; there is no driver for the
latter, so it stays in the notifier's waiting list forever:

  # cat /sys/kernel/debug/v4l2-async/pending_async_subdevices
  ipu7:
   [fwnode] dev=i2c-HIMX1092:00, node=HIMX1092-2/port@0/endpoint@0
  ov08x40 17-0036:
  Intel CVS:

The ov08x40 subdev is registered with the v4l2_device and shows up in
the media graph, but never gets a /dev/v4l-subdevN, so userspace cannot
open it. libcamera fails with:

  Failed to open V4L2 device '': No such file or directory
  No valid pipeline for sensor 'ov08x40 17-0036', skipping

Register the subdev nodes from the CVS notifier's .bound instead. By the
time it runs, v4l2_async_match_notify() has already called
__v4l2_device_register_subdev() for the sensor, so sd->v4l2_dev is
valid. When .complete is reached as well, the extra call is a no-op:
__v4l2_device_register_subdev_nodes() skips subdevs that already have a
devnode.

With this the sensor gets its node even though HIMX1092 is still
pending, and the camera streams.

Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
Cc: stable@vger.kernel.org
Signed-off-by: Pierre Pinon <pierre@pinon1.fr>
---

Notes:
    I am not certain this is the right layer. The same gap would affect any
    sensor sitting behind a sub-notifier, so the fix could equally live in
    ipu7-isys.c or in the v4l2-async core; I put it in the CVS driver because
    that is where the sub-notifier is created. Happy to redo it either way.
    
    Tested on a Panther Lake laptop (Intel Graphics [8086:b090], IPU7 + Intel
    CVS + ov08x40) on top of 7.3.0-rc1: with the patch the sensor gets its
    /dev/v4l-subdev node and libcamera streams at 3848x2176, while HIMX1092
    is still sitting in the notifier's waiting list.

 drivers/media/i2c/cvs/v4l2.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/cvs/v4l2.c b/drivers/media/i2c/cvs/v4l2.c
index 9fadca7a3..0a42f91c0 100644
--- a/drivers/media/i2c/cvs/v4l2.c
+++ b/drivers/media/i2c/cvs/v4l2.c
@@ -13,6 +13,7 @@
 #include <media/v4l2-async.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
@@ -400,7 +401,7 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
 				struct v4l2_async_connection *asc)
 {
 	struct icvs *ctx = notifier_to_csi(notifier);
-	int pad;
+	int pad, ret;
 
 	pad = media_entity_get_fwnode_pad(&sd->entity, asc->match.fwnode,
 					  MEDIA_PAD_FL_SOURCE);
@@ -409,9 +410,21 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
 
 	ctx->remote = &sd->entity.pads[pad];
 
-	return media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
-				     ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
-				     MEDIA_LNK_FL_IMMUTABLE);
+	ret = media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
+				    ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret)
+		return ret;
+
+	/*
+	 * v4l2_async_match_notify() has already registered the sensor with
+	 * the v4l2_device, but only the bridge driver creates subdev nodes,
+	 * and it does so from its own .bound and .complete callbacks. The
+	 * former ran for this subdev, before the sensor was bound; the latter
+	 * is never reached if another sensor on the same notifier has no
+	 * driver. Create the nodes here so the sensor is reachable either way.
+	 */
+	return v4l2_device_register_subdev_nodes(sd->v4l2_dev);
 }
 
 /**

base-commit: 940de590b839f71d6dc846160534bf202401b8b7
-- 
2.55.0

