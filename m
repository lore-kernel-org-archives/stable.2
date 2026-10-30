Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391232;
	b=JX2sNyh1e5snifda5ocn/dOhslWd7AKAS3OZQ9p5y80Z6SOQN0fVXIyv1tqSS7hAtN0M
	 jYI/BiJUdSqzVEJkvhz6D0Cuhulle4ETP0JDidqVzcKFCiXNtqX5PLkzkRxDBmXEAptFt
	 1CdZIhNZozHi6IGfmguKX+79i9bSJc53Da9WX03qH2GkhZATpyNSwXrhTDFLCtSXFpDip
	 ihtI9/rqBAZfAMHByZYaeXLrM5xEOCXBlFfr2XdTSCprGG7QemXv3nkXhb3IgHmNXrPEg
	 lLgyug5wL2xPEvmWXO0xSVCGa0AOuSV4SaQ8pbLKCiplMK1hMPbDS5OFRTLuE33maiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391232;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HA1eqb/XMMKqnq98MchSvo7KllgtgAWstr/4IblL2f4=;
	b=KDuWHlCswHkXYZEeTgpXRrsvBo0P1CS0HgeTA6cCAKE/jTUcq2x/755y5pfRVPsqHHVx
	 WSo2L9hhOIsaT0mLQ8mtjUXXR38aXrGQ2uyfekKRRWdhvyL69bK6EFtVpap/1MYDrwNyi
	 HI5VucoAVdWzrc/d6xsgTtIvwMfY5SXaWJVFDcMwUCFwduZY0yEoaE0vG6zIsy0OusDVu
	 Pkg8avwpMTIIp5pVF2qGiE5lNQmRr8MseFoU7efrDcj+yWmw15mX1lDIZcG+Z0bqfkEhG
	 NQ9IRuz1nvzoueHwRLsANavN6Pf4+ufkGgR7Ers4+l8u2iHAEkEH/tthfsz31/XPm4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkgSY1M8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bg95L2Ou;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1412606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1412606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkgSY1M8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bg95L2Ou
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIckko4118816
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HA1eqb/XMMKqnq98MchSvo
	7KllgtgAWstr/4IblL2f4=; b=lkgSY1M8cPxKpiTP/XBWmg2OyBpx5lmPo6d6fk
	gWV3HBZLnpGUSj6z2Ma27dg8OF9gpW3F1OA8GpccA5GXswYYk6JiJVERpKsTGr7i
	VQLAGCuKsRm1NJLoqXasC8nibNT/sRbTv9cfw/twGk7dBlXHSqodkshRMmQygExU
	W0jevctbtKQd0gxeOUga0qkgkIM0kG4NUOOLptUR8GFjUNO3jcwRuSgEm6pcGad/
	wWVEjUvHwdD/hpjPxBlYLF6jGbIykPpy0StL4CzJWwGD9bTP4INNw64amc6aAzwJ
	X6nAq79kZdiUMyFj5TMejR2yI4uRPOpDi1t+/cbVQbjhpxqg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu899p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:13:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a223755e4so4299620eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391230; x=1793996030; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HA1eqb/XMMKqnq98MchSvo7KllgtgAWstr/4IblL2f4=;
        b=bg95L2Ou1sl3OLs/lLJbqMddsEs18v8FHO1Xhl9Wh86u90t2KAr9xJprTrYA6rVe4E
         PhqjA7rWAU8LMYq0/DCmvgcYUPYqT7CyaFSXss2BFc+7TsQI3Fru2EeHwqdn9NVkHk8K
         sSYSHbg9EDreL9TGcvaonbiCEX9fZEjDcn2K75rwGKPO6tesFmqK3BxV447dleAe0MDp
         kjQGFLe41Wt5gn9wriaZDw8qws/GNibCblKWctMIoSbpap9299hyU9AnY1wEeOeNa9vz
         wn/Iu+UNVP/Ry3fZKwP8TzMhFx64pdfZRV4mCtz4leOsVfy4mHX2YmIx0hxK5paQFmfy
         377w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391230; x=1793996030;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HA1eqb/XMMKqnq98MchSvo7KllgtgAWstr/4IblL2f4=;
        b=tpM7Zp1iM9PzmQd1l6oWZWs7LLrYReKfWr4JFJ+3Ojm1WViVvupSQ0jlg4gDIyWQR1
         jTZfejdG0CF4wes18ke5b1huRTIB55kDycE6YPsNRXOTmOIcSzDp3qHX59BRHLaEEBLQ
         hBKMQ68uZn9u0QA7ij13M0pJyjO4aIdjlJTEfPC8fUk4CIRjPbH0FglOf172lnvABN9n
         cLj0KxVFoZaoDEEmcjG9ci2uSdOsqjv6LebQrVh4sb9jDLVf4gwU+mjQ0l0Ef68cGFwK
         MlMoHI00sAdRXRsH39wX6pgtidcXKJSfplEKk0MAvzI2Vl0+2w11wk+dZXLqnETcYrQ0
         Lt1A==
X-Forwarded-Encrypted: i=1; AKwUvByAZLaN4Wf+GYytqLcRDgqFB+0Q8fcoiY04HmHjePS+X/pySl57azPkw5gSrOdn420MIQMwHmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDCct1MZ17yPVBjuQbzdp25GGAOiJqP66Xg117gIixva1t/uRc
	sSnYmGTTcxIcl4pbEeZvGYmpSiefSpwGuqsjkz4XuMvHiW9kEn3o0HBMsx6TM0w3H+r84hINeMb
	ZxwzbLz+5F/Ovbl2d0VUXC5PxEkZh2P9jB1X16rrywkb5FWTP28zMqX+W4DA=
X-Gm-Gg: AYBFou3jAE/EPYeDe5LBXTWNODb5Qy6186LB2x9rT6PrVK2G/bwpsE0r2/CpJv2odVi
	fWgFj+7fguDfEmZCyy+oiJ4rIwCRFpi/HHmIseaIyvRHOSUnc7pe7JocmhpFoLDQA/5bioSntQ3
	dH/JR38wP3g/oUYCxSeMP1vSRAkQcJuPT5evrLy5hXA8GzRtGyfL26uanM8CWxh+iBqsmdj7HHy
	HD1hJNYDZQN32vkiS8EE0IYwoZyWqZYzIGufpK6MxLpPcSzpZ4A1BAMqpjNw3QsrA8zEvrHa1fa
	eeQb0l9ZKTsN4viGzCKLol69llnFLZFp60LDf4uR0UhB05cj00In+O5vPYh0WPXWXItNJUH6sl3
	5sUrBBBqcWwONnLfY9tQMmaU/bqng4KC3QLrCkLkw3etoWG8SP+XImLbNZxPFSyGtZpRplLBSQr
	pHE1KrWCw=
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr7266628eec.28.1793391229262;
        Fri, 30 Oct 2026 13:13:49 -0700 (PDT)
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr7266584eec.28.1793391228573;
        Fri, 30 Oct 2026 13:13:48 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm10830527eec.15.2026.10.30.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:13:47 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 01:43:06 +0530
Subject: [PATCH] media: iris: Fix encoder reference buffer size calculation
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
Message-Id: <20261031-fix_enc_ref_buf_calc-v1-1-54dcba5977a8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFH65GoC/yXM4QpFQBCG4VvR/LY1bCi3Im2MWUZa2j1OSu7d4
 ufT1/eeENgLB6iTEzz/JcjqIrI0AZo6N7KSIRpyzMsMNSorh2FHxrM1/W4NdQspQq50oSsstYV
 43eIqx5tt2s9h72em39OC67oBln8WgHgAAAA=
X-Change-ID: 20261030-fix_enc_ref_buf_calc-c0e73537063f
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391224; l=1534;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=FkrOlZDI4iemUsKsTYD08B3bK3zXEhsXGUqFdQMVOME=;
 b=TeQZNyEQxtWmQVIiYDHCHhn6k+6czHWhBNKa6y7Pk2TgVsh5QA6cnRpt3JP8gkvh+MGsiolWL
 wri65eXtzUgDLxHavH6m6oTKKG+NjbdN1+4pILk+k4WDVS9rh6Q4Jz7
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: YUA8tuVEIQLfRXI4UQkMj4mxDD-dS3nf
X-Proofpoint-GUID: YUA8tuVEIQLfRXI4UQkMj4mxDD-dS3nf
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae4fa7e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=55WMKUh_GWMeySVVs5YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX68kPl5Mb3GmB
 3sKdIU8+lP+fKDmS4NMeTYyMJmFMmTQ8CK9st12TusK99qfxw+KwDzAKjSJ+pI30V5Kb9rTVMQm
 E1aoFFVo274hTwqH9Fb3ROsDZHfdrB/F00arQ8O7I2oGgkbS7IFPUl/6/RcF4tOVsPi29eg1H2u
 zCs3/1onYazOp+eOWNVS2wSDDVA/V5YXFqGI6UdFDDVKroqiWcwbWj+3Gp1aqMtYI6LqPT7wJYH
 mhCNWwaG9MS29GH9fFawQ6RgZcNGY0qSK21bLf4pIowSAoXF27hE09EyM+AX7Bgb/blp/Hkljaa
 1ve5SjbR1TO9P8gJkLvDKzMfkQ+lC9RkY83Ye06YB7rTsB0oWcbPvmwm/+bmDX4Ic1iHVKwZLJL
 Lr30Ce+L1IYiNPYvTlWLxY50ntXO/jOykfs5XlDp34ttuZgpQKqLY5GryHJPgpoZxc7r7bPn97M
 Ni9E0ymzkAIUTvzHfiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX2kYMROox0iAB
 zuDHXykTL9okzcjah4OEeiwzH5/7DzyrvV+FSpDZzbRDmd7pTx+6nO0f990444BOvUYG5hzZgl1
 6wm82KwyaUCRcmLWhi9hu5Q8hbU0NWw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300080

For frame widths that are not multiples of 128, such as 864, the
encoder reference buffer size is underestimated. As a result, the
firmware reports a session error when starting the encode session.

The encoder requires the reference buffer width to be aligned to 128,
but the current calculation aligns it to only 32. Align the width to
128 when calculating the reference buffer size.

Fixes: 61528e86687e ("media: iris: Allocate and queue internal buffers for encoder video device")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index a8170e5fa9e6..2eaa2218f6a4 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -1517,7 +1517,7 @@ u32 size_enc_ref_buffer(u32 frame_width, u32 frame_height)
 {
 	u32 u_chroma_buffer_height = ALIGN(frame_height >> 1, 32);
 	u32 u_buffer_height = ALIGN(frame_height, 32);
-	u32 u_buffer_width = ALIGN(frame_width, 32);
+	u32 u_buffer_width = ALIGN(frame_width, 128);
 
 	return (u_buffer_height + u_chroma_buffer_height) * u_buffer_width;
 }

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261030-fix_enc_ref_buf_calc-c0e73537063f

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

