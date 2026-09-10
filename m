Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9D486E67
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045740; cv=none; b=PZM9FvE5J+qSd6nZ3MmtODLl/UkafzwPM4eDU2tm8G4rqefHKminogbAMySqiP5eOQbnWJRjVnByYRIX2Utt6hNOzaEiKLumOIvfLWlKFBhwnFMO1rXj8xCvKUIf/qp9pvdb3r4h+ptrviEMEhEEJ5+vFUJoDCdKtc5MISk2h1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045740; c=relaxed/simple;
	bh=Uma3r3Qc44Y0Xz31JrEvI/Rw746qZICX+o0Zsz4ItL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjR95RNtQhLGGrC/qgrZ6x0vqlGibJiaLWVezzJC4nV41+TSkEEM9RCj7OsnVcxu7pKL84Z7Z9DTopcetmOgwWqQEfJbxNOI2Wnhum3sffFsvT8y80AY1EWIXc1aXtZqBLnRLVASzVxMre0vFkxIoqbwsz4aBbRr93CsJFin7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GadzsUIg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFcKrhHL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GadzsUIg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFcKrhHL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7tff869693
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/AX/Kem1ZM8Esmp/0yLI0NjEShE6PnXQcN8z1bGeCo4=; b=GadzsUIg2YzBBr0D
	XAFgVM1jy6rl7/SVGpPBAHcFAUPphOJFD9RTi3dEQzk/rymaMtlE884OdBid3NKz
	C23UA2mhV90HOmldiRUW4bJqiFbybB6JhSc05KyBIeJfAk3ymXQ7+C3/uPCQRH5X
	soysu5yYaOMTR0YF3IW/H8CAmBrDXCb9i0r+AlDYUE4ELnUmShccEzxImWU/38QS
	8gloyOD/WKhi4LdFIi/uXDU/QVZS4XfyFUnf+ngHi5Fz4/WKqNHMcbq5JG5hySXh
	fOhCQBM0t36sqCLk63TmfA2dbEmdTxuy3GJENDbkR2LdMAONwkKHVmsy0zWnAoFS
	n/wpXA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd3wst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:08:57 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-46a5954cdfcso6751252fac.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045737; x=1789650537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AX/Kem1ZM8Esmp/0yLI0NjEShE6PnXQcN8z1bGeCo4=;
        b=iFcKrhHLPYvvvVrwgwCiIQ+0rUj7IautPl2vkLnC1OQVPgrDZyR8WidyPDRqR4B17O
         JQnrElzwHZPo4nTViXagO7M/x7/D4jXucmX3WDRoho4DSbdRlqqXzh1BNfGIS60zHElW
         2KW0BI0qkA1C8Sa1Pu178bI1b+aqcCnhODMvTgNK22WdWIiqMuJesteLDE/WznoPkBWx
         vukDDGosLVqV2QCJMWYj3VStTgMAx1UiQ9pwZZNhmfrPkd8X+owXUMKemgERqAv0ZnIC
         5Grs6cRvWBpx6FJAKkVpmdHEIE38Q6wdrRHIr7UyxtNXhKmwBGFo/eCaL9iCz8vNP93J
         yWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045737; x=1789650537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AX/Kem1ZM8Esmp/0yLI0NjEShE6PnXQcN8z1bGeCo4=;
        b=B/M1Wv08J9VhUSP9agZtZZyZvBEScLm0rRX7h7065TM2b372i5FNrprWyEdECECBs3
         NBN32GvnvGCdK6D7fbPJejEg4p3zYost1xVXGGeFrOcWHSI1yMRITuXfAcr/y0XgSDpL
         SoHnVbOj5lPWIOeeiGPe8yc8iF0BcSNERmRu0SkN5ylnCtg0gnUC/AplnBp3fkzu+iHn
         LvtdIVwL3caziOIDsN+rqg8xGGUoutnSIMtyQklfxDech/aJphCMXkIgI4npBmJlGYjM
         PHV+kxAzAASYtyNahTRwhlvc+aHB9ckByqE8CsLZ8sJkCiqtYNTPuRo1F98xVV9EkXuB
         M2mw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ27U3TNhVpZv9xNbqr+fhC+iiiSSgu4OBZkKl3qeK/P71p4HZ41aA5TpanuwhEqA60I7ISHA=@vger.kernel.org
X-Gm-Message-State: AFuF++ksFFRIb0YkP7ZGNe2FzNHSed1kF0dMpiocSufzGlyIxjU0h2aU
	mkX1+VjI160SArhKdMoHTT2lPGUMFgZRrSFsAut4aebKHr/nZMElxcyB0BwYOrx0pnyyEPSpe9O
	9ARxp7NmTtIfUhEAEHKtzVooeMbwEcmuMbsWNEsjPWUifeQkm3YcIl0CnT4BAuPg66rQ=
X-Gm-Gg: AYBFou0PG42jyIlE0NtRhiWBjoP136909UFQ3vVCvkre3Pb5TBexY57FZM8xT2lPRGa
	5apxNBlT4lvCmjV7xGRDYAtLKiIZDeulcMqClevHgs7fnaOfwa9nRD1Wim3cnvBocqOmmMa+spp
	e0X9JFmb78ieN74qs6vBzhfsEwKDNf+tmjby4Sz5woYoJzOPBftOd4elcDensHiu5lMUspk16UV
	lGAcBlbkCvga70dCXpycQvGfO57thE8aQjziPseRo/Fv11Aoua6C+SA+5dfTPF8tcZJuS0GZhqq
	WTTcdfBiF2PQ0n+6qAgwPYunUxoCyQ3P9vk8CMyXLbu7O7relJFm3sy9p65JMhtakik87+ZBw7U
	UI7jkfUSxVavBs8mVdwnZZh8tQ1Wg
X-Received: by 2002:a05:6870:ff89:b0:475:a153:2dc2 with SMTP id 586e51a60fabf-47c519261f4mr3937950fac.24.1789045736663;
        Thu, 10 Sep 2026 06:08:56 -0700 (PDT)
X-Received: by 2002:a05:6122:6c1b:b0:5c8:4409:602a with SMTP id 71dfb90a1353d-5c844096071mr109779e0c.8.1789045289387;
        Thu, 10 Sep 2026 06:01:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:48 +0200
Subject: [PATCH v7 07/12] crypto: qce - Use a fallback for CCM with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-qce-fix-self-tests-v7-7-cdbd2718af14@oss.qualcomm.com>
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
In-Reply-To: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Uma3r3Qc44Y0Xz31JrEvI/Rw746qZICX+o0Zsz4ItL8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoQWFinvRcFAnUPd4tcM/rD2YmCQ7Yz02TzF
 kzcr8WKelaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqEAAKCRAFnS7L/zaE
 w/1OD/48D1BIRVEjmOTkZ1OTGEWgwaQ/dwyRiP644llwbqISK4/pqV/Inlwv5tE4QpyEdtpTxdA
 Df7w5Bz12wbRguaAd02lo31r61KrjHVTbBVXqoEo80ceuMRk1J+8LfrSYx0NnQ8KtBD2OnSdXZH
 UGbX4HI7FbSjGSOgUMaE6I2wDWVrAPcia/yWFtyS816NpAytkqKHoND3dlHmXNPA17Tet/FO80U
 WeuX5kRPrxp+jcnU9H8af1GuR2T1lV0SwqZ8nsxqjuVoH92nKd24o5UTxcMA0Qpf5WwIAJYcn5p
 P4oN3MJphGRyLvnQ9KS4KHsfejsoGDl13uRKAclEI6TcwUGYooiVrzgqbjcZExh21imLVS2iOO/
 rA7log+daqucMzjZxtW/xMGCdazuGXKL9w5ujt8z5GdSJDNuzpX1OModWvWo4izz+Q0XPrnOFXV
 HBQ1QHPrmlkk9Jnaf2v49MSx1C+9Mvb1GtnID+H73kSN9k9qYSF0uf+z86TYeGJCfuG0OXm03OP
 VQ03TzoyOKAVkTZuN1IDFsd+peHkQ4/H09el9UHpYI8nJgNUdk73/rAFud+y8pGSNzRK7/x39P3
 dXgJX7c19T+RD5BCxZtuFOUU+WoXtnwrcCPWhVg+DY9179m6Ut9dWqgHupDiSryMW3ja44w8yyd
 r8Nz89K4h5eKNUw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: kObQn77z3D9CAg3jS_6VBJ5s2HcDkuC5
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa2abe9 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: kObQn77z3D9CAg3jS_6VBJ5s2HcDkuC5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NyBTYWx0ZWRfX9LWmScRKygtI
 BqqfyPNi3Ljia02zIrCZYN3bh4yANSQYcWiZorc+X4+SOR14XAa1w0KDeraRl5UK7NBLThLjRJr
 D9qilluDaFFmhya5FFTs3H9LgurYQEc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NyBTYWx0ZWRfX6sKv/GGAJhR0
 i1momDK3agVMPnOrp4DlmQerq9JVPtI+tNHudwlXQiNtacgaSnZd2X+KfBOELSHnhwtBRPTUi8d
 MGPXVr+XBPk8BNfMFimY6slKaDbqX4APrSWDCeqA+jOgRapTGWg5BUkuTzrzsOkmr4XTvgBTygX
 h1YQFuhprkbQ4LMUTZukP+so18eLcogCKYZvaWMxYSjyRlZuwgy2fmqxYKRDRmUtpKcHASkYgNx
 /QVsKBCFCpNd+eVqfiOBWbaNVsh7EH+j5v1kKvPzbLpSH2rS+dtuzShz++tqkSagbIYlIw/tXtx
 0MpH1axJvLUc+My6L75rxweA+ea7zbnoDPYWcwYxh5FKSQgdW+uoixzYB8p1d+8IgR8xTmQnK9s
 qJLH9cQbg4EGE/roW88X6t2h9cri5GkI5nr5MwavW9NvTUqoOQYqyW65VAgFZ+HF3+w/rQ7yb8C
 d1ioD9F7sgtV6w93+tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100157

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 0453b806408c96db9d67e8f1fcfab83f145ffb26..ddae743903229f248d1dc7037c4ae78537476563 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -514,6 +514,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			ctx->need_fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		ctx->need_fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

