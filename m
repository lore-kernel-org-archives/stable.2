Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5125B093
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702009; cv=none; b=LCfl1lCFRmz51UFi51bevwgPQKcgwMdKsSVB2aY9ptXsuiMxyLxyY/u8BMBPhzpt8Jc80ESdniQTRbqYObkEQ+10z3dAT1dIpR3H8RvGbDLa2nnHKwb9XxA7q1XA5RYQPH1WdklZEVBNLEJwQznIiAV4bs8my2iZ/lbn5VH5K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702009; c=relaxed/simple;
	bh=jkKi2YAbJF7AI6X+xc/+EnSTdgKmUW51DiogjBU7UfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9xt/nNjHDodtQEU+33Ev6Jfvtd4FaMrJcYQ8ZQpdXwWCkpI9IG1X0JUVzHRDZzoqIIK6cumcHb//3H9adgT5//2aCIue2AMZTqensnMGHYKLIStpwI3gvwZsyC9Wl2Jrmci6fY3fVqWTfBpzIgF6n6C9QHUQWXu9fpJ+uDVMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fiTIBT4i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L0gzCx+J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fiTIBT4i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0gzCx+J"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Eag4A1779878
	for <stable@vger.kernel.org>; Sun, 2 Aug 2026 20:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bdW3b3yE5a5
	kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=; b=fiTIBT4ilu9ryvngzapLLX0xMLA
	plGlAvEKPU7iAF+MUZzv/SkbVvHTeXy5rCKJRa8D8t/1Y2hCSYZKqR6tXV2BNvRq
	eAjNQbq08c7k37WR/1vORjTgrdHVpKDEbH0mX6/UuT55EYiw1A2jSpsWuVx3UvTz
	rrRtvw0L0RiDysahD1cMSkNT1hMzaBRZx5ptHHBAx0be6F0DdppNkIWZe3x2i+FM
	jM4uyLxVxavuPvuensM5LcAdI+1g9daTGDulKUZckLwSN38zGUa5CKrz7HpfVywb
	vmxSqz5T4Mjc1NJzkB1rUStNXCBY6BO05HUu4+Bor4ENILokzimby4de/sw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9jfuc9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:20:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52827090cc5so28244941cf.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785702006; x=1786306806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdW3b3yE5a5kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=;
        b=L0gzCx+J5Y0rIku7GaRUc1U/Angbh0L5vHMmCuz1tQXR9vf5CSVHnGptyesTGj8GsA
         FxY1fCjgp8K3XSX94/bs2h/Qrm5AfHpprxhQ+rMWgPJQhAHTqozwp+eKCTEOXLgc0Ka7
         sGpoKZscCgbhmWp2BdThVZnVzk5ZpkLhbBeTYsGOMwRcL0mdxHrxV6goPbX7ZDqVnUIn
         W9ECJXjaKoxX2YuC3sSu2+OR0k30Euzqlm5spqw5ts/4fMdHThc4MBi9eZXq44kBYmy8
         /N9uKJf5pdAlZlyoGXjy4NakK6Fjkwn/dmZC9lDQb67XZf/2K9JYZwdOlBnaiDu7ja0o
         Nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702006; x=1786306806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdW3b3yE5a5kdHBAtBS08K48Rusrr4JWvAveGHz8GlA=;
        b=sLhiXa4LQDDJHfKIzBKNBeooHm+cONlZSidfAGafopUHk6jkLs7ZJ1sLQlYaYJH+bO
         M4HAZZ7T703bztXTcA3NQTZoYCsd6JjU37EgbaBGEkJGTPlI6bFP9XKD/tmZH8hNFJmS
         XRsX3ZJ3EPmL4BYYnGksoQexrFJLzc79AhZL9/V8rCqWuSP4SxZPECecq1iGxOaadU2s
         JVf26f7IHFLsBBSn3L+VbH+6eCVsaHpOEK9I3N8EOXWtFls1Lru032okxCJzxyrsAcua
         9iM4Pz975uF+LkTWvJVU7p2VXzZmDjC72f26ePs6i5sUZg4Oo+LrWR+25EdG3O3dBLmt
         iduw==
X-Gm-Message-State: AOJu0YxCI8pVX3EZ/LA9HAhrJz2wm8+HiY+kTqbtCLAP+RKhISrQPLgt
	XhfSh35Bj9ebrizbqROEMkaj/dRwoUif+Wk81SVHGwNdCg9iIWJvYI5Cv0oFAaWqPuSm6MCahBW
	jkWp2UQJNits7KFfMFoCUadHqRISxVYEY1Y28jZPylHnHLk4lT7vuotfnY9i/b65K4yK/aQ==
X-Gm-Gg: AR+sD116g+WT1QhlLeWfm95knpjZuAD+vHXZRUd+ewCpXydBtXs1aEBxWsdtX0daudY
	TcfBqXx0C1QY6UYVi3CBx79hZt/nLmjdzSsScSnj7PgwPSU8dev8KJQyNTOLKVJO3MJvObmEE5B
	2O3NyDqp4fYeCG9ttavGXfmkYHhpkIzGK0hbwy5M2z3JbPC45frDR3n0BobLDj7FX5x+zXItMIE
	OSMOiq92bafTORB67MeTdLun9YdNxZqine3hE1r2pymzeesodnueVucJ4KiCkNj88YT4hIhI69D
	lcERbYbxVm+HdEtKiRotq9rjswBjc1YDv5X7RCK3HX2QM5PnyH2KdsTNkJeMMdCkpD/Fl5LKj1v
	pTDf/gaxxtJkYRiVvEKjOtVoxLBGT2KJ91wdry/+0
X-Received: by 2002:a05:622a:11c9:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52b4c256804mr154634391cf.0.1785702006418;
        Sun, 02 Aug 2026 13:20:06 -0700 (PDT)
X-Received: by 2002:a05:622a:11c9:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52b4c256804mr154634201cf.0.1785702005936;
        Sun, 02 Aug 2026 13:20:05 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd455f671sm418819466b.57.2026.08.02.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:20:04 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Yiming Qian <yimingqian591@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 5.15.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Sun,  2 Aug 2026 22:20:04 +0200
Message-ID: <20260802202004.3818201-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050103-reproduce-payment-a434@gregkh>
References: <2026050103-reproduce-payment-a434@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sj6Nww6jubHFk0uvtXLItuSfmfTM4Qtv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfX3La06N9/DdwZ
 OecDjc1Zut93xBDjPfcXCd0iSHPNv/wwV5lT59PqXctP8ZtdSQSJE1ZXJzYW4ZnkrAloZfOzmVe
 xN0tpsF0VNb6z/EopXn14LFonE+ga0VeMKJ9ewT3bEeZeVjTTktrRAQuxn/G6BQOGzaTluKDghe
 lkgRxEDkQSTcK/LA9FSu//1BDNZ3+2uWjG5sbQx+h4MRxg6okGSqbXZdmDalFBkjTsdeCdt962L
 RgWucqs6Xr2Fc+MpmfiP1nFwTK+C0UC/FaF2Quhlsd+WG8tSonAe+Fa5NZnBWrYt3SWKVLCNo8Z
 64lmQRHQ9vfoiTerLWVy8s6GqeNSIWsu2hpuaV64xWlzYOtG7wutthwdHFbhbW/GGZ/Tf0n/6Lx
 /tUWRItwtuaWUW/dc2qbVYAgo23HbZ1jZ4Pp3+8ciYGry6bmG+rlrJLlKrOJZk0Ah1DKcHfdQKu
 zl+yli1msD5x5CXBSBA==
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=6a6fa677 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=B0W5Ij7fcqf5pJQDF-oA:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: sj6Nww6jubHFk0uvtXLItuSfmfTM4Qtv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE4NiBTYWx0ZWRfXwOlaS8WX9+Tu
 JuS5j8nTIYqloG5uYRxN4kFjlyvUSzh2YiGQ54bXGq9tD9Q2JyWEX4wW/A91pdu1F7EFBbUEDdM
 nSHVohBG6kJdCM9gCGmKHAtlH6QeiPQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020186

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

