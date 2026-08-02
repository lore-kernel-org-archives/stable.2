Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1836DA13
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706438; cv=none; b=LKflfw8IefnVs9+CRMvJNh3A/HcivOtVak5TSwQXAHbhQau0OqUOfa2yb2LgCByRFWYvugOxfoxMxnrYr5MzyneJZLk9PKkBBLQxK8Mc9NyqK/15DAftL5rjeEPrZYxSiPXKflof5CxPVWIO/2dSwWf+Rf7GTdKN+Xlh346jWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706438; c=relaxed/simple;
	bh=z4Rk/ENv6uY01OVRCPcVjvpRz5KIbZSMQvZOv9IgcIc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZHkuJUrzbXotFXES3bIvk3OZeVzdY8On9oENnG4KFxd77eFRaoi5rBi/rAuGkzAMskHg3IvFt9bfBZM1i7VsJDnDwEBEsloo4Ic/0P0CdOkIQc0MC/no0mKgKpyOQGjOKZ+0fG4RpQzrwKQSBctcyz4sHptSpdPimvULzRaqR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QuRg6Ddr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMYN2O/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuRg6Ddr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AMYN2O/C"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LXa1A2213077
	for <stable@vger.kernel.org>; Sun, 2 Aug 2026 21:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=viDCMn7GMstA5IlEq3oDLv40PLbuhafG79C
	kOPJ/dsY=; b=QuRg6DdrSyKWG6/CoMz7r+LFtgkUbNjEfaTjYZRbWMBujqUaoQe
	xjfreU8GaTVb8KjTm/nSHXuTVGvvEyMUAUo4OwKIKpKjVl1xU0JS8RiuvMLEOAA7
	cmCIGSpQ84OVptQNsHvNGq6jquVBuWEwD1nRlsJAJhxaQFM6uS3atsFRNKbUr8Z9
	7++TzuYQJGK4J3DmnUt+wIux20okHRv1PBIsw780PNmxdcTU92u9qXqV0T9IEIxE
	lWo1aL3zc49j0qjdC6RvAP1H/8A3psh2w3W1CrNlSl55Q/u5X+via7kWtNSB6MY/
	QtjzPbZspAfSNd6cYhETLQSu2r9e7Ythgiw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftdmx80te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 02 Aug 2026 21:33:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso25275171cf.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785706435; x=1786311235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=viDCMn7GMstA5IlEq3oDLv40PLbuhafG79CkOPJ/dsY=;
        b=AMYN2O/CFsZaxoAJxQyzFRRTFqaeEVS0F/k8H1GBLjYpZicYIDkSestZp6ZwDwBz1J
         68LOsis7nY1AhCU6r0NcI9d/EMA9cBgH3lj6nGy+3MneGzrV0z7FCCJO05ZijOtGhHUE
         IBzxtN3GZI/2/6khfoqYOl9WYx0ozFOwk8NWlHk8PsAcwqFxos6KXRqexB/qBTydGzRc
         DqhXfcIHSyhNBagjbudi2J49vUezolBbCN2Bvtscrpl/fmt4C0ubE4dStDFF+B6uuXyk
         lGSED6QDQtO7xIVDDFq8mt66xxP4TIvgx0OYYan3pOZ2ubPvbwdhwAFddEN+YOHUWVJp
         pAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785706435; x=1786311235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=viDCMn7GMstA5IlEq3oDLv40PLbuhafG79CkOPJ/dsY=;
        b=nQNGvmKjRXcxlTYUGxDEnYvuRGE4tMoU+jzFEGI7bcxPjTN5IOhlCn9pbSjYbGxhWP
         Al2w1uT0T0ZQgBnaLjomzDDdBcKlNkyLTpgMX05PwwQJ3NPFD6YCv8tBDnZZjNUB8YJC
         XZCBkvUNYaoBlH30wWPcgzm6UaPqCcidq2WpI3CSDk8oaxomIcB7ecC+g6ADxGP5VXDi
         FPO51SZhmoei5/kEmAuiFnDX62voXPH21i1nu0NwhqWpIBgillfK0pHCI6MEYKa2cFij
         T8xvR3YZm+w+hV4wYY0r7Ga1Rcc9YLBI1gHw5UsDToCzbzL055ngdcqeXVqIc1vXwlvx
         4Nag==
X-Gm-Message-State: AOJu0YzqdbxJxujxriRE2sxf4SmSsr3gLWiWoFJMgk7naSDrqeJzyLeD
	XVqVgPtJxXXCbjsgZrNxq9qQqGbrBNkXWzjwL1SUFG4XqOliQVt9M3DhZC7lN+HB0LgZDlkJ5xq
	Yj+tfwpm+rM2/40cb5c6gdcsRYX7mVYdgmfxp0aKyOoq/pQxzeIaUVq69IJ7ixVGJgnwf8A==
X-Gm-Gg: AR+sD124OtC9VtPvP5c21e2s+IvI7+fepO4fYIO9FzVZp3d1vjvUAzEv/bCxltPP6xO
	ZMc7P1nOXfkmX3E4ZLtl8/22z+5PaSOodbRV2qQZUExBhyOetcJFUiqJFGeax6XVycexRMvw4Bt
	fulCh0BOSSrPw/MREIDwhfN8k5MBdTCCA2qRtFL14nCC/7zzwFZrwcH2CC1imVKbQy9LZ8dTVtG
	hP0VtfzF8uchIVbK9ky30Xf/wwrQJpgXUY4Dh3l9USOtex2WqSLdQVF7Ckt8KQVRWEd2M4TMqRo
	+Ow19GRBJnWurG67+k29TiOXVGJaPdT4noFPjAcMXIhhL06eCjHoau+0XfFGtSTpDY96VAxc1Jn
	0KHQLsSV9SERV38+1N1h53t2aa1TchtRdwF93CuCG
X-Received: by 2002:ac8:7d84:0:b0:519:8998:661b with SMTP id d75a77b69052e-52b5674e74emr132274951cf.20.1785706435219;
        Sun, 02 Aug 2026 14:33:55 -0700 (PDT)
X-Received: by 2002:ac8:7d84:0:b0:519:8998:661b with SMTP id d75a77b69052e-52b5674e74emr132274731cf.20.1785706434768;
        Sun, 02 Aug 2026 14:33:54 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a0d0a70ae5sm1377974a12.14.2026.08.02.14.33.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:33:53 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH v2 5.10.y 5.15.y 6.1.y] net: qrtr: ns: Raise node count limit to 512
Date: Sun,  2 Aug 2026 23:33:52 +0200
Message-ID: <20260802213352.3885294-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ijK44Wy7MdVAhCZlbM-L5B_51n1V5mRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE5OCBTYWx0ZWRfX/3LT9Fszq+MG
 qoLz1rS0Wp4IoXNALd4WWIE40to6QCKHIhBzhyq5q+AAvq5pav1v4HZSmZk5HlAuSECaozn1tzL
 wSyH5kusiqwEhWMjfH2S20gGiWauB54sEmgvJL9lqYVF+q245UdXF7ndwuhBZ7EPcp1KB1fmQNR
 0Ot4Mkeohwf6h/ONV4s6puc9gYSDcgn+obyOMRsN1MAL+zStSsBmtG606ZKp8tDnRjSDYvvJfxZ
 f0M+mkLXGxCMHKAx8dcnwaP+/KD7OjBKA6lFVuvaO2rlRSZ6dXkDKT3VF17tXQn5tE2qNj67i1p
 vhnj4tJg4ANOtoKnOQ4MEmcQqNHkdXOwpkB87Jardn5Gz6ONaIMc4LhIZn5V1iP7S9co2Z2fd/Y
 0dCHe5liA4Ha6Crtqzl7gPYEUXa01i1pLvGtroWGN60R2TS5Yy3/UFq8GaKpCTz2AehluZ10GnO
 tGK7ErFk1xxqWtGdS1w==
X-Proofpoint-ORIG-GUID: ijK44Wy7MdVAhCZlbM-L5B_51n1V5mRk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE5OCBTYWx0ZWRfXwOFsq+vCLI9/
 xaA0K5DxxHyNk/y4fIdNz3OyiPdnLgZ47B0Fok/FpejxxMqGGaFwjVsgj1ewFW0phDVl+yfEpJl
 02r7wL1zlj9ORPeve6RdowP5N3tS+5Y=
X-Authority-Analysis: v=2.4 cv=L7MtheT8 c=1 sm=1 tr=0 ts=6a6fb7c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020198

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Also, the backport of commit 27d5e84e810b ("net: qrtr: ns: Limit the total
number of nodes") to 5.10, 5.15 and 6.1 dropped the node_count-- hunk in
ctrl_cmd_bye(). Add it back.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ff194cffd586cbd4cc49eccb002c65f2a902a277)
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
Changes in v2:
- Add the missing node_count--; hunk in ctrl_cmd_bye().
- Link to v1: https://lore.kernel.org/all/20260729150958.3889964-1-youssef.abdulrahman@oss.qualcomm.com
---
 net/qrtr/ns.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 559aad0e3621..0b8958b45bf0 100644
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
@@ -406,6 +406,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 delete_node:
 	xa_erase(&nodes, from->sq_node);
 	kfree(node);
+	node_count--;
 
 	return ret;
 }
-- 
2.43.0

