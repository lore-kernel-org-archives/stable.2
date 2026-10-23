Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744057;
	b=qImx1xZS4f6Y29ST8RgxXZROe9+v+/FHwjMO6al4OyvLo1GSkf1V8iCFPrJlCWArb+ZH
	 riDiSgeiE8uaQoYdA3ej5jsYz7W2Bkwbt61z8AwS1KWGU1f8TU9mi5Ns+owtPZQR0jzsH
	 NOY3s/9lFSF04tMSKn6P8luj5NR9K5erXOHqDgRWQogaK1wsNZZIkBe4/aozNNXbOZ7A+
	 InA3k6qRpb3AUj5J4aaNnmHDv1CcMEfiOhLD95mN+uhw96wnyWNYWKb3ZpyguAviuo3yl
	 BLBj16j+WpUDfAt3MtC/iiEAD982ogGvGK8WUQ0MmmfQv6vm7naTuw8XV0JbosB1riQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
	b=fXAthITfSvEkAyaxNJ8JmwtxmRLsj/1ZVSSMOBIAwNituFJsz43EjJXBtTKvy9HGpTic
	 bUMXRN5zINkEC9vQUPa7wvszYNsd8oIefFjXN5ZmEwAUDJDopd/8e29L0rEXkjEqxBtrB
	 Q+XAY5FAdbvGUjFT5RCxgvD6l2EaslM8EGYrok2sp00aOUTukWyt0xFPoTScbR1FT8m6I
	 IIgObUvU6e6NKSBcTEZI3wXbKYJS1s0/lVc96jeo8wapxcF+tVoQELwRFwpfbyQAvOBK1
	 brXiNTaosxN1ok0SsxtDXmD5xqtDPICfN7cfJLWvf+nuKsdkSf9YQW/ytzqO/RzRVGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5t4gx4j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGIzS7ay;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5t4gx4j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGIzS7ay
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9bt2067825
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EhRIYoT55j9
	ig8mGHfIEupQGVMISzGazIaZrj/4btXE=; b=A5t4gx4jrxgMxGIDA0ijGAM42Ff
	WnGlbH+BXSjBKpC7GL1GO2ZTW53X+JzVkHZAuXWCGR2cSUHW18Wp719yfaFeYPRh
	N8eiOtDZeFCsLrTuriBbIC9MLZPiRzmR0eS6bodO5ViZQxjzMtj85jMAvCxrZ+sb
	9fnWxSzGZEwJIAaPRv4QuH5ovkA4UprmWRlI2HBStP+UvhXtvB1lKdM0LvM4H/QB
	/klKA8CY1vjMDPzZ4xYWImKUP3BE3YuHWo2W3R29s81D+EGwPiNEEoKdOYN88Wlt
	mecUVBNGiSmrIJ0U7Ps0sCopfjPq59lR6hnJacGlRemptoz1fI8IxA2JBNQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw37yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso730098a91.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744055; x=1793348855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
        b=TGIzS7ayy0rzIZUFUAVWAGAyLzgVWO1/fW0eesc+qZSw0lNp6308WuHbQuUjoBZnMO
         3hoxw/YVLbhALBYpZZZal4KIAzI2ZoI+VWMnYpBq+nw7iNxCpXZ5kfyDnXr1SRgAnCk/
         UB/U+cQoW8M0gNPRh3Oxnf/pKuH9y/3IZ88PuZka0oxrxj7YU1L5p3UXgMf2WFb+QZi1
         mFoTbD3eyyvSgA5Bn9rU2na4Sx8LH2iOx+Akv1AsnAuTVVoZDS5AEjkeUcBAp5cDLo+A
         Rz9BznZlUv7z/YkPqpl+kYA+vpGMqFthLmn93DqINhtKHU+JdcQaBaIS57iT1495ieSZ
         t0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744055; x=1793348855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
        b=NE6knGJK92256DDHWgc8Q80V2SjC4GzDC1u1dN2xxm8Vb51Uro6CP9pXfZzII1vTPl
         rAzG0FisLsAwOtAdmtRxzwleKHPyjNrXfpkxo4HObCuSdm87LGebG4bhkWJ8DGBQq3Rx
         aCJdQqktEmi29DyiGVGX2MA/v+3pJc+TM6Lg5/7eBjMQhV6f4ohdNya18y4Q/5+jeozv
         D1JowhKLazvXTvD8f6sZBTXYbQHi1kNyK3ziibrB2UaKolXW33BkLmR7HaYdjqX8fBkL
         g1p0P8GlPjVE2fsFR+EcTsEuj7dYpGJkLX755WPElEC4hF3t3eFjVCy/19u7Fui4Q1J+
         Ye3g==
X-Forwarded-Encrypted: i=1; AKwUvByijzKfvOTV+2vycmndLyEYsmEC8HXxRZj1Kq7NyMckAj8WzJu8KKTQ+Ax2N1cwkce4O3kVW5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKojW/T6+CFpyrD0G5dhM5l8cpL0s8vd4Hbshl3xJPZEEVmyz5V
	pBik3BOn+S1Dk77FTeWOkJKa3K5v1jvEwIMJxa7TN0O9o+E1+2CiVFWZidjhlD9xwjouVO+I68A
	wVgXAXGESuxyG1vQPU00K5sLmUOzY/BcPJx4lxRmoKvSgikXkVc1/eE8Vr6E=
X-Gm-Gg: AYBFou0j9qsA3Fni05ARtOeOJiF4PecSysMshG2ytOvjyp8MyFTcrm5TjQ7o9gvEpc9
	Agh297RlyXESokndaeS4GyCMLnyqHZkL/W1OLTVeZuTtoO5H3qcwWHF/j9hw71HrpF6z7z29ihM
	72+iUNHY4FoUvprjB9viAzm0ScYr2b0Hvs6drRugM9/e05G3xsyH+boSIka9frsG1UGI9M2wgP1
	EYrBr2yME2DiogvqNvIM95dGx4hbIV1eykFCYQRKZtmsrQp/b/bL4lh3OIuzrQA8LSrARW0wr+w
	XPJPhC2PnczI/8Kf1rzCF/6oe9+CtmHM4iDXuTA2VxwND8dgn0K/eQIMfoAfB6aXrP8+UQTEvXn
	CDmvURoO+tW5Qmi9YYvsYf3cZi+D46pCQBw==
X-Received: by 2002:a17:90b:3c88:b0:3ac:403d:6232 with SMTP id 98e67ed59e1d1-3adce0a49e0mr1178637a91.55.1792744054694;
        Fri, 23 Oct 2026 01:27:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3c88:b0:3ac:403d:6232 with SMTP id 98e67ed59e1d1-3adce0a49e0mr1178618a91.55.1792744054206;
        Fri, 23 Oct 2026 01:27:34 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:33 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:57:04 +0530
Message-Id: <20261023082704.2859978-7-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: akcaRwidXjOYZPl79ddId1WPgg3hVEaV
X-Proofpoint-ORIG-GUID: akcaRwidXjOYZPl79ddId1WPgg3hVEaV
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1a77 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vzw34t4vhacumBYsXzkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX26o69yIlx8lz
 hlkLgi27N3la/BMwlK2QRMxqbk7+aodXXqGgLnCkaT2Frr3AnRhLxx1IxHahcTm3HWoyX/d4rfZ
 +BaR4FSKYCg/svMXAW4kpvhZhmd3POs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX8Iy3Vu1g2Y6H
 LENBv+7THkUEt3x3ujABXFMkZL2XdSuJvxmaH7C6pIXPyFnHwK8bNXfS/oWg2jqM3w/jZWXTPUS
 UIe0v1zoRlc+kz06smeT4IvlgIPmcjJkJGwl5RlU0MJ1LKiO7P4NGckshYVDcHVPk3v/ULtc+DA
 5aNuIM0ak9aezJKktW1qxH+irXkoZMaz2nkvJdwNiwm65GYDngiNMpCvlfZKsSGA9sFox0OAt7+
 fkjKjJ4c1cK70Il9t28aQwBw5NWRhnc4X27X+9M/aD2Zi0N/ZTTyw3OFBMvmR0U4D8uf2KNppZ7
 Lu1JKxKPD77o/o0ogYik+HfV2XGwW0eg4hEkHCO9ngcWf5q5IQGhQBRaTGihswsh7miB/mZxOGX
 42ze4sPgp7cZ1XoGJBCICv6RerjqP6RtdhuXtcP5LdqO4651L+TuBQ+VL0QQrgR56ZMob+EkhSy
 5OH28TlZkedQazi4S3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

Remove the compute-cb@9 nodes from msm8996 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 818e5660df91..51ef306c1ce0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3701,12 +3701,6 @@ cb@8 {
 						iommus = <&lpass_q6_smmu 8>;
 					};
 
-					cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_q6_smmu 9>;
-					};
-
 					cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

