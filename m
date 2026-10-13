Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6963F1077;
	Tue, 13 Oct 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896616; cv=none; b=LRwVJnp2e0lW2pWNxisIn1O4Wwi5d5yIlL/JNoud69ev1akW6BMbFYPQaVWrqwJAA3w9t5S6QO20F01MfVul0cHbP4Fo2bHWimtd3sPC+wn/TmFObvaJwmDTD1VPS9Bz7Ek5rgPWkfVXh0+oHXDycAj95zkoH+l+aBO3F3zunGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896616; c=relaxed/simple;
	bh=uVjcc/KF4L/qAuKP4Nvyrp/+uPdvAFWs4UANUOE+N8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LTTh1KEZtdKGnZrCSZFZBMQEHc9lOjvQtshFReRQPSDg3tLQdjalzFYXhRNA2XpepYzjDpnESKJY3pPuRhHwS8PZiSto9yh9g+bvEMohIQ9DXV/chp1w1kMIj+/nid840oYv7mfnctIm7c7JLEPqyevA9AXPclBv7iAjlKtxu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68c74.dsl.pool.telekom.hu [::ffff:81.182.140.116])
  (AUTH: PLAIN soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000C70B2.000000006ACE2C24.00339CD6; Tue, 13 Oct 2026 15:03:32 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Philipp Oster <philippdev5396@outlook.de>,
  Georg Wenzel <g.wenzel@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data
Date: Tue, 13 Oct 2026 15:02:21 +0200
Message-ID: <12a1ab265a1dc0e3a062a54287c8ef48682c4efc.1791895478.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791895478.git.soyer@irl.hu>
References: <cover.1791895478.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some Lenovo 14ARB7 laptops do not have proper calibration data.

Skip these zero calibration values and fall back to the calibration data
provided by the DSP firmware.

Tested-by: Georg Wenzel <g.wenzel@gmail.com>
Fixes: c3ca4458cc2f ("ALSA: hda/tas2781: add TAS2563 support for 14ARB7")
Cc: <stable@vger.kernel.org> # 6.18
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes is v2:
 - none

---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index cff8fab8133a..44855f593daf 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -372,6 +372,11 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			if (*(uint32_t *)&data[offset] == 0) {
+				dev_warn(p->dev,
+					 "Dev %d: Caldat[%d] is zero\n", i, j);
+				return -EINVAL;
+			}
 			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
 			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
-- 
2.56.0

