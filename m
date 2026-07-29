Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C33B0599
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338046; cv=none; b=JWm04K0mB1DnkfTQpeVxD1O1KAcaPCE3jGkXKJoVqWbiHvjcc4sx0x4zhJ4++mEjFbFTq3Y6Yd+xJnxb8IUzj/M3CKHbt8wXjz3cxyz6NbmHAuvF1cYJ1EXJg+qgkXDuZYXOK8DkzITzIXXGSKBZZnANBQVs93NfdAT+tdMePXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338046; c=relaxed/simple;
	bh=YLlRccwWgahkuGR/qAGcHaIhRJwuf0+dY8/eR8OeCAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OimWgetyvNeviGIlDMLAzsB8n2Yw04BANFTg6T32tnajNMVmYX0XRZs5cMc8S2+YlknvvNs3dRwSSnNG3UBxGgWleKzV0B6p9zc0UaHZY01rwjNzb4AMkqdiTJ/3NZtSzgjl/ZXT0jHqDpeOd6/l9kMh05F8E3QK975vEDsVc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IK92W66C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/06xAYq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IK92W66C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/06xAYq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF34ZW2357655
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8qIawFstKWh
	94D5qvIpj+l3Hxea/1OAP6TOhstlp7rU=; b=IK92W66Cvq0bq3RLYCGDSjGJzxI
	xLqJwdVCWPAnAEP1lFjgMli2BzOFAT/zv5psR2KFrLc38NIPVNK4yurtGfrrjyal
	xLBhllSxa6Tu9/nbhn7IUboZLimKgtczobd85yCq2n6Lvcl9Kv/VvWI6sDU5ey5A
	fP/+VffZjMNkbSh04Zpv2bBuIgAz+cgDCFcyuOiT1+UNidLX+fD+ib+uF/WpzwR/
	H9DcHA64E+CWYzZzYc+9KjtK/OBWr7/MA6ERbdG14zDujfb10movST2Zd2glOpG2
	KPSTTDul6YJmsHgL4ZyH4WSlIHG/8oVdGYV6mIvLfdSvfQKNCaz7FV8SqQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhe98w04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:14:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51ebdfceddcso12913891cf.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785338042; x=1785942842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8qIawFstKWh94D5qvIpj+l3Hxea/1OAP6TOhstlp7rU=;
        b=h/06xAYq3SS4eBqk7gAN9cxr5vY2QkTs+KYLRw3DjHsGeCSVJbFQZ+hsvt0PfCZpZw
         gUlnqo3UqV0oimR5RJPotUR7GIaHkgV09evCfBX/vydTda5UxVROdEbM/qJIjj/8HA8j
         2mxf10ppEXJlElRjioGXoD+zVA9FhlQAsWofP7Nkxs0oqH1uPGsFWLyDZZfTkajnCnHb
         QVdDa7VPvNIjbk0WfDb6MFKkiPiO28ZIBhbO9Cbsm8HI1EBhjAzbR9PKry8kF2SmZ+bx
         ieJ2Gfbi92kpfXw6zciT/cyXGyXt7FPG0EF5QpzEPgneTmKDd9odeo7vhXmpUSVytYol
         wVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338042; x=1785942842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8qIawFstKWh94D5qvIpj+l3Hxea/1OAP6TOhstlp7rU=;
        b=MeEvxFgg/nna4kaU+8fkZleTMUyQ0jyIykhMMHHf7+jBNlTvWK9okjSUK2TRJnvMzk
         qmZQ5WWOs2zOQp1lD48kp7zhZJBtKGw4vxzRa5R8SK4nzE63qENm6U/Cy+YclT4+HZHi
         Sx2SNK2wIJ6fbJLropB/G3Y5u0GfZU49i8IcsN5uvv+RY6EMR0dVc9SQwLaC8ecOcQGu
         AemU8Nc39iDFOQHF/Lw3oo7p8Y560Lf3AvCg2bspXXA+ptZtype40LOR1unTGbKO88Sd
         h5AzEiuZ2KDZTPGUvlUoEemwI4KcqzbjvxxGKQhPKvtW7rz8kqehONFU4AJzGmgiSr7J
         gYeA==
X-Gm-Message-State: AOJu0Yxwra2X+n6IDMKDxJF4XR0Usi2+IpaJebnb3B6YHLFA13o/H884
	5Vd8KBGrsVSzwiDEwHVwlBTPWQjyURcGDTysiiLcQlif1brEqMybR0g7wdlW2tkNZtNSh9kkpuE
	4qST2Oow3isKBiNXs3VszPDFhTDQGnjFIv3my+FWuCRM8/GsPVRffDVqN/ecKkOG9hBAmjw==
X-Gm-Gg: AR+sD13zzusOzkIHW2rJop4lWHRvWGad9LZpXemEbgrelhhuaVHil7cJ6rEpb+JN3UF
	KC49t8ol/UJ3A3AaBtxCHy6U0QTUSEvePzSxULoCAcwr28zSbUHDBVI2L+vXEO2hDngQamwQF5q
	j6BRxX0cXgpXDEhFoLNZh6eBQU/Dpz/87F5IDsPA8D3G8Bt8gdXd9KuTu8uz9h9RY7vR7nMtr7C
	3Fw/HmjBHmyuJ2yTAbSa/wo83jv9PcbRWUr1Nl4Nzmartd3/ZqY0SXqThp1Z+D1maGnnGj4PwIS
	Z0exYfmu5GIPdq7sCElEtm9Y71Qjs4/RzNKxJIaYQEFbMi3yjjLVtB2Qpy7lZ2ImOKhJxRBBLM3
	HlA/z6j3nxCD1b+iOuxNVflNL9nkPIBWwOadrc8MI
X-Received: by 2002:ac8:59c7:0:b0:51b:f25c:2896 with SMTP id d75a77b69052e-529d6fa0310mr65384301cf.11.1785338041499;
        Wed, 29 Jul 2026 08:14:01 -0700 (PDT)
X-Received: by 2002:ac8:59c7:0:b0:51b:f25c:2896 with SMTP id d75a77b69052e-529d6fa0310mr65383631cf.11.1785338040823;
        Wed, 29 Jul 2026 08:14:00 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c6f4ffsm1010923a12.30.2026.07.29.08.13.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:14:00 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:13:59 +0200
Message-ID: <20260729151359.3892029-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072919-duly-quintuple-1304@gregkh>
References: <2026072919-duly-quintuple-1304@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX7Y+RCWHC4Dkd
 KOK+1790f+Ayyb4JCatMQy7ZWkWNx1hGehtMb04JKRYlu6ufUo08JsAvuKQDqLYVSinxszy3H50
 qlLXnO9czv4miilKT4AIXAC+vumB1Em0sIcbiSAkMwv7Fu18gw+a38W9PWMl74CY+oPUV7henV4
 3u3SoHUuOTEpCK/ARfkphcOntXUnEiOt7V+d0qeDjKY6lbpDjMaRBEJo2/ikyGRgfNm9uzAUV7w
 dsSTQ0yohkqnpnIbHZB0PTz3ugrWVG+qwGdFltemVHFbmEULLU5z6zSRyKYs/WbCCzkYj4TWm5r
 s2izYDUw3nOREtlb0YY3+i7tb0ka9j6Dd5vEqcBf2e+wV9/owV7M8zwCQzJEqrIPS9ZTQyQROI1
 uUysNkktX9OHHbCnjyZcEwiNMelBYY+vwWYW01+h4imAd3sKQPIRjPupdcYUdtrvStEwLnf0iYV
 9QMwsKDzA/9xJg87Trg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX9uJfpK7S9MjC
 ifglgjnsdnhygSCvLsfhjZ33GACcX7DVANo2NRMa26qMbL8DNDBt55K6e05E7+EEvX1CYBHsvxa
 zyfMum2MayhaeYm87mSmOhT97I0mtyM=
X-Proofpoint-ORIG-GUID: mM-o7AJtwR6yQHsASYDSjLiMV5pV7WMV
X-Proofpoint-GUID: mM-o7AJtwR6yQHsASYDSjLiMV5pV7WMV
X-Authority-Analysis: v=2.4 cv=EsriaycA c=1 sm=1 tr=0 ts=6a6a18bb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ff194cffd586cbd4cc49eccb002c65f2a902a277)
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 559aad0e3621..f8d7087e79aa 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -79,11 +79,11 @@ struct qrtr_node {
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

