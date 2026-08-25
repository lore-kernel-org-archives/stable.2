Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538924A06D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639865; cv=none; b=bAWKowe4MFj/uoWnAwupzKoNlOD1staxRlH3rL5xuaUfFo78VcpTGNM/XeRyZEbxxam9FFtxFXVt8zXWt2C3wTf/IpshxR2HjtrKjh5ePsXQPft0nK9cP9M3ckaZvDoB9ZeSzurs1zFmconp/pnvddZyTazCGH71Z+c30F/dm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639865; c=relaxed/simple;
	bh=qE50yLD2V3tITUPrI+VW+ML5IxIwxwtiEGU8xsuoxL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9awomzbYXQz3V1Ym7DhjPigBbDh8xzc32SPoMZSO7PlfRpVMHyeKwUYs4Ds8w4G1+8k8SMVk7QqPcs5jBkMyNUpVbmzRC3ry9kDhdQ8x2I1KSpk5T/BgdxC7N9s6oSbx8Ms12By8T8s/NEZZ2AesIoOV38aCqPVrcWvukSfkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPPxb8aX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPPxb8aX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2020421077so745354766b.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787639861; x=1788244661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ci3WaRxL1LKBNX+6XcT/a5YijLEiic6s2oitvILr4v4=;
        b=WPPxb8aX8QDACdttdq/wAVwTvvTFLOG3gdhfTku71kOb95llZ+5ogG2BqSdi+ZtrMN
         LZh4dVSeaR5JHUEV74f7uMVbqXLNcC7Cp37NAoC2BbTZkfmJMlBaZ/CkgAjPK+rPpY2K
         nRvbyZjwZtUJuMX8t/vvwkmTmlZf4ubxXCL+V71ih2MIVQArbiBEVFMUvjBNOhVLV5eX
         wslO0L8poaA1xDhDX3Fuke1FC9V496Uz3As423vyUaS+B9Ap/N+xwmV1MXvH6MCLnn7N
         ujMsw/OTyUbDZdUePclOZuRb1CSd5p7A5qYeDRbQGsRMWEWKUVyHNosxxs+NO0yYE92R
         70eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787639861; x=1788244661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ci3WaRxL1LKBNX+6XcT/a5YijLEiic6s2oitvILr4v4=;
        b=VCeglvCe8HAKxtuxxdHV73lezUjbtB6VKtqNM5yynrQbgu4RRvAOxE4xSxzyYJSvtm
         f4N7IKJ2CjeGWwS0cCO6CYG09DmrPNUGnhsu3FqNm8CsRnNRUeWeqrZ+gQwsqi6sc688
         E6hZFR/0lcLT5SLEFSfyVNlTE9SfWqiTaXI0KIynYH0FnwLoIdbjxetcrLhylxxNNbZO
         fBOKIyym73vurYFXhlAFzIOayWpoXnYE7CIo/DrEGKglb8/NhpwX0JBV0FrYX+2EtE9G
         Le9dLE+9LnsHtWaCbNCNTBKzkRbfdhfViOGVC2IEG24uJwKirrk97vyfCZBeKyNe0CMp
         sPdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7wiu+3dgTDy+XqHpZavKjPR2kAZVQaUpGQqTeZsiknV+R8EYEB9gnjFYtaLxDYJJpEs0bX8I=@vger.kernel.org
X-Gm-Message-State: AFuF++khuhR2D2HWxM3oK0JwYxZGwAFwuH0cYj6nH0P26B/6e+yhCWDh
	HYG3LoJdBcDPrqVfJOpAgbaml/gCWKYKZPlvqxXf35Ffw0xOxWpokpDz
X-Gm-Gg: AR+sD11INFUtdYWJkkiZQzrbvDzr4xRzpMTZhOHQ/nwD2j88kDLcihgJRbXP0UBIUIY
	1qYBmc4uvwWsIOtBd02z4S7psFrvF5lYAhMI9aq1nAEQsVF/qALQBMmkoIEbfC9QZU3Q0xlDW4G
	SWPwv3slRKt9xUrRFbvr6KZ3wZ5BD64tQywUCJl09oL7wJMjWokHnYwEeutZcT7DgMLToJrwYsz
	xo6FwP5uw7Ubi0PQJLBbNxB3bYgBC6bunpqnyTHPucYWUADKcpPmPf2ajZMCg9WvSbxZqRs6yGD
	8xTteBiE3l32QnieeVEPI5qWhSS4Og5vXK+ZWhOOwHAyhlTXOR1fcK6hnmxphqKn54uM92xb0z8
	ccV+uLX4bRBiUqaVXid04MuNyMEccRBNHZkK541DxkAprogGKR+ptqfQv3j5CK+gkc8CZVC/8CI
	oM+vzlRsClcpFi8jllUaFnBFU4Ov64+Ye/ljjfGEXFG4OCWtc5pu21pbC76To0qz7baMMwrAMPV
	+qk/gvTB4G7I6P9yAgzZo6iTuHcBYBnmiRs2TmWeKIOE1WYgJrVPAQMJE2KqP11+o4bU+eJ3Wqq
	3xyZovGBl4zD8OoQbJBx6UIQ5tRBkbUVjSJwp9pBDOm5ddDkzi4XiOI4+UnfWBTa3M1q
X-Received: by 2002:a17:907:9626:b0:c24:87e3:b8b8 with SMTP id a640c23a62f3a-c249209907amr2334856866b.17.1787639861208;
        Mon, 24 Aug 2026 23:37:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af54-b201-7419-a557-62e9-4d13.310.pool.telefonica.de. [2a02:3100:af54:b201:7419:a557:62e9:4d13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa97sm1442110066b.57.2026.08.24.23.37.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 23:37:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Tue, 25 Aug 2026 08:37:35 +0200
Message-Id: <20260825063735.14676-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vc4_hdmi, including the embedded ASoC card, is DRM-managed and remains
alive until the final reference to the DRM device is dropped. The card is
registered with devm_snd_soc_register_card() on the HDMI platform device
from the component bind callback, so its devres node starts out in the
component's devres group and would ordinarily be released at component
unbind, while vc4_hdmi is still alive.

Whenever an ASoC component is registered, the core retries every card
waiting for components. For a devm-managed card, each retry destroys and
re-adds its devres node. Because snd_soc_bind_card() requeues the card and
converts -EPROBE_DEFER to success, even a retry that still defers can move
the node outside the now-closed component devres group. It is then released
only at HDMI platform driver detach rather than component unbind.

With no DRM file open, as in the reproducer below, aggregate teardown
drops the final DRM reference. This frees vc4_hdmi before the HDMI
platform device's devres release, so snd_soc_unregister_card() accesses
freed memory:

  # modprobe vc4; rmmod vc4
  BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
  Read of size 1 at addr ffff0000456a8450 by task rmmod/262
   devm_card_bind_release / devres_release_all / driver_detach
  Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
  Freed by task 262 (rmmod): drm_dev_put / component_del

If a DRM file remains open through platform detach, the final DRM release
is deferred until the last close and the ordering is reversed.

Register the card without devm and unregister it from the component unbind
callback, where both the HDMI device resources and vc4_hdmi are alive. This
makes the card lifetime independent of when the final DRM reference is
dropped.

Fixes: 42d99857d6f0 ("ASoC: core: Move all users to deferrable card binding")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v3:
- Clarify that DRM-managed memory is released when the final DRM
  reference is dropped, not necessarily at driver unbind. With no open
  DRM file this precedes the HDMI platform devres release; with a file
  held open through detach the ordering is reversed. No code changes.

v2: https://lore.kernel.org/r/20260823173740.2983-1-kmehltretter@gmail.com/
- Preserve the existing ASoC component-lifetime comment and document at
  the card registration site how deferrable binding can move the card's
  devres node outside the component devres group.
- Point Fixes at the deferrable card binding change.
- Add the ASoC maintainers and linux-sound recipients, add the stable
  trailer, and update Assisted-by to the current format.

v1: https://lore.kernel.org/r/20260822143218.68764-1-kmehltretter@gmail.com/

Tested on a Raspberry Pi 400 (BCM2711), v7.2-11658-g26260251022f, with
KASAN: report gone, rmmod/insmod loop clean.

 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..7e312932488a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2422,12 +2422,18 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	 * snd_soc_card_get_drvdata() if needed.
 	 */
 	snd_soc_card_set_drvdata(card, vc4_hdmi);
-	ret = devm_snd_soc_register_card(dev, card);
+
+	/*
+	 * Deferred card binding can move a devm registration outside the
+	 * component devres group, so unregister the card explicitly at unbind.
+	 */
+	ret = snd_soc_register_card(card);
 	if (ret)
-		dev_err_probe(dev, ret, "Could not register sound card\n");
+		return dev_err_probe(dev, ret, "Could not register sound card\n");
 
-	return ret;
+	vc4_hdmi->audio.card_registered = true;
 
+	return 0;
 }
 
 static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
@@ -3345,8 +3351,20 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
+static void vc4_hdmi_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+
+	if (vc4_hdmi->audio.card_registered) {
+		snd_soc_unregister_card(&vc4_hdmi->audio.card);
+		vc4_hdmi->audio.card_registered = false;
+	}
+}
+
 static const struct component_ops vc4_hdmi_ops = {
 	.bind   = vc4_hdmi_bind,
+	.unbind = vc4_hdmi_unbind,
 };
 
 static int vc4_hdmi_dev_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 29d461d4ee49..444c73513d86 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -106,6 +106,7 @@ struct vc4_hdmi_audio {
 	struct snd_soc_dai_link_component platform;
 	struct snd_dmaengine_dai_dma_data dma_data;
 	bool streaming;
+	bool card_registered;
 };
 
 /* General HDMI hardware state. */
-- 
2.39.5 (Apple Git-154)
