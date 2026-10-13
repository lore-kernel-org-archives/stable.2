Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A6473C88
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885488; cv=none; b=Co5k1CDeG2PBdiSVrX9xiduM+HsRcuSoxPF9Yp+GLsy7IWaf4DD2ULW46qg9XgFqah3f488xErdBtUIhghLqex4EuAmshUNpOP0j45oNmNJ8RO49bwTi5AwmQHATtYe7jQs0pfzsoEstM6umd5XAd8igc9QTu6KdT9jUj3MPU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885488; c=relaxed/simple;
	bh=IL2qbLcxGDHaqL9aKu1kcosr0OoM2VP9z6rqwMPRebQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJe9b+FltZK5qWUegq4ROoX3GGWtkTADSCxXCxbXYK89zJwTai/+X3kUxFV2ht0HyrFdNCQm9+y5HhC4THMhWPRpzibu1WIzCWfGGz80aGl/KW+6JjLiU0rPSM3N5OpEQgkzF8M8Pcb0AkbQErA+HgnQ0qmRy1tUxuVnkuqxsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4v2gXcI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hKKydrVs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4v2gXcI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKKydrVs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7Oum0015766
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wpb76IjtBzrvbAJYohyO9P783yAFFumf2DZOnyI3vOA=; b=K4v2gXcI0D55Z8nc
	QbE6s6W2QEVM4q6CW3fvgp6PyTYPF9MS33TNuk7BfPOvmCr0GHXwQNMvjYKAkkxA
	ExDa1mKiiMTpCyrKw5a8asOvL8O++IhgzDQvyWrydBXlvHycu82dR0sCeYUR7HH6
	eFv+vMCCnCyMMPztAVOuhjMV68g4o7LJxTyEPiKie9C1z2Xv/Uks1RP4K5Nu9W99
	JzRadE7IYaj01f5FSXcYcgmg313YA8vMFbdeyngS1e1BdABK4LNPi8cv8nGrV64K
	bPGHgN6BCQXRbTDNaF+Nm1oDq7c3ihbLyR4aKgwdrNCGo5eCAAzXDnV8LRXe0d/c
	X3YdFw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugmjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93dd3c3badbso621673685a.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885484; x=1792490284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wpb76IjtBzrvbAJYohyO9P783yAFFumf2DZOnyI3vOA=;
        b=hKKydrVs7WZMEkhv2ffR4p7SKz6IlzEMvFWTTaNDfv9VL5aFgHsvtX/8LQpMQ6U0I3
         2rANdTrwtXkKIMBGJpLJcuHhnq3fSEtnQVy6tv0u14zxsjFg54JR4wGaLbFhCn4w9TBg
         Gaw3Rm2On5DqQEzDjV+3QtVf+1Ke4pEp5epi/X4lKuA4hiyCSuvlLxbC1eeUI6yAub0D
         uRoACRkx/FTQYQYbHW55u/P3+tTz1lJ1SAWchrc5D08jivi1A/KQJvTPi4Wvw/pLJrug
         OWX586BV+K244mBCBBEXVcT5vuWMFX7cU/ZEgMA0BqPCRFhKSwH1zZ9ROjQwdMk0ma5p
         9E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885484; x=1792490284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wpb76IjtBzrvbAJYohyO9P783yAFFumf2DZOnyI3vOA=;
        b=AjtPkWEbh9FFrS5cPXQBIaEHz3MWjGgxVAyC4rEZTQ2KFE1Gt5twE4VbnFT1CoDzCJ
         iBqoHamOXbJ8Mtqp1mz1Qs+/YX6QGJ6GRlaGtcmeOF0YNNOHylIEusGIAJXmzUWWhFyt
         IKtKpouofidwwPhbroqVelGQkxnt9gPJivog1oPhBRWstwJ208XaciYgIJVZ+AnICiGy
         bY58zwmeh/Jpxn4xKLmkP4yRlHNAbmvqMItvU7TgeyChxFA4XmJExMWBhoJwUh9objyM
         tx7XOIXkUZIw4hfppjeCQn2SgmkuX5dGOygYNhbgTTPbhhhEIc6xOSJixtaqizvyyuh1
         7uAw==
X-Forwarded-Encrypted: i=1; AKwUvBwIc839iM03rPTd6fAWIEWofB1rK4WYTKFdMVIdOSxIBfiTbyWJBJJwmxeg/mEJJT6HUJc7tUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUIal1+gpvPPopsWG3bOfh0bJE5IHj3cc2qK8zi9+Ng09OGrQv
	NvSOvNU5hQeaxxr4Qr8q3jmWbV4YeEEeNUQ7BAaayAzwmm00HpAeVabQhcccyLaDZuEjmyMtTij
	5ehz6QJ/G72NKz2wdNcoTDi1Ong0QSLa7qdzaOicsVxrcJhT5MJIkkukfdj8=
X-Gm-Gg: AYBFou24lOnQtUqcuZC4ElqHyiHLI9rq4KK/8FWUdE9JZzptF15ls12TnhvO0Vb1je2
	uC5hgobUCEm/qfkkG+5SZ58ArOPEAgJUjauc2Wmmd0wx/FzhHtLOKuntQLO8bSWC01Sjjkqr0f2
	yt0YeKDNPYU7TWkc5RCPwQbZe2HmpzXemiF8muLM+WPcvQ5acb8A2GDYdpLr/lwBfR0kHCQBbdP
	L3sEyLdDQKA6Ci6ax28WJqlsb816Z30CBRJk92RnkGQgSySLDzlQCyNAjO4/mj4NzwOgkEylN25
	8qshmYMFadXc4xPKHLWKOBkVMqHgLRpKGj7WHv/W+tMyFfGZsJLc8rbj/HcqwaLdiNM/LLh0+Yo
	LqNKdqLSdA82tLnMFi/KbXr2dTipm
X-Received: by 2002:a05:620a:a0d3:20b0:93e:c12c:9b74 with SMTP id af79cd13be357-93ec12c9f6amr1366684085a.79.1791885484336;
        Tue, 13 Oct 2026 02:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d3:20b0:93e:c12c:9b74 with SMTP id af79cd13be357-93ec12c9f6amr1366681485a.79.1791885483845;
        Tue, 13 Oct 2026 02:58:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6beaesm209412025e9.0.2026.10.13.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:58:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:57:30 +0200
Subject: [PATCH v10 01/14] crypto: qce - Fix HMAC self-test failures for
 empty messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-qce-fix-self-tests-v10-1-57162a38a554@oss.qualcomm.com>
References: <20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com>
In-Reply-To: <20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com>
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
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5504;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=IL2qbLcxGDHaqL9aKu1kcosr0OoM2VP9z6rqwMPRebQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqzgCaCRrqhKDSvOTzkyve/sVYAQR2SEZsIrrcL
 Yxe6Ze/fIqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas4AmgAKCRAFnS7L/zaE
 w5xvD/9R7FZN50ixptdJH+RbrIFkZc/qHLj+TzGsJiQEDJFXpksjmeAhiayN/zTil1Xkd0HXIKE
 gZNpp9/2p0dAL1LPIWQMJZhi31FrXHXFGYS2hqRv09bYYnY9fs3srncle5PIfAvpMxWnJ0dVOvX
 56Mqi6zVDhixSh7X8/ZEzTHTHMiR6uZ+L4RdJLUKItAgxh2q92nwI4S29+NnzpWcV3wLqHuN5D1
 4cEw/mMwgpL26yy9qFR8rqob6op/1mTQrE7dPwCj29Z8Jo+RuytVSX3bCVHEegOyD75ZFrTxM6Y
 yt9fjgT8/qhwGzXI8jPqSy4J61PZFyzxXfFWfeQtEZhHKPwTr3kBN4CVGETcZQjHEu/4PPB7hxQ
 nfDwFKmYOkaA5dXtGhyPUYp0YWSJX6SZfIS7QBGtYQ+Q87gsyEVA0I6BS6ZUB2L7yjXd7YqPgKO
 RVvK/r+7lMr0Zfi1N4ToUXUUgbISklkj/3VXRzVLRKig9g45sTs/OFibX3kgvGSdRIYgKqywY5j
 2Y8mWqJW14flTbA1XaMY4YH7VyfRlBoiRWN6w1WtisaLdy3rH8NpzMFWk0QnVzei9rMRKvSrZ8j
 uqnJguQiFzYC5zmpEL3VXpFLyl7B8EgAAqwkOCTRn8B/i7sNQTtEgfOKCiW5W2Xp4yoh6RKZJ5I
 VqweSXqa1vhI8Ug==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX7nfC0+Mi+Ov7
 fLpcFakoj8oUjaMlUFABHmyq7fbRXuZbR/VzYgXV4M8ZL9howh7hwai3CAVwepdoE17dz3U2qDW
 csEScBuhfSxIyCRY54yEoeO7WEMgVDuGAiau1jXbx1+HNq/t2+Efuq4JskloCLL/UfXHpWt5wPy
 9pXpMsxUUaDZ6q7CCPetR547qGkkl4XYKX+bsyUtA80JPpR1VKHS5nToPNO0RRoPUkb4gmCFwEi
 NZKk8gJ4iHFLtR4KSNlcfISWiBQZBS0imI9uhoBPnMZwf6DmQVnT2OtOUyaGrqRKqlNbOdquTkF
 /gH2TQCar/zUXQ0EYaQvTSJVRXK6rKzNKvv3zPN6XdE0VLkD65EbUztSbjpGrFKgRSyuuUTb1Ep
 We1UNjKItn4v6Noe1Pep2L1V2RoZ54JNr/GHArO46yFj1phi2UrPSsHcLt3/OOvr2nFUC1pHa5J
 A0Dtu+Ceh/Vmaoe6jUg==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace00ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=STDFJHEvCfpFcWkAIqQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: aZliAAZ-fAwqkeKyAZlfiBf8wntupKNf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX2vWbSS5uG6z1
 Ucpdzxk9gza+eOuJ4hB3j5H2EZPigoyOO9IK1JVEP3MzZ9UevZDypWPcBWdi282AgUTGSxUzyXK
 aC/OdOVrCuCPLn41zXxjK4py/EaKoug=
X-Proofpoint-GUID: aZliAAZ-fAwqkeKyAZlfiBf8wntupKNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130039

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
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/common.h |  1 -
 drivers/crypto/qce/sha.c    | 62 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 16 deletions(-)

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
index b67d749db05f2b9823cd2f0953ef24f4f337df2c..738454dd35655a8376bc878444fcc3fbd7535956 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
 #include <crypto/internal/hash.h>
 
 #include "common.h"
@@ -249,18 +250,56 @@ static int qce_ahash_update(struct ahash_request *req)
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
+	int ret, i;
+
+	sg_init_table(&sg, 1);
+	ahash_request_set_crypt(fbreq, &sg, req->result, 0);
+
+	if (rctx->first_blk) {
+		ret = crypto_ahash_init(fbreq) ?: crypto_ahash_finup(fbreq);
+	} else {
+		core = (struct __sha256_ctx){
+			.bytecount = rctx->count,
+		};
+
+		/* rctx->digest is the raw big-endian dump of the engine's regs */
+		for (i = 0; i < SHA256_STATE_WORDS; i++)
+			core.state.h[i] = get_unaligned_be32(rctx->digest +
+							     i * sizeof(u32));
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
 
@@ -292,12 +331,8 @@ static int qce_ahash_digest(struct ahash_request *req)
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
@@ -431,9 +466,6 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	alg->halg.digestsize = def->digestsize;
 	alg->halg.statesize = def->statesize;
 
-	if (IS_SHA256(def->flags))
-		tmpl->hash_zero = sha256_zero_message_hash;
-
 	base = &alg->halg.base;
 	base->cra_blocksize = def->blocksize;
 	base->cra_priority = 175;

-- 
2.47.3

