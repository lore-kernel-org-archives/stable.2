Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354103BB682
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995526; cv=none; b=qPss3kMJ0qTGTjSEVn83NyqNaSMRlDsZNRn972W9YZZaLWw3rWhSNPjgR3nYl8X1X8YNmuGU1R3egW/4hHDCLexyx2gZrY+FcLLJuHFTF3NLMI7DxEGzmN1SNRR8i81yHdEqHsa7a6JLS0ip1PRCCBe/GF1mRMO86N8YKyNxl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995526; c=relaxed/simple;
	bh=eJoYIGrknQwfb1zrIzM2gHnxaMtp5z2Pvd8SEbnN70U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FedSQqt+glQzW/ybDt4sHGh2KuX7ES+kH0YcN6I1MOIDQCJ3VD0MB6LXYl5XojNT3ImS+TwQ7G8Q1eo7hzMp6ej4bURDvOBK8LCA3Phx82eW05vQmDE5RylhFT0KG9xjlmrKTgNAZ0ieP82IW+HxVUCdxRCzV948tvd827GL3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IF7RZWwZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQt6lYZs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IF7RZWwZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQt6lYZs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdx761563453
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	04OudQ7RvWkd5HBxT2dEnlvpOGA7uiwqEFqHf0RkyOQ=; b=IF7RZWwZTdzCAb8b
	1FZdv1QNV6TuI8uF3afWvOGARYy4CtNOrnJ8qVa34gdikgvNgf1vAquKp82Jj08C
	kuN/kg5fOmMn0NuodLntHb/cw0A40x+uK8DyuROdA8qWvnWhWdHmdZo9ze8/y6sp
	oMNAmKu2iaTr+E+8aHtPbOPcj56G6X120rBZ6rX8SIlQBjjwqeKVHWydp/U9Omgx
	jyrLsj0A7JtJNV/gzgaOmZo7qcw45WuiY8/azf13rqjGNNC7aB4JzGJ3wIHKpzOl
	/3igA9QStw5Ry94zQWdh7iNfABdcHSFe0ED6smd5kZI4ZCMdSiaOwxbFl1CSGVMQ
	eQDqWg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw1c26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c26012cd0so59955811cf.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995523; x=1790600323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04OudQ7RvWkd5HBxT2dEnlvpOGA7uiwqEFqHf0RkyOQ=;
        b=MQt6lYZsh5p5mx33sOCi3r4DSlrryvcjLVZCLN+qeBkuMvtg9DP+u2hVxpdDEyzIlS
         GAzEb9HHepgWuyWPFCknFxaidMPVcwq3FGecljNup1bvnSH8qnCnkaxCy6CoHlApszwB
         yUMosT7/KwRDbOBGonx26ScMz+u6aBnaGvTJCQZRA++7OM2PUH9QP+6wN9CGWd77LmRT
         TiWcNDNAJOLrIaKMRLI1+VLQSiqfsvyXKNG5gj3w8wIl1v0dKQXbBMkLztiUna4g0eEl
         5K3ZoeaARNTTjsFUYZ5R3Rr3T2Bmy8gUJNZDyr/K72bLW184qSIM5Ty7tzyo+q+INryq
         U79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995523; x=1790600323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=04OudQ7RvWkd5HBxT2dEnlvpOGA7uiwqEFqHf0RkyOQ=;
        b=K3gIessH4PGTiEByexNgZP+ix022f+PG2aX9JSyuD11/GWqLiydduSG+41Aea8D6Vd
         Nt5fqA0BmHxT7kGDapdYS2DHWzQlMYvF08W1zldPLVDrXlGKd9d12nibcRmZss/OMC+K
         yFW8TONRF/Mou5NCovFOdGpo5pAn4NihOBmhthWWcxkWrler/b2zKjqCXFTufcUKzg+G
         w5uqTm48DcL/bxzAzYe5jQ/vfywHncuN5FiiZ/7PwvPIG4gb4TzSCKq5iI4VcDVr229N
         5d4zJIyAiiGeZHwnNO8jW99mvWOcInkXQi6v4vaGbzD/QerAlLZCiU3BhidMfsVsTXp4
         q5Iw==
X-Forwarded-Encrypted: i=1; AKwUvBy3ODmNPVWCpYhTlg8Dw9s+vhIWoa18BzaPx1A7r6nSRQ8pyevnqxmTPhZfMCtvH6Or4nqkQnE=@vger.kernel.org
X-Gm-Message-State: AFuF++l6UErmc1TwwYpM+6Qr+xWPeQSlkUrYbDuD3BirY/jhk7dDnGTn
	Nkc6TUvWdbbPii8p//HQzyoG93986GIWkw0eDJJWiu04hiDcfUbZxEPxuz8sDm5E2kkib8jXqKp
	1CJp9FHxnkEvTzNUaLWnULGwrTtISlAkGI242qKRK4ZqPxNHjykiZk8neNlM=
X-Gm-Gg: AYBFou1kDBs2n8WGGUfiSmn+XX1kEHxYayD66Ukra2P5/XvkcYf7VMDRUqtaOPFpRvP
	lC2aPCHhWfhq1T/2P/+H+sOaj+yDuQummWF/hvOP6ReRxt2Zns5c6MEGWDWpdMVjmvOLkqZDqlG
	+liRgzunh0UwV2yys8ktbgx5E/rFZbVTULM1o7a4tOLZsomDvv5Cn9nnNGvctWtfEEvAl/vuNMW
	JaAMlaDrBs+gXVQ0tJ1SZS8exzGZv8xtfW9ufvYijxDaJrkVLbqx9Zpp1BaRJatfNOdDZF0Wdi/
	SHOkPPOKyBP8nffnXet2AzG9vXsOFAPRmmhPMYQISQPZACiMku6DqeNzSDs9bz9aT3R2CXUrnVV
	SamwwvCR7gWqrnD2fmmoOpjXlCbw=
X-Received: by 2002:a05:620a:288f:b0:939:8e05:27e0 with SMTP id af79cd13be357-93c15dc1778mr47008685a.1.1789995522907;
        Mon, 21 Sep 2026 05:58:42 -0700 (PDT)
X-Received: by 2002:a05:620a:288f:b0:939:8e05:27e0 with SMTP id af79cd13be357-93c15dc1778mr47003385a.1.1789995522448;
        Mon, 21 Sep 2026 05:58:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:12 +0200
Subject: [PATCH v8 03/14] crypto: qce - Fix CTR-AES for partial block
 requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-3-107537869a72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d7WlPHrXeW7G7LyENFi8sr5ULS/pgYG0asWNnZwa7dg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnr7NXxogcEF0l4gf5+0Mtv/aOVOboqSDSHd
 mmcA6+YEHCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp6wAKCRAFnS7L/zaE
 w/mzEACwVBiz0BKzCYUDJ6EVW9lHyjRzazToHaLtXR6ahUSTqhswSuAnRfsiQI1UlsU6SYOY1/E
 cQzENS5CI8zUFiQhjKPBY33I0jWa6Ol7drGyqT7M9ek9tz+yu5BqdV59gj1oZGL5KN42sktQQki
 2ZkFTjlRaSptjEsfGy0+JzHSc49H6pLf1SHTYRkp5kiCZBo5MKU9mY0FiBrg7yynlRaGwLei6cx
 NJ/1vkBUGc/N2ZFch+v3NGK0WUDmNR9Iar+rAIIXfwLn5FJIkyBjolQ3KR7VBTHrsP+U5/ccDH6
 /dzf8q6UtI3ZUxRAURikCtDMbp8gIgQyjQm7f0pbPO5i+F98KIOqzVl+jH9UJV710l2mjFMd6WL
 BwApRnWmzwzFbIxzf+o9jFkpS1Cy/nH6wsTEJq2oLqDHIuYgNM+/tPemG+2Oa+SGa6NI0yGOx3O
 SLBmnT9rCFdI+S6e0WydRVfo1T5J6GN0MUFRIZ9abZC+OfNGfJk4ik1UrJ99O4LifMRbPEi4xqF
 ojzhccB8mwdwU98wca2LODKSk3jhG6UgSpoeR6xXhiPRDT3nEazonxWEisPjPLQlv12bPa2Vj0I
 DIIZzuQQkKVir9cxOAxgZnq4TNJR9U8rz0HiES0FkG+GjFI9N79y8nvzyG3UpdkbTkbs4F6prrx
 u2oTTmA99bvk/hw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfXziwsvjmFgZOn
 /h+UXsqg7JmknVCuQp4BQj75pyI78xYZyOawfF1e5QikiPFSEKjzpXAba7kIKUQTayr7MPtk24C
 oYKWO+YUiWTThCF8yvOtat5fUrybM9olVC8lF9JCXKejCBRzJNuzRVcIlnm6Rc1AJS5MyfZVUVI
 RkW+1aHq4bt05EaztOjTGUfgVdf9u46VepeFkCf2/FKWV4uKUpUxin50nSzLe26CjLSBVVJMsrM
 APvRasQS49l+AJqOJ6wt8EcicXg/eRyyzleccmvSDdGzZ0A2L+/lta/K28IlYR0BHGr5v5sf30h
 1qKaE7Sue6LQA8PBjdoGFt02YSLg/KIApsfoArWVicvQkmKPfQBFlnNstRLe7G2FxJqyKtzzQ/h
 h9qRrCv2IXdnNNxJuFVuLRdotrdllhJiLyxJuTxFZlJgYq/NhuqPYCScEupsObM3qakIOIxjc0k
 mDqRseRIwLO2nBMhjSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfXzWI7wPr/sQl3
 lg7jCvLwfey+9mM2QtE23/sNaMitaNJ8/3ppu5kS+GlIoGs0cGcdd7k0bbWLr/dotK5SOzP6sAN
 oq5+2Fk4M0i9JPU1O+7fUi+6v90G2z4=
X-Proofpoint-ORIG-GUID: Ybo3J_SsT48tCyb8k_rRVtiticCG3ERL
X-Proofpoint-GUID: Ybo3J_SsT48tCyb8k_rRVtiticCG3ERL
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab12a03 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Y2NcAOke46LZopEJyX0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

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
index b49c1aeb0d27d4798e3e3d0b30299f48ef8ae453..0a872beff4807e6e5af612e336630ea7a36e203e 100644
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

