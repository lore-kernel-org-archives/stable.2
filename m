Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71E3EC80F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337339; cv=none; b=PArDLiAhzAQxJ6Jm9qVretTJmE0SU2WgoeFxSWpJVh4+BRL6Csc5OFF/9IVc3AfRH5SwnvhmnW31fIPoYIXoroKXCnv1R7hSz/V/t5PkNx/jcbOtXUBArfB0YxQQ74DrT9QU9uuExNAvPhOMsPfSNA2hJpd9qbYKWjzMw8ocXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337339; c=relaxed/simple;
	bh=T5lK8wWfJN/iX10lOcW7hSkjB2+uA7nHVRM0h625VDQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOzTtO3+xF5WWBxocjMPwk/25TCB8X9/YItiIkiS4QJu/vUGnwUL0NgWEJ251RStTl3GOcoJqp83vuxgNFreX7Mh9FXnVKgojohIYhz96h+JTEaG+9ysgZpENW9VlIKDeg8KDF2kwUQ+iCCf2mUo8LIi41vt07Zm6HPFCeKx3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9kULzu3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL0b+W4D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9kULzu3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL0b+W4D"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2GCG1698913
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v4DlkGu5ob5
	sQWOsQ6nrSkn1OZK4Q9I2xMXiKx09k60=; b=K9kULzu3rYe2tkzvFcSn4kDYbNy
	AJZEio/UXCDxebEbMXYaK8vxG0mkdI0X3Bdz0NbbLi8pJ1wrneRGpI5AHQLNUxrz
	ppB2ah/5mrfhuIkEFwy44aHn+TAU9n5n2EOichCmW45RvpQVqU5AAi7zM9DfdySy
	jwUGjc/CKKhGxpGTwAGGKvGcxxuY1wbECvmAoauyZF9kC3Lx+t7jFKRB284a52wr
	iv8LXathHEbSlTqvh/7WrxRYK9qohFJdD96Y2CV5SOvytHPdDJVCOJLvdwEqj9eU
	bvBPU7xssUCbm6Amia8SdPg/ZaAf+hSwceXrCn8naIsfoeTyJ95BzPxs3uA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj0xgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:02:16 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a37fe3aa04so1270369eaf.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337334; x=1785942134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v4DlkGu5ob5sQWOsQ6nrSkn1OZK4Q9I2xMXiKx09k60=;
        b=fL0b+W4DbpVX0+RmQFTC6SejBcqvJhE1xvY6/L830CARTfMNg4ivOjwqtl7Gnf2MMg
         hTq9qZe1YYHyLbC+1YKstjgYzqySfLymzXlAV48AOTEiqB92mACvnxs7Nhe1F+X0gD/T
         LdFDF6wR6kokzyy+VY2rqn8uht8fsRd+qaDgwf14xS5/9HqRQ0nJV2FqM+9DfHAjjmcQ
         jeui6fkRWBah2vkSOnR5dPVJGtdBspr8062dXb7R4k4Cz8imX7MObk9FEEQTq51nla7o
         szzXMqCShWM69XiOnuv3fXRc5W0LgOBuckyUW5yfQkf8tvMOeTs57X84hP+NosHG3jbr
         AfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337334; x=1785942134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v4DlkGu5ob5sQWOsQ6nrSkn1OZK4Q9I2xMXiKx09k60=;
        b=savtVTMPXPFr7xFUR2e8OCe3YRKpbvib+BTr5SQxr0Nqc5h+cBACMGCQESVES68VRO
         insJBwuk0C08doYfI+Et6Ozyr4WRudseLNLmsOsgl/d5jMO7Dn0pgQ4Kk9j388atFe+F
         +duKj2buIBo/RfK7ff3RIDGcBlVUggmgFT3pjLcnKAlfaL4bo9AjWwMxsvmpg8Qh41OO
         BVpeoEnLEGLVm7ghMTWke9ziLkK9uvMDTWbguAi++Cama+Fw2L3fK/2QUN0F0o2P3KGV
         AleTyElqb95lTij/pVh6s75gjtdPj1y5+enDRCvhrLL7zo6/NwKhClixKeLxeaeP2IFF
         Q0Kw==
X-Gm-Message-State: AOJu0YxAKFa7vxY2awJaUhXoTvJ8ZXlyjMdldQm4MvKj1DY2wUzWjsWo
	azMaHy77SohXGGFB2knBFngd0OAK6MGVrK/UhZ+Wiae1QhA5aGq7v8IgFchb92s72P4Cb5qwCNM
	jBqzVcZyG5SBodpsgfljjQ4XciY739W7TOMjI2+2Dtm5K76P5znUx7Z+ONVK0HKPibvLDYg==
X-Gm-Gg: AR+sD125gQ8nK1RImgR5uXz8k1l74MCpfg/XE1PQ/lvQ9RArEYtmiCysq2nYNQEm81u
	ghcmIsnQZX8V/2mcETfPQpd8aDhVVSYkYqpcsW/rqelveWO6qmtU1bo/nm95ZcwtGlKuJjeSwhp
	7fVS7UgU2TcOc1daB6J9DI7kaCrzEGIQ6N+rtRWVJ4CYHqbhl/8H6T2y7rdgspCr2i2gcGKoG6c
	hI2bfYSWFIAz00RUNfevTTEuggXG4b5kqMHFFGkni2orCi69qgH4qHtP9fEfyMP0fIdGJ0E6fyq
	QmKh4XDE7g1gxEik3ACaYL0x4MnbZ++zjp0wWnzwLk0UhWURWX8l6Gd7bSPe9/qJuPWsyctSMr7
	Eag7Zrqb62MFiwV+CG5irwKdMbVZckU7DoSTYA2JV
X-Received: by 2002:a05:6820:308c:b0:6ab:ba6:f426 with SMTP id 006d021491bc7-6ac96de1640mr3497101eaf.68.1785337333995;
        Wed, 29 Jul 2026 08:02:13 -0700 (PDT)
X-Received: by 2002:a05:6820:308c:b0:6ab:ba6:f426 with SMTP id 006d021491bc7-6ac96de1640mr3497077eaf.68.1785337333412;
        Wed, 29 Jul 2026 08:02:13 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cea5f8sm128386466b.24.2026.07.29.08.02.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:02:12 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:02:11 +0200
Message-ID: <20260729150211.3884880-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072918-spinal-repeated-d081@gregkh>
References: <2026072918-spinal-repeated-d081@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a15f8 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=WZGXeFmKUf7gPmL3hEjn:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: kPnZUADxsa7h8yvQ1FvEy-ry6OWcKBCS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX4y/L4Go93zfK
 mFsNgqo/Ay9mCA+hpYivW2h7/AcJdbU+c4+hA7ZyNtVN0VJotisqbt2zSMehY68tpms+me+1edD
 ZH95fAsAWfNVnDnZJMzTgR0HWqRH6wuveNJpZ25qe72T+lnKVFIx/KRMYoqDBYW9kn7J0NtnFRx
 YAsn5Xa8gnJNLyz8+NNQMzJyU3ExaoDPc6/vdgvN7kx7xvRskl1GuJV+Cr8T1j6swJPiTqsxqwt
 Qgu6zN/eZ5q5GQ6iqVXowW0gf1+/jvdXnpub8u+eAhaDGi0WO81Lh8ffviGjPFYqB/9JpZM/od1
 AwRNOOonjEpr93RsIEom2sQncyobe4nTQjC+dXdSRlp1y7gpKsLBeh+MkAWsKR6EexohwukNIgP
 6V8M0QEevZJnPO7t5BKaqDi2c83pFqgjSDNyQzc9PwGvtt6uBkYj7ATm7f7rKq0etcgpxsYzP1l
 uALf3NVsR4VtCaPk8Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX+zhvykxviTqD
 08Ga/0Jlk+3E9uwAywD6CDdn2qUaZvpiUCYX8V64U/nY7FStwdrTbirDFTv3DyS3n7LU2ZOpOXY
 n3dERKXlR8wurgXam1Y0T/RwM1yeUY4=
X-Proofpoint-GUID: kPnZUADxsa7h8yvQ1FvEy-ry6OWcKBCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290121

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ff194cffd586cbd4cc49eccb002c65f2a902a277)
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index a10e8de4f7e1..e8e3ba1b3b82 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -85,9 +85,9 @@ struct qrtr_node {
 /* Max nodes limit is chosen based on the current platform requirements.
  * If the requirement changes in the future, this value can be increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
-- 
2.43.0

