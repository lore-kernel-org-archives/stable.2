Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373669;
	b=oDjW7ubK+mvCcG/2e0WbMGE+9xzyJkneT5Hhxp1Fima56xoittSjs1p9/xyB7cgTv4mQ
	 Rysv5C2pbZgbegt2iPtBrZq9rMBtyeX7iKuTGHczrEbjDAoBYRIxJSoffsl729iMh35M6
	 3xbzwx5+YrmVK7+plvqiUq3TKY88zq0MpXQYfcXM3DSrG/lSOLCoIwjHuVdSg7AcKlV9L
	 1hbYB7WgPwBkuDOscw+b/3k1uGuLY3R+BKwN/KKhPnkAQ2oXYCaa6qguTbWl5+/vPzq7H
	 k42cUZ/GjUwL/icWm41gmAyFSOMBei5JahDC+SLiBCbXYg9CqPCuPrmbFuRCWA5othg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hzVHA9oH1fp1U3bxD+Kp/H7EOO1vh46+RK07HTPMYsE=;
	b=UAIatooWTTn6+lODQz+LpvjjBYCt+9QUWH1XgJokOY4nbNs7YUcwaT4qGdcEIYhLKP2g
	 PJcm61aKXogPPXqCk2FnQJasixl9TbL1YxtGzvFw92Cr+v0aoM8U7VPJNzyPHCaXXiNHY
	 01T4x/QDXbjPmCUUNPdf62/ut4/eke5dBdf/pALXfmcaV30GYQMw8xbeoQHMLgdWCo++K
	 PTp8B+B1t46AW5gRjMrumxEk5g9AHvG3d2U8CgE/N2znsb3eFf1n4BOLG3tWdt/knz9rt
	 QTCKnKAeET84SJC+X5fLeRoP4b7QFG+yTwYLE40a4JfbFW80pqeReRfanQcRHH6Ka/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=is2eDw+o;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=beciiupL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B1606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=is2eDw+o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=beciiupL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERDMt4102993
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hzVHA9oH1fp1U3bxD+Kp/H7EOO1vh46+RK0
	7HTPMYsE=; b=is2eDw+o/drrlO8mUmPy9wbZBprfadno4l/KkKbuwNKOMSLMQL2
	eIAc6ypR9D9asIhA/MUElCmHTHmdS0z61YvQ10i9A5ty03s+afRnJSWHqm3J+kaZ
	rZvOZhPpdF7sAneV7bhoP5gE+vxoVaEYL1VC/Y5FLMrtqHUAiza/+Gn5BUNf3Xxq
	LM4va1ttWB8lyfQSOZPhc19iBk5nMrcJYiXiNaiE75WnRJt6yVoINEkI0k8WYsUm
	JNFrcB8failP3+8V/oOb/L0q13jzK8GVtBCQ/DipJGgamreuxGesgCGFXIHwjGa9
	o42OUof0IhQU7frDkD4NkfRmUfGxf9AgxdA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkqef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:21:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so169226585a.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793373663; x=1793978463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzVHA9oH1fp1U3bxD+Kp/H7EOO1vh46+RK07HTPMYsE=;
        b=beciiupLGg14b9ZIRn00pwmpENqmROfqjZMBenarothwqIJr3PB4ebKq3f8BY9PsRC
         ylPcbeAotfvLHAwIqUb+S/FdHBp3++jU4IbnbDKgfUCCB6X5cGmjF+qrGCeom8VAkne+
         Nuw6Fy42eusp7mGIla9CJHKsImuJIeleZ6IkW9jsBc9kIeai4M0SeVLXVRCxjWAfLfOo
         udP4k8ArWIeBLhsflOSXNo9MwKdXfz351wrFIXwFWYlW6cJppQ0WIojH2DCjUFvKb1lq
         ikfEMkIhRWRRMyep4Gi9KBSgrhxTvUWFJkb9BFwMLtlENVq6CyqLWunzJexjIRsx/P2X
         BXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373663; x=1793978463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzVHA9oH1fp1U3bxD+Kp/H7EOO1vh46+RK07HTPMYsE=;
        b=MjsM9tiCipI2ky4bBeJY1dAEl0Hd0BwUKDlVoqiVmHPSmsrozs0imAjLouRQLJL4qh
         cFh7uc/axdmpAUNotSybjiSel77xtWoM9YvtfFDxbTWJLsvjU7jYzBmmjy+HGFI3NY9I
         S//KNY6g6R3bAWKb70l9FVjo/uO29aKSbl/gjD3cifugdcWO2asKYitGzhiU2nk5OhDm
         3abgvhpwk1MxhCiCk8xnt7tlr5SFCfGG4zsZRpbvuiG5bnz/iItTyvXl/zIQ53GoWNMC
         XVZhlAIHHDxJjUV07SDSWGVmziU2LG/fYDUYkv/WDivXIWr9Uu5+A56PMe3xN/7arf5z
         YeCw==
X-Forwarded-Encrypted: i=1; AKwUvBwRoNYp5/0nCep5lLebZGB+kDSSAm6+nICXFrpNO6M2B8Qm9VtIQBE4pjuH48CGDRwRVkYgVS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+fFtKl06hT/vAEADDzQtf6ENLJH9ehJcnahzPLELNcr8fqIP0
	9ilJisiC6srS/+2Mu1ZT2m/wsnkmcUcv9uQFgdMV/UBF47H+vd+7vqo8xply89wh5AcC9x3rcjJ
	s2Vu9PCIOJw/6779BAtZOxq6dsJmoZMQbaxsSIj5/MmdeOPCGljYkgaaWJNc=
X-Gm-Gg: AYBFou1j0M5RxXuD4KKiQAEY4DhommT5bezA1sm62WssUPv9uyp2v5ORY2XGmo7pCtC
	FC4+gVjyrVZko4Tl38xbF5EnLIPiiiYnKkUDLgHVVeMiaq7qHWUARvD13mvQvNOwMJ2UolkQ6UL
	+CpmGekOdnDACwv2hEx8FYWKMLD863A+CEjuL/Hj/zLWqgMiLcySnBuoUgfJS74pqk9jzpqT5La
	wEcDQAJEcPTtj+zzaDyoGf0IR7zbcudGAAui7D2qausHNhO7AU43I0yvoIqHPEIWGum50rnvle1
	mkG7TJgn+VWp/gp7VPZJxdcocVV/qu24hSZviDLhTKStAdA9RZX7LsZRzxuWhNwNXAOIWW+4tap
	YDdbNKcxeURXtly4oZhMr67Sjgz42/v3vVR7ydAMk1zZBvwBZDYlSAQi/KTiMvg==
X-Received: by 2002:a05:620a:1a08:b0:93c:9d56:a860 with SMTP id af79cd13be357-944217439e4mr452270185a.19.1793373662648;
        Fri, 30 Oct 2026 08:21:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1a08:b0:93c:9d56:a860 with SMTP id af79cd13be357-944217439e4mr452260885a.19.1793373661793;
        Fri, 30 Oct 2026 08:21:01 -0700 (PDT)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm105732875e9.1.2026.10.30.08.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:21:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Boris Brezillon <bbrezillon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
        Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] memory: atmel-ebi: Disable SMC clock on probe failure
Date: Fri, 30 Oct 2026 16:20:56 +0100
Message-ID: <20261030152055.280193-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=dWU+lW1XZUsON1uVforDhInBvMK+7M9QnKSnKSK5E9A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq5LXXvtQhu6R3DuDcLTc1io0pSkK52E7jxYEMj
 PQ9ZI2DgImJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauS11wAKCRDBN2bmhouD
 1+ZxD/9cveLk0aYNZU6/ZDm2z8I3ln6xbcr30h+oGeUWaRXMV2v0p22Kq5sQenJIRlqauutDHr/
 h3AS1sAyfz6MY9ddT9T63Xiojw0sFMiI6/w9CP13cCLbSHjpTYfU94joYFi0BOrkhDjEdtj3YWT
 w3nxAyiYJ/Tix3wIH36cPCCHCFkBOoE0uUN/ZgVGhIpfmUq5wfeAxtRijwCSKEuKKwRvm6R3+7s
 UnPgxRkXOntHBwUED5qaIlfAxjKfiCgnptev6qwqD6iHadDv59b0ZtMS4iQwq2ZKczy5O6w1PD3
 xViUFR1U3kfeQGsfoqWxeQDvte3EsS48iDMaA/TBYZkXySl63G0YZhj8GOn9ZrUfsVrgbZctfbd
 zbHyfUvunKEqc2ezEg2jcbgXi7tPzkMAf9UVPffBrXeL54IlyprOt6hbN0M5jOSTBFyqUwq8SnX
 mVyZQ0chCWrnchpEV8klQ1MALoGyJ4BYMft5U4NJeGyjtKjjxEm7U5347a+kUBj1y1jsE9CtqqN
 uvnSJ7wZUZLMA8wnce4Gu0zlVrxxd+gzSb+2Y3re/Ty9BDhu9otY/4ueiqhBPJtQ3mcrNc2Yz6T
 UMdZIzDZGGHwCLFgLSJNbHc93wsOO54s65ukkk1oUiBo1zaSXGkdHa2orqEAXj+ufrH66BxIgM1 aK6SJHObYL+HVWw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX5uYqUVS6RpgH
 EhAf+oam+YRJ0iXYHRhGTPE9jczHkahPnDIULs75xG5OoVRlOyzBazvoz0b1vKkYdyyTpbE2Zpx
 L+yXWjWZ3T7qCwy9JjEKK06iBxIb0zVniPNRByXgsVt0heuS6YcMQsY8FwePOrog7xom1TRLfDy
 dvzCnWUi/3JHVq65FTLfM5rpV/uWmhS3s4smXXc34yaGhCqVOeHRlHlrXj+YVsrRRX5qRpP4wrb
 +j3iF5278LLL+OCwQJBufuocrRwGdhmjwrbPYT9B40ypJcn3zMnPF3AOz+AEQ/HkLONgxus2fDn
 N0Jq/06ox08H5IqoxFIdn3Ns/KGeXir/qPHRPqu19vVRHAIkKEWcw0PKhw1PmNI3/g4Kl0Kxdju
 VUIWrKjfMMfVlvO+6rMlfTng9SGza/SChpFdUPcFDx/vNha/CberMo7RjgJSERzxLPZXRUPY75T
 Nx85ybkZFuQFJblzvPw==
X-Proofpoint-ORIG-GUID: 7Xh9eA3VW2gVaeuNJ_xeLjqCKOi87Rkb
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4b5df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=BSGzfMJf4aLG5m6vmWAA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX9/xZ2zGuiGI1
 2AotGK5G+uXx9zfU2Rf7Vn2Xj+J7gWUjuzXa+crjcfig6WKCPAh1l185Dm+7JpOlxTNrNMAEsUX
 JLaf2d4Du29bns3E8QcgLDdjdunoLQk=
X-Proofpoint-GUID: 7Xh9eA3VW2gVaeuNJ_xeLjqCKOi87Rkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300061

Unprepare and drop the SMC clock reference, if probe fails to avoid
resource leakage e.g. during probe deferral.

There is no remove() callback, presumably on purpose so only error paths
are handled.

Cc: <stable@vger.kernel.org>
Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Closes: https://lore.kernel.org/all/20260917101623.2146392-1-vulab@iscas.ac.cn/
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-8e236c81-01b2-4274-a213-11c3f31acfc2
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I independently developed the patch and then checked the queue with
pending work of iscas. That one has issues and other complains from me,
so only credits for report.
---
 drivers/memory/atmel-ebi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 1e8e8aba2542..dec2441173ae 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -562,7 +562,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	}
 	ret = clk_prepare_enable(ebi->smc.clk);
 	if (ret)
-		return ret;
+		goto err_put_clk;
 
 	/*
 	 * The sama5d3 does not provide an EBICSA register and thus does need
@@ -572,14 +572,16 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 		ebi->regmap =
 			syscon_regmap_lookup_by_phandle(np,
 							ebi->caps->regmap_name);
-		if (IS_ERR(ebi->regmap))
-			return PTR_ERR(ebi->regmap);
+		if (IS_ERR(ebi->regmap)) {
+			ret = PTR_ERR(ebi->regmap);
+			goto err_disable_clk;
+		}
 	}
 
 	ret = of_property_read_u32(np, "#address-cells", &val);
 	if (ret) {
 		dev_err(dev, "missing #address-cells property\n");
-		return ret;
+		goto err_disable_clk;
 	}
 
 	reg_cells = val;
@@ -587,7 +589,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "#size-cells", &val);
 	if (ret) {
 		dev_err(dev, "missing #address-cells property\n");
-		return ret;
+		goto err_disable_clk;
 	}
 
 	reg_cells += val;
@@ -603,11 +605,18 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 
 			ret = atmel_ebi_dev_disable(ebi, child);
 			if (ret)
-				return ret;
+				goto err_disable_clk;
 		}
 	}
 
 	return of_platform_populate(np, NULL, NULL, dev);
+
+err_disable_clk:
+	clk_disable_unprepare(ebi->smc.clk);
+err_put_clk:
+	clk_put(ebi->smc.clk);
+
+	return ret;
 }
 
 static __maybe_unused int atmel_ebi_resume(struct device *dev)
-- 
2.53.0

