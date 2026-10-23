Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746210;
	b=o7CGMbSmUUEDB1b90xLHzVZVbvZR61bjQlWnXOMGYNTniamoK/YhUgcIZITIu5i1/mA5
	 CrDLAQeiTZOVTwtigW4lG6VQQeP7ersDSljWZrWowppIl3o4k8nXDyghtZ/MSxF7FmZIM
	 EVpJyKPp/Yt5Po1LxHRJaBNLzOm6iUYC+W0vyKcauuSpeJbsGpf4tsnszV/JJixQkkCAE
	 8qZ3CTutSeLEDeuVmPVjaigBLn6deuAoss1eKC55iT0WVkB2hwmoSjvMey/3xP0iYrT2c
	 MsF5OEXhqpmyyFZE9IAGJ1rVObc2qiH6GFAAetkEMEjRUrTpjFPwSJdbFUmeIKgUArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
	b=AE3IZH5y/zs03GBBCq2dsBZRz4VMHZKAYLo8yF0RZm+YtsAubIO1JGOpIu5c1tFX906b
	 UiJF0+V6WmC+6N9ZWqvFp78mkJkPWOJD1ynM17+Ll5IiQO8C7iNsfkpCx0PeCv4CokLBY
	 sdBJ51O2uI7B79qMNWciJleH2/g0yajh+vS+lX+3fxCr3z4PShqfw8gl+AjmZs/7x4XD8
	 6BqdSjEKX4hBeg4GWTeF/YoS4zETgWCs/qnIUh8fz38ntTOnLb2cqoHzH1CUP5Kq3g5d6
	 +DqRc2tBBKxgZQARPE6mJQLNZ8vMeXj+V3BzoBqeYA7j/IcfEBw27dWyPCi4zQorsCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOklABr0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="J0JY/Z+X";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526560A260B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9526560A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOklABr0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0JY/Z+X
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FT9T2650369
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jadIZSIrpTy
	Ei91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=; b=XOklABr0j/NFfZ+wWinWrioG811
	NY0GoQIS8QewX95BcHrRB277F9Ls2y/Afkk0Mg59eD+Fxx3+sMbVgOi6JOYOMLGy
	vlXQ1/ApH8jdEP9uqfrr0rDuVokjbuTcVYPIZR0eyEmusNMsN0hdHHbouZys9poo
	jWI9YRxMhXKbgIH+crOstxic8+JjN+uNmuTyRMVjcR+9U+zWdVhoQ4xJ+v2jeVR6
	MBa/TldiHqT5G7Bv+9zFkB/uhyWp+z2qg5Z/IP1z49sHlO/cqw3CkH/QNiCkbess
	h5NWTppYX4dJGwufgeqOpHCzhvKYbrErJctBL2fRlsf6t/ix7gKTQLvHKtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjawag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad436a9d00so720856a91.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746207; x=1793351007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
        b=J0JY/Z+XgpQkPURL2WMJxKAHS+E1JN7uxRrUmB2LIU2zISihcfza+P2cixI6xN0N9q
         ProtUq2w1H4UrawORYZYF80oJmKedV+iqExuKMAekW5qcpRj4il/5FkqekWhUeyE8at3
         j/HY8J480zbr+rOdTheY0B44s5+PZVKjI8XFZefFLTDi4JPrsAvL0nO1dyTxn4vCgEmw
         w9Lpv+GTcaA8XbcutddtFGlBcrwc1qBL0yDoa4aOOfeApwSmQAPbi/Kfo+d7HphbgHNI
         kXYjCYRhTk4y4V/VDTfoLjqi2JQyFrJKywt54nt6LbrFwdVOcT+h57YyBbX7zgdWr0O8
         Zbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746207; x=1793351007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
        b=eJKUS1c7MkXREu1XmQcNIrniD8T8/tmtaFH2qleuF6kamEnC1nmLH75OmsB9bmqmmE
         ChvTfPceidrG4ms38hRVyEksQea/1DpKbCxjljIEGxMJ4dNfv/n3oBXp0ioku2bvQoVZ
         kMXFcEt9/efbb7Fqc7IJ9UeziCpgpu2Us5Hw9GFh/KHL4AIEjSvYDsHItq9n3bus1K+t
         Z9KemIhNa3ht+ozn/jSzTuEKud316Wc+0VxXJ0fa5xUPZoyD/KQ6mxs7yQMVFE0KQZy5
         VkFgAQH9lvw/9iBsCXiiq34kneFGRs4OcsNFMqNMZNltgSw0wCYGdktxQNuW4A3nKQrm
         9k5A==
X-Forwarded-Encrypted: i=1; AKwUvByR9NSW8wdAFKe8GpBGuQ8IITRSNCFveHdNYPZkosGoi5mnDEqamCIS5Zat8XC4HXF3VaJ1tE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK4DxqUZYVS9zydNs1J67uGACiC/0P3Oxc1DSGmohzaFqcsbKI
	yiR4fgDNZrFHwyYCWdFj32L6q/C8sRABdob+grPnGJFB2F8sf/ZHRVgpASh8Xnzc9b3opR4l1Bq
	qtBTF5MGzJnKtu8vaivrCn86HcSNcgNjVMbnwW9HguQBVos0rU/Kj2ANspeo=
X-Gm-Gg: AYBFou2BW841fgY7eAO3hRcxhrSI2U65FnMRE2j1Xt+xhWadaXm1dhu4FWbqAy1JF/d
	RyedPTnfhJa8RDwoxOYl72BEIb1qpO6a0ExN/KKonquXewvOXg/azAfegKEbF5R2c7lYWr84RUK
	zhktCDVn3knlc9J3jAvnVbc+bdIJpUqMP3+cKgblxW/yERAVIZd42Pgx29Xl2CPUJbvXM3/iOGX
	Wj8cSyGeS36Yj/I24bjdp8fwFpnd9hdo541BLUYbhW4ks3G56wtBJafXSInHvZfvtei+FdUTDTs
	g3b3NDv7uY/ug4MY1qsD5wtGg+FNBeiT6ysuP3gcUCIRv9VMr0CNUtEfn0+aqGIxGE0Fb8UX3Bs
	C5fmUdJdvFrKFgWThZO9tRfO8bpRWVCLKMg==
X-Received: by 2002:a17:90b:1343:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3adcdfce5d8mr1244123a91.15.1792746207510;
        Fri, 23 Oct 2026 02:03:27 -0700 (PDT)
X-Received: by 2002:a17:90b:1343:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3adcdfce5d8mr1244091a91.15.1792746206987;
        Fri, 23 Oct 2026 02:03:26 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:26 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:04 +0530
Message-Id: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f0X9slj9tp6E3MJ3ycES-oWg0bHqw-RW
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb22e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tob_Kch83G3grsM8gxYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX3UxvZyPc6HCj
 RuTQaqdn73bmc0gkQJnTNgv0AHDtYJjuiE3+2A8QLqCxU1XIcCdutLqaY2Q681jzC0ejsBZQSZ0
 9M3KbgeA/BjsznadDYst0Z+oLTVqta4=
X-Proofpoint-ORIG-GUID: f0X9slj9tp6E3MJ3ycES-oWg0bHqw-RW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX+yD1dgo5u/h4
 g0UP0dxue2HVE0SLewkioTGD9NrIuL3H1Oy8q4rwWyJNy2t60pFG++Jwd9Y7xVC8/5awqhcx/DS
 THMXqiJ3xGe1n5JXmw/Z+UiG35wmEAUJj+meONRNdwQRMH4EgLdHAv7CEi1dzXIkGF5ux8OUozn
 2Ke0ed0CRjRZXGg8zfNN+NM3Bv9Wz/vOA4obrXLv4mdx6TPlLevUeNVwgs78Yx1pT78/tFifh8B
 E4gil9HHxfMpzRToXwJdpBFPY4VfrGEzE6TW9W3fEzGetwFXHZGVFmwdtK9N5YycqzjGH+bcBbt
 ZO69DA28Pq9m7vTyStSTtW+ZNh6rv/F4PvJ1zjt3GhAqKXUd02Yp15FTGHifIj+om7mhaC8EKMU
 1p/aJ7af59zi2hmGueeKnStuvpyhL6v3yzoWb7cZWFVEUGFqSgeVMqFpazmGd3ldwy3lHGm79/T
 y6dbIRSQXOyM2BDnO2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

Remove the compute-cb@9 nodes from Monaco device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224..e73a735f2f13 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -7822,13 +7822,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x19c9 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <0xb>;
-- 
2.34.1

