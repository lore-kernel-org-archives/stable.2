Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF644C518
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917760; cv=none; b=Pyt6dkl0sQe/2YjNkyEIjTwff+vkkIL0d4xABvcX2Lfb/oH/5S+YW7DCmBVhaY8Sr0xptdfeQiwJ1VgijAFSjhu4UzlxXaIpxPJxJo9JG6J2gIZoSfvXxu3tj9PIpOwS3yMlCyPjbosUKRR5L3NmFWP7tKZHbC9Tc8e4UpBJOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917760; c=relaxed/simple;
	bh=DY8VFqJjyMky+pruQfRM5PAcQO10FyR8Wx2ZfO+d6cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSXIz/SQU4v/aYfyGM1lUmZCll0nJsvcGeZHGZ85Jm7Rycc2P8bawy7VaCcXMsNNYMG4yaPvjHc9utdPp7J/WrohjojfvfDZE0EvJE5ILNE3Tl0fOJUiJ7ujjELGDMRxbDyHHGjyGpz8yzarJy4OiASpMVkACqviA0F4zicoltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTxgvFX8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CM+QubMH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTxgvFX8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CM+QubMH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OGqncg3937135
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j5emzuRgACX
	9a1cgqepsrcMt9zKe22Qqa2hBXKHbruc=; b=bTxgvFX8NKX5eDXxqIaBpXp0ciQ
	BGc0fryJenJH5LAVyBAQEyawLfJou8zs+DYflyC4RDR1qDT1WKcA5i7MI1AMhEMU
	lYLYlua6JYvBA47wCavq3zv2G3jMh+brLKlg6Wm1HMz5RW3MqFkCWRPhnmjaqZj3
	/Wjs3F1bU5EffYZCTIwDAYxazOH9OegI6T2WTzs9yvpHgQ3p/Pc01VMgvG/2sWKG
	TUKYb4FShIpFL+3fS8Hn8h6banQ+qQAAe1TTsVbUTXHC1c8QVUSrPOg7oGiLzcq4
	BQekU7Yqhw/NGAJeht+Xk1ulY0jjf3LHuicMgzp2kkq57Ns+azzrlqshzAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmb6p8h43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:29:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb733fc5024so993610a12.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784917757; x=1785522557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5emzuRgACX9a1cgqepsrcMt9zKe22Qqa2hBXKHbruc=;
        b=CM+QubMH5EImzK79Riq/9SyQdbiN1t27mW5tRtMwh54dI3WgK5t9TMRTRyzZuDMRrM
         geceWOrWU2idZeJh/hp2xKefJIt+ZDivlimmblOlDJy4xmLQcCc+9sXIO0QpAGaDU+aw
         N2UrR5NHBowQ6wOEDMrHQZ7TisXxuMjGLkfAIVErqGL4yIn34l0PKlF3rMmAMDpt9TYV
         36sx/ZdQcBFmbpEEmqrJqLsTFxaaLlG8mNbf9rsSdArRmAFJ2t2FqS2888kD1cubVgma
         PEnCj3dJLUyT7iZQTnEQSpiT5nFHuFmQs2F7BdqHXK++DTq/YM96k91qM7grBISRzxsw
         mhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917757; x=1785522557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5emzuRgACX9a1cgqepsrcMt9zKe22Qqa2hBXKHbruc=;
        b=TCGE9P2M8L8uIw/SdrNg94ggfkm107AUNYG66rIOodJjzsrqk4fOx0L5CZgD6BB4dL
         Tq9D7MyFPiwNaoXDfGOHNRWaHqV5J25wui8N78horK8QcyiYuSS1KyGxY/uCpj+Es+VF
         exVIzZrFLtdGpXAKrDAAFbdnmQSvoKMoViZaH7eVbkGAb70GWwFTUNlJYFwMxR22ldYI
         WANfT8JglK8tlPnWgWtsP0CuTP7D01T7LATD7acI3e16CffwrRCi6onFa4aub7/EDQK8
         Wbo7b6hItRGP5O0NiUhFnHUvmtI11rNYmxLFu9Mzqtgqp0GT9dc7hF0MainuTanYam2Z
         CPAw==
X-Forwarded-Encrypted: i=1; AHgh+RqxI4WIU9ZjgdHgv7X+8iaVgnqcWHg63m5SJLdYdDrAg0lAisTYZU6Ow4fJErUhhNK0jZwWSb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6bdz3XK0N53sdRSG6vGwLNulpOkNqkZsRM27Yb1voN3IHSPu
	HGiohCZ+mWILM+Z7EPqmTynkXte8xFcuVIXHfuTa8yczmGtUrAZRjxMGLN08qyzZ+NhZOP6HiWo
	Wcn5mcuxfTFApnTmNofSWevRvKG3hufmnyNOHdFgqEjS/FGssDkVpdse3VHA=
X-Gm-Gg: AR+sD13DGMaZ0TSZylEvKSKcrafUYIEVh4A+e9HKnGQKVFR2Z/LydGHPx8nA4vMqEEF
	D35AotMCIhWBl/HAv+UpKu2aC3yOPH/Q+hJtv+hFBgn8cN/U6t/eJYJr9KYH1CAcVixHAlCImdR
	TxDPznB9kjuACSv7L+xgcPBV3/W4rUOkmCtk0dasndmDr3Ie44o4ABlPqWMSjFtyaUJwBcXKC5A
	LNGWeINncJKVQqsWR4YXL7tXaAvvjKA4SInY0zWnynYp5SKqM0GQZfxsd8A/tVQps3W99PuFj3s
	2WDxKHqY28+UIdXn52B5Zy0J2tghp3J830DviO/sNlKzM1Ur582jEMd8vW130vArwxTrETIMVRz
	RFIg1T+PoUG6t3kxBskscAuvND+k=
X-Received: by 2002:a05:6a21:a347:b0:3c0:9c1a:8941 with SMTP id adf61e73a8af0-3c44b2c1b51mr8939954637.73.1784917756884;
        Fri, 24 Jul 2026 11:29:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:a347:b0:3c0:9c1a:8941 with SMTP id adf61e73a8af0-3c44b2c1b51mr8939936637.73.1784917756355;
        Fri, 24 Jul 2026 11:29:16 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5c53f3sm1341510eec.30.2026.07.24.11.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:29:15 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 2/6] remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check
Date: Fri, 24 Jul 2026 23:58:54 +0530
Message-ID: <20260724182858.1868271-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724182858.1868271-1-mukesh.ojha@oss.qualcomm.com>
References: <20260724182858.1868271-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AureGu9P c=1 sm=1 tr=0 ts=6a63aefd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Td1J0TjYGYW-NjyS66IA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NiBTYWx0ZWRfX+gJKkFh9YTcV
 KlES1lJNLEmAKozQfLLSd/rvNx6ey02r5VdAMJr6LH1HZTtw/xV/zAyHnC0j5mmfKDqHm09xPWC
 yJfLmtA14rWpnGepCs342y+oDU3rxlk=
X-Proofpoint-GUID: 9xeRcQKu-SZfRMlepVmOqsdvRxYsXjn8
X-Proofpoint-ORIG-GUID: 9xeRcQKu-SZfRMlepVmOqsdvRxYsXjn8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NiBTYWx0ZWRfX3oB79kM9J198
 zRTiZVcca/PHSpGsSfxA+fQB0eoA3pBwLA2C5qYovgJWRa68q1BEASQgAv30jk9NeplJaKPYHUC
 ID75zuSBkDRKmxkOEU7AOYmi4T3GGTPnnPJ1fOq0P5CRKKDYXtbrmZAhj534rW80Ft8L4Ou3gqo
 xGBd931L43mmce+gVIBkJgmV1L6Is0GU881vh4XcYCN+iwmmxeO+9uzGEc/r8rzC4PpBIMIpONV
 Lf4OlzxGW0PuQdgTC6VztxBnCe8N1BF2whmQjzeDv1glTe3OuZxxjXE41GHcXxfiQ4muejAP8hZ
 d48Mu3xKpXFUmPi/Qzu5aBePzoSjcIfm5F8lhtMDFk9QT7zEM9mty1bkvZ54Piy/ilsKLo7pfQx
 D1Q1cp435aGNt+YKWuIA5FjsdqxCxelpDxcGs+V9t4M71n261A4s3+VS2OhQ6pAcUzohS4gpfhv
 7Lo0+sWzsVZHPlmcXfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240166

All other call sites of qcom_scm_pas_metadata_release() for the DTB
context are guarded by a check on pas->dtb_pas_id, but the call inside
qcom_pas_load() was not. Fix this by moving the call to the guarded
block.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 29814986b82e ("remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 9076c82ac878..f70836cc382d 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -245,17 +245,14 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
 					pas->dtb_firmware_name, (__force void *)pas->dtb_mem_region,
 					&pas->dtb_mem_reloc);
-		if (ret)
-			goto release_dtb_metadata;
+		if (ret) {
+			qcom_pas_metadata_release(pas->dtb_pas_ctx);
+			release_firmware(pas->dtb_firmware);
+			return ret;
+		}
 	}
 
 	return 0;
-
-release_dtb_metadata:
-	qcom_pas_metadata_release(pas->dtb_pas_ctx);
-	release_firmware(pas->dtb_firmware);
-
-	return ret;
 }
 
 static void qcom_pas_unmap_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
-- 
2.53.0

