Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332747FAE6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885491; cv=none; b=C5sOnvQM+GZzJ140eu3A7QnNEqcmEpxQBD4Vg48r7/BCkFBPtU0FjkyVr6I/at3nTjKq5KTRtCjWMxuZ+5NjFX6l3JSBUwuT+Pq9jo2dD+/nGZYK8MwHy++8bPWsqXzH/2doaeSJ33yeTWO3712/nejCLndyd3CEpaaEcQ/z/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885491; c=relaxed/simple;
	bh=10czG1yn2EOwOEpiuflfvi91l4e59NVnoKNaveNpS5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1D7TLp4WUyaJM2LQCpwtqEsMnv5K/f53yDNGayfaDfGYfwlcjqbGrKPU0vY7jQ6rPmnhdwtzYPGLZB6V/k7gLNIM+WtiQ4HHOpBxrJK01vGFMKuVhehw4QxZPUlIb2OJTE4jOCedUaX6x4/c7WILb3Pwcjke6dEtlsSGUPdc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXyeWvDw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cgOJEVUD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXyeWvDw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cgOJEVUD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D902EQ791439
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=; b=QXyeWvDwyJzJZmF3
	SJPq2gpYsl2cjS918L9xmE5rDouOVwxHChyDHK+jWn1q8Cx3239kqgsSHIa5ncRO
	Dl3y5iynJLOI9Zk+APut40MONc3zpOY/T7vaGjzou8O9QbysdQtWVJfRITIX7J+s
	mgOpWgVsPxyWwTIA/2p2Gcdu9m+d/lL5e/HP5QUjyH9qwxeBzSmAlogYqcZ2sVPQ
	PB7t2FyqEchkGT/XqwACDvpZ9ePraray71r9Qgrr19IvaL0O2MstW9pzJsRxyQvM
	TbaQfXPR/6+QAFE/kpzaQXjXHaMdLjG6yszF3zQ+nNwudHEOErYNfV9jQDuHF11Q
	dv2/NQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjr8c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b89614300so35930656d6.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885488; x=1792490288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=;
        b=cgOJEVUDxQZXEiCr2puxnSiiZbzTditHRX06/lo9AP7z63IhxnGWn3VBG4XjHvkthz
         Gvd7yfkIotog9E+lLdO4eEdKpelMkH7mt6+DpiG90zKAKWG4DxJ5I7aXrAtdL8MzAORU
         bbXtrv8efAQY5CQRlZ6T7YVkzqCAmflIyOIe51Xtsiv3XS8x8bBAtKo9U0w1nlgNtylE
         tYHDPO8cbFLcPsq1KllUc0AZjTCNYlcrPTQ2v5a2wzOnPalU1Ze5y19lf/EDHjr4T79/
         GF+Gb3Y74BpNvwHuTG1ioW8xyQhyqIHWYxtXgwsNKnnqNqhN98ssQYZFvMgrJa9trIaq
         ncDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885488; x=1792490288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=;
        b=q46hCSiWpnwHnzjl17j4lGGCAOCQJhuuTzpjYqYBfWdY3A1n3EAwjN0diDLoQj54uo
         yS4emPuz55mcL6aUjxuvi7DWeTc8mzdIwOscmNZEjdtNwjYDlSr/a5TQ8RFKCEqQ/A3G
         O0glsut+zoK/6R0gKEZCoxo+nXBMZqdKTp9/2zJJxB3FWCtBU5poyMw4hJ+Uum6F4lWW
         vKv2TVjsat5SljIsSOsVOEoJp7ycuO+YNwEtQcchlrukEe1fV9rNac/oy/oCJ6vAnMiH
         EgsmabJhI73KpScbpPXTKiQgXl7ObHjh4YM/7O6KdyX2uJlVuFZhR5S1MMfhqz5NxcUR
         jPmw==
X-Forwarded-Encrypted: i=1; AKwUvBxkMaOMnHvpPjsZ4M86zNCz6zwYw4iC4HsLRke/wIDioeL7Xo54NIVHtpGn+L0UylP+57Fo1Ok=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmv7k64N1Cad/NbB4BRX7Wm0TibxzlNLdRYVr54cOegzfQScZz
	4Ebx2vASTbWufwBlJcfgAMyria6SQ4iVQfCGgZTkdc0muuyHUzPZRenI1WTQQytAL6bw/sijsnp
	BDSx7svp6nn/Ehk4z05v6cfLwDOvTa3uZJXUlUlOKDxM6lV/dXAHjBebuCeM=
X-Gm-Gg: AYBFou1ImK2gD793QNDT5coeeHdKfEGyD74FdTSOaUkeByFDJAGGN5Dx2bI7SJsqqFe
	UHeCfyu3TsvElxsaivWYYCRbuLVj3FFTXE1V2Mwtp9yED+clASOoDz/Hvv/pIaUfNgO0HIQgfh8
	g/ThxuTIViUOJELIuM3A1ICJvmMfaOBsWEkZHpNMlqK3KLKIqmr0ObR86U3SRkY+pWIveOXfmUH
	bsz8yOJ1bP48nWkrrzVdOK0fW+mhizLJcBR0Mlr0p47JadqMqw3TdkBWiwDr0AuAB5xlEaquB1g
	oZn3L7P0NjXHrb4iH/9XFcgIPlEq1vfvT1IIKlkmcRBcyNZkdJMBektAo0zbKD23mrohV387zYw
	UXB3CJAGcvvot2RyCeCX+IeRrln10
X-Received: by 2002:a05:620a:270d:b0:93e:7939:43f0 with SMTP id af79cd13be357-93ebd247f8dmr2055647785a.32.1791885487728;
        Tue, 13 Oct 2026 02:58:07 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:93e:7939:43f0 with SMTP id af79cd13be357-93ebd247f8dmr2055642985a.32.1791885487269;
        Tue, 13 Oct 2026 02:58:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6beaesm209412025e9.0.2026.10.13.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:58:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:57:31 +0200
Subject: [PATCH v10 02/14] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-qce-fix-self-tests-v10-2-57162a38a554@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=10czG1yn2EOwOEpiuflfvi91l4e59NVnoKNaveNpS5Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqzgCb+PXfJPflooYW0X+6u/+Z1zoTOjPBF4ifg
 sQTVCQOBfKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas4AmwAKCRAFnS7L/zaE
 w5OAD/44Cd45IorOSGi7mJwtmQ6WdaX6qmUoR1aecVb53vv1qqtm5lnfb1+IN2Dk7+NrCitUW5b
 e1PMnKqDk1SDFB1UP1LbKBvOtKdIcWNTU0mJCeFaLVKyVcAqxM1Do6tEc5BbNE3NtWI2GljqwHa
 qEbnP9Mhlw4LYMzo/oi/v+EY9qrsr0Hhk8g5D7vWMnfdU6zUGkckY/nQftXfAtqSS0cvaeQ4Ob2
 SN70xeId23HurGpcM0RzdJ+sIYZqwbKc9CaTe6Q22uxaWuwc9VUOarSN3dDE5rlMWr+5HNDhQq5
 I+Oww8JDQ0crG12sVqslneavK/nXvcBcZsh9VA8SflNa+1UlWluUkzPKKVxJfiqKNk1GpnTErBX
 NAkd3jh7LRuYX/YGn9M7vWZAhVPY6DC21q1zpYYu31ssbg4b3MKlr30GOYwVFQaGhm47/GhH7ze
 aqz5RLzouerOM2dr1ApwyecmfmK7GLbmrzFKgFDvJP1qlDg/2KrHsY3i+59TUVvqvhqotv3YDcr
 IVoqrFGjxfOGbjyC3zbkwMdD5J43XN3EA+jLJjjWa9CBoqqRJHSyxarR4EsBYLj2Z3RPkE4VAvO
 UwaNViQiK5BnqSagCdpQcbjNwOkH+Eu1mzLEKKv3OKLxKmGJPKyOlsbdq7XAAt8RIYtuwuId5q+
 X3J3tQo3RtNudlg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX1StCZp9QN5ek
 X8ocm3dQ4WG1gIIe5WuMPhmm2eJ6rGW9rG1iRUtHvhmAWmgClbHNmsmX0te0T98VwFoUfQZpOy6
 UdvIwooehCNY1jgseCg4deyQPAPh+No=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX5Jv2/qWQQyU6
 w//Fqad5+6QW7QwaweGSxfRSPybmAxsOjge0wHzxv3gpjQMLyKc/DanPKiAMXup8GAKnRGIA/3w
 yps8YLoSAbF4Ih+5PbQOxWIpsGVYI+W0a0sNkbKe968we5eBt0EcAmlm0fImdSSkq66KOV40wb0
 V3glcyyt7/L4bicyfxkBlZGxczE1WVI3XID62A1EdvFRNldSZ/u41JFVy4p4DdrKWoP+dUwv4JC
 bcjzV3Q1mBRKZum5hfoQbxYg/WsRYiw9TmOR3xQXmC9rrZjcKpecS0L5GDRmPQTevmaq44DGXHz
 VMhFbARtCdQJFdCQFODICg69EDcx9v04opARiqqc9V7ACV20d1HQrjU17FPLcQg33GRPgb8R7jO
 CRJ2uSS6GxxHkKPU+aDMi35rcag+tqp14+GLWJXnh8yk2RLDhc/KWUCQlNir1yevghEH6bg1JHs
 2I8+Bs27pLijaTbFhfw==
X-Proofpoint-ORIG-GUID: ABMjFS0InBUab5EV2AkJSclzBoS-N1Nr
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace00b0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ABMjFS0InBUab5EV2AkJSclzBoS-N1Nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130039

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
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 03a3cec2bb90e8d8c17e491ca40ec740a003d1b4..f177062eb735148561f798d0d3e65265f3235da8 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -222,8 +222,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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

