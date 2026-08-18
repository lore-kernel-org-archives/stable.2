Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59341685C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055291; cv=none; b=N5pKll9AinEQRbXkUPWpbLlO5wtKHnnu2qZDvs8rXKjecdYMeMmNW/IMqU6TBpOcfPF6OLAZ+Wmu4BGAuWaXnZSQtkKAFfTPElVkJcCTHtD9WMZKYrba4PzRIOyIeS06ToRIHLMTgA0Gr5QpPl3OQB9cz3nL+PbD2+oXHLTkQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055291; c=relaxed/simple;
	bh=LNwrpJ2jGDIVWzaHS6+BBNGZ+u3Hm7KHw91cH/cSj70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRdHG/s1o6SfevEsxQDqeXTwKdJFQcLMdk36CbXak5omgmx+ECi81nAMMLP8nhWhxWNLJ97zzghMNsy0tLg+YaIYevjl5epQnvQdAP3IzlA251cqdJRn52isJ45KbfAYMB59jhzo7I/TWj1tCF5dnePCzDNIkcJXqjN798awHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghAKAF8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q8R8BsbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghAKAF8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q8R8BsbU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABhKp820185
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zbfLTR9IwLCu1Z6/pbfQqxBwAeYCv1l1Xrh
	mM8Mbttk=; b=ghAKAF8UszpYCsc2pHNV/UXt3QKW+lE1Za2BbR0JMpFF0Qo5s+T
	BTEgmLhwOSlNyjro1bLNsbcRYB9ihKGr8R2fnzMnlau09Iaq4v26mpTowLZiHUyr
	UR5Xj1gp/8cNcAs6N245emE8zpJtqdESlV0SAby/SmhIGG4S4XafBILWJ0f245/U
	xr41VpVZ1WTq8vZYNV+aGDMlyQu6Di/rJPsbAH9LjerbUaaPYn1ToXyFlL/CrqXN
	oD8tHPvm5AV/oaLEhHvtICqaFiAuebR23G2eug5Vo7m7zwgq2qB68lVxhnzdhUgh
	g+prf3VdLovRcD1LVbhGAsuWqChrY1zjRIQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p1xe7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:14:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso101730385a.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787055288; x=1787660088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbfLTR9IwLCu1Z6/pbfQqxBwAeYCv1l1XrhmM8Mbttk=;
        b=Q8R8BsbU1eDb5hBSCjs3atIm2wQnYbTS/L9XQJkLIT9wP1hsC20oH63+ait07p8/uK
         gTbc6rQ598lfw5WX0d4wik4qp7PgaZh3ZxeJ75aGGzlWMD6kZ2mREyw20RikTYz/Aicy
         yqVm9TQHDhGDs9EUDIar/aGjaFVrr/BSmI0bSFlUG0OVC4+7k57rgMQHjgg84eRUezzv
         Q5hYmWjRGLHLU3j+Ln+FVFDf92RRW2XfarJz+rfklxg44Hq8jbnc2ctCs9etkPINOQ3O
         mdbyW4sLkYGDGemVBsNhWxVPf29WyXx7Wns/qTKbc3utQloYJ6W/am4cVKNk8xYFX0JE
         9Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055288; x=1787660088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbfLTR9IwLCu1Z6/pbfQqxBwAeYCv1l1XrhmM8Mbttk=;
        b=Ft8IOhSGsAJ4b9xPFruLkxl3vnkn65H1Ws33cN55MGrgNC6Ryj9Bssp61OzwaJpIIy
         6aJX56ulsboYjUHG9mIaTMf/dhtSTBaLLyB3CErVXaWH1JrGMWYnf7YkNQ+t2DFKjyXd
         nWAwsY4oV8RAu6LQogt99PSQrsYhEjg0A2M5hZWXv1iZdiEtbaOf9TcVzYIYOjEix0Tf
         0s+Qq5xDeu1XzQ4HyzWHw9YkDklCEtk+EHNivsL/vqf1HUiW3LQHGcEQMp/P2xjEg8fR
         U4ckGUbHH9jzrYBFubAO5kWwqmwl2I97V49qB3Yz3q2p2cQBQJEvIeFBBZPc7b0xYJC3
         RJtw==
X-Forwarded-Encrypted: i=1; AHgh+RrM+XQxvb5XnPPNMBHQrNBb9SGMDDi8ve5smLyN8udFLvm/dV5S95AA9waU6bZRQ7LM2LuFUIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzgn/9BZ1OE1bMsBx638rl/nCWaEnbHTh7IqCBfhEXiu5hy9Te
	sOtI6S8qWnKS7dSLLqgGBsEOnNto3Tyk6LQZlQwvfihDhxlvoGq51zjC6fbdDKdKsbWnZxFKett
	Gi92rWzuoTb4cHQjEp0JGRoj/isFLULslw7FXfPwuZG+IxkyJ3gyKwhkhCbk=
X-Gm-Gg: AR+sD12i8+pi2q62443PUvW112XlAUsSS5KxzBJv3MLPBC/iURAmuBEk84FD64KPUVD
	60F/F2Dp6v3/E7oNsYJXGYQ6RmwKF5yT4k82m8tZCUgcbV/C7dQ6TtO4XclWsMM/P2lE2PjX9aO
	UsriAJJQ/76vRL2UdjtW/Mpr2iMXYQj6Pnm4Yk5PS2Z1mEX4VlMJQVY7chRLsiNkE5lOkpWzsMK
	LLJd3IbkRfno1L9MTIhc8z65pnZ03qHxOlZYwgLUdElBCGSwARiy3ixRdgG5LeCKQCO0KRcjDaR
	/2AeSMPrHWzn0bHpmxElMJ6auI/7JEYmOhuFjwn7k27dRAgjWkMS8c7B/LacjPwmnP78qcMJ54z
	Q3DRPJ4LcMuR/j6E/a/CTtJ9ld8QhWKP9DwwLD7jcGxu5Nz013GMJDgyeZg2uQoxxwnyso8eGMJ
	N63BCTuaq52WomM9Q=
X-Received: by 2002:a05:620a:284c:b0:936:ce17:7792 with SMTP id af79cd13be357-9370657a3bdmr585376485a.8.1787055288285;
        Tue, 18 Aug 2026 05:14:48 -0700 (PDT)
X-Received: by 2002:a05:620a:284c:b0:936:ce17:7792 with SMTP id af79cd13be357-9370657a3bdmr585371285a.8.1787055287878;
        Tue, 18 Aug 2026 05:14:47 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea1e64sm175659266b.21.2026.08.18.05.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:14:46 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
        James Alexander <opensource@inspiredexperts.com>,
        stable@vger.kernel.org
Subject: [PATCH] platform/x86: int3472: Increase handshake GPIO delay to 200 ms
Date: Tue, 18 Aug 2026 14:14:45 +0200
Message-ID: <20260818121445.160751-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eMZcwHGrJHmDBBLO2YzxPeOudxAIvS-q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX4o/0qNca0sgL
 qKvkILfAp/Gt7dh0jBpDHZd5cf22mS/YNU33eQ94Kj1TCUJ65OkNii8CLabj2QnvNk/ffACXmLT
 3L31y/+UbQKOmZKhnP7dBt+CPMbplrc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX8vWOWUqj3e7p
 RqTxcBygYRWeozwzxCbQb7rSzQOPtnBjDYizvHTZoqhxnL9uh7B/u2/zs0wp/dBtXyrpRC2E6HA
 iWd5TcUAfKxQXv2zLycjTL+df1qdOWPmswjvHcuIzPLvUeRvqHOzKmK1rsd1booasrn8U4CIfIW
 G6IVjRqQBLrIzDYtmY3+TJdxCMQZAlIejLYqvkIgchfwmg/sODQ31qLamk1rVy3CQXznmmSeBrQ
 sTO31WZ6FfrQSj1U0EW9VI9oB+IiWLFbx+hBXHEYNPnuL7cv1g8EiRp79t9u7sk//2qs7d+iOmv
 Y6B/dYeKqsnvW/CdmSpYePCOsOmmuL6kRXeZMj946osXNWFKreJy84rHtJazCD0kEUSJjYe/KC5
 /EM7sSpAeisJgEG5NU0XrkYYye210deJ8j74mpn6M3QsZl1qrapWHYdf0bkcLEZiPORgORT4o8o
 F8ohEaEUEuRQWzabjfw==
X-Proofpoint-ORIG-GUID: eMZcwHGrJHmDBBLO2YzxPeOudxAIvS-q
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a844cb8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=BEWJZVgQAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=NkGqlDX_d_C5XZyMslwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=r2lMSnxMdfrVB7dy-wwo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180090

There have been several reports of the sensor not properly powering on,
on laptops where an INT3472 handshake GPIO is used. Both with ov08x40 and
hi556 sensors.

Testing has shown that a delay of 200 ms is necessary in some cases.
The handshake GPIO is typically used to signal an extra bridge or other IC
with that IC running the full sensor power sequence based on the handshake
signal and also possible controlling I2C pass-through.

It seems that in some cases that extra IC takes up to 200 ms to before
the sensor is fully powered up and ready for I2C communication.

With the default handshake signal delay increased to 200 ms the quirk to
increase it to 45 ms for the ov08x40 is no longer necessary and is actually
undesirable since some ov08x40 setups also need the longer delay, drop it.

Fixes: 30359c239ba8 ("platform/x86: int3472: Increase ov08x40 handshake GPIO delay to 45 ms")
Closes: https://lore.kernel.org/platform-driver-x86/20260816204247.2844986-1-opensource@inspiredexperts.com/
Reported-by: James Alexander <opensource@inspiredexperts.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333331
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333647
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 115bb37577a1..f9e42959647e 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -15,6 +15,7 @@
 #include <linux/platform_data/x86/int3472.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
+#include <linux/time64.h>
 #include <linux/uuid.h>
 
 /*
@@ -157,13 +158,6 @@ static const struct int3472_gpio_map int3472_gpio_map[] = {
 		.type_to = INT3472_GPIO_TYPE_RESET,
 		.con_id = "enable",
 	},
-	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops */
-		.hid = "OVTI08F4",
-		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
-		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
-		.con_id = "dvdd",
-		.enable_time_us = 45 * USEC_PER_MSEC,
-	},
 };
 
 static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3472, u8 *type,
@@ -234,8 +228,8 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
 	case INT3472_GPIO_TYPE_HANDSHAKE:
 		*con_id = "dvdd";
 		*gpio_flags = GPIO_ACTIVE_HIGH;
-		/* Setups using a handshake pin need 25 ms enable delay */
-		*enable_time_us = 25 * USEC_PER_MSEC;
+		/* Powering up the sensor through the handshake pin takes up to 200 ms */
+		*enable_time_us = 200 * USEC_PER_MSEC;
 		break;
 	default:
 		*con_id = "unknown";
-- 
2.55.0

