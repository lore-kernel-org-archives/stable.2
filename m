Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165193;
	b=TZ4zR1qvwNAaLzlVgz8a+fowoZ8ZZ3t04LwV3U0CdhTuL68sgnHH4ppSxMUQ3zIFdqaP
	 k2oMEaq7Le6i3RUqsSKfsdrEQDuM8hxxq7YvtI59dMeUcpyMHQkaz6VPG4+xNVcoRfRuR
	 J5RIfvlI/og0QAb1Vahk55tugXM0b8Obz/bfvpE9F7GTNOpHRkEQG3X0fqno8/DqZj2mJ
	 Krhpp0xGI1XIvfltiZxENjNSGIC/eFy+7yQ2eo2Qj2R4t+WBkbvPOvcvnME37HM92jyRB
	 ODxRldkiqtRs65mWQPxDlV7YstN0NE9eCiQLFHcXQFgefCHgU1MpyIJbBjQIV20RT0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165193;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+D3f9bi61lg53c1fUjRW0l7irQxN1pm6/gdiqoSesLw=;
	b=DHVcOc/a42HS0+6tudcCCaxwIvuBduMnbuEaVrt4WcTH70rz13v+ULSSN1hygs7wrEjS
	 ahE29492DKW5sFlkK0sYYBfkm0E45QT+PTvqXg2jMPWpuzy/6M3jb2uESShkN6yNknnfE
	 G2oOX+/4kJe/TRn5nH1ZQuxUVYTwbx/8n/muRxRPh9rChrv1Zic3+W226ihz2m7n5ZujF
	 AzOs+1p0SBG6BWz7fNMfrUKVQcZwoTrMn8QVbIriBRUe1wDME2+ve5fOt6WIofL1Kbm0J
	 s8Osq5Np4+BDHquudAlwaAF3OMR0/yZxPtrl+BbnZE2izxmj6HAnCY63OUHAk9XJAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VUxJKpkm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hOXDcmoq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27ED60A5BC4
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F27ED60A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VUxJKpkm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hOXDcmoq
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fPgs758528
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+D3f9bi61lg53c1fUjRW0l
	7irQxN1pm6/gdiqoSesLw=; b=VUxJKpkmxdZ2GhcmqLeTLul9MOK/fZnYnTMBNV
	V8pU3CCKb2V7Z+M1iR6rOBfy/KbuFsY6+zJFAXKhYyIYJ8yRpy3/x2WEp/oqRyrT
	h+Xjnlwt9RDT60GPJFj1Ec3t9JYScers+sYC+14fVG6Yh6Y3PtdRF89xmPOg0AUv
	ChXTSCiHcOZ8G67Y4s5j1JvHg0MfJ0N/g/RApn3v5hHJIaulOwXWb6ZrkmQ0lRRt
	YzPEn3DBIz0bBIMR/MRAebEzURH46XDfou4X3WbzH0xYxISy2j7rIyqCF8ejzYpb
	zU33wq3lkEZaY8/SvvAXQx5LPDdYOcsLxfb2RDQdpzULsMvg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5tv7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3b63b9665so694710c88.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795165166; x=1795769966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+D3f9bi61lg53c1fUjRW0l7irQxN1pm6/gdiqoSesLw=;
        b=hOXDcmoqspPjnJ2xEBKTLKGwIHlLSnVRzh3Iw4S4Ar5CHu8Q9QbLF6piT7MCb4LfZI
         cyNyYHH+RYvKO+T8WivCLHZ5PDJEKs+CWzH7uakn5UobqvaFfQaIFK+rHjgmh3S/4A9r
         57yPzKewlWlBUvFa7WXGczEiGe1bez4155QuZ65g36yfTqRsCdBRFfe31pg3pADqrFPa
         oiGcFMW1AL2StQv2kwjiw9XBjSDcvms9a0usrNkqMmnbrBXh9NrvbMh2HnmsworFZXOy
         txTvGd5jgH+rFCl11wDMGWc32mb3t47DFo6NzXwN0mo2AKIHpmYhn1uIetzeTt/DWNY/
         /vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165166; x=1795769966;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+D3f9bi61lg53c1fUjRW0l7irQxN1pm6/gdiqoSesLw=;
        b=SGt6kkN5uqUfB7wAMUmadeCVfPi+yy8pSKK5uoyHaZhlsrOUBmpf/d3a4DIoBJRd8l
         1RF7iP7ypj0Vc/CmkkoHOdfVy1523ZR1vuipA5Hg3P6Gw1gdtSyyk/dnNVBjROnyhRVb
         ArPSnqSamgjKvsjr//wPStA2SOA08s9LHXar2zG9D+7b3LxhItb6GQ2Nk0Q2mOVJEy73
         lbJb9/bayFDZCsSUlFYhAaar1WTsgW0TtnQKRllQut4M6CRCnCTf4ydSEHGKmhs4k+pZ
         glHzfRzPYXOBTNuFkjXeg+QL7ebZmICiNrfI45N13jidHFaeQoGhTNwpLnYCydfq7Rym
         PRxA==
X-Forwarded-Encrypted: i=1; AL+hErGQ1rSWnJY0/8kpwcS8jvkVGcoC+RjIQp+zPcd3KLvXnV2xlKNWl8xsBuhZ68XUmqeCHM1L360=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3+5dQCce/QMuXp7R+Z6uRKoVuip7bJFto+bjWa5Yxqmq7JgRl
	e+WXHc6/sL4ZqeUinJMk7P/Zf4QTwrgsqdGlsG3avY8ySKh1z4acgeM/iSXt1uuse6zYic5xCxd
	7qpz5JvB0ANm6zDvWODs4OmCsxHARABaQdhqtLcu/lYBQw5EtnbVyUjJqymyMC1jNy2U=
X-Gm-Gg: AYBFou1qwiOpOVgzWPMgtXFDTPjR1pmrKj1v0Crw6OAChSUXohizCreaPrE0+K6pwDx
	yUwetp+ed1c5XjxsPUdk1gWWSibZt2s8VI8bitrKs7YwW6kxwZZoFNOUXttgBg0BcG3WOsl87j6
	/y4aMZOPN6rz1l2hMjXH/cY4wzJVljyuBHviJYK9AEXrq1yn4UJXo2OWW2vAmPFaJ0+X5nwIXh2
	YE1xikeyKLuwzVK/6McvXqqQnzaABdjvujJSP7pNiGdynv04smIuhbQjc31xPzoSoLm7lkxhAFM
	9RuYaPfwLz/OktHDghXeUNuyL6YpofkvE54+QdVBciqJodQkMIXuk6xg/aURf1cTeaa+mLLQaj8
	ThmLDvwjPO7a6NNRRDXtdeL5W0GilOd/3D3R2euA8osu8LFIxOxW1WipDMlJZSo6B17VmvM/tem
	W9gCdeTEXjiadhsjLuYOZYLvtlsChY6twJpKnqYVhXB4ort8wJKNyO5bWPr/9oioyW2PTNCMOka
	nbJGuuWrUk=
X-Received: by 2002:a05:7022:3b8e:b0:1b5:10cf:c402 with SMTP id a92af1059eb24-1b5568a17d9mr2368681c88.10.1795165166029;
        Fri, 20 Nov 2026 00:59:26 -0800 (PST)
X-Received: by 2002:a05:7022:3b8e:b0:1b5:10cf:c402 with SMTP id a92af1059eb24-1b5568a17d9mr2368661c88.10.1795165165529;
        Fri, 20 Nov 2026 00:59:25 -0800 (PST)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm9490658c88.9.2026.11.20.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:59:25 -0800 (PST)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/4] arm64: dts: qcom: ipq9650: add and enable various
 devices
Date: Fri, 20 Nov 2026 14:29:05 +0530
Message-Id: <20261120-ipq9650_various_devices-v1-0-14f53b84c42c@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANsLAGsC/0WN7QqDIBiFb0X8PcGPdM1bGRGmb5tjrVKLQXTv0
 zXYr8MD5zlnwxGCh4g12nCA1Uc/vjKwE8L2bl43IN5lxpxyxSjjxE/zRUnarib4cYmty5KFSHr
 rGAhZl8DZngL0/v1dvjYHx6V7gE1l7tcIMC/5Mh21/6NG5Y/WnBKbwpMoyiQwSUXHK73yYncmA
 rHjMPikkXHWuHNfgRICN/v+AboiZznXAAAA
X-Change-ID: 20261012-ipq9650_various_devices-fcd1e358cd1e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfX8Qubmroa6B2l
 g4u2jZ4QeAaYQYwFwRwjijSV/zxkuUHdPV9ShObyyw1cZHj83oiI0FAEXxABprR4W0egOmYDkQU
 c2aJALahQd5GqmVrhpWTgdn7WI1pOWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfX8Md+I0n9lqBJ
 z0WX8RwlAwoUpE6p4cWXgITaBZy1avUgpfE+VUEmDhqEIPxSD39DZMBLRasTXfiK6N4fzi+h5nJ
 ZaVp7htuvypwjjB8P4UyXVSPbXbuoSItW8paXNfVA2GoQphEKx71CanSy1OuXviWxcysDWYIcCL
 avk8wdlXmZ/pN8EcofRAQ9cKiTViOVJtMo6ZKq1ubmSfkalN6Qv0WTLExLKG19iIiQk2EZEyWKR
 nC+fT8sYt7D1tzMGvRbxV2dTH4n0pcowrd3COyoRGTbCWJE/TjxJmz1hjNjsJFJ/4QLNaynMRo8
 uxX6tBQbWGWabN0oeeiLL4oGtyzfJP2ObuBASYAnRgCGPJqAz6bads52V02srJILluWq2C8AyRE
 lKIwq5+FevCG1f5FeXezpyl867IODDjtQS0+VmXGLsYmpNkj2yMqN0XScSVSGjiNUvKfPrgUEvz
 o3eWbj9uHg+XOcKImdA==
X-Proofpoint-GUID: jzizKFQo2RD1jFdBdT0lhdqK9Vwu_9gv
X-Proofpoint-ORIG-GUID: jzizKFQo2RD1jFdBdT0lhdqK9Vwu_9gv
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b000bef cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AkfpK71W5FzRhKASgtsA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200035

This series adds device tree support for various IPQ9650 peripherals
and extends the RDP488 board support.

It adds QUPv3, download mode, QSPI NAND, BAM, CPU idle states, USB,
DSU PMU, LLCC, SMMU, and eMMC ICE support. It also introduces a common
RDP488 DT file shared by the eMMC and NAND variants and adds the RDP488
NAND variant.

Additionally, fix the incorrect TCSR mutex address range.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (4):
      arm64: dts: qcom: ipq9650: fix the TCSR mutex address range
      arm64: dts: qcom: ipq9650: add RDP488 common DT file
      arm64: dts: qcom: ipq9650: add and enable various device nodes
      arm64: dts: qcom: ipq9650: Add RDP488 NAND variant

 arch/arm64/boot/dts/qcom/Makefile                  |   2 +-
 .../arm64/boot/dts/qcom/ipq9650-rdp488-common.dtsi | 376 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9650-rdp488-nand.dts   |  17 +
 arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts        | 183 +--------
 arch/arm64/boot/dts/qcom/ipq9650.dtsi              | 411 ++++++++++++++++++++-
 5 files changed, 806 insertions(+), 183 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261012-ipq9650_various_devices-fcd1e358cd1e
prerequisite-change-id: 20260820-ctrl-6015e1503b24:v2
prerequisite-patch-id: 648145477ef49e49ea4eac0423acb592882281ce

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

