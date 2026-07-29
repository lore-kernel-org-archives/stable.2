Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3E38DC6E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337539; cv=none; b=YuJma8OlBIoF6Sxq7N5BcpLtXPF+Lr4mO/OvMRNRV1mCG1xJBTQ1JO7CZw2gAkb/ceh7BMDPQxcgaWEXYZe8Xi5Fz/OSAu8lAS4sdLNn0qKxrZsp7X19WFKiFJkaoUEa2EkVPE8ARowYQ/1SaEEz1HCEqL3cPMJJNc4CKJdHYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337539; c=relaxed/simple;
	bh=iYNvM0VWoUcUl8Y0ZtXR2rGj2KBHtKlWcp5d32YUOfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gluW2cx9yZUC8VhErk6APvP5z/wEuhCRZKeagnQKHJpfIrU2IRO6bpY35ilfDwpKY4UrEw/3RI23P3a+r2uplPJDKAezxPzeEnAZkuOWabgX175THbwoDMgMc1Hx3tIfFrKX3OeDv/0gQq6y0/KBK7RFkUMCdp7W9qAB5pd4R5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVteJ72n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pf5Dc//g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVteJ72n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pf5Dc//g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3AU51700409
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bRzszPUe4oC
	QRr/QsHA/75to/k+W6isyT0GVy+U+h2c=; b=UVteJ72nIHQ6UfjwXwZhngrMTXC
	fjO7OeMUBZyIDD+SQE3PeuMmDJ1Pl2ejKcW+E5ihb8Yzyh6mpNIlnW1r38cUFPfx
	i9PEINOa2BGJh9inDopLgXgyXvjhosPjtNQOJeRhrMuD7c9lASprZZ8HBg9o3qM1
	LzRqO132UMqn2BCDMZkhIDsVYzKL8AM+xbnjMSMyIlD3f4bMtvI2F+mFCtdkL1Or
	rZNH64/oHE1Jejj1wGpiVZnfi7njIryRzupz04IqPftqUHTR8ZLbHfA5mtMxCfWu
	Mlq2csqH+Cnjt/rDWbrZPWtgcJVuHU/m3THlJ/EXYMSqrX/NeU/pZdAGDyg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj0yaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:05:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9776c59435dso144286241.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337536; x=1785942336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bRzszPUe4oCQRr/QsHA/75to/k+W6isyT0GVy+U+h2c=;
        b=Pf5Dc//gt+nS7Dzu5ekJle9TK/LiMN8JdTjtzEPjwpKx+zEa7KubkOVo6qWzNWO0rN
         nkcFqt00wflx3N3bWoFTXIug2IMBQaTIAT6g2YL4x54dfP15W7u2p/EqAWJ2yDNK2el/
         1nsO0jPiQAUEPniYWIHIpDmb5O8ljz1o6HHg6QOle1QkbrgEi7vRMaFAn1vM2yOXnjXh
         ws5ZXtYIP8g0ns8YjrPAotCvRHYQN4ihgm6zXTysk/h1ppAMStpf9lQYB0J7WETYTJqh
         KAfcXPtkHrzkOne0SI5+8i1qjH1WOCgJ6J4uQJimbrT1Ox2nKAjE8e30YRTOv+nrCe2h
         ijYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337536; x=1785942336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bRzszPUe4oCQRr/QsHA/75to/k+W6isyT0GVy+U+h2c=;
        b=S0pQCtKLu1vMFgoYJfFeAFNCZKui6rLIGtIAGYWOKNZoASMkEqPhngO28ZCOM565iG
         XaCex1iQ9auQY0ecS0FOMgKCpotEZT/sx++9LX1sTAUhxp34NiVfB9mqmW26YSFhqyos
         VY8RSYENDsHOgksWZumVoRkU3lbFJVaxoA6vzx15r2NsX/KzmddQN4aks+/ZwW57KTrU
         Aa/ip5JBwlG+WUZ9VtsCZOzjBKFaWH/t/CGJWl6rcVIz/YnR/+u6II/In0HyehYWu54b
         yFKREERgXDBPinHGinOuoI0hxQnYM6eZF2Q6wi7nHOzsD2ndYZiSlbIOpv2xDtcrVVYq
         /zDw==
X-Gm-Message-State: AOJu0YxN7e6AzCD8C9ApULkHzCh8mzsjUNEQ+nnK5OhT+1/S3pSnzVtd
	ubbNPNYf65+SB1JU6IumwfIT0aw1r176GlYLAcRLY061vGaki6n1MLgK1mygtILnfa/WbLc/Eyv
	KjHb0uq6/yGZgRHmLKxE3bUHckzwVRBwCXjfTRk9yLgsWv0117a0jx2k5QCHNYhmAvGen4Q==
X-Gm-Gg: AR+sD11ofxpjY6Io91SBjheLPLs15ukCaD1coBhNsK7nZB5uuPp6dg/SFhM437TMiha
	b5CNbXfh0m2BVNGPtnhZFptep1+ghGMXRMdVJSV85MOWnKxk8NVO1FqavD+FXavSSZH9I2pM9Z4
	S0dxc6BQz5jxbsL27qhfL9SXLG7QcI1dj/vwfh6dQ+Dx+p3QCP+bKrNkcihT3Vs2NLJLZuRk+jL
	ORAgWPNemzAn/iP01hni6CXMHsvr5YmX5ibMhCmvL+E413g+neUJJpfeGta5JUk6HFXi7LGjHNp
	EKIdy/H8sw2uEa0MVZD7k7kAMqi0MJIIXpN8cKRscqQ+JUui24RHZlqqKfw4Lvk63a5Rsa1O3FD
	VgbBLf/gPRUtmhJSujG+Malls1/GDWIkWuyZYozjx
X-Received: by 2002:a05:6102:3591:b0:739:71ef:d772 with SMTP id ada2fe7eead31-7549f34c235mr3276224137.4.1785337534310;
        Wed, 29 Jul 2026 08:05:34 -0700 (PDT)
X-Received: by 2002:a05:6102:3591:b0:739:71ef:d772 with SMTP id ada2fe7eead31-7549f34c235mr3276179137.4.1785337533605;
        Wed, 29 Jul 2026 08:05:33 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cdf521sm133347266b.17.2026.07.29.08.05.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:05:32 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:05:32 +0200
Message-ID: <20260729150532.3887022-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072918-freight-unsworn-15e0@gregkh>
References: <2026072918-freight-unsworn-15e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a16c0 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=TD8TdBvy0hsOASGTdmB-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: zyewy36aCsOoMyOSkuD32H-rf_LX_Vsi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX+w8AsUEuagXe
 tQ+9z5uTnRPqj59UE5N8JhxvqRd3HRFrg7H2idDpEce0T8cILTgLpBWawtqFD58KYtEPcpl8ot9
 cEOBVkhsS4z5+uvfAGuRjbNh7RY726cCmevLKXdppWzL52yb4+4XTBQ9h/jd45ITGQViNAr72as
 /azLkMcCFcj35aYTPPTL4FVVf/HvBk9cCOfExa5PaVR2DTQquJgndbMHTMfBCkYX3WGdVzXnaG7
 E2FwUoU8AZ0FeRsHUE5hEv0xGPBOPZ68nZSq+WWWleJpH7z4yZphX4PKbN39fMqsr8UvLQJu5nZ
 Wn73oA32xQdk1wu+O7L8rA/NXp2iudubfgBoGbw8Roae1Z9ZT93v/mBVMY0PgkTlC/GXAQkl0MQ
 ka4phXibGBf1y75bICujbS7UG1WINl5SR5PNRLzPq3VVzb3GUOvPZl7bnWG8zED/U7kldMvg6PQ
 WEt/YlVlaakrIgFZOZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXwsowgjpHaHr8
 RIqPBtx3H+r0UWq9/e6hfPqN06ZIAfaGsaCES3Aa9FZsAKsdSi2H19JLv4qwe0+gjQUwtajgV6T
 qAGETGEdSTH/nvJ3YgE9SJYUxN685aE=
X-Proofpoint-GUID: zyewy36aCsOoMyOSkuD32H-rf_LX_Vsi
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
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index ecf49172307f..90244ce7e95e 100644
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

