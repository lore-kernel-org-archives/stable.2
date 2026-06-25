Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEE35AC00
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380583; cv=none; b=dJG/MCn/mwFn5ZzO96CVOp3hy6IZ8bhHe0X1L+SUPEpHWbEMxt6wU+i7KCAHoU7BwY7v9y/XQ5b7qzI0HolrTRc4dOjqwwbTZAnQH7zcCOia6V7vO49YIyc2mTWLiTHvorU0so1bOoVw5vtsrrHsaCDv1v3MIVv9j3kiZHkxk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380583; c=relaxed/simple;
	bh=GeZzJ2lUUyqOawlzry+eBfuMH/i9lZW22xMIB2YOYZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HbfhNztBW53B5fYqgGYAi6KZu73K0/f1OvswRQgjpoKhbIf9Y9i5hRrNPoGekfRu1mASOiqV5Zis3WqfcGOqNmHJ+T2nxFD6F1tRXjUcyTr+tF7rPCAz12Xb3WMjmBv5hq5PUL4roP3hjGGb16TPNAzsIlnqAgBPa6RAi5eHadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OV6PFj7U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BrQ4oa2y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OV6PFj7U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrQ4oa2y"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8pbeq1345913
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+fUJ9z7/1Rya1MBrHCkQJY
	9zUrIg/DgVL6Rli088cxo=; b=OV6PFj7UkQxzbqCn6tJEMuGDqAu4Wm0ytBQDPn
	hEmVAAU5fElFR32mh4H4Xv3NFbpTNjHWh8M5U3bFKp58s5/XiRQFUhPgJocaGJaY
	4G0W8wDFLNl4OV286anWeUZWs2cE+8cfH5hr3MiGzvV3OC/gff7vwlbttyNPRh78
	smd4g1+VBgHbk3YnepHzJiGS3D5/6KLCUQZxVJEWxHZJrz9gRf6aoIdG2LuXFKqH
	Vah+gVWEE8BVLW4hq4uqlEWFynRGor9e2Jl2UcCA4BMrU5mBvb/hfUHljFjwmGnC
	URftZsepG5VwjCdQR47rVXppt0ZXs32ahsmPYU0qlGdCFK3g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0nv7jq3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:42:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-519fdfbd340so11277801cf.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782380579; x=1782985379; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fUJ9z7/1Rya1MBrHCkQJY9zUrIg/DgVL6Rli088cxo=;
        b=BrQ4oa2yJuDVx7IbePOJFDNLbmowIuEQGCxzxHycuey6O94/4gl1C5xo49si+64m+y
         5OcGibvIvG9TkpIdvlK02emk0JPubM6FD5gfTbTgjY74QiDl9oCgSEMyJ+XaPY2td24/
         Tu2xbzwgLnY5NZMUqUQTtQK0M5RA01O7E2KY0e+aJWvlkLTG9P+gAhmbBLk1TB5MfgsG
         wzoTxjR1RlAQLEjuFjQTRitKdVUB58PHNKGZ3ejcY4/O6gaKL5zcpIlAmlOoHLcey2AO
         vaH4qezAr3AzPExJekM8zZFC4Nxvv6TCc6vaY4L5cWQA1UkcGN+X5bAodE0AtN2Bc+W7
         sDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380579; x=1782985379;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fUJ9z7/1Rya1MBrHCkQJY9zUrIg/DgVL6Rli088cxo=;
        b=eED3vuVhga4i/0SciDBgOei4fX1+roSxBGczAdAVw6C5Tev/SXdWYheLle/uWX8zPr
         tD3V7ErlSC+Ge3rjI30JzYy5ElYF7WhEtw4fj83fFSXxR84aIvRkN/z4g0Q9BWuIFYpX
         d6p9rA47QYLDtvk24AesuHaB/am2VubQi5pedAJumy4yOPe36bOnQfbqm2pW7cf4hY3C
         P04q5R+T1AgGFP8S4zlrV7ttWghaBeutmQNcvY5oBbTMdR4WSfIGrwNk6djd8BKzGann
         AFwsIwhujxgXwXextYIZWqqxLnITe+A9TCCXTqdcWYnT2t7ZCfWbYywxe6y7yi/gnqd7
         xksw==
X-Forwarded-Encrypted: i=1; AFNElJ+xurv8FTNjs/0eki1DDfHjq6U5qMVa0j/vro4QMoEY7wZZvhponkgbtmsEEOVcA9Z7QIYEaAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRI2TmAGZni4KoTf/W32iTZ2m9Mk091+DjmziKgJH1qxsLCqY
	XHUdbdf4Cq6Tl370FOowecd1eJnCrGbytMnT9LPtJOraucft1qmn1NCawOBH4gDef4xZl6Zeh0B
	9ni6xzpJoB2OlY0hnrXMvMgNDsCxl5D0FCwAY+PPlGbiHVbRZb1W1iIvRXKs=
X-Gm-Gg: AfdE7cm+1H6F3txr2V0nQC94x9FK6dWARZsC9DjIfUNISDGG8jJw+UE08HZxkGUT21A
	vu++GwbMr01r/Fatk1nPd8z+cE+y9ZwACq5yXd33fMQn5CAdellOcuJLcAaGAzhqnyYp0Z+oTUr
	o0Iy3zbD3Rts4KRczqSUl4gbcgUtxIMsLInsQWsvdN9LA85fPJ9uQdJi7YCUuS8kWcjLh7ohgGN
	U63wtXz8ReuPhSBE+JvTDEugxXvhIIAvjBgSnL03EJHpXeLMeeXm6/luZc7ouTJw2EZh66s1ydv
	rxBAha9f/WqLfPte4WzFtpz/LuimcZZF0GCtNkBUXUixTsYi7mqrX9Xy3rNHZbQAFFDHJ36H5n3
	5JLiOYKiHgu2LGqKMg9yJhsCrrrd0E0R0lqRf+HPk2/2CY7o7wptaXGeDWOOcZuhnXyNWfw0GPL
	Ucbb0=
X-Received: by 2002:ac8:58cf:0:b0:517:91e5:108d with SMTP id d75a77b69052e-51a51bf8868mr151889791cf.42.1782380578691;
        Thu, 25 Jun 2026 02:42:58 -0700 (PDT)
X-Received: by 2002:ac8:58cf:0:b0:517:91e5:108d with SMTP id d75a77b69052e-51a51bf8868mr151889641cf.42.1782380578260;
        Thu, 25 Jun 2026 02:42:58 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a6e7669ebsm15037901cf.12.2026.06.25.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:42:57 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 17:42:45 +0800
Subject: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABT4PGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNT3eTkTF3j1NSUNHMzsxQT4yQloMqCotS0zAqwKdGxtbUASFSZY1U
 AAAA=
X-Change-ID: 20260625-cci-3eedf766d43b
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380574; l=1696;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=GeZzJ2lUUyqOawlzry+eBfuMH/i9lZW22xMIB2YOYZo=;
 b=y4tcfj8mA/WqgImYz0vooABkfL2DEx5+/5V2i80MAcTQI7vA7eCjNQitwNBRVPLIFzFp4oObY
 wMnYB0V0DrlB3B+oHcsjtk9Nx4MppDvjo4Djgm9KwMHCeqbGWMAebC4
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4MiBTYWx0ZWRfX9oBj6jTCjHUb
 VrjBAEnJwNXK77BmxPkNzyGIHYbhpNff6nglrazwID2Sta1vTdGgU0cNmXds6kFwsuMjVm3Pjbc
 Z5UYh1txAY1PbSs86/g3jAB3RmPJDrw=
X-Authority-Analysis: v=2.4 cv=RJiD2Yi+ c=1 sm=1 tr=0 ts=6a3cf823 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rHcAlnMhGb8R5zFVClEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: HuzpoO_xuDhXuvPPY5R836HrRpSu2znP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4MiBTYWx0ZWRfX7CHeJDGuWf38
 f9dB12FD7pu56ih3lMAHxaoIhluZuzub7ZG6bRQqcYz3AvU7Hqm969CcMKGA8DdWoviVZDRkRCI
 0+evyWHqkpFIfoTdrRCTyLPcMbUucjHejmwiQna8sTR3twRzNIor3QZGU7qKapwL1bwDCR5KyA1
 N4V1QPX6N5GB9IvgGtgH84lBQBWZv1LaUqYt16HCwzgGka0SkuyqF+0zw6sF5r28h5Ybxxiw5HK
 l8JjgiQeNu6gxH/mjyJ+pVjEt+O6setTnc++LM28d+9OAu1ncpT0HLOQD9CdxYpVOAiV4umBXBg
 uujIMh+lXNvJNM1/B/1i9B+OdcEV98BO1qr3P6EqMlIGqIilZcne7qovRS+bi+LFggxmX/H66Uy
 AsghGI8tGFIZKIECnWv9o9z1DV6HRTI2VtkOYnL2xFtlQcitLIvnotCnvzbgj/JbWR2uFhS/hUL
 NVAhAE9H2U40C4fFV6Q==
X-Proofpoint-GUID: HuzpoO_xuDhXuvPPY5R836HrRpSu2znP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250082

cci_resume() unconditionally calls cci_resume_runtime() regardless of
the runtime PM state.

If the device is already runtime-suspended before system suspend,
the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
As a result, pm_request_autosuspend() does not arm the timer,
leaving the clock permanently enabled.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..bdeda3979c4814b5cdb463734b8361da7fffa879 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cci_suspend(struct device *dev)
-{
-	if (!pm_runtime_suspended(dev))
-		return cci_suspend_runtime(dev);
-
-	return 0;
-}
-
-static int __maybe_unused cci_resume(struct device *dev)
-{
-	cci_resume_runtime(dev);
-	pm_request_autosuspend(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops qcom_cci_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-cci-3eedf766d43b

Best regards,
-- 
Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

