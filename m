Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567905;
	b=MV1tw0SrUPtd9YPl0x7sWMJB2g0ocplofNJpQhxsnzeB83qRGVW0y/MdAvlAR0z+66zH
	 i8PtxyOfEDP7Pab1KQu+h8Vglh2cWVio69CogBg2SA7cx8RoVw48RDSqfVZZZTstvfgF+
	 Lm5JJ0cGHXlNfEdUeDHspgGHLU5pClass5OUYI6HlVKAeXWB4J4ore+IJIwhVoSLYoNa2
	 KlBze20Y+qdjPImPFK5QmlRJRckVJ6iRcWfo27HdjKIRctkcJrSfFxVjrUapQBeb6IHob
	 vUgBFR/tVQpW8kHNLWalFKG2sTQKAqejFo2e3BTIo69Ddcs+Uyl9a3AvM9qe9FBuN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k5kTzIC/xwbiOBwUmgidJlrRFiWrIZutr9d7t0kBwUc=;
	b=OZn+nr715tBDc9YRrkFjMw0OdpSc5lBrBqcSBbJCBIS+X9RD4UwkjyuqoOExA113ELao
	 MK9MKKCYbDx6sE7ll9Z37HawoADYv3WNh3vGu0BxO1Ggl2dI8349n71PmI8Fqy9nqshhj
	 K0dkUtSXwjlzknUWcKeHd2/hOroCzpeJsqz1uHCtDGwB6Ogf92+g+N8GRztbhwGx5T9JF
	 nyrriZg12jNHADo7WEqxvzuIoJR9YCEt4+NzmY+94WkMFubEJvdfZquAci9j+lkuMoGrc
	 MbaP5+2U2p8Vws5ZkF69pRZIozmR0QtXOtfJHVSpuKFHvbT35H5vpCCeYsXHx0Brqkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoJksLH7;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334E606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3334E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoJksLH7
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so11525095e9.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567903; x=1795172703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5kTzIC/xwbiOBwUmgidJlrRFiWrIZutr9d7t0kBwUc=;
        b=yoJksLH72T5ruQc9lM2z7lpJklpea7vOdB6SjdBgssV4CRuR5mmYwzAnslnXJxggVE
         eO1zLkISX5gyNaCAFFr+xs4iAgnbAo4Pf0s1HM1Ol1bFozWQKxTgQ15MxQ9CyzMTUAsH
         +j5PWuK4FXbEtLmwreFPOLKewDQrretJrs8fRfDHatnKrfp8s7SGPPYfvOT53W5ABogB
         RF83NQ5NNuGOljgCY61gxaQn9hfzMJJd8qIChgBBU3SFsSidocbM87ELh6BabMF5E9xC
         E00DhZWPGHEDt2kf/1euUlWCA3Zs7+iiGvt7iARNdjpGUZv20de1dJFYpzTgtXfT4Zw5
         BBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567903; x=1795172703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5kTzIC/xwbiOBwUmgidJlrRFiWrIZutr9d7t0kBwUc=;
        b=jPHqAMuq/+NfWtAL8068tMcxtihmOuAHTo3kLGFXlztXTMZesv1edDvlbracEGn0Vg
         lPKlANSXctrtR46hrXCj41POEmK8SqAJkG7yk54a2YM+Oy2pbxIYn1bcjQshbxHM+Xuq
         T20kgQepf3xet1T6NHcInfwj4dUFu46ZAilTeqX1iRUXwdhsaJP/hgpBr0rgxhdt0u3H
         W02stJEs8zOb64RAi9PDE38p/dlSLVTxt47X0gm4MFZSLxDGkThRIvBN4Xk4IvfHVCa5
         ONdBiS7sKlS4IfNN/DoxZarhUcIuOJbzesNj82A8SBlYPKvPZzAQ1lTUzRxb46JJZdB1
         s+ug==
X-Forwarded-Encrypted: i=1; AL+hErG1Slg4XrK4PClSkAlinIh0CHXdamt55kKTX6fDU8npdokQCZxtMQCnO38IdOqYobXXr5x5pyQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wz7WVp8jfnkhh/jfHaUgqCeP0yTrUrz6D2ojs/ajC66Qpi4m3
	f1wV8/wB1qSPjDJ430ymdJ4yL/dWtv3A0vv2rlGtB8lazAueqvJkjfgS
X-Gm-Gg: AYBFou3Ng7hzxkY1roC6jHYzf7UsMvkjvx01ZgpTwVTiog+IaJP4TZ1Xlrrj87OrT9W
	3YA15ociAOHVDUJ8K0NMuCox9r8zGg339S89s8oFhUk0NJJSEAKTXc3lk0NDrhfSlYY6yW4jLzn
	ikfZVslV6icDxB/awb0wHmqN1RJUxM/kzFy8M4F2gglJD82pWKie0MezHKU84NRdw5I8p0zIc/v
	y7RMBOahbQsshhHLNoiQvjVjrYZqRu3VDemNV/Ue+7N71ZAjQlQZSJGg3fnhz1cs6zdbHG5esYU
	WlPposkvRZZIGs3WQXcVfq3ALrAc/M2QAAzUK9xDvMqB1K5GN89iDVsO5P+uD/PXPX04IzM1NfW
	45udyy117VvhBboe61nkfE4B/mM1uuHpr1WrgTj2ayMUFFCsTMtWlaUkeYMs1AohOK/zKGaXXfa
	CiQn/kAtxWFpOYy83gcJN/LiUAmj94scFXIU7k1UQWfcvmmeC+uCnfWbcyxUz2fGRguu+nfJOPU
	wOshawlDRqz1mpvSsJccCTQAOzDfrQJdGmbUXbIWqvMJ3Dnwhs00ZCnGUs5KyaRfW3nFLTT4YAH
	aM5NI4lVkX1Vb7NM903Dt71KOYpSaBLksGQ=
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr43197405e9.1.1794567903271;
        Fri, 13 Nov 2026 03:05:03 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55afb6absm57515955e9.15.2026.11.13.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:02 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx: test the block read flag of the message that is read
Date: Fri, 13 Nov 2026 12:05:01 +0100
Message-ID: <20261113110501.1142036-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

i2c_imx_xfer_common() decides between the DMA and the interrupt driven
read with I2C_M_RECV_LEN of the first message of the transfer instead of
the message at hand. A block read of DMA_THRESHOLD bytes or more that
follows another message is therefore done with DMA, which reads the
initial length and does not look at the count byte.

Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Reported by the Sashiko review of another i2c-imx patch:
https://sashiko.dev/#/bug/linux-f62df5ed-ad96-43f2-872a-ae2c0100b73f

Tested on a Colibri VF50 (i2c0 with DMA) with a v6.12.117 kernel that
carries the i2c-imx changes of v6.13 and later as backports; on this
base compile tested only. An I2C_RDWR transfer of a one byte write
followed by a read with I2C_M_RECV_LEN and an initial length of 16:
without the patch 16 bytes are read and the count byte is taken as data,
with it the count byte is evaluated (here -EPROTO, the device answers
with 0x25).

The line is from v6.13, the patch applies to 6.18.y and 7.3.y.

 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..9abe0a26c877 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1713,7 +1713,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			msgs[i].flags & I2C_M_DMA_SAFE &&
 			!(msgs[i].flags & I2C_M_NOSTART);
 		if (msgs[i].flags & I2C_M_RD) {
-			int block_data = msgs->flags & I2C_M_RECV_LEN;
+			int block_data = msgs[i].flags & I2C_M_RECV_LEN;
 
 			if (atomic)
 				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);

base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

