Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686682;
	b=BS4/yor0K98lhNQazFr66G0ZxT2ajCZByHrpEuAE7Y989jAnTTJHhlVUeijVHoJa+L90
	 mQpG6NMKUgl77Vbz8uNYwfmsODwB9gaLV/L5ajT90sWiKEApHbBErhHwyd+j11ykQheyj
	 Vwy0g534Dq1DP8agG0F9iSgbug2ALDzqnySQGIlSqxGsonNRRNtWrCCeWdbiPi9FclyWh
	 lna/qetLPeUfa1oKIUeBxGvvJHuEMieMPBuA8fnEYdYFIC/0IgxRUxgsyRPwQlt6HE3x+
	 H3wabY4P+6w1ujTAuQQ5OEGmLwBjaK85RJw8xu+3MVo79yVi1rksSsIflPPnKnI/wWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aleyTKbyUPwkKdibUq3IwvSz2dQSx+D+0Ibacr1mokc=;
	b=cExscCvV2jPe/AaIPIzkPIDfu5Qq8/v0MMy3QYNMD3i5IqSu8SCUJfhwoooz6IPoj/mV
	 88ktDCfV6MvpYgdhm1Vh+S/UGl4McIA7ooBIuFNWcjfgm2q74g1B7iRSMaM1+FYPnvTkd
	 zD/ozmkduTLQKrZH4vqF/PUSBY9nlCwVredQRgX9SUPR054piykXZozam3VKJ0piBW3nf
	 knQ85sx9lGXZceZBhhooYl1/Qm3BxaMyim5c2zK/EI7aRxoVM4ci/PjT1rSlW9QONMkr5
	 7+hR2lOqHA9/d5xjVwfsLnbUv13oBkuQzqwnILjRvYcPnTS2QWKUdWEc20R8PZN+QFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qxpOClJj;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91769606A31F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91769606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qxpOClJj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so5174240eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792686682; x=1793291482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aleyTKbyUPwkKdibUq3IwvSz2dQSx+D+0Ibacr1mokc=;
        b=qxpOClJjtfeOQfM044rAVrZ8LpRzlycX9HpUGrUusQc3d6Jrn+XIsSWVsOGux2SBaH
         b8LZaKGD3dnhMoeCA3rch0Q91EpYMlq8uUtE7pCBcZ2pp1gllF4irMGlmR8Xh9ZuSY3y
         71BdHuYB4qT/a8JcMytVm80z2vSTcEXxnxerXiE6MV+MmR+Gc385HsLfmC/6n+iKE3mg
         y0jIq2I6DH6QjXvrzbprSEVsFQJ6Jz5EYl3LZ6FjnGb3cUjCxiP2DrsYtF/mi9+MeAQm
         L0M2NuH+dQox3obSqNWDZ6pcckmCC1QAXqVis53tmJ1NzVNUC+shLbSu0QX7d0xk19VU
         jTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686682; x=1793291482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aleyTKbyUPwkKdibUq3IwvSz2dQSx+D+0Ibacr1mokc=;
        b=K+Fc3buBobf8kbcXw6YuN3h2RPmejrPIfS+xAllRnZCfsj4mwIkur3p7VcHLJ2ty9T
         +MEEj3wtu8TS6IKhWibga23uWw5Gjo4JSeScXA8LPNBS0rSBjdrx/8Yeo66DuZqm+Zu6
         5LlFer1AFyxG7s4OUT60UGPV3xppBj30vZ5F4TWmuMpv167rnCzFcCqFvoPZ5LbfroEU
         SAVX4TxrPiriaPmu6Jve7VHYx4g5CGKHnqVbUHQv0kkca4Nf1dTvlTTNqB1UOkQd/QLt
         CE0ZDxQCXmoBBT4iiSEJZ9lT5JuKHYSf0+VWMS9Uce9kPepbZCvHCr9T1U/adxJtpCM8
         k9bg==
X-Forwarded-Encrypted: i=1; AKwUvByX9zTX2hT+sgrslojeKuji098VtercZzDpSd8EkJHxNPnXxIfmdff2fC0N87YHF0C6HAU7vgU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoiKkoH1MNAoF5Mr5slKkHiwVmv2c3TTU5ME05YaFY5R2XFKhf
	YjrGyVyary5meMlj+zU1Jv7lkINafVxeRSHOAqsX0urOaHsnpDPlBgN6IbVoO6pdXuoGGw==
X-Gm-Gg: AYBFou33UGtjc9K7SV6MSHOd1SbOy9kqQ/mg41n9oHL0FeJzP/YsSsyMpALspNMw7QN
	DVJrR95nD0n2WEuykXqm/YEI9fddLEciw2Q9Blf1GbqOi6ZkMGhxXBbdcyTmypf0E8BQlIY2hee
	BdizHRn48hCBPKrVz1fR58zNUm2IrWqOVmDtz8PKhVHZZEiKdPWlDH52KYlAUderV7kBU5yxFc0
	X9e2Ox3GdOricnxDQUPnE3awkGFe8QmJoNBs5q5MKoe1cDn8H0Z1TulPs3rVPHF6ONvoeHfBXsJ
	zOWf80NXuGUA3NB0eUoq2g8tchAU2UQixwDQTqYX4nxZyxdsbDFoJqPjtrINOk+6QVeLtEVkguh
	/PpPs6CO+PbOhOydIxPhNnlHptpt4/3KEM+XSa9wGIGSagd2se7y19rxnsavc6biprGor+OSi4v
	APd1InvZmOUWg8+BoS5grSKpVlM6AkxTtJSUXT8run3voT1n6vfTbO8SxMCKTsMcsTFzd/12nZc
	bagSSzFcOSmwKyqsGNTEQQ3qXNhQIy5RXMrUjStVDmvYmQT5Jf4+SA9q8sK4+xtesEUgxQ=
X-Received: by 2002:a05:701b:260d:b0:14a:8df8:56c5 with SMTP id a92af1059eb24-190a599a5admr5852299c88.26.1792686680599;
        Thu, 22 Oct 2026 09:31:20 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d87ab1bsm17079981c88.21.2026.10.22.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:31:20 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Fri, 23 Oct 2026 01:31:16 +0900
Message-ID: <20261022163116.1042-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
register"), qrtr_node_enqueue() drops every packet but HELLO with
-EAGAIN until our HELLO has gone out to the node. When the remote's
HELLO arrives first, the NEW_SERVER replies from the name service are
dropped, and so are the broadcasts for services registered before our
HELLO goes out. Nothing announces these services again, so the remote
never learns about them.

On Kaanapali the modem sends its HELLO before it accepts ours. With
rmtfs started first, the modem never learns about rmtfs and its
watchdog resets the SoC about 40 s later.

Remember that the remote has sent a HELLO. Once our HELLO has been
sent to such a node, pass a HELLO from it to the local name service
again, so that it announces the services it has at that point.

The flag is not cleared when qrtr_endpoint_hello() restarts the
handshake on resume, so a HELLO that the remote sent before then is
not lost. The cost is that the remote gets the same NEW_SERVER
announcements twice when its HELLO arrives before ours goes out but
the name service handles it after, and on every resume.

Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
Cc: stable@vger.kernel.org
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Changes in v2:
- Replay the remote's HELLO to the name service from the core once our
  HELLO is out, instead of retrying in announce_servers(). Replaying
  the announcements once hello_sent is set was suggested in the Sashiko
  review of v1. This is also not the delayed work in the name service
  that I mentioned to Mani: that would still miss the broadcasts
  dropped before our HELLO. Nothing sleeps in the name service worker
  and there is no time limit.
- v1: https://lore.kernel.org/all/20261016124600.31-1-26rote@gmail.com/

Tested on a Lenovo Legion Tab Y700 Gen 5 (out-of-tree board support)
with rmtfs started before the modem: the modem's HELLO is still handled
before ours is out ("failed to announce new service"), the replayed
HELLO follows right after, rmtfs gets the modem_fs1/2 opens, and the
modem stays up.

 net/qrtr/af_qrtr.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index e7b364742..508a2dd2d 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -122,6 +122,7 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
  * @hello_sent: hello packet send successful
+ * @hello_rcvd: remote has sent a hello packet
  * @rx_queue: receive queue
  * @item: list item for broadcast list
  * @say_hello: delayed work for sending hello packet
@@ -136,6 +137,7 @@ struct qrtr_node {
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
 	bool hello_sent;
+	bool hello_rcvd;
 
 	struct sk_buff_head rx_queue;
 	struct list_head item;
@@ -541,6 +543,11 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 		qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
 	}
 
+	if (cb->type == QRTR_TYPE_HELLO) {
+		/* Pairs with smp_load_acquire() in qrtr_hello_work() */
+		smp_store_release(&node->hello_rcvd, true);
+	}
+
 	if (cb->type == QRTR_TYPE_RESUME_TX) {
 		qrtr_tx_resume(node, skb);
 	} else {
@@ -619,7 +626,20 @@ static void qrtr_hello_work(struct work_struct *work)
 	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
 	from.sq_node = qrtr_local_nid;
 	to.sq_node = node->nid;
-	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
+	if (qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to))
+		goto out;
+
+	/* Pairs with smp_store_release() in qrtr_endpoint_post() */
+	if (!smp_load_acquire(&node->hello_rcvd))
+		goto out;
+
+	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
+	if (skb) {
+		pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
+		to.sq_node = READ_ONCE(node->nid);
+		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_HELLO, &to, &from);
+	}
+out:
 	qrtr_port_put(ctrl);
 }
 

base-commit: abeacca61eea4f6803df4a595b656ea45c2d3249
-- 
2.43.0

