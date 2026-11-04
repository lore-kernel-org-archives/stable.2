Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805359;
	b=1vrUi8CDApGbR4pijuUp2daUTJzgl8a73U4v4emHOMyDT21jAur3GeUqUFNTImechSgG
	 Zfi7n+bke//oqW+1RTkZLcdJtpgofAfB4UJZSrfR51n2U3Oc5+Bfctk2Ut5nRiby3saq0
	 XX46UzGthl/W9UuEesPqcLvXysyj0W5xBALvjjo2th52KG9/eTga8xdp1gVKHWageUObJ
	 My26vJg/XUZlLEZPK9uwVcLB0uQJPWiple5pgmJcL495iCkBzuH0EoYAqXc1bScrEkC8g
	 fIHfMEtcGpCv4Bwv8Ma79heg5Et0Gz6yXiEHLcRw7fZF59FK4HB9brwXm8w2pwKL2Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805359;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KsyYfy8mRvC6Ia8wqa8pYvudHgL76D/OhZQDvChBBpA=;
	b=GSigzG+jIq8z64AOgUTTAJuSYwWAsHdhq3IXyNFKfIYBrq9QMC5+uJa7Oemm5bb1xnY6
	 Ch6tbs9diwufkjdFva//4v5dbFmRvHIZcpnMjzSbV5nB22xeAd9DdusQ5Kexkt0Th2eK3
	 DGv+APAscn65iJjb7tADlIkwLfw6G2jbOY+4z96TMnCx70CcL6QURxtr3WUEDQ+3xpJHv
	 N9v34wBchSh67+cAcrcUMnpHft6dwpCkIcE3xVZu28vN8cHumsYGHU1NHT64p1HqAhHHK
	 01c8rJ2KjYFrJ20YSiN/+jyptKAAFllcOdnfYWrgrN7XqHkKRaGf6SDtQSjNBrIXebg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OAdL1m1e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kfq8ha61;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB58606A33B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB58606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OAdL1m1e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kfq8ha61
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BaE7R1700648
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 15:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KsyYfy8mRvC6Ia8wqa8pYvudHgL76D/OhZQ
	DvChBBpA=; b=OAdL1m1e7tCooj9OIt+x9AEFxJzyrptrgoZgFN2MQGDvmN0DNrl
	9Bj4CL+atIm7xLHPuZ6tQwxUp56OjIvQxkZtAWx0cPwU5glV8sRsUmozsumaBaDE
	elAXR64+cPpSfaJYwl07gBBW/YDEv918Kofmh6vmuySFHZUI/aT3ad/MEb3y/R/P
	XmAILFQUDLDXy4MhepYRJ69aCu6cMNKRlg3Q1Nmio+WQHeT8LMdx/YFu6ExqbtCN
	53Rdy7er9VllNRakLdlrmNHfMu2oK5iRXHNMksBpQneqg9MTAZolSxfzSvpqElo0
	h9AMmVEsoEumxZ3s01LiOmDVuMHCSOkkEfA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3pygwmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:15:57 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99076c676cbso249936241.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793805357; x=1794410157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsyYfy8mRvC6Ia8wqa8pYvudHgL76D/OhZQDvChBBpA=;
        b=kfq8ha61gHAX7duIP113CuxamEm8AMZVPDeSfwjcQmC1DYIrBBQr1I5FfS4Nwo4+fO
         AcGYF+uhtyeaUbbWL/ZkGWARffVs1bC/ZCRaO69GK2vEnSrpKWPG4dZVpnMYBjLW+VFs
         c/htu2wn1Af1IJGsQMq12OjbK+0PscbCwCb6luE0Aaf3KBn1Zm+muBnWEm+bwWYd3zwP
         tVK30bNhJieAw8DjJhc2T745cXzDFTiyBLPJXx9kWOfrZeJgqq1FHfn0C/sPYfvOQBIV
         VbN72GQunqVxuLNHneRek4gVQinH3HLt1yJoCvheanXtZc+hhcxTebshZXgjPn6VnSEQ
         nF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805357; x=1794410157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsyYfy8mRvC6Ia8wqa8pYvudHgL76D/OhZQDvChBBpA=;
        b=TnoxRqop+JJXSPGa2GGIqox4Br8y5LPZTq9ZUqMWtJBcpAZHYuWhriKNBVMkPSHzlC
         uldUnyR7vCrTwFQonJm5KB9rR7cPEjdzskPJVivAtrnQNkVlCPhqSCrPxpYQKoxWFWAI
         GeFkqy6f5qKVCIHP05bacAvUQffsPa8SQxZZ6bYH3rn/KyQqMJg3tCuA6ozInxYvJNiO
         qw1f8Sa19xEXyGrsLzKsmxzyaIXWHnCxh6GthFc6Yoy4Sk7ObRo0fJhC6G+EsOumt+Ij
         BuqvHFArU3Wd6qFwEoir2ulFyg/l+N3gJSqCu8kZDwBDQxIbDC6PHbHSRsqN98jBOTfS
         OZwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJQ7K+KKLE3Z4JIxZVVMgLa9t0zwQ2tvfg+0EGWXvS3OaASZ3oRdHfojV9UMWWOM9M6pE1TZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uOte9+x9Gb+cxoOzkRHr53yfLQX60pz9mpDOGboEkKRZUPrnC
	RjF4QipSV8N0L1jKt7WPhIlHNAzKdbrIJK2JdiFKhlBRDus6wkRCJCtKsmymP5CXmgxQjKxv9e5
	MWF3TrET6s0Mu1fmUgAJ2dkm3qsH5vdPJm0M1D8+ZclYV4s3XXem3t+dRp/o=
X-Gm-Gg: AYBFou2LZ5h6YUnAmGncx38nveqiZmWdED/G3UCj+WwwE6LfDfXYACU3o7MwuXZgr+T
	kIvjoAEsb6vizQSjQ6NFn5P5z4LSvLU5V0zhI657e2qr1PY0QPoAB3tuinran+VKWYj4ovgcs+5
	Hn8zuf5rD+BdoCJ9VvvdsOYk+o9bKNzvNRvfmdbba6ouzmAtLMMQ4+I1SaXhAegYBSX/CEXQnCG
	S8MB2UnR3nrWqPngN534vWDUXkvlNx2nwN5J2fyHh9kyB+ZzXC2m1YtYLU6sohWg2STitzUZWF/
	RkeFPqfFgWuDO0Y1BPSjEteFxR4JUfbfT+NKwTPi19w3BNbsP4SY1QFDPOKLk8kdYWR43H99u7A
	LLbUWT5fNPaLoUlvOefuWRS01WiKPgd/fQ6kooP9jtY7mpfqRMrD6+70LmiZUXA==
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7d072baa450mr5990209137.10.1793805356705;
        Wed, 04 Nov 2026 07:15:56 -0800 (PST)
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7d072baa450mr5990167137.10.1793805356115;
        Wed, 04 Nov 2026 07:15:56 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa481a45sm134321875e9.7.2026.11.04.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:15:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] soc: qcom: cmd-db: Fix probe race with possible ERR_PTR dereference
Date: Wed,  4 Nov 2026 16:15:51 +0100
Message-ID: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=MQcMMyIyhWEipHgYUA1kmj8xFsF8tkr+QmI4/dQ61uY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq60wmqGr0SYcw4CYMyCDyvzNLSYOvICMFjA769
 ULwEeTog2+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCautMJgAKCRDBN2bmhouD
 16yXEACN0xBTQvk/FRE3tbvCH0kH/685JGYvunRPpT2wvdtFYO5XSeN+Xs4Tl5HrK2PMxablDto
 Vij0+JWKhHHFj5dd9NGKsv0QiGKicflwC1LCvZhIMfxp90vNSGzk3osxhgiEQH9kKVfDPDO19pU
 5c+wILTIwz74I9Kx7NLginJl+YouQDyox+V63KpWodhh1dTZGjdHKjVfeEZouMj2uG5e2lYUlzT
 luBZcOt7Id4567asZwXC2LXBQoinUAV9lfTKst0Cgmi8dSPhmw2NBL2nPS3YQmpkPoDwpaLP+6B
 UwGjfT3vC5Yp1uL63Kz4IprIDKScp2MHEHYkSSrh1Mbn7HF0/sXnvH45IW/dnoNBSbDR5DEmlXf
 3KDlwduhrxGuEt1iIQPF5fYMGjEeVUGxQKoptGYb9+WGUQ925xWsW7SRHsMz6xBz0HuQobadecO
 MRsSHLathQ9vk2LWTpVQzFTeqPPlQ1GiMydMXhS1kTPpBwR8N5z/Ya/+EyGznDjDwzSbf0aC9Bm
 rXYV8dwKHg0yYrkGQTICpeNMkFRwTXSx5xg39my6su4m5F7jbrEiH1HBQnn3NptHEiWsMrBEvw/
 VDRzjRMO/6FIXmiKZxeOI6oYCENM4zmwuzJgJ+ZRpLCE4Yx4hm9moabH1U0GLcp4RyzJufwPzZ+ MNrsnO87DQPDHtw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbmIpcVA c=1 sm=1 tr=0 ts=6aeb4c2d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0UCu7NDXrwntZz1bfdkA:9
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MCBTYWx0ZWRfX/y42iXuhyJce
 BsS+2y3QwNyJjTqLA/KYOtxIMnS6j5abLdnXn5dvWFbVE3KMd6fkcnEwP2P+ge1E797T6je0gdJ
 lkbrNZAGS9okUTwGuDnjwVlxMm545Uusk/E/p1Nku+m5UdlGE2/j7RPIfoZeEFGhbgn3H29Vo17
 2cLRkxAMlNm6Enitt1DylgUJU+Iv8/DwF2ZDpbTNzZ7/P3whFTbOPF90OdbOr586t0Vz5Qx05dg
 1syzt6LWb8ktsVr57L/96MlebfnPXIsUJMVTPyiTjl5/TQQeSnSEc+ahLchhnP63Ih3umKmQmY5
 0rO8Ne6lpFozi+1IW1zQ1EivEPSFniM/4h4OcLLWY9MbrTKHB/BsHgMV5EXRy4bV0693jtuV0I0
 Sf8gHoeB2F3Lfjbi29rb8wZvEozl4gCYVEZl7QiMg3jbyjjqlTuH/8LGhplKctXJBZ4wx0RbHTg
 no7rnI+m6nvq057kxag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MCBTYWx0ZWRfX/jbuC+w/OqjK
 iRQvfO2pygZ/oD1KLyjhzfpf6OuPmfTRCmDovd1qzmMj678GrLUVrMJG5tLyPH7VWIbqf4YYuWX
 /yGuuO6Og/RpET15mADjJU9zJYUfzYo=
X-Proofpoint-ORIG-GUID: hSxw5cv9YdZWNDHa3SMU-S64oxOJ8I1v
X-Proofpoint-GUID: hSxw5cv9YdZWNDHa3SMU-S64oxOJ8I1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040060

cmd_db_dev_probe() stores the result of devm_memremap() directly in the
global "cmd_db_header" variable and only afterwards validates it, which
opens a very short window where a concurrent thread could access and
dereference stored ERR_PTR.

Theoretical (not reproduced) race condition could look like:

  CPU 0                               CPU 1
  -----                               -----
  cmd_db_dev_probe()
    cmd_db_header = devm_memremap();
    // holds ERR_PTR
                                      cmd_db_ready()
                                        if (cmd_db_header == NULL)
                                          // false, proceeds
                                        cmd_db_magic_matches(cmd_db_header);
                                          // oops on ERR_PTR
    if (IS_ERR(cmd_db_header))
      cmd_db_header = NULL;

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-1e6d9e1c-b97d-447c-9cbc-d874a0609918
Fixes: 0da7824734d8 ("soc: qcom: cmd-db: Use devm_memremap() to fix memory leak in cmd_db_dev_probe")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/soc/qcom/cmd-db.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 3f1eee784387..5d303ca0dbd0 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -340,8 +340,8 @@ static const struct file_operations cmd_db_debugfs_ops = {
 
 static int cmd_db_dev_probe(struct platform_device *pdev)
 {
+	struct cmd_db_header *header;
 	struct reserved_mem *rmem;
-	int ret = 0;
 
 	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
 	if (!rmem) {
@@ -349,19 +349,17 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	cmd_db_header = devm_memremap(&pdev->dev, rmem->base, rmem->size, MEMREMAP_WC);
-	if (IS_ERR(cmd_db_header)) {
-		ret = PTR_ERR(cmd_db_header);
-		cmd_db_header = NULL;
-		return ret;
-	}
+	header = devm_memremap(&pdev->dev, rmem->base, rmem->size, MEMREMAP_WC);
+	if (IS_ERR(header))
+		return PTR_ERR(header);
 
-	if (!cmd_db_magic_matches(cmd_db_header)) {
+	if (!cmd_db_magic_matches(header)) {
 		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
-		cmd_db_header = NULL;
 		return -EINVAL;
 	}
 
+	cmd_db_header = header;
+
 	debugfs_create_file("cmd-db", 0400, NULL, NULL, &cmd_db_debugfs_ops);
 
 	device_set_pm_not_required(&pdev->dev);
-- 
2.53.0

