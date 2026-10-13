Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54B36AB77;
	Tue, 13 Oct 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885472; cv=none; b=IEFI+7PEd8/+YfZwGjsuKcqGubpwKLTQC/fZ2TrV03xooeQzv38Dw4X3OkJ4+HuZmiExL2nlbTwihxSKra+ay11WjFBbiANJef1Vm3WEpfRwy3jGdtAAFkTvi5/7EtSER1SUTTahXl616u60UihlOQAjt9hvIL4P1BXIuDJjyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885472; c=relaxed/simple;
	bh=prPWdv1ovPiV6mUJhBmuV/hQo6DoAeZ3psLRQ1K4zGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KzQWHJYRO9e2qPmvTH/ZohGwoWFtf6yOsnKvJSNJqQRJPAqvzgqaOAxEEH42zA+EQHiLv/ehPpVjtpcGlUKTwva6dnWgMoCchJ8uovpp5KRnmm6yNFmwpI0jDy8+cfBwRdf+7Qd5W4yAYdErThSVHFoSXApu2iPS1dLr7KJyM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70AC.000000006ACE0098.003393E4; Tue, 13 Oct 2026 11:57:44 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/tas2781: Assign total_sz at the end of the function
Date: Tue, 13 Oct 2026 11:57:03 +0200
Message-ID: <08ad212c4590c0570aed7b2bb870bcdf9a222434.1791883592.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791883592.git.soyer@irl.hu>
References: <cover.1791883592.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

In the tas2563_save_calibration() function, cd->total_sz is assigned in
several error paths.

Move the assignment to the end of the function.

Fixes: b6016332b889 ("ALSA: hda/tas2781: clear cali_data.total_sz when calibration read fails")
Cc: <stable@vger.kernel.org> # 6.18
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 5e5f46c9fb6b..f1329bb6adcd 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -337,8 +337,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	cd->cali_dat_sz_per_dev = TAS2563_CAL_DATA_SIZE * TASDEV_CALIB_N;
 
 	/* extra byte for each device is the device number */
-	cd->total_sz = (cd->cali_dat_sz_per_dev + 1) * p->ndev;
-	data = cd->data = devm_kzalloc(p->dev, cd->total_sz,
+	data = cd->data = devm_kzalloc(p->dev,
+		(cd->cali_dat_sz_per_dev + 1) * p->ndev,
 		GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -352,7 +352,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 			if (ret < 0 || ret >= sizeof(var8) - 1) {
 				dev_err(p->dev, "%s: Read %s failed\n",
 					__func__, var8);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			/*
@@ -370,7 +369,6 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 				dev_warn(p->dev,
 					"Dev %d: Caldat[%d] read failed %ld\n",
 					i, j, status);
-				cd->total_sz = 0;
 				return -EINVAL;
 			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
@@ -379,12 +377,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 		}
 	}
 
-	if (cd->total_sz != offset) {
-		dev_err(p->dev, "%s: tot_size(%lu) and offset(%u) mismatch\n",
-			__func__, cd->total_sz, offset);
-		cd->total_sz = 0;
-		return -EINVAL;
-	}
+	cd->total_sz = offset;
 
 	r->r0_reg = TAS2563_CAL_R0;
 	r->invr0_reg = TAS2563_CAL_INVR0;
-- 
2.56.0

