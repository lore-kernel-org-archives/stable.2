Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596031F9A0
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159929; cv=none; b=gb3qS7gsAAFN8XIbFMcVhPVzEWj+owQWD7Vo3dAdNpzsX7jJt0JNbxWXVjPZIA6CGmIerrf1/SPDRqM4hl32WZEIDrdMEz/1TUGJze8jwxJvViuf3/GMUMEeg6GQAw7ppNUKMOK7sRH5spNkk+ylhjQH4Ux0Yp3Ic+sPtReMK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159929; c=relaxed/simple;
	bh=PLKMvG5hyotQDMRVcZZ8iNkIZWwNLAYfcjvBo0H08q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqapSjCDw5KVyeJmz07kHTkRAW84Dx2JCJuGr/0uy64BaFNE0bt76x1WDNagTPIQYYkKIW6fz4ZBIoexFWtend3yCwUYjuNtNG+BeqgfpQvuWkPNSyKd+bkAPSQZYMaSd1nNXXSPM66gViHO6H22zSYc49QbsVb+NIJs1YnG1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAsqdvf2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jXrlApRt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAsqdvf2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jXrlApRt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE600U2301995
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cgh66chNi6rdMtMPBnHowPkYFSFoeuEVr7iErvjPiLo=; b=PAsqdvf2LgaNy4uV
	d1KgRfGSWxM87rPVtEM8va0f2J1zmL88i2AKebB9TZtt+B04w2/3bYUgdVq9pYWz
	lUxhDgDJgwCj4LZyqI+ahH3khbQhgyjvBuZzfYww1CT+CakFQYp6lzVq5iLdFCSz
	Oz32Qbp/wNmPI/GLxeijaFn2PFnpz5qMq8NuCY2RMR7zwTnihlos6aChepbYt/xN
	5rF41ZfuQStxt5wsZ3K0GbCDEtNxL0VCgK3CipvmkFUYvclepjnfw/+BT1Om/9vJ
	zXAbVmHom3n7WzWXwCFTCyIGkyy9MX4nlgWq2DoVKgziTUSP7CalAFcdyza4gLcd
	CUiUXQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sev2h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:02 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ea8eae7d77so1841941e0c.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792159922; x=1792764722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cgh66chNi6rdMtMPBnHowPkYFSFoeuEVr7iErvjPiLo=;
        b=jXrlApRtc1SHl5Kqy9REC5ZO13PlqJUqt9Miar77wsiG4skxYzuAOXYuNElWqBIRVC
         izVX5crmUQV697gDAZ2/DYHxX7+jCrPF+8soTXvV6vNsIArlTbUOlbVU50xVhdl3u5di
         pQ8xp6HSQzNWCKiB77gfCI805vBmI3Bu8T0lZJbF34qj4OYUnFcYZ95YmTgGR8WQgPix
         QzP7P+b4raYth339n0MYQ799l5hfL9so5M/xD2JnIG/SeZzBcTvEyCi5U032msdeykKc
         PyOGK2GZddmu4iHFyApA4w5OL4KGnIHJiN+XWcPJg42XfPqS6dHFEk/WqMIFlJ6/vrHe
         Qa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159922; x=1792764722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cgh66chNi6rdMtMPBnHowPkYFSFoeuEVr7iErvjPiLo=;
        b=T9n2VZt+NHc3IjodTbw5GGuf3sdpOm8dsoMd+QGR1ms5La0TnINSLJm4JqMcjN8AxU
         TyzrJJyVnmbHcXqeZ4kRSnWtPWucFdQR7izvM/YZCFFoPmK7V37iOd0KOzLJP4IJ4DUw
         XjD+N6UoBlEH2V04HeGfBt9ZO1d6tqP7qL78zY/rMm6vMMrtrPwot8QFThC3Jb0Ut0X5
         S18RTaNNuBKUnRyOuTJprrwpecaBXyKrtGDAWYPDqkLPh1iAVCfDdagK4lPQH2GLoMV9
         7wDTggUQd9O+5pvJzDSMelZaBTeKGDbDn67y6c8XQjma+O7mRUjn+ChNFdQik4sGQGWG
         HBkg==
X-Forwarded-Encrypted: i=1; AKwUvBwV9z8psoeqS8X64HnUOytCWzKlHMI1tWSrHHSaqVePF78GocTbIFCELz3VsK2PDUd++kw/qt8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9jWh33kEtlYW9VtvYylHXvZIyxhq51hvHlXHZk3CJxvCRQCfQ
	B9joafa+9ZDI27wHcJOtoDj4+zxd+/3R6356a0bJUihL0JysStVilRbl4FTlzLxKc+EKCQfidKr
	fmtYFLT5c9wK9sxEPcK81FD2+y7+ANQqnXaB8aeCr5+Ft9WYAgve1keEswO4=
X-Gm-Gg: AYBFou08BiMZzujm7kcqdqMgQ6mjMzSpJMzHbFGYWufn6Ng+RBMRRILTy62fzcwphVO
	Iz1fwjvRCFmNl5dAzsaZmV3DubuJGvezqj6SmP8EjASB2Q1vv/q0ygsNculdfRhSVN7cB0GpSRi
	THvQGjyM3p2Xg28uKTv3wTjpjC8O7Na9VybRhyDHXYVQV+jms5zb19zCqLqzR2qPWHkmWsbxL1Q
	woPAVN3WLacSGx1XK9t8ay/QhbvgPQ2jshQM7Ndzr1yGCkOG1hnjkrvRHi73GTtWU9KEVWGX1Yq
	lg1bFI3Yt7FGsCjDLpRD9moyBzdZTuep9X7WS3bcxNWsqjgedT3aGz0orOHXtXknyLYCO5Hs1oG
	u31kQL+CWyXYp86Wp6ubhTRnRIhzr
X-Received: by 2002:a05:6122:1782:b0:5e9:3144:427a with SMTP id 71dfb90a1353d-5eaaa918625mr50089e0c.19.1792159921535;
        Fri, 16 Oct 2026 07:12:01 -0700 (PDT)
X-Received: by 2002:a05:6122:1782:b0:5e9:3144:427a with SMTP id 71dfb90a1353d-5eaaa918625mr50041e0c.19.1792159921032;
        Fri, 16 Oct 2026 07:12:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8babsm5760145f8f.33.2026.10.16.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:12:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:11:48 +0200
Subject: [PATCH v11 3/4] crypto: qce - Use fallback for fragmented skcipher
 payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qce-fixes-skcipher-v11-3-d13ddfe609a4@oss.qualcomm.com>
References: <20261016-qce-fixes-skcipher-v11-0-d13ddfe609a4@oss.qualcomm.com>
In-Reply-To: <20261016-qce-fixes-skcipher-v11-0-d13ddfe609a4@oss.qualcomm.com>
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
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PLKMvG5hyotQDMRVcZZ8iNkIZWwNLAYfcjvBo0H08q8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0jCo3pAMan40/z9UMiqByq0ZVspFfxrqhiBE1
 n/mTvdMtZuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatIwqAAKCRAFnS7L/zaE
 w8iUD/49hMcTKhTSHUaF1cuIalNVjPDNk0o7rQm3koAyMyEAXNQE6iBus42vBQjq9nxxQgxLULy
 picWDeQu/tDBGhX9b3w+GwAUO8fAv4OyWi0kUNx0Tj9NOb1ExLtsyeHRP+4cBTwBiHdyVoJ4/l2
 MkT/qzXNBbOwn95d3SGz+3jqCnMEhXqGvaEeHx/khBlcpIR4UYXEEETP5x8wBZVhonkIlvPJvso
 xas3heMDCFw76+o4TYAYYJHxx/B2WwJ4ps1PnZWDkv/xOEjlb0RRbuZp7+ijYRf88dGx2x1phFT
 mDbnloS/rERP3h/RqsTpn/H/0oXnH9mEOYq1wpdDXxwdnSl/WBLixxe9QG1jP3ZSkhWEUN8greK
 He5sxwadiuJgXd3yOrrK59VSJQnsTqNUw0piWeaLOPh/i+rSqqjeudFyNzdKXlAZTjd0eeqfEAd
 e53K3L8+5knVDqtGKrNdgWlUzFFKCHLdDrC2DOvWuVwGEAkHPEBEtA33brsl7E6cua3br9CausU
 N5AUlPNuksUHiUnuBvYwelHLsVH7HOuT072r6990ru4mh60v4PbFA37FcTixTBIpaq37Tdyc1fZ
 zfCdnmZWjAXOAAMXINacruOFAUsPkfV4TPqOt2ZdJZrQFrvYOAmAkHJu/Nmq+QCPYSalv0Yn7Cu
 F2ITHRNLceVrygA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: rM0u4p8SQe511bEWMhEHAPn6rq7thFEd
X-Proofpoint-GUID: rM0u4p8SQe511bEWMhEHAPn6rq7thFEd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfXzvlmhupIZ66+
 e1NaW5EZDQpm0/r/2GyOYPcygZUCUVT/cWZGJ+FsxAebw4XGErkAq7F1zagXGMc8EP439uUrsH0
 sE0SRQgXJbBUAUGnziBOx7jvohd3SCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX4txWmyB7zkHu
 DWNNOgEWIWvkp6ehA+vF/MVTiomG/Hhg5lDsMZ6epOpW4pNNvupaQ2BC2+sRh7pU+ziRKTbS1fk
 x4QtWxzbZetXYHxI1OadWzIY6kT3sq+aTfxMiZr26a8b4bKogbRMluFzbCCVQFfogDILaEYp7mi
 rrc5lXdkO6PRPOzasdBoDz55CEnwBJBQMgXUS3drmaPZz9TGbDI9R2WId9rA4Y60T04DQp4lAX+
 +ezCZuhqrJ2zc82Vz1EeysCgT+EvBp2bQI2MZkHxohez/0e4ipwSCj+oCJRyouASaWJyO43zTRT
 1KrAzzn0CBkvefEKXpRTzTi+vvdFh1fGE+le7RjmVZVWbR6q9g8yJX7LpTm/K0itkfObZHkq+a3
 ln5aWg6PTUnB01DBmXP4akLqEzwNE85nRqNhwKMllb59cNHK6knOx5tfQ6ulfoyk1Wdp/BrXbIS
 CybYqsy/MbZy03b2DoQ==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad230b2 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0H9NDlJ9gza-_DYZ0SQA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160056

The crypto engine reliably processes AES requests only when the payload
is a single contiguous buffer. A payload split across multiple
scatterlist entries makes the engine stall waiting for input, failing
the request with a hardware operation error. This was uncovered by the
crypto self-tests, which feed the algorithms randomly fragmented
buffers.

Detect a payload that spans more than one scatterlist entry, in either
the source or the destination, and route the request to the software
fallback.

Cc: stable@vger.kernel.org
Fixes: 25b71d61d631 ("crypto: qce - Improve the conditions for requesting AES fallback cipher")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/cipher.h   |  1 +
 drivers/crypto/qce/skcipher.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index 850f257d00f3aca0397adc1f703aea690c754d60..daea07551118d444d2f749588bdfe2ae2c6c553f 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -14,6 +14,7 @@
 struct qce_cipher_ctx {
 	u8 enc_key[QCE_MAX_KEY_SIZE];
 	unsigned int enc_keylen;
+	bool use_fallback;
 	struct crypto_skcipher *fallback;
 };
 
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index c23ebc61873f1c542a4b475904c3c3a3d89bcc35..0473033db2af90e119b731b9a6ec96de5973d3c8 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -215,7 +215,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
 	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
-	int keylen;
+	int keylen, src_nents, dst_nents;
 
 	rctx->flags = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -237,6 +237,11 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 		if (!IS_ALIGNED(req->cryptlen, blocksize))
 			return -EINVAL;
 
+	src_nents = sg_nents_for_len(req->src, req->cryptlen);
+	dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
+	if (src_nents < 0 || dst_nents < 0)
+		return -EINVAL;
+
 	/*
 	 * Conditions for requesting a fallback cipher
 	 * AES-192 (not supported by crypto engine (CE))
@@ -246,13 +251,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * needed in all versions of CE)
 	 * AES-CTR with a partial final block (the CE stalls waiting for a full
 	 * block of input).
+	 * A payload fragmented across more than one scatterlist entry (the CE
+	 * stalls waiting for input in that case too).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
 	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
-	    req->cryptlen % QCE_SECTOR_SIZE))))) {
+	    req->cryptlen % QCE_SECTOR_SIZE))) ||
+	    (IS_XTS(rctx->flags) && ctx->use_fallback) ||
+	    src_nents > 1 || dst_nents > 1)) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,

-- 
2.47.3

