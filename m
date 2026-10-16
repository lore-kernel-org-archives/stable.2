Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6A4A5C55
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159926; cv=none; b=bBNqvSbp1/UNo6AXPG073bWhECkyaMx+An9mV5bN7PbD1NaOch/c14YZDUeJ1hAUcuqhmojGDXedtjtB/6BMscH8CE3oW19b598ojfgIum+ZOIcRdBEVaV8gQbdeJW1G3a1OFjHhNNSwFBUcjt3D18WIU8J+JCHVAWFLaWuUPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159926; c=relaxed/simple;
	bh=growEXKfL95i1OZPjUOAOaxVU0oFXi+ujqUIx6R/v18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt5mPbRXCx+g8k0i2umuQmlxntDERGKHyACge43Ff7VOYZjpuw/JTx4GbnOjSjfzcAL7hjsfM2OSZMkVmPTBVHOQQOa2jj/PfdkoEbZ3pFb/pdWrF10skQpQxcWNd2NfHWBrqd158WdkC37M6u56dmVR3X64Ho/UXCUKJBVBF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQrMijis; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWJwS0nl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQrMijis";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWJwS0nl"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5jsT1911011
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWBaZNLE2NxmhBfPwxyYxR7jIhcDJqVLs/QSuWULptQ=; b=fQrMijisiW15+juD
	LXfLva94PiPeTaNErMrd6kDWtX0YzBGWNNhC7K54HQ70jVbzJaGiC+csoEHUw9rw
	KTUC2hFRaHjX07oU6/apZCDxBAFBgWr5LuEzVjPFKcp4lDRK8PpDv4pLXTIUxQSa
	V6iJgezvq++oH6uXhnICuSTJ6AGq25caFlgcT3dEZTN3aVmZzOBtRAGD9SYMSeYE
	h+iWPOcv0TXAGhHhK4sMISVQb2DjLSWyhGMEUpNdTUjz7M8tYVtrGfpq3th4LiJv
	vlhyOac7/YzkCsWbjM8c6ezyQ9u7ewcgQfJCIafCiHA+luqUtEaPvMKBOefFn/Vt
	PQ+ssA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf8pbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:12:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bf4c0af4eso203567485a.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792159919; x=1792764719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWBaZNLE2NxmhBfPwxyYxR7jIhcDJqVLs/QSuWULptQ=;
        b=aWJwS0nlPMhVsDlN79l+H7Cd1F0KRJvb0zxoqpLmduJj9RH3CJi2UDYG1QKGnquHvZ
         9Keyl7x2vHvhR2X+6ELMVnc7Gy9SpYxHm4LtF1sX6emJgWVG3FtpbSwerUkGK/PbO0sj
         GMdUEcNo5uxfuYfMoyH+nUtZS/Ziwx7bXJoARvU6M/5ovWT1sJSY69yAnQp9CCpsAbvB
         dwHk3RcbDAdeQdU4fiR9YIpA4Kakq57nHbLIHXojK0dZP2e032OGwOnalA6Oslt+TkWw
         gLf2wAEqTP8ad8BRDnbKhOotpASvzxl/0LI8ZfJ7D9aQm4ZqaRNQ2wfiVVjOmYw+b/PV
         dJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159919; x=1792764719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWBaZNLE2NxmhBfPwxyYxR7jIhcDJqVLs/QSuWULptQ=;
        b=x2ll/ALPstE5T9PJ6uQkwejj4pKdgcH0E4mKcdDsfCpZhBzHxS45qTw6OzDCMWvVtz
         6Fy7LD/plPuApOwb1EUpIgqzV/4YcRFg8YueE37Kn4wqrMZEImMO/KX0Mg1iT3ztq/Wb
         hk9qZDntnXj2bI9pI/SlCbTUP8GY5z3IoGGGvuMmMgUDJLv/Oas3XKSBsAqG9i5nw+k4
         kRRrrQPuOJkedOo5XyQtlfMvMW8qVDkTWd2AhKR6zrW4PZgmTeNkk8kMfy+bL+VBeQT0
         Z7Zn3HkMgHpQhN25GoAo3KAtcvVeiDbidfOm7jY9ySSoZhQdFYXBIPu4uwhHcQMwnExN
         Dfbg==
X-Forwarded-Encrypted: i=1; AKwUvBw2dTZ0QK4CK90bY6dfSaFgqawvwpct1KL7YhMfnQLxc7ZqGVkETp9jSTX6JxpbK3uc2qlCZQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+xYHlzK3AT99WWo6Iz1Kyosz74GpmTQ+wzr6Wdgaeh+7OJdqY
	PucL0ZsuMWRbNhlrUrMHzQfUtFdOI+y2mJ9XAPo3h6TM3EtXfVlM0xOUWGeHLbsemdWorbSoSoW
	MmuuRisBNz0F1fE5FIXRnjs2RwIKItS85VsgWDaqzpH6/tQvW4dj47EzeinY=
X-Gm-Gg: AYBFou0+QBsSIDaWQkb+jLSlc/IHtyDM3q9oCnAmZc/lgNMs42508P7isNx5l8vscbm
	Gmre6qpmZ2j8sGD+FJgWBxl8Vu36oUZLhnAquPVe6ATLrfvaVM8439lutphzmMYhsOd5kYqiyg4
	l5l27RAuAgKRjM+5p0FOsW4xPcFplT8mRaDncJDGtlPjP5opmxhskVOuIFD8oVyWjI4LrK4wvLg
	tED4oluIf2hmvcIenNVa5qq2AjkeMozDguN6ppmTc1QtHM/lqnZX+5y8ocldXan+OJkpoWm36bW
	qVXRI6pdRmGiFRNeHR0zmkXNEIm/dmQyHeG4bO3srsoTZcNbmyB/rgmnmjm8yR1OKKKt4W+BPhE
	PhpCHN+7MZOwoQgbW2UsvEvNnBYXz
X-Received: by 2002:a05:620a:460d:b0:93e:c12d:4ec7 with SMTP id af79cd13be357-93f17fa8fb2mr547497385a.39.1792159919343;
        Fri, 16 Oct 2026 07:11:59 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93e:c12d:4ec7 with SMTP id af79cd13be357-93f17fa8fb2mr547491285a.39.1792159918844;
        Fri, 16 Oct 2026 07:11:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8babsm5760145f8f.33.2026.10.16.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:11:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:11:47 +0200
Subject: [PATCH v11 2/4] crypto: qce - Use a fallback for AES-CTR with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qce-fixes-skcipher-v11-2-d13ddfe609a4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=growEXKfL95i1OZPjUOAOaxVU0oFXi+ujqUIx6R/v18=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0jCoWfLCOU4A74xiIahuAFqOMrVNEEzNe38mf
 H62uAZckAGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatIwqAAKCRAFnS7L/zaE
 wwrmEACo1tT80qq86C7wP7y6yAx74Aa/SHZfhkQgklqsLYyoqNRLy8JFU1tW6LkME+cCWMucmkE
 1eioGn9WgzXIE3ZjRsff5ntnTjgE3Tl4e5dfdCC8W5zluevhP7hZvIG2UAia95ejB1s/FZJlmFh
 dEvfv7429q23bk0R7dE93ZF0ysQL68tYgkxRdpvI2r23QaPikIqra+P/KxtMJi0baWvDgJmHeCr
 e+H00vVnD2/x17xsQoH6nHW6xn1ga1tzOrQFxdWqntd6bKhkY1QdwwkGIDy+WqPvC0G+mHw0jia
 e5ooWHluJaBCW66r8JQ0yErf62x/sT2hZM/5760PvRukPJ1i4y94aA7WnFlhac5s1AosCgfDRtN
 KyOkl1SI2xpcZ34WHrbdEHv1B//Azq5bq10//PHec2M/w8ZLuJaO2MCMWloVPK/B2TpETTnCx7i
 SvPnv0OUw6zOAohpsJhz2g0Tmx8i/1MA67eoDAIR3/+hTQRlK2h/x5bd8PwcLu81yS0O6OS2HyL
 a/UphkjLDbmQDkfqqkXxNSuldiutFm3YOKyq0Y0AhC1TtzuNZbkbXyOt749/GC6f9Flzn12QWAo
 bzS4pi0B/csm+8+29uusXxZTVt0rONyPonhH8u2TqOv5nIwAXMSmWb5cQRYowkx007ytwB4CtIs
 Zvxqjwdh+2v6yag==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: _eILYjfKSy2FkxUDml57t5gGNzLksRsn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfXyI9YWtiYdqI9
 7FVAO2QeBlCsFYGrtL788gpyfWUtsTiORt1zLXfEHS/cvjhIefuq5Rp0E1pOnw697sqXGnZSt9N
 Y1rooAwxYJ2F0HGEbyJ+FY45bYCp/Hc=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad230b0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vUpbTSJP45I4i0_vGVUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: _eILYjfKSy2FkxUDml57t5gGNzLksRsn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX6YXTEEBTFLP9
 6rLBumE2FdF8pzVIRlqleHZ1tg04hppqDqqH5Qry0l2ZjZEinWnjzoY4SX4JBp63nh/0fUbkwKd
 sV/37BxQLtYejDb+LEBE7kQPf3FLzvLcu8zDrqewUMjlJFhFvWbCUDoFfgX+jAr7SGR/FbweZmI
 qbR6IdPGaj38E3qjNSxfNMW/qrHF/nxXSG5Erh8MiXPNucsAXk+J9myVNJkxP8Ilqtud9Ezyh+g
 nYZFIOH6D0fAyBvSmkkCKE5dmD5KPSxYrwBiyrhN3jxcbqvMxXgJuA69Wkch2H+P0q98VIjsAMR
 ByKuYL5Yc9nMkq5VFIQxNxpVq6PRsPrPQfeOFgU4Ml5VkQx/gVEzSvkee7AuO5E2eDf2BTptlxy
 e995tNmBjCh/QlCWqKdW97Bi/uCO1w73kDmAvvCB7FnnX3mm/Tya1vmqEoThvZjmHfstj45C9fM
 7fpw8NYj+AmINW2OaZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160056

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
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index f177062eb735148561f798d0d3e65265f3235da8..c23ebc61873f1c542a4b475904c3c3a3d89bcc35 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -244,9 +244,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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

