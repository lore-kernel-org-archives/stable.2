Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF303515C2
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506670; cv=none; b=M2vRD39cFc5diElrd2FtlSh+vX+4DHz3vXXjGWVQYYEFJKZYxovF10l1s9mW/cBSYWYLvJmOeN5JX56H8EdIzXHTWBn3OKjgMR8IXoeeG2XzJVrZppfb1sj35JP5Ed/FS0NTipUxlGevqlBpLJQ6vtoXwsyuq5bTFJEhg6hifwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506670; c=relaxed/simple;
	bh=vDzC1lXQTX20zA2uT4KvproTMpd8ikDZ7Uz9qaUggPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lpfr+SXxjhK045JmX2fQSiGHtylP997W/DZGV7BQ4cqmsTLGjX8t8deyECYT1qlInAlPyHhyIqpViWbBBfdAH+EcOtdV4LbwlzhUYl3g5spzJoO53DvP3cBeM9XNZREOsTZKPFxu444DUiyUpU/xoDPsr3/dePEyVkEpTlawyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQacU6NX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQacU6NX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso431431566b.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787506667; x=1788111467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzxtLwRD92+TCzzKKRXbUxryNiIrjmzaSY4Z8wvm3PE=;
        b=pQacU6NXgdwzVgaamRqgbVzWhlcLvjBztie4RtyJLUrQHp2L4NKw616g3JngzNBDd8
         25xUYQDJJylCNt7sGiw9GPtMC/GwThJq0CIft1otleNIrBCyZf0Ia69O2vHYymJk6jJ4
         Jvh/wiCbT/D2aIJDPjAI6YRsopbagDb2yK9XzGI6O7EUtKbqdJfK/IYTZSqSsmiahIpA
         Ibck/zQu4+RTs78ZOMJdB72aSEJ/3CVk7BqYx/Q8kPCNvryXfdNUl84XpeJKQ1qq3XEg
         drO100RRuPdI9swX012HwWiz9FqP0zCYc8orybXc7Sowl/B+3p/z25NS6v24ku5xakzX
         jKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787506667; x=1788111467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzxtLwRD92+TCzzKKRXbUxryNiIrjmzaSY4Z8wvm3PE=;
        b=DShjmis3iRyqTPbPcAJ1SxjEN90peyGn8/a3oFVLgpZVVgRvikcFoBpioOAw3eV7Ni
         YwfQdxkZXOVmHeaD2Fp1tzJFtW+4f3RwpeeRvfXTP/204/Oyi5aEImX1hJPzlWqdWOXg
         vQbMpAzXGnJaaxX2U5m3z73q/VfStWFSKBcYcU7g5OcWSCpcbhp01tZ6PsPnMzX6mXaE
         x+AH/L8HACqVLvE3pJBx//+xulNLgbrQ+wt6BBsOFH63KgDmQCRAsq7YBeWk56dQVXN4
         +A6UTvL8Z0WNCQc0ekeMWG4EdpRsnVgsBK70rTO6MD+81yMCr8IqS77KwQ3uulkJE7ef
         3yiA==
X-Forwarded-Encrypted: i=1; AHgh+RrtJBJlw8WTfkkXZHIp7SCAVohaYaHNZKbzz5RAUQ3CA69745vKGN6szdu16tvcY1EnNBi96VA=@vger.kernel.org
X-Gm-Message-State: AFuF++loxys6vnMBs0Us4Um4HOejFdsB9pi8WAsrAJR8skk/q587gM6b
	7c061gdLKntq8k74kjpGyWZDdUh2yRmlhvrBo/Rw5x6g+TDsy7rd96GY
X-Gm-Gg: AR+sD12QKvN0DqfnihoBtbU8eJRgWMg4gqDojJ2YHcrIHbHglNSiE9bTUx6sDBhDJz4
	5cc+4VpmCFW25z3aTwZFkW70Pxh0dFSUf6UVXdAdB0fJZfdPlFFIDinv/8wGAlsSix+boxxYYb2
	1v6OL9iNWkll2ry6yBuEvLJX+HnLILDH5b2yq9oXoGKjHW9/9PStF7IQQYYvvjY5rfZK42IL0QZ
	Z9dKJkrOkpkdY43kel9YPUckwcnAasF+RwOSEqDg+dzYMP5b+rONFbRKvSuOQm607UyQSR4i6o3
	Kep7IIBdJym2T8uuXW4b1fGREpq/IKpeDe5TbgC5B6Vpr+2426dzpkGXRCbN0CecOAhjSa53B1C
	q+uGri27DIPLPCFoEcCd9deDD1dVPve/VhFQ3FZnX7hlQ7LKQJxxu0Cswo6VNeIXBNTetEPcGvS
	iXyyflSdbSihgjttfXmtl9eoraLQW0Lc95xEj16kRGhuN9IXGZ+5x0v25pefNKDDAQrbDJQR+sc
	Y/EY20op32Mup38QXHGGhbwmx+6igw3PYtVghgQoe51MBp4ZdEXbe86+Z6NUEjaPM3NYx63ly2s
	FmHA0MDr4+Qpj0wTxe9DJES8cCcztqZrzkHyHDnetSt2lSOXWLrcDcWU4+Rpm7hp983ImMlEXw=
	=
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id a640c23a62f3a-c246a62b495mr2653594366b.18.1787506666570;
        Sun, 23 Aug 2026 10:37:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b027-cd01-554a-ffde-5279-f351.310.pool.telefonica.de. [2a02:3100:b027:cd01:554a:ffde:5279:f351])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa1dsm791239266b.56.2026.08.23.10.37.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 10:37:46 -0700 (PDT)
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
Subject: [PATCH v2] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Sun, 23 Aug 2026 19:37:40 +0200
Message-Id: <20260823173740.2983-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vc4_hdmi, including the embedded ASoC card, is DRM-managed and freed
with the DRM device when the aggregate device is torn down. The card is
registered with devm_snd_soc_register_card() on the HDMI platform device
from the component bind callback, so its devres node starts out in the
component's devres group and used to be released at component unbind,
while vc4_hdmi is still alive.

Whenever an ASoC component is registered, the core retries every card
waiting for components. For a devm-managed card, each retry destroys and
re-adds its devres node. Because snd_soc_bind_card() requeues the card and
converts -EPROBE_DEFER to success, even a retry that still defers can move
the node outside the now-closed component devres group. It is then only
released at platform driver detach, after vc4_hdmi has been freed:

  # modprobe vc4; rmmod vc4
  BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
  Read of size 1 at addr ffff0000456a8450 by task rmmod/262
   devm_card_bind_release / devres_release_all / driver_detach
  Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
  Freed by task 262 (rmmod): drm_dev_put / component_del

Register the card without devm and unregister it from a component unbind
callback, where the HDMI device resources and the DRM-managed structure
are both still alive, regardless of where the card got bound.

Fixes: 42d99857d6f0 ("ASoC: core: Move all users to deferrable card binding")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Preserve the existing ASoC component-lifetime comment and document at
  the card registration site how deferrable binding can move the card's
  devres node outside the component devres group.
- Point Fixes at the deferrable card binding change.
- Add the ASoC maintainers and linux-sound recipients, add the stable
  trailer, and update Assisted-by to the current format.

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
@@ -3345,8 +3351,20 @@ err_put_runtime_pm:
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
