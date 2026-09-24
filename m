Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B536604B
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258123; cv=none; b=TpOBPeL2SqSSu2hsG4TKX/vB6AAXImjIJoJDG54ezx2Srl6m7hVfitwvnXsVA8zkcnBQer5eu8ElKUGmLI5WdPwiRdwYmUH+qNJci2z8STll5FtTP+5FzlDuN5otsIilZL8ssKqYCZJBo75Ye/y2tFPMxKT4vSoL3ueLaKglfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258123; c=relaxed/simple;
	bh=s6cINfwztF9EqCNc4OvkEGGx75tkWC5jloCuZo0HzQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bABOjymkAqzSq1D9tJSg4uJIOVQ4ss4HnR8qWa8PtOPuSGz+wak7cGhdNMAL0QafhbvRec1DUoyBxwAS2PKaqRXXSiN6Is1l9+0oEUD43NvZxWHemoi5qbP8WqA3l29nZK1zckdET681+jr7mXqFrJkrBNe2OBCfZ+oPWbUnvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS1m1dKH; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS1m1dKH"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34907so1707872b3a.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258121; x=1790862921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ap/7M2cse4mK1asKMRK4GIwJ7czLUQIQNBlufYytSs0=;
        b=QS1m1dKHIeMBKxwEMktYMNSiN1xFoHsOLmRpARS9ZEjDXg80+rHprXL+Y3apGVYgcx
         ZgzHZcxPdfVBMMzjY/poO1uBzo8Fpw7RpqrN0sMdRRKtZHERbNGKkABOkgwdysT4NAmU
         QjkUZnDG63kvEUk7HX865v3uwF54WfvkTj+e8/5B9wpUNmToaF1rwJqeRoy3h9PeAq5O
         m80wNVn+zrnn7cgwXQ3BB6K+8UmZah0hajWmrBTmNf5adiziWm0ARLiKlpB1iKyquCvn
         Eiig3fR4T+8z98fJdadNp6X8WM3pWZ9bYd/Eri4DpcghFlJPvpTUddukGugIHL965mwh
         uhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258121; x=1790862921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ap/7M2cse4mK1asKMRK4GIwJ7czLUQIQNBlufYytSs0=;
        b=PWPEpKVdC4VdkZTCa7bT2ENaY149UKYMqkI7TCASPsLY+v/TM6S4ro5LeFR3KS5pYE
         bULWjYOZ8GwpUHumEANFTUM+rpiBud/MgADY33ch8Ea/AAN+SzWAkoi/4G46QN+0Fgod
         J3cObt44UwfFcMXmBzUC4l4ZQ5L7PB8g4BV9Vll6gFNA+PD6oBaXLUmQvHe9RLtkRGbx
         XROuWYTJe2humMj/Jg/DBCbWnJAY9WublgNdgxyIYIYPnLIjTqc4C0PJ8falprpk5a3o
         a/+dM3TtsdI9/EyNV6l65X234u+Ab4JPGCFgUqkXa9lzfjIkXKtd/DauUg2wnSpgHCEg
         ac0Q==
X-Gm-Message-State: AFuF++nH9XF5xNj/NB0uAfIVVfZW7tMiuwujeH5Yesx4MaQkOwlOptgl
	VRA/snLiraZvT7UKRESGta3pBM72ZXO0huV8y93psJnoV/PyVvnUtRJl
X-Gm-Gg: AYBFou1CEW4wjKVyn98VxpCM3quWlajSGGAzlES8EaLSZD+oe+DgPngFmVSAuVUdwkP
	aSAbd28NgsF0Z+tauaSLaFyjAPadANkZV0jI3ScVkXqC8A/3lwhvCIN2P3vOWd+9aXibJ2n37HW
	zL2SqqwLBhEPGCtoYnCIlxVMP3oNP1UUCj56ifGMgSTLqjM+0rvUCsm4du3wSz7MduLEUbRxA7j
	fFTEO30I6NkL1HWqmB7VAjCAd3TjTZUnRxN2tYMsh/cv9PwnRNse8DTMR7laltPDovzEDCL+U1i
	MA14pz0+ftutAjpNdRcYdLEZ4f1ENCOcpbVWz3G1d9Rjf5NMaFgP43+pp1IOZlCYRGzkfoEjz/D
	+3vSEI8XXllezDiWZTYTd6MwQ5gn2hinGxF6yLRMXWfuUE9m4CmeaW929QwZN9y5LvHdeB6Lbv5
	oFqev9hm3IiCP9NSe7kWVltJHI/coyk5c2f0nkg8RdmrQNFXqYB1kH4Q==
X-Received: by 2002:a05:6a20:e211:b0:3dd:85a9:55a7 with SMTP id adf61e73a8af0-3de0e8b0694mr2789651637.32.1790258121006;
        Thu, 24 Sep 2026 06:55:21 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f5e79sm2684937a12.25.2026.09.24.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:55:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Antti Palosaari <crope@iki.fi>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] media: rtl28xxu: fix SDR platform device leak
Date: Thu, 24 Sep 2026 21:55:14 +0800
Message-ID: <20260924135514.1591658-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl2832u_tuner_attach() registers an rtl2832_sdr platform device, but
does not unregister it if no driver is bound. It also does not take a
reference on the bound driver module.

Unregister the platform device when no driver is bound or the module
reference cannot be acquired. Drop the module reference in
rtl28xxu_tuner_detach() before unregistering the device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: a2f7f220df5e ("[media] rtl28xxu: switch SDR module to platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Add the missing try_module_get()/module_put() pair for the SDR driver
    module, as suggested by Hans Verkuil.

 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 487c6ab784ab..d2957e4bf017 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -1391,8 +1391,16 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
 						     "rtl2832_sdr",
 						     PLATFORM_DEVID_AUTO,
 						     &pdata, sizeof(pdata));
-		if (IS_ERR(pdev) || pdev->dev.driver == NULL)
+		if (IS_ERR(pdev))
 			break;
+		if (!pdev->dev.driver) {
+			platform_device_unregister(pdev);
+			break;
+		}
+		if (!try_module_get(pdev->dev.driver->owner)) {
+			platform_device_unregister(pdev);
+			break;
+		}
 		dev->platform_device_sdr = pdev;
 		break;
 	default:
@@ -1426,8 +1434,10 @@ static int rtl28xxu_tuner_detach(struct dvb_usb_adapter *adap)
 
 	/* remove platform SDR */
 	pdev = dev->platform_device_sdr;
-	if (pdev)
+	if (pdev) {
+		module_put(pdev->dev.driver->owner);
 		platform_device_unregister(pdev);
+	}
 
 	/* remove I2C tuner */
 	client = dev->i2c_client_tuner;
-- 
2.43.0

