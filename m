Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614385;
	b=RQHNKpcAz2pn8h16sos1rxcLIK/hxRT3+avkNeXYRRGfe12nOxVskH+l9hWEz/b+QlOu
	 9Q6ai66til8MBVBJNjpByvT+kZDdT/AQNQNlDzJryX4ArmzZlVHD0zl8s8orqUd/SSSGu
	 0RqiEhaDC5OoSqP+wfYHIltEtiekYT27eVTsRABcjOAZ350q+Pc6ym8VObJ0fVDHIKJal
	 Hybg7unegWDLmr7at+EftQdAWQYsNkFViXo/8oQbO2G0iccInoMXzGN+F9HScfIOvI5xB
	 cnVLKZHPT2tINwb1vrOCmkEtCLMtBhi4V8tjQI5IEiaq0xNDYjhkPaeL9F2VbQeYu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614385;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=O5wOfkfj12E1VqPGVMS3QdvX8xXZ38qkpNdnTaqGF8g=;
	b=J1uZYyE+viMsznMGS7Rghr8dGRKxa4NyhH/A7C48xCKO5kT4/jZCqD0ekTgBEZOHEwvN
	 pvvkVi17Sw9bBfNAaCdUOLDphsejAFgUq84NGs7408nUkZh7Q8svIbUcv+EB0OfVERP6w
	 /WC5rVeIW9YzJkJAMVZ4m8rDzgITnJkSEhpkmW8k57B5uJWRK9HlS/3u9ejAOeu6GIH3B
	 PUDcrm/eEEyysnERnjI7Y8CFZuavq9YKjLQhN8gl4yKHio8EcHG0TY4tiM8dCKVkV+bR8
	 Q3WZAtADJNLBVYKfOqOooDr3G2ddnJWvnuci/s4aRkZR1Tg+zjnfr2oo1dXJ3/zEbXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Jj7oc1dD;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC734606A33B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC734606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Jj7oc1dD
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20HVNj3288093;
	Mon, 2 Nov 2026 10:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=O5wOf
	kfj12E1VqPGVMS3QdvX8xXZ38qkpNdnTaqGF8g=; b=Jj7oc1dD1rKcxeHSooZff
	gHc9845UUBdNt3nOP6uNf9dB4fCHIOMVh2WNmQstsZyjgceM7iuJWfNFEIVKRrQU
	7YsCM7Sgl4fAkarL4BkpWLlqtL6j2UVB/xqR6qxsy1xxcg5Z0LDM4CEyPtgUJP0y
	a2Bg98BnaRHKt0Q07UkxS2pKlJ1uwpikdO1vIsJN8iZApmjtxdXQRRgdZI5fyQgf
	RUfbQbqbotMCv9kJRL9WA3Mr6FKuxAF65zDEex/u1+EJ/3aflb70WXV5lmapsGZf
	lF6QrDjQfZBV0pjlaf3hkVcTBfOM59JMi1boqBqfb9J6gW1gtDOdK00ECLw2SIU6
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01kwu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqMp2995705;
	Mon, 2 Nov 2026 10:12:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-5;
	Mon, 02 Nov 2026 10:12:58 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 04/11] net: dst: introduce dst->dev_rcu
Date: Mon,  2 Nov 2026 02:12:32 -0800
Message-ID: <20261102101239.1557688-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: X4Hz4ibttohfRUw2Ua4MoleeCE5F6tXA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXyJ4tvGMvUAX9
 51NF4aakv8ZD6W5SvY0+5NIZ6IaWJZliGRFa/lrRfJ7IW6KZzGatcM93OLtjQBnkbZilaZPin3N
 1AS1h5LlwdKusicwLtiO+lg0pKH6LlJZ2v/2JGIkLaDKZoV9T2NW
X-Proofpoint-ORIG-GUID: X4Hz4ibttohfRUw2Ua4MoleeCE5F6tXA
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae8622c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=1ODbnsfedCPZUhNGbKQA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX3lgV/ljWKbtt
 MjGqJ6s+l4WtjzplGDtnSO2tB5VuSdTNTVz4SDhUmQG5Rmx2SYPkn1qgXWQpxIkiTTse0pHp4QQ
 jnJPpvJ3qBTw8XXqhvGROloKwXjqX8LKLXiTbPByo/uuf03aspf31JN+QkCUNtahes5VbRyGKj+
 vgkBddtihxcewmEvsoD4cR0lxPjFHmT2ewHADO5uX6LtKFrBmUvLyNLuhd4gckGHWSiyUFzNBcV
 JGcJvE1eqvJcRD7fqtIKReWPq3Q5rxGGjs17xKhxaUhs7m4DsknzWsuq0ygfLVkRsXy+2aN9il9
 3XSeNxPIeDnzOR4LnaJQZGgn40JRciGd9ECKld/lyFMl7vi6Fbz+2+UmPugjOxZ7m9fxCQ77gw2
 G4RgDeu6AWPxYsuzagfbf/Qi2yINT+Y12oAEjCzBZkHxZ1wZwGoxLv0+VJn0xxaYJVlB51pwtTJ
 yqaTbDaaZn/hLUMJZ8g==

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit caedcc5b6df1b2e2b5f39079e3369c1d4d5c5f50 ]

Followup of commit 88fe14253e18 ("net: dst: add four helpers
to annotate data-races around dst->dev").

We want to gradually add explicit RCU protection to dst->dev,
including lockdep support.

Add an union to alias dst->dev_rcu and dst->dev.

Add dst_dev_net_rcu() helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

(cherry picked from commit caedcc5b6df1b2e2b5f39079e3369c1d4d5c5f50)

Conflicts:
 - Use 5.15 dev_hold/dev_put; retain the global IPv4 MSS limit

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/net/dst.h | 16 +++++++++++-----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9a23986f1071..6b63c3435bb5 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -23,7 +23,10 @@
 struct sk_buff;
 
 struct dst_entry {
-	struct net_device       *dev;
+	union {
+		struct net_device       *dev;
+		struct net_device __rcu *dev_rcu;
+	};
 	struct  dst_ops	        *ops;
 	unsigned long		_metrics;
 	unsigned long           expires;
@@ -556,9 +559,12 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
+}
+
+static inline struct net *dst_dev_net_rcu(const struct dst_entry *dst)
+{
+	return dev_net_rcu(dst_dev_rcu(dst));
 }
 
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
@@ -583,7 +589,7 @@ static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
diff --git a/net/core/dst.c b/net/core/dst.c
index 8707b7ffe421..4376f04ac514 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -151,7 +151,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev, true);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	dev_hold(dst->dev);
 	dev_put(dev);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b444a57498c2..92c70648651b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1077,7 +1077,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
-- 
2.55.0

