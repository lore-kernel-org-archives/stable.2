Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701725;
	b=hPvBOx2pVaqPOCOVp5bpgGgIW+a0filjPiyK0QBhnuddVYAV1opv2Ta7ryPHdlFNmaQ3
	 ZFuoPmVhT7k1dZ/CDPe1WSL1MB9y2z8nfXFLIFuvAy85ggT/LASPoiiK696JZqz6th6g4
	 vvgmk4s9FX3RjEIbh/xcqchl7h2D1S0Rf+mUCCtO7UJZk3SuJ3IePPWkiugJmLq9zEm6E
	 kJmgOJjSdfGAasDPVMkEpiRO4OlnC5ADwadtC5ZhXsGPxkTvEg3vj4XifJXH42z4I/7Nz
	 PsX3AibcnKKro8vzGV95O7qAll0ffi9btj0lHMyknZ56lKN4HC0uVsD610Uxc4iFkVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701725;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=TmwjRRGkhnVnWcZ/zamrvsicPht4ljwppqlZ4OCe+QM=;
	b=lezAXHEwd9fiAuVHzKZh9lRSXDuH8dg5Y5/3p3I9HAmEM1ohamNfx6QJtJt2Y1scUbES
	 FgobJ38MOlcnMsaxIX4lvAkGN2L9mmp8ypbx/E/329jd+vGOewVV2C+B4Axl30SIxiC+y
	 fRX2tRGjhgnMHlc+ndbmCK4wSbp59bt3WULZvjz7I0nGbDk7llhqTmMFJGHTwloLDqZxt
	 ZBO3vDmmgLbmkENonnbKtNd8NLF6gHMHlyRfwVYMSRHtxQPBXrzryd5fgzrflA2dyhjDG
	 he0IJqw6argoMH9mlsDJiYb/Ba3AmSq+yiPTqLgT3v4FMLwqKySlAIwUT5PVYN4LMtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB7606A828;
	Tue,  3 Nov 2026 10:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCB7606A828
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHWJlZt+lqZ6k7AA--.3118S2;
	Tue, 03 Nov 2026 18:28:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: cec: extron: release the v4l2 device on disconnect
Date: Tue,  3 Nov 2026 10:28:50 +0000
Message-Id: <20261103102850.1340434-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowABHWJlZt+lqZ6k7AA--.3118S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur45uFy3Aw1fCF4kKryrXrb_yoW8GFWkpF
	Z5Ka4DKryFkrs0gw4kta1kXF15Zrs7XrW8ury3Wa1vkrZ8JF1xGFWvy34qga1UAFWkXF98
	J3Z8tFWxWFs5CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUFzVbDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIByAwAAs2

extron_connect() registers a v4l2 device, which takes a reference on
the underlying serio device. extron_disconnect() never unregisters it,
so the reference is never dropped. The extron structure allocated in
extron_connect() is not freed either.

Unregister the v4l2 device and free the structure at the end of
extron_disconnect(), mirroring the error path in extron_connect().

Fixes: 056f2821b631 ("media: cec: extron-da-hd-4k-plus: add the Extron DA HD 4K Plus CEC driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
index 1f8ed7ff31e5..724709606a0b 100644
--- a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
+++ b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
@@ -1403,6 +1403,8 @@ static void extron_disconnect(struct serio *serio)
 	extron->serio = NULL;
 	serio_set_drvdata(serio, NULL);
 	serio_close(serio);
+	v4l2_device_unregister(&extron->v4l2_dev);
+	kfree(extron);
 }
 
 static int extron_setup(struct extron *extron)
-- 
2.34.1

