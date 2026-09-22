Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D93545DAB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081879; cv=none; b=D7AA6tw8ERC1Z4EaW/rmsIaHYZ7+mUMTFYO+ygQHTdtBpA+NZj7G8awsG5WqN60ldoef8fyaN4tpmA+ApwaEaslNZUt8WJ0hB4CQOcJpQxzzNPsBqfP5fxVA6nUGfkQ42lLpWaWkB0PaxYvgYNN8oTr0MtxhC5VZI5CYYyClv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081879; c=relaxed/simple;
	bh=CF/w/I2oWEL4xyyUISvXBZXxucJ1ol0yr2u30mZJdOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2T1eyS44ZmB05MK/MhBSnQGpmUNubpSHBk9KJKPBCbkNMZ2k1q7O9zkFvunbLSf/WOqkjKqUb7QXkVjWISpcUhAoD4pSKM5FMXiWOLx+ff4Dhvv4Mcunqtf+HH584uwxY8WIT8kPmuKQHqZhzz3fTu8R1/2PWU0caK8D1PdnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEXLY+o7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHoE0/BH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEXLY+o7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHoE0/BH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPTMO3516035
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t8d5GV6KzLRz1CYx1P4YFuvPCuiN0aNrCkWkYjs7e6I=; b=QEXLY+o7H+Jkj+9p
	bWmSSlnHyCWzU0rkp9oX0Piyt9VqZgTY1IGj/GkBur3tL6Wg4/HzXkKmkRQcGS+m
	jzGDQnZD3KEbdKMsHSOBJGD9+0dvKoLmkF030j6ljEG2bv7uM1YQ+f8GCZ1ubK+x
	oJdvbkswJ0x2oWiPsEnemJYJus1fDCV6xP0SQ++YlohnKrjhdAsEixy7xwYRnM8S
	lUc9Wb4y63/DjMsMsgPdF2V/0vWb980XKnhKT9qSL7FAv95hOXPOJnvxQTdBvIEs
	CW7zkUJkZOwHrAUOXrnEeb2Tv4Ss05wacIIlcZ1A2U78cW081rXzbpovMQsb6cM1
	+hGp1w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqagsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:56 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso3230115241.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081876; x=1790686676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8d5GV6KzLRz1CYx1P4YFuvPCuiN0aNrCkWkYjs7e6I=;
        b=DHoE0/BHZKpAFkx6RS6XAV2fJzd1sfCqSEEIPIn71gX2aUj//Y0DSzXCk1SahXdfDN
         fa0L6r/UbQJInjs7ljC6bTrGGaI5C/mBLrHweik3uNMi9dJ5ihDjkHJa7CuUyCpZs2Rt
         HNAS6E1VESx0mzdq1G7pRILG20zWipNy45qu/siWwqmA8XxYc+CWYFu5PfT7TK4fnn87
         E2zN04J+XRFZxbTmBOSpws1zL+aRAvqWfor+9me3FJaYoIsK0U0HKXvm0aQ1YEA1b81z
         9VGrGQ2INp/KAJcIkpx1VPxbN/dFSX34oGadJflUgzAfJUGjkJCdjZfBRCmE9vk0qo7V
         LZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081876; x=1790686676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8d5GV6KzLRz1CYx1P4YFuvPCuiN0aNrCkWkYjs7e6I=;
        b=JrvSCZ6l3EYOhp/MdUw03cVbhxDZNUghF8lDvmbxVSXbHec3Eo/bacG4i89UFbX7rB
         wzt0Xdz57fRfBeHdK8kfFepC167bwP48eordIF9oJVnFVWUPXOMLJyxe8RKu+l0YGb/5
         7E1nlh4nzc9k0CrETBxmxgw3yzWSMpykip8LggeeD1h2qYSwkUGmO7a+x9zWPdIISyxl
         p+MLdxT4xmUpNhypQYLy/HcCiaGp8M2BzsRqKDLZqHloO+2o8GHYtYtmbwC48LoNztL/
         EeOz7bpfT7h9hJnj7kqoizP3BFnUXh+eK7h70ubyxXdORrYDeaZSyYXfHVEmoNX3LtSR
         j/kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiPLap/qVMLBTEp6Rcu9g2hovxbEpRLAKmvNfgnAuz83LobzoVQlOiteZh/0SyI8bAl7cPEug=@vger.kernel.org
X-Gm-Message-State: AFuF++kduIQErFMel1v9FsYQtBsqB81e0vicec/iIx5CkqV2LQQQksui
	o3gbZA7PoKXdw22iXqrjNQ5T13hAUn+k9Sj5/G21QkihvBUvL1+SNTUs9cWNwVyPutG2hf4d5tj
	jCalygr4FNX0PTLS2qYFczjr23D7grlSlOZQ6DVS1Dk/AVQevjf3pXw+B6bA=
X-Gm-Gg: AYBFou1GcyNfv3CEQQX4HSszTj0KtlgwOp2IXT6yr/JCUQZVsKA9USBAtwVs1JcqDF1
	wRZgYYWGeKR9csip6RZO187s3lrJDglPYlrVxHZtvBx7uuZIW2Pgvg9ywKgiIvg4H2P5T5RB4/L
	Gkpb1ceCYrvoLDJH/+oN8xLv+kt0u2iwgX5el3phq5kubBTQvZvZyoqPz4J+h1hRl8307tmOcZy
	x6FlRbYqjxusu1QF3WEmRPI1ZAGSWphBTFu9cGyd1BH8eZzcKttArIk7NsYigDjbHcIsNqaqMbu
	0Gliq0WhZ3JHK3QNIuDiHj2agzpnSjZj2ea6zIcY+HhhwKhp2yNk34YmFQJTrb4grFjslaEvxAN
	5B1L//0Ye0FqanUqAvgb7pUr5y9g=
X-Received: by 2002:a05:6122:310e:b0:5c9:a60b:e5a0 with SMTP id 71dfb90a1353d-5c9b597ea0emr9167078e0c.11.1790081876013;
        Tue, 22 Sep 2026 05:57:56 -0700 (PDT)
X-Received: by 2002:a05:6122:310e:b0:5c9:a60b:e5a0 with SMTP id 71dfb90a1353d-5c9b597ea0emr9167055e0c.11.1790081875488;
        Tue, 22 Sep 2026 05:57:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa4537b5dsm1097669a12.30.2026.09.22.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:57:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:57:20 +0200
Subject: [PATCH v9 05/14] crypto: qce - Use fallback for fragmented
 skcipher payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qce-fix-self-tests-v9-5-b1aa742e79af@oss.qualcomm.com>
References: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
In-Reply-To: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CF/w/I2oWEL4xyyUISvXBZXxucJ1ol0yr2u30mZJdOE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsns6exnmLRxX5OeIpWKZ9CFxYKoMxcYdGq6gt
 cdm3/WHvXOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJ7OgAKCRAFnS7L/zaE
 w2T3D/sGvLLVisZcqbLMZgMAXE/FdWjALLQ1JRvjQYr2eJc6Hn4KRry+6PH1nn4R50f5e8CVtoA
 GES/YQPz2THEjelD4rIyadz/Je1U9JN5JR0YqqPsWq7+M8s3AGfB7mJG7DCv5MM3/53CVAa6bff
 yxep+hth4qyb1yL+l6o/Mq846FGMy3whIJTPu2iZ3QvbYmhSK3YxxDtWS5YTaV55daF17nJWfw6
 c6pHi4A2H3fGDniJHnldPMgab9OY5blrBnNxQEgOwIuHAwE4/by/xJdohq8fVL99SG1DJddS4uL
 kJNVmumvpcST8QVhjo+7PgzwFbavUloxXCOXlTlhCMpJkinS6Xxy4ryo56v6YrkWu/HjCeqDY33
 HOTt/x+UAjVJgyaL0V9hVMphFBV+f0/jxBgJ5L7mv4E62DSNUX89HHG9KQn5LLNBQpwLg5E/E6n
 I/BZ/erW4lvyYY6DQS+vN+DIaI+VSwtOsxtzZ1uwSWIf8bHq0II93HxJeFNo7Ftu3l1C1vI+1cp
 8+a3pKeN4wCUd3eYVc67M+S6KRMw4HMeKR8L9MjhPfVoM4p0JCJTSp4mxu98aN/DlhZytql/AyV
 IOPXkqLuzig4t5vZaG67WDCzN+Kmh2F+0R+kcVMEl4UqkMIvbM9F40rXOV5HYrF5rbxnp1d+rU3
 vFeJ06oA6P27tmw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: LS3egyFPparVBjyaGeo42N1Wn9l0dF9Q
X-Proofpoint-GUID: LS3egyFPparVBjyaGeo42N1Wn9l0dF9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfXy4SGcy/qqNPE
 4xTiKt4GU1n9q8geHaj9vzt8JOv+abZcUmZ7GLrQVrS5645dTLeHxOJO9LihhKRNU1VDQY7J4xB
 4ze4KvBFyKOrRXpx+ATr98VPTXib+Ik=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab27b54 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2ArJjka39wvl4ErYtigA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX6kC00BrJqwI5
 A1V3yICCa5f+UcyPO1x4qWvUu6THIyu+3iKLFMlomNdp8r/syUiBVu9kD4AXN9/d+1Xa77VRMOo
 SWXhJdj1otiAGACXykfccpmAW4C90dPIXq89MSQiBuVK9PaywlTO5qszOn3dd/RyFbX2dRXo2AL
 4P4sZYMHENRzz4OkqHTVt1D1ilXwB/HJED7RIoOLk2FmfWGnt8ExBmM8kEs3LrNz4bAemPfzUvW
 V8gnrNYZrcbT8KyR8F3p168Ua3j49M+kbixjqlv/j1co8pj0DC9+g6SP0EquM2e3H/GwzfRAKMr
 HfziPGAtNQcnpittwase+VfEbD5RWkn55SVm006Z4ZJQ9kmWiyqZYgj1T6kPgcUnb4vqUULIpPQ
 PNQQsoXUVpkt1l3NhDN76DxvL9TtsYurSvCy+l5Z0AojcxP0kcw+KBmVa5+Pz5dK82ux55DUs0q
 qnsTTFnWxx2eHUKmzeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220187

The crypto engine reliably processes AES requests only when the payload
is a single contiguous buffer. A payload split across multiple
scatterlist entries makes the engine stall waiting for input, failing
the request with a hardware operation error. This was uncovered by the
crypto self-tests, which feed the algorithms randomly fragmented
buffers.

Detect a payload that spans more than one scatterlist entry, in either
the source or the destination, and route the request to the software
fallback.

Cc: stable@vger.kernel.org
Fixes: 25b71d61d631 ("crypto: qce - Improve the conditions for requesting AES fallback cipher")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 27ce87be2029d896fd987608f091084ac64f5185..dcf2c6ebd588fc74c759820807b08000b274a501 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -261,13 +261,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * needed in all versions of CE)
 	 * AES-CTR with a partial final block (the CE stalls waiting for a full
 	 * block of input).
+	 * A payload fragmented across more than one scatterlist entry (the CE
+	 * stalls waiting for input in that case too).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
 	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
-	    req->cryptlen % QCE_SECTOR_SIZE))))) {
+	    req->cryptlen % QCE_SECTOR_SIZE))) ||
+	    sg_nents_for_len(req->src, req->cryptlen) > 1 ||
+	    sg_nents_for_len(req->dst, req->cryptlen) > 1)) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,

-- 
2.47.3

