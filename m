Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534E3054C7
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346004; cv=none; b=HwnuvauQWrbPT15gBAQFE9WtY8UtvZ501sIwvEQnFxP/Jfb8OTlss3IQakP/J5ILUor/l8uwitjq/ZCAtN82RBRbdW0vkNIdefJBG7YxWK1hcJY7Liu8rSXADYuVzmd42NpK5hU/PgFupHVlAzwBX1l6yMMOB2zx4FpW+wefWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346004; c=relaxed/simple;
	bh=DQ9tdQg71CEhScbdrlvlDz6O5dyiEfY/OFqLJIXLap0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V4p6QSVvXOmBwN5pjuM7v/yzwWj+49p8luJ+aM3vfNr96DZBBaHJTVzoGO5Oqj9Mmb3oABsekvXz0pxOGBHiqRQgFbrGNO06fOyzDu0cXr5AP1Rzu76FQyHTs93WkL88OR38TROVoLuMhnd9Cr3BaXG3VWKOxCWSg/ilQp0hqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DXl9SE9z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3y1wI7Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXl9SE9z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3y1wI7Q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax9DR391072
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=00D9UxEKhvn7M0h0JLLCeW
	xotg46sBowMcnHLIfg5Vo=; b=DXl9SE9zWP2E9/UFGgCs36sR58nFcPzounSJsA
	gM9sAxUedO1LGjgzTTfqBaJM9oC/CIl0NX8SJt7m0ZB1po1Pjg4etr9k9isdl05Z
	nY8o0AJliRelTP+JkAnwpprZl/UFSqUVHErBQOol5xZacplOyTiulmgceyBsK0/U
	Ev7oAtoHG/G8yedLOLcqndjoryzGAvJPHpo1hBqLesH/ISB1ZOAsUPu/KbGf1ESs
	C5oQZ7L/2v3rkXMaG70iAStdqofU189RuCX29E41TvEgZp/IG8LBLe4bwX/F6cpB
	0xKvc3WSL0ybsl4WM6oCJAxVGhfPYbXPIIAVkyfur/LBT18g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs22p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:53:22 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bdf87be987so463181e0c.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346001; x=1783950801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00D9UxEKhvn7M0h0JLLCeWxotg46sBowMcnHLIfg5Vo=;
        b=S3y1wI7Qj/xP/PNHo2cfMt+MMxyF0ar62fooUIxWZBLrNEZKF6K2ckCbQi3vMXAomj
         P6EMYMRHk1lStPFIbr+VUVVtBhvOf5vqV1UZ0HEMLVktX2fbFpCWpP4o2ECnlhw1gcbp
         STunMn51UZDr5SIFVL0D23tHHe3XJJNOvcjjid7nMUGDLivvAVjzNoaH8L0HAvA7mZ2P
         sWVDlIiOAuOYb4xDRoLJXcmucDXULbD8BZ29VUd6dQD340/l1cGLwMb1beVzopeRf4Fo
         Gd0FnPEQlVvrh99Sa4tO6QaxSvpzhekDaw93rvf20QmN4ER/L4PjCuGUh5cHEugvVykI
         2z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346001; x=1783950801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00D9UxEKhvn7M0h0JLLCeWxotg46sBowMcnHLIfg5Vo=;
        b=BJovs6ky3TtYkzO0YUb45GVuqohQ3Eyv+Wvz4w2tSKNim4Dr+hhEqoMTZBo7EnQRJA
         mlPcGF3cEWj8AOVx1M0fWmmDNn4/IlVsQsw8R/JDdHyiotZqHlbSVxEk+u/ZigcLj6Js
         nKJ4LbKKp7CPiURUF1iyNuMIwWIpvtDMo7dZZOrrIQ+zgZFBmH7zugb51hLmoWYryZ+2
         VqfBibO5Xxooe1SGz/Dt6vtwOXsk+3bHfcu1eaomJfBNH+pczGcwI4JlvsLhn8zb5LAS
         LQ4FOOAFSWB91QJFrAy3UhmK1apfzeiVF2XNepj7QksbVnPYbl3FDpr13+xcXXW3NMtU
         m7nQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZzjIeu+5+2u2Jltn05PvcsGxnhfNW0nh6ELDRqUZRDsrt+dtOPSsSgE39Ol0cnhuKJwbEaao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfiyHNzsiQ7ILlc0QSjY/gm13Y2IupNa7eR1GSbGOEYLXfPie
	69EEg8DKVpho1WIQ4bf907xtRtCIDAXoMJSBLejLpCbyOkFOqfHfwJY3fXLI15JIUUR0SpR1Ybl
	x3BZOnNP8mQlCdc2IvykvIKKC5DmsvYIzYaP/MuogWQf5yFxUVV842QPSwtY=
X-Gm-Gg: AfdE7cmGIA8BY2dl0i/5fUw4prk5sdIf3DNCuN8EVXbfnvuQhXzzcZCqp08LrvAbFzU
	4BIAlrn2srIv2kqGBNYDuLPChfxIKnEp+8Yp+0oy+E5gyOGV7/oEwYN4maU5mdslGmfUHAYtn8E
	6CT+wxFi4kcxUcslZJelGMUuoLuQkNjQ0+MrWfZEQYmUQGHhcZ/m65RzFUtRLCGSmqHxe6Iiln1
	Qp+oPmvwNfSsXKxKx5Oq2WJtYJyTfbXqmWOz7QaENM3vDAXsZIJ+FwDvid64b1b73vmj64fMUSZ
	28Dyiz8uuyOJXQBMnN2T30bxzOqSdref/hoh8KFZ4We0ctIugKVyCasuKk7mq6qgCu4ulw0HRL9
	k3Tus7WA/Vb7v3gZSoRld5ouTRCQlszokhuppU4B7cHWA0tOOTKaSh/1h6ctX/docy+HDUEAJpP
	sygXrpE7t3WErwyIN6WTxc7V7c
X-Received: by 2002:a05:6122:3b8d:b0:5bd:c6ff:b6e5 with SMTP id 71dfb90a1353d-5be90517ccfmr372210e0c.1.1783346001214;
        Mon, 06 Jul 2026 06:53:21 -0700 (PDT)
X-Received: by 2002:a05:6122:3b8d:b0:5bd:c6ff:b6e5 with SMTP id 71dfb90a1353d-5be90517ccfmr372186e0c.1.1783346000618;
        Mon, 06 Jul 2026 06:53:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13701easm2932551e87.16.2026.07.06.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:53:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/3] phy: qcom-qusb2: sort out register layouts
Date: Mon, 06 Jul 2026 16:53:13 +0300
Message-Id: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqzS2oC/22NQQ6CMBBFr0JmbUkZbU1ceQ/Doq2D1AiFDhAN6
 d0tuHUzyct/ebMCU/TEcClWiLR49qHPgIcCXGv6Bwl/zwwoUcuzRNH4txhntiiOWkqjlW2cIcj
 +ECmPe+tW/5hn+yQ3bYHNaD1PIX72Z0u1ef+6SyWksMo1SmmsFJ6ugbkcZ/NyoevKfKBOKX0B1
 C+tMLsAAAA=
X-Change-ID: 20260702-fix-qusb2-3600a65bfcae
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DQ9tdQg71CEhScbdrlvlDz6O5dyiEfY/OFqLJIXLap0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqS7NNiOjSi8y3MNh/Jn7u3BA/nhn8RN6aeLND9
 zfl+iYvfIqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCakuzTQAKCRCLPIo+Aiko
 1WNRB/96XCowCqlZWvWXluPMOCDRxATguU7K5R7qok60qsCWHY4LHr01quDyrUfB9PR4e1gO4NP
 AeEx9JAtIUV6QCaEwDFL+vto8vTRPrOgICsEu/Ubt9jQxX+hI3gt3XYmHBgP4b0i4izhW/DDHWP
 G85rFwNUytfUiftDz88hH+fpNHS86IZVrGwa1c7MCMPnIWF8p7r5r4JyWEQNLvdZkVnl2E6vq8X
 RORW8/7dUTcTORAAtzqRu/8iybN1Ffd1wL4/AAnbQ6D8bD8eUGlVqbx69HIAjdRgKtHIsGI/Ewn
 tzJhXyPxjAxLSh+fx6L+zcld0aAr6xXGJXBz0GkL/imB14Vh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: vxHa21O32WELQLVVyWJvDlYVTLYZk8WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX+yDNl/So2GPK
 wuO1pXj5FkGsTGRKuPZRJ2f6gv5LeZzSRjbia/xI5LvjAaeu1aV6iZBmP67P9yc6V24R/iSab4y
 ZYhAGBEDDh7JFZkJbTOvnJM1Ivq6ATzy3Ig3cw3sfENu2zy4Bo5t9gDn8GdU6MZ2yDOhHSbovey
 nC2Vknu415A6UTCCxQ24SE9w2UyuHhfJOwHs+t32puqHQldFnaXJQSZC8VMDSCHMbZJFGFhy56R
 E9MU94C0Kd/XzLZDdi6dGFFzQJ7fLlZZmCyAxRADO/YCTR7OK7lRQ2QYCFur68EQ63rNO0aVvx8
 hEz2RAyxz7r7loxvntkXw73oixhY/tZnDv6xRythAeCDfQDBq/gJ6oKexpEbwMebThJHVnib/0Q
 vOT7vHkWRic5rlfZHkv3eZQTyRy6bOAXuGt7Q1a31pklbOKEmMmU5bvlW1gBKGeNuL+VRostXeD
 12g+iknTZ47++SEwvbA==
X-Proofpoint-ORIG-GUID: vxHa21O32WELQLVVyWJvDlYVTLYZk8WW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX65DFdgc4+0Xj
 UOZLfLBPjYC3jFStr3a7y8jfeiT6Z9NBMMG+0v8Y30zLP1uFKCuseAOu8G1/gUJotBVtMO1PD0G
 Tr5UZbuzZl16wEPVdUMXc2SRQ4VbgdI=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb352 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=LpQP-O61AAAA:8 a=JfrnYn6hAAAA:8 a=vLZ8uGs2IYTldnpWfJ0A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141

IPQ6018 and MSM8996 use the same register layout, however for historical
reasons ipq6018_regs_layout ended up correctly definig TEST1 register at
0x98 (because platforms using that layout didn't use autoresume), while
msm8996_regs_layout used TEST_CTRL offset (0xb8) for the TEST1 layout
entry. Fix handling of the autoresume register and definitions of those
regs layouts.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
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
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-fix-qusb2-3600a65bfcae

Best regards,
--  
With best wishes
Dmitry

