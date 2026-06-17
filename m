Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7044A138F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711415; cv=none; b=DnXfmZiw1LC30jAWNZa+FKX8wxdYqDWtmBIiAH6qkli0Xd+VYvdQ/Tk01Ox/HKP+WfD0fTyzN1RI63UjDWrgLOiESOCUhPxntPjA5L2hjCjl9SeqjP8NC6FwKi3X/ieCvFIubAGIB35eg/j0C7eD8OvljPwRjsyrdVX59ZNRZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711415; c=relaxed/simple;
	bh=LTozN6+KKvaV3pQEB1cO/FYh0GrmW0oAjoYOtzAUIa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQh8nJQpDZPnbPknjK5h9jv9sgOv1uKHNiNTeRtLY/ES5R+qpe1lqB5r9UVydbD6tkOLK4AgBNq/UGinNpvlj8k4A2ASw79y3/GworJr713SxvrdpHPuJ6hMgm0yqLgjoOAgMzALBPqoT0OmlPfjLhaWORDh8DltiRAY0VAVOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULm5j7Nt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMYZB7SD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULm5j7Nt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMYZB7SD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFPbY53157352
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	snUUV2JUr0Ih2MNO7R+yOLfSCvu6cwwWeMkXOmJL2KI=; b=ULm5j7NtgKlC/RHt
	fgtQ+pFDM59Ar9aHUsupgiqhzczmkfJDWZF+Vev6ColoEp1+GwEjobngn8VFWntp
	c40UHDa0PhDeOIHOFR0fUrJ+g8EWk5Xc8gGIDqsJYknvrtj0CZDV93Uf6cRlvx5Y
	JHkAUfAKkrJR5GwCKwOzMx8GyrQ7YSz2GYOAMdgbhzDJrDmQdR26X8pUjV2ug5dw
	yLh40/Iw4kyPD8baui1nOyVfQqjMs8WNAMxmJ+GALlEh+hamAAgoO8gDiK8QDpVQ
	Qj0fNLW5Knzv+46Y6CboiW1toLWAW15WQiBROXbje+KxCmFzgoGTvC9BkFm7Jkwm
	jEUYxA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerc2u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:49:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9181f3cc5ecso208915685a.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781711399; x=1782316199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snUUV2JUr0Ih2MNO7R+yOLfSCvu6cwwWeMkXOmJL2KI=;
        b=gMYZB7SDKKyeDnhItMGcemBAmlxMX2FCEbczVx68M7GPAhyjSe1SxtlwftSKBIESUI
         WALkEHp7heYbp4bp+drqSI43DUibuwJiidKZMTQYFeKLaNLw76RX7KKjCIHNxJ1E1Hji
         hrWOC9Iz5AHVpfWyp6FuCclpecYmF3dSSTyH+uRuyHk97hvOTjp4g9b9LpRxxRGnn/tL
         DJ1zgVwxHJMErL/1GDFILlMEdKpY6BkMct8oi8Gq1c35253zJFoTDlcZG4g+IhYGA1vB
         hB/vwCYJTsvNxVWpzV3Av7YfcTC8lTPFp2NALunUAo4rxmXJufPD/T3qwlBaavKuPAdn
         BO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711399; x=1782316199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=snUUV2JUr0Ih2MNO7R+yOLfSCvu6cwwWeMkXOmJL2KI=;
        b=sCfxJXatp8juNQo8L6IoTmx8ZtAwDd7RW71SkBNmz3ZzgOm7xUvfxbuB9sot6e032h
         sU+niLgHiEVYFXc7hL1TrtsU9Ii6mRdUK2dW8T5XfhTw1VEm8HOjqUT8eveEP3JpLXYa
         4AhlQsKzeLj6uK4WLt9i1Ix8164ZsCI+zITouxSwGvVTsqelCnBH+suPgENyIOixJryC
         cFri3UjB9XhHAFu1K1raZEfG5LxSjO2CHJ0s6NR7oKDpY7wEbTHf0oa4s+cXC07frm+6
         Mnpk+XyD9CXnNaS2/8RfhK1RbJNN9T6e1VfvbQe4484X5hwaH7vZkzBQZT4pSLhZMasZ
         x+oQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2h25vxfHQupHmHCg/9oYll1+EP/KG8gjONAg3nPyaaY8k/cT7GchAw5krOoTxY01NxvKG66E=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrs8+2N8oLocqSAXXzIsghhrSPAlGJCO27KlMCg+HZtI1UYzZ
	CREGhCa6g6QY2CjGkkgswCPWGNyRf4+jG4AnKqBN9R8gkAu2mfQapI/P9cEB3v+EErwr686df+/
	aLRHaS8omHOlqAYBdZcDcpPGIw/YrCP/ZyvhBddoUiuyXzydMytnMXQisbJc=
X-Gm-Gg: Acq92OHTeB8s1FvwwbzxDL5g8jqB5fxWeu6LIGdQQcIkYBv90fzN2lgqd+dLc0+Y8Rk
	v790vcsKpDAf8SRxv2XvVg7FUR7y1GRafq2gEs+HYEocfYu3tRqLzbTNdLtLqHGluwPB0of5gwM
	r4pfWvIa5wvI9VuHaUggEsfpVTj//4zLYasfCoLBxPtELFexijCDs7GC34Cx+lzZrGa/h630Hyl
	iMwMpaHmL/udFvfGvZBFTK1oM11igkS+rpmN8i905iYFTBkftaX+rgYGaWhsNxn4kBWcaDCiGWD
	QenlirV5PWnM+r0meG0LlthKtg2H5mZlULOnApmQC8M7s1VfYniY4/A3UR3ZzC74vzw6265xMtZ
	PBo4ovgQf8uGWU399Yf0rrsPL7vYJvSnyB9tEJH4A
X-Received: by 2002:a05:620a:4890:b0:915:80ed:8327 with SMTP id af79cd13be357-91f0b10d07bmr377185a.41.1781711399023;
        Wed, 17 Jun 2026 08:49:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:915:80ed:8327 with SMTP id af79cd13be357-91f0b10d07bmr371785a.41.1781711398587;
        Wed, 17 Jun 2026 08:49:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c856:25e5:e249:5e0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm168913195e9.11.2026.06.17.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:49:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:49:32 +0200
Subject: [PATCH v3 3/8] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qce-fix-self-tests-v3-3-ecc2b4dedcfd@oss.qualcomm.com>
References: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
In-Reply-To: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LTozN6+KKvaV3pQEB1cO/FYh0GrmW0oAjoYOtzAUIa4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMsIYsWtxEfk+euw8cGJrHp2EQC94ItMatssu/
 IqK9akWznqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajLCGAAKCRAFnS7L/zaE
 w5oAEACHmCVEXZ9uyMKUTXx4EkDSrqWoM2g6y2Bxl1/UFyoLNe3mXaMz4G+hgNxqxA5N7DeRTUy
 bu6V3BrB+WOp0ZKaJum0G3kBXSIOXGppXzrofVZjlElbRnDN4EXr+Dzb0hSchcK4CHuM/tBI+U4
 s8lCUm/XPYqraK2Tma9KHFiFG6g2jMdxMoIyeNPqvO40ZX3YiTnrQu/RaxFWVMV3sIn+oEYisxa
 K6xUQIpFqTQdaC81Pds6buL/QqVaeV7FPeqwSWOQ6NOSs7Od9FuKaaN6RaMS+w9tY7hnIzW2YXn
 ujzlJZG9aCSNzSpiatPhf8vzi60fPB4p9t0aAdwI22bJiTkYBvMD5RE69EGpjFzAttqTS/0NtZP
 6twHSnLLtCHLTFQWAS13SgfzdPfprTocTgD1n8pjcfJnt0zxldGQu6KBn9NREEdIAchUJEWY/UW
 5+R9gbRREQpsyvkJLE1M5gYUjlkeeej2kigaAbmIXClb1E+xCZDQlnspgj/cn7vOOb7wonZjEvT
 kQ+ucPz8b4joq7Ljp0qjDIGZZj2MdqXlGMMsetztQd1IaossB2Hj6qqNrg4jtSi6hHWuif4gG4k
 sKfcJX78ks1qMf8UlDrVjagxEZKQxEZAMIVqyJEpIoZXyevt86aV1m+cKAegsECbtlgkMlfQMh9
 y0B2pPL//1ahveg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX4NDwPoTCXoNR
 eYxgyPGF6bbTaGWkEGc8XUGY6DFx4v1LiY/6U/gNzcEdCbX6bv2vo0myOQk0puY9Dfe/jwNKVX2
 7Kggmw7AwldLAh+NC1WPeU9blpzYGOg=
X-Proofpoint-GUID: 365JPMDHlTEg4hn-c3dDIUtpnA5N12ks
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a32c227 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX8c6HlTX5vIdb
 cDJGK3yLN8J3eMr0f28r7tWIcoTL3sSK0UIHbYzgdyVwRPoKx1vpSfk4Wh3KLLmG2ZzOvBjRyKw
 K6qsB9FolmaNOK96LlBd982zpoCbZDkPz4P620AlNyOCBf0FunPdybRSsALg8KntRyyVJH2RqQ6
 zBnSvPSM7h9PATnGVkj7bCJ4MYTHJsM1mFe796Bc0jcolYK6TSklhRHCLMY1cMDqhxSes1G88HM
 coOrr8xskJMtKcb2rkQP5frmv24VNVijSdt1DabujJiYMZXEADeN2xD59ScowmXBWMl0FXDrqke
 9p3uH3+B+X+caJCL0bUedeCs6I9PtgqPe8CO8ShlP+s2bbYUBsnSKYZZvhhSwkJxI2H0Gs5JF51
 yfuyJ7kAb8Fec3o+tDEYg+Of8yFu8mPC1m+mYuHoeSLROjo/oPMYBHu4URBvMbURKarHl/vE+8F
 R8XI/aGJaix4up+5TWA==
X-Proofpoint-ORIG-GUID: 365JPMDHlTEg4hn-c3dDIUtpnA5N12ks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170151

XTS is not defined for an empty plaintext: it requires at least one full
block of data. The driver treated a zero-length request as a successful
no-op, so the crypto self-tests "unexpectedly succeeded" when -EINVAL
was expected.

Return -EINVAL for empty XTS requests while keeping the no-op behavior
for the other ciphers, which the crypto engine simply cannot process due
to its DMA not supporting zero-length transfers.

Cc: stable@vger.kernel.org
Fixes: f08789462255 ("crypto: qce - Return error for zero length messages")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 58a6c8e333784af73cd4340814046f04405c69e7..459c9ba6d0a5363da9f6ac8c69b6d3c1a4633f91 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -223,8 +223,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
 
 	/* CE does not handle 0 length messages */
-	if (!req->cryptlen)
+	if (!req->cryptlen) {
+		/* XTS requires at least one full block of data */
+		if (IS_XTS(rctx->flags))
+			return -EINVAL;
 		return 0;
+	}
 
 	/*
 	 * ECB and CBC algorithms require message lengths to be

-- 
2.47.3

