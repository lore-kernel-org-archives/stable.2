Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699178;
	b=2+YDIzXEJrzB4K+BiKkPVS6bOZLjUyT9pUErnMTxN9lrem+Raj+bcJrBSiXrtlwk0DrL
	 EE+K7/Mcm2jKBLcC2FpcpTs/DYXfuzVoKwkHtFHeXo1NugxM18yUM5qBLVtcKUM0f/jM8
	 o1QVBtNhFuM/FS9aZ+j52R/GeIkht3ZE93GCWyLk0T+d8U/Tp29sqaxfVIGt2mEKjiDDA
	 7XkWM2agXtRLmf9CEcY3OWBSgr4ZH/aitXKN2Ip/IiBn6xC4O82nZNh2atKO52wZm5WNk
	 LLKTh2kGSIJ/F5t5lOcQT6vLa3ogqqDslFT0Trdtd9nRjnv0aLxHLzCLBRuVipBvU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699178;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=PSSWxOObJQRUdiSiA27fJeWB5/M5WSxNOiKsb3DWVQA=;
	b=vuGkeBxMOxASsdDi/qJLzxTjsiVK1PeuwpRZAir5wu+g813YF2TN011DTEuDQtx3uwFw
	 Trbsw4JI6qkh08zXJ5v9W2zI8LVRY0NBvpF/jA+lQo6BqiJFidQDut/KsVwRV13OIBWGI
	 cOyMzzxdH5JfkLobuPbxbCWFNjKoC4M8NunMosqOhbFU6PQQg9LE62ddAjnNf7873xT4P
	 SaEX75Pq/6R8hyHzujYJVnQF8kOnGfbh+O4gL2i35OJOlo1aQTvcrYMU17cm/X5CMN93V
	 uPJdSNsFX0XDFs99RPLeJZio/bHvPZ0TZK9PKlBXubLKCWv3ZSICAZRqHTnQOaUZHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972F606A326;
	Tue,  3 Nov 2026 09:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3972F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpNnrelqJ087AA--.2718S2;
	Tue, 03 Nov 2026 17:46:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael Krufky <mkrufky@linuxtv.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: cxusb: fix URB leak on start-streaming error
Date: Tue,  3 Nov 2026 09:46:24 +0000
Message-Id: <20261103094624.1289527-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpNnrelqJ087AA--.2718S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kXr4xJF17GF1xXFyfXrb_yoW8Xw1xp3
	ySqrWFyr9xJryxXFyUGw1YqF93A397t345KrZFgw1fZr45Kw1xWFW0k3Wvqr4vkrWkZFyj
	qrn093srGw1Y9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrv
	38UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEAA2rpnO5ORAAAs+

When the allocation of a stream buffer fails while fewer than two URBs
have been allocated, the error path jumps to ret_freeab.  That label
only releases the shared auxiliary buffer, so the URBs and their
transfer buffers already stored in cxdev->streamurbs[] are left behind.

At least one URB can be allocated on this path, and vb2 does not call
stop_streaming after start_streaming fails, so nothing else releases
them.

Jump to ret_freeu instead, which frees the URBs before releasing the
auxiliary buffer.  It is also safe when no URB has been allocated yet.

Fixes: e478d4054054 ("media: cxusb: add analog mode support for Medion MD95700")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/usb/dvb-usb/cxusb-analog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index 8c7d0888c721..648f947e8cce 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -822,7 +822,7 @@ static int cxusb_medion_v_start_streaming(struct vb2_queue *q,
 		if (!streambuf) {
 			if (i < 2) {
 				ret = -ENOMEM;
-				goto ret_freeab;
+				goto ret_freeu;
 			}
 			break;
 		}
@@ -879,8 +879,6 @@ static int cxusb_medion_v_start_streaming(struct vb2_queue *q,
 
 ret_freeu:
 	cxusb_medion_urbs_free(cxdev);
-
-ret_freeab:
 	vfree(cxdev->auxbuf.buf);
 
 ret_unstream_md:
-- 
2.34.1

