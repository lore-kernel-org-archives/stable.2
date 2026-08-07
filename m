Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2F46E003
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091345; cv=none; b=Lz/nkn1IDb3qw+fNInrn7UjwI7Fja/wd+x7yLCAz7fQLoqbJCiah76dIK3XrHSJTV0705Er+BKvz/KEPGXy0aVgrk6cFhGm2n5qGboMNXsnxoYx6CNask+Ns6NLB7kemy/bb9Ui7n9VNxxhWkznXsL0/7+WO3edWestDP0C6Hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091345; c=relaxed/simple;
	bh=sZMIXG0nwFtx1hKS9yXu7fbiWxUQITd58z4ngVTLdYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2v9uyBHbLjat1YKmLLEW+7VM6RB5vl2hfd40TGJ2HJNRu60MMOVzMD7wTt9pA+CV4Jya6HgcgJ9l16gmX/fpPIw2AmQlKFXAxvtQpUcw/7oEu8IIN5Rk1iK8ZlKYRZSIgXS1ggct0zPINqQ1NCpnQXYFb23mXQnREq/EiJ/Ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LjJYt71y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+ZXzReW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LjJYt71y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+ZXzReW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6778OuhO3477289
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPfon5WEA39AtPvjk1jAodAzzkzt/iDl4b7Q415BwL8=; b=LjJYt71yKwVcuWKp
	dKZazcTLWTJ6IlcWm1WGZ6hVmXnDj5nI/VhtP1/PgcFQSQxzOwqqCnklmTv0oeFk
	UTTkJbbhWTJEeMHztkn9KMjAhjLwPgs00nxNgTMgwNym63XrVEMrY6zRGJ4fjJoP
	5t50dfIoOMauefTQfE2sMMduwj5gq3e3bZRDN8HWx5K3IbfYc6nYOElnmobw1I6o
	6iSNYZt4nijy1ftn0OJcBQ7q8WTxZC6yMPuIx32uAE2mahOvsH4JaPPmeJUkafor
	IxQaN7MkJXjwi7npiVqOiTJoIniH0/Xlp8v6I6lGQzFvafBF1tzGZjEnXCtnvQPS
	B2CtQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hb1c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:29:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so47698495ad.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091341; x=1786696141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPfon5WEA39AtPvjk1jAodAzzkzt/iDl4b7Q415BwL8=;
        b=P+ZXzReWWtwmUaGBUCFf58k9RvQam6KC6Mektflt6I2uHsp0eSiX9tSqCYrsoC/KkE
         CImdiNu1NpTwbrDOMrKMZBKE7mdHbEBbmq+DFxiD5ft0lYBFuoktk3/4ZBoA4rw/0yKx
         ymK28lV+lIHOGaw2RdWFphEjiGV80cdP1GAxrMTFuDxsfvVYT1o8mFsy61LTrZodghrK
         ZuSZ/ZKd+Cxfl6SNfw0Pixgl4vmwHVgJfqlTaP/K4DCayLgQZrr5zSfVw83fiB4sIpwd
         sVW7nkp289pwQO91c0SL3KD4SIGUoXajiazMLsYvIEe2vOIV2klj/BGWulT+5vh6UrRo
         C+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091341; x=1786696141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPfon5WEA39AtPvjk1jAodAzzkzt/iDl4b7Q415BwL8=;
        b=jx1s0om9KfhXomR9m5DrS+fuOIM1OWO9dSquLnSsiQtBCsGnRIyAEx6QawFuC8VjAx
         o5ZkX08MtQF0nVCaaVkwEdxXRh/p38Ij85xlaV2WSm+2u+7w3hlNnJptSeHumkpaJSxr
         kFB7K7oImFVDz2JZCJNab9YywDaRxfiMUiU3TV88s5zKkjTrS/00JSVTPS8ezgrLZktR
         1VaYEEIzYle59MtLm4RI/z+YCbPYVypxYQ+DClzPndg8IeCAzgOe+fGoVullzxsSN2gX
         53j+5QpTqj0GGyUjALsmwuG3zkAGYEtlhIvqzQNYuq7B2rWv5JDfibYXvEy7PghNeTo7
         IWvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2avV4YknU2JodExhFSRKPLHwhVT22+GWY4vT7tj0ONYl0MqPqOrsnHWyD+KixwtxAXPo9Srg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WXVoJG2wPt+0S9LC8yUudqj0vqz2ZkJdLoBInLUhB72gQqSc
	i95y3ZOkl9fCZnMG8J/i2QVPsjCcCy6M4Px/AVwzVQNkNiWzOCEIjOLiFN8MC2u3NKDHmh7qzjE
	03ja7eAGQQwYPQKHCaiaHYYI4LzIv38vpJhEHFieB0R9FOeH5gRKtMJaJ1eM=
X-Gm-Gg: AR+sD13r5Zr/NcRmQ5Uej596gVBLgSR87ysB9T55Mimvit6Zjn+QmFHJGzZXweafxYP
	uJtGtEFvw5X4R6ViWbVCrbTYLxbc34Ii+wXxOvIGWmWcMiZK/bhVUZ4wgW6H+9DrQgcO6de6kKw
	dQZdoJIMLJsCyDLI8+BKxp03b5EsTk11aDqN2PnrSD/e/tJBLTI2vm7cJ59FIZjt/wxED8/1Fxa
	zi7LBuhMWeF2+HBCXlCTIeUU+pb3cRvQby/06ibe/ogNfM1lDWkhy0KAFapEoMosw98jKdiV1c8
	mdsVtxnbI23bR9MAbMx6tPfK5+SHW6DWfpGAf2/DORbjWWP6sjBqUXpjhT4tZX61HPBzyV4mTTy
	plxC4PRgcRkv4OibcnZ3g6B4+pyZ/KZSCwRc=
X-Received: by 2002:a17:902:e54f:b0:2cc:1452:a014 with SMTP id d9443c01a7336-2d0ca9fe7d3mr242992255ad.18.1786091341152;
        Fri, 07 Aug 2026 01:29:01 -0700 (PDT)
X-Received: by 2002:a17:902:e54f:b0:2cc:1452:a014 with SMTP id d9443c01a7336-2d0ca9fe7d3mr242991715ad.18.1786091340741;
        Fri, 07 Aug 2026 01:29:00 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:29:00 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:55:01 +0530
Subject: [PATCH 17/22] arm64: dts: qcom: sc7180: Reserve low IOVA range for
 Venus
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-17-3996f67e33f9@oss.qualcomm.com>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
In-Reply-To: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=2095;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=sZMIXG0nwFtx1hKS9yXu7fbiWxUQITd58z4ngVTLdYw=;
 b=azs3P4Ccl2Q5Z4JTzvti7qERDGhwgov9zYP710Sy9+TkBnRTMjcSG5V5bcwzmg0vMTALqij1U
 YllpVueplWQCSZVk6uqrKMa3E9Gz/e5jpTni/vF/Sa1Qw//wI/oXEnp
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: KCarfWOyoBhPKZR2hfyPLiUGeC1pvh5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX+v9NlYHKcJ2k
 65hMfvBIDphLWfWwalcIR7qDPRhwOrXQOnaoLOeuGXB/0kZ1jOTuXLx1T8Ea+b1PCSE8wWAzbre
 bzC8AXQvh7oIuP/4gsf1ueOYnBc0/UNjfdI+8fk3Eo6KGiHDQn0GXPayaJa2ZbIcZKmbxy3Bhfh
 QYq6ZEnovzzjL0T1v9qXGfQg1M0/NpyDLdEkV5Jr3rxNWvyRdqRMUOIBkuwA5BR3pfT31P1/6jv
 Dr4hTGATTmzUS8FcO1F2wy+Sp9Pb6XLBRZhK5ePTCi43GTwIxbj+82mgdSrZppeJ3TAGZ0MP7b/
 kKPYsuKb60jsqC3wka2gBwifz9nPiTtvwPMczKHQWGmHoorGjrupGuQF2RAMjwbeTTfGETwT0Q8
 3AijqxemBjoxxc4haNzEwWvB+ZVQadtau2C44OvJG8Zex06StxDNd7ujL/z063VxsRqBczCxskt
 EqlNV98a8kb0kearAmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXyyVztduMzWJZ
 0nPWCbeHN2ythoTzOriQvOWjn9zYQmUBGUBgN2G0fllhhROJxoYiYrsEsdwN4FI3AHMhSFtQ9Za
 2HmgVeumlAKicGnsnmsHSCLSdXXQQ4o=
X-Proofpoint-ORIG-GUID: KCarfWOyoBhPKZR2hfyPLiUGeC1pvh5g
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75974e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iB3bJDkhKBw2G02gjNQA:9
 a=pNMhd4EwCtYNc-yF:21 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070062

Venus VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the venus node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: 058bd0a68950 ("arm64: dts: sc7180: Move venus node to the correct position")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 70fbfb31d4a4dd0d0dd75feb37f686933ff38a14..4ea2dfe3110398ca3ec213301537a734b9cc1eb0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -692,6 +692,17 @@ rmtfs_mem: memory@94600000 {
 			qcom,client-id = <1>;
 			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
+
+		/*
+		 * The Venus VPU reserves IOVA below 0x25800000 (600MB),
+		 * primarily for non-pixel buffers using different Stream IDs.
+		 * DMA into that range triggers unhandled SMMU faults and
+		 * spontaneous reboots, so reserve it to keep IOMMU
+		 * allocations above this boundary.
+		 */
+		venus_iova: venus-iova {
+			iommu-addresses = <&venus 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smem {
@@ -3155,7 +3166,7 @@ venus: video-codec@aa00000 {
 			clock-names = "core", "iface", "bus",
 				      "vcodec0_core", "vcodec0_bus";
 			iommus = <&apps_smmu 0x0c00 0x60>;
-			memory-region = <&venus_mem>;
+			memory-region = <&venus_mem>, <&venus_iova>;
 			interconnects = <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>;
 			interconnect-names = "video-mem", "cpu-cfg";

-- 
2.34.1

