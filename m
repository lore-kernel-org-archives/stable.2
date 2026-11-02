Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620149;
	b=3dAMBmwGaL8zm2rFwAhJBcMks3SD9A6TDK/HbWVoUNabj/19MUnawM9IwX3pqegJ+kLe
	 J2db4bO/lzI3BcuQQADWHpWCIH6e5Y5yHTeF7oCW24pVt0HLNhTFiSQYPidxXUlGUdUbT
	 9QucMtSXu4PF0zMvvD4YzO2LESx7o1/UR2dBJViXUbpIrBktLsLe0FrT65fOix0EmbqTE
	 LBfgLyBVEZtAE7OmrLM26iFZUefnwuSKadoOrvG2kkWFcs0NXUCkSG4jO+oSHTMy496bQ
	 3IX3aPAhaOHkEdvu4DlImDoiiI0Hs3dkEBxdnS4I6WLtSsxJMb4S0DIC7/6e+CDeDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620149;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MIhl96XrVO6h3egsH716wpa0+bzeQt1syKhoX13a6Ew=;
	b=GntwhtrKmsXzvhIKP2IeHUSQ1OnomDpFUnJV17c9rPSivFBD7oae3jD0QKRpTF6hgpKU
	 ek1K5pzQAx1HTsCrOi01GV5Oa49CsFBC7DtfP6G0Y2CRC73gC0ceOizqD1tUgfCZiA0Ti
	 E3/xOvVxN3/eJTSRXs3Qt+KE+PtBwJOk3Etk+wLD/QNmnLaaRyQjmYSoAkE/LKaNKAVtb
	 uz/KgDAs+eOewULqKqcRVLk+hsaV5cs8ysMOTnGOzlbt+zXIMkr+oEV20O0J8SxxqcdDC
	 nF17k7e6OFHcniCxX6IgGpfaxoqJcJfSxOUM4+v1E7q1WxYh5GVRpdYkVHl+w79U/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N3ow2HUe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKUMBpGG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2C606A33B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B2C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N3ow2HUe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKUMBpGG
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AXJW3086640
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 11:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MIhl96XrVO6h3egsH716wpa0+bzeQt1syKhoX13a6Ew=; b=N3ow2HUeRab9Viro
	5nysgmFgkDbs5ypqJJilqqtXkzVhOwlmho7t34QDW11POrylfI8KQ7kW66kEsNSw
	wcxCXBdxjlZsLXe3G+T8oLu1+JdMvShcWkJI+rqeMdcjoPftFEIzrAfCH1fLjP75
	0REt7Kb5VcY5O+bt4Rzkt8gyh6Ss9c5Twhkdb18/RCV2yHnBguxrQVv6UW+qiZJm
	1WkDDoyg4J109pjMIiNVE/XYpR1mB+2155izGnGMBEH+oK3umgFPPExrbXsmj3qU
	CSz8FrRG05nrWA8chnJ+I49xNnIK2LhTleI39hYUEF/9wLkDdRke+DiEi6785RnO
	xKFb3A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61mgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:49:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5365d95f4a1so46135141cf.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793620147; x=1794224947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIhl96XrVO6h3egsH716wpa0+bzeQt1syKhoX13a6Ew=;
        b=MKUMBpGGJlWp/kD8vvd8GOBmn8m5aZcDiFSZcOdkHQKXmd3XuibdvEOvoPlP9lOOBd
         pZbduisBGyWw4WHnb2jm1u7MbOu2kYO6I2+dkxZXV42zt9/DudWAIIGYCYiZVmQunxfp
         Sj+wFb9M/vTsvdoB1eg5zFh0asHCbxOryydBu7EfBKARPYKCdVB1hmzW6AIOapdMyuE/
         qUeDcZIcQIq0iPLjBXh/Nha0yuHtZO+XNrMlPbzBBkdlmg5+x+94F0c2kqmCxox33Y8q
         /3sZgukb1AEe4FithNM4LnjbYRNPncft1sYuOvoBdgYOGM/I1wJ/iiOlUe5iP2L+0nA4
         qvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620147; x=1794224947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIhl96XrVO6h3egsH716wpa0+bzeQt1syKhoX13a6Ew=;
        b=HWdl+5QbSuy2rbJ4v+Xhllc+KMvWVHuWLNtZbRQrMxYPFxEbKl/4Gl8XneChOKV0S8
         Sl09anVcIxr30/pLiw6I/xdKHaq7eGhjiLbBaWw388aGCYxOmY40yjrTbu4kxe39jKEI
         iHN9nMca09u1Z+e6vSBhg3NPti+1bbWXdPmp8Zrb49P+Oj1m4hTP3ubsfYqntQHRWJTc
         spMgeecqjgxHAOAXc1rb/+mnPzq5HNcBmW4Ve9uHt4hyEt60Wi6Yfe07OFZJtlNEbUpB
         /Q+xC4QfhI1huixVcunLZI6sbeEeeuiANndNlAgHpObA2A2pIrlu8G5VtAKM5TfCHDxa
         Ugnw==
X-Forwarded-Encrypted: i=1; AKwUvByXeqyqUeAaWSvYkBqam6uWyBgx91Q2MUWWccf56B8mK27xQc2eSGQfM1GtNBoy/DbZAG3wi9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+efznMIJ4gyhk96SWanJ+IuPWvYi7ss8zzCrpH7WQQ6pT0geA
	Sw5rnDTB6OPXsKn5G+acEL6Mcluu9qZnkNnPURaK/vCcoOPK0jLDmC9q5Y/qvRZFC3Kd+iXCe5J
	QPU/qqOAo5TMh6Gu3Aqs30BWLUCtP3iJr4BJuKPSYzCCylJJQZrblqxaR3E0=
X-Gm-Gg: AYBFou25dyNg2i9HKS/wWUS0+cxpPnSX2yGsguThfqWe+uh/8oRQh9yiIKTezVzIFXE
	AZJjWnMkeJB0otCoaslMm4bjhRJvEe0ZHvuxJXFqDegMLXP1ffEV2ySo0LF5h1K73EXfIYJr5+F
	bCNikrpzpi5Z/UDGLnFZR7opxr1mA2ZTt3KZRw0wMK97xa+Ul8/LwMI46kjwTITM+u/OCkxP0jv
	KTL1JPTez55V3Pj110AdDxt/fABmOAua7ANl2ih0RklTpm49oXZPjo/ZxU5XPabVGCy/c92zQf5
	6Hq1pD2ok1/JqmK6BIIC/F3PscblwoC/T9gNp6NNt2xpJcX4rtO29xw9nuhbgcsokoVDLLKRRzk
	PatXLQdDAn27uGowueHYpKSEEHu8APlKfRit9+afN8cOx6yfYwr0YwW7YGg==
X-Received: by 2002:a05:620a:2794:b0:93f:61a6:b7a with SMTP id af79cd13be357-944217b8e35mr1507874685a.62.1793620146713;
        Mon, 02 Nov 2026 03:49:06 -0800 (PST)
X-Received: by 2002:a05:620a:2794:b0:93f:61a6:b7a with SMTP id af79cd13be357-944217b8e35mr1507864885a.62.1793620145048;
        Mon, 02 Nov 2026 03:49:05 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725b8sm19766031f8f.20.2026.11.02.03.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:49:04 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 13:48:50 +0200
Subject: [PATCH 2/3] clk: imx: imx8qxp-lpcg: Fix stack overflow with too
 many clock indices
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
Message-Id: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-2-1c3fc3fe727c@oss.qualcomm.com>
References: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
In-Reply-To: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=dhlDpkiSrZhRzO/cBPcN3/Bco39G80HHAf8kGP7ODtU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6HipW6PTYPSJAlrKvb7+9EmcAI3l5HEoGI7/I
 2F4ZkNz09eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauh4qQAKCRAbX0TJAJUV
 VkNrD/9rDjIkvAY9Zjhn8SYl9PRi56nuL9RalFeecAW+CPPz37wCegFcwBum1JuVTWOtlGmnHoT
 5LGTqDf/fcJEQhLpb0c6MwAxvbQ3VqpeBRGzfkfN3NYAquxuDXmpaNqRYCOQDJn5U/KAINI46Bi
 v+zKjnd+i1IgUPIa3URFlvM0O+AQfoPKwPJjI5k9HMJ4Abu7WphOR0JAOCPp1IpcvdhfVG0JeG+
 zyaWy6yUPaqOgQERPFEkBRzpadAyOllZ5Jz2k5HzfkDMCKLnD8CMK9KEymw1n7jFPYMl47Yfznb
 zL9aLn1gEif5ciH6hJ8H/oS07giqUhGnJ6z1V87got0QndfFdjm3XP/nYI2RX/GS99nbP1Bin3h
 OoFQY8sPu3syIbMjei9MKmDRFpY+kctJ4rQlXoh5IiEGbhhs07X9PzfOTxpe/a+DKi1++yxQCo/
 KoR+QXmPc4kG77mJKvsf25NsMzjKKGjisECaJk07bswkgNGZF4pR10HQd2qczgYbeI2Uf5uBVgl
 HFE+I1wywFJuSZ/pGHo71+kCx7ar8VgLejjGssWuTLWPkFel3DrDeBIi97VAy7mglug8gVdLAw/
 H6q6heBVtbSP4Avb4mrOc7uBGB4J3P/1ejQfyYSRKjXLtaZY8gIRIf8iBIEyQrAGlpJsFVa68H+
 9r2f/OcNO43eJRA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: jyrz_u-UmpK7jO5DTPb3IJP7Fvn9ODsP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXyjHajFLeL3Q5
 zfhMdYl7+Uor9dMBGkdpM6h39FcveiJU50jVonSA5gQrI/bPZly0Im5ot12A5WJ34lwmrHzffAm
 yyBuSWDSSiNMM2Phvi/j33Lm0F2ZHBE=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae878b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ci3yrrcZy3FTaSNcm8YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX6nKDMs+x6CiG
 ILcuDFcR8YZkDEguF2Ncdhr4MaDN5JQAEeHIPgcNtNC5ruewYSHc9Yp5BufoEWrnlxVzLWuRoK7
 jeCLDxtiMKgIXtJ7hJzg+lNgn5jl/Z+8RpXfu/NOASoFD1pxNVkx9AExYi2EQNmpkPlgvSESKrq
 I6VtPFn79AZi2B1zPoL9I8a1z2BXtq0VLHjyeusG3ziLAVKTvKQfzh8Yw3WvzKvr+tc6q02SKOc
 oGjJ1l/xJfbconqw52h1kE5Exxl93OqW+4D65/htNaouRfOeOtsD4pzrfCHWNOni0rCmh1aQ26l
 q4YxS2nHW2qPHVq69SBZbEPHBs/Lsnkl9SPzfXKqKHS6OOO783Sbq+7ftdu+w/vBQLbHF4hcjXH
 v3rEQTfMnM/5P3FONqNx6HeKEdNWoo2oRBd40ej5sZipT5JO2m8yCr8C3WQxvNKLQF5ercdGIgZ
 5oWz5s0bBaGKQk9Nddg==
X-Proofpoint-GUID: jyrz_u-UmpK7jO5DTPb3IJP7Fvn9ODsP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046

imx_lpcg_parse_clks_from_dt() reads the clock-indices, the parent names
and the clock-output-names into on-stack arrays of IMX_LPCG_MAX_CLKS
entries, but sizes the reads by the number of clock-indices entries,
which it never checks. A clock-indices property with more than
IMX_LPCG_MAX_CLKS entries thus makes all three reads write past the end
of their arrays.

An LPCG has at most IMX_LPCG_MAX_CLKS clock outputs, so reject a larger
count.

Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index e57e7bc074a9..ae8cb5408246 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -200,6 +200,11 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	if (count > IMX_LPCG_MAX_CLKS) {
+		dev_err(&pdev->dev, "too many clocks: %d\n", count);
+		return -EINVAL;
+	}
+
 	/*
 	 * A trick here is that we set the num of clks to the MAX instead
 	 * of the count from clock-indices because one LPCG supports up to

-- 
2.54.0

