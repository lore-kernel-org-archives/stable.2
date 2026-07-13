Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102535200B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954746; cv=none; b=DPogzkYgCMJCx2kP26UQ1YZJf6YDu9ExWdaGniEh6qjW4cGh+F0mf4UiTtTUaiUZi2LnFuw8/+uwVJXW7VOSgLeamfWV3Ik6l+58gBm8J7kcyVKZYVvYA36HH+APNjhf2x5zvVz4mzND7ET7AhKETpehe9+i466Rs9Dysq7WGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954746; c=relaxed/simple;
	bh=lkIgxWjwf/sFNbQZls9lXBmTHyrWhCv7iqGMHOrl1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTOs4w/3+g/RFGHaja4tf8Y/BdhHYl+Uaxcuu8YkpnJxbsxQfDHavyu4/SRBz2DWNajEZIcqINCVmiAkN5/dWVv9aiIZCJAzCohdcis6iA2dbfv8SB/37vYjZDVBouXXtK3C3b1f4zW6yxSemIkPtLQb57ZvMSs0lQBnjrqZw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/CknA1O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ji8rIqni; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/CknA1O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ji8rIqni"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCEAFZ1304582
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y0B/Toi++qviIsvH3wfVq2MiAIIVK6Q0fCt
	d190RJhY=; b=k/CknA1OSczHCEG6uycRAnm5Hcq3NAN0oR7cqwGm83rbmAswce/
	8AraklXfNNdy72spR/hK6WQEBiKhdazNMtH/2/V+gmRGIhQB/oFPPOTZM2j6ovu2
	CEn/fwL/nXuwLHjxxjrtWLmd55Ehx9CAuJA/s7qyfuctis+vVJNgMEsft4Walnjq
	quM/uMR4AL+6OO1DJsLDzAwEnea/uuMoNbInqeXwH+cvOU9Odo1KVFP9YACD2Ty9
	2cwnKPC6RpLsacAutAr1kX9jVYK9GkBBNfPiRsvaKNMs2x92TaXHM9lDoA7Vlg5q
	LpK3JTWDkz8wMvyvaE21qELMurRTFqeOyKQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9s81d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90410c668adso43726396d6.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783954744; x=1784559544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0B/Toi++qviIsvH3wfVq2MiAIIVK6Q0fCtd190RJhY=;
        b=ji8rIqnitntbUCXjzM9Hb7NVgX54bLQIOeWSTsd76iXiE5fSfEagIu0WrVfqYD5qjF
         80cBUIVXTTN70CYuJzycO+f45GRuptEBBy5tV8iMRia13510+qFMgc6XqpAKSwPJDSrJ
         sA8ZzPyMw3UKpoJVriZsvj2MypQ6w+MYNomwkHQyzjeyt6ISUDVhQ08pZPBLCdGBTI8A
         /7o1r4G1qPCmv/bbBigogNwrM9120wmbDbE775I8Q5ePBzeSWuJ/V6VCcjw1m7O56rIS
         jWZqkLwCMIacd/cnlYfpmsGO3AG11mZM8JSdFdkeQgGS3Z3NsaBjP2fx6C2P9DMuWf6L
         USRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954744; x=1784559544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0B/Toi++qviIsvH3wfVq2MiAIIVK6Q0fCtd190RJhY=;
        b=mweVsE4W6l1fbrjDoG5FaN4Omf5A8LmiiF7NBzxCPIyl3TsiLBJuXz+2jb7g3NgFQA
         H2m4oA2KG5vlMMdLReIcVlEpJdAvw9mGJjZGEGphvYe1UIXKGIOp0Ik06jVmsFb0PlqJ
         X3SCvnoNVKsc1or/8ew1y8x6sffcO2Sgf59drHzctAKZg5nUX3Fs2vejVh9HUPUQX3yl
         I+jbL7NmeMpJ6ltOfhAlwZLyqqQAaYAmcPGMipghi3lQeo3D3v4qJO6gCDG79m3dxVBi
         6QTr6zlj4/WaT9/bk6kHwnkGmyY+OYccmQrjczB6fRnxSgKtW3lALONsJkaliUANvcVU
         emzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqO9544k3ZHAAiEM5weQTzkA4RtAAOixeF0VuSUmo65aEzUxZ21Wx5DGu6Kd9KE61qby1Q/Wu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmYKuYnSOqGYuUKJvjCoWjtRbj4pxPc2jbgTlYc5jUcYwQrWZ
	Ccu8ow5zUXcktzC12CFPFDWRvq53nISLFSmLLjTwKegjDFsP/Lt8UfbrhvxMT1O9ruO6yO7J4aA
	zDBmIgW/od+qCHVXTYNg6I8uDAjjsQg0AJlQPkFSsebcae4z7JTkRfwYWUVPIDhIAdSpTWQ==
X-Gm-Gg: AfdE7cn9mo0++dkBLk3jVbHA1/txKE7OHTzoDB3wvAGpzq0P+2NzhiZJU+alGGqbjJE
	xn4jaB9lS6Mcu7sL+yS3eEgpIV3pcrBBkML9wT880MMxZt/kzkNQWdfYCiZQVwwRTqpnKMQyGXU
	HPyvslADCfeXqyPC2YwMVykQF9vRNe/ifZGyUbKt3KVNRIr+4WKblADb8m3ejS+lEm/05jpjwYM
	OkiRYxNznhW+J9/GGATjBPYYKsqs35VrzSoSWGsIXB1fFEbJ1C2j92U7zxgdgMWLSFO2SFFGzXz
	MqPmuD2n2ZX+nHP3q7vD+brA7ohcb6drDx9SkblJcAViROYqUvm2LbtaEQqSxUufceZq9SUr4Vs
	Z277Wzi+o372mEkKm80tKROoNbAnZ8kqtjmLBLPpRrUg9ZuiE0pU=
X-Received: by 2002:a05:622a:1b8f:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-51cbf30423amr92118311cf.65.1783954743668;
        Mon, 13 Jul 2026 07:59:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8f:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-51cbf30423amr92118091cf.65.1783954743140;
        Mon, 13 Jul 2026 07:59:03 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15fc29937esm542450066b.22.2026.07.13.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:59:02 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc: jeff.hugo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] net: qrtr: ns: Raise node count limit to 512
Date: Mon, 13 Jul 2026 16:59:01 +0200
Message-ID: <20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1NiBTYWx0ZWRfX1pSY53ldNXUV
 E7kGrIHe2TbUGJPLV0MhX7qkAl2oCKdeenL08LZydPGthXaDAvTRdZWvnp4fdyF2utR3j+nmJJR
 rzKStHRv3FQmYgnUfcKwfPtw5glgmsuFTLdktkWZZb+dNUEL/7N7liiBnqty0keQ2pwdOy9OdSY
 7wKcULNzd67za96hYJtlOopExzGrZBNyH9epqiRM6HtxF6tHo15PF7qUw6FNfBa1chl4CbyaCOZ
 r/xWDEt2+ajEaPPdcrGIHJlugfc7AJOkEBa8iD0GxFvfhK6PjnMCu4J3c28prvvI5+Q3spd35Bn
 oqMef6ZU1rWFEA9NC3CccWA2QgY97Ec/uAfYDhZF2k1gZxXH+6d191vlIsMJHO7mhkm4Te9aUoZ
 03BmlXsqESpf91v9KrSqW2TPUuy6t7/3xyOV7kmdpQIWsHGf62keibSVEHXYtn7RWZRoTi3kBBW
 eg2TSEdjtJw7DFHQfkw==
X-Proofpoint-ORIG-GUID: 3qA97mWQC3_Sl9sdLFsizEiFbq0TyNbZ
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a54fd38 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BAFur2-UtLnwWEDNYK0A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 3qA97mWQC3_Sl9sdLFsizEiFbq0TyNbZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1NiBTYWx0ZWRfXzGA9xfwpuRd0
 CMVZlZlWKbCMq0iF7BIqDu755+VFWFFNTjDAE8jgO3OeKaJsceYz2wWQnj1XT6zARn8LZb+2vk8
 CQxsk20xKanJY40LfCJ01VxpZZ2aVwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130156

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b3f9bbcf9ab9..e5b2adb161d9 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -76,11 +76,11 @@ struct qrtr_node {
  * requirements. If the requirement changes in the future, these values can be
  * increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 #define QRTR_NS_MAX_SERVERS 256
 #define QRTR_NS_MAX_LOOKUPS 64
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
-- 
2.43.0

