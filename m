Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE69409135
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538630; cv=none; b=P/7BI/4xcKiazG0lyiE30YjfjeRATwgEwH4V2nSqisTlEVHi3ZfclqT7L+jJV5p2EXwehT6dL3gy7pKSJlFo9sXZXX9pF7FWPPQz9/8EVQ5j+2MfHhoMes6USIAl8tCjhmfYh+tKmT/pBHBLKX5wqxJfEo7P7J5R7zb+U+iErWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538630; c=relaxed/simple;
	bh=SGpiGMPoMnJW8OsKM6YbK2sMApDpA7GM7O3oLvyBQys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pk4TMZAePsp7SwnIwzwx3MtFU/6w8JIRrUeYtkd3wMfiQyLnM9gFwyfplEcVEgb5ThwiIqbbT+Gkzm4PnTN/R+Kx9GPwdS8qsr9ktznPXxuLFuCNKHDzyQ5IotXXwJXZYSODmNDUh7ZNAE/WFL7UETmimgv1UyFI8sb0vPbnVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TdJMSSrM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UP42y13K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TdJMSSrM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UP42y13K"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhNFh347111
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6sgKQfIbcheNzVd3O2AIimrVboSNykNJD8xRHhAS+4c=; b=TdJMSSrMO9k5R6Dz
	o5xPN88okf0ZEJs+gP0BjTdE5OOqhvLY9PN1zjNXRnoLt2GAlQU3MFOqJwhEXHoK
	wYhsSH8EYWrfnpJqNGW6wIqXeF3I/uJunW+EPXuIx2uzDaQQJOLxaPabshHNgBY2
	RnxGfjKKZe+eWZpS/aenARlHKnchxQM5wqWrBqnjOEP12blZvgs+NJbhS/M0Ap3F
	xiU2PviYlGX9rNY+JZsXzDp5UtFLfKOGBC8ghv1m0tcefTPEzonMS7+nx12CerHQ
	2T1IP6B14Pu32mh7VGj+rxx/GinX1hL2x3FApUsAHl6LtHIVJZA5qRc7QoIO7qNL
	jZTZVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjsk28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so356510085a.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538628; x=1782143428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sgKQfIbcheNzVd3O2AIimrVboSNykNJD8xRHhAS+4c=;
        b=UP42y13KmdCCjsd7QocVprCC28sSCGxxbdP/fy1uRVXaVrGTUvB+nXJ9bSi0U1hBEh
         u5yRUJJeTaHRZ4eRZbFPxQSYimlgq9W994Xwtg2Sv0foIWpYElM6RY/CO3xPioaMW4LK
         7Me1FFIyAhQ9sGNgUFkOzWT9o0L1IA3thulL4v3pkVj2UFoa62iIL1ic0QPK2z0phTEJ
         BECuve0oS4ph1Jlgch19ib8B4nmGXBv9PZb66/e+2pMwbk5ffM/Twd7hnUXQ2C8Axrru
         vVM98mPrj5KPn1Hm0AqCRf1pa64LeuiELaN7r40VcXbwW70B5oMe7081FI69JCgjsWq9
         yzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538628; x=1782143428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6sgKQfIbcheNzVd3O2AIimrVboSNykNJD8xRHhAS+4c=;
        b=N0VljwUtldG+psHofUz/277STU3hLDifID7anl4DXmz0WtV4h5mDgrke7I/w4NHGbE
         Vfd1TUUTIXHY2Ht9ch3pPsO7JZlxmUk9jmj0pzeC2PaVbq0EHXIPi8j4gzo29+HAdkva
         SbeOGvySNHt76/V7Z7e0N86apVCUk9jBneSvkkMYiv2Y+jmO7yNellZWKk50YjmoyNnQ
         KFKWYADCgw/s9c3pgkXXFdwwVJdKn8RuSrHtuK1Qsqa8zGFOS5p0sqUtIQF6iEyXTgcB
         GxFvDwojxyqX6rDZ4yahkepQhr9tHWruONzSJfCAqRs9Ztb5dY1oPBljpSsvSoPtFmZQ
         fYzA==
X-Forwarded-Encrypted: i=1; AFNElJ8mOFrEui6Kd0A/4/DYx4MaE/67l3wuJU6+6TPVtCy1vAQ8UN3OJ1YamakeEbMFw9bpmbM9S5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNZ41EWB3xp3w/8uUd/QPzT+P1kGka9nstOYo5o+lmiD7M51o
	SYpQG/lmDY/NsyW7cNzgdsBFT9Ww/UP5aJbwx11YG9ezx3Qv/Vni/yzx5djOSH3rE+835By5aAG
	kXzAHpSMe6QWKa3M75KvD3Rv+OOmgOZQ6nhp9waClwz926g3t6GCWOxzWy1G2ZfU2q8aCKQ==
X-Gm-Gg: Acq92OF4ZhoyYK71d5MDEO1LQd/i6SoknrxuqTYaosRyBNtdOAI/mLzB3ZPTLoHajks
	/nPRX29qRPH9vuuoVW8nBdU6zPgS4uy32urNmNq4ofK6qifIouGrW+iOCa8s55XDxseuK9eeYse
	IqocK7dwoQworM5pcG2jNWah23/gSc6vqCaVv39FCANxJTesMZypxtVijyh5+TeKb3ZWll8RHma
	t0E4DUfkNOfuG0N5S2Wfh5XM/x6xPFFldH4S8VU7QkdrtOlm/lxW0816Sv7klZ4/yfcOFYGRsnv
	hW8KP8RDjfGuBOLFQ7zjN6+eH6I7duZxGXFRgQliFKxKzgLxxyzvSsRTWN2Zxq5jWq6GTgkLPba
	kiXoOGFWWYJsYW0r97VVAYIiYpo0fYhiru02jXhMQf/MEizcbqdQ=
X-Received: by 2002:a05:620a:7106:b0:915:a953:4b93 with SMTP id af79cd13be357-9161baf5670mr2274026285a.3.1781538627398;
        Mon, 15 Jun 2026 08:50:27 -0700 (PDT)
X-Received: by 2002:a05:620a:7106:b0:915:a953:4b93 with SMTP id af79cd13be357-9161baf5670mr2274019185a.3.1781538626936;
        Mon, 15 Jun 2026 08:50:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:49:55 +0200
Subject: [PATCH v2 4/8] crypto: qce - Fix CTR-AES for partial block
 requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-qce-fix-self-tests-v2-4-dc911f1aad42@oss.qualcomm.com>
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
In-Reply-To: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3447;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=S0n3FvtYweutMZSxJALq2DQ3CjmyCxFcNrOXGyJ+JFE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB8vWTxT6nK9U6anmrJqcFiMjPqzFfQpNqOUD
 5ZIdIjDEXiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfLwAKCRAFnS7L/zaE
 w5WJEACsEI87v3YbjeVgMti2J5cFz4Hd9oJCvqnot/2jl5P2OxJUb6RJ01yOawx/Oe5ZS0llkRy
 FJdJxUs+OL+S+KKe0H/Z2BJGDHNDAQID3twnLnL49jrZ0TYZki82H/AfpL/9og4KJhI3ON90XQy
 X6Q8p6f2thoRf9J1fnpnhBNATpNNqOzMBexokOROQcs8Fmt3nn9+kQPJ5BdecjtIQt9WleDloGG
 Rzx1fxrtpqVyrwwFS/7uWVMgep4iav8ZivIeuv9PC17Q85YxyJrtGSkkjcn2lNI6hCVdylde6/w
 xPhi+7VK86xe6F9eAF9bPMl4g3g63fnxAK3kXTFHRApAgznEFQOAa5pZzAiEaviQdKZMYZxKFVL
 fCqcxGms7i3Rk7w4SoNoU8BlvifkRbqpj5obfqUtO4f+23NF9cp7xEbM/IYYaP8bd0G7w1A6PZi
 zFybf6V0BvxwGO/a2Pc6LuTtyX1S4hkN9ilymDJ6Ny+H6FrFKPZDNNyPVLprnFLpYxHD2PSRpW0
 VjNk1Br7vflvd4mJrmdi7uqjRkNahko5DaY88ig9B2VFRnvNJXhufKjHlz3P4iO7TBt0gYAFKzz
 LlWFQkQWUPjIt9nK6p0WIFBUeZhJlKqqhUSiHPRv3O4b9K/Ifxhj3vc59xYTa6CTNuGbaNlgcYF
 emGZ21I51dtksNA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX3ODN+EamIZTx
 CJiljbtQrtVKF7Gy+0YZoqRpwRaMbNaGgLEbJyCN0xOETEy+7AH/EwvZsIFVAQp9loH6a9cw32w
 9k4UCeK3Kq7Sp7S73BvtDfqxjx/NQrdB3Eo8wc/VVV4oMC/R2J4bdvmwcc1/SJW3h/1v7+0MXTT
 0G6c4kd7b2CjngVvMQhb7zSBO7TiRxBzGhO+VcNlxKvk5/2yk/EL4bBnhzKiuT86gBoLFrvOZ6I
 2Ma3buYQF/16xnoNoS3DH15NZXBiGrT5Km4zZFCKiH//hhTPKRCYOzgZ8DDBP8+1tkPYbxeOplH
 /IlmQAyAD0uQTv6IQuFpZSX2w/3Mep0oiijMy2yguTkgkO0Btt3GOJZdmp7Mz8+vLr7DSONK0CE
 VuH28lSQIqOlwPzdocL9M6QVwxm2hZEH//yOFbqEFweH23+SAqZJfcKTQ8OWa22WWrQHWSLzPsF
 4JdyTPtsc0CgLHrNa5Q==
X-Proofpoint-ORIG-GUID: 01Gakc1Nb9yv0FX8_MdIw83WaXGiYdMf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfXxlMll6ctKIah
 /crhbh56Dg64QuqSgClGuho5+TauVSD903uDUYDiJUw09KwwKOGy6sL+L7dhYcOnF4amPw044P5
 mSNt3oLIdi007CdtoeOj8IVPWeMdVQ4=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a301f44 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Y2NcAOke46LZopEJyX0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 01Gakc1Nb9yv0FX8_MdIw83WaXGiYdMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150167

From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

In CTR mode, the IV acts as the initial counter block.
APer NIST SP 800-38A, after a CTR mode operation the next unused counter
value is:

IV_next = IV_in + ceil(cryptlen / AES_BLOCK_SIZE)

The skcipher requires req->iv to hold this updated counter on
completion, ensuring chained requests produce correct results.

Referring to Crypto6.0 documentation, Section 2.2.5 says:
"The count value increments automatically once per block of data (in
AES, a block is 16 bytes) based on the value in the
CRYPTO_ENCR_CNTR_MASK registers."

QCE increments internal counter register once per full 16-byte block(for
ctr-aes) is processed. In case of partial request length, the hardware
uses the current counter to generate keystreams but does not increment
the counter register afterwards. So the counter value written in
CRYPTO_ENCR_CNTRn_IVn later once read by software is one less than the
expected value.

Crypto selftest framework capture this scenario with test vector
4 comprising of a 499-byte payload (31 full blocks + 3 partial bytes).
Error:
[    5.606169] alg: skcipher: ctr-aes-qce encryption test failed (wrong output IV) on test vector 4, cfg="in-place (one sglist)"
[    5.606176] 00000000: e7 82 1d b8 53 11 ac 47 e2 7d 18 d6 71 0c a7 61
[    5.606192] alg: self-tests for ctr(aes) using ctr-aes-qce failed (rc=-22)
Expected iv_out: 0x62 (iv_in + 32)
Obtained iv_out: 0x61 (iv_in + 31, partial block not counted)

To fix this, just increase the counter value for partial block requests
by 1 and for the full block size requests, don't take any action as
expected value is already returned by the hardware.

Cc: stable@vger.kernel.org
Fixes: 3e806a12d10a ("crypto: qce - update the skcipher IV")
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 68b83e3ae088ae42a7fb2a2f0c2e132acf62e849..379b45d2cd952a39c387e84af71238b53f7737e9 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <crypto/aes.h>
+#include <crypto/algapi.h>
 #include <crypto/internal/des.h>
 #include <crypto/internal/skcipher.h>
 
@@ -34,6 +35,7 @@ static void qce_skcipher_done(void *data)
 	struct qce_device *qce = tmpl->qce;
 	struct qce_result_dump *result_buf = qce->dma.result_buf;
 	enum dma_data_direction dir_src, dir_dst;
+	unsigned int blocks;
 	u32 status;
 	int error;
 	bool diff_dst;
@@ -57,7 +59,21 @@ static void qce_skcipher_done(void *data)
 	if (error < 0)
 		dev_dbg(qce->dev, "skcipher operation error (%x)\n", status);
 
-	memcpy(rctx->iv, result_buf->encr_cntr_iv, rctx->ivsize);
+	if (IS_CTR(rctx->flags)) {
+		/*
+		 * QCE hardware does not increment the counter for a partial
+		 * final block. Increment it in software so that iv_out
+		 * reflects the correct next counter value expected by the CTR
+		 * mode.
+		 */
+		blocks = DIV_ROUND_UP(rctx->cryptlen, AES_BLOCK_SIZE);
+
+		while (blocks--)
+			crypto_inc(rctx->iv, rctx->ivsize);
+	} else {
+		memcpy(rctx->iv, result_buf->encr_cntr_iv, rctx->ivsize);
+	}
+
 	qce->async_req_done(tmpl->qce, error);
 }
 

-- 
2.47.3

