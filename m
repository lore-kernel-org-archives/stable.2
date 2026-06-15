Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674253CAE95
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512561; cv=none; b=Kjwr79lwjqtg4lqU99QMsTi9sSeyqrfmc6kMVZAYK4s8AazLYuuNZWxPjAwgW76n1ce9vMuvcg+L495f3bQnSx18PJgBmh8Dbuz70Os6zAuBYcxuDcmSAROcn9LXls/739EKhdgT/z4Mcs8CuhZraFjC/tJjCelQEp1UxYn+ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512561; c=relaxed/simple;
	bh=0CbeIfbe5MjOdT9CQPYp9szhighV6UBlYT32HHqksf8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UjfoVLV7w5YrBd3/bUK92X+ofRPDfWh0mGfAjAAhAz8fFPRx9t9oFQuBQT1R5kUAcNqFt7UebDw7gzNcbbah8rJRlyjh7H0oioTHRGDW98N4D+HQli4RWPmw7XD2kTIGNkFyGgC31fqxJdPnRmryWDW/Kab+R3sXXzDRxvop2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oLSuJ8HK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hn7aJ8HO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oLSuJ8HK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hn7aJ8HO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L9Jx3828464
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wV4trMcsPj/JH0c/7ibhAF
	ZjIAm9kEZUKLzZv+e34cA=; b=oLSuJ8HKER9/GeorRd5RvX3TVR3eXutYtJvqa9
	kaKex+OP9syc+slAiw97WhGfs6Vg4yHSPnYIZmoyHqxz2ezbto+KAhPnJoWc53v1
	pOtw/aj/eApjwzvpddAKBpbs51af4EzapK1/JtGv+/8D+A97ommfwmKthS2YFJoV
	nyzt1tbglG4I+Tpd9mGEmy1uuFV43mEEqFHwqm249HfwYfYp8Dn/2Mbp//N3CDuO
	0ctG+R6NwnFjRMRlxv+M28eAQW/yrIEe7p0rfu3ai5lLtzSs14lfa6QFHNwFwBe5
	qUOisnqvd7++h+PXGGXOo6PqFeVZuHU5rp3iSR5N1po4rAWg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6e3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:35:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso5710459a91.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512556; x=1782117356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wV4trMcsPj/JH0c/7ibhAFZjIAm9kEZUKLzZv+e34cA=;
        b=Hn7aJ8HOd9JCClW9WTSqpJzqtvX3L2LvgCbmPemgOgYrt0qrflPrCFonkYI+RNPFVD
         vLVYV+VnmTM85Ye3wVeH49eCN7WSa826cYTacXtrvLh777K/a5C1GSdPTKxW80VAlLrH
         85IYKY5Ljs+o/exozv/iKMuWF1kBt7gIHlr2/w1euY1VWfGiku0AqcOLnBg8J4spbOMJ
         jKvHQhw1wTNzC7VHhXd86QI0rCNBvQWvYeMhZKlFDPHkPhxNV8xi70I58+0GuzaprmpW
         tG0Z1M81NfqZi4Srgmk4lKU9nbSPPYJq9xO/JIRzS/2yXWH4c2nK+fOLVRigkZGtqG4E
         I84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512556; x=1782117356;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV4trMcsPj/JH0c/7ibhAFZjIAm9kEZUKLzZv+e34cA=;
        b=HJs9Mg9yV1MY9THpdscXSQpr+XJvFDt29H+RZQ+1Xo71Q1h7aBKmttKllAhUoja223
         +SujPkD+RobGWuvr7tXl4MXYDIB/5ESH11/8rESWyHq1jmkEjihFapzmuyscAruSa9UN
         GSQVSaF4V5/j1LKeUEqAP/AH7o6XAw57lIEo6Zib90Hlq5mkYoxKGvAwFzv2lydK/nP+
         6YGMFTl38NTaJ1ekH4/oU2r+/EALXG4rtKnZ7OEin9eYU0XTLF7cLFxM9gu1gFIKx5QR
         aiGsuiqn6/x+xhC21+KYZRwQ7e3B8wAZjpcd7DZPu0QzCwvbLXbKQjppqzu+z0JgciWI
         T94w==
X-Forwarded-Encrypted: i=1; AFNElJ/OeOmAApOIyJmRJYzgJ2FNnL/qHB3VSD//JZ+byiT9pQG0mn6jcYtRmf2wxNaO4D5Im4bJijw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZGJNSGP5Hts8iuwxNYw72M4LPWHUy1aexyNdE6LRBBbkgKPR
	CHMCsQO8FjWA5vSZe6iPA5xbQLZqt1zLynNXikVXksA6GX4BiJyHMeTuOlCH2nbDVgdjJE/97Kl
	kuSUHGKBVAwA9MHuDxoE3Q9ZAimzEeD/fuNqy9eLFUE+CWjpo2O0iGs1E0h0I+B4Khjc=
X-Gm-Gg: Acq92OFCpqBFf/vVI4GGn1wTNL2+1aREtIBpmNBs065dO898452gdgacNcSuoVgqQ9f
	z9oX5aX4UyTsSSpoP+w/tKeoPZZ+1wDRm+D4I9PwQZxWUNfsg1VUw/dUGBrBLRzoF/Tu/vFLGf7
	xlSYKPPBog5aq8CuFqE1rs5PXWuzOU86p8sPCNMFMiQXawzS6YMW/XLh3FMc3dlhjwRTr+wgLtN
	Js1IHR4y39w9iAAQTWV1R9RF/aA7SWZ42XxWzQV43Cxywt/ScgJi70qjRWWnNgtOTRNKJxG9pq5
	UDt0L+e5ZzP9E350tDLGqNiieZhwZcAUa6T6p9k1cXAESkJMHhOyt/eIHZz3FTSfQJPrHjc39qv
	BkMUFVLUHX+BGbh4fmzvBYZt+MGcjTpGvdRh9HvP5GLJW66bcVgkXNgnz3KB7EjDiDRy2hWCMDp
	PKEQ3rY6CEPPSnO3QnchQB7W4lfYgWBw1u80nRfM0Y9S/v0BKU6OXxHSLK
X-Received: by 2002:a17:90b:6c3:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-37c2bd033e6mr9436103a91.12.1781512556281;
        Mon, 15 Jun 2026 01:35:56 -0700 (PDT)
X-Received: by 2002:a17:90b:6c3:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-37c2bd033e6mr9436087a91.12.1781512555895;
        Mon, 15 Jun 2026 01:35:55 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a210ad64esm9558974a91.0.2026.06.15.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:35:55 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Add support for the REFGEN in the IPQ9650 SoC
Date: Mon, 15 Jun 2026 14:05:46 +0530
Message-Id: <20260615-ipq9650_refgen-v3-0-5f611623629c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGK5L2oC/23NQQ6CMBAF0KuYri2ZVlutK+9hjCkwQI1QaIFoC
 He3hY1RN5P8yZ83E/HoDHpy2kzE4Wi8sU0Iu+2GZJVuSqQmD5lw4BIEB2raTkkBN4dFiQ1lSqb
 iAPkxzYCEozbszXMBL9c1+yG9Y9ZHJTYq43vrXsvHkcXeikvg3/jIKFAhkOtCi6KQ+7P1PukG/
 chsXSdhkPhj5B8KYz8KD0qupFYsF6lS+EeZ5/kNpEpKAQsBAAA=
X-Change-ID: 20260520-ipq9650_refgen-196b570d8bc0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fb96d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=jDu6XcLu4sYahdmiP6UA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: r2aRW5tXvMyaM5V1dn30OHwGEFpeXZRE
X-Proofpoint-ORIG-GUID: r2aRW5tXvMyaM5V1dn30OHwGEFpeXZRE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX/5NUcoJj3fDS
 vHa00M9FE88RDJNPLWq5mC3/CwaZIaUnKnrqwSu4mNJjh05e57yrPENvCKP19Gid7pIwKAN+4WZ
 QfVdf6bsbR3CU0a77tC+7kPJl+LCPKTSvBniilZGFc0E+dKP1onoUVdWZLDkXOU7KAs4zVz7Ppn
 4/R2yOCkdhOTPjLrRuBC21eUTbo28c657WkJws1Bi/An7t9ezAm5VDQdu0K26cSmtvzZBAesT3T
 2UT15Z0a9Yk2XYT0IByGFNWKryefrJefTFPy34iOPodLvXiPPvX0iEYhB9XNij3ggaMQqOxBSdW
 R/SX5+oUS9yz6gSsc3AB///ZEr7DnXEAOIslVBzBmruFPk5AcdxwY2yAM52Sj1wpC7aMe9nVSCD
 qk4ZkrhJZ2TfyF2JwOmqPOSfZPexjreA74Hs51JjfnbU4q+sdHyzugRyMkg3lv2aX7CsgEK8L4H
 r+ZEeamOld3375Fh4dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX+4GPKrtqpd7a
 +hGoLM/fV/STbJDAxNARYPWV/L9ZdZpqgebZiQI1/nGf1jh/WE9eK6QnX3E2WBnaSf2w6mqzo9O
 qd2cuOTBk/qLm97pT/HoESwVtHnE62E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150089

IPQ9650 SoC has 2 REFGEN blocks providing the reference current to
the PCIe and USB, UNIPHY PHYs. For the other SoCs, clocks for this block
is enabled on power up but that's not the case for IPQ9650 and we have
to explicitly enable those clocks.

Document the same and add support for it.

Correct the regulator type to REGULATOR_CURRENT, as the REFGEN block
supplies the reference current to PHYs in the SoC, per the REFGEN IP
team, aligning it with the hardware behavior.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v3:
- Pick up the R-b tags
- Use the lower case hex number in patch 2
- Document the IPQ9650 compatible as separate one not as a fallback and
  move the allOf block after the 'required:' section
- Link to v2: https://patch.msgid.link/20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com

Changes in v2:
- New patch 1/3 - change the regulator type to align with HW behavior
- Add the constraints for clock and clock-names property in the binding
- Read the REFGEN_STATUS register to find out the regulator is enabled
- Dropped the unused slab.h
- Link to v1: https://patch.msgid.link/20260602-ipq9650_refgen-v1-0-55e2afa5ff64@oss.qualcomm.com

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Kathiravan Thirumoorthy (3):
      regulator: qcom-refgen: correct the regulator type to CURRENT
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: Document IPQ9650
      regulator: qcom-refgen: add support for the IPQ9650 SoC

 .../regulator/qcom,sdm845-refgen-regulator.yaml    | 31 +++++++-
 drivers/regulator/qcom-refgen-regulator.c          | 93 ++++++++++++++++++++--
 2 files changed, 115 insertions(+), 9 deletions(-)
---
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260520-ipq9650_refgen-196b570d8bc0

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

