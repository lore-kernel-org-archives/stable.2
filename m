Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396032B112
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091219; cv=none; b=rYuNa5mqRObwMdQgcnarvxVpOjH41s9aFlnHONwmdM91iotYMp6pjMYuxaTle2aW4fF/xyxeo0rtmtrm9saDoA5x9OfyYENdTcjMAiPcuA/3cnIBZiWEdJR5ytKmDeCJaPUKpwMVStpnnKEYP5k/PH39aGqDh3Tzs+a9hHi2T2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091219; c=relaxed/simple;
	bh=RUJJjQBrrcmOIMJRWgb3GGaWcd7QRAQLbdW6SGpk2NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e89UKLlxaqt4YH3Au6iayAqmMo4L1QKQTu1Kl3vGsT5h9jAbMNd5t/qxjVTx9Meyxt90c5aYdVTiRLCU/HNwpl/NefTUfHwnGiSaUM4xG2sPDBrw7BL7MpWlzQA3uyq83cWvy6wdNKciXJgRif9WfNx0GC/n9qyjantrKYKwE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lSoe82Ha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Blb7eH+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSoe82Ha";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Blb7eH+s"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777norT3252328
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 08:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rcph1uyEXbBK81UQqq7ppFED8fJ0GoK6EhhgAUqQ7vU=; b=lSoe82HaD93ycRmp
	jSZqfIptQvaZSviCon0DPRODRDBisyj3Vm3K+tAb4PrcupTWlcU2ebQFsX/FGeAQ
	8qAofsjHhLL6jZZjMOp8mfc43beIHeoW8XoNwiZnupnmV4Uqq7whpvqJpQD+s/NR
	50kES3c3hm3rKgS09O/Mzqz4JvUx4i8JATXkU1K3R16dlEbz9HbzIMs9h2oGEkxd
	UcKuCMCAPCyT3Fx0PN0uSfy+Ity8wjQJ2phcmQa9/cHnaJ7FRWlNVs7yDR6PAXIy
	dDthHEE09Im2LBCE4FwyrbEXXY5oiFagbsZrNyIkp+xvvNQkHqsAKYFQwIIFW2+M
	LqhMqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6k328w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:26:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so3950390a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091216; x=1786696016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rcph1uyEXbBK81UQqq7ppFED8fJ0GoK6EhhgAUqQ7vU=;
        b=Blb7eH+s6kre+4d43N0Fr/lGE5ot5vXpa/HnsRqtwuq64B3A26coP13JWg4EhcfIMc
         g32m66vtbQVSKf7DmRS0swOt3cH7EmLKI8Fqb0kqOwIRGkNEcKOdEjQt8NxEqx0f+i7Y
         I9gLCrJUj8QBLlyauzo58/0BYHD2HM02wQMA8s9IoaQeqEGNOD3DnTyUYQcFKXZEm31c
         IRHt8YvDXhuTbbeOfmbIdy/QtBnNd4Ns+L7lAlJeTvz3i0srbsgQpJz1aLSGBJjCyfOM
         3VbflRcEU4brJSNbD7fAzUP/9hoJ+gpLuMYeyaZI56SQhbfDl0OO+lcjSmk6NLU5iftM
         Mn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091216; x=1786696016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcph1uyEXbBK81UQqq7ppFED8fJ0GoK6EhhgAUqQ7vU=;
        b=AT63K9Cs0tuwJ9fZsckse7K8V6dhOUXq+qToUAqCKl6lTt1+Tp6V3r4HIA88SmYm4U
         1m+WDDfAMWUK9y3fvfl2c749yoDbe1y3cgFwR6JxmpED3jmkebJzcwIwf1P3A/tBbKKU
         kudeRLuMWhSF7HW9YX3YuYwxa1/3jLfHGuEqNy+HAKwf7A8VDDWKttZCQM/q4Pr3sMFi
         Xn6rX2srjBnF3X/tgnECvL/E3sg5xZ/E8nyoadeDCGRptLdIzMt4rX+9pw78O5DNON63
         xDdoysX06ee3GICsA+txr9iIbMM+Y6Lru+MSBOCLb3icrHtyaCMyGkCwwhwPym+Z26ro
         RROA==
X-Forwarded-Encrypted: i=1; AHgh+RpUqYiG8Ubx7/fUbpcuFTXlF5fxCbG2LBZ/q6Y7K1I9bk6ugVWEjFbp8DBwEH7BYGnmqp/Rz8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpnaBjq2MDJ9vYny9eHIyvkQwHhI4d/0WY2Ee5D7CWWOvF2iD
	prcEtgSpyI8m1e/wNb7F2rOu28pCBJ/M2MtO9OPrSPkEpDbboFEvwUFFekVvl4fEHFzfMQGqYdB
	uaj7pAlufOAy2Q0CAqk65xGazuw0z9hxWg7YSVuKwrDzND4+P8vRmI9xbEkk=
X-Gm-Gg: AR+sD12VdUQJozF/Of+nBSx4V1yXT/dldYvrRlInECltmtouuGKSgFRMZ9ozUSsXyRc
	2LU7hbqXmRvYCJ30j79Ww2oYGEhD4CE41DrR6rTxxD6Ie9IdHnJj61fqtdr00s0tF4Gw7uzy1I6
	G6D/Q7N/uwRV375l2JW9QZR034pa/MInjlKo7uT+/vtIl4S80EySNoYt0+FkVdfFICzw0FCgo+m
	Y2iaPxvOB+BD4qKhAfjBha3SIe+Eknhd93d1UYChfo3HQtnxPND/GAtEOehEfAWMGTGynxtvP10
	qU6lKV8MZnxmHD2zV0EGjyQ3Xa+V084JEdvdKvBoPteLAuwrLbhmOaihdZG37ZbGWfN/v+r2RVr
	Yjlk9VoAC0QT11Kh8krlnFFyDZOwJ+1Z7TiU=
X-Received: by 2002:a17:90a:d644:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3903c582511mr21905484a91.12.1786091215613;
        Fri, 07 Aug 2026 01:26:55 -0700 (PDT)
X-Received: by 2002:a17:90a:d644:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3903c582511mr21905425a91.12.1786091215179;
        Fri, 07 Aug 2026 01:26:55 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm5377977eec.28.2026.08.07.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:26:54 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 13:54:51 +0530
Subject: [PATCH 07/22] arm64: dts: qcom: sc8280xp: Reserve low IOVA range
 for Iris
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iris_iova_600mb_fix-v1-7-3996f67e33f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091113; l=1905;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=RUJJjQBrrcmOIMJRWgb3GGaWcd7QRAQLbdW6SGpk2NY=;
 b=jT7fpDMxPQmhAEB1r48JCbu5da0Ay3ZhKOdpZCYvdXzQIogTSsvTBTS3Q++MpalDT+iPX3At/
 SlOjPDlum3NCW788nIknlHygUF/WzZJ4N4l2jXaFYuh3S5s6rrFxlQj
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=RpX16imK c=1 sm=1 tr=0 ts=6a7596d0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oZq95A5y7fdjfYKW3kQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Pu8dfc2wB_18sQyOfVvdz2DGurGnf2C7
X-Proofpoint-GUID: Pu8dfc2wB_18sQyOfVvdz2DGurGnf2C7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfXz7ARJev7jf0N
 n+mKPQOcK9VIc21L2/uHdq5/S5FfGw8eqwmmmUW2RAIQmx5BSoR9XOSv2V8an/t0k4FfEuqGFjW
 Y/Gd16bPuigivWZ3mJuxsZjsfjUjc+0bBh4dqifPP+VTWgs0iFqrFDCb8w6LMmLn27E7Q4jWgF7
 FyylMXRil9WO7kJLqZuBUojsg/JFTDQibb/fhyqUCBntOyEVc7ReMcK3p8XuVieAK/+0oqErQqA
 nJexdI5ioWq1sUH3qBNiGOkaLZ/cisi13GvUFJwVN86qOsp1TZLj941bYFHSr3V15oIPMrdD8cb
 mqrQRs3Klqoles0P3f5tmi8w0f/EplFw32+StdCAHB8OMNQl0KEXamFuKbrhHtoBb3WwnmRBEHJ
 biW2Y/JedKHwHE+rFesNlMhRLtaPqc7Oadk7yt5WMzg2IMXUseCcntWR1RgQ2ah1zc2E3AEjgcg
 QKTjZ8Wt7KC+7eKA+Iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MiBTYWx0ZWRfX2XZ/mbrtSTuq
 pA/yuCeedQrdxDMua/T/VJJioMR4Efk307NJ/KJX105EV692dItACxj4HiL1MItRxW1dNt2lArk
 dMTAB4vZ93Irnf9RpUzJcnVzTssfSdk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070062

Iris VPU reserves IOVA addresses below 0x25800000 (600MB), primarily for
secure non-pixel buffers. DMA into that range, from any other stream id
would triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with one or more browser tabs
driving multiple concurrent video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

Fixes: 3a52eef16b97 ("arm64: dts: qcom: sc8280xp: Add Iris core")
Cc: stable@vger.kernel.org
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fbcfd3883bbb4e465a71e60a2e295f9a4b3c668f..1c624683d003361773b5cd1e95424990e8130b9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -669,6 +669,17 @@ reserved-region@aeb00000 {
 			reg = <0 0xaeb00000 0 0x16600000>;
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
@@ -4266,7 +4277,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 
 			operating-points-v2 = <&iris_opp_table>;
 			iommus = <&apps_smmu 0x2a00 0x400>;
-			memory-region = <&pil_video_mem>;
+			memory-region = <&pil_video_mem>, <&iris_iova>;
 
 			status = "disabled";
 

-- 
2.34.1

