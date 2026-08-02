Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8325B0AE
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785701911; cv=none; b=GAiHuG62k6D6H0vkKZNUgXATjXf9veuSU7GWrqbv/S4Xsm4hIzsSeh4smnX6T5Hf8kJpM55ZhuN8Rkn33AxbqWMvaYCl2nLZLlh2KCrht7MLsfHsMVHlpl/zMVuN3qHYxOm0yV+YLn4j093GCLxKFUb/IQYu16hhdzVAyDlocm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785701911; c=relaxed/simple;
	bh=jkKi2YAbJF7AI6X+xc/+EnSTdgKmUW51DiogjBU7UfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYA/QcwDAGDKshRU1HeW6Dt1lfg+TE59vZqV0jsJ4cSVJ+fGInx5kSbcG0SCW1x8KCYTmn+iU3x5BMVJuPdQcG4xXtdur3+d+M9scErQfZ30oy9lfLjvdsXZxXFUIQ1EJZCQ9W3GAMTC9S8gd4md1oIb15/RP4ROPtt2YzKhC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgFiFTSD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LwF4RRqU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgFiFTSD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwF4RRqU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672EagLN2095276
	for <stable@vger.kernel.org>; Sun, 2 Aug 2026 20:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bdW3b3yE5a5
	kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=; b=mgFiFTSDTL9oGvqKPmovZE3ioxS
	OpCveqAmhSiri/IkPzTgovmrK81ASEw2W3UIqSA3xhx+EgKyGJ7qNzvTPujHDZqA
	mM7s7W1ms0kbB/lhF72Oi6DtgEcxbf9QGmnc/qP1vXVrI6b+kbUH/98oMMFcfJ5d
	9P5QxeKzQUUUGoxG8FIHlgDHIbUKz3mFyywPi0utOJQfy1CvM1wNDwjJqaUkGpqw
	Vktkw8pEXM9ZHFtI/9Tsxw9Rdb+oNH3yZMiZQLnai886NW006dYGMizicYGXyLqd
	WRNV468mjzDLrXEl+GnATFW8LY3LmNz7DPRixNSv0Am1EPSpPsHs8nlnP7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs911bg76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:18:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c20762d21so30537191cf.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785701908; x=1786306708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdW3b3yE5a5kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=;
        b=LwF4RRqUYwqnawsk0X0M9mfS8CfEGnbBcRqekNrv41rZM9KR7hhGym3lgKi2El0R6q
         pvfwv5YexTgcBXOkf8N/lPCJ2eWvEuBESLdcG0P5wBFB4P5czcSGTSxgX2rgWPGt45Kp
         44fTpjBgbccuI8OdZv9RoM/zidYJmkg0tiMfMs/II0Q4VsPpE1Tz0k08VGECwSFKKOUz
         ZlA3kMcGxnfZ3t4Sm++BTNQNxIbiSSnloK4dNpKXw5SA8XpiGckUyr6GI65/0Z20Ilah
         o/5U+kTH+k04cN0Fh+2JqODjNn6UvtyLUyG+XC9dykY0WFiR29ZJVx570BFLmslLieqP
         yvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785701908; x=1786306708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdW3b3yE5a5kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=;
        b=ZBNo3hrKB5GjB07+dgU0ZvA+F4IDTcppcj884DHZEn7P9Yck42PPTyQNg/cPdmG55Y
         x8/fTEZ1S5qM8Kl9JhGFDSJJgr5BSDQADnR+aAonfxHoUGIPdMxVA2vGPJI1FlXaARr2
         +IF9b585fRCQbcQOplZ8OryWPWG0xY50RS7FfiJCRd8+rQ6l9W7oUC01EFxcAAGKNPan
         aUfgZwhLFoHaiWbdHO30Rze9FuYhS7Aunse5kQZ2uu4Gtph8Lwlxq/GyD/ADoVg7USap
         4xNaTi/0ItUyVGKGhP+LD8dlj+TvPc2za2hxUC+n5NOV0GhO7k/DgmICDNLP8R8aKvl3
         pKsg==
X-Gm-Message-State: AOJu0YxMvv9MbHdnejA0kGdfpkkRevKkDDxkKsjftwAdtWj38dZegiPS
	UHLF8vMYHszkhJICVQPW6EzpEghZA4w1GKaKNF0xQPJMRuYnIXLoe7VhT8rPnYSwrbd4QjRtgEK
	IzP3yr7lgYpznxN+StIi3S5ss/BNPJ5xdOJIKgRtMvyDcjyVyKm9+R+uVU8zNPvblDNE=
X-Gm-Gg: AR+sD110hk62hmt+7j6WN9HwcDK1m3MO5n3To2NVpr4WfYntDvUZEUGTuI2Lytoh94v
	qv+SL+LCPPp8Tm+8ntQ7YmUH2dYCG3dUXLZaDrIiuxtjq2NqqBD0TG4ywJYd5XN9o27935LOyBs
	8P90r9lyB0N9pXVMURp2jBtuWD94W85IbFQPKOuBut4Rk/NPT7EfZTKxmrbsJq7M8btOAUkOIu7
	kuGQOY5ocSHklaLzxxeKoYTW601y+5uX672n3Ftfo9DD31eZ8GV2gOlA+lfG7Is1UNwtWKz5YGu
	qnfIA49UoxRXVoLDMJLpz2KlMpEJWhAob5I0Dt6Z/MPOrl3BpPjsHU5/uVDvMB3gtHVgViFTubi
	oiih4heBsM+0+efTt+s082QTT8Rgu2ZLQgyxyey6+
X-Received: by 2002:a05:622a:514a:b0:528:3216:b802 with SMTP id d75a77b69052e-52b566aef46mr170873421cf.15.1785701908106;
        Sun, 02 Aug 2026 13:18:28 -0700 (PDT)
X-Received: by 2002:a05:622a:514a:b0:528:3216:b802 with SMTP id d75a77b69052e-52b566aef46mr170872911cf.15.1785701907548;
        Sun, 02 Aug 2026 13:18:27 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6615a1sm4283918a12.27.2026.08.02.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:18:26 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Yiming Qian <yimingqian591@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 6.1.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Sun,  2 Aug 2026 22:18:25 +0200
Message-ID: <20260802201825.3816958-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050103-depress-transpose-795d@gregkh>
References: <2026050103-depress-transpose-795d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfX7xTJsiTPL1sS
 05XA7v9ihnYRQQczZ76wlBoXKO0YMeKVZ4VXuwnG8OEimGKK6dKUaL/VwnNtEVWPaFuubBXD2FU
 izjfZfVIBFF6A9e+8EaTnHTiYVcIE1M=
X-Authority-Analysis: v=2.4 cv=PvGjqQM3 c=1 sm=1 tr=0 ts=6a6fa615 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=B0W5Ij7fcqf5pJQDF-oA:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: FBjpmDvsDfpDubV22B2fBpROXk8I-S8G
X-Proofpoint-ORIG-GUID: FBjpmDvsDfpDubV22B2fBpROXk8I-S8G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfX+yqJQfaX4tE/
 NW6kkYh/Y3JYh9/J1AtZ0nkhn2zHpV6zwd6SrLZvjj9mo4T80yghPYFxPcnW8XAbnuHkxpHA2rf
 9ZqUdwm3dukC2jKuxxhxtjOhwzAnGu8u2iMkzKqlt+EpjHdLwCGQO08KOu04kwHUELCDqWiefbl
 ZCxRltJwcJMWxYjziXZTpTZdmolNRy1NmYFuP+FhfrAB5z7hvzwPhlpxZhJQDLS82tzePO6JXSy
 jTFka3hU/7i7ym8tutfYtZW1bnqFd3OJWddrtLcSx1WgtVqBGZNE6undC5UydsSZWsp41W2n1Ki
 Yov/vcYYK9MrSY/kJBt3kt8pqDvK+ySBNcVr0tG/2fofOh0G4xRl2xu2KIL3FY1SSZgR01yXMiX
 vsKXbhRzVuyUKC3g8IcXjhEBZ2nJDsK6exCMyKLNTmmObZRIubXUnd8W7LORF2seYuAEb+eitmg
 RTYM7Uf5lnIOmzPLb3g==
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
index 559aad0e3621..91e43b0fd566 100644
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
@@ -708,7 +714,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 
-- 
2.43.0

