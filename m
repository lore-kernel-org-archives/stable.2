Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7645476F5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081885; cv=none; b=sQ8WCBGPTDznGv9NeprqxE2aJWeIKULXnpRBMYCSqaFj0FxQD2VuNW8K7nun6yFc8oMH+uoW4AkQNs2pOhBhdLC5ZjAuItrcff2zJq4Wm5uISJp4EItVxnnuHmjJ0C76Y/PiG/2apHdos5Z/1jL/vRwch/VUFHAh3t6lfx8dD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081885; c=relaxed/simple;
	bh=bj9lX9c4+OC8dVs8JmPGc4UfJVDkKWl/nVNsAYzA+XU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oe40UrV4ZeJ8Iwr8LuQYR0EiXYglLgzJu2XZ4zFhl3sV/pDhmu/KqClXTxdXExoUhtiuE3oqD/nqHAt8G4aYXb+Kste0847QN1Fgnhb2/8jjJnF9W6Rx2FUK2FlMOlqcLvWDnViQxO/UylWcF3a+YBx5tqtbRnghyKta5NJ11aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chTdvJa5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d90eRVTw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chTdvJa5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d90eRVTw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPa7e2869472
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/MIEadUHz6VYfh8CAPIjr93K/GWIq3ryVLs8Yl2c6YI=; b=chTdvJa59d54BeGt
	WHVvdpJKKeOWEpI0Q+WQWmZzNDsl8Gjb3cBrl9MNlyCyVPc7cQKO2IbUfHywsIi8
	4Nnr3u5+g9eLLhtLJ25mwP9u2OxQWTyk4ZdMcpJ2QHFqBeO7yHbgIfzwOqoz6roK
	Lm5zft4YYZ053/wwUYV1Wv2Q0aXDdyKj8FMjtrMXGH0gc/gO6NBLkw67T0AUjiO7
	th4/W7KPPZZWLS3Kc8/DVpiO5WjZqRYC72mnVKGkFGxviM+3GLy6mSrPNrPnEVnw
	cFZquudFgZO5VtZ/CL4Fa+FvUTc6EAdpAp5O3FZupFa33tmXuD7ufORCq1DqCPXH
	JilFDw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj11233c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:02 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c82c2e9761so935640e0c.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081881; x=1790686681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MIEadUHz6VYfh8CAPIjr93K/GWIq3ryVLs8Yl2c6YI=;
        b=d90eRVTwP5tGoDe3GU/jso68cg/VhHVy6+5t8S35areR/toAyB02jRSyk/t1Qk80mX
         0h/FK9HL5hXaaW+GjTiuyU2jzZIzSYg7eRkqG3HxsekP/buRHX5oXx/nrdJSzpTaAVwC
         0HqfQd0LFQDhIkX6gzG1vNO1NZPaGlC+YpxL8KwAynFWNiM+Vxa/wV0QPpeKcghne4Bh
         nT2E5vyAv39PxHGDY77RtDrwM/HJo6G/FNv0vEfd3no3gkn26vfm+jWULWmzDUVdDeh2
         EDJ7Ld42sUhcTj1J0X2Cg7Y1wvyXRZQoKrHBriCRq5+zZLDNxVvIY+an+Q8vDYEWYPcy
         czMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081881; x=1790686681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MIEadUHz6VYfh8CAPIjr93K/GWIq3ryVLs8Yl2c6YI=;
        b=oDkfkUj0PaWZmWi00roZlrCuBsqS8ZUALdXL9zSrnbv+Ce3/S1ImsFgi+tvD4XgTMs
         pEAwLpaHTM3tUY6bvwyXOc0JMvEz8WEiZtndrlcgjOzWzNSC//3siNaWOxQyXtmIhOiZ
         CvB9c+CyZSBvOMCod8X+Edx69n/aEwdHdwGkztu26rgQUkkASerXUFGYu0ANnduFBM+r
         UW7r/QtxMZ18Zwj3tbWj52K1/w79AKfp7FWWJ+u/TU5ynygY2IxM9ysGfg2jgUpZCCSz
         TvAhyO3Ct9skOgoVPrL6JFrjTm4u0Uh6RL9+qDPA1CAEYHsrkMSRZ3fW0bb5Ixj6wnDZ
         h+rg==
X-Forwarded-Encrypted: i=1; AKwUvBwnNIkQjoZykgkQvZjL7jlczwgORvZt7f1OXPC/pUYHlvGfifZPZdI8J1mo/GwuiNwCR/ysHr8=@vger.kernel.org
X-Gm-Message-State: AFuF++lCD63HIUFY0WyG/Glr67sI0wD32NuSgsl+xC4RGDXGjUv9av31
	tfjlRtSZUQKY5BJ7PrWjuyLKac9TZTMh9IEf7Mf5v14JcJnyUaT8nvPs5qUerZ90sDUhWULnDqn
	dQft+oE6LTxF+50Ar+FyJNcuBlRUJQ80Wf/U9zL7nyrFLCgqGFBk+UzHcglU=
X-Gm-Gg: AYBFou3sKI92e3u+rKousEsxQktQK+Mc8iEiRnUYvFHD7pQ8HFiIJGq6nBp9jhOR3XE
	W5HnizcE7yA/OBuoDXDWUDF8FFBlhTzbjyF0pVNy/lfhuSFgZFQFqg2E/sf9xy3EVC+CfiVnime
	Ffe9MNEPR33wWucUX6TBF1pndMhRl+lI4T+GHFgKTaC7+WE0pcWo6BMfD3zMDGbPJEMW81Kl+b4
	VpfplsWKyjga5kOlrkULOPgoaZTvYwVUHhgBhTtcvvNNkiJf/tqgxoEcOnjCIozGD8QOd1KzxuR
	oCe3ECMvfeXmMBmuaNjHu0YPeck+khtbt0I6RIcylypWYF83fewSuMWZ0hHj0wenBbiMUcuHAS2
	FvONLTEe4kfEHOpURJtZ46TnnKfY=
X-Received: by 2002:a05:6122:17a2:b0:5c7:a814:b987 with SMTP id 71dfb90a1353d-5c9b8a6c1e0mr7412265e0c.2.1790081881578;
        Tue, 22 Sep 2026 05:58:01 -0700 (PDT)
X-Received: by 2002:a05:6122:17a2:b0:5c7:a814:b987 with SMTP id 71dfb90a1353d-5c9b8a6c1e0mr7412232e0c.2.1790081881084;
        Tue, 22 Sep 2026 05:58:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa4537b5dsm1097669a12.30.2026.09.22.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:57:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:57:22 +0200
Subject: [PATCH v9 07/14] crypto: qce - Use a fallback for CCM with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qce-fix-self-tests-v9-7-b1aa742e79af@oss.qualcomm.com>
References: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
In-Reply-To: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bj9lX9c4+OC8dVs8JmPGc4UfJVDkKWl/nVNsAYzA+XU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsns8hv63zSBtiXYbUTGccvk1xP2mkvo1BVVCt
 yxLjs7/kjqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJ7PAAKCRAFnS7L/zaE
 w7bFD/9Kth36eGZBIVEX800vPqzyl9ccVlbjzHLpgw9p41gcpsdUO/y1PCbrtzgGxVe3nXy8b39
 K6lvPIGz1pP7NJR5uugWdMeFouuhSHIgQnBEiTEANpTSuR2xdAbZA/sCQhv2Ol1IJmpXQnjQXqD
 pDiTSHTVOEPLFF/59RnGbTmP2u5sjVLns0ABiT7NwyWBlATOo2n5dTaZt+mlmcSV4YuLazFqfym
 RE7XWqXTxZl9rYW8amIehXm53GDlftRqYvXeQTxayswNQvJB6+qJyuvyh3GlpmLCu3HBM+la5RE
 eiyq6XyeE8mS9L7nEqZBd8YhLHEpC+AzNQ2tEd82lm1quGeKbVci3NBDbC7lsa2q++JMQwp8Yka
 LVaIRfAylSlZJ+ivGZ0RVXBESyHK+okQf5CD9FDcof7hY6cTNiC7rlIX5rpMPeUUbzQH27EBa+K
 TYdN4lrpVAscBnNFdlFEG0xnZoR6nAoh03VufvdvhVdos4W6MORxU0u+HWIJnhpVVq6Ih6cPdWC
 GI5eAyD5BydUVjmGK55CZubxwNkbSejZCH9ygAbJ8j2h1rAPW6/rbiblywD7iub4lnltMTnT7Pl
 OuI7dg4J1TvQ0LUkQCzS5qRwmcnFeyBXpyeEwB8rFkuNFCy2PbRAK6QstkH344ndMpTPfJRqAWl
 h/2sTB+scr4lNrQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: YSCWmbsQ_xOWwR7bMqF-StMT1m_nP483
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX0GgLRCl0KEY2
 MLFApVn07DtYpIRPETpcj5I+JHfv56S6Pf+tYvwFTJKnGpsRUOIvKy94XYWNmcgSMgogyCcHdJ4
 iORi0TGJ9c7ieNyvDJAMegVSrrhUEOU=
X-Proofpoint-ORIG-GUID: YSCWmbsQ_xOWwR7bMqF-StMT1m_nP483
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab27b5a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfXzu5eTw/5L5N8
 Jm8OPDEqHtg92BctjYGycGVx+5lx/AzXsAh1B8VQNZjnXpEyGRK0BFVilcRkPYIWmic5UWB4jn6
 b7Gh/JKWFbvXaZBgWSMSUGw0BtlSo0bUnn7JFIGleAY58icy8Sb5HunBgZQmhE6yNcLBmD84KgH
 Gg0MwaOwkPPENuA+dJ49RxhL5LW/tsoXtKTarM4AKouP/8Nqlv1TORcDRtvHIbA5YEntUn35lga
 Qd3KkRXAnt1QaA7CFafvdCs0fTMKWwLDraD/mBbyISDMGeaIC4JEcJXTHa4NyeXVby9FKB89X9b
 HaLgIZ2u5MFAyNiidxw46q7h7rE1Y5JLotlcChURq697CRTNwGhNAUNIcPtzvS7QeBxrK0s9/ge
 6qiI4qjWtcdCXZ8htnLpFfj6spxX/HUwix0NzpFOiv1IShVcq4aCpj4I3VRdzEpBQzpTFLJ5KQi
 AW/LuC+V4z9TFzBNfNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220187

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
index e0061bfab216861444e36700d6530e7a3cd347e7..02e1a7684a7e51ea7ccba0660eea97a17589c3f2 100644
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

