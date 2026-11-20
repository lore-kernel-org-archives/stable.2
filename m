Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165172;
	b=j0MABRlNDjX0nbH/UEYI+Tb8ibojs3/3fH0a5Boa7neEGE4OJR19OkYuFuUOnPiMNGxD
	 euZm0omNsIsRVaZqknAmlDtv/Q3kqW45Gf1rN362GKoKSOHwk1fiE3FpeEpWqh6hvEs1f
	 J5oURLul+dhSz4kBVS2DX5No3v2GSGSCDhJWYwV2PejBw1LjGJwwrAVWLjz/OmUWO/MGK
	 gxFVRyUJ0fYxFbXVP3acyHckYPSIrrsrX4XHJTxISTziONsVk1hlji9i+xIjsYLsSFPCO
	 SQ5CI9XEfcaWSthD5YQQKqwy3UFQ9aAVAfBr9ZktUl3NEHJqIB31wd8TfeH5SHBi9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9yC3cw49LDStsX4tcMB+rfbv7t6LPElYR1xcbvBtwNs=;
	b=otZoaXl9jlwsyZN5QP85sAY/SeNmetliP2yER9mkkqp5IRomEWZrdnfTsEVqKGFRfoir
	 Eickk5hiO6s4No2CbE5u5oV3e0vpyN7uI4/6f/lM1ART57e3F177Kh79ZN1EaCiXqZGVK
	 V+NC2wiX6149O8DYGggLdAHVixBl+oE7+nHqlBR1NQpcH8iPyRmDseK0G7EQbxi4QBldf
	 53OxYsE/ZFHhR/nxd74c5LLwJf6+uvaEyoOEdiJhoOFSaB3Z+A7eGJWxuaagEzr2F8J68
	 udSUwCISxfMYguFc5BE+4B01TEYyMiD2A/53/f1L5Laiqxnvu+jEpq6k6sNvLPsWcfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BO0BDJHH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ElOsWj5E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD3606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BD3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BO0BDJHH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ElOsWj5E
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7es7m2019464
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9yC3cw49LDStsX4tcMB+rfbv7t6LPElYR1xcbvBtwNs=; b=BO0BDJHHVP5a4Q88
	f5AOBZso9jP0CqVvq/jzpZ4YXg1gZ80sQqxBQhuOxk38gzK23+d+6E/XnupWkV7S
	kXEGgN11mu5Kbew6nqnca+/Fnwkkp6h3s41P/Zpr+Esp+GMvwHGkFjI3Y0i568Yx
	Ds7MThrfrA7j0AsjNuATNThYtO7NRcZUKf8mDr1/2vHmZ+PvVnDLhyFRl/k2GELB
	U3uZTgB05BxXE3nR0EN/CKRYQijwjhScCwVATg1VRG6NyJVEi8xavWBMFN4e0d8Q
	mtYm8m/4Qe86Eyl6/H3ZM4SsdA8AdqLL6I/9bIE4kYo+1nnWOV/a8h/bwN8EcHBX
	dtf7WQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj8y1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:59:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3846d5f54c1so799392eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795165170; x=1795769970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yC3cw49LDStsX4tcMB+rfbv7t6LPElYR1xcbvBtwNs=;
        b=ElOsWj5E9b0TS9gSBOn3D3+hcgB/GUZCjRBIuyrObE3uwE1pvQ9r1KDCi+Q1vQbBAv
         cuw3VEF9lL5wDqgSCGijg3r31M7+gAx4YJUkPwR+mOdUMsDaWU9hFW0wLARBodkCG73j
         ONRPpCL58WQBa45Y3w6Us5kpDvuRb+c1u86LoOybFddNRaQ/5ozY0ScrK1cQL4Kz0Lgc
         orGheWUZgR/j5Ahv950l/BIREqdRFqYOn6V/DB48PzHGBgVjsOhA8IH7+DvagFFUTi/U
         fhdB3aE2JEz/uUyoBvkgHACwhnhbua+vUb4cioh2gQqYjjENG+rFDLceFZMAivjlfOQT
         jlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165170; x=1795769970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yC3cw49LDStsX4tcMB+rfbv7t6LPElYR1xcbvBtwNs=;
        b=ER6zcWltnX3PooP/4Rs7kdhpASZOAa3XhbhIOefaKKoCRjZ3I9Xut9Ghpn3MJjp3AJ
         jD4dRDrce4Wuu4EsuI2I3kQOe9I9W4pWxMOnwia9MROSkptYxpIxTX0MAP9lLSFS+cWD
         Y+VVyLnWoEAPvmvw6GPGnK1uGOccx8MkyhVHBgQg9zY718ZZyMY336Is7aX2t21s1ptG
         N1v8HDNf0KEtlb9RPhw5dj56O3acThF5vzykaE3AR/YqUmWjrkkwYj099gtX6h88xrEM
         s+mFmdC7dlinePPh5CNcXPYtUXX66lEGnzoayIR8f3wLNOzXsSOCL7+0YupEqeWQCswV
         r0fQ==
X-Forwarded-Encrypted: i=1; AL+hErFFyBwzr5AbgR8DF/CpeCV/EEbkvafyHZfZmoDCzMsLxSI67TgE0wt9ytIOOdog8qWiLrv8SuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vFruc8ZLG2HkDx+o8Ulr5Ivxswa1LpBYCs9nxVwKDkL5HCszR
	hxyXcaFUc6Yh91od/268FSNpZIZyA/UCYZt7fn1edVaIRxvDeAZ+Uf8tJ2PdbeGezMVYphiJeV/
	H7cU/49rsCkqvUzNrRoHUd0+MvfPRsIictj/7wE4p61EVxRa20fwtDRTaINE=
X-Gm-Gg: AYBFou1QnNEx3EFLmF8mDIHhxb7DVQcmslkIHAc4qQdaZ38TekKcaJqYsVNzLkuieeu
	Y7Bv01KG2+RDAZxPkJvnrawSab/Wr43AAJt2gQMR26vLa5BBOoqkuwSjj8uzGXGUJcdnHVMazfW
	BFcKBgy8g+vBHd8tgtAE9LZIddFAxiGHMVcwIP/tdFghkQZSWYS9JSMDuxzFvlge2kNNMt7F3Ok
	f6avOk8FKebSaKToU0iJEV3IGk1CqEep1Atfc8BpkDgnLJs53Vkh7/0FFgPLkUDT0eaETydguG0
	+aPdbrO0215GkR3eaP7HtL8grrr3O/IUZ3NfTddBjKkum+eqCIrDoJh3/u1A8uMltpmQNExt+fa
	7zq08j1IkDPF2N0AzUdzIhoy5D0CNgZ9Mb2Pxn7hrLvo93vrG77axaibuFmntGrcqrWRMWIcHmL
	MFH80L6HulE5h3ltjmgfhaKfbTzrH+ydpdDkh9Av+e536BEfJHGik6QiKwzbvWqRLdq7Bgy3L74
	GGtUadCIXA=
X-Received: by 2002:a05:7023:b12:b0:141:5281:8a41 with SMTP id a92af1059eb24-1b55687fbc9mr2380944c88.9.1795165170184;
        Fri, 20 Nov 2026 00:59:30 -0800 (PST)
X-Received: by 2002:a05:7023:b12:b0:141:5281:8a41 with SMTP id a92af1059eb24-1b55687fbc9mr2380910c88.9.1795165169700;
        Fri, 20 Nov 2026 00:59:29 -0800 (PST)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm9490658c88.9.2026.11.20.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:59:29 -0800 (PST)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:29:06 +0530
Subject: [PATCH 1/4] arm64: dts: qcom: ipq9650: fix the TCSR mutex address
 range
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ipq9650_various_devices-v1-1-14f53b84c42c@oss.qualcomm.com>
References: <20261120-ipq9650_various_devices-v1-0-14f53b84c42c@oss.qualcomm.com>
In-Reply-To: <20261120-ipq9650_various_devices-v1-0-14f53b84c42c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b000bf2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eUx0VPcQqj1qSSogbGIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfXz9za3r2qkGIB
 LTcG3z16AIinYeeAolzkSyzmYDtli2jH5lfrnaVXda43/4qxn/dMtVtOy+t33Bsn3dipfHkA+JD
 qVtppYDhqsfDeL6rlcpvDXYRhf576vo=
X-Proofpoint-ORIG-GUID: dAYsAHBCKioqXf0-LdK6S7iw3Di945WL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNSBTYWx0ZWRfX1V5uvg7tb8ed
 CRmveGrlEzpl2yJ5AdckGLATgWQKtJjnPSuNF8BAt6eZSUfirVGDEdpur6ct27V1H6SL3+iyGi1
 vS7TEO/2lyRp1HMZSt7bRVxydofk+KJOWipwF1dJv/sfUf9h9gle+7aH7hH24jANsqDGTJjuG4R
 CiIMKie+CI+CGyLuNbT1EBXnPQWf3rOsFeli5vQDIm32hKGYL3CGufwar1y3vdQfcG148ORI/78
 NREdVpSs6JywqVUWzu8fRy9yRZoR435iJEL4F8XwxonIdbNL/wQPUXynM8Ohv126BjtepfHHtsb
 qB1XOcnZRnF3WqOc5CcnRiMU8xrwTmaaqObo2be2uXf4YHk1rB4p8tBGulvmHNIVQwXis7VQ0aq
 vXQSeeO3a0nsXVfVb7i5RSX1KDww2c1GQ1xXLIcB1fqbsmf/LZN107Po+zGEhtxTxIUkLlU2zKs
 u0xuM8QbH8JgcKOylEg==
X-Proofpoint-GUID: dAYsAHBCKioqXf0-LdK6S7iw3Di945WL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200035

TCSR mutex region is 0x20000 but it is mistakenly mentioned as 0x57000.
Fix the same.

Cc: stable@vger.kernel.org
Fixes: 8cef25a0044d ("arm64: dts: qcom: add IPQ9650 SoC and rdp488 board support")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq9650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9650.dtsi b/arch/arm64/boot/dts/qcom/ipq9650.dtsi
index 9ace638e43e2..94269c9c8d6f 100644
--- a/arch/arm64/boot/dts/qcom/ipq9650.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9650.dtsi
@@ -385,7 +385,7 @@ gcc: clock-controller@1800000 {
 
 		tcsr_mutex: hwlock@1917000 {
 			compatible = "qcom,tcsr-mutex";
-			reg = <0x0 0x01917000 0x0 0x57000>;
+			reg = <0x0 0x01917000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 

-- 
2.34.1

