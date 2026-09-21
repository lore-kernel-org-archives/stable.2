Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6F49B5D4
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995536; cv=none; b=ZZSbl06D8tVfAclVyQhEC+yyRexOx8tySklhNXw8fmhrnSv0GqhE+fTywqoq9gEvaTR8PMsmY+bPAyiZ4E8v4BLQax3eQ1Ehf2X53KH9joXNUXWrPCGx2VeJDB4He44w/c3BcJ5jfK05bJlxmfR+NYrq8Ngaf6toiHQVp3JCK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995536; c=relaxed/simple;
	bh=bR7rcpx8onqzBSepmnCRtUu5K6IkMCBMdI6sMN2Sg+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGxLVSC20wnpKSS7kbi/QIOMiWY3fjfu6nFfiRsrBa/c9MTPnAjWm8HnGqJVdDlF0rLYwZq+jSv+GhzvVlYIZI1b+evJyYD4ARogdhUQztwUZ1+1cfvtgeP3AwPQiiG/dPV3MkZGvVHkffflic2NSZJqs1bDRvMxCfMOk/xU5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lhAMprkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YUmedBtm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lhAMprkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUmedBtm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdxDx1563459
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y8KgtcfuuaZKDzeqQLlE1f7UrQdF8/SBl/S+AsYWcQ4=; b=lhAMprkZ5Gd+p2Bl
	zapGRykvf7aKToBxc8zGNoaMhaBWSB7L2eti1GKQO1p1txhBuow6ejUZZ1XL9eBr
	/FWu2c0eyBhxHScIFHpIrC1+NW7y3Wd1KSuG0Lnuxwop9jCFOl8Sk7lk1GlUvizT
	5MEee0gSkgZU4CO1m0ygK8Q8/iRXSnB5PLtiKwEfEvGtuTbei+T79nS7/K6u+BpO
	LjyqPGy6FLGh/P9b56TjF6eOAPR2Gn1jkoc/9k4t8ChMwH7bvmFYh0xQmC4L+Yux
	mQ0U/ur8lFHegpfyiRV+GLi0hwglZleJanjGFvOL2lJ2j+rvStGzpTdV8eIk6Nv9
	RB3oBg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw1c2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939f3426a7cso598493485a.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995533; x=1790600333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8KgtcfuuaZKDzeqQLlE1f7UrQdF8/SBl/S+AsYWcQ4=;
        b=YUmedBtmCXz7UWY40CZaWhGqi1IwgUist6GNt5C/oC0+JOzCTkL7UJYoDiHDYeVh1G
         YT9ArOl0PRDlP1SWMAkcu2IzJhjtpDq16RCu9K6M9Ch8Nj+ft0iW9UogX7jp1DpT0Ilu
         M1gTd4MbxveHiYdeXs5ppWLTCdARMnK4PY+69IKk9q82paFcZiGoxlFO3GwcPqxntMbT
         bEdRxCsEhNfGy/q8QO2lawh6OkshIJ5iaEwxWeaNkl4k6ACRNGQTr/eVXWnZ1EPJqMiO
         Xdo/Ib2xPI8FHjuecF15hVBCkEQoQ/4smAhOS6ptAu1r83VXyNvrc02p8gFTF+DWivAO
         8Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995533; x=1790600333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8KgtcfuuaZKDzeqQLlE1f7UrQdF8/SBl/S+AsYWcQ4=;
        b=swprlJr9pJLzxrn/4VHR02hbYPn1uxh+njYko1kbFNLE24Plqq0H6sq08N3ei7PuoZ
         UbK9hdEkUQ6GCi75NvlHG8mF6y90qie7CgoqY0Ov0E8b5wSWFNfnKvIE33qlTcjfFdsp
         Aj3TX/p1Hx8/Oa+bxn3z7F64+XVbdS7GSq5ltc9x14d35CP2L3wqWMnivIkxdhpd8kwP
         ZOpj88kx51v2smVtlfZK6k9GyjeDBfSOatK2Q8svkcVLe0UzWuJNrDF5e82q1wyD2OyW
         zwaqGzHsiFH3MzMNe06E1FqwnNBSuc+ekAvHjmQE4faw8JVxetnI4DIdELHrkD7Yo8Hm
         RQZg==
X-Forwarded-Encrypted: i=1; AKwUvBxBu1iip1Oh5NX4QqtJNapojqilECFLSNFqnXSbjfpfIX0K3y5yebJJho112PjqO0+P8XJBUK0=@vger.kernel.org
X-Gm-Message-State: AFuF++mrBTsPh7e9iG68RzYNMExVzOXLAq/yBArARzJjDPOvU5LXT5+X
	CWe9v+wYX6bGhhv9v9sTZHs23O7WtBw2SFMvqGq8Js1Fixv1w7DQJQc4S4isjvDvB7RLo+FVoct
	3lCUDoyl9n55XaROIWWRLeqwVkIBOgWJH+mfuZO7SdgfdOb2imgSp1ci84LU=
X-Gm-Gg: AYBFou1zKrquWKB1ReaNgWZl3iddhlItc/ERa1wyYVCLWGrh9cA8wAOmQi2ty7pNLDU
	zfSjMcUI2nXW193fEQ9S7QToaR0jSyr1wI/NGhOs2i7PwCYwetSH++VGHJ/7Ku82g74zNYHc+5p
	vO9Jg5uNyS65/2mVuhqqhUNrx9co+fokL4Q1wR8rI+t+6T1YsWKIMjpAKZGMwAvjQZN2pZfRbEH
	9UPKmV8tLzhiqfEYXeFdROfWTIZh5tnkw1xZOSht75zqtiiFwvQG334cEeC6O74w1dXQQdZlu7C
	EPumPxAy+WrjJPDU5ahKlQ1W6XaEvKpQOBzQ2PxXiq8qcsOIi5X1VZIMbfa7KADRr5Ye3rNac2T
	cHP9liZJnxeFZNLIDJx6v1zfYib8=
X-Received: by 2002:a05:620a:444e:b0:939:1864:343e with SMTP id af79cd13be357-93c15ec573amr44086385a.40.1789995533453;
        Mon, 21 Sep 2026 05:58:53 -0700 (PDT)
X-Received: by 2002:a05:620a:444e:b0:939:1864:343e with SMTP id af79cd13be357-93c15ec573amr44081785a.40.1789995532985;
        Mon, 21 Sep 2026 05:58:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:16 +0200
Subject: [PATCH v8 07/14] crypto: qce - Use a fallback for CCM with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-7-107537869a72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bR7rcpx8onqzBSepmnCRtUu5K6IkMCBMdI6sMN2Sg+Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnvHJiGUrC4aXm7TleNYXA7PepLc1wPa2hbD
 kfU5yixVxCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp7wAKCRAFnS7L/zaE
 wyk2EACJIdLOHvcyKrgdEHuj1c7IJ7Q+gb7sVEzM9lLn1SDswRn/fWkqvqJIpO3P3/NmM5EiaOX
 Hw5HMjEzPxRSMpGluZXC9d4j+amGCaC9uSisPhcO38/tndUG+3Bv3+Suv+aBMQfjuNxGQrReWeK
 TzOQ0eHj7fjm/pk4/dkJn9boC4Kf1pWZVzokY2kxTTqE6FBfHlSuoYO0Lg63q4YniDKhAe8K71K
 3gbnH/bxR1O5Z8OGcBTTzLHFLmbX6vR+zlW8WA3x3W5BOoPimLPqSNA58odwNC6ttl1jQM9qFdc
 cmlXU7do70hYcmSlWZOZw20Q8sPDLCtB0aNdweicU3u3yZ251YGg4T8cDbuzqEgoXqZBOBTIcZA
 rK8YsY9G24xcOKbTCk+9+cFFuL8tbE7RYH0wFeN8sVz9Gdk0HvIR8BdQzYqstElrUGYNSDzgALW
 mnc9dLC55W62VhZS7LE6RkbgZlo/bpnQQ/DIiJYQCaSQM+mIAbrrQZ1Qan3GNo11FVl7PVIdZOx
 cmikZoEA1wV7jbfNXB5iUPuNxZI3ijYJe69hV0GjdUCtBHZYXIBxmm/bMhT5FGA7o86xY6B4jP0
 98qm04tPUmT5nGQLery+x+PPVyjvFqQuwKkDg8m9JoPAy1rPhTggSW45Ymtr6JHadxSumNfBEcM
 dkzb+N+vlnOKt0A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfXzA8dLDI+5E/D
 4BtqaTfGTmEaMCv6lJ/w/ZyLIypX0z+qqjiBDxpRkD4LCTlzbefzMG2dCTd5il54UWzu3wMWmCI
 ZFtDQqjssChfaV2bB8FrE2FabQmDU7coee9f7aYWb3MulvlrJpwKWY6LOqm617HcwsTJrv66gvz
 Kg7xzKb60Vozfh19ITS2/hKUa6wGJMZfEZgucEJB/7ETFmctA/uex2c/qvK3qKEDLLPjPB8DftJ
 BQ39kM6S6WcM0o7zn5BIwQTP4bSbj87fmm7iuLL3UGHqLYE4m80PBexSRxGEMSkb9EmpcKdg5La
 eK21chDkoIXDAipgO7vude4jMvLlMGpMhsR1cCET8NW7pfGeJwjVJWS16VD/34KeWL3dpYFHBh+
 2DtiDp36yzWx+l6e+jeO/LlcRFiMLiML6K6J85Xh3SR+6IoeNcRCJUJsvUxhR2M4NabJqkHOGH9
 TcxCh8PpBoX/lJItGPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX3jXRLF8G5HPD
 1Iv9b0bh0WfIAM2PKMBHydtIv/HfKh2dn5z/rycQZVcqe53oJ2L4CLwEt0ICgg0ytj5stSqCWWk
 Zgr4g95xZ69fAbYXthOLCoc4HXpK42w=
X-Proofpoint-ORIG-GUID: 4g1ljyTRTTxmhgeFZvP5v3ILCk-q49Kz
X-Proofpoint-GUID: 4g1ljyTRTTxmhgeFZvP5v3ILCk-q49Kz
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab12a0e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 2324aeb4d4d90f30f999108be00a0d98e4f67b43..dad2478bae0e2aa70d31c5f3c7b37003e9e15e2b 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -514,6 +514,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			ctx->need_fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		ctx->need_fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

