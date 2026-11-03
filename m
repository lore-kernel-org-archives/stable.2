Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694311;
	b=jg/eXHXDxniSx1v799ypOUkZTQ7/RFyciHbzAKZqdygvNMrpPekLKZmsRyaMN0QUP6aW
	 INGh0YjoD16vqhdEXk9fozeGs7RNRdMAvC5V/+SghYTzxi2a3mfGtDC5JQuFH4/YVQd+d
	 JByqUQcLroO64DiV5hXusUrnbKQyR2ol5xmKattIAkJYb1xD1NdK3CO9iVHxetXL/DS6z
	 sF2yI00TtwUtBUTDLPuQ2XO1l9umstGTb0BiB2/XM2fe0tTDO1Xlg+uw4QZCsGrudAbrn
	 0KjzaB4Gc5UoG2HMgtT0Jj+8yUjdViOqAttxe60fljmI76bohtj3P3qPEw35Dhm6Rbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694311;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=AZrGsL7Z7FxxSc4wLTOVw0JSZcYB9+OQkUBgWRbKyRM=;
	b=gdhId0bqAqWWLflsSU8RcKR4/PpToVsurHqX9ir3X2azOCYCRc/MWiE52pZzfhl3Bu57
	 EcrhpMRCSPnC/ZBrKJsEHyXumtDaY1OatBehTaPw9x3ywZ0kjDcSaI3VKZ6zNWN3A7TLJ
	 E2QttTV46LeAufg74ucSQtcZUsuE1kIbXrcME7uGbghaMJf+0Lvnuu1LfTcmKV+iRqGpT
	 ik1EeZS9w6UIHK9Q7oVv7l+P0+67EpHNvvi7BHAfJWfMRbd9hKfV3GWMhRACvXb5gQKaQ
	 DKBp1xgEWHFNTTUEKVLaJQrXJ3b1HeHa3RAbdCjIt5PiHe6g4GArMpCDtxy7Nhi6HMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B863606A332;
	Tue,  3 Nov 2026 08:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B863606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5hgmulqiGg6AA--.47740S2;
	Tue, 03 Nov 2026 16:25:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vladimir.zapolskiy@linaro.org,
	sakari.ailus@linux.intel.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: og0ve1b: Free controls when control creation fails
Date: Tue,  3 Nov 2026 08:25:13 +0000
Message-Id: <20261103082513.1162639-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5hgmulqiGg6AA--.47740S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8GF4xXFWrAry3uryrtFb_yoW8Gr4kpr
	WkWasFkryDGF4Iga1DJryj9a4aka4fGFWUKa9Fqw1xZw15XFWrKr1fKay5CFWDGrs7Zaya
	qr40qry7CF1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAAA2rpWwryFgABs4

If a control cannot be created, og0ve1b_init_controls() returns the
handler error directly, skipping the cleanup used by its later failures.
The probe caller then powers the sensor off without freeing the control
handler, leaking controls that were successfully created before the
failure and the handler's allocation.

Save the error and use the existing handler cleanup path. Preserve the
original error before v4l2_ctrl_handler_free() resets the handler.

Fixes: 25bf2e1925c9 ("media: i2c: Add OmniVision OG0VE1B camera sensor")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/i2c/og0ve1b.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/og0ve1b.c b/drivers/media/i2c/og0ve1b.c
index e7cd0f72f3e5..78e8675d99dd 100644
--- a/drivers/media/i2c/og0ve1b.c
+++ b/drivers/media/i2c/og0ve1b.c
@@ -665,8 +665,10 @@ static int og0ve1b_init_controls(struct og0ve1b *og0ve1b)
 				     data->num_test_patterns - 1,
 				     0, 0, data->test_pattern_menu);
 
-	if (ctrl_hdlr->error)
-		return ctrl_hdlr->error;
+	if (ctrl_hdlr->error) {
+		ret = ctrl_hdlr->error;
+		goto error_free_hdlr;
+	}
 
 	ret = v4l2_fwnode_device_parse(og0ve1b->dev, &props);
 	if (ret)
-- 
2.34.1

