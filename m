Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C053D647C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091231; cv=none; b=Jkw+uA4nF66zueAUaSCzVBrbWZBuxm7xgajxNcj6/Ng7JxyXDiYtdst6UUnenmD0Cf+fHMPa++h09EpqqGnYBuuukDRd94G5LPw9mVh/xegHg5wFvr2twMGWBYwSjJoNxrhZM8cCU2SpsI+djSG70lUYMI969R+ZW1E5z0NabNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091231; c=relaxed/simple;
	bh=HnLNXZ3RmH6DPK6kLjbwgAC4lbvAPZcKDrBL0MlxlhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFN0pB+1K6/UNIyF9ieiP1K8uyWAnb+R9XS8FUBsupulZ08P2tgJvWWKXFvYwervqXWiKoWVitDzgSI7u/Bo0dZKRyiNkXMNtL566cPfTg1pmo83s4P9HBJMuSGWsRfbSPAnnV8GXtW9uufQp2aMNxiiGw2QEFyba8WKh8EW1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjxkJiZy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N87YjIQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjxkJiZy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N87YjIQS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777vLAm3519198
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AHVZhIIlu1sMygyrwMP/LDeKV2f0QMHo2ueK37WbX6k=; b=MjxkJiZyv5H6KsYi
	lY3p29gzWhcaItQERgT7nsRioVJD7JFbiegN7pY+BpwAkVHL8utooaKPhd37vIRE
	wgtRNkcGu8MUsC4BQYjUl++nz5rwRjr1dT5A80shaSnh3l29aoWZ7tQmK78yZCIs
	Zoc+CYCj93rVwPqPaxevHr/83/mj/k8M450DaZxSbbWYwyQO6rgrVINAPH9y5Ter
	5Cpd3MddeyLQIY35amdESF3Zfq3bE/bZghxqtXq8hUByKsXOmoTsC9dbO7Tz1TCI
	E0mxCECskfh7wjz48kXLyZDEHSpuQ/9P69jDUBOe2U6RNbg3EeL/XzjNY89UQUde
	UAa/og==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6s3212-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:27:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb733fc5024so4387706a12.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091228; x=1786696028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHVZhIIlu1sMygyrwMP/LDeKV2f0QMHo2ueK37WbX6k=;
        b=N87YjIQS0lAamLzEeJ2ppaD4IBq+z5Ey/oe8bfVJ+ILfzQbgznosjecP5SNU7MvTlA
         yYgSYdJb1Tf8mtOCiGe7rxEXZk/N+OmJYFPiiWhG3csyGOa/qQUcj+6UCM9Fm7BgTahd
         LcrE171GclO7FCRkTy4KLBr84NXQ3rH+PwQEMdYTT+85JyKinjy8oAsZcYubtI1GXsVo
         XyeYYB1A0wMn+VNTq34rT/VC+UDIO8DW6eXACahLOrWUlsMpig03uJogbAt/r7BSQXPW
         y0pm59GAMEyTf/dZ+exW31kC5i28EGlCdEHt7e1Vh3mdQ/v9VDXCouOqqN7b2FDDFemc
         CfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091228; x=1786696028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHVZhIIlu1sMygyrwMP/LDeKV2f0QMHo2ueK37WbX6k=;
        b=sCJO0HeRXlKosxzOBSiEl1o6xLlpz1jkLJGXgywoMQy+3uYC2fcbQA3YnOmYrFTH9B
         wpqTLgCHjPIcckHB/aJanJnOaP6ZSvpNy6f1lwBstxeB/UTWO2BmdX1F+jjizecILF69
         r1zjcR8cXHf5+arMT4lupUEM+lR4sKv0BLvtKZHOrSr9I+CHWLkLwzA/m4c6KmA8GtT1
         /QjG/68W1XRImUN6wtajxPsY6rTWQWSaqUxbA4yjmWvlq4c6bmm0k181lQix9j0rMxqL
         KI02mnjF9RVsf8pXmw7XGWXXud0vzwPWO0PNHmk8IIPZXVNMCe/XQsvh9+weAZbnCvjU
         Wdiw==
X-Forwarded-Encrypted: i=1; AHgh+RqoWojeZhsFBBlBk+C89PJAhFoq6ZtguVhgVcopVN+28K2/NnmlmZcmNpaQKAwbKEh9AImJdjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3ymEuugf0PHNRCtcZ/hXlqSEfB5nGXNkNftl4m7D486qjWBE
	YVuD94d3FRDTWbFUnrW5dFa23KAtsa/eLjDEwaf2EzG/8e437W4dcG9mC2InsNKeEbnw5ToRMnA
	muocSm9ysZoxX3/0wnhKyXRe2Sx02b3jWfstfJexDNTmc39Q5EiD1djKkiGs=
X-Gm-Gg: AR+sD12pRDmZpENOAp+P7k3Ogrm2xvNUdJrrQzi3Iekdls1bafqmcHtxRYhy9FBrd1S
	uigAwCpV7sr5TYKHRBxQ+3TrG48nrmPG5QWfcNYLeXCsskZyr1amU0KAQKrd40uVQ6qb0vkifpm
	2wLMnG8QGVzItzQmYAQGbv4Hq9Y8EYOJjrYTuQvjwdtVN7+GJFpWopTNyPCUFE17PiaA4ShIVQ2
	GU32weYNbA+DSuydgDgDUjk2WZlaldMYGuVFjxzKkhLo8FQAwSc2aXlrLIpDnc3aU9Dio4o1wEp
	KB1V9WUG0MjckodZ07xKvU9dPKvTM4Mr5DnQiBVvQ+1AIwGIlySi9hMkannRAescnyn5XWlzjT8
	MUCswOwaiPyabW4lalWHPkto05/bJNAluGT0=
X-Received: by 2002:a05:6a20:244d:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3cb85de8c46mr23889689637.13.1786091228039;
        Fri, 07 Aug 2026 01:27:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3cb85de8c46mr23889659637.13.1786091227649;
        Fri, 07 Aug 2026 01:27:07 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:27:07 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:52 +0530
Subject: [PATCH 08/22] arm64: dts: qcom: sm8350: Reserve low IOVA range for
 Iris
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-8-3996f67e33f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1902;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=HnLNXZ3RmH6DPK6kLjbwgAC4lbvAPZcKDrBL0MlxlhU=;
 b=nii8Ur16o/TRrI8KA5UBdMSfzt5dFWlLfYGhYvMMqw3h5pdaI2NMuTIzDYhUu+KTvWdFC4XFG
 yuISWtMIpKeDRDFVTd7/a8wrk66NRuHhAa1uad2wy4AqrwMhkuNAav/
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXyAklZkpGmTzb
 zL57OEJrQB3d7sCfE1di+5yfCvDWIMcxwsTAoI33fJU/v9fHmMSzPeIoDn3dwUbL9rj8yXgmd8x
 j9uZt2moG5D/2vS86vy6qwr3SF+A5ig=
X-Proofpoint-ORIG-GUID: 7cuL7JL5yZwkHjOlI2oK3Lh59Wf4nV0-
X-Proofpoint-GUID: 7cuL7JL5yZwkHjOlI2oK3Lh59Wf4nV0-
X-Authority-Analysis: v=2.4 cv=B+eJFutM c=1 sm=1 tr=0 ts=6a7596dd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oZq95A5y7fdjfYKW3kQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX4h6n+xhx0nlm
 WnOvRc2A/pMhgxg6lXx9wWhfY0Cs7w83sbEVlbSjNYbTJSqzCPEXNqxFdN1SCBNRd6LY/mE4Axk
 kWw35nrMhQbxRueMwIDF2Sk1qjiIAllgZosr0VJ8eliqbPUZkAi4rY+sPv3WnScr6j4Ouah+Ec2
 qP20zwc2ybQa9t4GycmNspFT/FIssx8S0fkvTXMW2ao3KURpujaS3HrMUF+kdCMR+Aps2fe9IsM
 n7zOsD1KWAt+4EEKie4ZSvHCSaXwc8ukvObK0hqq6D4DUNVYJn5pQXw/F1oESvFxlXsoeMOzvTQ
 tAwJIrqV62myQcBZCRKwDKcwaz/AvMzb2tWg1SvcoJl9b6SDXO57B8TZDpI8A5+C48Sr+DJdCwH
 8nPN0M/wkueunHRMpgRL02BTwgqv87IyNac9pfDmGtxhPb2cXy1tDfo+sy4kbsgNbCRh1sUHqDL
 HUGW5graXx/nrMpYApA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070062

Iris VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: a2b0c5eba743 ("arm64: dts: qcom: sm8350: add Iris device")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 32b47f5ec1f6755dfe9eb92df9c03e5fc2c992bb..b376dda0ed5208633660cc3b975cee738134b758 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -553,6 +553,17 @@ removed_mem: memory@d8800000 {
 			reg = <0x0 0xd8800000 0x0 0x6800000>;
 			no-map;
 		};
+
+		/*
+		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
+		 * primarily for non-pixel buffers using different Stream IDs.
+		 * DMA into that range triggers unhandled SMMU faults and
+		 * spontaneous reboots, so reserve it to keep IOMMU
+		 * allocations above this boundary.
+		 */
+		iris_iova: iris-iova {
+			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	smp2p-adsp {
@@ -2786,7 +2797,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 
 			operating-points-v2 = <&iris_opp_table>;
 			iommus = <&apps_smmu 0x2100 0x400>;
-			memory-region = <&pil_video_mem>;
+			memory-region = <&pil_video_mem>, <&iris_iova>;
 
 			status = "disabled";
 

-- 
2.34.1

