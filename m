Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694765;
	b=na6oW+/6XipIrqHSl/45W4arRUK7HpSVi8ALYq8sw15ZzSe9CfSUvvYNB7BE7lg1wVOk
	 Ne2FtAWKiSnP7wPlrOcDScZe7oEvZ8LjJGFpERDJ26vJMyEpyA9jEccbVgJCfmXcoFxTg
	 RpClrfIMFkRwPDXxw+9Zvygdw+67GtK2TV87IVJa5+iD8IcQ+crd20j6kDdZZJVrFJcLg
	 SqNYtrsjNeUrW340AnYN30v6xSVyvFVqm1UlsK20vVzpIhKMElPQY/Y90pR2Jp9vDNIyg
	 XsiiC0+sv+eQHWjUplqRwa0CRtzyMRNOzMUPagVb5Mj7/XTiG1lyP0v9n2OdCYANQ5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694765;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=K09UXt1IJ/4Cor9+NZsyvuf9j/o9nZ1JNa0XlXYp/uI=;
	b=sgJR+UItiRREl7674SzNuA9c2DbB44p77Q0kEY/jO4WYhAcz/1Ptryzdyh6FKynS/7pU
	 3KYoKBRy+w1n9PsfQINcnuGadmYwslOPFLeYt7yy0f+6P1tXFDdV5oq9H2gKUkGq3itAT
	 x07Al690VjLasjpxDc4mRL4JIzytE0n9JVtWJvf9evhSnaZecXBj084kgaUNGbdgOIZNW
	 dHlQ3c03RscSl7hGwrv/w80AX/LieMYg0U3VAzD0SRUzFZKeAahHAlLxhSpsKDiA3NoMg
	 uyjBzv/cXbpU4iT2bv4IgZg4DDXN1eqz8aN99nNddyRdP1HP4YPIwGb2h3GCWkvBRTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62670606EE8E;
	Tue,  3 Nov 2026 08:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62670606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5gpnOlqCHs6AA--.47806S2;
	Tue, 03 Nov 2026 16:32:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: nas.chung@chipsnmedia.com,
	jackson.lee@chipsnmedia.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: chips-media: wave5: Release m2m devices if video registration fails
Date: Tue,  3 Nov 2026 08:32:50 +0000
Message-Id: <20261103083250.1174880-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAAnN5gpnOlqCHs6AA--.47806S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryrCFyxZr13Xr1DZr43KFg_yoW8KFy5pr
	yIga97Ary5Kr4qqw4UJa18Cas5Jw1SvFW8ur4xZa4Ik395Xr4jvrWjqa45GFyDJrZ2yas0
	vr4jq3y8Cr47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUMGQ
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpWfX+KAAAsh

The encoder and decoder registration helpers allocate a v4l2_m2m_dev
before registering their video device. When video_register_device()
fails, both helpers return without releasing the m2m device. The probe
error path only unregisters codecs that were successfully registered,
so it does not call the failing codec's unregister helper either.

Release the m2m device before returning the registration error and clear
its pointer. This balances v4l2_m2m_init() for both codecs without
unregistering a video device whose registration failed.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 ++++-
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 86bc36ee17fd..929ad9cfb674 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -2051,8 +2051,11 @@ int wave5_vpu_dec_register_device(struct vpu_device *dev)
 	vdev_dec->lock = &dev->dev_lock;
 
 	ret = video_register_device(vdev_dec, VFL_TYPE_VIDEO, -1);
-	if (ret)
+	if (ret) {
+		v4l2_m2m_release(dev->v4l2_m2m_dec_dev);
+		dev->v4l2_m2m_dec_dev = NULL;
 		return ret;
+	}
 
 	video_set_drvdata(vdev_dec, dev);
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f9fcdf4c224b..6577028201ae 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1854,8 +1854,11 @@ int wave5_vpu_enc_register_device(struct vpu_device *dev)
 	vdev_enc->lock = &dev->dev_lock;
 
 	ret = video_register_device(vdev_enc, VFL_TYPE_VIDEO, -1);
-	if (ret)
+	if (ret) {
+		v4l2_m2m_release(dev->v4l2_m2m_enc_dev);
+		dev->v4l2_m2m_enc_dev = NULL;
 		return ret;
+	}
 
 	video_set_drvdata(vdev_enc, dev);
 
-- 
2.34.1

