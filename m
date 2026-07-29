Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A23B0582
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337804; cv=none; b=EfK1nJvehEbrGnX1GhfSC7e/HREyry/ZOSE1awlXCJcyra5oHSc4CabJXuH9LgJr8WP2AlLcWTxF4YqWiLjbnccAwPkdwPY3J8KlUqitvd4TICEXWfc8zf+T72CyaVxaE3qbrTW5EdalUrcpukhK1dvVPZ2oARapPMImRpEVYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337804; c=relaxed/simple;
	bh=rfcSuXgHo1NHgOssCmVmxLY0vvAMZ5mzlMBzj6h+CsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDiE1Yoq7Tn6/Wpf7VmLC82hnNEyGp3ZsoDdsFlbubyDsgGrjaW7LfeiY5sI8K1tdoQRCBR3ZkrCbcXK5mQUsYRiahl7uW2KA6px/WiW1femZxPHVOLVfjVNs+2N3UlZHh9OIQr+FyXSyvDN7qar7QW7al/fKbUHwFNQpsx2rVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nH21GuTc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AczUU4Rv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nH21GuTc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AczUU4Rv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3Ged2194945
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OYhEyBb9c0c
	clI/EIx/LzoZm6pf/YqrZ7Py7ePryB5o=; b=nH21GuTcw4HoPddeMwmQEym1v5m
	sZ//kbi+aX7dvi4xYVL2MLZyBy9qFojaHN+iF9uqMjmaRU9WU09k8U/zfF1yiYja
	KoRPXTFchosTsg6hKA/gY71hXt+ynj5zmjetnu585jEFJgVoL8u3OfgaGmdLW8VV
	7bSlTeQgcwn4XUkGlJ4AoovPfWX6QOPKVQRZHfJKhPrbgi5Yz/Ig9qlyTmG14I/T
	KTCinqTRWZ/e+vwROgOvt5eHg3FFxOVgtw40/sRKx95RPxjYYcBA5md6i4D9puGz
	6Qg6IF6w4R2OwKKTbes3810fkR0JUSoaxkwOedoWHRP6rrjdonluocVqspg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm85vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:10:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d7886cdso20232231cf.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337800; x=1785942600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OYhEyBb9c0cclI/EIx/LzoZm6pf/YqrZ7Py7ePryB5o=;
        b=AczUU4RvKcaDbC68XLS/ZwPGW3M4mUWhg7Ig+ZgfgY0yAZIjaDkpb6kjWBy1AyQou3
         ID8Ndm58jU+G3guaeYKoVQkuhXtHkf4wjGLA1+kYeMNiBTrRfgcYo3AvjmMkfpsmwFMm
         Kga3KP9+fb2jXR+VKI5KOx2PV3wD0VZSiZsu8j6gdZGOuAzpxdM/4uPLgWJQYonLJgwJ
         Uc4qHVx21gyG1F5rhCcPw5YVrJS0fXkRrld/AcFi996WyYyN60f3MAI/od/JeYzRVuop
         WPHF+OimYLZm/ayxc0J22aznXgDBwyGmRwvg350ipRXbZ8xK6ojEbLLbWhtyY6pL9QV3
         SWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337800; x=1785942600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OYhEyBb9c0cclI/EIx/LzoZm6pf/YqrZ7Py7ePryB5o=;
        b=YZy8Jb444Zs3GH4JqmJEr55CmVq2M0oAAjH3M8kNhwvMTMrgEHx0F6j9l+HLfqMlWF
         e7iAYoUEjo5TndVxfFFV5wCEcB+WFsxquqvtX6fh58YAojNn5Y5X1trG6dAN216mb9eV
         WpT0221x7J9hwg0IAXwkoDXPCFdIA5kPqE/iQA8jqTWB/GtmAXwo+l4bXj+ENLILTjVt
         cPuB+6J93W36mj+nKhqyY1OSBNqsP2moIcZSUJyOl1CVWUzrjh/OLWrD7ffgUnOBCbs4
         oBFrnboZpQUoc0y7gtM/msL5F3up/mN0TckrKUJDIKzeCFf2SdyKGx+YQTNPVp55Ui4/
         8tgQ==
X-Gm-Message-State: AOJu0YwFVf3Fu+qFOjfyAeMALXehKR3a/41u0bfGm4ixHqc3Tthf61Fj
	Sak2J8aTXEBA6grUmKSJxwp7aBRRUbihmi2eWEHhFkZOVhIscLGh/jUEwhWZK508dG4ZBheT7mB
	GgE7YtDSgatEBx4z/n+QiH+8NVD2hN2QonnW9YLQOt6Cl/ilSrhXNo60g9h9fsw+8I1yzHw==
X-Gm-Gg: AR+sD10YvJWUdWH4kU59oC+Zh/ahW+uPL1gEFGdxAN6+63MU7DtqhTj9z5/amZpBATC
	080tIMrTme37UZBwxataL/hmjpLDYBL0AcKVajKI2Rpy/K5CNaVtRviefR9HKmvmqob+8wCQz7P
	gtOMWzeg+rfLDmBD1xiUKT1FwgrYIqy/iwNSFuKNldeIGwBKp68kpANl0+yWo08kj/9ScKvSzFO
	lge9LobUCitYRZizXMWrhesrBFZH6LTvTDyJHv9Swg4ZedhqhZ7srVtlIWNojeok3MceFAVT8aC
	5lIBVMNeCkp1jR9MOAweczGXBENk5EtVtVi/L0v6WGlm+UZcZQEc5jNsSZ/VUitWeyTzNTPxB4L
	C9AjMTKNF/FvoYIgocIzC9/GkzJpaTWWCT2/L5Wuj
X-Received: by 2002:a05:622a:5b8a:b0:51c:7b12:5fd0 with SMTP id d75a77b69052e-529d7182307mr63368521cf.76.1785337800513;
        Wed, 29 Jul 2026 08:10:00 -0700 (PDT)
X-Received: by 2002:a05:622a:5b8a:b0:51c:7b12:5fd0 with SMTP id d75a77b69052e-529d7182307mr63368221cf.76.1785337800105;
        Wed, 29 Jul 2026 08:10:00 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83ce0151sm128945366b.20.2026.07.29.08.09.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:09:59 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:09:58 +0200
Message-ID: <20260729150958.3889964-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072918-throwing-steep-c08d@gregkh>
References: <2026072918-throwing-steep-c08d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a17c9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Y5-aNsUz8OcWo5tvpmFFB7XxgoF0YRPM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXzp4OkJ9CXYq/
 dUzTbe/RLI43z7ulmSPs/CLEJCzE/3yQ9YM6jr4E3StNfORr3HW1qbRY8ao0N4rI3uTbFHRPE9d
 ++GTfKhUbWvZij5b2oDLS1dw2L8DjG4=
X-Proofpoint-ORIG-GUID: Y5-aNsUz8OcWo5tvpmFFB7XxgoF0YRPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXy8bOGVdbznq2
 +Y6R0cA+9fTUmMJblj8jMSLq/i24YmyqiXOCTMAagokqoza1jl9h7WwNn3dzXeGuRHGMxfAhyuN
 63vPo2CnN8AW8rYnogArC8Z9A3X0EbGwTp2IEZB3U+6XjWALkGcRMFwkkxaGMME2UErycotuGA9
 n5Vk5RgqRusvOdqOCB005eKtzlgOAv+AiamuBzqOr+dO6qp5F52rFrBqpOrtm7Mv8PCM4h77qDm
 VcTAGHLz+8L5GdGEr1AnP0TPpzNaqPXRR16AE2FUaInp2vIZt4ZPIYgW7ptBMv31hrBMWA4FL2T
 K4TZLLmtHGXlfeTo0PGJwMkd1i4eka5/Fu7ov/DZChhlFHLzvhGSM04B1IapEVRs8Jp/rbMuBtW
 E+HhrgIn386cIpllHhdehIeInzdhCOgebIFTiCT1A0lz20twme2vMNGR2cc5MNix2cTwfN3Mu4r
 mkDc1oHDEoMBOlSONGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
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
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 559aad0e3621..8aabef85e34c 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -70,20 +70,15 @@ struct qrtr_node {
 	struct xarray servers;
 };
 
-/* Max lookup limit is chosen based on the current platform requirements. If the
- * requirement changes in the future, this value can be increased.
- */
-#define QRTR_NS_MAX_LOOKUPS 64
-
 /* Max nodes, server, lookup limits are chosen based on the current platform
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

