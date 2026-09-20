Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182E2EEE79
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912762; cv=none; b=BjhJL/IHZLgmHOG3jORqa+DpGF2I8C1JpnAfESvWQmuo45nrfuSyDPubDDq7DB0pFSs8bTJuiMBDhF0pZV7y2nYIJ7OtacArSv1uT96vuHpkOeDtvhJMO2w8NadcCcZCyQuTkIgC+PGHixJPE7q+if8sh/TjykuHIi50a5hW2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912762; c=relaxed/simple;
	bh=8ufTlczbQype1yUPrXZx3FbvE3v5McTpVj18fSvYKig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hnxxn61Ji86HP7ye+A1EUoi/M8dd4nWj9VjuyzHZaopFVqc+fUqLJutwIJ9o4AP0+lyMKvajwLDJ2DvPlxcT1Godtif0/Ckvf/spzOO+P7qR9wn55HUjEzytVdlVznmJfoaENNtTTwboLIPfGBa8GZjgbCfpV8gr7h7g8pbyjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDko0p6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iprz5AnL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDko0p6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iprz5AnL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBoDlY3272158
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZD2l9pEwB6DB+I/AJudAh2
	5zH9LnaG58yd8EK0sMN0E=; b=nDko0p6pimunjE0TlO9DRXvWLAT2M+Lm8bd2gK
	OhYmCYvahx5Bdn39aN778EduckJ5+gAuFDO/CmMyPUexb0+0L/QSkNm89F5rxGda
	9s//nMOcn1kIpOf/I84LIK78puo3CPbtldfrHLit8Yj80LvrOxhhSUXCrbHbCmE4
	iZys/NV8sqkxV792tkauUcLbNXjnSovgXb845t3MwKsZrKTVFHdPFyNHwTUoXuff
	65gbv4bJM1O7HztpWTkwURer91tpbgETStMY1twujOJNqC+CAE6CmNGEu5yJO5T2
	SbYeqBilnPu/4aaJnc4vtdqSgKCjlTP/c3PltwXxOURWU6Dw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshbsb83q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 13:59:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-912054a1c29so32689076d6.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789912758; x=1790517558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZD2l9pEwB6DB+I/AJudAh25zH9LnaG58yd8EK0sMN0E=;
        b=Iprz5AnLu85T/ikMpp09RQEJK7nCEnceDp54QSZM8esAkrx5JPi0Zy1/54NYivSvBb
         DaFu6OPjBw6xYzQaGVDbsUxYHgyHG7aF3NYWZv9YvcG9nmOwWee8sYNotQiEqL8BWQh/
         Z7BD7RKs99l0Ro1/M0HaNyEHGrm/F7cydW4UwvyFIOvuy3MRTgHMfVuxXtYTjuHmYb7h
         j/SoQm7phcB32hhp6AdIVXFEQfgTMtkpDY3gQ3stkriqqakI4GxhKKzBdZZEzl7tLscO
         v7m5OvfsHO8vKz6rJ2SvyTzal72w8GQWr4SaSt8f7eYhJ1oMfcOu6gheiZuL7e24cop2
         Dzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789912758; x=1790517558;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZD2l9pEwB6DB+I/AJudAh25zH9LnaG58yd8EK0sMN0E=;
        b=1A7dtt+AK0lDRPLEz9eCWK4Y6wijyD/atXlzjwTubrFvjl8VqQ13Z2R2i9L5OdMFLC
         QbAxJr3Yo9QXanKYRbJTdQ7eOEXCoSkR3j3nM4ofi06XjwyXTl3bXQczxyBit5JFXjNN
         7rI6FuQD/Dv528eeyQQprs7g4GX8sVTX6QCr3/vRfYP5OLWvRrXcGPREurUO/2Bo85eR
         lE9ZJYY0d+5IYYDUeUd/5SpdZfeP0/ZLSqidFDIg1I/RXxLXxr9sdETQqprn5UpdDNeL
         0UyEzCeFKK6WDAt0/8ZXKmD77BTga35C1Ks9pdQvOd8g1WXRi7MyZQpBOkFYRPqKuAKf
         nQhg==
X-Forwarded-Encrypted: i=1; AKwUvBxUbsKz7OEqjWQeiVziHYT8jDQPCHlrh2JHQKRuMt5ctCtzEeUuPoERxlv+YVhqeBb/SKGX1Dc=@vger.kernel.org
X-Gm-Message-State: AFuF++nGcQSxZ2rxVbxpe+UiC/YjXeeKeL6sTZcdOgw3uutxcKbC7BN+
	M7Uh+p0Hj209XDqqqDf/QukVD/H3g0ctLOLExlibRG7hak2Cqn8JumGi1EUMGZF4nU3uxXgHiHm
	vp+3KI40/2VLbF8GTJB+VUiJj7X81N7urQhH22V3yRUM4fHiJ9vburfMx6eU=
X-Gm-Gg: AYBFou0FvXRnjHiteotRSoQ6WPEnF9B27peXsjyAMhg8gPq6DXLhUb95rUNqIVL1M8Z
	VNi0z6i/AM8J6rwSO8kX/TnET7ct1rkZrWZBQqWnGflDbbFd0Bnqbru0Ue0Nd82dsfArZBKqRht
	ZWQKjLOkdylGlW3CFmRN3p4msUpArwE48suxI1ZPKsnA2gdsDxdtS5QI6HCpGp9BODl4r6uF/5L
	q5DYj6oa85k82aXYIQ/21koCgkXdcNdJFTVO/a/9lHCWizDILiPTSFcucLLT5eQnICfTt2I+cpU
	7rgdpjsdodJgxkCmj/EJ6euNxfThgkh+H7uHDW3g1hGTIs4FFgq5rBSxnLyKpY6Upuemc4L9lpO
	1EDgXj0XQtkyXfBvh4DU7QL3i9ena+mgTp+sfN1OVZMn7pvylr7/Qi+rGAJjNPFWckxVW04NCyd
	oDwLldBM85ZEDH
X-Received: by 2002:a05:622a:181d:b0:530:d95b:ea47 with SMTP id d75a77b69052e-532b720383cmr59301751cf.25.1789912758094;
        Sun, 20 Sep 2026 06:59:18 -0700 (PDT)
X-Received: by 2002:a05:622a:181d:b0:530:d95b:ea47 with SMTP id d75a77b69052e-532b720383cmr59301481cf.25.1789912757612;
        Sun, 20 Sep 2026 06:59:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a607678223sm13620541fa.39.2026.09.20.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:59:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/3] phy: qcom-qusb2: sort out register layouts
Date: Sun, 20 Sep 2026 16:59:12 +0300
Message-Id: <20260920-fix-qusb2-v3-0-c273e75c9fb7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDmr2oC/23NTQ6CMBAF4KuQri1pB1vUlfcwLvqH1AiVFhoN4
 e62uGHBZpKX9/LNjILx1gR0KWbkTbTBuj6F6lAg1Yr+YbDVKSMgwElNADf2g4cpSMAVJ0RwJhs
 lDEr7tzepXK3b/Z/DJJ9GjRnIi9aG0fnv+izSvNtzI8UES6YaxjhQBserC6EcJvFSruvKdFDmI
 2wBvgUgASd9VrquJNWy3gGWZfkB3zT/JvwAAAA=
X-Change-ID: 20260702-fix-qusb2-3600a65bfcae
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ufTlczbQype1yUPrXZx3FbvE3v5McTpVj18fSvYKig=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqr+aymqdqS6JidCXr9caQBTFeIyIiRpO0D3SDi
 36D6DP6IKuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaq/msgAKCRCLPIo+Aiko
 1XxtCACyKgvb+ppDsi/WTFJtiq+BFCATjG+5l+DK3b5oF6PgGGRAHX/kJ3UN5GzRHpCxucOYSe4
 T6xW6wjjLv7H6zk9jLRTor8yWtOC3IIc3IECRZxMsqQBVy8DOvZbse5qV//hXqri/+wTz7V0d5O
 hZRjwBPjKRjqg0t+sMC046YJ4BBy7/VwvoKBnhoKX9poy8sAC5ofYozF8EdCvolml/rO91oredw
 +2nJfheOHqnyPGdIcSwNHouVaiC4KYdY7U5HLMWh5xVNYyJKrYJVkiZs7oagRgMWQIoid3fl7dA
 rTimDcmJL2FeADbzQMtkbd0JVWd4KWI9QJ675NYrN/AUvwWG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 28FJMLDUZ-HV0-qHqDSR2Ppj7SjIwQWU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIwNCBTYWx0ZWRfX+O1RKxm/DhuM
 HUqqj1+NK4jf8ighUKA6bj/3X88QOgZPmmE1+0E9nIsm/3NRyhkCtl1kq2dIyTUs6ikfqMUNUrj
 ZPdtqgP2eXQnIxjCSpUQ+jPUTmFM/PzQguDAU+MzXrl5POoV4PzNT1HWmTkoN2bEsrEVioQGwpg
 n29H3+BtiMNAqUHdSPmfrB7sE/eeu8ElD5me5wbVhx8lKvTA2wEQT9Q4tM4k96t//Sc7YWnxCmF
 Bti6kTby1p42DjyKNKbNCusdsYMdmYnZNhyMRNxJSsY9OSa2yHXCWqmJ0H8284JI6fOp6thRqgK
 SoUaUpNZ1/gAlAIaE+ibhNWfnUkCaY0aloezrD9D51qz6WvrqU+g3pA/jglSUjDUZKonuZLGZdf
 5wfc3GnjG/EDD1xku2rbU9zu9ll7AULNEYpmp1+11Yp2OzvQjX61rlYo7+7yYEsPRLIMDrPrthF
 ZvCPjp20umDV7gud7GA==
X-Proofpoint-ORIG-GUID: 28FJMLDUZ-HV0-qHqDSR2Ppj7SjIwQWU
X-Authority-Analysis: v=2.4 cv=bPqDs/+Z c=1 sm=1 tr=0 ts=6aafe6b7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=LpQP-O61AAAA:8 a=JfrnYn6hAAAA:8 a=vLZ8uGs2IYTldnpWfJ0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIwNCBTYWx0ZWRfX3lWB4CfKPNIn
 CWWErrRwk5LFKrZhICXRLXTjP3GvfxbmTPyG1yBuWK4523RV7bc5CPCVOKHi1SAkwbmj/aQkSqB
 chGxSJ9waxyWeFvHnSDdznmdmFwC7mo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200204

IPQ6018 and MSM8996 use the same register layout, however for historical
reasons ipq6018_regs_layout ended up correctly definig TEST1 register at
0x98 (because platforms using that layout didn't use autoresume), while
msm8996_regs_layout used TEST_CTRL offset (0xb8) for the TEST1 layout
entry. Fix handling of the autoresume register and definitions of those
regs layouts.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Rebased on next (Vinod)
- Link to v2: https://patch.msgid.link/20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com

Changes in v2:
- Reworked the series to enable autoresume on Talos
- Moved autoresume description to the regs layout, it is a property of
  the regs rather than a platform.
- Link to v1: https://patch.msgid.link/20260702-fix-qusb2-v1-0-b5cf55621524@oss.qualcomm.com

To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Kathiravan T <quic_kathirav@quicinc.com>
To: Baruch Siach <baruch@tkos.co.il>
To: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Dmitry Baryshkov (3):
      phy: qcom-qusb2: enable autoresume on Talos platforms
      phy: qcom-qusb2: correst PHY description for IPQ6018
      phy: qcom-qusb2: describe autoresume bit

 drivers/phy/qualcomm/phy-qcom-qusb2.c | 55 ++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 30 deletions(-)
---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260702-fix-qusb2-3600a65bfcae

Best regards,
--  
With best wishes
Dmitry

