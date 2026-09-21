Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8949B5D0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995521; cv=none; b=I3700BgBGUd0F1ca3U4wgJEdQkGWy1wxH6SxYzR83jCNk+fYEIPQGT4867twD0xhKeMCp8RNVjmklxiqDK88Nyv4HkfUJuIq662xwDMLUZH93/TycIKlIsuDXjoiNc6zgL/aeuIeonue0wvJTXtB2+/Uhh/PXRGYxmf3nIRM8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995521; c=relaxed/simple;
	bh=jX9qpTLTDR3AaV4kn5vvkCsyHxUfD9CKGQiGMuz5O1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEdTrlKORFvYLU8mqiKR0nsj8H3lisqevH1FlJtZMZDSYLSGgoh151cjfayJ2r+r2ZJmTwVdXTb1octWOMqGOTEwbZQGHyH5lnEkijVD/LDtU32S3R2wzg7vWmX/viFqrxCGsEE4uHD83Fv8ET0Rz7xJmAgbp2m2N8cwI760F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wx4+uM+G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eEJ2cjVd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx4+uM+G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eEJ2cjVd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeEtd1219020
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=; b=Wx4+uM+GVH21ik9L
	3yLLllzpgvOppwlsZJy8Iav2LaK1k4gqWj70ia3clu0O96gj6N93oPh3XdKdK/Nv
	dl7wYqhcTxVU9JjIaOT0di9p+cbiLd2D7qniWh7Q2+ZGBKZYSGVnuI/jjJNXf5p/
	86d1+8rAM0Lh5aMpVc8b9xQcJrfraPM95ofMHNncduxWBhlLIaJhjS4WLVovYnQo
	MguWJ9Ulv+6EBg/ncv3zWOS4TjcSA+MSDTwaHUGtZAUaZgjdazq0xh2vW7P+QI7s
	Y5DSF9K3LDiTmvosewThzQn9ctcV/G2S7DPDxwRBAruPiN2rqPXWcjH0WU4JZeJ6
	dHgL2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0119b9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a3f673221so494414085a.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995517; x=1790600317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=;
        b=eEJ2cjVd0AixZCPw57fJOA57wgHrHCfYJ6f3Ia+IN3qKpkDBYBUtJcWUl+bGX9ArOp
         Po1Ih6zQqxha3c/KZI/WwbTRrk7xYimuq1ZIVwsGHO4qfO+yUxYQCOCYYaiyyCo0vT+A
         x0WKsT7keFRMv7too1C4bSADlycLcW+RoVJdT5ToansqQ6MiQgBzDqwqYFfKQj9H7m4C
         Nv9hIW5ypsLn2ANKiNOTjdxOW3e/UbBPWtDRKscqB0lJvn1qpW+bEX1hvRNuqQnBzoiR
         9Hi9vZjXQTkxZUPCoJTLxAuOVNPA/0kk1tYb+yRlzLZijuSYyWyB1LHCnDOjGKsxKTBX
         TVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995517; x=1790600317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=;
        b=tgEaG3k+7Q2BkTQ1r6KKNHwFDbcct1HLQ+Fq0Cl9mnY+Sx1siyI0B9cvelZHmW2kAV
         emoIP2NBL2R9pFnq8LvxF8iq4qPdWRrfyCEnWzGJXxZU83TEZTZXbJlsqoVl5hOqZOfv
         VKxXRSeulyhvBheJaH0Y4LIUe2zGrldbLoYluLVT0E9ue/yChbF3sJjq1ye8w6Xer6h2
         xnkAbM+3R7nXlaWQNfV32HxAYoqA9XOr6elvb6eI816j6TDNt7a1+lbyLx/hIOqw5y9c
         DRSpiArdH+S+eElBcXSvXDEYf45XzfVE4Qu6HKklV2RmAYbxACr4pBh4Qz7hA23P6ZoW
         1zwg==
X-Forwarded-Encrypted: i=1; AKwUvByd1gej160VyyVJWDIi+hFYlzPb1P3rqlkwbl79dizdTWq5QGf/E4keawc1G0BHPCZq6dZq+kA=@vger.kernel.org
X-Gm-Message-State: AFuF++nrsDI1C9X3RrESO2q7hCfTP+YwW+V/c6zgrBcgWlNa0z3lx/NW
	bEsqbSLjj0Eyir6SsBpOdv4jHF27Yh4efoc1tlSP0/4vws9RVOxWtuq29fQTH1cTjGyRhclmgJj
	qyu+0abt7poi2bm4CdEC/uEuX+J0qn736gszND5lOI7qhKVRbSOzDCye4D7Y=
X-Gm-Gg: AYBFou3PUHjRdbRz5tTSJewWI7PVMX9lbp8+DV1HspxfFEkSoV3udF64z7UWIFTB3Ab
	pbFHVccVnNBVViWamrqcRChGj8SAFvO2vlCUqp8/js7LrWTE9Kozw0Exrh7y69ZzkpEQvgR7vGz
	G5KauKBYxEt1OcaBoKsKsI0XGQq1ocwR3bkgn8NEg38Ea2hAxWo0xkJhdZ6TNYmMdFTj4x2rKVT
	1osus0Bu+CYqUwOOYEpFKGEtbTWvbQ/lOdQLVup4FcYQBllWnd+sOV+CkO0yBb55N/Q+AAxfIuJ
	ABP1DcPRmNNTAHcfUrUN5Hh/R1i8RSkO5IbZ/fd4Zdi2SR42IgBTTu94sCHJhTClcMGZOh/JT0V
	4vFAmLAmpfhVL4bBMneEvfBX6b20=
X-Received: by 2002:a05:620a:701a:b0:939:6a:a71e with SMTP id af79cd13be357-93c15d9198cmr51498085a.21.1789995517461;
        Mon, 21 Sep 2026 05:58:37 -0700 (PDT)
X-Received: by 2002:a05:620a:701a:b0:939:6a:a71e with SMTP id af79cd13be357-93c15d9198cmr51493285a.21.1789995516945;
        Mon, 21 Sep 2026 05:58:36 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:10 +0200
Subject: [PATCH v8 01/14] crypto: qce - Fix HMAC self-test failures for
 empty messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-1-107537869a72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jX9qpTLTDR3AaV4kn5vvkCsyHxUfD9CKGQiGMuz5O1k=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnpKMr0GKcipCGu6A/xXU3+s4jILWH11Wy41
 bfqvpW4YXWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp6QAKCRAFnS7L/zaE
 wy0ID/0eks3hQCOkIGESPYIE5stJ9pm/DA4xm7WQg68PVBkYI+8GYf/LcZ9ZXfr6/ZkPJaGjI2Q
 ECuu5yxvPd7nCrx20jP+4KCpil8awvPxhelx2JCO+nFFP8E0FMzlpttIjZMzhWmpeXOGxSSjqc7
 /3eSMLjfW3kTeNru1b1CI+rzFHvFwnAuqC0IZygeBEhjtEKz/jdVJbmbU4Aw55EpRuILXYeJL1U
 jKOGTHZBy411/RDihZl+YZk9Mk2Cjb7JRjU4XkUuHq5SnNRO3f1aY0uuUV4CkbeazEx4hriAPV1
 6G2CU+ObgPnPHfBvsGWylUR19fsDf+KlEMFPfP+BQtMWo862pwgJKaBv0s3PSi7VFzXD24QzgTs
 JojKN7fACTyxRNEYUyrep/N9XUIwt8TGmmJhxCWzTCjshf2lRjNCRt9s3oBDDrrTvdSk2oW2eSy
 V7mR5l63uScc4c1jWGd5Q23sQRa06lXbrS0QTfRKk6YtGAIBX9mu3CB9qRRmJsNVvozf9Y9PtKq
 QPA5E1qq3Ss6H2PRliC84nvvtKV6g6Y6xBrJxM0nYZeC7wSSPwJZm1pzHlMyfmpikCpM8RMnRG1
 SmsTeplkbfvig2gjVosd0W5E2gVW3huwoLVeZKIWiQQ52C4OgJN+C/kyiojbdsPlJge4aQl3K7N
 NQFavh9VkQtBAWA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: H9OGk0eVGKvDhPxAmGi6rfxBhnvqQsL3
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab129fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7HxpRQPu5N1oW2hdKb0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX0QLScGASSkYJ
 EcAj1J45XbaUutx4Zy6+HJMSOP6U1sKUPexM0cqoK3yBmw9/Kp1q5WMnvedguHJsJWuKHzT3lTZ
 bpkq1iyZxvCG4iHEAYOGnGXHlk2cW8JeiCnWHOfvMxb/Lavrz+mtup6aPQv0m0BgddbBSO+tLCA
 nglJ6iy4C7pxV1HJAc/ZulxjxDxPTHhGy0EMl/ww252y6ydQ8cZ1wATYlnEXUEjGUQNbgIgnoJb
 Mf4J4VrFvdQeZL+DJWQFzf3DSM2bCjLylhZoloOhUbYagotX8PSk+rC54MsgInSWVa9G3foCNIy
 GmU1pRrvhhfijp/M/+PJsMzRLIp6ICvqazlhYNuGr6EAelqqhLxtfqCcEDYLXv1WusvBVohfV1E
 DKv00/wk0RXnAQYGYNVDWyrg0UJDjpkdHnP467C6tSVr5U2DIsDNdbLTF6yXyredxgEfEpFdpWl
 a+fxWUqQ87FH2fnwADA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfXyZZPSTB8WbWT
 gE+JLsDYUdwGnLR0hfyZBO1A0ZbieVc7mn7xeiLqu/jYXSbBHTZfYnzpJOTN6w8H60eianqpC4S
 6R0mNyc5p6f//M9A3XXSX0nDtyJcpaA=
X-Proofpoint-ORIG-GUID: H9OGk0eVGKvDhPxAmGi6rfxBhnvqQsL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

BAM DMA cannot process zero-length transfers, so the driver always holds
back at least one byte to submit to the engine and only ever finalizes
with an empty buffer when nothing is left to submit. For plain hashes
this was handled by returning the precomputed hash of the empty message
(tmpl->hash_zero), but HMAC's result depends on the key and cannot be
constant, so hmac(sha256) produced an incorrect digest for an empty
message and the crypto self-tests failed.

A zero pending buffer at finalization time does not necessarily mean the
message itself is empty, though: the caller can also reach it by
importing a state that already reflects some hashed data with nothing
currently buffered (crypto_ahash_import() followed directly by
finalization). Special-casing only a genuinely empty message would
silently compute the wrong result for an imported state in that
scenario.

Handle every zero-length finalization consistently through the software
fallback ahash instead. When nothing has been processed yet, let the
fallback compute the result from scratch using the key already propagated
to it via setkey(). Otherwise, reconstruct the fallback's running hash
state from the state kept by the driver and finalize from there,
accounting for the HMAC ipad block that the engine absorbs internally and
that never goes through update().

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/common.h |  1 -
 drivers/crypto/qce/sha.c    | 58 +++++++++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 9cd2e6ed8bbb0f76e24be187d8ae7e2fe2f7b932..587d349da91d1faa2bed7cd488306d4358467b2d 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -82,7 +82,6 @@ struct qce_alg_template {
 		struct aead_alg aead;
 	} alg;
 	struct qce_device *qce;
-	const u8 *hash_zero;
 	const u32 digest_size;
 };
 
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 406c33532612f0b37300abfc9c8c13e43d0c0392..a9a55bc5bc310d82a52b5637655007990da5b7a8 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -249,18 +249,53 @@ static int qce_ahash_update(struct ahash_request *req)
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
 
+/*
+ * BAM DMA cannot handle zero-length transfers, so the driver always holds
+ * back at least one byte to submit to the engine. A zero rctx->buflen at
+ * finalization time does not necessarily mean the message is empty: the
+ * caller may have imported a state that already reflects some hashed data
+ * with nothing currently buffered. Handle both cases through the software
+ * fallback: reconstruct the running state when there is one instead of
+ * assuming the message is empty.
+ */
+static int qce_ahash_finalize_zero(struct ahash_request *req)
+{
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
+	HASH_FBREQ_ON_STACK(fbreq, req);
+	struct __sha256_ctx core;
+	struct scatterlist sg;
+	int ret;
+
+	sg_init_one(&sg, NULL, 0);
+	ahash_request_set_crypt(fbreq, &sg, req->result, 0);
+
+	if (rctx->first_blk) {
+		ret = crypto_ahash_init(fbreq) ?: crypto_ahash_finup(fbreq);
+	} else {
+		core = (struct __sha256_ctx){
+			.bytecount = rctx->count,
+		};
+
+		memcpy(&core.state, rctx->digest, sizeof(core.state));
+		if (IS_SHA_HMAC(rctx->flags))
+			core.bytecount += SHA256_BLOCK_SIZE;
+
+		ret = crypto_ahash_import_core(fbreq, &core) ?:
+		      crypto_ahash_finup(fbreq);
+	}
+
+	HASH_REQUEST_ZERO(fbreq);
+	return ret;
+}
+
 static int qce_ahash_final(struct ahash_request *req)
 {
 	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	struct qce_device *qce = tmpl->qce;
 
-	if (!rctx->buflen) {
-		if (tmpl->hash_zero)
-			memcpy(req->result, tmpl->hash_zero,
-					tmpl->alg.ahash.halg.digestsize);
-		return 0;
-	}
+	if (!rctx->buflen)
+		return qce_ahash_finalize_zero(req);
 
 	rctx->last_blk = true;
 
@@ -292,12 +327,8 @@ static int qce_ahash_digest(struct ahash_request *req)
 	rctx->first_blk = true;
 	rctx->last_blk = true;
 
-	if (!rctx->nbytes_orig) {
-		if (tmpl->hash_zero)
-			memcpy(req->result, tmpl->hash_zero,
-					tmpl->alg.ahash.halg.digestsize);
-		return 0;
-	}
+	if (!rctx->nbytes_orig)
+		return qce_ahash_finalize_zero(req);
 
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
@@ -431,9 +462,6 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	alg->halg.digestsize = def->digestsize;
 	alg->halg.statesize = def->statesize;
 
-	if (IS_SHA256(def->flags))
-		tmpl->hash_zero = sha256_zero_message_hash;
-
 	base = &alg->halg.base;
 	base->cra_blocksize = def->blocksize;
 	base->cra_priority = 400;

-- 
2.47.3

