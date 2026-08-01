Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EC36D50D
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569889; cv=none; b=Qc7+6F+yGyGFURy4gw9p7bNywPitHJioNPnEhhO/Vtk5nXiBFenCQCxNbEG9FDIOSq1GsQf9rYrePlWTBEqZuDfL+DZEFJvfkxWfUFzizKCR9sDGbLXsFRxGhC+1AzKHQxN4k3iUhsNDFWN+/wbSl9BHXRNgAQ2aNDG91mYySeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569889; c=relaxed/simple;
	bh=yp/PSl0xJvh0pHjc986tzEZ1xFg02iT1pk3CEWR1FPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wmlcsg3dV7VKV6CBI5E5pQzOjE4j/vRuckSd16ATblqDYbGpRdJd5BwZMyypPNPy5ftS1iEZipimW2yrXKzuqMNvIM/j3pINGJ3BqtbnMdwgpk6McED+Ceh1ZZ9mM2RTn+scUSizhUAJk3jNYmtK8WjnfcRKOSIi5ej+yisHMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BE5xdFyI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X0bCkALz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BE5xdFyI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X0bCkALz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713jWXX1688645
	for <stable@vger.kernel.org>; Sat, 1 Aug 2026 07:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tY1FfLNEN80IzlftEjkLni+KsGCPFaDfJXgD2tZhNV4=; b=BE5xdFyIKzhrGmWY
	tMbqDLOal+/f79rWWyRlAyR0ipCNf5YYHIQbLmcplbMptONqsozTzvhF0tJGMNaC
	txaVZtfBTaV8jsJFpdXOin/RsaRKEL9elLX1YXitRG6I85dq4fq823XZXU/Sgshl
	UWWI4voyj8INADSWX6hHiGN501bLskjvZL+1UoqZZh69kgkZbuaq3+6FSN8RhWkk
	UugkZ2hrcHl79qMHJmYr6xTGIEiSEeh6fOzn/MShdjTfmOVSc7bAFXzG4BY9oJNE
	FrQeoqCzrG+pDao8JcqvyaWlkRzuH5a+papKFONn6RfpSQtOwEF4iR1TbgXi3nen
	onbhWQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9668dhq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:38:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so1840851a12.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785569885; x=1786174685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tY1FfLNEN80IzlftEjkLni+KsGCPFaDfJXgD2tZhNV4=;
        b=X0bCkALzkMICBnTNwLXSW5A6XmO3MFfE1gPq6SVaSC5y0guh1gGPCx7ai6rJLA5lNr
         /SDhYJdUxI2gpmh34d6BfKzgPDX8sE9Diyf0cb03n8p1SLZQHFznYjNTQx5GFT7mRSiq
         F+dNufIsI3jLjARJx/GFADwU4n59C+MDa/RGYKS1TpD20Lap7ouJEZde/7BJu08ynM5e
         CLJNgGdxtM5x8AM+257sbrFRYUT76MlIoAV90aP1cwM9b/VTKLie8xgTmwRycKv6nii9
         A59H4Q3NHj4lTG2tJkU/33ZPU2xDA69RlepONSDVF8xb1GMbbTfQPd2fJ3avmO7pOxMB
         YjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569885; x=1786174685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tY1FfLNEN80IzlftEjkLni+KsGCPFaDfJXgD2tZhNV4=;
        b=XsavcTyUCh3yukHvx56LJBjQtxrtmPxSnvWn/GzzA4NVVoRRnj56CKsxNjQIempLav
         RJA7JBUmlIThWu4jCOyi7fcBXgrAmEvvAxydIXDnZAJw0F5fE2MV7anHTuAYUsiECYfK
         2JYYZc0Mf+2CmGOGDq3Y2JCq/dcOJPweJHXziFDwys5PYaGqWoJNBxy2iMDeTRZn8kp4
         m8YSZPf6zxJi9l4pShWG1YZu2qzIdhjNbJQjgR8wA9I01g0Wz3I6CbT4fVh0IDU5C2Ov
         8oUUxEkVzrHkIia81tsWbc7y+Cu17S3RnUZGfsXng0JuBeV8uAoZT97fRMv9REDxW7Lr
         g+4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpTSr+8m7mFX8yz/V2Fr4KbCDL9Ex6Yr7AQO0JpjQfy2orXWsGC4RPLujmb8V01mAxJ8K/0OMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpS5EAgwR1LJ2dhKP2rirqXqs/gBjs7z4FsExNc7OcpgnvrqT
	Oy9yUjGBBCcDm8QfO6dN8YUlNCiL36DxasMOaeO9Kd6egVvmlQhZ8TCx/qmxsuIK7grnlBPp6qo
	nfd0PtDS1JAr/amk0mXjAYdM5RsrfSc/JwziNz1GOknq9+7HywMv7OH73Rds=
X-Gm-Gg: AR+sD10b/Nv/3Ya2CCm887Bn/qv/wtJp5ybCS8A6ulf3M0MyqqSE/ozbTPgn4F9Vj6E
	V8KaBcwKpUGzrgsO+tVVgEU/EayWuwbxX2Xgy9nU/ncWr13yJN9QyMvciVqjNxpdTpMoEEhTT1z
	NwUFv32LPq/d2I4hreG4VTvHCGeSZgoM12EVl43OWZ5zqvbx1+66LZNpTvpjiYHjlg8e2Y0EG69
	ZQNpvmC0258TaixuxKwELpIqx25qXzSFQrmE6wEhrdtz+Awe7nFwp6L7jaPUbV6RIBYI9F0EmrX
	9zyLGdS6YLsv1mvL1b2YqGy/LWtp1P9Epfq938M1H4e05CkFDP4Kp1521EbsoyLeu6Nz0rnUnOe
	uwBIorDR5lTcBmSgqhWno2SPlAsE4BsgC1Q==
X-Received: by 2002:a05:6a21:489:b0:3c3:9c95:c0f1 with SMTP id adf61e73a8af0-3c92a7bdc19mr2645714637.41.1785569885471;
        Sat, 01 Aug 2026 00:38:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:489:b0:3c3:9c95:c0f1 with SMTP id adf61e73a8af0-3c92a7bdc19mr2645680637.41.1785569885037;
        Sat, 01 Aug 2026 00:38:05 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm20729985eec.19.2026.08.01.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:38:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 13:07:27 +0530
Subject: [PATCH 1/4] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785569872; l=2146;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=yp/PSl0xJvh0pHjc986tzEZ1xFg02iT1pk3CEWR1FPk=;
 b=bdiXzqz+vcV5AXLwJ5u3t7V9OaQf3n97puy2Czu3Rn6hX9fTuJf9Tlmf7dakhYznqXPqCM71e
 9/u97zjC4HoBPmeiIixLqfVUzy20A0lamYsWFhfRRfjFudAccqIUyi9
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: nqVlXuHSa6QazNU52CAJGm70tPBim_YB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfXy+DGqzQkqEqs
 eNM++FynhysbLZSQXvCUJCyelzunM8oOpM2hsvbNKjvyQY5p6OSc2OtLz+HNidB0oY8voDyfCd+
 jQmo0IXqui9Hr18mvLUDk1MiHjm/zcgmhZ5+jkUb9Xxh0xcYUCZLt/i5RyzZ3vCIMNmicfkzrk6
 dat9oBzi9eSOo6kI75SBR60i53f4b8AAGjryL2sgpwsJie8odi68p7SKb09vTNM9xy55HTm0R94
 K5KkH+bEzT+O8u8R/ZI0uNifKkUTbAbhfH7Qjtet852pMYGXReEYxJrQWz0w9vhGY8RmmxCU6qO
 loU35NZwNSaHkwoyBwW7ROAtrtGntEbhNhI60ML3qkoxQve7+fKbicNIgS/rPZb3HJ2bL4oTuRR
 vj4h5/EPCxD2vmsR5wsOSRq9BzYxi1/c16PmcyEqfAEIuMDIxSHbKW5Vb3gjpngpSp4l/8YzAu0
 sV3v7SvMxErOzDAp7/w==
X-Authority-Analysis: v=2.4 cv=TpfWQjXh c=1 sm=1 tr=0 ts=6a6da25e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=blfVeHGCn9lIR-DKxncA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: nqVlXuHSa6QazNU52CAJGm70tPBim_YB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MyBTYWx0ZWRfX7t80uZbhffe8
 qQPiZwN8dQWg8mUfRKj04ZNvwLlNadxsmOThNaXbpKmdmk3PGv/tydOOGnIr3xY64L1L+z1TJsf
 44mSwXeyKKwFRdc26DRlchNSTCs9nNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010053

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
 Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index 9725fcb761dc..cc31f3ba7e7e 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -42,6 +42,8 @@ properties:
       - const: vcodec_core
       - const: vcodec_bus
 
+  dma-coherent: true
+
   iommus:
     maxItems: 1
 
@@ -85,6 +87,7 @@ properties:
 
 required:
   - compatible
+  - dma-coherent
   - power-domain-names
   - iommus
 
@@ -119,6 +122,8 @@ examples:
                         <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
         interconnect-names = "cpu-cfg", "video-mem";
 
+        dma-coherent;
+
         iommus = <&apps_smmu 0x2180 0x20>;
 
         memory-region = <&video_mem>;

-- 
2.34.1

