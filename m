Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE806391E72
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385670; cv=none; b=Ssd9KifhdX9wYq/bbgwfe1Mhf/WV/bmozU/FJblMGbBflrZIEtIse8GmnYg1raNwsI+xXku6NHQuEnUigiweLCALb9EBvEL+Wkat3ocTgD3crl33Hlj0dVLFmJOqS3xNTrUVPtxZafnHTwNQKd/XFhK4apZI0qHTVPHK1XtyPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385670; c=relaxed/simple;
	bh=YVirmTDYaEkiYsJPJUV6u+ccJQzQNksQiW7zP4Dw14U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6ZZsDpn79dT3NVFa3XSe4/YW4hDMN27KuvGm3uf3k4zjGocBn54JC2uVaXOe9MDy1X9UzM2AAmJome5jRQDfDzf17sn2sH+UQJiunQ+zMmfFCOMDiZzjBZ4mUkwZNTBFdVYj3aQoZq0n6KlcPuHaDN3NpgYg7N4eoNNFhQkDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCCwsyJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpaWI8l5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCCwsyJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpaWI8l5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652293bX622614
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C
	6wyLn56Q=; b=mCCwsyJCStiVArdcAakihN+lVucb+RmIJ+esFp/Lm/ZZaBRBOu6
	qOY/JkoG/OmdTPNQ4MSjGpspHTeLEPUhXfbVMS6F+5oWpFjEsZbrdURfzp1otOI/
	3T9pauBZz29MgxxlljYGnvdbLUUUIqG6sjn/tJj6TlPGfhiNZZhvWZqLCqY26h/y
	w0YSTceUkmpxzikPzKCrNV2WCvvzIjDV3PHvu/AbAUeLSECsrVg4aEtpYkvV5JlF
	cU593s5cNY9XexgMRLTxTbl2REErDsLlp3flxOTFC30m+o8sN8P0y0cQvMk8OzR/
	bJ1iHW8enyFyn/9yW+eg+0+0GS777U6Ne7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954mng4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 02 Jun 2026 07:34:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516e0846095so45970961cf.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780385662; x=1780990462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C6wyLn56Q=;
        b=YpaWI8l5bYG5dP+5ojcB1/pgG8oUv235TSCdMTe2F3xV+T2zJm7GWFpry6XbvTnsmK
         54ukSrzDVya1+mrRZgQTjaLbPg/8Tbf/THnyLqeacdYPTuLHOPhKzUfPEvunMV0K4UMg
         8YktDv0kOFu7uIh+uD9uUY/1TP7ydcZx7QqiexaD4YUmMUEyg9HzJDeTqqYBV7h/niIP
         96vFY22INf3o/kZ9mBQXJSl9uHaTHP0x4MMEM3wO6KnyIgz3i0DFoOkfNeI24TNNb5US
         V0R675aTvOwSASn+fSDYdkKKZNzNGSDSfx8EOT8uGyYcosFVhBvQ/dnc/cQhl/LRNbmF
         Dq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385662; x=1780990462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjC88RteyMdNmZiiaQdoQEc/10QE+WI+V+C6wyLn56Q=;
        b=MrYDlChEVR3N5DRm+UDQzJkOJJkYvSjrcDBiLLg59BjlpN8dChqHqSznC43O/xCC/Y
         QQcYj8rKSFCb2mKQpUgPLK39duCE3bFtZA3Lv9gERscqZ0r8agDsHXZeqIzrAsWSh4iC
         JkAfNAKJualj7XETw3yiOcK0D8yWCGrASNejvPpq/B2GugHeQoZSLKJOctVRBNmTprmf
         /+5hMhvWW517wVQfCdoyQXOd3UjpcJbWjU7X+3mvlpK2PcC+WLkfF2++lM8vGuI7fU7u
         BiCEHsElgNDEU4qub30CxFAKCaTJ58dThmvROjXqxHx2weeozbP6Q0dG5A/erMsn2L8P
         HJdw==
X-Forwarded-Encrypted: i=1; AFNElJ9G5tEq5hlbDcSQUcx8REMjji0OYN/GXW2J56J/nDAu3m4pLP9u82PaHVaUORFBSMf1PeFYJ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUj283mbnKwn6SI+hJZQPbmvafju08llvoTJMAeQ2Bkh7KoQv
	HEbc6lxN85+309Zl5LyggO6zd52BH4GmpU5ZFH0I/6tIJ4MYHZodqBbZgqAg+6AkZuD99JpT0OZ
	uHyOe7NYOFAmDPVMFNn+pgl3wqhK2dgAQhisbROWPvxY+gPmY8MagVAdGU7M=
X-Gm-Gg: Acq92OEwP0wOol1+YkkgtwzPMgBm331koTpck7SMLbMrzvnNbHzOx77LXhapQJ0IBW0
	1mRkRUTOYIf1eDY7j1kFa4VYUBXYQJ/OTWZJ0aBu4vv1wf/RmLTMrt0KttwuLSVxRh07O8ux54L
	QU154XNP8JCnw4+FiuH2DYiT0ugGlYeZ/ob3wu0UBsES7Sl6VI24UEI2sJBjK6hQYDV5R3r/Gcu
	ETuSUwvZjnwHyzkQ4EC+P0DMxjcEuQ+hLRpkSYxE3+VegVCfeb92a/lQZcUcaJgTXI4l8vPY0Dn
	LYpk6JkOJsfRz+kNXBog8zvCUWnpUf1ZIU6fJG5U7lwFmYv5O7ucJN8wFzIATY710MHRsGLJCSt
	EkF4vK9u/7TGWixiSCKS0d0sS1ze+5kfMRIf/lk/aooAI6/sN1pK8cREwVfVE30hKpI3oXmG+Ko
	bWPmUaK+9bcfLw0g==
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id d75a77b69052e-5173a80ffb6mr203814461cf.48.1780385661985;
        Tue, 02 Jun 2026 00:34:21 -0700 (PDT)
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id d75a77b69052e-5173a80ffb6mr203814161cf.48.1780385661519;
        Tue, 02 Jun 2026 00:34:21 -0700 (PDT)
Received: from brgl-qcom.local (2-228-54-83.ip190.fastwebnet.it. [2.228.54.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm32453424f8f.6.2026.06.02.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:34:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND net] net: mv643xx: fix OF node refcount
Date: Tue,  2 Jun 2026 09:34:14 +0200
Message-ID: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Kl_6E0W-Xy1nQvYtinrGMHzHUMksJOh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2OSBTYWx0ZWRfXwuBiUZ5a8NP/
 Yp5JCxSacPQmtjBJwIJXUOTaMTTrML6llUZJbnQfFy2on/UixVQo1BnymjFwjIiUMLqRyDiMGTz
 C5jApu3XfjIzCBtRUThXnlnJhVRfSD8G8ezIfd5KpqtPx/Q+gUMNfY4mKRaQqjLB36S3sQYXCHO
 xHz9cwSENWiCsYuyUnVm9ul/KAL0vF0f5nKK4JF/LQ7GnMz4Tys0HAY+dZmh5+bYlisHjn41T0M
 X9AQY30pTgFQa4TPl0/QCRG+3TqxXTWApbQ6LY2NwjVtErnOehkloPOoJrwHoL6TM/uakJf6uv+
 0Ej8I4sIhEPkOZiYNIGLhCgWg7AH4VgLcC2TyXmOYBG6OXf5xk0jJFqRYQbOIbl3zi1pMNNYDou
 qHzE4326KMIMjNF2kOxcaNDBDtFHZIEUMhss1yWmpQYG4ceNUDOo8eHAxw5NeU0ukq4I3+6YUeH
 tb7kE1NyFXs8y/G/J9Q==
X-Proofpoint-GUID: Kl_6E0W-Xy1nQvYtinrGMHzHUMksJOh3
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1e877e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=F4J0OHcPalsv3C1teIDEwQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2glh-Q7MoEu8omcI7JcA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020069

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Resending separately as requested by Jakub

 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f9055b3d6fb10..1881583be5ce2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = pnp;
+	ppdev->dev.of_node = of_node_get(pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)
-- 
2.47.3

