Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819829;
	b=FPTMZ016Eau4niftpNWAEfe17dNV20txVY3p7iRaS9QsVvcZnVht0vxs7Bb1bi0KFvvK
	 d+GbolZu2Gg01xcxEsBnwo/OcuTxZykprd43vVwnXNURC+z86bMO1kVu0Ec+inscSFt3F
	 tRn4kPx7tqWbj0JaOq+QN90gQMwwoh7RkJc25NUeTNL1t38qrBHEAPN2Ix4RNkjx0d8pv
	 PqiXkCYT6NKguK2MPa/5jwlExQ0Qx2sJE6xqImFYoKsxVAzR8vFKjIZ5xaoyRBmL50OCd
	 YW1uZ3WsJ1Q3iZyTUgMmBBlFatr1LKfl7uC5SJPNn/hL28tlr7nesHubC0SshfXNQRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819829;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mh0i61JUMejWj5g4lzHJHmLHyWlhp6f1+PzcJPwbQKU=;
	b=oGne/USg2e1QYDQlq2+LEZWxJTLiJlZW1VWWgwGQ5C9t4x8ps4CLHlpo3Oft9/YXYMTD
	 x8XspMbh+kREWoscOBJimjIFGabj7mK2YKFcbllfA95uo7xj0XQYuOHfdMdAj0LWrFOeY
	 HD5bL+xVw4oUxeyTyuKBzOR3mRwDxBzlBgS42O9odlDm2qkIwbWyjV05PkuhUJzyPjJTR
	 BGxxBUa4jB35ziVuAUz0XGqA/rFy5KcRK4duF3i4Adi5mrQAqwsOkS4ADL4DjUTMBVOJr
	 E+BahCyLwgHqmT6IypF76tdTiuB72Q7VaHw7z5BL8ye28oJDXOl98Qu+UoKtb9tmVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j2H2B3Vd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqKBOa1I;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676A606D83E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2676A606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j2H2B3Vd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqKBOa1I
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4H31X43031038
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 19:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mh0i61JUMejWj5g4lzHJHmLHyWlhp6f1+Pz
	cJPwbQKU=; b=j2H2B3VdIVShuUdohZdNELCHvIJZD2w6HtvgwswRkyUJvZlaGaq
	KBWEBFJaFtsGqoKTR2Kziz3AzWJ2XXCNbHh5Q4+D90i3P69vi3O8gs0CPTU7gj2k
	DQwtEPyyWAwb/05xhAHk6dK84V5NLvqxK+J4Nb58gde4qZdjQkC8OXRfDMGaenZc
	g6PMnJ4cUVmsNSLMeidVl5OTUoI6I76QniK1Z1yxcpca0BmClW/2nRYvN8b+hm+k
	zMmzyzsQ329Jm6Ukom0PsuCNnnSArvf3j8O6jLwOYcrUH4kQnsdlSFyd+DMnr4jj
	RPxUFGfSPTvfoNLtdw69ngSjWtjjWVpY2GQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr8rv0p46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 19:17:06 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-999e001953bso342241241.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793819826; x=1794424626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mh0i61JUMejWj5g4lzHJHmLHyWlhp6f1+PzcJPwbQKU=;
        b=hqKBOa1IsRTRWzGsScTHCuHfXsOqaJ2bCp5JVLK64tf8NrM4+dVDrSkY9tbhip0Bj9
         yywFhfojiPwdw1aWImMgd3/65CXIy8L1pfHtGv/s80eU+AL+5Mi1FKBjOdN4Gzv7O/zp
         AfNry3kYn2e5czkyDyGa2TcBztelQx2Np/mgAK9QMjMQZTsMkyuDP95It5UTDmNXsRlH
         0PmIRBCZpSe1QnKI81rhzgVSsbSKZQO7JKMTYe0w2Z4idKUEzbMcYwECrJJfnPfzO1Zc
         XSQ+DF528gqtc6v1aj36VKct+3qvvTU3dAX9eq1aYIpiYRcLjXTRZ7IqmjFMR/v/vnub
         8gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819826; x=1794424626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mh0i61JUMejWj5g4lzHJHmLHyWlhp6f1+PzcJPwbQKU=;
        b=czQ5/hDMMf8s+WJjGVCezcpBXj7DN09XvqkYmNpCufJCq48yElYoE3IPqi4b3bd387
         yTWdF25nItpLdNO2vYAWmNq9xaZVPN5y0hmcqmzMDU2LhFv6M0TkFvo/yoInsmVRjpe3
         H+LUanF1I2Da7UHlvEFBsWnDP7bBOBfzfj/xRQ9oBKMnwElZZI9feap+144T593r2CLp
         98nWsrNg6fbHG0AsA07vje1ZQskmZl0ZLFLR1eCf5Pp1TccF71mB/QxmcbM4w9n98ZtZ
         dKZzM6YM7Vojj3gdGAfAmCpxNBcFttsCteGsMgvhFjL3g3ZX4zncquu6ddHYZk5ZCNDa
         29oA==
X-Forwarded-Encrypted: i=1; AKwUvBy2h3R/C/JR64H/z81n1h8XS9e6yIgUCDCKqUtdDPQhC8vBL0/zheHqAeyHTRpBNYDiI8+5wXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Uyo+vSXNjf1r9G5E5fE/c4eNZKXtZu4Eabba/Gszqd2eZrBSY
	wlAhllv8RgmxaWRWFGmGA9sJN73xFC4ygSofJEzttsxm1ogsZY3gtdHQ2MrFJcYYM2/83YGXYDR
	TcELhVhiiQlj6kG5mETpBhABqOIHbhc+HIvlLzz+6AYD76liKuPPHq4YXu5w=
X-Gm-Gg: AYBFou2mQ7yNb5kH1D8Y4V/pZjNpYlgif9LRxCpRhick7oPTcPKlrrj2seYwU8dIzk0
	rkF5VQZT1/5PXR6cP2/dDGg+ca9u56yPTzsYh2101EBf99aHBGcn3v7QjcfwYcPZByvHy0EWSoI
	NSeTAyn+iJRGnZpq0MqrV6lFshzE3s2qCI4u+WXmy32HdMfie0SZ1vEzdCsT1pm7b46XX6CKi9q
	7AXzu05h8Rzo5/B985VoK5Lx4WzVV+/l4RKPfSVPXTpM44aEW8SmNBjvUXcUtcVNXdeEVdrKior
	V2Fd3sYCLsmQUmq5lGj/8nXiMw/jt2c5yXvC0sRZvWfkLTJnPHI9Z0pE1VChiTNw/hq3CIqUneI
	d3J1/u8z5THDAdZoktAz6RENMnBs0mcWHi8Vk//LGDSth3oB4p5wO/RP5L4jcPQ==
X-Received: by 2002:a05:6102:6cc:b0:7d0:3eca:a872 with SMTP id ada2fe7eead31-7d072711c8cmr7579653137.27.1793819826317;
        Wed, 04 Nov 2026 11:17:06 -0800 (PST)
X-Received: by 2002:a05:6102:6cc:b0:7d0:3eca:a872 with SMTP id ada2fe7eead31-7d072711c8cmr7579640137.27.1793819825861;
        Wed, 04 Nov 2026 11:17:05 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b414b170d0sm51276405e9.1.2026.11.04.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:17:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8994-octagon: Fix side touch interrupts
Date: Wed,  4 Nov 2026 20:17:01 +0100
Message-ID: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=A85EQK2rUPMA7hLoO5/FtN3bhTj/OFDlNXE8+ADzmpc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq64Ss+hPorLiFM+X6gXqF2aw7di7XVGZPHtluZ
 HH30LaSx1SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauuErAAKCRDBN2bmhouD
 19lIEACOFKHpb4d4Gd6DXD/mhgWdzmrfCFyU0rjL02uSn4Ym1UTtgoji4iqiD+388NCWCh+M+Hc
 Zt6mrEEbXOIqGmmRfyZkUs8ho42itrJkx5AMroy10LIGJrg2hclfcQ9s78l9ETMI66DmAsZmSVc
 2UgaqZFYM9r4jK/yMyGaZXASipbZmLcMrkqZmZIShaY95u2jHBPdnqghFlSPm4R+snpvC+z4eUk
 KOeQ1bY5wiAZ3SklfY/1xG4mC9adTqc1j716rCIor5oEetb3PtqGhEHG+RvU5zvyai8aP/XfTbw
 mfX6AZ1TRGiHZRNYqm0QI6mSsm9HOOfddg9euE/EttcJyuQknwBRMZYyYLLTbr94K2WL/mE5r5X
 kf/17MsxO6FuOEF/QprmVuN4+/haEsUt7MOVrx9afUzJb0xFKQHLgCgte0UQYg2d7RHJ6K8QMX+
 ArfAQinXMdJ2ARatJ5yps1NC9C/VStggBSJpZSEP8gXSwocRyXqjxs0TtmbnRLTS5lKk29CeHpD
 XHs2Pib9JqFeaTZpjulwHMAfzKvCMd/5XrLO2H9XIArA/IqrBuraTJcUbYd/MWLWsgiyOOUDXKi
 J7Sg/TXxMuabqiAOSZQ0Y3VanoGLqOsPP+tWoZaTplCr/eGEGrq+ZmKmFuvO9IuZEAkWrBPJpj0 HK1ancsV1sbM3iw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vtm2kO2n c=1 sm=1 tr=0 ts=6aeb84b2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KvnITNCCr6MzWQ2eYPcA:9
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NiBTYWx0ZWRfX4EJEhZ8b22y0
 PnThYfP9k4H54w76WtHNuJtmm0rgRKXCUpfqAqYA52LvECL4zpB9ZT1iBajBXose2ZEdmkzCaTz
 NkS36SiV2d8l1ynjqr93i/AlQ3HxP1Y=
X-Proofpoint-ORIG-GUID: jZK45k4L_IcSyjNEMID30RbaNbBaHrhc
X-Proofpoint-GUID: jZK45k4L_IcSyjNEMID30RbaNbBaHrhc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NiBTYWx0ZWRfX/Lb3HXVUnjqN
 m40HGDvpzf8TwjVVaXP6hr7K5uhBcExUWALtWI9D98OyPFqu62D+d7jzPa+awuKHI47zeJGE4wv
 4eX/XKZopmU8Il8OwoJeAKaapYusGPX3e9IcG82vDtTpPGQYZB+Yq8AspxanRwnsbf8tnrninWJ
 IjMMyFfn8WRPZG7MSpKzkbHRhH3u8JRGtV5gHDKrJYyBwt74bvujOJUviLEb4q7e/Y8uDB4+ios
 9LNrt4bKTcAufz+BJfzDyGz1lRRRlru85uemjNzOyT3u25/pZ6KR+StNjqxRRQXoQRdr1Gx5e/z
 aTC6zp9UXV1ABtbl8vayP1oCzMpOjzT9XvYPb5YwMvmkSSBYk8uosycasMU6bXJU+8Ahb4UQV9o
 hLWHYgOucaXrVqArlXu+dTcBGVQAFo2I0AhI7q0YV2EaUXrxjX0J1BqqJad8azxWHXyzNiFs2Bw
 qvws++XklvrvFrSJjaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040076

Interrupts property takes a number, not a phandle.  Passing the TLMM
phandle made most likely the interrupt as broken, which could affect
touch operation.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-759fcb27-d081-4ec4-9683-6667b54fa3dc
Fixes: c636eeb751f6 ("arm64: dts: qcom: msm8994-octagon: Add AD7147 and APDS9930 sensors")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 7ace3540ef0a..63dd5a1a1cd9 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -385,7 +385,8 @@ sideinteraction: touch@2c {
 		pinctrl-0 = <&grip_default>;
 		pinctrl-1 = <&grip_sleep>;
 
-		interrupts = <&tlmm 96 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <96 IRQ_TYPE_EDGE_FALLING>;
 
 		vcc-supply = <&vreg_l18a_2p85>;
 	};
-- 
2.53.0

