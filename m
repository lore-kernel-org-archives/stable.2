Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB533F8C6
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569907; cv=none; b=TCElJAgUHIxwiXUAf2pnecgnn38E7+uEbat+Ektou7Sf67/PFtbTXi98BwKMjBokibJQl3kY7/6CJZ5kebGDCOQwx/yTk7pBhbJZktKI0JRbG0TIBXHBQRV1zls3xr4NB41TR58HPsBl8wiy1UBlllC28dWwGkAS8ZqI+fSqmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569907; c=relaxed/simple;
	bh=qBcqygLGzctnWl0Ad9kRqj0ar7uVk/8H2PNp87JucGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isQix4hkNwzsRBqeTHU7d97SdjvOYLXF+R5NJro397eJHDmE8btFNroIxyVhbgDIpJWRDDd3vtUJU8AGns54xVW/Y8OnlnqwcWw/IcfmiYxAnwmAqiH/mKCF4ohli0T3+IUgK9EPckYMsTxUiHmnrf+tre4c3bHhw3GGzIL3zK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q86wiqAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M/CapaV0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q86wiqAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M/CapaV0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6714BlXp1780547
	for <stable@vger.kernel.org>; Sat, 1 Aug 2026 07:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Mp+nfA3N+p1lXQzMxJCbO+jynV1YH3G+4IyAbOESn8=; b=Q86wiqAhA9bJ5lgC
	OfOArRrU92p2EdlV32XF/6o4sL/Cm8scNPeDkz+TrWBt1xdMeH/BlcAqlewFfGEE
	GUaf0iU3u9CMYNjJ49VdbncUSEko2pbwkWoA/ScsURPZoxRwpZ2qM+0D+/z9w8/j
	Z+0IpchwAEgyeHgDe65xVt4XwaEJMf40WGX6mE9Vsd2Vnh9W6LW0FK1RNPOgauuU
	1pOigAOtyE2vwc3YmDk+wgsdwjjz1iACDl+SZcJd6CVBcmtUnyikH4mfWK4UXo27
	r4c8QRn6MwJMxlMA6zz1ZyOqee8Gq52zN0W+EUH+1/cBv/VQWjlVtzVVm5PmsmZY
	GBnIfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9jfrb9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:38:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so2107222a91.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785569905; x=1786174705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Mp+nfA3N+p1lXQzMxJCbO+jynV1YH3G+4IyAbOESn8=;
        b=M/CapaV0FGtDxQItITP7nONrdCaJLfwF3HHFLuNYxMMgPGl3Sp5M9F7KmKq8o/ci5B
         SOM/9Op6DxtbfdvNkG2O7jcEp6ipzzfrX5hWHrDE9qny/2ASl8wJ8mqRoYjUBBFyTVeJ
         MS48BmIuZT18BXxVCU2/9y47vEfTg3RQTZnp0iwYS91qIhPOTIvEzHW/cx59o83FI+mM
         bSwRq4k/vXbECbnqDzxBui91mamdMOEx/5qf0FQyfiiziWT9jT+tIOD2xzUb/ppUnu6v
         /79twFNxtLm/pGw4l5WgSM3QzvZj1mf8EyfEditEk0WI2lfbND1XU+vEtBKmI9z7IIeA
         zkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569905; x=1786174705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Mp+nfA3N+p1lXQzMxJCbO+jynV1YH3G+4IyAbOESn8=;
        b=Q7/Eg5XdSYnQ4ryqFBoLtz5eVyJC6mdWpR7Lb9Dg0dU1FyUk1vbUBX5nvtB4Ss5Bia
         93CNsh0eQEGtHYqeC2i5alwfe/6yXQL3vulDYcjK6bXySIVV3qaHYMCA6irjm3jCo00/
         BvyrUZHdNs7K14hIZbzn+jjpqVKu/qr0cugKO386jihmh0b3AkRSqMFR3IuoYOgBCzOt
         l9kAinty7Jig/AFNuzlEVGErtteBGEvDT4Q9gUCDItquROds3mnO8gOqjDkgA0xgaMK4
         BrqwmtuflGLiA2a3keMtvFCUuHlUlR/jWjxku6gjxqXmrMOLYy4F9/dgrpaQvZB+fMpT
         nHew==
X-Forwarded-Encrypted: i=1; AHgh+RpnEQtAFNrC8Gc2frsfHpw3J3zdSTu/Dy/bIHhxnxObGrx9mSQZIimg6opMIjphuBWtv8oCLy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZ4kjEQeMcynt9b20AvtN6KN01ICjrKwSLtw6uaOtMOPaaOss
	pq5XAzJeX5cohKS467E0N1XvfrlUHqqNK/OirZnBiETv7f/4CiLx509DI6W+Zy9ez3O213h2L+M
	8Fyl2tric3XphpQ9aU7QK3AhUlY6CYlby1QZkckS0suNRMohuRJ2u4YmXYfwArZkgTMA=
X-Gm-Gg: AR+sD10CR9JJFCtY/22hvIAlHWjLTwsM7W90+TNBoUffRcPO6w09rRFxtP0FCDbunZO
	RNL7dNYfKX550J18Rb/B05+jEqR+6GlmX14YZVdIrVzSatfr8GzPEc2c0reAMUlXkybtEdIfY7j
	L65Sx+kbHkDWccanPQDMcTRfGK7+NRwRGdCwK/wV69GSiuqs5Bmi1ILhMsmoCEB7kSyV3ch4hVR
	v9AMvSrFdhgKPeVKeDL+YERMSo8Xm4SChqFbKXZdzEZag9bTWxQE+R/eERd+Vqo+rSmH9nMLEUo
	Ivmoykx8VjdhPsdD11e3A94n2VXV92/KxJm8bsLd5ytplUzwbUw4BfLjDUw6aCYmv+xFepUj36z
	3ryYBMT+kcQ1R8cqwcawjBDHwEP00JBdmMw==
X-Received: by 2002:a17:90b:4b12:b0:38f:57f3:4dc7 with SMTP id 98e67ed59e1d1-38fbc4c66c4mr2472937a91.26.1785569904672;
        Sat, 01 Aug 2026 00:38:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4b12:b0:38f:57f3:4dc7 with SMTP id 98e67ed59e1d1-38fbc4c66c4mr2472903a91.26.1785569904117;
        Sat, 01 Aug 2026 00:38:24 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm20729985eec.19.2026.08.01.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:38:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 13:07:30 +0530
Subject: [PATCH 4/4] media: iris: Fix frame interval enumeration for
 non-divisor framerates
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-iris-fixes-dma-pseq-fint-v1-4-aba0cb22f6ab@oss.qualcomm.com>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785569872; l=2222;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=qBcqygLGzctnWl0Ad9kRqj0ar7uVk/8H2PNp87JucGI=;
 b=Zb792k/Ttm9QCTPbV0RFTp6LNEeiguSLfulNYbjzUaoDXYPfSPyu/FE/rWHuOS0q2tZe/Ya6Z
 4QbnxgnmjttDbmKXo+Ky6fdgKaEt/djIbmE/8LIlw/UkVeCP8Msgts0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: Xd-AP9vq7vXjvQ5QQrLrbYHEtt3k2IEo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfX0cTBSUncE2D+
 /zarEDaYtKXMjzBbDzJ6SFG8vy7Y1sOfQo/almz2z8WgjFMJegPOABgoYckxvEjX/y8KUudBW0g
 ruRgRbJDVSdPBOiORJOUN2ZomRWMmfHnP2g9g0FO8ll1v/OJxn7PZYu6HVqbpEgcXcUWVOIgjkf
 eUFAT2HDzI7eLKWIbLy7r5fqqHE16vDCRot1an9K0AtDf8mCOL3GcEenerV+EzuXpUGTWlYcMj3
 XIV8oGvJ1/6QJir31Z6TplvOah/KX3GAqywXMwkCY1NoMxqSNRpDpzWG1YHx1jV5pe0wMzpDog1
 MC2ewtSxEwg0OkBFcMNTWUrcnF1tCPoPdkQ1PpOGAw3Z3qpvhP2mip07OCU/LNCgENASQ73f8V4
 Td6nPV1D4bjRL+c3RiUYuANJT10ifBjemtlOwAV6XmfabUCwSS0aBawXqcmq1DB6i3zZGQB8ri7
 hgXOyodWCgQtCqEKTVw==
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=6a6da271 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SOCO_u0IuGyKYXpwI1gA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Xd-AP9vq7vXjvQ5QQrLrbYHEtt3k2IEo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfX33o2wM9ucmZn
 Ejd5W0tVx1ew7Cx2RA38phgc5DNM5U8VyDmfrkC0EP4xr0317f8bwkUOm87hASi1FfniVU7eDfV
 1aLlCPzJFl0ZSQd0aNaxBtBC9w9qgCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010053

iris_enum_frameintervals() advertised frame intervals using
V4L2_FRMIVAL_TYPE_STEPWISE with step=1/MAXIMUM_FPS where MAXIMUM_FPS
is 480. This caused client to enumerate only framerates of the form
MAXIMUM_FPS/n (where n is a positive integer), restricting support to
exact divisors of MAXIMUM_FPS (e.g., 480, 240, 160, 120, 96, 80, 60,
30, 24, 1).

Framerates that are not exact divisors of MAXIMUM_FPS, such as 29 fps,
25 fps, were excluded from the enumerated list. There is no hardware
restriction to framerates that are exact divisors of MAXIMUM_FPS. This
caused GStreamer caps negotiation to fail with an "internal data
stream error" when encoding content at such framerates.

Fix this by using V4L2_FRMIVAL_TYPE_CONTINUOUS. With CONTINUOUS type,
GStreamer creates a continuous framerate range [1, max_fps], allowing
any integer framerate within the range to pass caps negotiation. The
step field is set to 1/1 as required by the V4L2 specification for
continuous frame intervals.

Fixes: a6882431a138 ("media: iris: Add support for ENUM_FRAMESIZES/FRAMEINTERVALS for encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index fcbc60016bee..8f20cb281a93 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -438,14 +438,14 @@ static int iris_enum_frameintervals(struct file *filp, void *fh,
 	mbpf = NUM_MBS_PER_FRAME(fival->height, fival->width);
 	fps = DIV_ROUND_UP(core->iris_platform_data->max_core_mbps, mbpf);
 
-	fival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
+	fival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
 	fival->stepwise.min.numerator = 1;
 	fival->stepwise.min.denominator =
 			min_t(u32, fps, MAXIMUM_FPS);
 	fival->stepwise.max.numerator = 1;
 	fival->stepwise.max.denominator = 1;
 	fival->stepwise.step.numerator = 1;
-	fival->stepwise.step.denominator = MAXIMUM_FPS;
+	fival->stepwise.step.denominator = 1;
 
 	return 0;
 }

-- 
2.34.1

