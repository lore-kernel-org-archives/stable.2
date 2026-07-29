Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5A3B14A6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337994; cv=none; b=ZRxXGVQhS6b+0jrbF4+hLdKaKeWxnUPO2TYCS+i+xQos6rjZPntf8hkVNWrI+EsqfcUtQoHYGqJBzltNXQDWI2ewuVFtscglQQ93kzkKBYGPT5xS2iXdm8g1ybEB4oOds+sSKo+83xGzzHgx5oby18Dm03q4nQE2YIN4wANehJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337994; c=relaxed/simple;
	bh=5A4F9OzpzAJOSLHHOXu0wxR/WJpwya1owJQsO4wHwPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me/XowQIjoeCIsld4wPNu9Z+kkbF9Repnv1WUGY3WlZn+JkIo3lrBFr62PSB145OEC3buN8+JdR2+pIYEMqlxBqOWTk4mAchT7puRlen6Kftfi3CHbprGz3rjQKQE68RdP4L03z2fb57XgNiyxO5F9QksrfVTGg6JSKmS+ZYSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+42Dugg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B058FPqC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+42Dugg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B058FPqC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2wI52397314
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oMcC12Uc+jP
	zmyWBUKpG+kqrN2QEXuYgKA3viaiaGsU=; b=l+42Dugg6gCrqlt/TCMF90g41I8
	7BddhE05SF6aiuSkItS21drYWO4n2GFPrVqG1zlspp8k0tWEOUe00O4L5Yd4i0JP
	tFGB5cHeENlUp7z2yfQ/flZdgaw7/H8i6/3T6g8DiynnzQeeEnnh0Tz25qJY4R1u
	K2uwTGWnIIVAWM4aiO1+seBFloJznySp2XN6sELGmjpSziPppfLYAm58OnFPEu2n
	xk5PJz5AGDa6c06Gu7o2Vhzbf41L4KPsJO1+mfo4lw1RyWaWaksyNwnbikcodg++
	8EvFKyxIBAEGFBpBpM6jj3nJZoN+9z6v1qjZh54VIP2OHkxSYNBH4HyIEYQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr690x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:13:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so11516191cf.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337988; x=1785942788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oMcC12Uc+jPzmyWBUKpG+kqrN2QEXuYgKA3viaiaGsU=;
        b=B058FPqCr9AOEh9xnd10bg1sIJpSpXh8jrinFY0SvHsuoSa+omPxGmuPXpE31u7Ih4
         vU4nrNl4zg93yUXaTLTY76/HoNB2isBKQex2YTa2ZPbaP7StZSbugHmJB4Rs1L+VLnTu
         dDaSosGAxX5zVD8engBoXD4CJW7L8gSgC5nr+LX2xtsja0jPu0Rj0Ipsz0aDDf7tYkWS
         kYuth1aipgh0WYE3VRttWLckkfvVSWBp9ubDNlGQyuarpBb6H0PMymxEZ8Mi98bBqqSs
         I1PDZDfVed7mDjuRhxaZr0+Ie4abqmX16S2R4DMo4OsBHaZGo1BXl5ntA2kjCjJvfRCx
         b6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337988; x=1785942788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oMcC12Uc+jPzmyWBUKpG+kqrN2QEXuYgKA3viaiaGsU=;
        b=DT/QMqF+5/KM2LKTKyjFBhpBjpfeEkPoWbZQ5lbcxk1prhzRdUqVB8R/GJ9xiER3to
         DELsmqQG2ZCTi6WG7L8nhb6Ozy20tHLmMcaVBuKg1p0rMsjRlEN5uOyOSVdKSEFJICd6
         ODDqz3IT26bnK+YpNfbPF0gcMvazsOiaUDeYT1uMyxtU3JRI8upvTOvajalAn5NNR3q7
         rJvHSaIDD1Kqq2NU9oVTGrpbCfM/7EJkJz/Lwcc2YMInY2S1FXwpHUwjxdqXQTS5/3ga
         dm0zQXdF3PnxWZGC2hcJRZweAG4X+FNyHT8iXQ7c1aWiczB13xC7HGc54Sqj6Kd/wHKE
         Aw9Q==
X-Gm-Message-State: AOJu0YxqRPyMB+7vI93WnRj3YpEHK7Cgj5LIdZ6O8EpTq+/FWt1HHWpy
	PVhACflP7mnc6u7XoKWpIJQw3VE3Gwh44raVmAAjiacmsjGlF09waGIZLfPFd2g2odHotJK1G5z
	Ydo1pGneOWU48xwtlGsIjHzWrHL8REAzveaLiPuEUP7I10Iu2fE1o/TR3poODhRdO/4Dsng==
X-Gm-Gg: AR+sD13fIZ4u+EDWWo/9TAwW0Aain8fwy/YZ2qG93orjCg/N7j0jr78tLfdszy0BewC
	X2cATUTyvDUZQFDFKxgTkt14HW8MbsblDhqM9YxAivxXki7XH7RqB+hMBkNueLPbYq+9WJRu+77
	P6Z7bkIjNvVXXSG55j4NCRppNsab82UqP62MR7FNSGv+pF+8ytXUG8tkihQNeXMoitELflxXerd
	CJlHdt46JsAUrgDW6plB5cxGH0aFdPurt+ht6bR0lAOtJX0pD+9rQWYXZKI0PP6Vo0GqEG2ha+F
	52D35jCL4L2VjRfqvkTRzxfyUNAzJlaMfRcacvvhQNSHyMnIKVXOUEq6E2ZX/y4qCCTDCO8kc5r
	jUyJH7m5DKQsPvap78dkI5i3GpoR0gBE7BxzOJu1G
X-Received: by 2002:a05:622a:110a:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-529d7274257mr66445831cf.85.1785337987092;
        Wed, 29 Jul 2026 08:13:07 -0700 (PDT)
X-Received: by 2002:a05:622a:110a:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-529d7274257mr66445351cf.85.1785337986553;
        Wed, 29 Jul 2026 08:13:06 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050be87bdsm998293a12.11.2026.07.29.08.13.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:13:05 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:13:03 +0200
Message-ID: <20260729151303.3891482-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072919-footpath-target-57cf@gregkh>
References: <2026072919-footpath-target-57cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX4Tuvnsc7T+p2
 /pSbxDWPY6eABUgLHFYqAbMlhSYVNB1WEUkWtERSQhdAdpWfHuxpsf+E5ItsHdjZuK9I3ee3Adg
 jZIt9Q6f5QGfN79jkSirdFuhNGjrp7r9mawd1/U9qu7cJMHO8oc4KsdrKPM7BTQbsVqumMcf5Oe
 tBopBCwTa5aFcQZ5BXp7YaoNde7fzRnGvHzJdog/W89pDzNEhRPTVFz5ux5UqVUxQRmxieKZcc9
 JFefLQaxTM4jPeslhqAWOhhj3SzpFZfnL5PyKgxdN4tO++goAhldwm+JWZD0GvWwt/P4zoW6b0R
 h2huR7Ki9Y5tSgeNVxWhojjXbYUshwnfewYaj7gAK4qNmlKIHJ4D273rE2c2EjuHpaMSEp2pO46
 22pSJM8yatwYTA9OKUWw6BxcY/ECrhV/53V1s8evduDq+jv/Ui2LwkmcEPU9Bwziiv46jVzuLL8
 l1uA1HkQDkpYjPSv4uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXyxKiCgsM5YGi
 DDEikhdVdAExTot+y6I4Gp15QnPL1GzUX257HL70Ll/UwM6HWPHYFDsF54q2ITPl2YvfVuxlWK/
 xoOJBcesPBKQmh0Cg8qJ2bpmrG9qzjc=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a1884 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 1IZZkd67N-9iWfkCPzxcaSYIphlvnV3S
X-Proofpoint-GUID: 1IZZkd67N-9iWfkCPzxcaSYIphlvnV3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
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
 net/qrtr/ns.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 36a7a9ad6b50..6cd123b51192 100644
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

