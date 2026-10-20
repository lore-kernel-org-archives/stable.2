Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500443;
	b=r7L+Yf1fGVpVids7AYrSLWN6rDfCILdYUREVdpxqZ9KC0M6HWe3BIKnQqVj9e2395MON
	 VEdoyJWkqqhvNGLPCd4D8XjNgdDQsscDPp/5Z50ZUnHKoLgxSkyBFIV0jBE76LGPrb6sh
	 KymWWvqmcxxlAFT/7HrVjTTQ8bKITeWPENREa6U/GKKREPbadAPkKo6vvjeX6SskdCtDQ
	 00ogXNReKD+Ca3hACuy4nWwIr6A/4tqRD3DGmdd/BQLPoAXeGZIUP4i+Ley5NNpiQz8W0
	 1mU13bAbchxtByTF3QALay2I3pRKARCLnsDKvQFzN4ykKxeKs/hPQzOHs4YmjgWWaQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500443;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MBZ9SltNnSEtWttBakHmryjxyNCeNxHEQsRo4iElg+Q=;
	b=jnSUtEfWdGmYtvmPzjJpI15N6eFcK8lMENyqctPcQQr85+jRzDPCTUGTC1YeTjIYt9LI
	 hhstJdurwbtIJKW46bpem9TaqMrwY4V1ex+cqrR6hTRA5rKMoBjEolO7ZMy0Q52lCtaTR
	 F1NjVe/XVFm0MbddHBTxnsdIQMVrF84iD0oNC5mws5i7P9c8ESl2hQQWroSQqX9hYdxsS
	 02ge61rpW+bvme+Q1nit+uzPTNvn6XkTRPbFZ1h83EKtqHZLesgqurcMUZ/cc7GxgCj+j
	 RF+iYb1FTf4UPDA31+cBwOTIOEUeqGQSp/1hX3HlPe3kA5hEgiPnFQzvg6teH+4TwXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a36XYnRr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZoeRwSob;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE460A2604
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5BE460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a36XYnRr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZoeRwSob
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAxKe51145596
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MBZ9SltNnSEtWttBakHmryjxyNCeNxHEQsRo4iElg+Q=; b=a36XYnRr7DAWLo/4
	rN6kCOdoa8cLS1ozt44HWJVnQJOLobAB92/kAecm1eEP28BpaBQqCBmNKf6zn0zN
	8/gOiWE4VN4Cn4xfnkZEV0WcG4gIk1Po6ZmfF+14PbhKwE7XH/3FBjsIW8jaWedd
	dMlN8eh/V19GCQjJ751c661blOVhbCw7I26hY5/QzzJg0oyuuVB6rbGkq33oEYnW
	Jfe0kSysRWw3EGPY7BIyYGwa/6vPWKtKBUIRTE5LIjxl1WOMvtnS9K63atHa8Xo7
	7mJUZl2NHUrALmLqJP4O4sL7ymSVv8OrO7CQW5HfE3vb1YsB2ChkcEoMyRnXv25y
	PhYfiA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qafn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f3969a2a7so376315185a.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500441; x=1793105241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBZ9SltNnSEtWttBakHmryjxyNCeNxHEQsRo4iElg+Q=;
        b=ZoeRwSobSeR3Bmy+sPSG63v9hvG+BbGKqhU4IIs1gZGeegjjcqd1pilqQcQjT76a8E
         RgJvRVnAc7Fz0OYGVGJ9lJVzh3HpW5j8CUBb9/UMLAMmMd3AKfdSeITmhpq+ify5OvYw
         aXUxuRiHDBGURM/HgxlXnPv7L+LPqVhJJkwIw8ueh4URmWs2VMl+Dh+0wsjUowAbhq4D
         VJJkhVQGNIo7WklgDKYoaqpYwewGd4DqOZL6p4l+ST9jRhZ21PX9tTeFYQdKlblkztes
         BOTSKQMIiM1UEmejJiMQMP28Om7huCKJzGYgiVaX5goK7/gZymYH28skZtOkwrsf1TwO
         cUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500441; x=1793105241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBZ9SltNnSEtWttBakHmryjxyNCeNxHEQsRo4iElg+Q=;
        b=qBTVZ3JZOY7pilfIHCN6z4XwtJ2i40WEEUqOKcAwxFD52TEJNY+ZN8PAf596Maj+aL
         VcQLpnFt5phV5iUm+uGv3sFq/O4eF9kT1P0n+mSHCXRDwFnnLl87rIv0FHhBFBxiy6+T
         XKDqiOy6HeeVJpmjhMOcHFPvEdOAy+3v9k7ieDIrL9w4njkp/HN17lByjDUVMJCwYwBK
         TuAAir5q6cTbhxjuRd+vD3NcfJ/0aQiOe2+dsPYJ8h1TkmeibqbEZBDUNC2m6nvmoiN3
         Uy63r5xlzEimjj+y6RDfC3I7BL3h3wSsm2Apq6eJBne9qBdA/iujjUWLaODeZiVna/8k
         yh5w==
X-Forwarded-Encrypted: i=1; AKwUvBzanGpxkvFejn01uV1xCUTJ6Xd9UKo+MHUbI/J9AxzqdOBvn8E3m8SJX0rL6h+KKjACW2wy3QM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMksMqbfx9vXiiVU02rCK+fvAfLAErfFjlBtqFPg3JASnt23jq
	bdnu1REGhNMR5BfJByyWw+wwXWQMRW+s98di4Fu40u+CIuZv+sNY30gul6PQNBaUfiz8k+0QEiY
	Vr5M1aSkrA8V7HJrO44crWoGC3ITEMtQ2CQ4X1ELF/ICIIHkgco4pguXUAxM=
X-Gm-Gg: AYBFou1XQuUtPmbIAIIJZPpubN/2TDN1UMY7uDjjGaUj0DNbY7Z6V+0mwcmT9OeueCg
	wiKTOgMbuZ6vDuJm3pwdsx+U3bgqm0H72Qb5Icyblil210zUcf+jCzUSR/0RMzxiGN3aU3v6xSv
	Mr3odGU0rPFOLOMIyaVf2uPrA6ZcT5CGXplH4GuqlwhmDCZFqvlcdqT24+Zkpbd7sx/05O/yEgT
	DhcC/oW88Pp6bQxNRW2UwgnR8tZUqnFvkFRcc929Y2RCwkiSgqThRCWMaFah0vXuUB2K0uM+flR
	2ayWgfvgXtUR54OeyCj173G1qP5oLimtxSJKUuOy0sAFdNcbU8pa2/MKtGuF5ufHtfbBLy06UDi
	TPpii94oQhNCM9nu0QLgsYis1P302
X-Received: by 2002:a05:620a:1997:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93f29d4e1acmr1847488985a.40.1792500440870;
        Tue, 20 Oct 2026 05:47:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1997:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93f29d4e1acmr1847484885a.40.1792500440391;
        Tue, 20 Oct 2026 05:47:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm6544253f8f.42.2026.10.20.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:47:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:47:03 +0200
Subject: [PATCH v12 3/3] crypto: qce - Use fallback for CCM with a
 fragmented payload
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-qce-fixes-aead-v12-3-77a2e09abd0c@oss.qualcomm.com>
References: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
In-Reply-To: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2870;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AsBxpvoPqBx8HskvDXDG+rPpRtLziH3BRXM3FeA2dBk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq12LL76Dfs7XlcOj9kts95kgKasuDVb03TksNy
 aS3QKz85paJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatdiywAKCRAFnS7L/zaE
 wy5ED/45pU/hGaIXGKuq+YmcyCr6NvMBlU130xKNXPmOd2rIYdd3uTlIEgv+TG/Zw37DRsx4IgU
 lm42hZLI8S4FvC8czY/bsjC+yvBv9QIMeMGQSirTPk/PZIV/mIZqWmgf+dcYYBQdW3s1jXxvftc
 2JgdT33jadUiO39cJbVEMbIVEwLr+ejcAa2bqAkNAOYKiXxy/h7ccvSB9PKTEMBaBuwI4EIkDGw
 jVfs7UoE2VQKeShPKZ2N7EVeRGusLRVbTDdv+lUJH1PdINQQwuXfM8kVKHgU7/Y+mmrTO8ibdcB
 MH82L1y69BfaZwP/qOpDI4eKgP02YIqeGdAKDR0Ov9Z7ygZNGW+EGsii+3SxirJUGir/39ojsq0
 GJafh/x5kdscIlu0Vl5tAWDM7QFONJHjtExhJb/HzHP8iiHdFSoYzdK5nvfQ/SBQKQeuJ+2Ex9d
 gGmayt0eH/t3WoUH1o/SGjERHQy1AU06iGk2Nzb3lZpQ5uuVfCmku4UfUi9lLx8f1dXyPrqWKAu
 qwDzz5YiO6G694xHfzE8I4gmbvnz2ancToowKcw9R0DKWGs/KSq1ALenGUwv/VmM2FqZQT4r8wn
 YzpsYGPj1Bl9sls1/3YjV5b991rfqn2ddrwGx1CUnOENFNXiqmkl4ztpv/MKSZVhD/GoAkpEji0
 yo9IhgPLxXjCH6g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: w-QvCmeBqGgKVA8TpsOMN07hIgBt4vtw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX3SbuSE487hpP
 hhy5dyJ5zfk69nRuY/nz6pxZlPq5eh1r2mT00iI8NALRvtQO5ElK1iCi6foGTI8wvG8lKkD600q
 F1DdmZnYUe77xiOEpFjIt3EJVsnE689ujKxZTI+x2DjLAW2aTlerc/KVP+DDk1EMk8iph2iuC6g
 xcCMhqNDtG+PL5rfO4NHx/g+gL1JkGoOSodmQgj0pGKGlZ2M0uudjsIH/sWzTrQp9+tg+u2m5Xu
 Vblco+bGhyJcXzgCLgRu3n+uCeR6opCBB455YcvXF/cVCiDQSSmjkZ76LUgZObZF3snNuusg6qE
 bg0REKzof2j9twjB5QLUuOl5v7agCv1T5i8kcdZNcyLbhv1mmJbiErnllJ71YS7Fd/tM7313uwI
 +i41ac+Hcl1VzuVRjhmySA+v5ZCx+DmiA/MujQpIth4YI10D/WYgUCT3oljrmdPIa9Tq//cSXtK
 pNF1Eh5LZGdBpdDWuQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX0Cz29gAsCX7w
 k/EPONTiTPZo7yy7pX0rLk27cSF43ua/cIQZyFIIfLKVT+m+MD0nJcEBXwwSlsEQT0tU16YTmgy
 FqldV7aChROmFX95okTHAeEc5yXLgwU=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad762d9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=phyxH6jkQibGXiXynFEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: w-QvCmeBqGgKVA8TpsOMN07hIgBt4vtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200050

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
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 19d7e92aaeda0df1072114fa0435dc40e1eb6849..8ce1a9f3c9d80ba46d5c074cc3ef45c69acf52ce 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -498,7 +498,8 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(tfm);
-	unsigned int blocksize = crypto_aead_blocksize(tfm);
+	unsigned int blocksize = crypto_aead_blocksize(tfm), authsize;
+	struct scatterlist __sg[2], *msg_sg;
 	bool fallback = ctx->need_fallback;
 
 	rctx->flags  = tmpl->alg_flags;
@@ -523,6 +524,27 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
 		fallback = true;
 
+	/*
+	 * The CE reliably processes CCM only when the message payload is a
+	 * single contiguous buffer. The associated data is linearized into a
+	 * bounce buffer before being handed to the engine, but a fragmented
+	 * payload makes the engine stall waiting for input, so route those
+	 * requests to the fallback.
+	 */
+	if (IS_CCM(rctx->flags)) {
+		authsize = ctx->authsize;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->src, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? 0 : authsize)) > 1)
+			fallback = true;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->dst, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? authsize : 0)) > 1)
+			fallback = true;
+	}
+
 	/* If fallback is needed, schedule and exit */
 	if (fallback) {
 		aead_request_set_tfm(&rctx->fallback_req, ctx->fallback);

-- 
2.47.3

