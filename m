Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890086;
	b=tFNg0Cwj4Vf3YEub+ihNyEgWq9mY3a4oI3v9z59QS13EZhtmUm0YpGqYCVatkj/YVSUD
	 C/+Zvsy0r9+0SNv+q1IGRGfQf0miFNQDMcf7awyMkBp9wXUtCItCt3+DLO4hVbxqzAlL7
	 eUsyhyLlPx2IJRaFFm+LoAV8Jt+l6MjLWD6Azt5D4X49bwGS2jqXMh4KR4BianSYqvvMr
	 Fgr40fE090SPvo+K5B3vG+AlIbjSk1NZq+IlXYmzoi3tq0V3yYMv9HXBzur2TUNVVaHsr
	 V66P+Q+rDNsC7y/Z7luLMp28t0DWgnii+o1PqsOD79cAGVmZ/unh+FenWA9CxavRQxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XIUlQahuIgT2dggn3IBdwyTP4HkjjzBGnBjYhez4rP8=;
	b=1R5FLNS8eOZBCY/rI7+ti1rM1+4SZOB05KbobyEfR8CP9WKodPiidZd98zHjCFY7SInc
	 ubC9RC/25Wyv7a+Tbq48bnv4uTXTGVqBN4+ZwujFH1TSUO/pCFSz/Za5c8cJLsWGGp6e6
	 PA03o5IloWgPOtwOYsTBbEIHPXRkWXnbBS7U73JFv85hkDGyw/yqrHeBrAcY8h9q6hHUl
	 VQtv56iGIYdrPiRBCpIKDvi+Le6uj8n6LGtrxwb+tTG+lHSQZj6X07/+TjiFbGNu9hgnT
	 HXofGfPWfbcDyn+vvYf9za6ZoRQ20TR2wa7kMVNudQOoVeHjBGSPFS44EV4CHCj9wbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JsILPRvH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z6TL+4hD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD4606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DD4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JsILPRvH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z6TL+4hD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQBwc3644455
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 14:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XIUlQahuIgT2dggn3IBdwy
	TP4HkjjzBGnBjYhez4rP8=; b=JsILPRvHRooQS58yuPGOPxACkZkYcLhyFiCVWD
	F4ObpXr7YhxFiQUvFN0A7FBjVK/7O+NdIK2oytFZOEWTRlBOingOqx5lzH6mSM2P
	zuvFdgrj0Qd9FYLd2QLFauV0dq9WaGsELwZP7xXVjOvEyHBuI3AAFa/RwIwmtD1m
	V/mlzEjoAN05AtAXao64Z6jSWtCiFq8hv5XbfkgrWObCCp/EP26ule0LMbS/ZJKu
	2bPuwPkJvBeZwk1zResonU01ko1QIbQQtpLtg73McEdfbERd24pW0ad3mLc8Hsve
	0hJsIkXY0Etx/0SONzTaKt7VyAl1ckueoMtZMO4kluBaAeWw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdry93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:48:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc694cb4adso410669137.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793890084; x=1794494884; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIUlQahuIgT2dggn3IBdwyTP4HkjjzBGnBjYhez4rP8=;
        b=Z6TL+4hDHS6qZz9Lqj1b5CU/aBVNX72hcDC4TSOcVCbOXfpBF3jcCfvBRtnLcRs6A6
         Sryty5mQNjZ3rE6IlKw70GhXrM/aBa5IYWKmSitqnNOqez6vtR6FbtFexssFTguO8m0Q
         OxboO6ff7rTS3tSim/I/lwcT04codb4JKY6f492260MO6vU4hVwp+rHTDqyH/YVJksYW
         er4PnnoqsGcQfxcocEX5XQfcWhpuH7cmqqj6atSTmZHd4UaaGgb15WU3QRAbgzV5o2qj
         bz8+h3RdYgYKnsA1z8N/muaP2+28MwzPCD6QOcGxG6+utW51vH9c6kemviTKl7JLT9st
         MU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890084; x=1794494884;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XIUlQahuIgT2dggn3IBdwyTP4HkjjzBGnBjYhez4rP8=;
        b=e4fyRo8n/cWCrKmEeRyMDyxypXTdXlipfXoI9pelazct6TD6gpxkjJwR3w+bg4y+tI
         AQKiicKKNF3W4ePDmjp+24hi9UotSKKZ0TnCdxJ5bEWN9SxiBKUmY6oznOGPNJGxewak
         VHcAP2/jV+qtQTV0P+XCs9WXTfQdNrv2yDO+b0o1o7c8Fmvv/2ufnA60UDFCCJUXN19v
         gBxTPpSyHu7aaQkmXvzunskSZ/ZkU9Kzqs5MfFrzuwaLR3ot+noVB2lAaG32ftp/ONWY
         aGvmH4R5Hfh5WS6JEdezxPqrnJJH/K3GKDj99n/9wFhE5TO8cqX9ZWbzx3bRcL0UYixL
         saQg==
X-Forwarded-Encrypted: i=1; AKwUvBw1CDNXsy6iEOnTggQpnG3S5wN1Z3Un39W5T6wmm+f559QNr/kCyuhXAHVDdFJTxN3GRj8TYUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H3RcBzwD9mOacR3fbmbmMDfQESZnJYuiRC9ZL9pRud8UjMWKE
	ZHgNGkcQNhY97YXUbUXCpJLNiry/xrAn3wOBUVvPPtruYA3q/bwBbjQQYovZ/dV+MdWGSCo9ts0
	kG+Obxm0BPChHquNCeXQICfANkSw71KJpEqG3LZWHSttoVjygKIRRrt+cNxjUKcyYpMk=
X-Gm-Gg: AYBFou0mWsOtcRpBA0uRmsMoV4PPMcbYI8H07uQRl5W/Oxgw2F9fSkRbLhxgVDc/ECV
	R+IGkxbJqmoPXceuiT5ErbYWZMe5nUpLFkZodTqcFQveAMxuYnnI/JwFPcNKwkWppQsvwKofLkq
	ql1Heo3nGhmzKxK5Q8FMtnAkdOF8YbsgYMJa4ZJwjZKMVDuejZMpNmdigaUoymEpXAnY39F1jYP
	iHVSmv2wllHXCSQR1n2sGRDkEBrouNGgzVVnLIVfegEuOc6lTqAL82ZJWM0mlps0j23u0uC6bx6
	44+4nd2mdLUCzMPDiSqtm+YG1OuvG+uc8sgZdoD2x9jJo7E5y7sBcliX0QpvxN1unHC2RmMhnAX
	Fpy2GRoB5rrY0Jp6mFdvx1gwt2ADamjAuHZ+lw9j09oKcELhhJ97SXEijBxQTkeoXoxCRafI5Hf
	CSKA==
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr9621664137.2.1793890083836;
        Thu, 05 Nov 2026 06:48:03 -0800 (PST)
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr9621639137.2.1793890083224;
        Thu, 05 Nov 2026 06:48:03 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20567sm11205756f8f.51.2026.11.05.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:48:01 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 15:47:59 +0100
Subject: [PATCH] gpio: cdev: fix waitqueue deadlock on chip deregistration
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-gpio-cdev-srcu-deadlock-v1-1-6047117030ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB6X7GoC/x3MQQqAIBBA0avErBvIQo2uEi1MpxqKDCUJwrsnL
 d/i/xciBaYIQ/VCoMSR/Vkg6grsZs6VkF0xtE2rhGgkrhd7tI4SxmBvdGTc4e2OotN67pVU2nR
 Q6ivQws9/HqecP/43eSBpAAAA
X-Change-ID: 20261105-gpio-cdev-srcu-deadlock-1377b86567a3
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4206;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=0fakC9EMET3jBy7No5GpBIe7f4Pl8vI+qRAGeN01JLY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7Jcg4Ok5sTBKUiSlkopmH63APNkd7sU4H2G05
 r5sbOkZND2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyXIAAKCRAFnS7L/zaE
 wy2UD/9FHgbARHQ555S5Rr5I1dbXyvIKKT+zVKpJ7wNIonEzr6i++NbZ0YUJ837PVwjFoSG9uII
 7tu80ivanzao805uILT/PysobDqX8UOMU2G8mUfkyyeDK3/pvxdIkAet70CkdMSQB8RO1aASKBi
 MTBg4LjR1zW+WAVzwC536rRo/r2wUMqkbzuSDLDtZccYUfh6wWD8TO9nl5XngqKiHWe3I4rbupY
 DdS06OZJ3ra1zBSvju9XpSBuWd2U6UjdwninFhtmEmL9QTaUQ5rMmh5t1fSiIJmFTbQ57SEpEft
 WZF9w/wNrv3wF1co2ehbAUgGjMsNcstFHNuTaK2WQN1BqboaRTgr3rOXmW423HkKQIrWTJj7BBZ
 zIyI/Q2rNHC3Yc/whT6ctfdBKxKwyhNlYhKt9euSNgrOdCDQsffJFtFxXMo+uOu9wO+J6EH4icu
 ++Vy3PNQHucmoxu7lyuumsAuEh7TMWnE660d6of49eh7polmB+fYgFQkp4leB58hZNu7rgjFJf/
 c+LmlfrCeHWdH0OdWhrfXYonoWcWiA9ZJ+bngT5W2MdUGQv86VB+fXYWgF5waMDcGtyjL/9rb9z
 9EbhWJ5P40NIPKwakCAnAeKuxJo4UvtPzEcA1pGFKHXY/0HyE+/JxLnqpzvxzHr0sWlMmD2Rn2y
 qX51I0+4zZiINkQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aec9725 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TEQn8LnYDw7bCQWhkO8A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: 40auRHoCDhuGd2tGGy_fhFL0ei8XiDE-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXz5W1VBaSiHHY
 c+Di+iI08hQ9vcKmDYuJtmCMvQfEAfZ8WTxmjxnWNIijhbu5rADBpvoOuGjzab11b/yuWf12SJE
 /2a9bSXmswKWs41aAnafqIs6+/Xgg84=
X-Proofpoint-GUID: 40auRHoCDhuGd2tGGy_fhFL0ei8XiDE-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX4rIZ8NlKgcd4
 xstCpYEQEbi/BrG0UxDSCiWwBzyBfIu8jWoz0n2gacqlp2eEzrTk5Bw6yysRCQSU+oYSL3hq6IV
 LD6dnEWLAptg9wTs+h9mb6fSAZ6FO7FdavoJLbmtksUczZzKoMADSOWki3//xEWXsq/MQak5zVO
 q6ZfdxYnschJV9baR6FKQ4yfylBYZx1jc6Zi75Q1wnE/tiXWGzRgPV0O4FZrtwP+PXnKclzwgix
 /Rw76H/XKAOb5nEgbjgkHEd0fuvPfAuK2HwFrzx604++J5BYH3xa9+FT+E4fq7K+DHwmZdUYdUl
 LTwAq/zGHdzju5+he97zEDqRZB7ZgVIuRm7sIuTNpjUEU/QjisTzF1fodmw7aUri2ENHsg54X2I
 6qhzDK4V7jR8XR9VWc1VGkKEj5Cl3kDKmoygOeITuD5oDFPHRsOPbypcf8x+2ovqJRnZANdUO8W
 3l9AYaksjw1IvugLa8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050058

The three calls to wait_event_interruptible_locked() sleep while holding
gdev->srcu. In gpiochip_remove(), synchronize_srcu() runs before
gcdev_unregister(). The latter fires the waitqueue wakeup events from
the notifier callbacks, so a reader blocked on an empty FIFO never leaves
its SRCU section and the removal will block forever in the former.

Since rcu_access_pointer() is a plain READ_ONCE(), we don't really need
to take the SRCU read lock. We don't access the chip structure after
checking it. Remove the lock and instead make the waitqueue aware of the
possible chip deregistration. Keep the initial gdev->chip checks as
removing them may change the error codes visible to user-space, for
instance in cases of a non-blocking read on an empty fifo.

Ideally, we'd factor out the common code into a dedicated helper but
there doesn't seem to exist a clean way of passing a kfifo as argument
so let's open-code the three call sites.

Cc: stable@vger.kernel.org
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
I've had it on my TODO list for a while. I vaguely remember someone
reporting it to me but can't find the reference anymore. Please feel
free to add a Reported-by: and Closes:.

Paul: I've Cc'ed you as you may want to take a look at my SRCU logic
here.
---
 drivers/gpio/gpiolib-cdev.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f68e33cbd7d4cd5153e82ad77768cf52a90601d6..62215d43b8ac757bbd5344bbcf8631feb2443a6b 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1489,8 +1489,6 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	guard(srcu)(&lr->gdev->srcu);
-
 	if (!rcu_access_pointer(lr->gdev->chip))
 		return -ENODEV;
 
@@ -1507,9 +1505,14 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(lr->wait,
-						!kfifo_is_empty(&lr->events));
+						!kfifo_is_empty(&lr->events) ||
+						!rcu_access_pointer(lr->gdev->chip));
 				if (ret)
 					return ret;
+
+				/* Woken up by chip removal. */
+				if (kfifo_is_empty(&lr->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&lr->events, &le, 1) != 1) {
@@ -1801,8 +1804,6 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
-	guard(srcu)(&le->gdev->srcu);
-
 	if (!rcu_access_pointer(le->gdev->chip))
 		return -ENODEV;
 
@@ -1832,9 +1833,14 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(le->wait,
-						!kfifo_is_empty(&le->events));
+						!kfifo_is_empty(&le->events) ||
+						!rcu_access_pointer(le->gdev->chip));
 				if (ret)
 					return ret;
+
+				/* Woken up by chip removal. */
+				if (kfifo_is_empty(&le->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&le->events, &ge, 1) != 1) {
@@ -2579,8 +2585,6 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
 	if (!rcu_access_pointer(cdev->gdev->chip))
 		return -ENODEV;
 
@@ -2600,9 +2604,14 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(cdev->wait,
-						!kfifo_is_empty(&cdev->events));
+						!kfifo_is_empty(&cdev->events) ||
+						!rcu_access_pointer(cdev->gdev->chip));
 				if (ret)
 					return ret;
+
+				/* Woken up by chip removal. */
+				if (kfifo_is_empty(&cdev->events))
+					return -ENODEV;
 			}
 #ifdef CONFIG_GPIO_CDEV_V1
 			/* must be after kfifo check so watch_abi_version is set */

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpio-cdev-srcu-deadlock-1377b86567a3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

