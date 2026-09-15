Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E747ACC6
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468798; cv=none; b=PnSBCLUfSKWvkGgjCc4bsW3WvCNNlh4QQLEcdOzUnoApQ1Ra9hCKR6+JwdQwtTfUgq1aXT3V5mog+kLf5OblYU7pQdBMU4nVnOtJKgHhvJ1ftFT/0+Vo7oAAbbyw9hIYwZr7UCqKkB7nr/GS9/5E9VZFVa6QgjaVBFMRo3a3uzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468798; c=relaxed/simple;
	bh=tcI931i4u8P1ZSsYrMD8we1x90i3T/XXK/hoYTAcaIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5ecLCudl8gM5Z7HDWH15CwoktJDQ8uGB3XzbARxtQBrgLb41fC7BAuxWxypMGysfHuIlFGPORZo/SycJyNYEJb/nbzupPMDVf9pG2f+7o+qT923iFAkWovylR4QlCRMM9UuceFhhK0oFIVJFfSU0bRYvAKCWloeJUOVGdcH1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpRjl+LS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpRjl+LS"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so2572483a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789468796; x=1790073596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dq59aTjp4HFxyWvEqbSyMP71FWosCOm3vRvqmE7kBIk=;
        b=lpRjl+LSw9SaFhIabK5+7xPhJIRPBRhNhcgD1IE8+GrqQQEsZt0TQhDPvm2tvm3Ext
         crE0CutV0BfxGzqPpnPlCmW5WnluCz6txvyCOWKyim/dk+mtTdt8gxwZgZ/cFLOagXiw
         L+4yWKZ4Yw2LT1tnMRREJ1pZo7BmXfrphLj1oL+fAKAu9EZLAzRJDsIlpstQB/JH+myN
         LC0duOS1hUlpbG4cMiCITf8UW4d0v6NtrOFmXIlpk5binqSohMWsh8vbSnJTGCFUQQPA
         PIvruf79icAM17ncCvCLKrd86F/k+dxu2rtmOg7ez4DSVIQUkCkP0vTfYvz9Rzp2W0df
         0kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468796; x=1790073596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dq59aTjp4HFxyWvEqbSyMP71FWosCOm3vRvqmE7kBIk=;
        b=NTntVjWpFTXK2xADF5MD/AomBEU/rMYskkgPMxi3GlaIFMEviihxKcDoloaxCamKBa
         zovJFm+MPcRvqDRXkWGLzBznXoTmBUuspFjD+tePIkiI2pCdvU04M9JtkYwz1QjVCEaK
         rYKYXhvSG/Hw6kADFgRVbrmNxB4gCqqvoE/pkYXBgZT9qay29fXGMSP8+4Kwrcsc0pUB
         r5vemIl0NtIX8ZnAn+TcoXB4aitmYKryxjj8bZgjvc/0LDaLQ5N28Aj6DrdpQqQjmDf7
         pl2MxaMn29qYij7SZ6xbVJuKPEgdqAJhRAWDnrao+e7EZPc8dY6+Kc+d5+JUimShRG9y
         UlTQ==
X-Gm-Message-State: AFuF++k98y7dKQEKgn6S4Y6Bf4oGrwBGmq/oVRu5c2KhQ62epxVZTIFk
	AW17sJwtWw6c/Qcw64AZf15dtDBotIpUs8gCFnSPvE87lZJ3CCcDgPBL
X-Gm-Gg: AYBFou3JkGVRuzGThSPbG4XFON39umqb6E5Ft1CE15Np3TvK/OItMsjuPSiTP9KJBx0
	G0cf5KK7uTl12p+zv5LxPdlsb08nPyM01T/ZIuGQ7GxIfoLf4GPcCvW0M69kbAePO+6PxdVm82v
	mW5OXxwSmIe2r4kNFv7cK+yefZn43Yrk37AGhMaQ5lY8QMvLK6GE5gWYPaU0M4oTOmclNUeWo3w
	2B8JM/XuQcOsvUpXzc4qIh2U6fRuPDERrLQEbf7vrJ9IEloygQI2snIcBc3JSUZAsMF7QqnVGY1
	3McXoQLLGFxRG15QMMSABIX95lVXl+aBxSJxMZz1S98ROHIZ9wpw0D/uQUR4Cf06DJus2uN2UDN
	yOat6K1Q0VtdABB/FPpFhqIWQ4wzO+o3BGfHIJDAErrtnWLJwDDv1epWRJ0ZCfZShqksxpO3RZc
	NFPWSmGrnAhJWpag3zO7A9N1Lx9Nxj40R1hwD4naa4bT6Oh9H5cpj+4A==
X-Received: by 2002:a17:90b:134e:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-39dec04fa58mr13238735a91.16.1789468795714;
        Tue, 15 Sep 2026 03:39:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfb8b7561sm1924883a91.1.2026.09.15.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:39:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Zhaoyang Yu <2426767509@qq.com>,
	Sean Young <sean@mess.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Igor M. Liplianin" <liplianin@me.by>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: dm1105: unregister GPIO I2C adapter on remove
Date: Tue, 15 Sep 2026 18:39:45 +0800
Message-ID: <20260915103945.2364107-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm1105_probe() registers two I2C adapters, the regular adapter and a
GPIO bit-banged adapter. The probe failure paths unregister both
adapters, but dm1105_remove() only unregisters the regular adapter.

As a result, removing the device leaves the GPIO I2C adapter registered
after the dm1105 device structure containing it is freed. This can
leave the I2C core with references to an adapter whose backing memory
has already been released.

Unregister the GPIO I2C adapter during remove, matching the cleanup
performed by the probe failure paths.

This issue was found by manual code inspection.

Fixes: 0017505de0d28 ("[media] dm1105: GPIO handling added, I2C on GPIO added, LNB control through GPIO reworked")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/pci/dm1105/dm1105.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index ae4544042a74..ae7954cced0c 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1195,6 +1195,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	dvb_dmxdev_release(&dev->dmxdev);
 	dvb_dmx_release(dvbdemux);
 	dvb_unregister_adapter(dvb_adapter);
+	i2c_del_adapter(&dev->i2c_bb_adap);
 	i2c_del_adapter(&dev->i2c_adap);
 
 	dm1105_hw_exit(dev);
-- 
2.43.0

