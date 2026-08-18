Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDE3B5319
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068472; cv=none; b=jIktZAH1ztYh+f9Ze2SQWcs8+MsBWgvIFJY61nZjO2ZlOWyRhIONbP/QSGxuEhFP04yQEfTY5vJS1KSwcjt4G6F/+TOV865ynm2IvfOX3eu5jMRJgQ4jch7279VeS0XYscf+yM1qZ7uNJONg6C/17jAMWFW1bvm2couWP79ZPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068472; c=relaxed/simple;
	bh=WVS9GHikQg5wf1mgNe+vtdGOXxmmqGP+XxBotszidUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=autSUWWp38/qpa8bP290c0KhIJchNTh4RHLrJ8tVV5S6Apl/DsIZCugiILHjFctcgMJBTb1Lu1dqog8QjAaSmVOs0RZUVTLnC8wPYlnR7EuOM8LK9LZIMMs4icWBy28sSMbfS7DXMiozCN8x2unP/zTT6hEsfsd1AY9sCkTvCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dU+0aLHG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bs80cJ4y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dU+0aLHG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bs80cJ4y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE0m0V572256
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M0vkyOIUMiYiRCITnoPLyY
	q/NcpQ07ugD4GeVjYtDjA=; b=dU+0aLHGjGjihaP6Nals1yBgnMrih8Vj4p6XUk
	WnRh9IFReFVX3Muy05gID5Gaow1BhQFG3COGcF3zrdFLsdUCFJVumXEAaKz6Eukr
	AzWT/zAmtihSJ2gUycWGAuKkwk1zonPlX/emlwS/it/6N4qUyQB120TxSgKJSCtL
	UW3Pv9Gi84Z9VG3o0bCOq694GNA4h+32C31BL0J9N5wCkpNC826NT14/4BaVX9ka
	1U9oLJIQ79WO9BX8k/pthcd0MRisDkw/606el2M68/YnTRpR/81h6JHN4pd8Un7r
	GOWmukg2d+Ce4boXuRGloSGk40nfqzNmTBU3NyadSwh0ZCVA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5pu74u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:54:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso105135a91.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787068468; x=1787673268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M0vkyOIUMiYiRCITnoPLyYq/NcpQ07ugD4GeVjYtDjA=;
        b=bs80cJ4ygavqaMoLN292Aq5xRmZU+zP4k3ZBhMydeUAv/3TcgV6ABtY22SYqvNMEgD
         HHIVUIRw9o7pHWHbKSFutR4SQa79sO9VYZlRViZ8rZbWU8/UTEfrTs/mr5sTz16sw+i9
         9+uwxEMMeAQgJIa8iEfaE5jQvj5MZifraWPuOzUlsarem1Mxtis9SbsPTnlzGBkx6VBk
         Ucv9vVO8D/s94n7xsvK9koCaYdrApaMWTXMO9/TPh3ol750CINyCvgmqz2KMr4pD/+9L
         wV5OBuBVKpuK3LawuJ0Zz5V5IkWWKo0vDYW+vwEJ4S/4AlBmJQFEKWgAMTKd7ZuKP2fa
         lQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068468; x=1787673268;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M0vkyOIUMiYiRCITnoPLyYq/NcpQ07ugD4GeVjYtDjA=;
        b=J3Vsdy27ipJlNHTYpsJiqWnVhbZBjPcjZlm66O1qk/exPw4rzTCf5xJ76Ur9yr0rep
         g8F7Wl13Fyfu6q4vuTDB6O/IKarI4uf9mvN/QfjRfQRvzVguUFFNJL8xIyecJcmEDJCH
         MsUxnXzBtu0Ai1vSN3fojq9Xb9rg2aQTAEeACg0Rm9/eBzd5iXQHYddUwy6rb1KyotbR
         +kiPDveFpB9CPNdGADNa3dyVRxRAulryKgDIforyWF3XUjgd1AZxEsUGOHcStD7JcUC5
         LShdfZarjf53U/K5zre9cITNdVk3QshMz1JtZ+nGss4phHYnKC5SVBtZmQp/qWQAqHBH
         2ksw==
X-Forwarded-Encrypted: i=1; AHgh+RrYUQzUGMnUpgKYG1hFPwx1JbYFBEZ8aMfysT4ctts2PMQEjxc9IdWY4L53SAFx37AE/unAxGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywer2U3s33tDCLz31+BGrxSxnkZi7npv+5Xd/tBpMw3viwU4D+R
	y9VmmF4MznXJfcMnhyzf8AmNIq+VHDdJyWdoReixS4QdGxQ6b0KdTKmoLnG3i8t1+t/CoMz3v3c
	geTXFti9nXgiWcf4zTPh7r8Pa08pCz5Hy3k9vyqghgxTC2fDNmhUqrm7rsz8=
X-Gm-Gg: AR+sD10P1mlPAi6DIR5koe7oorgR3dj6XRhoLqJfDfZEMNNjqQViGCC3QkjYgMSK0LK
	VXXCwAHea2lmQQBvGzp3f3RRa1yGttsU78R51SWjYR1xYCWBfiXuAwQ3Rid7jrFoMBZi0MJIko8
	ZSKD2Ij5/M9iG6H7sRk6yf+JYV76lFoUvvElFxeGsY3SIwavabikP3ne9e8mKi5rxWG8DgUiJrc
	VGKMSo/nmFZtMlZFN1CwEdpAywfKQojFGDuePD/jj4rgmEmFYGZjjUpGAJqsJZ/5FXS2wgAjIwx
	WnfIEKH/3y48LUfSDtvqN7IsmV5MJo7Xe3Ruq8VQLwV9wfdIO1rnTWyKUa1bohFKpy9sf095Qq8
	rVCuFYc/PG81LEGHpDRoTkJPdbwokRLj9HQ==
X-Received: by 2002:a17:90b:2684:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3955a756226mr13470179a91.9.1787068468101;
        Tue, 18 Aug 2026 08:54:28 -0700 (PDT)
X-Received: by 2002:a17:90b:2684:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3955a756226mr13470085a91.9.1787068467599;
        Tue, 18 Aug 2026 08:54:27 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbb41esm8877721a91.10.2026.08.18.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:54:27 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/5] media: iris: Fix DMA coherency, power-off ordering,
 and frame interval issues
Date: Tue, 18 Aug 2026 21:24:13 +0530
Message-Id: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWAhGoC/yXMQQ6CMBCF4auQWTtJKUjRqxAWSAcYEyt0qjEh3
 J0Rll/y/reCUGQSuGcrRPqy8Dso7CWDfurCSMheDdbYytR5jRxZcOAfCfpXh7PQogwJnXFDXvr
 q5q4FaD5HOmZaN+1p+Tye1Kf/H2zbDlYoHbh8AAAA
X-Change-ID: 20260818-iris-fixes-dma-pseq-fint-707f14d69753
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787068460; l=3971;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=WVS9GHikQg5wf1mgNe+vtdGOXxmmqGP+XxBotszidUU=;
 b=7SFbwildhCgD02fwzEO+gjhalpqIW+Ib23N51Yq69ldSx+t7+sjt72LtbyHdoCvue2ceCkh8m
 zGhh5EvSMPCAWNtnVkz95y+iRjGVTtSwmuZ56DYbefP81rBBduSjKzE
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a848035 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=LpQP-O61AAAA:8
 a=24umufi_F3H4al0x9lcA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-GUID: KirFz8Bhr8IXp9fcdxnz8YWiOy8W6xdf
X-Proofpoint-ORIG-GUID: KirFz8Bhr8IXp9fcdxnz8YWiOy8W6xdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExNyBTYWx0ZWRfXxT8PdO5M7Jn5
 j7vi+SLVwUilho2+qIji4j9isR9igt+2SxmA9oSiY8K6KC1X4/ggup2yHvIOIsxjDJtZMmcSmpi
 f2ZO97IKQe4Mu3eLVyquW04HNm10tA/1OMzKQJP+T9UKhLOL0vFktfR20taXNN+pjElzHVgDubL
 WIioAEO1ylMrN/XDQqnuqtVqwnZ9eQslqtAOV7rrueQzITMGURFBSi7IMDEXdpP/+24Iz6K0Gh7
 qNq3ialmb0vHB1pIqSq2D0kmaTuxd8FfEdgMLBwX/XTfzzu/WoT8EPrRQAwl11sxj4ocf1T2n3o
 QRMvDqXA3eoHYVvQEbpv7+eSD903AodFHfALk128jfJpR81LZwMwB280b0wek3WRExkE89gDw+G
 gkoPv5YJ5Mw02MglNSzfYLLMfTuNwyB3/njbboHPMx8ZNRhqH0Y3kl1B3l6LEoBJtsXeQsHOkaY
 qXCv5ZRrRF4zgCnXIQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExNyBTYWx0ZWRfX1CGHuTHlySvr
 sm8PdsXT781pk6pUC1urfUrFCe97XOOULlpy+JA8lbYPh984/phgnrAnxGtK/KcgZgzlN4HgTlE
 +CjZhmrPXvz2nKm/EkXpX1sMkhg8K4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180117

This series addresses three independent issues in the iris video
driver and its devicetree bindings/nodes for SC7280-based platforms:

- While testing with some higher resolution clips, the venus hardware
  triggers a fault due to wrong input data being received. Corruption
  was also observed in the captured output when the client dumped it
  to a file.
  On debugging, found that DMA buffers shared between the CPU and the
  venus video hardware/controller are not in sync. CPU writes to an
  input buffer can remain in CPU cache without being visible to the
  video hardware when it reads the same buffer, so the hardware
  receives input data that does not match what the CPU wrote.
  Likewise, on the capture path, data written by the video hardware to
  the output buffer may not be visible to the CPU, so the client reads
  stale or partial data, resulting in corruption.
  This series adds explicit dma_sync*() calls in the driver for the
  input and output buffers, and declares the dma-coherent property on
  the venus node and its dt-binding, since the venus hardware on
  SC7280 is IO-coherent hardware that performs cache snooping between
  the CPU and the video hardware/controller. Together, these changes
  keep the CPU cache and the DMA buffers in sync.

- iris_vpu_power_off_hw() disables the power domain before disabling
  the associated clocks, reversing the correct power-down order and
  risking clock-controller access after its power domain is already
  removed.

- iris_enum_frameintervals() advertised frame intervals as
  V4L2_FRMIVAL_TYPE_STEPWISE with a fixed step derived from the
  maximum FPS, which excluded valid framerates that aren't exact
  divisors of the maximum and broke GStreamer caps negotiation for
  those framerates. Switching to V4L2_FRMIVAL_TYPE_CONTINUOUS fixes
  this.

---
Changes in v2:
- Add dma_sync*() calls in driver (Rob Herring)
- Updated commit descriptions.
- Link to v1: https://lore.kernel.org/all/20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com

To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Bryan O'Donoghue <bod@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Hans Verkuil <hverkuil@kernel.org>
To: Stefan Schmidt <stefan.schmidt@linaro.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
To: Mansur Alisha Shaik <mansur@codeaurora.org>
Cc: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

---
Vishnu Reddy (5):
      media: iris: Add dma sync calls for input and output buffers
      dt-bindings: media: qcom,sc7280-venus: Add dma-coherent property
      arm64: dts: qcom: sc7280: Add dma-coherent property into venus node
      media: iris: Fix power-off ordering to disable power domain after clocks
      media: iris: Fix frame interval enumeration for non-divisor framerates

 Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi                           | 2 ++
 drivers/media/platform/qcom/iris/iris_buffer.c                 | 7 +++++++
 drivers/media/platform/qcom/iris/iris_vidc.c                   | 4 ++--
 drivers/media/platform/qcom/iris/iris_vpu_common.c             | 2 +-
 5 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260818-iris-fixes-dma-pseq-fint-707f14d69753

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

