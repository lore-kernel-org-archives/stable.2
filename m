Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391614;
	b=evbWZzzFn5KQc+FIL2heclIUtXyEIL5mKp4kJZOqrHmvFixaxTCgx3jZ+seaYTK13toP
	 9SYpUS/waK09ItCFL7kdS8R3vrbFDaYEwBqoaUqrttuOVgejUH1mxfb4O8ZUjiwLStk1P
	 XpS6/Z7oMIZA8NVwf7edaTlzP83mvcx4J1hz3wnhuMNS4F6822BSrhWbZJbs6vIU90lZS
	 CL0DRv00ll6DbZGZ76xiLFI1uuw+Pb49V2JXlQNrC2kxrsV/BnqTtdv8qk9IWyuz776aK
	 n3x/JVMWRdnc2wgO2Pa6eKqjpP+t3ap0wQFo2dOESUPXWmIUkMO2yvT+bglGxyB1vrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391614;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
	b=MVF2qToZktD08on8BVnsKd1ZcVRYpH4y7TltqbWxiyiV1NYW20nrfEIiJ2lAYIMGQOo6
	 DyYJ0QIBjHCS9fT95E4OM6ZMkit8bqSdn/v9KX6GdzgZvxmIHaiCvdbLusKPOSFuiZ8t5
	 Pk5/KqfZMo8rM8iVPQmEjgrR97crjV7yYCBUGyzAuDw8t/cPlJcamYI6Er4XSdMOMIRKU
	 2YcNz3YZNRFuCK4mlfI64nUgk49E/wO4GGJvJIyGLoIBJMIkpT0zLYuVi/ylUe3TajJxt
	 jGuidbI8bM4eqz4yVol0xo4urNdONfShdoRwpB8OCTq1k49tnVPp8O4Epuuz6NBTLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9PCeNAk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZ56mWVE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD4606A321
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBD4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9PCeNAk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZ56mWVE
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIcklR4118816
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=; b=c9PCeNAkIQY7B6SD
	CRKBDrmMKqxNYarijMkARimArCFg+5WcKzR43Z3j40ITGS8sxFfqbOtG0JZcbBg1
	mK6Q9NTbvljTcErpe6FCShVXCqo86BSrK0rrW6W6neIIMOA0AntP6Zismkhk6GgR
	aG4mpfXZiEcwLcGa54QEPuQcElxWkHmRTGTSozemjkoh9ScZGgyJFsbuJrmwNkU+
	IsWuNF40mS1vbR7jLwu1BYQAIA7t27W/u69v3CjxAQT7WTZEX/SMO7fSPZ1Qc6jV
	3Xjcu/KfwfJKBcY08vxGlvgW8PjidnE681izC5H4drJEFTJZ8xMHC2BNT3LRg+cc
	VYosjQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu89t5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:20:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2533901eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391605; x=1793996405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
        b=MZ56mWVEppdaZz8RCG5V/ta6hnwFCY2RVJyr6F5wCcSIpgnvf8pABCXeXnEz43n5BV
         9DvlPpzCBqXlCAQpRTZYTy1ARnMSvLCb/WapYtHMMY0+eKMgRKSt9ONqgd22IL0SBBaK
         U9sykCf64+RM9L100is21PZtQ0VQR2zjjmBl69QQsh1fIulfimdHWf6mAAsXmDO1S4si
         sG50pak4cfYUSq4/JTLTFeybQNIZwmyb7MGWT5BVCUO+JMrxJBjqdSxQIljQvp4CKpef
         zPZ7oXe5wU2FLfjlRdXviYq0Tzp+A3as7nLaNHuBwbq5N/YNK1//hZoJivMVObZkti6l
         Obsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391605; x=1793996405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
        b=q4nVGwbbIr+q3mW7UFnF9CJL5oivoeSCERaXwWWVP3gy8/mpyypzqS9Zj+a2gvVwf8
         /AoZK4+DwXJHu5IiPEuS2wulqe3eABAN3y/yAHwx+rqGrMhZt+xv5xW/dH4if0Qy0O8O
         5JfsKWEqIJr0SK7UKAnJnRz6jKPjOKkrDCjF5Uod9bRSB2MzC0yVdKgCA4Hi5J/X9eNX
         wItB1Gh5s3cDSeiWgFZEYIMFwehgoBRGep1awd+g5UzPuLjpHc2aYTjvrBIRpsHPL3fh
         CQtSVBjYi6JIQtCU1jB/g4fqV6xuAvYUkdxOulCiahcN0/NQ9I4aMbWO5S4z1Z2VPFV1
         cBIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLC9wqT8bgAOPQBHHm1unTuaYuEfild7hUWnOVabGYqqSBJMRK88XKwDCAoemCeIJBtPsmKyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5rivFvO+NnesRRl3F6V6IASSPsy740rL/Eni9pUqoCm5e6nE7
	HI7nOjmpMBzqyfhVuJkQ+UAByeH3ggkqieqj0o1q5vPPqGQ0/g8C9tISYLqI5OMZkIRkVegS8YB
	9yeTBsuKh2UjrW6LjvzzvCqoNkWVcVzxllf8M9S/sypSTPZ88DzZpYqQbXd0=
X-Gm-Gg: AYBFou1HZR1ogs2HT2dq0+0jKsc3SfD/sKwGKyG/KksWfsVxv5f7U5Ww01YMmal5Nr4
	l9Dme0dnqOrIulhLHNXMcb7NgzxSBqaDPPBau8WNtuHDsxGf20f2Aagj1byPRE9BqlhNdrgfm1O
	Af66NcvPuNPY846d4HJACa1KDttDmeCm+mDsKoVt1fRkHkfjn6RSNnwWr87XxRaERUF8JLR5UA1
	XZZZRHZdFjqI35nV7M3Q4gMMp5srDk8lrTuG/p9h//esNEqsZmdO0/bL6IuSzu+8JNe9i5HjOb9
	fuP6ZisPjz97vyLkQyUrnGy6w2Um509yTdT3BNIhIDOuWTnp+hRVfp4P+gCBp05fZBAR65KpW8z
	a1Obu5F7JxW5A7AFXoy+cf94TeFC4QM71J8SGd/xTTYUw8Ee5bDdT7rn3yQSFrOCHrz0f/4I3KU
	HdMFaj9Q==
X-Received: by 2002:a05:693c:65d2:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-36a423bf43fmr4432688eec.26.1793391604400;
        Fri, 30 Oct 2026 13:20:04 -0700 (PDT)
X-Received: by 2002:a05:693c:65d2:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-36a423bf43fmr4432655eec.26.1793391603841;
        Fri, 30 Oct 2026 13:20:03 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm9300197eec.0.2026.10.30.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:20:03 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 01:49:11 +0530
Subject: [PATCH 3/3] media: iris: Use firmware reported count for output
 buffers
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
Message-Id: <20261031-fix_dec_seek-v1-3-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
In-Reply-To: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391582; l=1644;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=w2OxykH7sbFu9wsbTswZwhTlE3jYoJAIFTL8aWVq6mc=;
 b=/7IpBs82XJf7ZOkyCgyvFgHeKM15bwLLOH6zmIi1T1B6daJbr34n7vn2DkScsKUm+/zR4obkm
 udz9xSEoYXGDRx55vAjNN/Gf8K2dX35xni5P4a4WOyhkmfiTtif480u
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 6SST4g0Pgg-Rtsub_7UJTlV8aXOK1_1c
X-Proofpoint-GUID: 6SST4g0Pgg-Rtsub_7UJTlV8aXOK1_1c
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae4fbfc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ngQ_FiyG7nPeVDEeuhEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX9PuPcVnMIWIa
 p1/XvsTt/lt4/D4FUm93Z9xL9iJY+aHUa4oyJTvDOEAHQgrcnmwBhNPZeQYipNXBqYhxtLkCzjz
 mNWFgIe65wj0MhkEaQiHa35p3AGDvbQWF0FAYD0EsDcjqCxIODgiBYN3leek0yfmKg03xJRkGgS
 7qm3RLLti6CmoTHeyjT0ZaRIoxRg2H+OoYgmGfAmmLVjRxwIYGtO8Z+caiC4R3Qk2CeC+cniORZ
 /fiyhNstPrUf8YBLsHjwlIv76j+NqZAyUQExE5nNMyUUXIjdKdhGtzwqmoJXS0/ZAOJFjP1r7cP
 ZFdC+fVVSWCT9SUhB52lVNyhYp5NJjD7a/trNmVQes/mbqt3B6f8F55dT+jgdANrqw4uEE2rh5G
 WnLpShpHvIaz1V8c7ZtBIKTgt1l5PtS/pYXAAc/SAsWA3k8Txco+02ClJcewi0n445lv6vwoXca
 aIV3HjZDWPzd49BKl/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfXxKnSJEIN1km3
 td8gXAI0WApU92ZTfV+vNhD0mg+hMEHaSPMnEzJWjAuzbWp2I5CYin+JIAdUKaKDR4ky6IvI3N3
 VnucyEsnb2YA5JdECZDXvTrL5k1M1/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300081

Once the firmware reports its minimum output buffer count, the driver
still caps it to 4 for VP9 and AV1 when split mode is enabled. After a
seek, the output buffer count can be lower than the minimum required by
the firmware for VP9 streams. This causes the firmware to report
insufficient output buffers and the seek operation can fail.

Use the firmware reported minimum count as is. The driver calculated
count is only used until the firmware reports its own requirement.

Fixes: e1f5d32608ec ("media: iris: Add internal buffer calculation for HEVC and VP9 decoders")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index a8170e5fa9e6..57467c952f42 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -2375,14 +2375,8 @@ static int output_min_count(struct iris_inst *inst)
 	int output_min_count = 4;
 
 	/* fw_min_count > 0 indicates reconfig event has already arrived */
-	if (inst->fw_min_count) {
-		if (iris_split_mode_enabled(inst) &&
-		    (inst->codec == V4L2_PIX_FMT_VP9 ||
-		     inst->codec == V4L2_PIX_FMT_AV1))
-			return min_t(u32, 4, inst->fw_min_count);
-		else
-			return inst->fw_min_count;
-	}
+	if (inst->fw_min_count)
+		return inst->fw_min_count;
 
 	if (inst->codec == V4L2_PIX_FMT_VP9)
 		output_min_count = 9;

-- 
2.34.1

