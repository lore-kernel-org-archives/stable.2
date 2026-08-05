Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4D1E98E3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890280; cv=none; b=XGNCEaVNxXLOdxYEuk933vR581umM8U/vC9SF/ABEOVUrB/wCLdpMaQdE+0tmkqmPUwpyoaGIHWsTtJIRjSWoGbMWWU4bQFvSMPwsNkXqGral4kOLukrEjvHq321TivLnvqoDJWBTyqu9NWLWiitH2uieE/RiuaJ/zHXSrbu0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890280; c=relaxed/simple;
	bh=8g8RcIdHqtEJRI+0y7bA/715q+GOHUujTPRrYmOevDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfshZFJe8vRjdhoKTGEu6nXkt5JXsZVXS4ZsJFPKEG4NFXCQM/2bSsgyDf69sjXFxBNUXFxZ5FquUbXFeBZzsCj2MMFFcn+W9RfIrjI63JLSghxqccIQnhxrR4JdAkUvMze3XRF13BmLkdFiC3F4ZUUDWjal89itq9UzcryaqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oElYL7EA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oElYL7EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02631F00A3E;
	Wed,  5 Aug 2026 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890279;
	bh=7+X0ayC1QoHb75tB3t5gljGqkHCdckTwnPuzKljJlP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oElYL7EAuJWlDPyRjnPeBiMLfjSiUU1YgMmdY9+uA0fwmWCgYaf5dOhtuBNvl37s9
	 Zgx0sjlwINYqBFP07FWOW01jS2Qx4sS3G1Sj7sQ8OUA7gsO9UXFst4YmIhNUz4QWgs
	 Lh0vTEtfF/GJIbxXLLYur3BwJLvr2UoKgbkBm61L5IXfxNKmKRoHRxsIBDq8jTvP4A
	 rPBERH8Fug7CRLxd7RSaF1bfTn6b14rTp1c+qjNICwyix3klbm3YJvr9t45BCYF7dB
	 RR3nbN88k4BqrC6EZEypYCeYYTmejY7RZgqi2A4U1bNkOVrGhFU/IXY0HVKYqEavdF
	 SshJSMFItscdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] media: imx219: Fix maximum frame length in lines
Date: Tue,  4 Aug 2026 20:37:54 -0400
Message-ID: <20260805003754.3975160-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805003754.3975160-1-sashal@kernel.org>
References: <2026072956-strum-murmuring-51d3@gregkh>
 <20260805003754.3975160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c4f1ba7354312ad2d6e34e70a518a51a9344715 ]

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 7e55b4224c639..d2daf1bed3004 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -73,7 +73,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		0x0160
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 
 #define IMX219_REG_ORIENTATION		0x0172
-- 
2.53.0

