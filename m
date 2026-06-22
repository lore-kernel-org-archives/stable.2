Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383C3B47FC
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134324; cv=none; b=NAW0MsioVQ50XHy6ybzRFYAvUVC6fsceMXakptGaBw8A2FJ4UuaxJU1bCZbLWDUrce/B65H9Sv9iO9rZkn25QpRbZW3hnNlJ+yuocixbUwGTsTTPsAE4P88TIYZZMHfiwiiqBIOeSQ8C+xifwJWz5dQwJibxmY2cLSkcs9uqO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134324; c=relaxed/simple;
	bh=CYY45MSM4ZMotmXQHnMyBcMwgxFxp0g8DkA1Qgi2eCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhwCGllqRtildZJo+yWMQxytC0yu6uEsWgmhwfkWCMccKsLu6aRtY+4+rL5FXri5KTbIliw+c2kNYV+UVL0vI8VFfojlOKyw9soG+kUZy7eUPbQgmpqRfCmDQhoFMODpwV6IQhTMl9kHJkOQanBUaSms8dC9fORlAcZWPi434nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BeO0oHtM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OS4qUkRf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BeO0oHtM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OS4qUkRf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDG3mb1062155
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=; b=BeO0oHtM9HzWUcv2
	fJV/C+vBkIfAEhSk9UHDYtRSXDgbvmX6JlDF7cRp8sBV+zRLyJXNmue1fKsCA1+A
	6vD/WdivrB9/56B8QgZ3xtqQq8u1EQy6l6vEkX9HklLK+0Pc2SXtf/5Fp3EQLJFe
	dNUl3vnplDo9NWEqoUwdwYVchSa+H3Rlh0/nbZrc3Aw7ijMxCvyE60eQTdmPZcjW
	ML9t4W7m240HTGkCqf9YxRvI4tj6FaqCb3GIdvSIz+F4nP9bkg6IAp2y2IQ5xWmw
	vLMcIl+lR4e5BL/HW4WDwjVuqhbqOlnSkA/n+DC9qw23hHlkgQqkrZgn39HuAEfp
	aa4ReA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1sn7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:42 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963aef8141bso1138217241.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782134322; x=1782739122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=;
        b=OS4qUkRfEjDXtgNWrjDRBqyoama+hij8sk9xIDJBx9g3tHI1+f9POSddMWRl3aq1Ep
         R7GATF7loRO7XSEibkKbdvCP+XN2QKCsu7KHkNOlYAw4zT6Z3IpudUsUgz1gDIil6JLr
         7UyteJAnmUJ9iUI9A2JOPJOkDcQV1Sip/7XOIQ1KU4JzkQtxg1xAEfY1Ve5dDurrZhWW
         bPmGnT32wlc6/gevid4SJQGmPr3a1ovtJZQKTz8AUQC8QaSbF1xyx2bApQWny+Rht1Av
         y008dRXPD+4dsaJWuinmPfJcWTGPaN5ySPcdxOX70PIaLBneaTZVYrj/3LDkZLvm6UGe
         nmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134322; x=1782739122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=;
        b=aMkwgX5bb+WaE/wjwy6e8rPLDxO5DwlmE87/ZCB0HbP3cNLg1a21GE6xR8fveHVaN/
         R4rpCV4KR9GqmZcnxMF6O5Q6bOaNMEYaEQdmc7ruW4Rt4As+fhNM5iT1PUvnBgqub8Fm
         rXfZ8vXH3o6HzoY6kgdqGB9oWY5r2DSTOA88epujMhi9t6C9reE3hnoGRqiQeqfQJ5fK
         yFE1ozYvNYer0qxro/l4BcW18PAk3gmFnwQmAWJ1loin+H0xvoD0nSJhtSKnawsNKn8t
         NTNl8b7GeoVjrVFRBukRE9CtC3sKY3ummmvSZTvA/2yOUJ5Lk3+mK/MhWIkry8YpjpKD
         I+ZA==
X-Forwarded-Encrypted: i=1; AFNElJ8l5P4MwOHMDywN3tzLFZE+BISB7BxqiEA4mtgmFKhv9DRACzW27RYgc/trqgLhsl2bJGBcDq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNyzqpcEUFKg2E//r0/QfS/Ad9LlLxheTM0QVLyscAA7TCbcV
	YwwAAtKH/+DJ4/pKVAwfA5/e41Q/eKaiB9HSv2SPf72njhxMiuXqu+E6CabTm2cnjsiI0FMhs/3
	hnxp3ISmPV8oekejr0/FFn9VbgZUonIm/3J3v0m1MBX/IBeKxGypMaO0Ed58=
X-Gm-Gg: AfdE7cnA/D0XZJKXI0GOnX25JGPHNcoi9W4MD5YvCRzfe/Uam5rCuNlOQyqdpI3Pulu
	1zDxjdV1OPGXZ/coSEZk6LdIau9ijg5iDp4W8xEhh6ysX7tZvipJzxBTicckCdRlxeHI5aSnKAc
	U0KRebluMVCCpI8GGtFWROcy7BezWjyIkIEalGKj8J/E6/Zla/YFhcJhpHCMKXlpUI2OZEJ/UMi
	9aD2yknAwTlyEeOGd1CK/ayjkj9ZJT20AKbJNjPRw0QbPI02bp8wSNwxKInDcR+COsApY0wgDe6
	0f+6ClR/B7OY8NBdjnKVi6raZsAXQyhcrWWKLlfqqdLANqmrBrTwxkpqhOjgEZFOzY5AE2yWlxF
	8PdnpoKi7zsO6uHfhMpx5Nf+x8NOUalHTeA9Izg0g
X-Received: by 2002:a05:6102:3909:b0:639:3b08:d64c with SMTP id ada2fe7eead31-72b669d678amr5888849137.13.1782134322102;
        Mon, 22 Jun 2026 06:18:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3909:b0:639:3b08:d64c with SMTP id ada2fe7eead31-72b669d678amr5888806137.13.1782134321657;
        Mon, 22 Jun 2026 06:18:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm294083835e9.7.2026.06.22.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:18:13 +0200
Subject: [PATCH v4 5/8] crypto: qce - Use a fallback for AES-CTR with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-qce-fix-self-tests-v4-5-4f82ffa716c6@oss.qualcomm.com>
References: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
In-Reply-To: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CYY45MSM4ZMotmXQHnMyBcMwgxFxp0g8DkA1Qgi2eCQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqOTYgjP53jjO6eSKEjKu2GG4WuSt/zm2Ko3Wvw
 z/1Zrys49+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajk2IAAKCRAFnS7L/zaE
 w5g8D/43O9RZpr1iYy9qGRZeUp9oyuL2cZfMyc6EXCeBqaOzHxO80iCo9JZEOpCdhx+cYoH5cex
 YcmTjfbwunIUxyz9B6oFM9QxPtQyPqFBOisbaDNbbKWg6BlEP19m5LC7jDSu+tMTAi1bKm9vLyk
 NxAYxOBk4Vut/kZsJLVLuqsbSlnv5sRjk2Dx+l5Dbv7bd5IefDMYAOhsjLOCQaUHvKJ6wZn0HZc
 luc5RK85+W66F5pKTDq9P3LF4dud7zKBThFnJypACM+xlMSaoFMDduOM1WaxCW119mGQjEnWHS6
 nyLZ4Mi3yfLyL/57sxerC5yA8FWifxnayChw+Yz9Cz39rtILc2s0ZljMADtBgJfw0ksTFZh/QLP
 G2VULSK0SY6B/nUYAwKwVzSGLdqbt0I+To1ZDNjQH+LAAkBw2nMCHXbocPK+07tAaFfKcvmAa7i
 J23cJxMExAKpDzRWaZXu9Jqd/kVwLSxNRU4VmLeCRob5/e6l1836o/Yc7WQKbF+K7GbZtWr0AUb
 wO/HEfr5G01jAOCBs8hAdRydRokNpRcDOQ9bT5nPpwJF8WYlblSI3dnn+H4a0gwSuX/sQtM1P0w
 gjkC/Xk0pIip+/MzJ3+PdCwcpvmhEd7KcVYU5VnIdhz7wKpRNfU5eWbNCPm3hzasl4IlY4+mdIU
 BOIiZYYEqj+qT6A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: gAzrGYSL0JYeQpvd-JvIkR_CHVW0JRlj
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a393632 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vUpbTSJP45I4i0_vGVUA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX9qTFPrZf6zep
 Li8U7sdI8uV2/5adGr/vlmXC4EWRATaZw++BbSP0Mv6zfNsv8BKQKa7eZlboVZPCb7GtFMvvYl0
 +5jezh6sHLHwIwBE3zFPMO4NwtDicGo=
X-Proofpoint-ORIG-GUID: gAzrGYSL0JYeQpvd-JvIkR_CHVW0JRlj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX3KBTHR/e1q3Q
 1X1A8rjg5iAw9MKpvnVcOeyr//k1asliNn78oWereict7Gt3m68bqy7ATcA3ukCVwsoJW5i/9q5
 rgcVRHhGfljlJ6sC8WzGVg88OyfjspegQFNHFqCBFdzE1DLNWvd04HAFnDAc+wH9dD83bLzmGP3
 EcQ0zhOztwiUL1Bjt9JLqRSlIH8gj5ORwe9Fa4e0SusMnoOKv4/RuWcbgfecRCVt7NKR0nB0hZU
 HvMNXRqt9ne1ViWpeZgi2dfgZkLP788Xq71xDETOUPUEsZ1LTERP5/YEhcmkXR5l1Ne9eU0J+CH
 Yv0kNFlFrTKjY/YyRMO7W+fTrSkYWUybio5jHRbbN5xa9mxV1W36FpRTeD1aMDbafO/TAU/fysk
 dWyReUJrDsLFH7ZfubF6ERN9uYNvU09TLaynvX2RPhI9exrqQkOCI816Z+TlGFOrGOmDCmguM3t
 zAVRDqP6Rb94UOQoGqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220131

ctr(aes) is registered with a block size of 1, so the crypto API hands
the driver requests whose length is not a multiple of the AES block
size. The crypto engine, however, stalls waiting for a full block of
input in that case, leaving the operation incomplete and failing the
request (and the crypto self-tests) with a hardware operation error.

Route AES-CTR requests with a partial final block to the software
fallback, which already handles the other cases the engine cannot.

Cc: stable@vger.kernel.org
Fixes: bb5c863b3d3c ("crypto: qce - fix ctr-aes-qce block, chunk sizes")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 35ddbe03cfcd75db7599a5754e4ff978f3528105..54ff013e24317cd4d7a0dcde88cef8268db784c9 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -260,9 +260,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * AES-XTS request with len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it.(Revisit this condition to check if it is
 	 * needed in all versions of CE)
+	 * AES-CTR with a partial final block (the CE stalls waiting for a full
+	 * block of input).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
+	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
 	    req->cryptlen % QCE_SECTOR_SIZE))))) {

-- 
2.47.3

