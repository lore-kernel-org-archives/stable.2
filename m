Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DB42A797
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303645; cv=none; b=t19D8Gp4WzwV7PlxA0DDGZvRKXN+TwZF47iGoRDxk8pIY6Ls3GzP4G0eIYde6XgHLf85YTQ+QXregeuGK2EeoFcyPeFDhgrUBrJ4PB0Ew9I1LGv9ciArwSPzAUaNMvNx+DAHgeg61i/FpL7dLigmRE32sOXS/6P0El+WSjFjkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303645; c=relaxed/simple;
	bh=ibXDE7QfYBh/Y3uVHmqj0Doeaz6ovE/rm9hnql1AQTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXVWotTjEAiFjEnO2phHS0IzYzfDQnD3g58VC5MwnAeQoel2ms2u8gG/lOQEhA94XsqXTgblzWIsb6tdEZuSqB1dVCWAqvYjBRg2xm9H1ZrUcki6RLU9xyOZQMoifvlm3pruNDXjc6WaEyEWfpwFB35hlwBIIUKds5RdP3s1ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cAG+3HTd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h44dsrLp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAG+3HTd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h44dsrLp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7rcn1809412
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYeFtj5+lSRAHCG4iElDvXo9CD9HgurpDRFCb9pO2Kw=; b=cAG+3HTde39xHBO6
	HCG6LoFcOydtjWSFSFHjLFtZ9sMBUmX55Loig1XKymrf05iso5UEVQTO8eHP+LoS
	fRfM7tB/6+wpkvPw6zM+4pyzew3P//aS5Xq4N0UitoeocK0Yj559NnkOeSwm3pTX
	j7EKeAxOS7iM8/+IH343KlpvrkYyn+L0/9wT6m5ZdLKPiZjn6/7SIp3uUbhSMD+V
	RFQgH24BSO89blYrfTO7wa7TqVxbTl33pa3v7cm1rJBLV3cxMZUzUKq7lCUmv0l0
	ubtyO3bvHembL3a7V4Jw/upHolryy+V/K5hVCVT20zYGPNPp5HIfJKFPvboYJLhC
	QFhv/g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8mhdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso33561061cf.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784303641; x=1784908441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYeFtj5+lSRAHCG4iElDvXo9CD9HgurpDRFCb9pO2Kw=;
        b=h44dsrLp+ONA53vmxvttVBjtpx1iv0poJE/D+aEt2SfeMsyhSCjkz74ePT5NvNmvcF
         5vAgHir2ZPlKItT9m30BKHWIPZWkzoDQTzee9Ln/iSoubIRt0/JWRqKGjduBkAttVnAm
         DULz8aktv+yh1D+8O5aMPKVwJhXYHpXJ582IB2SOpLoeiIkMRaKRo6RdRukNBEt+fPLY
         B0T0kugDeODszMy2d8nuL4f/NCknMIevxpO1OIpq9pG1cs1G4rP8y8bbN6vhy23Y32NS
         val7WcbXfbhr/EZuPnf9WhtMSwpS1oKocaR38UvRjKTVkCXqx3z6pQMrCOlyaGygX0H5
         AnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303641; x=1784908441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYeFtj5+lSRAHCG4iElDvXo9CD9HgurpDRFCb9pO2Kw=;
        b=Pyw8Wu8GO1KdSstTkyWOG7/saTBv4ua7/XBuwiqRR/+h4j8ZKJF4AgCXnut10MgeE8
         nHQIDGIP0CTltSTB3xKiwyTU1zVnrpaWZamoyC2GqAVCX71ql3HcBA8MIKpfZy03Yi4L
         pxQg6hKdmrnHEiGfweFX05Q9tc85od3QHu5hsEvfgD08K/lLkAmUrmO903PTL2FyCUyS
         fpRYPoW1eJewUWof5BzrS/KmH5LBedNcbo+mObpTcsLWCVLfYCiIqwFtjCxfZF9TYSle
         tOVwq850thc4EMx71nNHl8uXDnG0v6gLiTSYl5jNBnM/oscCIou8OytfT1jSZjk1cCKp
         W4Qg==
X-Forwarded-Encrypted: i=1; AHgh+RqGejr4TU/pruyvN3Hv++cfOZOyFdjFouu46pNcs2LTbcFsglKn9QBhfSF0nAerCpgymEezH5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHMqAM8K82lbxpJJqGj8eZfavLgCHCuTZtvFGaRiodTXEQfEl
	BXSkF5TBYFYBO9o3a2szZab16AL1tANzAtKjSribmrp1MeFs5W9B6FzxmxAAQPlbsolTXd50wV1
	fyngm+iP/aBfOR2u49Lt2uYnWu/yxzN73CB0Dv5DbE0HSBo/+w0zpP7bZjYk=
X-Gm-Gg: AfdE7cmJp0eBQ+Dxvd7NUtBOXE9clbOQ7Sm/wT5E5mJyJiBR+DY/lhWGks/t+icZPWz
	3LlHTjvnEspX3zRsHncDGGqGSu+kZOxtrk6l+iyqo7kii3VOTAMhdAcIBqu1WO1lWB/7dijkieS
	r2Lpvm6900P7Kbf3VZajJ8VFrHuVyC4+3AS1l1Bd9lk9IWcGGSq9JZnKDbqsEWbtVwioTnQBEKD
	1K2CRMSeMcx4DDNQ3p2d0M5jWlQ/GPY7ooCweIsXuRoEm1EJmT+KIpbMfXZIvQwqKbtErf42Foj
	7/c4yUkKv6TCXbbfVh7J0rVZzi4Bb1h1IIlm4DvgDByRtjOAf21nWwMQJuOxZa7pY+3yrDyULKb
	vQuAFlXtAtgS4nD1tu9Zks4PaggYbDw==
X-Received: by 2002:ac8:5993:0:b0:517:63df:91a5 with SMTP id d75a77b69052e-51fbfaad90amr75648631cf.19.1784303640635;
        Fri, 17 Jul 2026 08:54:00 -0700 (PDT)
X-Received: by 2002:ac8:5993:0:b0:517:63df:91a5 with SMTP id d75a77b69052e-51fbfaad90amr75648351cf.19.1784303640115;
        Fri, 17 Jul 2026 08:54:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dc44:5b1b:5396:79d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2511sm47057095e9.1.2026.07.17.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:53:32 +0200
Subject: [PATCH v6 3/8] crypto: qce - Fix CTR-AES for partial block
 requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-qce-fix-self-tests-v6-3-455775fe5f6c@oss.qualcomm.com>
References: <20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com>
In-Reply-To: <20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=0wfULYDcviuc8Q42MEg50uyXBEFkn0s1U0Ju00N6IK8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWlAKW2UNv3U6nFiQE9kWWZwPOg5OFCqB9H1H4
 cBzMP9CI7SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalpQCgAKCRAFnS7L/zaE
 w+sREACcjpz5KVQ8zguYq9FygEPKgP9grRojVsv224aOD2JCnjYLqrHSuwud7NnoRKPDTZMfeoQ
 cKk22j+o8dCtLgMy1qq3CWCac+iOzM87yYyHVO1Lf9NSToohTC38lX3vPzJ6oCEBLCMXFa7/EhQ
 7qf6oIaqbu2hELSsijr5qj1rIMefDPN7xbnUNBkBn9kccfmEX17eKbR4Yv+Y0Y0vpQB1Ssh4wW3
 K6OpBotd4jZjAi2Sq/nogkPJohCgFeqe6vhJ2uf9gL6Fb1Xio5VQK2vof0//teRhxnYDSV3KWhC
 /3TLW7IIZbkKGlAyDzsmqtFhKfPie6jjBsQkQp0t4qKblQISsbBnxgOah0bgZmsUUF4N5iDolxJ
 yccUaf/b4WsUDytJLjgU8UdXbPKx8msAuB1L6sT49orf1E3qsX5A5lqAl5qhex8yjAf8JA5BRUk
 pNpjdkDOYRvOqCyvuWBsyxSVQJy1p6Sb/DcZm7NNOD8fWNtkJayB1ARMb8O2MwKVhddxbvT8gxL
 ffBs7wZMvkt3HabS6U3DXfHS/OWNwSNZfl4VSVklzS6aEJYwLbTyFb+HC5lHYMp/5bAN8aIbZws
 G3Nz5o3u16yQFxaALoXhGSW4Eqb40/UW3uR3baHBk0r8E22gO5x0uaPxjm0/9pT37p7WdurggxX
 pAdgi7OlDS4ugOg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: mXljwLoceZwQr0-u12RYeRi7EsEQ2_7p
X-Proofpoint-ORIG-GUID: mXljwLoceZwQr0-u12RYeRi7EsEQ2_7p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX3f6lKZ0/PjQ3
 hkZAme+uYaPY0eV2Yi8Du59yzuhmmhPbpCRLA1t6fdkTR/C9ZB3thOpyTqouOl1LZGu+SgxkiRX
 8loBC4GsHRYhd1AFrrA7Mqms17nAFmw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX5PEtf+dGv+BY
 2DzkD2Ole2C/CiCd81UWt2GmnDYsto/+12EQg1TpUbTa3XNQ02d8F/PAkvy/L/3ukNWulSUkwXi
 RsdU+YxmnusFc8RoeRQJ0716KHkiQbB7bYrzRcRL9IcCv76oCBh8K+bzkz44rof/xQ42S50YKK3
 AK7SMPzigqN6CGlSMX8vV7VjjCDdoBRBcTSJB+OvJ+n1lI+gpyYF3qyrdlHL3E4TnV9TbzqAUJk
 BvzQAWdbBYcrw1MVgWjp6p3z751szBHJ7TuzXTOVJw30UCkLCK/kYt4JuFs62gOS7YM1Byumu4F
 fyOuKUeOFJKOGSxrRoy6KmFlQ4BaJh6c73faeEaLQfD8GAuY9qlrsMWbKgp+LGV5ZRsW5BL8Hsx
 uplWosNgcw+DuovdgCQIa/p5ekxucWhq905vMVr6sw9S/j9SrjjwyxY7tW+tOt5b3mfLdBuKQiG
 AUz8/m0J9DkTzGl1q4A==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a5019 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Y2NcAOke46LZopEJyX0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170162

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
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index e1f69057607fac36e8b4bdb5dd9e62a2aabe5f50..35ddbe03cfcd75db7599a5754e4ff978f3528105 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -33,6 +33,7 @@ static void qce_skcipher_done(void *data)
 	struct qce_device *qce = tmpl->qce;
 	struct qce_result_dump *result_buf = qce->dma.result_buf;
 	enum dma_data_direction dir_src, dir_dst;
+	unsigned int blocks;
 	u32 status;
 	int error;
 	bool diff_dst;
@@ -56,7 +57,21 @@ static void qce_skcipher_done(void *data)
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

