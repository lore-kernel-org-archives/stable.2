Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940B3932E4
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569895; cv=none; b=ZhPVDrOpipwblWzcLDurpMAgruGBF4pnf6EwdaVAz76IBp6t1iRHdrSvoEFuejA8pkVHY3nZFzlUDGavFTv+hpfvWrFe+nfKbz8kWzslzM9JoFb9quH7U2KZnZ5sEt+SKtY8J9zrtGOKIcazkoYB6D3D9wZdQXT+gq7ub9lXRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569895; c=relaxed/simple;
	bh=Oi2ts3pd2reFAvM9hDgXRQssR5ZUrOVAm9WF0/xVRBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAwzc2d8uWG3Jg1nPIkanGSkNzPzQ6oksWqWw+btwP998dieN+404fhka6WzlLCLB99hDi1Iz6OkXdaQEGYtj/V5P+9hYQncbb/yNJqpOA7WD+Zx6n7ITxokiVPiTopcwjKmgiQG67i1tu+YjMDSPW6n5LCwF3YWKVtF8AG03jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4IKIEEP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gTTaCw6C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4IKIEEP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gTTaCw6C"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713LWnw2059785
	for <stable@vger.kernel.org>; Sat, 1 Aug 2026 07:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CydxYBTX6LpQq/EH4Ur5mtxDb42yxKY1KInKEWUphhg=; b=K4IKIEEPSeChHgSA
	g+ygQgPpawXkDVWsZphW6v8eQEX37ZthOPUhYn7gnpXDQhcemPPZMQpGqjuXQ4Oj
	GQzjVprUg9Lsj+rFrfWO76PnCBFSrfxz7kHBDmYJRnEndu5uLaKALZpid48wZNk2
	miH+AYxctrYSFVLozW+uiuPWfYDgg5nW5NZOu/J71gYdhihW4xj/OvkCRXd05qBt
	LCyDeh2XJwTWSDpe+3Sxy/tI8ctnzr9cZ0ZeSctRJAYlHUj+U0ZCnnzwRDU2IFrk
	Xu73dyw+TMQ3sERzB/nsNeqhydvNI+R3r9exNAqZ6JpCFh7bIuVutogGvKroEHb2
	nTTbgw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx0fnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:38:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e375d9736so2629826b3a.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785569892; x=1786174692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CydxYBTX6LpQq/EH4Ur5mtxDb42yxKY1KInKEWUphhg=;
        b=gTTaCw6CEGVi0AJLSkjGjKuJUgwzBY5T1yN1ucdxUGGnhtDRN7LKdvMI2OWBibMtqd
         ASn4bZZ4gQZSFVB7ZXfLlvt0ebaann+L5kFg8qklAkOnwe4+YYbppxEm0gkpgaE3gjqg
         bCTo1Cs6L+83z3MYFHw+xAOext9F7BxTOosClxeJ8DIvhRHEQ+cIZkjUZWep+IKWB30R
         gQJcc2rTPlgY/9Uwgfv+MfwZ0ntUz56zup+lI/HCPLtrf5S+1h5UJFA0ZvmkTLUyBhCZ
         4hbZAlYRTyL5aWV3KF1dFHUtcIAkIcYRd8aqAQsJL3N8D7fHWxVK/a1R4FK47xLnuicl
         qzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569892; x=1786174692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CydxYBTX6LpQq/EH4Ur5mtxDb42yxKY1KInKEWUphhg=;
        b=h1TNCBpK045sk3bzhVZdXV5uk8Bj0YncnzXmWCTHj7u7zfQQModNaFpuOAloWi3N3h
         ySU8Tu+eRIVi2442kzn1sH8GIMv/T5+8GKM/+hdMETXGyYGsOij2OnzBAI1qTf3O9Yqz
         BaXoD1a7R3kwJNUZ3edA0ube3N19p3W+Fsl4YQYZnxPdixQzRL309rsB2fV830/ls1h5
         N1IUfHno5YsWxvZSzjLBkr99Qr+Dz+Q1gPx5KN5JIUuUmzV4rIpvoQokMAZ4TkHdz/L2
         PJCezunt9pMGpsy4uKdfhuk6q+F8A80k5tN0w8qJUwVMtk4wIgdVVbEoNuP2rqVFI0Ub
         1pHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPN5Y3gf0KrgRtsrbmDTkY9bPbUYFWv3pXUvpQ0ADwQBOpON0MkXWCM8+/RSJjSIZe2YLbgok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatAJJJ/bPzDwcECMY9SFMRPqogE+92wW5oHCQ7S11ZmdYMrer
	udz582OXq2PMAPbq5Bm5NJvmzRQiiWXafezQzo+08Tbb6XkVKr/Jbede7VoaXOiqSs0mLlQK4M4
	40RWUlU4NbD8ZidrZzFeiLN5/OAlKaABV+isl3IxRQUfOWKx9YwWky8/ALD0AsQtIUEM=
X-Gm-Gg: AR+sD108/K5ghuZHJT63xBNLcwJD/gsCXtdHA7B50BCntok1NqX3ZzgJ38fkH9+6yIu
	kbr8rUjr0ZKPEg+3vSRXerkuhIo7gwxwDPpdt1Pv9bjB7wpZWAzYSfTEW6Yec2eO/m30+wXtP26
	7Fbhy2xzkGEC7ROpn5gTl0NQq1GrddkJr2nplNdZgUyT7br9GfNmnfj8l84z43BdyHdMDZb6wue
	1R5sfeuzq6B5i8vsI/7mdcSj9Vu4ODHusXMM7mRq1GwgRUhIDVGcX0WjU8Ueh6OuG4IMdRSfJyP
	RkcDTsw8BJL1nnbGS4VXgekJx8ZMnoePLscVV9603vbqUaGRBaGHdST9l/v9AuJe/aUsoZVS9qW
	RaPJTTnXm/ChbRE7xT6G+7/My15AwPwc9UA==
X-Received: by 2002:a05:6a21:9206:b0:3c3:8f0f:b6a0 with SMTP id adf61e73a8af0-3c92a813063mr2664458637.49.1785569891816;
        Sat, 01 Aug 2026 00:38:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3c3:8f0f:b6a0 with SMTP id adf61e73a8af0-3c92a813063mr2664412637.49.1785569891336;
        Sat, 01 Aug 2026 00:38:11 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm20729985eec.19.2026.08.01.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:38:10 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 13:07:28 +0530
Subject: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785569872; l=1722;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Oi2ts3pd2reFAvM9hDgXRQssR5ZUrOVAm9WF0/xVRBs=;
 b=m5eSDcINrEApmPCymeCVlrmeolRlRb4OSogXRA8j9ihD5GJp6rRiN8Qrf4MFn+gPj5q4fIK8k
 hZ8SADBzTWZDDHtc3K+K3CP1lo1nw3cmrT/nocQG9HPRHmqNk/ul7M9
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfX98pAEhaxyNCF
 3t0eavgUadT5lzaSuYKmfDMGXT2ljBliOdwiyLIPuuP9tj45mf8g1KYFhBwBDz3tuNA2UtpDATz
 jfLEdQy2V9HIdILsRlXlLywEqerkKCKLPHzpWR2IXCBv/VewUiBo2aH+mnvy4OwUtoRGqP8CERo
 YLQvugOfv9akfKuOc6ox7eowLA+hjy7nkHKuHSi7Ui+aqQ2iSE36MHszXBg6g4EZ8nTyc1jLIE7
 nUpPWVHMDYklK1ghfsQEGQe7TPMy0aAXS2zTWrGk7sc2z1uxjxqIpv9+PmYK8aeI8KTs/RD9pyo
 LeAx0fBV33xyg3KNAve37q1rTtGAn7P5eGD2if40+D5GDc/6cCL/95UK8Jh1C3og/dVaUCTQXyD
 rkRmohqwWYBAS+ZdNaBg4BjbUSPIq7kALguXC7iZJ2QuQq+yC+g4i2/36SjPTODbstTSbqLQkOC
 Wh2hG10g7nAusyXUzsA==
X-Proofpoint-GUID: c7VKIyWTfSmTM_5s2Qq-awuScSrOIF4I
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6da264 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wPaHxwV4LXfiR_c0ZecA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfXyFb11gHFASky
 7Tw8wR0PbNYUh7hgmBhA1+GB8OpOYLrpF6trhg71387qthjjH43kyGP8g3fAkUXr5EOaEPBZ9uV
 QnNzQzvlc7rb2nOzHkX0kMm+wy7lRVM=
X-Proofpoint-ORIG-GUID: c7VKIyWTfSmTM_5s2Qq-awuScSrOIF4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010053

While testing with some higher resolution clips, the venus hardware
triggers a fault due to wrong input data being received. Corruption
was also observed in the captured output when the client dumped it
to a file.

On debugging, this was traced to the venus node not declaring
dma-coherent. As a result, DMA buffers shared between the CPU and the
venus video hardware/controller are not guaranteed to be I/O coherent:
CPU writes to an input buffer can remain in CPU caches without being
visible to the video hardware when it reads the same buffer, so the
hardware receives input data that does not match what the CPU wrote.
Likewise, on the capture path, data written by the video hardware to
the output buffer may not be visible to the CPU, so the client reads
stale or partial data, resulting in corruption.

Add the dma-coherent property to the venus node so that DMA buffers
shared between the CPU and the video hardware and controller remain
coherent.

Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index f74fa66f1a67..98184760b4bf 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -5024,6 +5024,8 @@ venus: video-codec@aa00000 {
 					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "cpu-cfg", "video-mem";
 
+			dma-coherent;
+
 			iommus = <&apps_smmu 0x2180 0x20>;
 			memory-region = <&video_mem>;
 

-- 
2.34.1

