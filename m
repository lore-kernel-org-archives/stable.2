Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DE49C4AE
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995541; cv=none; b=MUEhANc4ithBSy/AKVISELPGLme/yPMF57sOllRoP9PjQVeEmqR1R+ajpOMYdyWJjmZn4Xy6ec0JOIcGATcPALdGOnhBcK2sPbDWP5zeN8aAsuYWc0Y2IALR0Dhb63MmU3ngvYqymBod5XHgR8gs6vne+b2gHkWDoxQ98NYqn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995541; c=relaxed/simple;
	bh=IJdDm4DV2stdnBPHtaq11uqEmO9kKVnIjpfyisSRYII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rumERAEuBGNnFCoDH+Oz6Y4R/77/QG0xPdllztdt8NrGxB5Thtm7JBO6lHh+DUg9S6gTR3dNdQyayIP4c/kEcah3CHlF9He108azHEvSjFnqOv5kwjxb2IL5J+YwMDKNEYzwbjLwC+Jxo814kYDdebTPDIRudErKK9vy7ZASwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ag5dRETs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RhJszDdV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ag5dRETs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RhJszDdV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeBxZ837829
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AEL9cOLkbb0sELjP3bPIpNHAEuCYXD2Bf0vsGddneIo=; b=Ag5dRETs4yzbd/I3
	muOajTYWnmgVr0KNplJrjVPfcqw6dqgFhdrJDO8ZlDHGv4UfeBm1B8E+9jF7JjJu
	98ne9cw1CXAad1bmU282PFRxGkTBmYJv91mJ705h47lCVUTHYkW0lWrhjf0MmWSH
	x2TZwgS7m5GtBLiixnfCi/V+AqhnJWT7kk39ZLxQQN6o2R4XWtn8Ux6c46LcyQwp
	RjLcWvAsuwk5Ah6hzBEt+BNGYws3p4FKHQzVrS7rtoq1j+jyM9KfVaaBFvYSicSG
	kSdAQGFhrLx4IIjir/ODkk8RPWALZDdXKcQNfN83tmftznPIMhl0zsyv0wjfWRnW
	zXC3Xw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hwja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bfb2da664so393670385a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995537; x=1790600337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEL9cOLkbb0sELjP3bPIpNHAEuCYXD2Bf0vsGddneIo=;
        b=RhJszDdVqMQu5W9MX4PDvZIR9KY77l1+h5FZAuhzqinJp4uRhgGgdkGNgmRXQqh4E+
         tdHmQ9zIaTx5MGxBZg1rOSERdihloD0ovMw9rRYp5Hw7EbhhgzIgYK3WBk+luss1TOkD
         8UQDR1X0HUh7StEaOhghVixRuLhODEG72qfGrxrdP+q2/mhPystDrqNsNrIs2dVLoV4p
         Lh837SLDQsBF2Btgr6MT8xalZxAGWV8vSoLimvOClv4MFJ9idAon4HOrcZps/ALTd5md
         NR8fQUq8rgWOgazoiGEdZZJgIqMQqpuxCYYZqEMqVxeaMpT0nn2ilbBM8WoFINQzdXQW
         CraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995537; x=1790600337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEL9cOLkbb0sELjP3bPIpNHAEuCYXD2Bf0vsGddneIo=;
        b=rputFiIYkUfDocMFF+8iPrQ8oXxX6kRhfsriHV4sA50iKILAoIdxtv2UJGoXWsAmuO
         ga9UIML90eqOH3AYgrZLC1lbgvQxixA9UU0Az8OAQF16WtG/d5orBXJa3J1tCUMP57Yh
         2f2hJUHxgGA5MU0SASqfI/vOX809WtS5hWuvT1Zwb0zgWwKMrKauouKnwMwGMs4101vs
         2jxteRFhS/lYPUJ5OaChKxoPu8+pOKiY6w6bqIDa+MpHY9sFtq8JFuliC2FB8pZsJPDp
         VT0gWvZ62+cOi8fPwXBal6P2+HYsk1tSmKGN1FwnqN5w7tLNfJE6P4PB3jWUgyglLICQ
         0KzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJQ1/QfCiGgJU0eYdpZVGhYoUK4ZgrdEV2myDowfzkMK1vl0nFZ1jvS8Eqzm+4OEWg/Y++cRc=@vger.kernel.org
X-Gm-Message-State: AFuF++nUUDT5d5FvaqwSbSfJgRI4Zs0FViIrGAm6snnfS5DNcLAAz38Y
	mpUsz6JrKY50vKYHIRA98YOVjknmHrDMb0UqAXoo+DRRE91bqQ9TLrkRmYCInnXJIOZjUM6lg9C
	oo9DnxGxCPqpCNEOJw5Ktjv88Pmj3P9nlC0XICF8S7kZaLRNF5Q48YD3FU+I=
X-Gm-Gg: AYBFou0oQytsqJ3dhpzqRnlW4csWQ/aHJxh1kPr6UL5Xef0IvOY9kBKt5ypS6SOhTX3
	yP09H+WEuypZCX/OxPQHcFH+rvk+H0Q73r9jfKxi/nmsnUH1VcP+Q6OZOEw9V3Y0EGuv8zm6Or5
	K+5NDYOnxyfpOhIMUwSA9sfql/O6V6y4NKG4dnmB3VOE1xCIl9mzrgrJ15JcazhzpVbSjvd48ta
	Oeit5BSJZStwVNamPCkj7UgWcTAGSjB4nB2iEEfRZWd6vQQMHic91WgFBuXMSC2JHZYQYDMI7ST
	3bzAuMT2r3RsqCdIALTZvYI0MsyohUn36sPeg2ZKBa3rsLbJ33zx6ohaPDZ1u4F28sfZUEZVNSe
	8Xizn/2cZNPZAE5hxSJoJWdVGZlk=
X-Received: by 2002:a05:620a:701a:b0:939:6a:a71e with SMTP id af79cd13be357-93c15d9198cmr51643885a.21.1789995537307;
        Mon, 21 Sep 2026 05:58:57 -0700 (PDT)
X-Received: by 2002:a05:620a:701a:b0:939:6a:a71e with SMTP id af79cd13be357-93c15d9198cmr51637985a.21.1789995536815;
        Mon, 21 Sep 2026 05:58:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:17 +0200
Subject: [PATCH v8 08/14] crypto: qce - Use fallback for CCM with a
 fragmented payload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-8-107537869a72@oss.qualcomm.com>
References: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
In-Reply-To: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=IJdDm4DV2stdnBPHtaq11uqEmO9kKVnIjpfyisSRYII=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnxUdKIQbn30Wr6jm9HbMHDt5xoh1FVftHXo
 OfD/ESCrnmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp8QAKCRAFnS7L/zaE
 wx/rD/9/w5RK7R3qv59uB5ZKSYkJD4KfqaUj4FguyKfvfNwrZ7hPt7lF829dTNBYolnwWM+4zH0
 AYD+6nNRJu0UnE4r6nhKIyOVIQZZRPfv6Gx6hMLCACsK5slCgjetxmVRmu2+tnSb0q2Mq34nNF0
 kgj+90QvbVXngW2BYbHa961jyJ+dOz/eb858t0IpkszPk4WRKMvUMmOlWuPVyR8IkmF9digEaSx
 xLIo2naQcomCCdOxxK1AWsr0IpAj9m8mTHYQMd4hL4MfrZXW/ReqFLKU/lCJM+Q6A0mGg3pmLHT
 3cZssHxkVJI8RiaBWWEhctMRZzIvr5YbfC4QLlKrzGVnijy1SPwcz7d3szbDVIe5hbIbXikYFVV
 HRthcl4vVr7TEafu352fxhSdFtbT5/Q0zyprhnWglmOze57el0rF83P6k6JZsN5TK++P+Vc5x8l
 oRMwqaMyiQNCg/1qFD7lWr2lzOyW6/8ANfCnxBhR4PyMuLKu2c0JgP7cFLmiFAcu+4stOV0riIk
 HK0lDuHz7gH9jsK5qdKYeSYOSzX56erTdlubEG3UDg1I16X1DvfA3P3oJj+A+R7y6F1L/uH8VLQ
 m6JyiIiXVNz8eg4htzF7kkQh1uGic06qkCCQ2v0SikyvTVy1u2KLvQfS45icl0OLt/2q+rtnFb/
 ADUJHxCBUOHemvg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab12a11 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=phyxH6jkQibGXiXynFEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: VRNDq9Cz0BKQLo-50GrGn8jd_jjUS8qm
X-Proofpoint-ORIG-GUID: VRNDq9Cz0BKQLo-50GrGn8jd_jjUS8qm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX/VhSFC56LBTT
 X28GaBAXJM6GGo/vnMj/1RC4k6ClluInyALdwaO05ou0/J+10QW+cp4Q/Pppe4pTfZCCZY4Ce+D
 MxpX1CivJVHA5ZNgQ36HPbsBC9LbT84=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX8k0GVENWiUws
 og3gfXv52mUFgxuwe4QL7y0+5seGW4GHX1PXdw/MgYHqvMYotDilP/VjtGTogEMTZDfk6WSz+/U
 +euaSbkve8lyQmOqTEhLivu7oeyhTxa7ZSUZWfhJb7ldjz+Zl0hDYhQ2lLpzNJQKk5eMjc07bit
 C0gb2W7RC+UThjA1fZkjxaHCOFiVZoD7ysCk+ZNm4+k8zTuo7t5pcsG5B3n5h/EYXdjCpJVNd1A
 r51ReSCecpJdE4Xq9xov+RdTitHj7w65Jf4LX6fzuvIlb8HuFUPZadGjBIyy7HpDRJPC/41ccdW
 98t4LQgyoQ++Z0ClNMcVpNIjmdWeHBSQjhm1EC41dHv5+H4ELszXz9+NGyqML568yn/768qCeu+
 ii+lPsqnl7lcAG/3HaMNjPfnUnbNG3Sd0voX5Pr2vtGQ6MZqF84YkG/VhOE7U/YNXrSSARcVIwz
 CobqsoaO4vC4+SM0CJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

The crypto engine reliably processes CCM only when the message payload
is a single contiguous buffer. The associated data is already linearized
into a bounce buffer before being submitted, but when the payload itself
is split across multiple scatterlist entries the engine stalls waiting
for input and the request fails with a hardware operation error. This
was uncovered by the crypto self-tests, which feed the algorithms
randomly fragmented buffers.

Detect a payload that spans more than one scatterlist entry (in either
the source or the destination, skipping past the associated data) and
route the request to the software fallback.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index dad2478bae0e2aa70d31c5f3c7b37003e9e15e2b..a38f7f9854437a923b8fffb3dbddbfc0e3b44b97 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -498,7 +498,8 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(tfm);
-	unsigned int blocksize = crypto_aead_blocksize(tfm);
+	unsigned int blocksize = crypto_aead_blocksize(tfm), authsize;
+	struct scatterlist __sg[2], *msg_sg;
 
 	rctx->flags  = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -522,6 +523,27 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
 		ctx->need_fallback = true;
 
+	/*
+	 * The CE reliably processes CCM only when the message payload is a
+	 * single contiguous buffer. The associated data is linearized into a
+	 * bounce buffer before being handed to the engine, but a fragmented
+	 * payload makes the engine stall waiting for input, so route those
+	 * requests to the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && rctx->cryptlen) {
+		authsize = ctx->authsize;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->src, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? 0 : authsize)) > 1)
+			ctx->need_fallback = true;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->dst, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? authsize : 0)) > 1)
+			ctx->need_fallback = true;
+	}
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

