Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4034F96A5
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417706; cv=none; b=aoxSM3PNzWCW49UUwHNJ32grIfLYcEXfynx/+PKoDKd99PEBhsCQP3P9ipUgxpyNIKP97SBlpddewKEMLY5epUcSERhOlxUyhNkjVNQSVuTEq3PXi0EMjZOjn3r3pxSnA1xn16wNH/ilN6oeJmToRp6TIKw85qeb5lbnYSXgyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417706; c=relaxed/simple;
	bh=5GHHihT8Q28Q2Z6IqnDJJLR49udVLHKyjwu/T6aBJ7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncYwTPLJQWT1aXpYsy/FoRA7XQK+pBk9/lJ4/zEgrzyuUTzlGKHIuB2x8WVK8dEx4hRMFIbJH2UVWphkmdBvYT0whfbw+K9JVxGdtF7qodVi2+IKVxtdYr+SRI0pP98EzReXRla02/WFPHkRb1RdkaZ/z+4HN9NTNq6ixxk5gRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eve5dmsK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUTLbyvz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eve5dmsK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUTLbyvz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JCsZJP2483642
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3z8i+KPSNZ2br0pM0JUREqSlK3MOF1iO3EQWQGWiPH4=; b=eve5dmsKKTHeRAik
	/3vr2+iutwPPDVeub8pyF0Dt+QIu770JipWdLd7OrSqlxu5R4rXEnbJcCywz6vwc
	vBB3+EwI3JairFp7cdDTWkL+xGnXqWDGQl6Zgh2ro0uhBuemdXG8oNCmieIa8yWv
	kqqzG7ccjnATqjJtyuqtnNbWaAXKvpXBubmyXc6ppjSbeDPXlrF45vFcLxEerp6Z
	xXmBOacReS33qdhEk5hxz4tsN/qgJknxV5TTAFkPfBYIUncqQyirIbT10C48gwGr
	u0BL0LvlJvTAYd9cLxrrsWHSHGW4MGDJxpIqd0Vg9vV38cmObKktOWSGJP8U2+B7
	BZpKXA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfg7av-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91be1227fdeso42791806d6.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792417702; x=1793022502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3z8i+KPSNZ2br0pM0JUREqSlK3MOF1iO3EQWQGWiPH4=;
        b=JUTLbyvz3CpDwhWSt0A6avupu4f61+inNrFvTYI4qgpQk6SsYQvDy5U+8nhKb6fS2s
         gLQBdNboW9n8t9mmgEcy/OvNVAA4Fiq19jvzru0+wYSHnt2DfAVbcLKJ9UM3pu8dZLRp
         ij7K7HUUVbpPXElzoLrg6rqQ+1fQbvkIAUej3FlUdpaLLqw8N5OC509FDN0AeD7po3vC
         7f6QBAlsEaIIKhOV1ZiU+o2H5UgETVfysS0QsmNkzJHBRUZwZffcM1XCTc4asTddh+MY
         ApY1P53/E3m+RTfOZHOI1B1qmwQSiVzwDy5sK4pf32qQswafAKapyE66899KcMFi+rGd
         EChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417702; x=1793022502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3z8i+KPSNZ2br0pM0JUREqSlK3MOF1iO3EQWQGWiPH4=;
        b=0H5d+APYTW2D28yioUNiod4r6nkZnnZ0FSXKg1NcDEQEgJQw9/eNBLs4MYaJDI5qrc
         mJ8nz4Cm/ZCunEbpbzTTLaLi2iHNXJbkcnCyTIr4Gnff8eAnapLxtG/2Y6DhnR7K64A5
         lgc4Hpa7ngrw1ltByqSljm0lLIYUlCEfDh0FIQixFnRLSg9QEuPQaPxwYhQNydhA9FhB
         slxKiccHeMFXxkcgN7P8nYH172AqYhdZBOGxZFrFz0Hg/wC4E0oqeJZem9124POZyF5z
         Q92wwGYmaPQKHxdvDof3La9X6GJ/8KBJ+x9E+BvhR1KdWLH01j3pxL9/KLyEwo5nlQy1
         Dayg==
X-Forwarded-Encrypted: i=1; AKwUvByV7qYhjKvmxAbQDzHiXgiodKIBg10cB5dYddVKbEnR/C2hdH/goIsfLAgun1Nydz3GCu8WxM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBXYFkRn0ZF7oXPQw3Otf7w1h2mskXE5Oco2DqgeK7lSlpY4/3
	jj2IV5TeEMuwiW2NIZGHyCSJwFmwiw8do6O2om3Jp/kpraKzgnMxCkKSjqtUSZcJFYMFX0Aif/x
	Hr/8k7oqm4a34byKlLYSFLFYZEEZ+EPNM6Yuf/igG7oSwTi3nlZR/BlUvXAw=
X-Gm-Gg: AYBFou027YHIdNizbECNf1hBlmm7+h703niaFuxYnHrCxqlCzRGiDtn9H7tAMzfUEZr
	nlDIio3obzdV1jRuHVZ0y/nap7/d7+NEczK/lLwgByAL/4PpQSK4egCVBlxPGwVxEu6UHBAbN3G
	BtSzueLP4Pj+eQcv322cIxuOuisoKAEa91Y+Lc6LSHzSpYB3BNfdZx6qxmCtD48oMcV0FELsVQb
	vuNli6Sn1w9tQIQqIBYrYNFN4zrau8EVXOPemNlH7j7mspQN081cZtUs/uMfhhxGQfTPqhASXm/
	6f97ZR4nIfPbQFohjlHsGcvdiizmnqFraxmCOde1VR8SUw1QcT7sYRrHSQVrBH5vCIPwe1D2gWM
	xK1ULzuylJTge3RqYAXB1ExN9iwKH
X-Received: by 2002:a05:620a:4547:b0:93f:2610:fb6d with SMTP id af79cd13be357-93f29cc832bmr1363860185a.13.1792417702249;
        Mon, 19 Oct 2026 06:48:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93f:2610:fb6d with SMTP id af79cd13be357-93f29cc832bmr1363855185a.13.1792417701785;
        Mon, 19 Oct 2026 06:48:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c4fc4sm20595574f8f.15.2026.10.19.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:48:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:48:08 +0200
Subject: [PATCH v11 1/3] crypto: qce - Don't modify the TFM context for
 per-request fallback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-qce-fixes-aead-v11-1-11c55cc7a695@oss.qualcomm.com>
References: <20261019-qce-fixes-aead-v11-0-11c55cc7a695@oss.qualcomm.com>
In-Reply-To: <20261019-qce-fixes-aead-v11-0-11c55cc7a695@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5GHHihT8Q28Q2Z6IqnDJJLR49udVLHKyjwu/T6aBJ7g=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq1h+gMOTqjQt6l7IKLo91jf5mwj0P/GJHk24Py
 KKqGkk9mZmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatYfoAAKCRAFnS7L/zaE
 w94ND/4k+pDq8J3I5zsCSvWVpqkCQyoYt9nrtKvRWvKqvjlYsSe6yybcwAtZuig5BWOUTwzi3QC
 8KcSiGBv8klBVo3MBblAG8tByLMV5Y89PGJg/DKdpA5ULdhS/h6iNkMEV2m48n3WlU62ZPSPG0E
 NEiBZHkqktVGjYaIxsWE3qhuHLfn+5zYV007HtvsmkRBLSUja/5uua+fZmpXiGujUe6pTTIec3O
 qxQhIdPkEf+oNItFdiCJblNNtoL05mo2KHsaCgmJ77+UqozwZLZmUf2QvhxdFTt0oazP38Kun8a
 Ci9CynxK5nB1X5s/QaPV6/Bp0/0FrWiQLMc0nhpGFgu3PBDBeLec1qq/sz1kFmp4eSl0IwzI9eA
 60hXOPVQbWUhg7klpEKfVDbE6iDY0OxtiBtt6H0JLWKFxmxlYHMcx+Q1EIpH5t073DKDdSOzvOH
 4gt1Zr3hEzKpin5+dRQBASjn6itMEOTMvqEHewA1VS0TAYYBW8g/5MoaxCp7g9VoR/KACh+xU+J
 C6sxjVRND4U1me8UiGrGE6B6qjMXd0Escb3C+9BAn3XK+NRiWsq36r+v14K7Ox0JjbaU5JO3Tv/
 Ag7qxUJ+ehUZM67aF14ifyFZS5VVZzC2mEVGjLdUfyfidpM8QPDEwrcS5i/GeOwNL/LcvJAQafN
 kBCTaQrv9OgOMHg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: YtHINbwWSDcWgZn0yMiKB9Gc64Ur6Jeh
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad61fa7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8On1wDE6BETRpeAr_T4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX+QeW/GTXy5ab
 HIviHf880nauql8CdXtxUoJ9p0A+P5/ob0xi8zWVUDzuKwfhfcJQ3I4B+dmriaWI2DfcSwPJFfF
 bVqRLHXwujo7maIvmDMtdz39M2YNguwj5+aaUvOTvGQYRpogMWX3xrl6uCrqLezOaqncuOVdjst
 zc6w59a60QbaQvsdVawSZpdnEfPje06gaB87LTedqoOXbNUXxnWNvy+uwtawFITU0F26SurbKNw
 eSQXHS7dDmC0m+B6J8rshRMJx4AvnfcNGHWjVvSXJBD1Pghb32DfxMxZlyCfo2VVB/EOhh82Onc
 B2SFnGevGbXmlURBXe0AGKgNWZKGnWuN5OzhfinX+QkQMXEgHf+CgDz/FGcvZuqi0UdQR29PSm5
 4rg5BaeIP5NvI1A7E7Kb2pXzN2W9lO44na6V6cYkbed0HiZUiBsiZKgS4gLxCQVEY767Z+3txtR
 nmDPTRi6xaHBmv8qb8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX7tiXzlU2wKJF
 e4GSKnxDmQCwo2APA3RZLHN63l2NN2IQnqnijSWvKA5VxgjKZanf2ZLq4JwiyMEfg6ullmVtC5b
 5XWtx1xKJRObMU2Kqk3OgVP55hu1/1U=
X-Proofpoint-ORIG-GUID: YtHINbwWSDcWgZn0yMiKB9Gc64Ur6Jeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190054

qce_aead_crypt() records a per-request decision to use the software
fallback (on zero-length message) in ctx->need_fallback, which lives in the
TFM context shared by all concurrent requests on the transform, and then
clears it again. This has two problems:

1. Concurrent requests race on the flag: one request can observe and
clear the flag set for another, so that a request that needs the fallback
is sent to the engine while an unrelated one is diverted to the fallback.

2. ctx->need_fallback is also set by setkey() for AES-192 keys, which
the engine cannot handle for any request. Clearing it after the first
fallback request makes every following request on that TFM go to the
hardware with an unsupported key size.

Use a local variable seeded from the per-TFM flag for the per-request
decision and stop clearing the flag.

Fixes: b51dcf05c1e9 ("crypto: qce - Schedule fallback aead algorithm")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index e0061bfab216861444e36700d6530e7a3cd347e7..81c1a9598474c7c1623e71a9eac876fcc0c111b4 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -499,6 +499,7 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(tfm);
 	unsigned int blocksize = crypto_aead_blocksize(tfm);
+	bool fallback = ctx->need_fallback;
 
 	rctx->flags  = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -511,14 +512,11 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	/* CE does not handle 0 length messages */
 	if (!rctx->cryptlen) {
 		if (!(IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags)))
-			ctx->need_fallback = true;
+			fallback = true;
 	}
 
 	/* If fallback is needed, schedule and exit */
-	if (ctx->need_fallback) {
-		/* Reset need_fallback in case the same ctx is used for another transaction */
-		ctx->need_fallback = false;
-
+	if (fallback) {
 		aead_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		aead_request_set_callback(&rctx->fallback_req, req->base.flags,
 					  req->base.complete, req->base.data);

-- 
2.47.3

