Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF155D886
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957453; cv=none; b=J1moBW9aFZhdce0DISJQF32rr0lWGrQHCt71y1nmaVLAN82GQnET2KpGjDQUmqqLMzM2yiu/RebXhcLqJePzEONLxQwiLNrUQvy9G7aCHZBJb+l0AJ9oFVRiIG+LT9cSzd37BaBgjN6rifUK2JEf8FNnfyFI0WmFdLrDviFWWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957453; c=relaxed/simple;
	bh=aQ4wUnjGc5pmfoIzvGc2IT9dZtMCvDmo5D6QlqxAXbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKjK8EqXmdg4xWt1fmnQLouiOlpCc5eY2jJkNj05ZiQetdoxOhFrJb1wF/6Z5qKMx4JDR1VteRRb3ZzXdRYl6mCu4bM+9B3dO3lXfevwDeX9N4CeFvPMHtfqKnBX4P9qCA4SjUFW/dyO3+4UfF62ohd37SDap/pWSRBrhjs6Mb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQ4r1EO+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHuqXuFq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQ4r1EO+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHuqXuFq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CASI21233042
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 12:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tHOk3O4iY8NmPYpem4zaMAQrb1+f8Tv7Kz/g9GavEs4=; b=DQ4r1EO+UlkQjRzh
	+81BwMd5RWqJLbiNTyDtb0bL8yVim75g4cbxiTk7fypgSRqHo3yoJVE49fWU9Nq9
	UCqF5HN/aMvw1PQc4kX7ZhNwe50OVP1yjV7hK8QIw4l6t1c1aJGEiuZUWF987PDm
	CJNMaqqhNSlX1k9jJEvFk33qtCzJZanlv3h3/DpDD43Te1+py29rRXbNwPRJQcV2
	cbvZeYNMAneys1BrkJtuHEELF1F0B0jndxi5zPwpozkhsP8dwNwv0zdPrIt50yMd
	PL8wfMxwRLE0wsbTvQw4S3mFFQ/y3C6kqS1/dbnfP9P7IWmG+AoMckAA5Xo64Auk
	vN9cVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk77vg2rg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:37:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so986859685a.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957449; x=1789562249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHOk3O4iY8NmPYpem4zaMAQrb1+f8Tv7Kz/g9GavEs4=;
        b=hHuqXuFqwNSd503zJwY7zfCJ7BqMLICkDLKH+qD2vg/6NUaQXIn7LaMCmuWe2B7Q5n
         StzI+qCwQwE1obvr8N+5Eye/IjNxwdol7Fh6ZjUBzJ7eQmnQMMpRog4N8U3w2lz9L7P2
         5rcDqG5YqHsjHzpSkLJL0DN85QY7SyU385Zd0hsY6QMsLiTs0ZN/U9YuqzwI2u4NCuXR
         a8yY4Zn/NQHADvncyPEk6DgrRRlIFPPh+GVYEfsmQPYXiovLv4jkvaE1THK+H/gTB26s
         YxvgQjcWy9TgkoItmZ6pTTnRe9lv/Jv84s9MGkSpfnd5rmxufsLcFntpk6+CQJPrbnJb
         oWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957449; x=1789562249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHOk3O4iY8NmPYpem4zaMAQrb1+f8Tv7Kz/g9GavEs4=;
        b=XJ41wy9EcoDOStFETK25ld8Yiuywxn19PevOetnUHu6+hNLHJOmwsFrUwPR6wq4xB6
         Dza7ashrwOwV56/VXTbaUzrBO7B+jtwSBhKtGXXYgpLL1P9MTQ+upfqE2Dll0V7AYeDB
         sUixtX5hhc3BZno5Ezgdom+r2onqpTduPrkIEEKDA8o7anffDNmmei77SfpGWggPPJuc
         76/SRXdtfrPA+lXHXJAx3RNghCgOhBLG1G7zYeNSuOMlthir33Yc6H+Pxc+PxewhXJdC
         pRfOxhE3lmNEoFRWc0nypG73rky/x9MQRQu0GweJKexP1H1xnkZtMwIk8/S5t7xWDwFx
         NHMA==
X-Forwarded-Encrypted: i=1; AKwUvBzWZ80+/3m4KUivO7FIFer+IUT4mVoOfOAVDn7/Q8zFT9/n4JWiiMwEn3j68m0czZTldrWqg0I=@vger.kernel.org
X-Gm-Message-State: AFuF++kcMGbuYyJAu/GjQIPLWqfZTIiXUiJhyVWxP1dG2RGFXRuX4aBA
	BpUnDbUsWVvFfUHHZgvMldYiuAFIR/gIDXj4j+tbaFyrWMGwuR117s2Bv+GQ0vthgqh8KHotqLe
	b6J0ky8GKJPQRyJ9NmuQOdS6lkUeu41xNDY2iJo61dgFeXBEcRVUopHcrHwA=
X-Gm-Gg: AYBFou2fWdsEW1MqTWpp96PHhZck9ZRFaYomBQRdBQQhb+vIPKUc1DXYThbUqLp8NPj
	PLaR+VwcYwRfiI8MSbqaadfv9z+RvXrlHsHoogS5SztIA44lpGhvKJazf20dcadkfmkbA7BVGMx
	RA9eFeRjqEFfS9I6dQvU/riXozuivqjISegerlcc1BLyL1FS6EErCShEcXRb9SIC4jvudtMVtKG
	IsRjYQr89tTRKgDj958Z8/7NwRnyv8tmtyqPFJpQLQemJeKXBfEsyu8JDB0fN7DeeGaKNOJ9gdn
	C5aZk+4+KqSaO7Dllqc8zCQ9atxugsAJiwQEZ4dAYZk1RRxhvIetj0pejGifDyY+t7Y8NdtMXXh
	Goa7I+I7UQNNWU/ygcMqo/syBOWtW
X-Received: by 2002:a05:620a:4494:b0:939:d440:e530 with SMTP id af79cd13be357-939d492a0b3mr120409585a.9.1788957449473;
        Wed, 09 Sep 2026 05:37:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:939:d440:e530 with SMTP id af79cd13be357-939d492a0b3mr120400985a.9.1788957448984;
        Wed, 09 Sep 2026 05:37:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm36317328f8f.20.2026.09.09.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 14:37:09 +0200
Subject: [PATCH v2 3/4] power: sequencing: fix NULL-pointer dereference in
 pwrseq_device_register()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pwrseq-kunit-v2-3-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aQ4wUnjGc5pmfoIzvGc2IT9dZtMCvDmo5D6QlqxAXbE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoVL/Sq/tgXU4/X6gqqO38xFKMT5GqgUCVy035
 4yRgiUMKpGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqFS/wAKCRAFnS7L/zaE
 w4w8D/9JI9hjiLlbLoDtubGkshl0wI00tYT8GieAZK85Lpf3rJ0tsRqQsm0Upc9WGH5N+eqK+ce
 brP1+0Dl8XNaNGsnn3LPyrLRQJ5kt/numaL4MBHj5KcHtAVT+0kE96m/svFzw2pEsqdVEynSOLl
 8JJZT5HYeQh5sFdJm1nqfAxE26c18BofBEh5r83X1ztYQZrCgPaSC4Z3t+20nTEjkuqMQojqKqz
 272HnjTBbZQ5dk7KnT55uKB56GiEt4ukZKUOhKC3vzuLMzK5H4+E8+AsPNpF47TJ2j9bmoLxKYt
 cgAoy4V2kG+rQrLDr8Cq6z24pRc4T+lC2Cr/EUuRM7+YokTgJDVpVCpPEj4ReFJ+PaArguB8QgR
 tmFrdOQhUJdjpoI3tnq/A5X66miBO1WEpaEpeHJetrMUC9XWwJyZnOhfIUlPv+Z4s26dKDnYswH
 7WMYfM60lD69clYfHHwhSqjfeVGpOojUh7L8khYtzPADpIFXRdJAeEkdOkflSt+bQ9mWLw3Lf5A
 xoR+rcCtzAsmjbJu+n6yUzBsJpui8VQC3nevIlVyqw7OvvoIrQKUyjAd8sTs6yDHkLi2ZQLZHUg
 VqU0ZbIYs6imQ7vPlwNt0axvDRnvup0HE/y2HcNoS5qdE5WNd60ahMPdp7lagcb+8ZuZHOMuIjd
 YKmmWSFncRYEyPA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6aa1530a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=lh2aROLewo0y3NVoW6AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: D_WuUGgyLeXQKVPn1epBCyt3hNtg26jW
X-Proofpoint-GUID: D_WuUGgyLeXQKVPn1epBCyt3hNtg26jW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX3O+NfMrSuX2G
 A8BIkXFQsK/I9up2jkK51HgH6FdhbqTS+OtDim6Siu/VWZp3eOAtuEPhmqkMxH3eiDpTzBjLt4b
 uhBR3nZGBcWUFnjw/dBKYScI6Zd9B2w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX6uq+ut9Ad8eQ
 idPXVHGI4qsPw3ULu0KSF4M/sCYJf0NDMfRAakqHNheduJ3PMYknxXFUFXMhBYyFzcYj8waAMpY
 dMKwXXI7AgDBO8pfMG67KN2WeYyMjQPEb/9aVHQ+ZX8hd1JRcB1EMnCgxliSDvRyS2zk93/M+K5
 qJCLYTqJxaXhvjQzvWqEw/a3z7thOCYzuQ8b4GjTjeo7l2IchdF7+VF5qoL8ZPZ684tubjF5ec6
 6uqCPABuULrHz1vTXpsNgADpM7+vrV7aNkO1bDW1dwfy0jJZjpXMHkA8PnrtLJemimDell6Tu10
 HY0yU1DEtUaG3PktmSgXYD9wDhfwv2pyMybnxEzrG4v/AgyeT+qG4QpKE2lODEzwZEJ4g7DZQus
 p/MDAGRZlw116WhGNU2dmnuyQ0yEbqa/sPyMa/Y5IoFMZ4+pVaZGoxMpJcLx/c49yHGt2WKs8pe
 zizv3KilZAeKtHtPwTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

If dev_set_name() fails in pwrseq_device_register(), we jump to the
err_put_pwrseq label before initializing pwrseq->targets.
pwrseq_release() will try to iterate over targets unconditionally and
subsequently dereference an invalid pointer. Move the call to
dev_set_name() after the list head is initialized.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260903-pwrseq-kunit-v1-0-1f893d2cabc2%40oss.qualcomm.com?part=2
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index a092031943397241b2a9970de5793a0bbc8d7ecf..3076b3879af9e29261ff1f4b133bacdb74489d7c 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -505,10 +505,6 @@ pwrseq_device_register(const struct pwrseq_config *config)
 	 */
 	device_initialize(&pwrseq->dev);
 
-	ret = dev_set_name(&pwrseq->dev, "pwrseq.%d", pwrseq->id);
-	if (ret)
-		goto err_put_pwrseq;
-
 	pwrseq->owner = config->owner ?: THIS_MODULE;
 	pwrseq->match = config->match;
 
@@ -517,6 +513,10 @@ pwrseq_device_register(const struct pwrseq_config *config)
 	INIT_LIST_HEAD(&pwrseq->targets);
 	INIT_LIST_HEAD(&pwrseq->units);
 
+	ret = dev_set_name(&pwrseq->dev, "pwrseq.%d", pwrseq->id);
+	if (ret)
+		goto err_put_pwrseq;
+
 	ret = pwrseq_setup_targets(config->targets, pwrseq);
 	if (ret)
 		goto err_put_pwrseq;

-- 
2.47.3

