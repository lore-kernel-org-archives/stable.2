Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373856;
	b=haNkR+4L9MqY61TCA3GU+GcKlGsRqQVEQ4EzAnbC0v4paYtWrcmdYmq9/umpxHwB2rEd
	 TA+uNp+ue4+DX/V1jniAT7Oc2mGOHUpsdmDLDeF6VOd7NDkfyQcS5rBbbreVIdMRASj02
	 tLL6PWYFmpCd7F0tql9UkyotfVjfL2mjrX4S6Efv/SrJ8Fxm+eSGOJNO2q9Vfu3qpHkwi
	 ZMNKlN7TumorIYhl/3U3R3Lvz/fjiA6uUJFYr+L8s27jhNxZ2O9a+yA9Jz0j4i91t7WR4
	 4nUMB5YRuaWZXbaqsY0oFaB3IsmCMu3pxHyt9EouCC7zTrzOOyjdNzC5ybtIfisT4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=D50N3E011gOlYPi42VK1o9ynvsH8cEI0ETSUZB5t0Rw=;
	b=MXLFN/trsaG8rBvr1G5Ye042N+j+MLC7tjX1jQ9dSIgUv8shFaQcMCzvvl6XG/a0bzbo
	 L6gKa/n/UTiz9iLeNdiYcWE3N+epwDMgFqBc/xh3HU1OsZWRdn9lcaF4ndSYkolMoPRhv
	 sgxWqRpX53s/pX/v+lNIzsxjW73cvr66LjiEAWZsx8SLx3KJMxenUMA7AYRp6fX/2xYvS
	 WGGvt6M4xa8BFpsuEk92gByRdtOsNnNRDsAVK8wb5TTIeAIPY1sGWATV79KTgIvSmsBSr
	 MpU1Idbv9TR/0W72tPzd+9gvgIkOcbjAKDKUPx6QXTnQyqNaa/n/HVaNKhXZxEYczcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iT/cHDBL";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PzMhpJZ/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8E606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB8E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iT/cHDBL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PzMhpJZ/
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UER3Wu377954
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D50N3E011gOlYPi42VK1o9ynvsH8cEI0ETS
	UZB5t0Rw=; b=iT/cHDBLzav35dNId9cT/Hal5Ga9KPaW5OTvdZ6xpWDvjKulWr4
	dZHETTNr7Krwq5JF3IaIQnQsEVKm1ex4YDANTH6FVgda9GMBIHWGIo8Q40ZDVav+
	4u1iJ1iebmZ2QHerl7Kq8Xhv9c5IivnCfQnHNrwGYBOGZdDtiR2DTThg+PlHhh5b
	KTvVPQPd8Lrdoh75DmeZLNpM9ESSEtYrHLWj0rcCXdfqGTwJoFQaRysdFiDUrFRK
	ANAFgigKfPlLjxHENKrzvKdSZQjN2L+KDCMPoOgXouI1zKD6tk2sOGOP+NaRvT/l
	4cBUV7llganiKTMfcgLabdS8P1wzdqH3hiA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme753q66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:24:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f5844cb60so162736185a.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793373854; x=1793978654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D50N3E011gOlYPi42VK1o9ynvsH8cEI0ETSUZB5t0Rw=;
        b=PzMhpJZ/6mPvhOutqKj/Uod4+zurRW8x1xrMkToT/Ux1xzbz3xqxH4IOidp5CKJEA9
         pYRPysuYOO6PnhZzxT8hkB8c5mo6QZJYGhxx0LLuIr0KJf8lNmckSspBRgDlAvvb1cMd
         TeWQMA+i9Srp1Yf7rMnI/SgPjs/45P2RCa+cJ4iGOrpeZvmsiDyDcIDjLAOOltb+wgLN
         9IWWPJAUb7NsYLqzIG60/mKzukrDaivY880XGHlWFJOp8NguHnvxAREp00gQGakuO/gQ
         vQrlGRDVKqQmtqbZCp5M2Zjj1xZ3rHF7CFvodMlaDMe6HgK1GGbCSGzIowzCUuI8UCNZ
         zEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373854; x=1793978654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D50N3E011gOlYPi42VK1o9ynvsH8cEI0ETSUZB5t0Rw=;
        b=tgZyJt+jje8wXGi83KCIn9ms4TY4aOlKeyMNHfuMK0iBW0HeqJYngOAORURbdURvH8
         LEmjILLsPo9/45qwJsFVXcXsbIIH1PPBa4MrRaD6A5xSMEvxaT/G1LWPZ0gtAmZLXX2M
         llbTlU45vvGUH8gv0om08RIU2rBAQT/zUzgWaAPvMm7xnQz6sOOMqdl0lB9ioor31eTe
         ahapsDDEs+BvngAVzemvsPLaQ7jZTKOifXL/5daCsGsPKz8hZza3w4UIJnTy0OAZnu9X
         uk3Swxv9Munlyr+gW5kRUFTqDPEdz9t2IfCaAvM1hc/T+pRkZxJQLeEcSdW3VarsKvqn
         dvGA==
X-Forwarded-Encrypted: i=1; AKwUvBxSH+ES0RT8PT9hLIs1X5V3leVl5YewdSCva6x5Ct0Gs5Hvl8sAq/c5LFJQy0IlFgn1otmUuO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS47aTKKtyJsxFBS0c8EBVQ4aP40R2Ebwo8iocFWIcbGHV7uL1
	beIGIa462fgdTEIGe2iBPGU1K8iDjy6+N+LzDassh2nCDiQGvKma2HfQ+JpAonCF6Dpx/emZzTH
	suBqgX/8VLNGaxt10Y5rs6+dgVHeMB7qSOxqBgGlNmX3jmKMOgfHG3Ic3r1k=
X-Gm-Gg: AYBFou2FqgizxPbSagq+yo09Iu7uw5s0xtESIR7H+dzlgvAB+A7w8YdewQ+00Hq3rLe
	FIVXqEJX6goD9keDf93W0uGI5WSR8yWF5cE1V6cRiN4qEcyuVcY8HxjFWl1yn3bZ1zDr3L/TiZF
	Mk9AG5orQ1rHOuxJ/of4cA3UCDrHfb7qTe9yg4KgH1j/J/uoUp69BlfdcCPT9aiKCwqRAFsjLzr
	KR/TopkF7eUaEcFgSZTwXQ+TSXvYlDUyX2lX4iVfJsNNp+9EwV+ScG4ha4BgC+Pkl3dwaLIRkRR
	+YxXPv4qlZiH1tE2ss8tDQ14kPYaFiWo2CBHFA8nzcwXTxJ39BKcVRc9sV7JfQvklZly2N6R5j7
	C+Xdf8jPYRSljkyUNGvXiDIdpMJ9rdde6ZTqW5jToZFdihUZ4No8pmB5JvHGusg==
X-Received: by 2002:a05:620a:6187:b0:939:b053:ce44 with SMTP id af79cd13be357-94413389996mr928844585a.22.1793373853729;
        Fri, 30 Oct 2026 08:24:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6187:b0:939:b053:ce44 with SMTP id af79cd13be357-94413389996mr928840885a.22.1793373853253;
        Fri, 30 Oct 2026 08:24:13 -0700 (PDT)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm142847215e9.1.2026.10.30.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:24:12 -0700 (PDT)
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
Subject: [PATCH v2] memory: atmel-ebi: Disable SMC clock on probe failure
Date: Fri, 30 Oct 2026 16:24:06 +0100
Message-ID: <20261030152405.281376-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=wFhbia9prCL442JdEQf4UMZvrrCKTAZ4Ok3cjklDBLo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq5LaVZGq+kapElhK6n6TsLDGbX08W8YZOq0EEI
 pWpSLYJq8mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauS2lQAKCRDBN2bmhouD
 1xMhD/9ANg5eGH8UHPTagwQP1NLkMZXe+QyI5r0+r30Ya80uaHNYXwdC9Rwk61C9iGK00wdpQBN
 9WdzP7ugttjnzignv764U5jWwpLfym3bC0YRCVIxGNK13QiKKoIDfn0yz5zDIue9yIc06oECf6X
 XRMGL6HFkjyh6S3dNf+o0/M5LfpxpvGh2IxW6M3FkcgnYaUu2Uj68smuHDDdZw50boe/SsfGE8G
 nWloLFxXPpfSos715os12j+f9fNnJVXgaPOnQIGPp6U2mwvevJkh6WFhqmIbFm2cw7Jjbof0KmY
 w5WEz/wvlFIDTs5YGzVZNRfCcZPL32LZlABzL+dyCLUlal5/GtbvqgMZZ2aX++IBSGgMbJKM7mW
 CxjtyDoncdmxmhJK2Zmb/W4lUC9T9VGtV/fnkg4F283uk5u4zE6o3eVjWIEPE42leAcQmd3Wuqg
 560V8B+JH7awmpxcQ1B9z53cjSt4Wvjy2cYVBjUaK/n9EHMyXE5fQmy+z4oN8yA5rsrGOzFgBzY
 fSAFgh87mC4nQmDcXJTZScV1VAA2M9uesbc5od0yQsQ7jC55U0oxSAU0S3lx6PaKuuDpc6oUiHb
 RCsHt6hGKnY0GY24zOmaySOEox+Z0UoOcGdq5/WPFXuKbwMd25oKxFxGBhgHjNGN1T9aK2qHHJv hIORlticgFejOFg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y304i61YsQ7I7YjIfBffO_4Bi2QVv6LD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfXz7lRTYTQQ0OS
 SGa+XFlPOE/Sdujt3nvmmG5NH46hee7derEjvhTX35jhadv39cbY1MBbfDJIN2ksUkKJtYAFx1T
 BQAHlg/prCOS4Nhgr4jbMoGKQwya6aDRl6MUug5usa4hDhfraMBI9+9NGZlq64FGRogElG/QquQ
 2d6bM8GA4xh/sjk1pW0atJJwkSH759rQqMPlmG1aHPFm8glCw2FMFyxlpcXm/9aTxMI/xU4srS/
 HAF/QLm06YX/Ric6berNdVNNE/Nv9WslmXosmQDOIk0lRrrRxKXesdEBFmQ3Zau4Iy+m7Ib2mV5
 Du/kDOgsxSclO8bwSNca8XCeO0eLUnTxCKDMYbwuum+lZ9jQ99pvqAH97r/EAZA9VGRKE2nsEjI
 caNkxpo3ujowmks+USIQjn0k8ZnYP4+E11kIVZO7zVO5lVe92OhAE6jdx1BgEgfN3aIdluGPDcP
 2YeUKL8fqaruc1Vj7Ew==
X-Proofpoint-ORIG-GUID: Y304i61YsQ7I7YjIfBffO_4Bi2QVv6LD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfXzJIVATBmJQse
 MeX5nXbQGhPW/2eS+sFBKjy8a8wB5ZiyOvyqyk6x/6zXczzo99IDmOM1CTMjC+jmYkooAPRmne1
 MoGw1kzsVywnbVCuY8PQOxBqFAG5jeY=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4b69f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=BSGzfMJf4aLG5m6vmWAA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061

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
so only credits for the report.

Changes in v2:
1. Handle of_platform_populate() error.
---
 drivers/memory/atmel-ebi.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 1e8e8aba2542..7dc2f7add1b1 100644
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
@@ -603,11 +605,22 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 
 			ret = atmel_ebi_dev_disable(ebi, child);
 			if (ret)
-				return ret;
+				goto err_disable_clk;
 		}
 	}
 
-	return of_platform_populate(np, NULL, NULL, dev);
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		goto err_disable_clk;
+
+	return 0;
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

