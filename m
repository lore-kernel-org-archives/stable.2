Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421742F7F1F
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702071; cv=none; b=EUg9fT+LDWfH3TlUpLZ56eMqfGFDllcXd01paYQ+ta8TJvVoWwUTNlZcafM0WICTbesDKycXps7fAIx85p2Yd+CBIjrL5V0gYb/KTqhXCbMdKa7LkG7NIiqsdyfv0l7MbQYWSOZOcANCEVZi/EqlosMUbvGL2UaHIfnr3eCjc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702071; c=relaxed/simple;
	bh=n0eOEX9FT5pj9R7KjwOC7xexr27XWTNM8XSoOmfkj/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO39R3Vhf+89SAS9RTGz0dXD53zKkpA7waJXLhtWoIPZ7zAJJqEg2P6ugeh3+zdC3Oq9L+pr26/TJgDQyRLv7Hpn1mq+Oy7U0zg+urpE+mDK5Oxjq1cNaKrfyJTjYsYtR4cQnUvy6HkKymYLvxqhz1wx4J0ENl3w2VrxNkWBDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hw2ydEeY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CkREt7Em; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hw2ydEeY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CkREt7Em"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Eaddg2095231
	for <stable@vger.kernel.org>; Sun, 2 Aug 2026 20:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Fc345opZGe1
	jmY7WyA2q1MUifEgEMItFQB8MsA12J0w=; b=Hw2ydEeYFONXnZ3rXejPwT2LhUj
	W+JxZLA318FJ03ATpbtPsgQcl/cHXff5YewwoA3S0hyFMgd0bKJRJ01fmms7QRQI
	tIR2rLkI7OkBdPNTEdhbRgs1DydZxbEea+ZVbIkyT1rfjLi+P7KKXs1O4UaMvieW
	WR5f88jPNsLkdaosw/Jw0svhm/znawHJ8U0hFPo4M/nmSJrpyYTfbqhZAfl/oK7I
	QiccpPKDxccds9oT9ehPNC5uBrVWzO1wTTu9HwBPf24FqwGlsqLAKJxejC6PAEdp
	4THmuM4nZ7JFoi4kuZmU3klCEPGrHDqI8Pfss3kR3PqvlXt4Od4TltQ1LQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs911bgb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:21:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0199faafso27068251cf.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785702068; x=1786306868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fc345opZGe1jmY7WyA2q1MUifEgEMItFQB8MsA12J0w=;
        b=CkREt7Em6V9KpPKu0TxiK5NkBHntZrNRjtqdJd15Zczrl/MiR3tabM+HrXFZD91XER
         ncnLXX7aG6qopKUetDTT+2z7gRxngK11Ub9n4lMGBphobwJJWvcBBGYsAwKy2UwKX9Ms
         vXZkTUsiTxwhzREXHA1aQmuoSmmF2SDRKgtWd47B8/0boBgQj5DtPie2ym3u2bGonrd4
         94HWYhw4DF8yrX1VMhPEzzZ9FtnUIwQ513/ldhh8YaHY5A6cY85BRkli2jRpfBApV6iY
         /t9YP/pjtrrg3n7O91gQE8fr1lEy9rPG4n9xd9XRar23JgKP0pIaOUkrwVTOgP4Pbfm9
         ysiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702068; x=1786306868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fc345opZGe1jmY7WyA2q1MUifEgEMItFQB8MsA12J0w=;
        b=hWUR8TnIRbFdoVd9WWGiCARaOwSr/sYdSNINWIu5YtLl9qbXl1TwdhTwS0yTBm921X
         kfJlXh6s85LZGYRqdAEt2IjOi4KvIQEuTzICM7fqcAOlqnaF6g2G3svs9zj5OPYXva0U
         aHeMwcvIHGfAgGIVtiD3IESYi4ep2Qjb2MgEcfIVMFfCtp1ybL/k64VSQCHezcQ9Yq2E
         T4nHM0MrGhg18+AG8b/wB6RYpHSriKP6EFvwQCp3ECHe2aDVGpklcKSks/YSElYJjcOs
         owLKiyKXccoKRwmLQmAxQi2R6Rqum5pfJWcC+wsZimeHyx5ESw9hbAmGYa43rp1grnJr
         jUPw==
X-Gm-Message-State: AOJu0YwPGt7eSc4dKaPSGvSTeRaFZj8cavxHAxsb91o/nsXiXpSMD3at
	GCTyMxLLqUjLKSbiNVXzS1sEUVJeP+64g9VrAzbzQiiIkhWfmI+c3xwtJRGvVkxCf5R6BtYQt1M
	+jUNPdWY6clYn62HlQzwtZMiIkAbLLwYhAVkSOLuMgJJTZd+MNfUkjzMC+OToyLyEBDj96w==
X-Gm-Gg: AR+sD12mi+JrAtCjeu8DKnqpxYXoED0bcowiVIYxvlgI9SA6xNLJHkmmXucPXDhn/7Q
	X4m1pZ5xETdI3zwA8bjyXpTLXJzjTxv5rKFiWW8AD8/h87v8hlnPTIrUuWBVdXps7po80RvS2n3
	y1JYre7GXcip3lgmjeEiUOhMo0pkNuLvwP7xwNdGd3cMo9hZtgUsdyZRTjU98sWLaf3br2sYIeK
	XbmSgwEIs+KEIkREtqHJJ0e8GT4CraHaGDP02YZJEyvsIQWIvT6+2jchtxkIy9q321nBdfElPTV
	Cc0dgy/C1ap89yz/xSihRUqRi1J1J+n+SpqG6RZdPxUeDbVEceCR+JBFEboaaof5FSTvXdJLixU
	W3Y4MbWDE/P++6qjAD6IFgAJP89MmXIAVBVnQgkWe
X-Received: by 2002:a05:622a:d5:b0:51c:1eef:4fb6 with SMTP id d75a77b69052e-52b56696317mr128879041cf.10.1785702068390;
        Sun, 02 Aug 2026 13:21:08 -0700 (PDT)
X-Received: by 2002:a05:622a:d5:b0:51c:1eef:4fb6 with SMTP id d75a77b69052e-52b56696317mr128878751cf.10.1785702067928;
        Sun, 02 Aug 2026 13:21:07 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd445433esm466414766b.30.2026.08.02.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:21:07 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Yiming Qian <yimingqian591@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 5.10.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Sun,  2 Aug 2026 22:21:06 +0200
Message-ID: <20260802202106.3820763-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050104-esophagus-relieving-ac31@gregkh>
References: <2026050104-esophagus-relieving-ac31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfX3NfdfTB/O/xg
 h6LKwfbyd7CBK53Jxo0+d6QPhJBROdPUPSq6Yg8xM6rF88KIFyoDH6HYrHMCuQaaOOPJzR5AA22
 j2UzlRuxzY4T/13oH2J2uBfhxGp5Ri4=
X-Authority-Analysis: v=2.4 cv=PvGjqQM3 c=1 sm=1 tr=0 ts=6a6fa6b5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=B0W5Ij7fcqf5pJQDF-oA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: u2Qds8sNJ9FWAy6GnIWfDr5lh_RXSryP
X-Proofpoint-ORIG-GUID: u2Qds8sNJ9FWAy6GnIWfDr5lh_RXSryP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfXzwo4LEQFx7t4
 7/pdca0VjP9iJV6UK7DUoXdz6BtQIr1DhstvRA2r+ppLIytpSGaHlNFxzt8rER6zPli2o3tZqsG
 sj7oUzpNOBnbReaz44kJQdsi8EvSGqMFx4iX92yiH6JPXrd+lGgJvpvpf0sPJxxNgbX2rYPjbFT
 93p9hg3OeYw94IUwNLyGx+2s6XPmjdFjqg1OPnVvvzZiS2xhQVENHHQ1TcNonj/PWau0F+lwDII
 evdN89HX1a9NsWOVrQRYh6Xm1oMOCE9//q294oTRlxk3KyrilVv8lbvzWmlEhCX24P2Iiza9BdB
 JbNh4wPHEY8znJ+j6T/6z5Sitv3JzjaLZHot/wc8oh6ILcCWeMlQrk9xO3XjVlDOjrOVK0PFgJh
 VbSzYtrk7bo/wxeRRa5I0FiKcHRWDJ0WmZBgiKG4Hxb8ZE6tknhIWfYhM0ekj8PxoMgvami+nfK
 jM4fi9K44zLZaWPjLEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020186

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Current code does no bound checking on the number of servers added per
node. A malicious client can flood NEW_SERVER messages and exhaust memory.

Fix this issue by limiting the maximum number of server registrations to
256 per node. If the NEW_SERVER message is received for an old port, then
don't restrict it as it will get replaced. While at it, also rate limit
the error messages in the failure path of qrtr_ns_worker().

Note that the limit of 256 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-1-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit d5ee2ff98322337951c56398e79d51815acbf955)
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 36a7a9ad6b50..440e68601e25 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -68,13 +68,9 @@ struct qrtr_server {
 struct qrtr_node {
 	unsigned int id;
 	struct xarray servers;
+	u32 server_count;
 };
 
-/* Max lookup limit is chosen based on the current platform requirements. If the
- * requirement changes in the future, this value can be increased.
- */
-#define QRTR_NS_MAX_LOOKUPS 64
-
 /* Max nodes, server, lookup limits are chosen based on the current platform
  * requirements. If the requirement changes in the future, these values can be
  * increased.
@@ -249,6 +245,17 @@ static struct qrtr_server *server_add(unsigned int service,
 	if (!service || !port)
 		return NULL;
 
+	node = node_get(node_id);
+	if (!node)
+		return NULL;
+
+	/* Make sure the new servers per port are capped at the maximum value */
+	old = xa_load(&node->servers, port);
+	if (!old && node->server_count >= QRTR_NS_MAX_SERVERS) {
+		pr_err_ratelimited("QRTR client node %u exceeds max server limit!\n", node_id);
+		return NULL;
+	}
+
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
 	if (!srv)
 		return NULL;
@@ -258,10 +265,6 @@ static struct qrtr_server *server_add(unsigned int service,
 	srv->node = node_id;
 	srv->port = port;
 
-	node = node_get(node_id);
-	if (!node)
-		goto err;
-
 	/* Delete the old server on the same port */
 	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
@@ -272,6 +275,8 @@ static struct qrtr_server *server_add(unsigned int service,
 		} else {
 			kfree(old);
 		}
+	} else {
+		node->server_count++;
 	}
 
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
@@ -312,6 +317,7 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	}
 
 	kfree(srv);
+	node->server_count--;
 
 	return 0;
 }
@@ -716,7 +722,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 
-- 
2.43.0

