Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63F489FDC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045289; cv=none; b=J9baYWgmaIkvfSE2B6N2q1v+fHE++9zHbQneE9ebuMmqxWNer9wRQrgwY31Nacb4byO2qklWdFK4iP3EJZHiXc1QWv+GN23zPAmdFFdSVBJmf5/W3vKNKeNzOKgGtPpb3T/HMYVsHnSbQOY5uybMeVoxExkuQYy3i6U/2qY/ceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045289; c=relaxed/simple;
	bh=+q94hW+kiltzd6oZ8H14oSSW0osx3J/1PTA4e8Zi7ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtBRksa+VilfyN/mJSWFlNgzgCl1C4A7fpPoyutOxBngc5vZ/aiyFdOjCBMl6dZkuy9letYDDHZA+aLN7azPhqBzYxLccyoRzKVtWbww/rT76ZfQRoY9fQXUzwBaDY3NwNYy0FflONnrvOEC7tOB+gdm5M9Tu8c/zcWp+3cFBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+Sm01bS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SZg6gUYm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+Sm01bS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SZg6gUYm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7rFB1087169
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Apr68ly3hCT/cD0oaIKI9KYaRUniJ63SnCFjliTBbmo=; b=P+Sm01bSkMAvGkup
	dVKFfucx9enT6NmWax115NJ25NxPUw0H4GqTMoA1ZJR9L/4Dn+o+9TJhgS2Lyvbf
	uzEbB1K9Bj9KVRMs48a/LlPLyvyDNFJjmP397VgzzcnTDvk0HXWcKrEfxeQn7oy+
	y53XvphpRVGHb902oAohk2Q2IzYmvPLeXoKIQzjh6+2UKvMxCCwhMBVxf/faeg09
	o0cviNhrIg8LzlyK+Bac9ReJzLo2ai4n1OycTAzgfS6mRG+IZhmAQ2rDCAkOtXbx
	yR45jy1hFCjmkSdhW2wg/moM2dbWWHWnS1VPQulwhCfh1U0XrZoXQkT/gxwolt/t
	+exAtw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg3yty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97e768af628so5438479241.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045286; x=1789650086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Apr68ly3hCT/cD0oaIKI9KYaRUniJ63SnCFjliTBbmo=;
        b=SZg6gUYm22iZlaPcBMbz/Ib5Oo5DY8mA9I5jrlTJxLKZQuyUEzDtnA59adZGtFTzEm
         Msqu6FnaXyPObAI0It05taUffqlm0ri33hnOUBHlI7Owba4GvNlhc//md67Kq3tjnqaw
         huC6tp5paeM6vgf7s2LrpsjxmuzNU8PUmcZx5syOnwny/mZxCiQP6IxdRbETK2z/XQjH
         WMxUYU2Xw4Igx8RPzbud232mwKHfQ0ZHEtiJxxISUadON1Ypy4Qgc0+NIPjhtEeG0E1z
         U7en+0kQ8ejsr5WnnBHKONO9OlZBg80kOQXyEDNYlWRTn0GgURbexE2QO5hkRcDLuT4t
         suPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045286; x=1789650086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Apr68ly3hCT/cD0oaIKI9KYaRUniJ63SnCFjliTBbmo=;
        b=Q1mUx1/KnQ2UzSetGY0LcU19R6rtn9xG6Rspm8z84wRQGj/RidXMRQjFVL7FZbOTcW
         yFHr6FE7u33PC2kzA3XLLKk3AzH/f7DO3g4lGtUnZylFW0615CzqnRSt142MQ4mQb2LZ
         vwgcQgbxLI7EvLpBbnGh7ydc8WkNhxeT7tHyeigpZwjKtKuygCXgdzTSr6I7F4PJRByl
         A6pXZM1nCuOGAvZvKUvTau/SlICcb9nHoEm8qju8uxxGXEldHri98l9SdoBmdo3Z0yIb
         WIbqHe1lPhSWXUB006uDQlyuyYhio6S+Im5pjvYXjkoeHQaiPZx+nFZ6LyYvG+ta72En
         QuNA==
X-Forwarded-Encrypted: i=1; AKwUvBzH/C1TCZbMnWYoX2uwklZk7wmewDpOViDSwOQPwKsc8OOob+KNUbxUtyxJD2yDnq69Zlupb/o=@vger.kernel.org
X-Gm-Message-State: AFuF++nH+FjM76Y4PbCxahDPe/nUPweFJMkr+ORawXqe0SGEzlO6r/WY
	Yb6cIWbRDQOwCg77OQSPmza8Sw0afekfoO+GIXJDDyd9UC2vMlqAk29TjNDQhaYX+HK+kW9wBnq
	zjiHDYQjHH0au+V/Gw113M8BElN9ht38OyLkgZDU8crfYwkpc1Diwop6EGZA=
X-Gm-Gg: AYBFou2GkpTHktj33gvRyORx4Lg5RaZahnappNW5sZ4xuNm4jMdmf8KMb3upBMfNFi8
	pDJR+bR411cz6E8l3tTg9q0ZhkArnJsoPyuYo9AsYK9FMS/eJA/gfg9NMXBK8lc4yoU/76+V3Io
	N6abiKds9zJKAhNHbkUSmP83HxIcg3Na6DOb/kFg0uEHpkN7+OwXA3kqrnZGz45P2kAmE8m8wr7
	OpykY3P8joXxoj2qo3vDShFtxVNwzs1ZNTlFgewAipomtzYijNdGkiK7A7e2GkGQtnpUoQlXf/u
	qe6Dqg7j2JZgsagp6blpVPrQcxmOahSVZybd3y5rqp+ra4WdP4G22a3Od/Bcimpu3UgtGRU8ZQ9
	Wopm3Es2Ns9j96NZImb77wlILJdBz
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr22260008137.6.1789045285811;
        Thu, 10 Sep 2026 06:01:25 -0700 (PDT)
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr22259771137.6.1789045285030;
        Thu, 10 Sep 2026 06:01:25 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:46 +0200
Subject: [PATCH v7 05/12] crypto: qce - Use fallback for fragmented
 skcipher payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-qce-fix-self-tests-v7-5-cdbd2718af14@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+q94hW+kiltzd6oZ8H14oSSW0osx3J/1PTA4e8Zi7ro=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoOYC9y0PnnwCtT9kBv8b0ovnRcrryw4KSyj
 wGEI5TzlV+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqDgAKCRAFnS7L/zaE
 wxskEACFOaBj8VCu5B2daTrv5BL1EJdlpaGjPEAc0+autgVw4uDpHrgV+3wQF3YrzSRkh/fJvpA
 hbD1xtYeBJiSF2Ufat0CflOkswP9FSXfiQRPHThyNoRWSS33fwoflUiKMJgGcQqFwtb3fbb0Ntw
 kdthQfMGge4Cbc2g5veN43m/7MpABusDQfWkoWy+RPYyJX1Xc4q/VZwNoVPzUEViD23Bjtp7oV/
 QORX0mTsV9En+Ac5bpj98aM4C1zgYbyF29uemcDC6NwAUEuL2NzpmLjY3OcCPJl83pGNOx+ND8g
 GKAEHiaSouMnH5Gz7P1md81OLNWq65D0nSThs67VRqOaX3q47TSr5BBRvWY9FniDfWR0eMjth4L
 L/Q5u6sVi2IfDxrN+e3LhTOF2L/Du6mTR3yxafNhyke3I1IhBn3cq8IGk2BfQsKpnqiyQ7h4xEd
 gNWzwFH3+IXb1b/vclTk2sIPE41p1kkNcdGqzrjbjp7pLHNu1odQAdJeyMs3iqQsbuMgJqApxWV
 dSH9x53GNGoylA2PkFmmDmhU4FqUowB9r6DzPK+gPWwx+hpo+IX/n1mxV5XVyKhwNEaCdfjy+aE
 Yw4Td64K0jdXuxvTWoL4F7Vk9KReUSLCyLGByeDUmJIr0HsLDJFsfwNnedw1YkSk/VdP7Ii6kaG
 JLQ/08FYJW5Z0VA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Vu62kO2n c=1 sm=1 tr=0 ts=6aa2aa26 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2ArJjka39wvl4ErYtigA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: kaaqvcmoX7YiPITjy6Mm6zLw5jKo-Vrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX4j5cQBfbrkUI
 rpoSKOC5v6wTlnio9xfqhqRqWAWqaVZT4pZaZuOptT2TYbNeVpr9yFFqrD9KY4UoV/i6JOdGJCF
 Acu3vsV3rHDPkbAmUWitdpEueGspVn2mqHeEtINTtRUkLaO8pS+LCMxJDA4jahQxkYhZPR0ZRlp
 M7Ycjm40L4VcRYgTx9hOTX+CHxuDWAkFJl0D/jCopfXkmlKaUAfLxPTxIHriPE/D/6kNHQabcFe
 M9dhys9mY5eeJu3FvT1hqYaJ52OW8rQEwnAzURETfVPLqDr972pQW3UvDI846NeDNgHT0TM/jxo
 7BeTZaD73Er7e9TX6oKy6lMSVbFtMI6RJ04djQ9z7X+Sc2lqIrN2u5M/aBGCG+8/Uuu5JrCSCXY
 aEoWnkXDF70ZH1ItQqyEZdSVSLRDLvr3AqpgvWNeHjzoJmSNd/udLUXRNzgXBwLUC3MrvzPZjFn
 k9NtcWyxUY/mmiw6Qeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX0TZ5LM/u0eSV
 mvGNqystaFuVTfYGf41wsW+FbIyY04pLwCSAydUG3fxARWuyqKTblcAeljoJG9Wb1eOB9aO2wUd
 P9RGEBy/JqGhgFLqXaNfdGNGzc9RZ70=
X-Proofpoint-ORIG-GUID: kaaqvcmoX7YiPITjy6Mm6zLw5jKo-Vrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100156

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
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index e2ca2f7a6eea1129edb724fe30659d55aaae8190..4b7545e6aed220b7fb5af7dbf20ab47db5d1d180 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -261,13 +261,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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
+	    sg_nents_for_len(req->src, req->cryptlen) > 1 ||
+	    sg_nents_for_len(req->dst, req->cryptlen) > 1)) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,

-- 
2.47.3

