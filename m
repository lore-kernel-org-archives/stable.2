Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E148A8DB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045292; cv=none; b=rJ1UWYWdv0cIJGe1P6ywboA88Lh0hMw0q8d+IQQXbd5cDxzkeeUQRZDM3wvhzp2V8so/PRPK2n5QzEVSfo9sRWRkRmNzZrNTjj4208Fw/X4te6/ubA2qsoaF7hlKOtMHc6fyILiYx0cIdTBYs8hJUutxeuVZbvBUanJhn7Zk0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045292; c=relaxed/simple;
	bh=jX9qpTLTDR3AaV4kn5vvkCsyHxUfD9CKGQiGMuz5O1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCbmZW1WmNjYf06igTEavkXDHVdVYG0gXJytaIhlncNkxn1xFJ3Ie8ngCwf5+y7P0WttUwIHRXdBn1tkjmzAJzsUeR/tLE/TU3nQ/QGg3w3A63Dmnoe2YFwr3cQBCpiocpElsBVsy7aUmCwgzbp0PdISnj6Iv9gaj4tHTeZoUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRC6i9BV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RV6fx1ZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRC6i9BV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RV6fx1ZP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7rI9869650
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=; b=oRC6i9BVWBHapb39
	gtHHkqihreFDxI2Z7J8RUkiFhjBOBeV5KT2n3VbTlMJNxed2leY2MzGI2NWQaE4R
	MKkHKwIH/voOfXwb7ZoxneH9yAEMttc6POED5z84qOrIhhm43R0LC4J5eG5j3tjY
	JSi2/VI6WHiKCRCXBf6nzyoVEMuGDvDyltI8LfjxiS/rYn2lrAuP+s3UN99IrLZI
	ViCDMeo1vkbC2bbuspKMgrd/1vwrx1rvJH3TVxxgfXvJ7R5JmjGPlW5Q0vRuCGXC
	zE9S+gSSdvbS0KiRTPCeCb8XDi2oq6QC7+O5yPuXG78uPiYpGvGSH8oaSjCVkuPE
	2iN6ZQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd3vmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82fe2ba8aso1691160e0c.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045289; x=1789650089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=;
        b=RV6fx1ZP1cXVr1O1ZlQEuwyrSpaB/iqK0rmiCFfzgiIO+t1EY8bfO9ROPclNUNfAhw
         HGAtRAmiCpPJoUBoVOej99EG2BK8U0zeDOl7lTh05i+Pvzod+mkanlbm/6fcTAaonRms
         dkBLw+lIU34aVwuetSdgfIn0vdmGjzVpAXRT+0QwNpbHph1VESsvXut38ksD8jyHoV7j
         s6j1z9mncf6X7uAzkDK9Pg8Y7/eDrzb577dO8qAPhEZFQUGZ4abTmI54WaR5APgya/tE
         HhS40lBF7xovqdaRRfV0KivmWkR7EOYFFPpVQRGUd+Wg7K+mFT3RJ2gT0D/Eqw+RUgpW
         sc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045289; x=1789650089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iY/I37otMekVp4HI+AJzj1qeI5YD4C956zvxiF3oYgo=;
        b=ejoqbIJziL+Uq7pczgTyJUOSoC03fS3jOl6PxcNGh+lx5J3Nv7zb2ciwV4Ma3qgQYb
         rl+xrdNDTylohuVRB99haFeV0OVxXbE7feev1FSQ3myG19L5s1qfruVgQQGwfRPkVtj/
         wFCCYQP6ifKXz00/oAEvxe69RVxA5OB1JhH5uIjosy7R4EOiWZTNIHJzPA0jEUo1/E7S
         f591yGvLATkebRfMCIp+QAtBrv83fjpOAlyaj68Y8UShaQRCDNLz/VwcwVNAF8AdMg9U
         593EvA3Bwbrjp6bzhapb2rlBecbge3ojavmVukAvLJu6IEEfS6hhTr5PKcZJUmFWgny8
         lOtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRFR+WvMzJPD+D3RLy3nEnQe3m+Ot+TJ5lBuUSkvH8vw5G3R9u7nA0tJgP8UB+wKr3RHUErfE=@vger.kernel.org
X-Gm-Message-State: AFuF++kVBaCLGkOMx5bzI01al4khyGM40citEDoe17gywaWUxo8mPKJH
	vTEpfmGLte9NTxDo5xJgVbq+0vEy1QGn3q1F83rdxOQGe4wVtNJpjP/RJpZctG1x1GSF4BZZvJo
	EPfKNlF9rMsT7qJa7vx7MoIlJXS3vGpCSC6D7opnNwDC/nwg+tNGkXFt8rWU=
X-Gm-Gg: AYBFou3xGRTIDdS3eOxVmg8e7v8Gt2TkzVMLJrx6DK92oUk62cRNhUtwj04hS4xxnWd
	5E+RLY7YSMSLrVoQE2LZXDSXZazQNs+HwdBYg07dz1fKoT3LVj83nAkNH2sEfkUCGpgdhheMnOs
	9d20/cTg+mTpfGYGnkics9zvaWCo0ops31nc/bjkomrbqUCl1//eor/AYvwMtQmLVGrGQBvfPIj
	dX5NAblzXmEPq5IO3zPr4oCdJRO7uMFxJRLBRFbLmNBHotE5u2lI6b5e2MoOeCKeX07Q6sxsQPe
	cpYywbnYgx4hHZV3v53+LrFNjqs/yTP7kiI+I1AubgCoH/41kRqkJMYkqggsPG9E8mFmz/RypDy
	XKIblVGMekfp3sQ6DXBU6tm4Awy2/
X-Received: by 2002:a05:6122:21a4:b0:5c8:3a2f:a497 with SMTP id 71dfb90a1353d-5c83a2fa886mr2861614e0c.0.1789045278463;
        Thu, 10 Sep 2026 06:01:18 -0700 (PDT)
X-Received: by 2002:a05:6122:21a4:b0:5c8:3a2f:a497 with SMTP id 71dfb90a1353d-5c83a2fa886mr2860320e0c.0.1789045273518;
        Thu, 10 Sep 2026 06:01:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:42 +0200
Subject: [PATCH v7 01/12] crypto: qce - Fix HMAC self-test failures for
 empty messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-qce-fix-self-tests-v7-1-cdbd2718af14@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jX9qpTLTDR3AaV4kn5vvkCsyHxUfD9CKGQiGMuz5O1k=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoJZIWIXW+j0hk5IgiX33WrCjHTt7/ixBGq2
 +/qS7cn5jWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqCQAKCRAFnS7L/zaE
 w9tBD/48irHDb7sH9v/HqkpxveTDaGlk06v6VDQaPN9nBIWEiQvigDJ61F+iY8ErzOyzbFJQBRq
 kutA4DsjJPSmajJTAHvJPdBNVCEZ8YyCbuWK0GYP9GhjthzjDXHltJaVBrJkQYWVZcX75s8PG0V
 CW30tpXYJbDpC6p3z6ibjAjtODfGTXKEBfZaAS1cZNbp9CMI9jVqb/s/2M1qnrL7+mpPgx8C7Av
 CybJfJB3UENNhFoyV5JabQACN6N5SAGYsjZWooT5BrFk4G69yD0vSApqqQM3SCbq6r6KMBrLiji
 qneqkQdfPVjOch5DraXSyeer+dAg7k21iq703C1nooqzNPh+B5xy78xekO6jbsjrefVnk3gbHqw
 sLPRcXs4UXi4tMn4v2qhupZ+GHZ45Z4C8aQYxBNTvVC8+VZ0gvwDHpOvBgY17/lqTAHGfj9tgef
 W4dVb+olsJmgp7aRINxwItU4sJdzXdBdjxVTauO7RP0eM2fqxsEDzmXZ5RnLhRZEgOuDjYJ3Qa4
 CiCwcRS0ayl4x4SuUm+VIIl/hZN9XvEh5D1YjdWn4AQ5KIBav077XTIyalwNwiqiNVzaMxAWooT
 8H6jNo7C0Iq3eL4xF/OjVT6oaSFSWRfqWF0e8ilPvKdhnOHdcSE3Qc20kmQ6phc1CtXLVyhpEFs
 vFD5P95mdPuvD7w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: ZeY9xhSbFeJa2ogs0FwDm7k72HzUE-mh
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa2aa29 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7HxpRQPu5N1oW2hdKb0A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: ZeY9xhSbFeJa2ogs0FwDm7k72HzUE-mh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX6pfZkjN+znt3
 SI94P63V2Aq3HUXv3xMOpd+wudNVUdvOCAnDplWzPWWmz22Q7ytpcKL+u7jFj+Z/owSIrHc+jo/
 k/bbiCF6vpPf/788yFn7tJ/zu7cXVoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX69aLTatEyz6d
 9WlOL1Ic8iuprXsakC4qGhSYQim5FEZa8qZ7tYlVkYy+U4eAYdLDtk82p6qqvkc3qyhpkI3CW0W
 8c/Ub184xWVCaqzJQsVUmy1cchdc8oxtoWKYBLPPPf79O+Flm1IbG8ExHn571oNSB1P18ooZjBY
 bix8sBS5dsRgt2aV9wi7Uo1w5R/NcpgNkCKZ82Dx+SyQkWzguivEcmhOqmxLqVyy2oRQ4Aw4FIv
 0xXO3qcEwiTyW/TGlku+r6gjHfJsSddscfRxOsgEU/P4gZmOkvFA1S5uU1wZ81wU1xjNLNmmo+z
 MJmA3pD85sgoAZu3dutfioY6cs+9IJ1FPk53RHKIrOMmMPhbuEcvvBs463hR54XOotRO11VGpAa
 OLeNURPcIWGR038DSxYYwzMkGf2NiHf89EGHOiUMU5bRyRvy7g9siKF7hdK4/sKwSNcYtux1LNE
 9mCFnIJsRbEGubESlWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100156

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

