Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CA414435;
	Wed, 16 Sep 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582687; cv=none; b=jNixYLPRtTBhyUnhnAZ4t6VrS8qegWceIqnToEIOsdSRef5r42OXRhS+if3iWuSTdnPknMAH8wXP2BJF193O11Jj7ArpDuApoeEXfg3U6T+RfPWwRvs2hK24bqpWK6TAqXmt+IdRaeBNn2JpB/PytuXrFQT8tMRPHhk2RswR0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582687; c=relaxed/simple;
	bh=SNBU3LDY5WiGXZdi0zwQP/kdHhTLC06NrqJQebeYLQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ivGHKqp+SBHcfsNYTkHpR4ljtlt8ogr9+0zYDP59WaRC9FYBGs0D7u+dhnMa679OzzD46Se88Y8soL+a6qKimfGShOYPDMSUYgAA4lOuVlRqIKVvPIijnf+t93I2DXodKbzFQ86mB6EkpLmY68hbirCuHVr9TDnaQJYaGTRdUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABn0z1F3apq2VpvCA--.24248S2;
	Thu, 17 Sep 2026 02:17:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/rockchip: dw_hdmi: Fix hdmiphy_clk reference leak in dw_hdmi_rockchip_bind()
Date: Wed, 16 Sep 2026 18:17:13 +0000
Message-Id: <20260916181713.2091226-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn0z1F3apq2VpvCA--.24248S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDtryUXw48ur1kur4kJFb_yoW8JF4kpw
	srJayYqrW8GF4IgasrArn5ZrWft3ZFyFWfGrWIkayfCa1fKr1Yka4UWr4rXry3AF13u3W2
	krn7J3s5Ga12grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
	0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMMA2qqpVh2pAABsl

The reference to the HDMI PHY clock obtained with
of_clk_get_from_provider() is never released, neither when binding
fails nor when the component is unbound.  Drop it on both paths.

Fixes: 3303a206ae74 ("drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..5b90de4da5a9 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -622,6 +622,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	return 0;
 
 err_bind:
+	if (hdmi->hdmiphy_clk)
+		clk_put(hdmi->hdmiphy_clk);
 	drm_encoder_cleanup(encoder);
 
 	return ret;
@@ -632,6 +634,8 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 {
 	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
 
+	if (hdmi->hdmiphy_clk)
+		clk_put(hdmi->hdmiphy_clk);
 	dw_hdmi_unbind(hdmi->hdmi);
 	drm_encoder_cleanup(&hdmi->encoder.encoder);
 }
-- 
2.34.1

