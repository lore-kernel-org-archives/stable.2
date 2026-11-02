Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632059;
	b=XBUURhOCOdK3bUmTNmnrH3aaVkSccnBsOTEUEiijIiFyJiq5KMeNwjV1mcBBhbJdMvzB
	 DUje9DvabFMiTd4YSd6l3bMDnCDtHw5Q9+Hyx27fSnccGDiHxeGmG+sQM5HHjNx3ZLZL7
	 pP0g84fks2j2ohTfQagt4JFQE5lAz5p1d79IxVHk0LUMoHi31LSaUBF9mOstcaUTbD0Df
	 nmMVMVKzyjbuuIRsfsJqOccj1GVHOZ0TmiQhu2DIvLd0N6qjVqkExdDMZRb5UobrNwTG0
	 Z7J+JeRdyfKgLtnm6PFRKInbrrsANGgTVXxvd7cxyM4eQQ2NNKPpUe2eUSciDwjZ4MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z0A8W9k5M2rC0HGmQPRaXBbm9a8tKFZcCFhC2q3wOtQ=;
	b=zR/syJjPLlaRYwtBAdawPIb9Yw4GVBnCA3dN/H4QJPPknKo4RSFrRPZNlvE9+i+cGQA4
	 RamX3QeWin9zLyhjvUqpvYCgDTfxXc4vJ78875kN8ojo8zKiw1wSiCKCGMh7YAJqsJJuB
	 120TAYjblQvywhOhEPKzRQvA1s7pQsPLUO+R1F4FabDjw9IoJdFgQXs4Y8GCXL+4S6et4
	 7pd0ZmV7KRKFp/hqPs97XB39Egxbyz90Th0a4+95/tXJIGH5M5WSsCqA1/TOw9RAy/Umg
	 k8LkSs4oUryapRym3fs/Sh6cjSQzEikCkxfFGfaL3r9x9IwYxNQUhNzx91TVgkox6bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ILDthXLY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KOE08ZqR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3497606B0D6
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3497606B0D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ILDthXLY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KOE08ZqR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpRUD4070548
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z0A8W9k5M2r
	C0HGmQPRaXBbm9a8tKFZcCFhC2q3wOtQ=; b=ILDthXLYJ1LhmQFFWuryO+lbwwW
	kXAyEALMj/DhLWPiIconrjnpzwGt75OOn6IkOIL/mv5X5jRhm31lY7LZxeY4OrcI
	MwHSb2JYjvRDZYbdtopBaqokYNVs3syQYwLuqZeJ3A6a7jFwSLaZCZPtdOIcKZOK
	+P9/0b31mDvjE/CBmybvXP2j/nbQOAd7CzwcP4fn325dKXNsqOTupFlSllo1j16p
	8pU3rB3tmb09GnHfEdwsKgCCJVqk0RIZ4mxmRlXAz9BMY9zeoaQSZgByTO+HV9wu
	IJUqExdyn5rcw7c48/d2+UbnP2uKB+UmPubvulM2DlAVCbRL7hhPBL7L4tA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5gu4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:07:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so622967785a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793632057; x=1794236857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0A8W9k5M2rC0HGmQPRaXBbm9a8tKFZcCFhC2q3wOtQ=;
        b=KOE08ZqRtdoM/S/NAzReTcLuxi5vG8QDCTcFbQG52cxrW4eBIrk8crraCYGzqSyfBc
         z16fCfwwx/2kO8vHqmhRUxGfpZYiM/bnKKXAcQv6/Z7XynTxJGqnXhI2h84upCQX0b4P
         qyyVoGg6lR6XGyotBOPLvPYVTiGz4d00rB7/C8YFHnpcQWcMxf6Mvk6uVhpfYd8i7UbS
         Y5M6w5aW5nBWEHMKGHEeRzFo+azpdU7I3ikW0PmGFvgxgke21FYvexUnWVQ5UZLz96ih
         QDQJ7Vf8iDg2I/riYFk7xovdz/IPlvupsQPD7X3EvtBc5NGkXyrBUFrV2AjntgWnO8jJ
         cp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632057; x=1794236857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0A8W9k5M2rC0HGmQPRaXBbm9a8tKFZcCFhC2q3wOtQ=;
        b=XWfZIH6TogGQhNCnRwPIr5gFX9WfjhZUM23BkRgaxKqXhaUa8NYiRzMAmZ6FB8Xz9+
         5/cPkA/RUQasZ447kg29RdnyyX+SDBkYA6cNF5ZJbRgJ4ySp1z+DmA3q0TxtMyG7kGIt
         /ZVKywJ4SCJ1KaJ0A6/YI84BqEFd/aUGAioT+kWwcJQ4ZKNHXNbhfVc7uA7Gfoj23jxw
         VedkyUfolF7F9jBJhOoJo/RuIolaqCARzaogYDZYH+rFA80kNjN+PWMyOsk2K59afY7N
         mxYWNW/FmHrw2i2ucks8h5Awe8OyJVD9UQe+Dgq0c/IRa75OSMsZogiTTHAcARGcNm7n
         O+Qw==
X-Forwarded-Encrypted: i=1; AKwUvBzLlfKV7TEf1Ix+i4rnYbSZWNPjlRXSmN268cg8lK46HiYOXoAp7JYr6/s7BpqpciH2Qy0DUOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL59txHuwNw0WY6pYiYcG1VCGfBp8QlAj2yG2o0oe4yDRWit5D6
	l2R8O/ZExM0QLaLwMSL1JBYEZYn4dhA97j/XU3Foxqc8NeyIBlWkrYIeRpQ3B7RzEUe4v0jHD6K
	voUbCMws/Zw5yxjEpkrRjqAHIHVkGsSoXc5oY5njLArShoB4+YHbCp7uHBMu5GJ3lx8c=
X-Gm-Gg: AYBFou3kZLOeEOiqwZkWjoeUgH2VVnoAoWI6MosHUzO2EfdPO/2UR4hUjk/EsB/KgIR
	fmN4Yhn4NrcSQUfKnR0JKG6fyN4yGYM5GsSDvnuKJLy1NaS3ZWP+cdRnGLEfVRJKHAA6gADoZ3x
	RkkUnCEgq5KYF3ei2j9ja1pLscwszRPsPPMiMNdaCki3LHFYpiGVM6PSdTZsYtfqUXcvdRoGL56
	XlivZmKDDtQL9w8PyQJhdxQcmERZEX3swc/PbNzRDjAAGPnZatvP3Z3v3aVNK+WQaJFQIyadCjG
	SVqudvJLuzQNx0hZGcOTE74FML0TCK+Ct0l0aNQZVZRGLCR8fw7/POxhDInYRDfoTqBRCzoxXpK
	LOSnj+HbmJXhqkK35kfo16URaiNNRYtePCplA3zJsOFhsXrmZGYKXlfldLa0kYQ==
X-Received: by 2002:a05:620a:bd3:b0:93c:6ded:4665 with SMTP id af79cd13be357-944214cb617mr1560225385a.1.1793632056806;
        Mon, 02 Nov 2026 07:07:36 -0800 (PST)
X-Received: by 2002:a05:6122:2087:b0:5ea:c77f:2f22 with SMTP id 71dfb90a1353d-5ec6897bc06mr4078176e0c.22.1793631679691;
        Mon, 02 Nov 2026 07:01:19 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf368bff7sm279827185e9.2.2026.11.02.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:01:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] firmware: qcom: pas-tee: Fix purely theoretical out-of-bounds read of resource table
Date: Mon,  2 Nov 2026 16:01:12 +0100
Message-ID: <20261102150110.227479-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=qLzdq/l3FCpuzwGztqy7qqwNOzx6wUZeD13FV3iP8dU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6KW3ng+OmAg9FvAlryl47/287Hy3gmJ0Hvo8s
 CJF9xNx43qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauiltwAKCRDBN2bmhouD
 18dgD/4oL0GeGT9G4GLwasi9cAQOMH5w/KawkU0/+6UHTWdId6zyvcDzXvwzb6SFYotztZUjWRA
 VyX2Kf5lZZXkFhLUmNrPnDm+1bEEV6L0s5PPfRn2LT0nmHRxCIq//IGn9T8Rd118AU3TYO5af+7
 gWK26gS9Q8bWHJLikmFUightnMsdMZ3m3utioJHefczKNXH7UJogYX0OH6j1YVXdppnGiXa9S1H
 V1zwCHyIg/FtYeTvn9NU0ROt1p577UuTF+AqSgDiCUbhmFuDMpcBeVTpG4myyq5TNnROE57d18X
 j80kE6C3sy/VSiEjVHkiT8ut4BlR1vh0JkzNtneYZTyfzLbz/jLteIq7qKeseC290AuTRA5CHfi
 C7B/riV+lPxVo/GyHuBKgb11o9mkw6O2XRJrH4wKyWiC3+VH+DAlflHYohvSwJYTWKSqayNff/0
 pKVetZiITDbI6CLomA7l2qId48CJRR+OwVB7Z40HDtF2vT3e5A+7OGczXxiwOcoxiheXW1YcO9y
 uj952h092gZf3/ZgRGz8jPUipVjKTVWWiyzIwOjyPNoKmHi8aC6FzUR/KexyQwzjjDwwgeSV+5f
 +ogQc5qfD343Ibl+qaCRJSlXwTvvkOaVfw6DTI8gzXXinU60duivGPUgeFjelQ+9hqSDGcFyaWZ 1CXanN13vRoAevQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae8a739 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=L1n7qZ-GtGzK_Ty1_EsA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: CXf7a0qx9w9IkK1YXvONAxkRLu027DA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX7GZuFaa89JR1
 ejsokxANf/bMJ6gMSyMixy/nrDB2k8JlWQBLY6/HRv1FVP1RpYWXRwQjZuO+YAoDokyp6EvQJuP
 4ZgGb6bPClotppsluVkvegizjqvOFYcLpH4wvDLBJjlZ3JdE3Dtr5sxhJkgDvXsbks1z5tiLwDb
 6agodgtCbD6/VANCRm6c047mlSFi2xBh5tcHpM8UpuuiloU+xheocsLDDcRxyvJuAcxxJSz9drK
 h6U67PT7OWO+9nW+YGRfcLuCypBTugTT4f84C8fJbbyXve3W4pHfOFogjC/4FyWozHRo9iGQxDH
 LnbG/JBwpBTh8OKEZOg2EouO+n78h6H9u0kgaRUDjrnwrHozhi1Ul0AiAkzFpptFqUADKSHoj7i
 ia0Nce3kacMVybwiWBdlo+AYwzM8lCRPZFWq+RZqxjFi6MkK+w/khl8Jt0ZqMocRNDmkiCtk9os
 rxtNMF1eGBC52gCD67A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX98oJyuN+pGGb
 gwFJo/DEUjEshUAKnCEW5JMq2GqNqxzsKYj6cf5Aoa6JZ/FuKQ2A2FMnzYZFl+RTnWTKaOW/dQo
 GQ80vDf5lHLVW50GNqP/XEVJJZ49WfA=
X-Proofpoint-GUID: CXf7a0qx9w9IkK1YXvONAxkRLu027DA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060

qcom_pas_tee_get_rsc_table() first queries the TEE for the size of the
resource table, allocates a shared memory buffer of that size and then
invokes the TEE again to fill the buffer.  TEE can update the returned
size, but the driver does not check that the size returned by the second
call fits in the allocated buffer.

Theoretically and unlikely, some erroneous or compromised TEE returning
a bigger size leads to kmemdup() reading past the end of the shared
memory buffer and leaking adjacent kernel memory.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-dc984fcd-4884-4518-a98d-9490de9ffce5
Fixes: b6f7978da0c4 ("firmware: qcom: Add a PAS TEE service")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas_tee.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
index ba9957023ec8..cd84befa34d7 100644
--- a/drivers/firmware/qcom/qcom_pas_tee.c
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -244,9 +244,9 @@ static void *qcom_pas_tee_get_rsc_table(struct device *dev,
 	}
 
 	if (param[1].u.memref.size >= input_rt_size) {
+		size_t rt_shm_size = param[1].u.memref.size;
 		struct tee_shm *rt_shm __free(shm_free) =
-			tee_shm_alloc_kernel_buf(data->ctx,
-						 param[1].u.memref.size);
+			tee_shm_alloc_kernel_buf(data->ctx, rt_shm_size);
 		void *rt_shm_va;
 
 		if (IS_ERR_OR_NULL(rt_shm)) {
@@ -270,6 +270,12 @@ static void *qcom_pas_tee_get_rsc_table(struct device *dev,
 			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
 		}
 
+		if (param[1].u.memref.size > rt_shm_size) {
+			dev_err(dev, "PAS get RT returned too big size: %zu > %zu\n",
+				param[1].u.memref.size, rt_shm_size);
+			return ERR_PTR(-EINVAL);
+		}
+
 		if (param[1].u.memref.size) {
 			*output_rt_size = param[1].u.memref.size;
 			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
-- 
2.53.0

