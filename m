Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C053C8C48;
	Wed, 16 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581149; cv=none; b=cqopzpdU+kGpI/JlgBWvEv/naDHOnF/PASbA5Io7LT3jE883eE41ZxAb06d6VEZpCWd0HwnuPL2BREkmFQDBF/Ltvn9ZHtsBIBVvEWVZ9es8sSbZFu5WHSn+B1OO2jxU6xF/O7PYorGXoMgbzyabXtF0fieP39FCjAM+lnhakAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581149; c=relaxed/simple;
	bh=U+eOQTJxaY0aUk6miCCBOq/I3SH6A6Ukb3aehTMfWyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sROFmaH1UIKo1W9MxFIGgx4x1nXx/9QNp8tdR/EMK89el0bUGJUS7LiDEKo8IbXqrjMAjGGmRmp/c0VDHAsWqvzNrz7CQfGLgHFUQlcUD2ulmPdPIxG97RTY8a9Yk7eARLwX9O8y4bAgiS62UpoDSFppL0/BO1ROwGnVrNrOb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3pD5L16pqMvNuCA--.22793S2;
	Thu, 17 Sep 2026 01:52:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: architt@codeaurora.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	treding@nvidia.com,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: Fix device node leak in of_mipi_dsi_device_add()
Date: Wed, 16 Sep 2026 17:51:43 +0000
Message-Id: <20260916175143.2089466-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3pD5L16pqMvNuCA--.22793S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47ZF15Jr1UJw15Jr4fXwb_yoW8WFyxpF
	W3Ga45ArWkKrsI9ry8ZF18ur1aga1ayas5ur4kJ3W2k3Z5Z345tF90qFyDGw15J397AF1Y
	qr9rJry8Grs7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2qqpVhtHQAAsE

of_mipi_dsi_device_add() takes a reference on the DSI device node with
of_node_get() and hands it to mipi_dsi_device_register_full() via the
device info. On success the reference is transferred to the newly
created device, but if mipi_dsi_device_register_full() fails, for
instance because the channel number is invalid, the DSI device cannot
be allocated or device_add() fails, the reference is never dropped and
the device node leaks.

Drop the reference when mipi_dsi_device_register_full() returns an
error.

Fixes: c63ae8a9686b ("drm/dsi: Use mipi_dsi_device_register_full() for DSI device creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..16c0682f8a99 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -162,6 +162,7 @@ static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
 	struct mipi_dsi_device_info info = { };
+	struct mipi_dsi_device *dsi;
 	int ret;
 	u32 reg;
 
@@ -180,7 +181,11 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 	info.channel = reg;
 	info.node = of_node_get(node);
 
-	return mipi_dsi_device_register_full(host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
+	if (IS_ERR(dsi))
+		of_node_put(node);
+
+	return dsi;
 }
 #else
 static struct mipi_dsi_device *
-- 
2.34.1

