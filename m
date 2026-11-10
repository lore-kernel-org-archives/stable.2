Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319909;
	b=4G37naSRZMtnnz0ph9g6Wz6h3sOSCEO8VaGJUk4PW53rOydDDRQYu62KqRHL4hk/h+cf
	 e90TLf+2t4/Xf5p4ldRC1JtFTuAwlXo7R4Iv9jnT/6yl3v3If5rv4Q3M8SoMTg4Xn6laG
	 yWLzkIsz43B5YAfUHoDglLLvl0nikY9fmi6wPxtti10QNrFRxqwa1C8zJYBeDBOnDPZqT
	 FNLfMsbGTb6YNddXoZj6n+WB2do0knjOeSQQ14Qdci6dlSQGsuX+V17PGa2Nkpz7FwmJ9
	 0FA0DpqY49pK5M2uFUMJteNMGijhqUNqa5cxl/NAlPxiRgxpL2xBW3daWyk3OqV1Cvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d0ZOTteN1CPlOiy2YAr5oW6dGe3Ubh3qGAuvWmq2ABo=;
	b=SgxD/Z0UprZMZCKcitftgJQLVUXlL+ApiRkMvc+7abNASnIGWhtKLsKme4NUp1JOwLer
	 SayIYK5mybZZg5LlXYB/tQEzizdl9IZFgD29f6Ar6EV6Pt/KjeFhe5DZoo9iQYlCAKjiY
	 p6vhPtqEMYmIkNOr0haS9Asu6Xga1oIId1MWtoskflmmn1ezyVZd098a/AF65aH8NzhTu
	 Lch4GwbimWbIcKh/yCMyYl7WuyDBa06C6ps9ZCAMQieD7ZwXIGBAQsYAUPD4+0lcwiurf
	 7vkkVZT6nZ1gvOwRosNp9uRagEXxis3LiDBVutemgWlgznohCc0gQBaJXK8lqWrsRcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvvBg2x7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6060A2623
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvvBg2x7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06EC1F008A6;
	Tue, 10 Nov 2026 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319909;
	bh=d0ZOTteN1CPlOiy2YAr5oW6dGe3Ubh3qGAuvWmq2ABo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvvBg2x7g895j6eThu72y7e/B/mgxYnJtbzzsT//YoOKT1rp6O0c9Lji9R2T9uGGS
	 glYUHAgCtbGd9QeaO8hfMLDm0uSz7IfhHJoAX6iaNYFBO7Mx3qPy6BiQZOhWIbNWX9
	 l2Iceswg5QzJbDjgI/9qsw2EUzEJLKLySrNxN9eroS87UCObuukYTBPWLXA0TsEUFj
	 3tPE3NPqFvNoNmxqc0Qgjyw0ShsWdr8kkOOu5gSRaQfdKyXr7cFO24rOlAMU3DXrDN
	 33hsgsO6FBxgR9VXqsVpZSErDRjLMhIe70vFVf09VRKYwVY0KrjtuLYD9NvjoWzSTg
	 n7y6Ve5sVTVow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
Date: Tue, 10 Nov 2026 09:11:45 -0500
Message-ID: <20261110141054.1839848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141054.1839848-1-sashal@kernel.org>
References: <20261107061653-failed-5.10-b296be1dc008@kernel.org>
 <20261110141054.1839848-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

[ Upstream commit b296be1dc008fe3a536341afae01f66bb302e67f ]

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://patch.msgid.link/20260903-wcd-dma-v2-1-189cff560a28@ixit.cz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index d725e7fca392b..6c17340ad3360 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -214,6 +215,11 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set DMA mask\n");
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
-- 
2.53.0

