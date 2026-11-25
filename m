Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618693;
	b=LEQ1UM9q/vqKV21tMal4SvCQxhBnl1Swe9HXMqkNa5cFRu1VQssORFBtntqHWTk708ep
	 HfJaMWVgZtdwsxUt0WNgEr/tM68yocvXd3WfSVfhYG4J8+5R1agiJ/psSOj4Cfg3e1YWK
	 FieWnX+NKOzBl9SD0k/k7m+ylqKEiMT3dN0ee8GL9YVe+jiJcS7bquIZOVx4iwrk/wfhL
	 +EiyPHb9KRMRowA+gYmGCLZgIn7t4kQyPEvokFDU9hSCcXmYWmcsLiDnLQNWtnKW/K687
	 iyONl1KTaB89XeTE3BYAO+CTfyD4TBK9kzNja4uOn72d78ecqmdDVpl+gBHPR7hJF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7eS5HhdhQMmDi3knx+HRC0ZH6LVcLiRV0MePre42Noc=;
	b=cQNCN1hWhyIZLDYWCXUwll1FvMqmKJB/uHuSd5h3Mo5svWgKv8tyNjNWyM4TE4ze6gSs
	 MGJi8oH8mwZFnd43xuc0H0+CsQV/CbNegfgY7ffUquvQ9jT3ddKml5WUFh7qon6x+DJs4
	 TIKbzF6SkAX8q5qDEfmWWko/X1KgCUVEQIwSlMEH0WuhZ3R9hUA4xQUGhOHV3GoRgJP87
	 CYYwXgvQWmnXqlV7uAsPRoG45fI2Mu1t2wkcTW5RaS5Kz0/GLcW6TfgmgXP9xZnLGUb2K
	 4ETwbimtjMHy3dDfEo41ZpGuwZt0rjkRZO1NPLMRR2hoUKks6P5P/QZMPpAWvZRRLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhueRSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF78606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhueRSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A99D1F000D4;
	Wed, 25 Nov 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618693;
	bh=7eS5HhdhQMmDi3knx+HRC0ZH6LVcLiRV0MePre42Noc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWhueRSSpWB0k9Ao/Yc7gz8gqWOTuwG+6RbKUUYtywImAH3pvPMQbWhU8jq7havm7
	 wf18aLthdk4IdVCKdyCPJdi2Zv46At1zE7dg/nDzPSNVjjVlACE0KAD+B+LXNXV2ua
	 APkuZepMQJ7UT0vNhBFs13p1GrnOWW+GUZosYay0eVlFFXfJFdkOpkhbRNQ3cS4I4z
	 EzO58RK3guNhRGgN6r3c1vT/FzhvL6QKXHLnxA5B6f1GZ3qiZHZaF7tFau1fU9aeFf
	 20wwXhy/dWjG2SJSAeUpwJSDx2RIDyo3DoZ8P3AFK1Zv1fZgnFIvZw1rvh9xceBO5u
	 ZUsllEu58jMng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joas Antonio dos Santos <joasantonio108@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] gtp: free the skb after handling an echo response
Date: Wed, 25 Nov 2026 09:58:11 -0500
Message-ID: <20261125145804.7113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-garden-tassel-ecb6@gregkh>
References: <2026112511-garden-tassel-ecb6@gregkh>
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

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

[ Upstream commit f17b293d155f377e4cff582b8113991d2ad346d6 ]

gtp0_handle_echo_resp() and gtp1u_handle_echo_resp() return the result
of genlmsg_multicast_netns() to gtp_encap_recv().  When the netlink
notification is delivered that result is 0, and gtp_encap_recv() treats
0 as "the skb has been consumed":

	switch (ret) {
	case 1:
		netdev_dbg(gtp->dev, "pass up to the process\n");
		break;
	case 0:
		break;
	case -1:
		netdev_dbg(gtp->dev, "GTP packet has been dropped\n");
		kfree_skb(skb);
		ret = 0;
		break;
	}

The echo response handlers only read from the skb and never free it or
pass it on, so every echo response that is reported to a listener on the
gtp multicast group leaks the skb.  Echo responses are handled for any
peer when the UDP sockets were created by the kernel, so a remote host
can leak memory on the receiver by sending GTP echo responses while a
process with CAP_NET_ADMIN is subscribed to the gtp multicast group, for
example a daemon that monitors echo responses.

The error paths do not leak but have a related problem.  -ENOMEM and the error from
genlmsg_multicast_netns() (-ESRCH when nobody listens) are not -1, so
they are returned unchanged to the UDP stack, which takes a negative
value from encap_rcv() as a request to resubmit the packet to the
protocol with that number.

Return -1 when the notification cannot be built, so that
gtp_encap_recv() drops the skb, and consume the skb once the
notification has been handed to netlink, whether or not anybody is
listening.

Found by LLM-assisted source review, untested.

Fixes: d33bd757d362 ("gtp: Implement GTP echo request")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Link: https://patch.msgid.link/20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 94f4be527e539..841cd3220c2bd 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -396,16 +396,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!msg)
-		return -ENOMEM;
+		return -1;
 
 	ret = gtp_genl_fill_echo(msg, 0, 0, 0, GTP_CMD_ECHOREQ, echo);
 	if (ret < 0) {
 		nlmsg_free(msg);
-		return ret;
+		return -1;
 	}
 
-	return genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
-				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
+	genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
+				msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
+	consume_skb(skb);
+
+	return 0;
 }
 
 /* 1 means pass up to the stack, -1 means drop and 0 means decapsulated. */
@@ -560,16 +563,19 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!msg)
-		return -ENOMEM;
+		return -1;
 
 	ret = gtp_genl_fill_echo(msg, 0, 0, 0, GTP_CMD_ECHOREQ, echo);
 	if (ret < 0) {
 		nlmsg_free(msg);
-		return ret;
+		return -1;
 	}
 
-	return genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
-				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
+	genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
+				msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
+	consume_skb(skb);
+
+	return 0;
 }
 
 static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
-- 
2.53.0

