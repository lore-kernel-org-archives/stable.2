Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E922D94B5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912493; cv=none; b=TRAKKAidorxqF+cYENMDLGfTsSpi4eOhazRxZhGFqzD23aY9pIAMxJX+gz+IFUlS2okV0RZmQbnljxm9yrKsYtFJfBoG/iShdN/FJxPzBjyB/7nN3gbkk8bqcpReJjQAAiynavaR+8y0ieFZRzbThO2CyYRGmGcfOH2cEMfDndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912493; c=relaxed/simple;
	bh=NeQaBYawbJKcYUn520WXK4R33qMhpbbHezvk5zlfLrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE68JEiYIezs9NsKIpJhES8IMStZ+h69tZMthb09ohKQ59cGtAD/8S57XINro+nK4mp0AaUFTJs3X1kHQqsZd2BDmoLqGbEHZCg6FoOxisEe/djnwA1cvvDejDUqP/WnlkcH6D28kSe0px4kkLO4pSSyokXtAnFt4b3XcIfI/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUxxEG5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUxxEG5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539281F000FF;
	Tue, 13 Oct 2026 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912491;
	bh=Pp5swYT15hjMdn3aBz2D0DHu+cW9yrNme843szdLaA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUxxEG5ZKcjMym7hvRbDtbIgkGVTitVJhbNqXTg3HY3NSjeztorn6WXAFJ2MibZiP
	 Tk7rwv79YkxYhy9Dnvz81ZJdbidUaQ5H0/yqlJPWHjJDgPYMPkibhGPRVXP5KWrDaX
	 U93wRWgj28nLRdjYD9Ju/ySMxGwC7ZsX4T652RjA6RLYhB295krTpS8amlatZSaTPi
	 DZUj9GPIpvRrdJyer9onnPixhmBvCnJMFxbupQecZo7DJMNbWDHu7TrLoUCwvOQdsG
	 8wVdEEcaQ/pPK9o8NfHATiR+OAdN4iMl6xdxDfD7RCOXfnP1EcV2g1d71B+XCk/wCg
	 0t44sn59Uxk3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Tue, 13 Oct 2026 13:28:10 -0400
Message-ID: <20261013172745.516795-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101259-chess-obstruct-51c3@gregkh>
References: <2026101259-chess-obstruct-51c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit b816da5d5df1461446a0a5f3fe2b4948a659a790 ]

The firmware reference obtained via rpi_firmware_get() is leaked when
aperture_remove_all_conflicting_devices() fails, as the error label
returns without putting it. This happens before the firmware is
consumed and put further down in the function.

Put the firmware reference before jumping to err.

Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260916154015.2056797-1-vulab@iscas.ac.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
[ sashal: Adapted to drm_aperture_remove_framebuffers() and its direct-return error path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index b6384a5dfdbc1..ec5eca21df44e 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -352,8 +352,11 @@ static int vc4_drm_bind(struct device *dev)
 	}
 
 	ret = drm_aperture_remove_framebuffers(driver);
-	if (ret)
+	if (ret) {
+		if (firmware)
+			rpi_firmware_put(firmware);
 		return ret;
+	}
 
 	if (firmware) {
 		ret = rpi_firmware_property(firmware,
-- 
2.53.0

