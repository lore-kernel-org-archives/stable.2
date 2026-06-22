Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6813B47CD
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134321; cv=none; b=QH2mqSQHT/+kzsfWBoEgWBvgMSRonvqowpvUUABJlCGlRAhrX/CjzRFvV4/QAOFwiq6ZZf7k1d/9ky9ks9mQSqpJfQpFElmAUy2XySOH4Qzjea0A6UXES/3Fz5PcqOsuqLFO4gdjeDwHs2mrfXgAfFxdp5WPjDGauFMCWFQekY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134321; c=relaxed/simple;
	bh=c+mrubN7rsfOnXUrhAmKfIPiEiFtp1qvBtE3BukFaZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jeSioCyuCa7hfbGovLovPUlwwhKT+wTSGaZr0WCcCWLKfcpvbyQegltrf55AYTKqEXfQrK8iEKEajBxjIJumVTC4S0YpsR4H1xdl3Q7rxc8Za98Q5v2pM+KRVKycBEDYycIUjkKR1nHpCBs7D3I0xImWDa2LGvSjYn0KGc/mxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gVXBp6uT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fMRnXkv4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVXBp6uT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMRnXkv4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGLnu1338648
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=; b=gVXBp6uTrK1uioIt
	z7QW4e+E2mlYwNiY26sj+jzsRolSEDRngNCyUFTZPrmkPXNg9jRBV47EXxRl7VRH
	ZbfDmyfFVcMPopYczGuYuoW0aEhkyFS6gAf3KPK84WVoB8byIsuxgNHiY6r613T+
	tUH4WMAQGWwzy7cS1bHilZ//dZqME+LCdFQrao/9oxgmWUt/Frwkavg6mZ9I7Kh4
	a7QTRlrGGcknQfMZhB9oo7+gLRS2EApTIjUpFaiK89IiXi6E8JWz3OEl38lasYhz
	GHuUc0VGFNdjYBPWE9z6F5/7ZV02k8RUDQs1yw9ZE7xWXLyYf25vPXWj8HHedSj5
	aFosuQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h8jnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso3211285137.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782134318; x=1782739118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=;
        b=fMRnXkv4qNujbOJeFr8DaB9j15PaUJsJGCAreVmfZwm0i5x8JgG4VnyTsKq4oe98kE
         aGs8r5HsXSK7iQUfbnQGXcdB3c2xjP8AXpI9gSqaEA51zyozTMVjKUHXjdJX8sttew2C
         fnzHbZBqUxzb/IeB3sbE6/WO/l34IA6Eu6rV1jW8HcyES6Evx0Itt43oQalEiRRQLR3R
         QzJ2yLSX7l0n4cNdaEh5SU5ZTOoBeYGMKQk7tIhgQkgOlIY9FYSBnTECanAbCn4cDUyi
         Nmmb4da65FJ6YYZWO5qs+8nmPiVVG4I7vbi969JdQjUC9iyOaHsGhfNftf7dQEV/cDce
         /iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134318; x=1782739118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=;
        b=W5vzbn1X6sCy/6zMQ/xosxMZdUvp6OFBFgRe6nANyip3y/XSH+eyOBTiHgNbY+E1mR
         6JghoXrNcxunq0GkDag/7VVcbnQCl8W/Ij4TwOxyAAk6JevB0BziyUuhmULQ+4+uwOQe
         N3JpH9iiHcMrainCqmmJ7pezHqe3g/d2G/X1cayT6NKIm1Ei5QmS/VCRFDXGCIC1hQki
         ugU7rqQbuvc0/l0/2oEkZW6aVRRjpJbHae6KvWU4IYeV06uCTgesaKQEhq8H5i2+Tf5Z
         DTlRwhmXGREaPmfBO7POFSlzziUDwWUTALAbi/taGFGmHYou+V3facVY1IOcIqaJgDbG
         DCJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CE//KUv9+uC/QwgYkncxK5Gy6ZpDkaWQDFbtjblqb1QgfV0LWKgmkai+A56nHjxjNC6C2jX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4srjIwryRuvzJ5SvqsUd1VaywY4vD8c8pCkRDMNYge6XpH8iS
	Dp84H52ZjMUpzEEDIXuHV6VE2gPfzj8sE/FN/Ft7Op9Z6oRzXYddeEP9w3URUNTY/3/aOcRkSX2
	bl5s2t3PF4jdRLOlUkFDH0iMfBdpaTvidLFDL7lPYJcMhB6QO0rQ1TOy2D0k=
X-Gm-Gg: AfdE7clXl58ijqMWSRLvgD4SZjAaj4v9cOvbII9n4srlF6dctW7VW5QAWQlpT+ivTVO
	YKFg6v0sNBRmmNO6NWjPMvPxwKM4pghovRqaMZPHEpn3EbWpaioncIkjyZgt7lcvoZxCEa/gX+j
	Ph4kQodrP6cqNrxC9T6Paos934U8kXxz/9o/oZnjWE2OVE+sldvwkOKrHw9nJcTPVbco63w9fyr
	H3jKR3l3dVQaiKs6oLGlEw8Dq0lzhX8EowKEz45Tk3Gj+L7KrT63hJT1WpuPIXp8ajukwL66gu3
	XrpeGr7ljOfGfnhrGlTb5JwW4uP9K9pM6q3+T0K5tg/ykAa6sMGk1BIvKACh5rxo1ugOzW5fjFB
	dR5com489vRuhkA3rvDYCSiydN9jrvhvA4XRgxfhH
X-Received: by 2002:a05:6102:548e:b0:604:f849:462e with SMTP id ada2fe7eead31-72a78d9227emr6430095137.25.1782134318467;
        Mon, 22 Jun 2026 06:18:38 -0700 (PDT)
X-Received: by 2002:a05:6102:548e:b0:604:f849:462e with SMTP id ada2fe7eead31-72a78d9227emr6429685137.25.1782134314901;
        Mon, 22 Jun 2026 06:18:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm294083835e9.7.2026.06.22.06.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:18:11 +0200
Subject: [PATCH v4 3/8] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-qce-fix-self-tests-v4-3-4f82ffa716c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=c+mrubN7rsfOnXUrhAmKfIPiEiFtp1qvBtE3BukFaZ8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqOTYdajfJ6qLD0b2DQCgJ3NCXMHH1ZjzGsVtuI
 6P9oyD3r3eJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajk2HQAKCRAFnS7L/zaE
 w0MjEAC4TLJz1Ej68xBsNhIVa68is1as86eop9e2v1TD0+VSDjpYasp+cI6ZHukN1EE3rzaYMob
 rywaUyaGxf+sjYVUyZAnnZHm8HjOYPX1zME0JKp/zi6qwXTnh7whtFBtQf/xAqF+KRJUgGBC3U6
 yMsGA1+ZydV0E29eK8nA8BCtgooifXRHn0FWZt1tKlcRaywq9Np006Jqav0qpps3js/fsjlP/ob
 iKCo7ss+JEJI+L0UpzbOmCHRoL2U6Rzg6rcYI6gPO1mkEavJarU/eUG0nR3nO3oYQOxcf6ZTFqF
 ZMaXSWpgXsaQNXGljPeLVwg7mdUoW5Pc7J4bz++rFbKJaqYrfi0VfksXDNBkJ9h/lqOXVRiZeld
 89SxofCKk7oZufA70VM/OVLOEN8ZMH0TOAmMGYwGg8GeXgY91vUYDzGfx8W+oeGJYjERW6Ok9vV
 0hx7a6LosI3soYJopKCqV+SjEHRM0L+HHgZit9iLbJi4SZ1k5TU0eF95IyKOO2vkgs2dChEs/2M
 kesrl1IqngEU2c3CXko/gH6InTSUCH0Epzj0L6VBHT1c8cFmXrL6+sMcE+1lOctKgVyuONGUvXQ
 UZZiX512AdznXLGCDvQwWdPpfcwTSxnDwM36NqEnXXzV7f11OUvo3EQvXo2msk5Gup048ix76kd
 RF9chZxmAm8uoxw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: nqZiDjwfwXSFBfIPETQmUHVlHv5wIwDp
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39362f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfXxekmTmbarhjQ
 TQSJF5srhvBFVlYnEfgY3YHF/LuvpfJykxJbr4PG7i9rt/e2iRZQzyNcylhYB9Zuebo5+N6CwKR
 8bEFwRj44TtrqOPE6fBmY31HJxTdG9U=
X-Proofpoint-GUID: nqZiDjwfwXSFBfIPETQmUHVlHv5wIwDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX3cLWqD1gutOV
 Utf3MkCQC5rgCyVoFUkwMWjy0aj+WZatZ02tZR1OuA++eebAb17VbxBwbZak9/nJingy9bN3JQN
 UUdokSYibDXPegBZ7vP/o2HYv/DylLCNgMNHA7eEfO5gIsOaBlXuaF/dX/DYTt+JXfqo03Z6+nf
 ez5GPokfiF8a5VqPeqLBVtTX/WdEhP2ADljp27f/5EXKhXeOIHLKgLqvLCC18cezHoDCAIj0Kjn
 4XLJRsOrM+8MBsxJVqQbOXEMyY5kxoKpv4Xqnxpbd4rMU1WpEEGmGmnrow5Uroln0iaxV4wF77Y
 3cBrJ+n/4E1qucAJbpTW087y7tuUkhQXQQpldBmTD379EbZf9QWSsPlasIqFZAuCPLrHDKfeH59
 ffdd9GatWgHDyPwjZt/+PCGD7rg96ugwS4pn9sCiHASywLO8kkvheCpzQBgfChrSt2JAQsE7lIX
 vPG4NBZdP1SRMJbhlvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220131

XTS is not defined for an empty plaintext: it requires at least one full
block of data. The driver treated a zero-length request as a successful
no-op, so the crypto self-tests "unexpectedly succeeded" when -EINVAL
was expected.

Return -EINVAL for empty XTS requests while keeping the no-op behavior
for the other ciphers, which the crypto engine simply cannot process due
to its DMA not supporting zero-length transfers.

Cc: stable@vger.kernel.org
Fixes: f08789462255 ("crypto: qce - Return error for zero length messages")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index b27008ace93a8a40c291d564c3fb9d73df5447ec..e1f69057607fac36e8b4bdb5dd9e62a2aabe5f50 100644
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

