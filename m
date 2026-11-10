Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318392;
	b=mG68C/ouomfRjPcB6vu7YkYH0QgwEZgeYkhUuStOdiZhRsZAx8yukWbbgFVp3DGLxs62
	 C2sD/OCY3ju4xOtgEkuoqrd51DVDhTNA1GYW//Ve745/o3DqHgGQO6pW48zrGawcjMn7e
	 HPWKXwx4ZfGgksYnBefS9OZw/DGwgAOCF0jhvhT2ViVhkKaHqvCW+xvfRcJGAX/ZQ2Ce9
	 DXdyOIxrxOuVtsmQGqEA/Tly/bLLsCXuA/V6aUCw4NxTF9qMbDECXfVy4WKVRrXHpuFbf
	 N9QuklBwwT6XR7+eOl54NO688WQ2sRT4kjQCbu0RsDHbdGpBF+RP/u3lGxPWEfbNCww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KSVJhvzcdgPdfp5xUb7UN9DLdLwRAQ0PoV3NkqL0rwU=;
	b=hGYEZgS15EDhHZOfZnZ78kPf+yefw0eZTETUECo6txuwILygfXCTnFlzJmVI6+DC5rvd
	 zv2yVqXrTqcBXjQuenh5X2MuoKp3n58ucHk+ovDwU3WSYSu0uE7HXtaJEL4J3qGEe56kj
	 kBorxhs+BX1iZFElZXxaD7BeOdbtkr4hXh7rtRPr1IzCIvsyfGdF9FyEOC07XwCzZCLYk
	 Z2EM+7hznNaq91ZMJxEUC6U9yu+q01gzQiFVivdrf9f3SjwDqDHFizrMqVRyPc2l8gSDX
	 FBi+QrRqinR5BWcQrb+09GU2wC3zj7svjAN5/j9XK3TQYmGuZsYAgwf2K3kumxu12zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMT2mjFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMT2mjFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D71F0089F;
	Tue, 10 Nov 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318391;
	bh=KSVJhvzcdgPdfp5xUb7UN9DLdLwRAQ0PoV3NkqL0rwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMT2mjFBmapa6FkhiKYLzXR6kXtECMxH5Qv/OLzj0y/+/BLRbpJsRDcZLNndxtXkZ
	 AeuBDvF8b5NbcYepDzaZpsVQqXj5VF99vx5Bnxvlh+ojCtXqBSNheBmBcQAuxc5t5c
	 rI2uMMVuxgEVCbaFyfWPZRIN7R522DBk/aAWHVJeQ5GiMKVC0zL6aw3GQC2rnBO6Pc
	 N/3grOfNLJfaTLstCWrWM47yT2u+WBk7S2yU3KWLQvr/bNVFG5g/NI8NqXrzX3+LQ2
	 NigAMZEPj3YEG+DDnxwMVtBoRnvndgsePfg1KBoUrH03glSMcMUj+ZZ45WqsWSnBfS
	 ENL2Rvr8IFOqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Aishwarya Kothari <aishwarya.kothari@toradex.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: davinci: Init async notifier after registering V4L2 device
Date: Tue, 10 Nov 2026 08:46:28 -0500
Message-ID: <20261110134623.1784694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054244-failed-6.1-b00fbdad64d4@kernel.org>
References: <20261107054244-failed-6.1-b00fbdad64d4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c62a9b8e4d5515638dc2f5e31969675b98c3de0 ]

Initialise the V4L2 async notifier after registering the V4L2 device, just
before parsing DT for async sub-devices. This way the device can be made
available to the V4L2 async framework from the notifier init time onwards.
A subsequent patch will add struct v4l2_device as an argument to
v4l2_async_nf_init().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de> # imx6qp
Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se> # rcar + adv746x
Tested-by: Aishwarya Kothari <aishwarya.kothari@toradex.com> # Apalis i.MX6Q with TC358743
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # Renesas RZ/G2L SMARC
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: b00fbdad64d4 ("media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/ti/davinci/vpif_capture.c  | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index ced6392c46d2e..7592216177b50 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1609,18 +1609,12 @@ static int vpif_probe(struct platform_device *pdev)
 	int res_idx = 0;
 	int i, err;
 
-	pdev->dev.platform_data = vpif_capture_get_pdata(pdev);
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev = &pdev->dev;
 
 	err = initialize_vpif();
 	if (err) {
 		v4l2_err(vpif_dev->driver, "Error initializing vpif\n");
-		goto cleanup;
+		return err;
 	}
 
 	err = v4l2_device_register(vpif_dev, &vpif_obj.v4l2_dev);
@@ -1647,13 +1641,19 @@ static int vpif_probe(struct platform_device *pdev)
 			goto vpif_unregister;
 	} while (++res_idx);
 
+	pdev->dev.platform_data = vpif_capture_get_pdata(pdev);
+	if (!pdev->dev.platform_data) {
+		dev_warn(&pdev->dev, "Missing platform data. Giving up.\n");
+		goto vpif_unregister;
+	}
+
 	vpif_obj.config = pdev->dev.platform_data;
 
 	subdev_count = vpif_obj.config->subdev_count;
 	vpif_obj.sd = kcalloc(subdev_count, sizeof(*vpif_obj.sd), GFP_KERNEL);
 	if (!vpif_obj.sd) {
 		err = -ENOMEM;
-		goto vpif_unregister;
+		goto probe_subdev_out;
 	}
 
 	if (!vpif_obj.config->asd_sizes[0]) {
@@ -1696,14 +1696,13 @@ static int vpif_probe(struct platform_device *pdev)
 	return 0;
 
 probe_subdev_out:
+	v4l2_async_nf_cleanup(&vpif_obj.notifier);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
 vpif_unregister:
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
 vpif_free:
 	free_vpif_objs();
-cleanup:
-	v4l2_async_nf_cleanup(&vpif_obj.notifier);
 
 	return err;
 }
-- 
2.53.0

