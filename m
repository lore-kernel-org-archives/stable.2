Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE756C621
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966435; cv=none; b=DWGBb5XpfZWw5oTer4vamRqsfxX0d5ZywFQxuSIbc6LA8y3JwzSNtQenA5VSOQrJkW127fD7I2XBfSr0nlJ0lmtwsGP50ci+AYB4TgJaE/xKFxty0GhYwdy+c8h5b+NfzG5y150AUC9iMe9304OyyIuFViAYN/gqljHe3J1VhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966435; c=relaxed/simple;
	bh=Z2au/zKMsNaHmguNeaqh+iFtHuoMEhLideBKGSi0+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNEvkOpfeQPnYkV7CWT2jWQC5CDXhWsnAOZmlIs2vwrWDMA6+34KyO1ECYc6a3gae89SyfarKRcM8IT7pEINWe8phTvGmiOGY8oMgUdjMDTCGhbIyuiFh9PlaaX76CmohFwbhNuAdLRpeinhBSq60JoqtmdCCGPx1vaCYle6xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peBvJebl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peBvJebl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-871c8a36fe3so67746277b3.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966432; x=1789571232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bL+hQaKHbTQh2MApIdEHF5AP7KIOzy8y9uYEIbPJE4=;
        b=peBvJebl0rb3bjqoBZ1FH1L0iwy4UIG2/vcPDfbQ5Ni2GtO0WWDLwqHlt7Vbor8dMm
         4Ba/JylNbxjHSMzHjxFXQYHv5LPTn1rH8FOr2qO1FsoEQtYHOTvhtK9WNfdmIjJRFNw3
         aioKXndWrJCkani+4L5XZ3c54XrhZkyTKUgeTcr1zdtAd+ntAeproiluRm7eTHIBJQYq
         UCAJE+B7L/kUgOrDHyJub4IAGpd2LSyUfy9vSg+wekfOkb0gWMsDyfyrR1sZVYZ/bFvj
         HsTgPdSz/WQmwMw1xFinuZc7ydhRBgu+OYCGsno7e75mjsHkWfsPMJAR7SZ7yPB33pxo
         Ba0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966432; x=1789571232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bL+hQaKHbTQh2MApIdEHF5AP7KIOzy8y9uYEIbPJE4=;
        b=PAmX+Si9S9NpRuMwTv/r0qBwFGHcZg007Q3JJcIkS6SLUzONBVwsCUiF/IuHmux3K9
         wvOQeTU+8Aa7yE5TG6ghQkMv2OzVQa5jQFHsMA0tNenbWI6bSe5zy7pes311Cxv+jnAq
         RD944rjZ9YCUpkTAML3NKYiJNY9dtHox4wTbC2tiDbHNGSjABsrrgr3VY9xQBMs7o57h
         wHVUzmTGeLthf8XJSFWMm+o4bsdWBsffkqRBnXvAF5PX01mFzuN7aLWyb+Okz9ckCTUz
         Hdg5eMJB/n6kGhfjec7e6mgQuMh9KJRIJNzYQ52GXN7/MbYZvrdi/uiPCWIUXu7wFDnP
         ketg==
X-Forwarded-Encrypted: i=1; AKwUvByyEjQmlWE37XBoVQa6x1u6XRcF+Id7dNOvzQNrIoTJtj+Lt2E49GIsFn2AuH9uPdHjklnj+qo=@vger.kernel.org
X-Gm-Message-State: AFuF++mNgQTa4hfgPen1Wiyb/pd7mfCO8jxrNMVP0bEhauFuEf/A//Zz
	wV/WjqZcmFTJZtE1dJfmttivPAtm6IpysWgL7x3/VDskeRwxbD29JLu/
X-Gm-Gg: AYBFou3PIlNP3cmhpNqxLvVI7qTGY+lVRt1ALnuS99Y/C0Ncyht56g8KZzZ4izesexR
	jYiPUgYz3Hyg4La5pn2DuAPkE4KpNnaSnWESpvzEOEHPrpZYOJYxf3RIekaYBoAgu7kn9a3G+E/
	cKNC6LkKgFxe3bSyjGQJsbWuvO5/Qgtf7dOzgenHX7aHnO9cOqCO+dhpECv84b0/6wSn/RpLePi
	TtEMOEUpRe6TGG+MjYwncveM0SRj+3EM9QcIdWGH2wEUxATcJGtC4oP8C6ot9hB33CJn5hcLpW2
	1/Bke/EH4h8ZVm7yjc19o//ui5ck1eGDo77taf+aW3joFVEEzCNSJ3HysDpniybCXYS/pU6YBTF
	GSZuaaMOGqhtwAXg8y4k24Dop1NKu9sTW1SJyAN/d8M9TxoGgNKmNyV8vx1QT9y1J3UPCLjQnOY
	DLPFUOzt5+8H8bpc7H/bXqmgPQfjIVj9PSS85wsdSpF61T6fnKbsk0nb01NFb7cb7rV2wPjpuA
X-Received: by 2002:a05:690c:c00f:b0:833:f9bd:b289 with SMTP id 00721157ae682-8712c90aaf9mr108547867b3.31.1788966431841;
        Wed, 09 Sep 2026 08:07:11 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:e46d:9e65:1b2a:35eb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054207c16sm141409421cf.28.2026.09.09.08.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:07:11 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+2a3de29133b40e8f69f3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] media: as102: initialize mutexes before registering frontend
Date: Wed,  9 Sep 2026 12:06:44 -0300
Message-ID: <20260909150644.232424-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus adapter mutex and the stream mutex are initialized after the
frontend has been registered, but the frontend's stream control
callback as102_stream_ctrl() takes the bus adapter mutex, which can be
used before it is initialized:

	INFO: trying to register non-static key.
	...
	as102_stream_ctrl+0x27/0xc0 drivers/media/usb/as102/as102_drv.c:259
	dvb_frontend_open+0x7eb/0x1410 drivers/media/dvb-core/dvb_frontend.c:2825

Initialize the mutexes before registering the adapter and frontend.

Fixes: 41b44e041811 ("[media] staging: as102: Initial import from Abilis")
Reported-by: syzbot+2a3de29133b40e8f69f3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=2a3de29133b40e8f69f3
Tested-by: syzbot+2a3de29133b40e8f69f3@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes since v1:
		- Succesfully passed available repo. Added Tested-by tag.
Changes since v2:
		- Reorder commit tags to fix warning.

 drivers/media/usb/as102/as102_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/as102/as102_drv.c b/drivers/media/usb/as102/as102_drv.c
index 6b1d3528a0a7..a6dd675689f5 100644
--- a/drivers/media/usb/as102/as102_drv.c
+++ b/drivers/media/usb/as102/as102_drv.c
@@ -287,6 +287,12 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 	struct device *dev = &as102_dev->bus_adap.usb_dev->dev;
 	int ret;
 
+	/* init bus mutex for token locking */
+	mutex_init(&as102_dev->bus_adap.lock);
+
+	/* init start / stop stream mutex */
+	mutex_init(&as102_dev->sem);
+
 	ret = dvb_register_adapter(&as102_dev->dvb_adap,
 			   as102_dev->name, THIS_MODULE,
 			   dev, adapter_nr);
@@ -341,12 +347,6 @@ int as102_dvb_register(struct as102_dev_t *as102_dev)
 		goto efereg;
 	}
 
-	/* init bus mutex for token locking */
-	mutex_init(&as102_dev->bus_adap.lock);
-
-	/* init start / stop stream mutex */
-	mutex_init(&as102_dev->sem);
-
 	/*
 	 * try to load as102 firmware. If firmware upload failed, we'll be
 	 * able to upload it later.
-- 
2.51.0

