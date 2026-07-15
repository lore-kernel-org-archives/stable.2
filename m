Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26905306B3D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133155; cv=none; b=SVIZjxRfNWVdNS4IX26ATPu10iR54Jf1Ozv2h/fMp7N6SZQTGMi7uPQmpr78H6WMYtkyZC7d67mtFB8N2rNSDa7uedFx95Y0HSlYzrn7ncci/Pbye6WvVjBNg4Dvnll13DXNDpqOUseoNyab2xCTt2hjS1ARVYqNatOlg6LezW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133155; c=relaxed/simple;
	bh=89Rp5kWmGIvdXP9dcrc3PpY4WlURkNb2gdJ6t0liJEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtAiReGHr8UkQQx7RuU7t1RRgtoz8Bse9zuolCZ19UVcVE6IDqZ8VRTsRm8B767DU1jwVHpDT5sJQo2z7Z89eknr4Itz8/G0jrPwLD+LPNFd0dq3z6KKy4O7AQHCK56bzd1iosZAAhMX8fneDHISrH4j1mQc9OVKcaUjoCv68hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAyx7baA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAyx7baA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD6B1F00A3D;
	Wed, 15 Jul 2026 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133154;
	bh=4Ftscj0zci216bBWdsjkYaGLyzZOuuQFa+uRfFci3pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAyx7baAEwRvtlGqeydnuZFFIQCVuk/VUC6myM8ynOyleL1oGN6watFwz0NucnhA/
	 V5x8HYCzSm+DWaRQBFm8wq7DJrJvMVKJ0eWv90dWfUuWg893MSy4LbMSpdkn7YAk+h
	 4k1CFKhA4D+Bsh66k1jLSvN1X1Swr8CWHet89tbEPewmzHKKUbxigLa1AcVtnaeX7Y
	 5eCXcz6k/xr18HIkVxyP+rgEHRW6hHeVLnocKNEpwoBWvvYM8YZ8hIVVugL4csQdNv
	 nE44xlqZvIRCj7uOmdBy7L+wGzXNu/FU31iuyLK7NPpbK0TkM6HqXXqiNLjAGHvm1D
	 57XXk/G/noY0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: nxp: imx8-isi: Fix use-after-free on remove
Date: Wed, 15 Jul 2026 12:32:30 -0400
Message-ID: <20260715163230.952514-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163230.952514-1-sashal@kernel.org>
References: <2026071342-backfire-varsity-a0ef@gregkh>
 <20260715163230.952514-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit b670bf89824ede5d07d20bb9bfbafb754846081d ]

KASAN reports a slab-use-after-free in __media_entity_remove_link()
during rmmod of imx8_isi:

  BUG: KASAN: slab-use-after-free in __media_entity_remove_link+0x608/0x650
  Read of size 2 at addr ffff0000d47cb02a by task rmmod/724

  Call trace:
   __media_entity_remove_link+0x608/0x650
   __media_entity_remove_links+0x78/0x144
   __media_device_unregister_entity+0x150/0x280
   media_device_unregister_entity+0x48/0x68
   v4l2_device_unregister_subdev+0x158/0x300
   v4l2_async_unbind_subdev_one+0x22c/0x358
   v4l2_async_nf_unbind_all_subdevs+0xfc/0x1c0
   v4l2_async_nf_unregister+0x5c/0x14c
   mxc_isi_remove+0x124/0x2a0 [imx8_isi]

  Allocated by task 249:
   __kmalloc_noprof+0x27c/0x690
   mxc_isi_crossbar_init+0x22c/0x560 [imx8_isi]

  Freed by task 724:
   kfree+0x1e4/0x5b0
   mxc_isi_crossbar_cleanup+0x34/0x80 [imx8_isi]
   mxc_isi_remove+0x11c/0x2a0 [imx8_isi]

The problem is that mxc_isi_remove() calls mxc_isi_crossbar_cleanup()
before mxc_isi_v4l2_cleanup(). The crossbar cleanup frees the media
entity pads, but the subsequent v4l2 cleanup still tries to remove
media links that reference those pads.

Fix this by calling mxc_isi_v4l2_cleanup() before
mxc_isi_crossbar_cleanup() to ensure all media entities are properly
unregistered while the pads are still valid.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260507041318.491594-2-xiaolei.wang@windriver.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 560d58ff2db8bd..a161dc32689542 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -519,8 +519,8 @@ static void mxc_isi_remove(struct platform_device *pdev)
 		mxc_isi_pipe_cleanup(pipe);
 	}
 
-	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
+	mxc_isi_crossbar_cleanup(&isi->crossbar);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
-- 
2.53.0

