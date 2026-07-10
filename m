Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91B1ADFE4
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652070; cv=none; b=JYLx2ek3qceJJDG4hCHcR09ictk5aKQETUyC/kKHEPa23iaw22yU3E59fUaI2vNs8gTj1VDW/sI7reXdZlraRPI/42XNlAAkHJ3j3C/qaMVctr5sN+GPcpeRZJEmspKlthAnGec9IwfdSTCGgxNmXyQoWHRxbJ0X3zIapGpPato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652070; c=relaxed/simple;
	bh=ZRQ0rtnnQB0Oq2dtTeQphk53sePamjzWEWuDue98Mlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRS2+e9kMq7JpZk3eXVhhqof6PxQFXgASyGVd5BogRV+AbF58ux9Ch++pVkoJwRj+mh6z95w+h9TZSY/OZaZnsYXuj+iWeExvgdHQrM1Afuwlu3+Z/eD1bWqukhtCjh0fQa2OkI4a5e4N1FsCrEEB7SR1gQoXdAbZ5Vnahkgb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnWYbhuX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hdp22n5G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnWYbhuX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hdp22n5G"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HXdNd2475553
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8srnsUWvtGuuuukabgqd6mjKla54hcWqMvwIgpbUTnI=; b=GnWYbhuXMgrgxBbG
	kJ2uEbofdKwgT0U/ixGKBhVZX5C3pyvYLtXuty7G2FQiL0VW5eet3RWp1rHzWUtg
	RC7Q2ON3TLDE2wExRm0s9EVQD39ksPMEq6eGSwc1eRrvM5oRaL+i6EzAXpig5KsH
	VxZ04CzldOOQgMGWC6BbH4pPxz9RhEG3rt1fx6QIqpzNSl4+LHniwzGqxC9/7bGe
	jpzNsoN27XhsxawFTyfJY4v8x92iyMOFHQUk12vs0j7JI9DPFsn2XPQ0Ytxhmfc5
	nwPFH1+3LqWRHw5d8OPSQLQnYFhy2fJkR2wemy/+q99+LSXerKl78orL4gICnUdB
	YDvN/w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mt43s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:54:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85798977dcso709136a12.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783652067; x=1784256867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8srnsUWvtGuuuukabgqd6mjKla54hcWqMvwIgpbUTnI=;
        b=Hdp22n5GJdkupe1PjFq5Jl4/I9pfktiAZPLH9CvPKNwzYj2CecJ6Zc5DOXrfWVbDcM
         qOJvV/d2u4BJQ2W6x4wNAz5pfQqh+0dW/5LQLe2zalkfbrZpWVaEHWV5fT4YYMSfN029
         wva72pyl+6WAYU7/Y+pCdDTJGOqBxcnYFbUcOLW/Rp10p5YGFzhfUnhz1o5XRUPypZpN
         9AWjXFR+J7VkvR+W89Z74ozpXFbM/gdxDJA+4wQfithQTnMKCUONYPWUCbXNrRAkbwzN
         +aa7leuMMmpCEUQ0ZcyNHIUm0E0uVdW5q4Nw+INFoiEGNGvnT5R+kjrDo0paKqHGSVUR
         lV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783652067; x=1784256867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8srnsUWvtGuuuukabgqd6mjKla54hcWqMvwIgpbUTnI=;
        b=PC1LM4CZifcyFEJMfHPrH4Metjptmo33jyPPqW9UpsqhFCP+Ku2hA0P4oZ0EdhDkAy
         27gtwwVfracT6+BRPY8pvxUq1ggC+db1q6xJ9NY2pe4OZ7g2AdezZzyGfIEwfe6BNnQ/
         lrk1a0//jsC6V1N7SqFLHG69qfdtwQNw23QGmsUqCptoRmrfF643o6KD2rg/RV9IZGF7
         vgt7IgYd6jsUNTjb3jHLBUBm+gMrl0ggL7s8+f8UbZFfKzjZvEee5YVdavqv6XYFoWDE
         LQiMhwoLIwyZF/lLb1NevD+1hZGky3doyVhPt0Sfes6KQdyG1H91IF96Ox1ozApeqQ7H
         hHag==
X-Forwarded-Encrypted: i=1; AHgh+RorSh7DcqjhqQHR7Q1QeBmfYukoo0vU0Z0Nqc8N2FUQaaZuz7rnpULFzNQ4ZM9ABvcewNbUO4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlY+d1/bSAWhtGIFS/Zcwsuiqv3V9gPZNW+LKlwkSu8tgAPqaS
	OR2Mi++TrYlm1oL1vUtwHx20gO0CHKqaXJt/0QicTDKbEY9a0r8GcPO5oAGvdHKRXABD6LA+2VW
	s1cM1Jqr9CyjlZq2VcOdsOgPuSE+pR3ysOCBkww4JRTBQTXVg/FTi60Ktado=
X-Gm-Gg: AfdE7ckFCsG4e9w4si7LL1o6HxN60tuA10RNMpWuuEwdjocRZIraArLKLy8GtSEp+U+
	80cZgLbecF1ddrqIMFzPWJKZTtjzid47rRp2+BEVov4d7VVoSSDst1D3oFBdRowNpffQFz/ZACd
	8IGSwtgGQgmIHR7zANWTkSxU/FpCTiEWyz3DY6ar7spy+5I6h0xyT46kl24d9H63mzfjwTP5e4M
	WJgSNN+73g/c1XtQY3Oi8wwXkiMLnZysSZOqNGT1if2boHRVUOayPlPV+/0Y9OXQmFVXOw2rLkr
	d+BHbVBe4C+g9l3Z0ddBejLooEI56hXriH1ZMsy0gMXtF/xdnR1Pd5DrjH9wPgogiMmOEaMdAef
	jY+vUiTk10mY6d2HzTTSqKPqq6QYIu1HSYPyDKwSKPzii
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id adf61e73a8af0-3c0bd3acfb6mr11104567637.73.1783652067236;
        Thu, 09 Jul 2026 19:54:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id adf61e73a8af0-3c0bd3acfb6mr11104540637.73.1783652066768;
        Thu, 09 Jul 2026 19:54:26 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm41843220c88.8.2026.07.09.19.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:54:26 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 08:24:03 +0530
Subject: [PATCH v2 1/2] media: iris: avoid bit depth validation for capture
 formats
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-1-701d6dfd1ac1@oss.qualcomm.com>
References: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-0-701d6dfd1ac1@oss.qualcomm.com>
In-Reply-To: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-0-701d6dfd1ac1@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783652057; l=2168;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ZRQ0rtnnQB0Oq2dtTeQphk53sePamjzWEWuDue98Mlk=;
 b=15LLH6rKDf939RdkOMJKOw8UWOxgXGNM5upSQQzewjZB15bas81M3g0OgGdZLgTWxxN2+9OVm
 I+MoJDYRt3wDX0yx5mt73PstfhI/x/CW/Vv366LqmKLKIuKH20eFs0+
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: FO_ZztuDbrNpCaYofybG03ZZFk7W19F3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAyNSBTYWx0ZWRfXygOfQOA9iXv9
 omlj0Tnmtx8iYlJeJxJOeaBUzBHkfumTLLpEX54UTdcye4453bYcCdYvyXMHyhWgqL/hLPjtghC
 mz3lVuLuWbhjf6PaBybS7fyOudyr/Zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAyNSBTYWx0ZWRfX88xEf56BvN/G
 2et6JhgZHhDi/dvWkRcpfapqGfbmyzF/SRH32fbSOnQhzrWnFAfdux41zuHY0jOCgDTldUU7tNL
 nqKaDvO70tfcpDqyivSJOn0J3uVccIGyFT6bHEpkzGzoqBITjICitpILP6P8YOM4mA9/lGG5pH1
 U1Wux9kmq6mJ2e6Jfh23z0N0ygQIEVPTrwqkvwfb4LZcleppofY7tw7T7PayL6ZqqgvTdsGih2s
 USOQmLeVy1YXB5g/jhdn9BgWal942jM+ugxIVLT/4rNrFdaKgVUnyHq0qJ2DFi72+Q8dPKnpn4U
 TCJjGREju1NOBkK1t1JTci3Iqk60jQnyprd88W0T7bZqlzgFwKQWclBs1zRW06D4PINt7vxgPsB
 wA+PwnlN0BwcjLzF/j89SIOG3hkvflcOpkOpYPfRuEOOaRqbTFjHAaldSKjY5QJCXrWpnqUjk4Q
 f2tM98KJOX0IwMqFmzQ==
X-Proofpoint-GUID: FO_ZztuDbrNpCaYofybG03ZZFk7W19F3
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a505ee4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vL0Q6q4W2X9FnyRf_zQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100025

When validating a capture format, check_format() compares the requested
pixel format against inst->fw_caps[BIT_DEPTH]. However, the bit depth
capability is not available at this stage and it contains the default
value of BIT_DEPTH_8. The actual bit depth is updated later after the
firmware reports stream capabilities through read_input_subcr_params().
Because of this, a valid client request of QC10C format request is
rejected during the initial format negotiation. The driver then falls
back to the default capture format (NV12) and stores it as capture format.
Later, when the firmware reports that the stream is 10-bit, the driver
sees NV12 as the selected capture format and switches to the default
10-bit format (P010). As a result, the original QC10C format requested
by userspace is lost and QC10C decoding cannot work correctly.
The bit depth information is not reliable during the initial format
setup, so it should not be used to validate capture formats. Remove
the bit-depth checks from check_format() and only verify that the
requested pixel format is supported. This allows the format requested
by userspace is handled correctly.

Fixes: 20c3ef4c7cae ("media: qcom: iris: vdec: update find_format to handle 8bit and 10bit formats")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vdec.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 9e228b70420e..7f89e745a4b1 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -95,16 +95,6 @@ static bool check_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 	if (i == size)
 		return false;
 
-	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-		if (iris_fmt_is_8bit(pixfmt) &&
-		    inst->fw_caps[BIT_DEPTH].value == BIT_DEPTH_10)
-			return false;
-
-		if (iris_fmt_is_10bit(pixfmt) &&
-		    inst->fw_caps[BIT_DEPTH].value != BIT_DEPTH_10)
-			return false;
-	}
-
 	return true;
 }
 

-- 
2.34.1

