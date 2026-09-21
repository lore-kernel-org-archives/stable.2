Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD803BB107
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978559; cv=none; b=j/T+4BJzg07rLEZXBNIu/7LKXLAgI0p6PaAbr+IblgM7TtRI5xc+k8m+fza0xjateSUuSbL5Ile1dzmUWl9aOvtwfA2EHZl9oKF4q3/hkZrWFKPl0j0RC2MkLfNXYJPXs9E/xnRRZofXNexRmC8c74CgKRX9AY1ik3l2W9rKcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978559; c=relaxed/simple;
	bh=Iu14+tGkXJ7W6qu9z1nJ7iDbzj9Mz09KrdKxjIeeMZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkmJ3A3JSp7NhWt//BbDMlKD8gXjZ2hCQu2atRIer9S0JHa5+UdVizK4QfNanc9juF5h+Y1YuBmLIzVAroaygIwHEJcqrEzSMYISfwLFl2oOnHbfjcCo/WdVr8einTj3y7Fg4QzX4JguJQncNLhqf2N9E/h3DJkAIy82j7CfSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nulSChML; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nulSChML"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc433d52421so1466452a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789978557; x=1790583357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVJagrft1n8Its2gcvGhHWhNvvTksci+ZknnJFdRNaA=;
        b=nulSChML5xCyH/Zv/zBIsW7fPVHURLRObTmXnBZ3SOFNj/4mwMF5j2EOdFdjOP2MQz
         1YcPG6M3KVoBIerh5Y6uuXxXdfsHsccbw3/J32j3cX/GYqP647XUd5KAvS6gs9Ic23yX
         w8rADnvERupb9dhqs3yu6fum27ByRiaGf2QZYn/dSPuPDIkhiMmL4Qn8PPp8btGo5uLE
         ZeGwETSeQNMNNxbKtiHqlG0t6r4VqZyj32nWiI/1bSIh0wMbZd3mgMibdd04LchMa1fW
         zwCJCXaRA8hTLCM+Vk3myuvLIphueqsHC6ZWx4ZmYV7z5UmvGjnNCUpDO4Fdk/amDuJb
         SO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978557; x=1790583357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVJagrft1n8Its2gcvGhHWhNvvTksci+ZknnJFdRNaA=;
        b=rUhCxgN4nwLSO/5FVet+I0TTrVtMAnFsAk8qBSPPpMm8CLLmmIeB8G7zxYDF1GXuDw
         8LWb3l6UqSuxB1BpRnZdzmF/n/36BMLUM0SPucc3lWEaoQ5Kv45ZpCjs3LV/9xrWy5nT
         lV45HkI7u5GaWoRcWLq5ySWu4V1B16yaKl+1cg66imRzudQ3uEeqXYe2FYZLaj5gr39g
         Dlu2y1ay2HINIwg8PFxwH8A00Ui1yNOTHtSdYBy1+YfVqnnxojxfDOM5N7QL0Og2HsN/
         jFE/An8VkChFGMdQZBxdpuYHYuj7PWNQr/xCYbSIUSTBu3K1Ll/5Ntpc0rhTpUsHOk8Y
         Xd9w==
X-Gm-Message-State: AFuF++n5H24LyjIenIvYwXK4v632mwmu2PwMOYAsH9sO6z6b8a6B67Hj
	BJoJiYkNKpuRY3fuzswEVgt2d8J8uh+O0bSw/5fKKvSmLW+vt7cyYqHhCaYUVCxpu50=
X-Gm-Gg: AYBFou1DexekEXxQg/d9KbIcOF+h9KM/vwKOEx0O/nqIdYyu1E+PtD6ki9ijr/XByx6
	xcYXl8QWDW5G3Y99CJwiNMiv3Yf6P0zWMfp0mkB4u7EFl71DbsjeLiMTrkSkSpCLuB1F4JDlhno
	YWUHfRNArvRAMttM4xkj9Rt2odruZ+s/iOQ9WdzGd1fp/25FTtneVkJSo6UxS8kaJ7FJT81UUQO
	aaO/uEcpRLQl3Cvo+sgPubigWjyvrcCb7wP44UeGTA0lsJeMg4yyxMfCgQC9y7IrCpGabrKxy00
	DUzeEigyDDFggSsdDTOv/Lv+lzKTJSfyt4xyOQ63nTLOPJcLYs/AktJ5nj5cMMPSTjtj+l4BYst
	prFsADFtoLzmEET00YKQffqkKcnK5UX31YSKLcrizC4jLm/ddAY1J2gKgXCYEsNLbjGEP8a6KuG
	o0wMQqHDEn9XPXUlr6Ljukq1pxUwHzqW4JoqokzXW2p5w803d9dcpItA==
X-Received: by 2002:a17:90a:e7c3:b0:39e:261:4e12 with SMTP id 98e67ed59e1d1-39e54eb2281mr15605736a91.23.1789978556544;
        Mon, 21 Sep 2026 01:15:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a04982be8dsm4160673a91.13.2026.09.21.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:15:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Antti Palosaari <crope@iki.fi>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: rtl28xxu: fix SDR platform device leak
Date: Mon, 21 Sep 2026 16:15:42 +0800
Message-ID: <20260921081542.210151-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl2832u_tuner_attach() registers an rtl2832_sdr platform device, but
if registration succeeds without a bound driver, it breaks out without
unregistering the device.

dev->platform_device_sdr is assigned only after a driver is bound, so
rtl28xxu_tuner_detach() cannot unregister the unbound device later.
This leaves the registered platform device and its associated resources
allocated.

Split the registration failure and driver binding checks. Unregister
the successfully registered platform device when no driver is bound
before leaving the switch.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: a2f7f220df5e ("[media] rtl28xxu: switch SDR module to platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 487c6ab784ab..3603d0cf638b 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -1391,8 +1391,12 @@ static int rtl2832u_tuner_attach(struct dvb_usb_adapter *adap)
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
 		dev->platform_device_sdr = pdev;
 		break;
 	default:
-- 
2.43.0

