Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB51386C9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091130; cv=none; b=YDn12swM9yacmfVw1TrhBgV+ZAlC2EV8XtE7Z0jojdslj8uxD0oemb24QyvCsReqnPAq0O6zsXT7CUYo6l8cUQaIkGCKTOjk52OOEH8px6PdXtWeUPzpT1o5H1XN2AoMRXAkp171mC/4JmaYNyId+Rn7B/SqdkyOScW3YniTx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091130; c=relaxed/simple;
	bh=MoW9aVmEIjIWLCV5hjyihPIC/ktQYRE+H5AbgtHmZiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hf6Zt1bYmCpUYPRD/rVV7alCac9cmeFLMJbJxnvEUiLGVC7S8X37yN3QAawulHfTGr3jNmQrMY06ZbbrkUmcf2CNypUrU4dMrPUDimZcOiroBeRwv4bJFdg42Lp+5WRV2ns2DcsiOoChLRN3deuMsxEjJkndo1DvnpjTwuIMrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSGgMTWH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+GLMv3x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSGgMTWH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+GLMv3x"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777o7WO4063424
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ke+t37I0zMJ+pgTEV++3x/
	JvbCj1SoeQggbCwvwg5pQ=; b=NSGgMTWH7eF0wx96Kj9pd8+tZLlvxcYtnBJ462
	3BG1JbSceIY/nL5iAGu5bAYEfcDX6ByUdTOEqNBWSetDQi3jgLvjy/6wWkuU276d
	8liY0jvuYqIe+kZE9SvTumJjg5SAobbzQ3XmRM5moTgANrQ6cCrA9o2MiBiDVZHB
	UNZ+UD4W/PigublA/GSAPFAUJzmrmxbB2BuMkC2v2JuKKvdLuiRrQvrKM/JK/8BN
	hq0lSYtWXIZY+B8Ho4wNY8l2AR8SN0BCyrxCC0jm4j/Nf8kdrm7/yh4GILzpLaC9
	BEt1Ys1IqA+6giANYlZYL7+OPTBNEANYZlIuGhDFNMQL+GdA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hawq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:25:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab041eced3so4612289a12.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091127; x=1786695927; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ke+t37I0zMJ+pgTEV++3x/JvbCj1SoeQggbCwvwg5pQ=;
        b=h+GLMv3xDqPaNtXDQVjglzzXd2pWtHhibY8F7brH/JtRJ/TNduxvK9FcrDh3nmW9C2
         YFHB+peji1pMakHlakrcDj3bTXfXn/ctchr8pT8yXYvUWemrnf4zNhG3FDxMHr6QhYv8
         08cuKg32O2qxU3vHmoXJ/nsPJ7AX9SSUKKVMRBzPVNm99qA4d92h36QXUDlhwxF6ct+M
         sR24hVT2jRo3WlQJ0sCN4nc+AjVDhHt7h55Meo6Todb1fTYgZmfoTTps+6l3IRUIpHvy
         WlYGQ/xjiJ5pydk8ZKoiMM5H31Xb/H1LQ1UzIXo1AzTui1XQx8XcgvRZDuF4D46hwyVv
         zBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091127; x=1786695927;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ke+t37I0zMJ+pgTEV++3x/JvbCj1SoeQggbCwvwg5pQ=;
        b=beQvSTMGeg9XMJyTPhlTFp39PrKn1R1JBvY5A6arSFjqLA0f5MySG+WebmM6oEQLoh
         BoCDnC09ZRm8fsdisfA84r4DpXJkSi7Bkjd383j43JlWfBxwqxynIAmnvll2UswjXgt4
         6YOuGMoVaVEs9lXLGHQU9YDFISyHm9DNhOMIBt160VqIKgeI5Gcm0q3U0F8hobHj4Ubl
         UyrjsoTWZAFRyKD1o5awvYNnJn32rV+RChIcODRcQ247uBcSkSH0J2d/Ge+aRLgurTF5
         ciUDAWTs0fdhO2THG/VcAhcK2wkjj5imam/9/R6O4JFAMQI4lR/OXO8o86gedss56trh
         1Xdw==
X-Forwarded-Encrypted: i=1; AHgh+RoSYwrRCF+CFx+IAM3EIejDOR4Co7b7ziGJHWRmcvqvp4JIUgshDwLQBv8Q0eYwACh2d/xgTN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Kqm3+ckVDPEcvHm2do4TQmlWVg0NbPG5nvUZIUHsl4MKYwWk
	Y/HU9SIy4jCAT6ePKTt7OrJzVfqSYP8TW/XGSXFo75Mk5eGLklb/Nfj5sHOZRG+J+SkyDwuif5p
	xYkIv3e2aXx6Kv9IeG6uVNMcwtZyA+ianWt2PIxZTNLqiwzss1dXMRf+xW5I=
X-Gm-Gg: AR+sD13IeWfXZN+ZmEfgY6YwJ3IeyWVGXFa2tp6DQOREpGqPTj+Iq5mz+UXjMQAeqIH
	6G3H+STYRHnJj1c4kBEFOg6YvkH8aUYr93zUd4vCjeF18K+EH5+Dh9FgLjm+TzVC+2Zjenc6EFZ
	qTF9Mg13v23RXR/L0fGDWaVnI09wklaCfcEozKkJXiy3XmFxcDlCF5Jfq5rR4omLleef4cQYWZO
	gbIa9TsrJVymTz8TZ+4HKbhEEYUQzP0Qk9PHmQla35l/0RZvNFQ2wJjgY1e6gwpcQdOBFMh6h54
	0V2K24torkLs3MBXj76KSfdK2OqCQD/WRU8Wwgt+KFHySKkoMecAay06kcXakNJTJZr96LzXZTA
	QBdntxJGa2w80INbCijKwtIhhqe/ob1VCTsU=
X-Received: by 2002:a05:6a20:7344:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3cb85df0a1bmr23641238637.11.1786091127056;
        Fri, 07 Aug 2026 01:25:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7344:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3cb85df0a1bmr23641161637.11.1786091126522;
        Fri, 07 Aug 2026 01:25:26 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:25:26 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH 00/22] media: iris: Restrict lower IOVA range for Venus and
 Iris VPUs
Date: Fri, 07 Aug 2026 13:54:44 +0530
Message-Id: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyWdWoC/x2MWwqAIBAArxL7nbAJqXWVCLFcaz96oCBBePekz
 xmYeSFRZEowNi9Eypz4Oit0bQPr7s6NBPvKIFEqNKgFR06Wr+ysQjwWG/gRGoNanezNoDzU8o5
 U9X+d5lI+lTsDVGUAAAA=
X-Change-ID: 20260807-iris_iova_600mb_fix-70f6ca25896d
To: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=4954;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=MoW9aVmEIjIWLCV5hjyihPIC/ktQYRE+H5AbgtHmZiU=;
 b=jsyz7552awp/K6euSPZ92b+AMIcGJiVfkq6DLsA5JqXWu4EiYLCZvcuBENFokYWnpEkx32jzC
 T4vwnLhTUajDmeSpb87XcRzNI1mExrwh1T9c5qpzB10ddgW0hs0sccF
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=G60s1dk5 c=1 sm=1 tr=0 ts=6a759677 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=F5J6Pypd3k36O_yxEmMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: S0ePaOY-Q-L3NVKbmAR18c1IkT6-UciS
X-Proofpoint-ORIG-GUID: S0ePaOY-Q-L3NVKbmAR18c1IkT6-UciS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX8aUBDqV1d//7
 eICXqVjXu0KARsG3SxK96gZzLfFqi8A5F+7xxqM5i5j4n6smJPH+UZEjX0iXd/O6oG/RizAfeiS
 82O1jtIqHZLtwWuPO6VzZFpQOXxK2uk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfXzupzGfiiHpkL
 zLtaoheUvma2Knr1gyhwzlubdtthneLmCWMmBkrHC8WSAFKacMH0S7KLXkXYkjxP6cMvcT36YWs
 C996AeSaZOnDli0VW9dicFyw7YbKbyPfYwgUQ5JZH6Vab2hMjw/0bWbYekTFbLrcJ7Zw/8bjbMV
 MBm/nKovrgLxl3FwDx5EmAuejgn8EZi6lfi4Uq+Osi++58RX2GngEQMFLjuSYBTcTFTlfiMLLEF
 eS2N23aYnOuxXiF3tSFlP1BK5pwCCeCfoYMxUameHjZQVNQ5MJ6Ho8y3IDP6v0t8TFcOvWOE1sr
 M1sCPRr1N/w/jf6sOO4X8v8gIrGkaQ5h5V65+5JHx5WDFsgMF7SBmikXWECD/92c2q4+vMRfd1z
 XDyhmujofs4pN6GV+Gpsqr93T+OdnYdf1H5nPbz3l0TS2ZnPv/SLxRQXkDOcoexgBqDFsHSDn5/
 /8tAiT4QXRZouSyUGwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070061

Qualcomm venus and iris VPUs reserve IOVA addresses below 0x25800000 
(600MB) for non-pixel stream ID in secure mode. When the kernel 
allocates DMA mappings from this restricted range, the VPU generate 
unhandled SMMU page faults, leading to video failures and, in some 
cases, spontaneous system reboots.
 
The issue is readily reproducible on affected platforms by running
multiple concurrent video decode workloads, such as opening several
browser tabs containing video streams.

To prevent allocations in the restricted region, this series introduces
support for an IOMMU IOVA reserve memory-region in the Venus and Iris
bindings and updates all affected device trees to reserve the low IOVA
range [0, 0x25800000]. The memory-region is referenced by the video codec
node, allowing the IOMMU layer to keep DMA allocations above the reserved
boundary.
 
The series consists of:
 
  * Binding updates for Venus and Iris schemas to permit an additional
    memory-region phandle describing the IOVA reservation.
  * DTS updates for all affected Venus platforms.
  * DTS updates for all affected Iris platforms.
 
This ensures that DMA allocations do not overlap restricted IOVA
mappings for non-pixel stream IDs and prevents the resulting SMMU
faults.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Daniel J Blueman (2):
      dt-bindings: media: qcom,sm8550-iris: Allow IOVA reservation memory-region
      arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris

Vikash Garodia (20):
      dt-bindings: media: qcom,venus-common: Allow IOVA reservation memory-region
      dt-bindings: media: qcom,sc7180-venus: Allow IOVA reservation memory-region
      arm64: dts: qcom: lemans: Reserve low IOVA range for Iris
      arm64: dts: qcom: monaco: Reserve low IOVA range for Iris
      arm64: dts: qcom: sc8280xp: Reserve low IOVA range for Iris
      arm64: dts: qcom: sm8350: Reserve low IOVA range for Iris
      arm64: dts: qcom: sm8550: Reserve low IOVA range for Iris
      arm64: dts: qcom: sm8650: Reserve low IOVA range for Iris
      arm64: dts: qcom: sm8750: Reserve low IOVA range for Iris
      arm64: dts: qcom: agatti: Reserve low IOVA range for Venus
      arm64: dts: qcom: kodiak: Reserve low IOVA range for Venus
      arm64: dts: qcom: msm8916: Reserve low IOVA range for Venus
      arm64: dts: qcom: msm8996: Reserve low IOVA range for Venus
      arm64: dts: qcom: msm8998: Reserve low IOVA range for Venus
      arm64: dts: qcom: sc7180: Reserve low IOVA range for Venus
      arm64: dts: qcom: sdm630: Reserve low IOVA range for Venus
      arm64: dts: qcom: sdm845: Reserve low IOVA range for Venus
      arm64: dts: qcom: sm6115: Reserve low IOVA range for Venus
      arm64: dts: qcom: sm8250: Reserve low IOVA range for Venus
      arm64: dts: qcom: talos: Reserve low IOVA range for Venus

 .../devicetree/bindings/media/qcom,sc7180-venus.yaml       |  5 ++++-
 .../devicetree/bindings/media/qcom,sm8550-iris.yaml        |  5 ++++-
 .../devicetree/bindings/media/qcom,venus-common.yaml       |  5 ++++-
 arch/arm64/boot/dts/qcom/agatti.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/hamoa.dtsi                        | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                      | 14 +++++++++++++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi                      | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/qcs8550.dtsi                      | 11 +++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm8650.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sm8750.dtsi                       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/talos.dtsi                        | 13 ++++++++++++-
 23 files changed, 252 insertions(+), 22 deletions(-)
---
base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
change-id: 20260807-iris_iova_600mb_fix-70f6ca25896d

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

