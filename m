Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744037;
	b=EB5Qf1w5Fd89b7v7VSCrdQUnl00TisMC+zYakOHNVTdw0eH9ip+MezRyMIXhAl15oug4
	 AMbBna8SB3uxpbxTM03z+KpQo/E715Ss8UPJ9I7qxMMhIXBUbMbxjZvItOgFjweZD4pSp
	 JejqJ/MPsKvdN7ybqnGRpIjowv/WLoQcf3nKhw4qPH8pJ5oIo8Z4NZSRiDJHXDPaseAqD
	 tHT1IiQ1toUvABIHy47JB5ya3SIdlfP6E79pPqaJ33NxDIJpgXB5D1WP6FZX6iJW/zjlN
	 w++YB5W81J0G+iknAY8kNA5mpAtHS1INpjwApoc0/kyE+zr7E+ugmMxqIXPj4UyNwQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
	b=qxscUO4gcaTd3j3YmGigSmXnvavXtP5gx1482rcQ9NT7mlIqhnfyRFKbA3i3+G2D1gta
	 BTD1yvwAXSAdF5xgOwITnZBHVLsiaWoGCyqdXwZ5D+mieX3xbCfIf+JKLxJ9ZhQKc8AXg
	 tWVBUrpSvZgOm+Yhm9zo1gJtS+wD6IUHP/envj/4d4YSehcHS7FPC5ViDfJ431+6O7v8P
	 CGt1bbnB8iuKOhTy2zszJ0WYsztREnjMIxyn5GbXjINxtVHBxGrYaGB6uLbX218S04936
	 R5qBVBCYz79WR4enVdtV8L7Dj1JhEINDFfGtkAGLJGDPJ/e/IgflAeMsGxJuy2mLQ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+0L5CV8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="B1p9Gvs/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA2606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FCA2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+0L5CV8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B1p9Gvs/
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F8B31200806
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+q1eV+ucE2e
	Co/QY19WIgE28IiM00UBzaKhHu6xsTrE=; b=V+0L5CV8sz6Tu46Rpy/NOe4QLcp
	hPdRLeIqRd2brUOOLaNnJiUTAagJpHTU2Q3Tw+oCgy7HW36jQ9bZBIViX26c4+y7
	x5LRtj1CDaJ6VdHvLaDIPsNHMd/kebCOVuQRPyf3sJWTJzpB2b28AFOUARzfXs+N
	cVH4bFMfMMmro560yIYLlimr7rViIfwXTYRTHzb09uPmpTwjFJKu3Nh4TWooF4RV
	DJxwnuJEFGOTfBLJa9C/4Yf0wiyNjcXjNxVVA73oyg1v0k5JEaIJ4Dak4MuSnb/N
	jVKJWl+y9pPec49yIpwBr94pUfZTgDNtZq/lxlzxXpBdSAq1j25JYf7tHBQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms2pj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso719825a12.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744036; x=1793348836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
        b=B1p9Gvs/DnxMP3DDLzZQ47OcQxnLzri+vY/8ksBRhIlcpnOZonkTzA6BZo5UsljC88
         XX+Nc0cO0ZajGW7Z7ZYHKvqK+4g4owPhFX14Y2czXJK8lIQ1AB9nmPv+4tooCs8Xyefl
         dM7hhjgDAarTEPf/sv3bq+u+LnSYlFrw6gaQsj2CpMH9jJFfJEwTWMZSjvVjAZEVT007
         XGRupPawjDkZcSHN0re6ZWDI/IZ+WD5XwKmL4HUAGKe1Y6+Fx7OqMYCT3b1my/bRUaSH
         F6+oL8wXvNWOoBKKEQ5QU/4IlEV9ISk8gp1on2ZCtuqJNlEps2qUgFiofn/dQfejoRHp
         SwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744036; x=1793348836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
        b=hZEBUBIbBCtkX0ZNbCZ5DNgkGevw4nXgsUs2TiFCrwl/sJ+3oVFsjzs0AS4EdgvrZj
         g5nzmlvPLd0AAYEFkmP6tYBBVClwxFIYLrsTwASCkbNQWQL3M/y0XzNLzNyYO/AyEw5l
         F/0gTlbmMyOixB7VFRB9vtZRQrbLIY/h+sVWuvBCCg4WpsItGTHxlOaiFyBKNE4XaOU6
         5EUIO3kTFrv15U9XJAJtKneM2yiYH+aQgpJUAjL6XH7ONkWN7bacRhhKvLNtddeRFtWh
         twfM/jnI8HvyuFlFmhV8dsWPtYCFcp3daGIUqDv9ODcT013s/OWt6vGoaNkW+c87psxP
         yM1w==
X-Forwarded-Encrypted: i=1; AKwUvBw+RSGiSKep/ZSe7ZT3fqqxYpq716lzmTFCg01KRtHgG8HtWFB3WhFYnR+VRWIjxqHUEC+ZSNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9BcU4DjOrgqwz8G7SYgT/x6ZU+8S3d94Nqx+m7ygn7A+Wv7kl
	VsvP1ad+liHPfMSF0FMwTiYIcFTtozELkXpjGTZHrnaYh+ZiNhDiQmlKH5I6Et8TNIk9fMooCd1
	Kq7g5DjG74mheZW6tqNHN2xxrZxyffrKru3lJUsKnukU4eS2kI6EZGuAZyHg=
X-Gm-Gg: AYBFou3v/d6PuOuKhUXBIsybpwE2ejdkOsM0+opXLrCMfosz6sCbu2mDpePDGSiIGMf
	/yzB8iS5oki2FxZdBkY7+oZhFEHY00uhySe1NnqiKWDH3VEcX2ngUecM4ejAoyG1U4EDXCkAcyM
	/kRlXbn+s0i8gu6ecOGMA8clHAR2SGxUc5gKc8GNbM1ChBqLkvgb4UZT415Vb1YhCOlcABI8gfw
	WJg+JPpY3Qry0gd5JFWxVQwoFAzIHsTu6oMabKgJN4cynVvdfchnj+VmTjFOLKeFfkDHyQWyV00
	md7v9yePv88EKCRC8hZh+fxY+3F1uIC6DU1DxN+NjljnhILRcgyp/ziPZZ8cf7MnCAV5/IkX7Ck
	Z3R0vfp+s89CiCdJkmRlrPp/67zP6ydnexQ==
X-Received: by 2002:a17:90b:4a92:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3adce7a6682mr1267044a91.22.1792744035736;
        Fri, 23 Oct 2026 01:27:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4a92:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3adce7a6682mr1267024a91.22.1792744035105;
        Fri, 23 Oct 2026 01:27:15 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:14 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:56:59 +0530
Message-Id: <20261023082704.2859978-2-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX/IiaJi2Ho+/1
 9d+eT3uRkqLMc9CUFRXkaQK1NMqlmKLfVK+3EmJEAwzaWTGEanhN09qaV2qeD2LvkNkRjNgYUfs
 T+IUUWwp24KJW8MkqqwO9L75vdZef9fLbVbckHXpC3+crcbGiQyNg8/RJZON05/GapZAXfvgAAf
 lV7bjn0+V7TVL/OE1GM7jl0CUHSx5kFsZ5ItkEAzzCjLEoR+IvtF3c/AGLToKYJuldvD0vd25MS
 lnSiR1uKo4b0cxnH+FTVkZbAwG5NTCgABmBp/A2fG65rSklPxqRm7GnIIKr8AKkx+w8JYdmC2Wq
 C7ILgkSfMO6LPb/mbGfB1lRihuqHhrbrqjsxJ5jHtJzOd0ZuQl6cNgFKqs/ES/9nFUL+Ib2XDEs
 6lBthotmfXlSt2afx5lMPXeqtXjWNHM6cXGzlLwvNFueY/Z23au86DKisUCFmluWD0Gmkx7ZDB/
 iuJViC9rbkuRATnqOBw==
X-Proofpoint-GUID: kkQMVgAIZl7Y4JcmzcTCTvIXIEd8jNlq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX9Uo7hECwE87s
 kvmtU9p7oNOmvH5zkBjCOP/urFQcskK/LCEZlSiWWrl37kHrR+8IwERXHt2SUt1TXr0x/dWjix8
 vtL5btaBDTl3XSti9MTSGeYjkVHp6bA=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb1a64 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OoeahSk16-wZEypY81EA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: kkQMVgAIZl7Y4JcmzcTCTvIXIEd8jNlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230033

Remove the compute-cb@9 nodes from Lemans device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 695eae1b7256..5481dfb73454 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7861,14 +7861,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2149 0x04a0>,
-							 <&apps_smmu 0x2189 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;
@@ -8000,14 +7992,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2949 0x04a0>,
-							 <&apps_smmu 0x2989 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

