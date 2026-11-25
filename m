Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618497;
	b=eLHko54ikXDkGKD9bv8f/BKcrQ2+Ea1cj7D6yCGUnMw2JmI8f2j9c8DabrRbfH2EJS0C
	 dz+oK60Zt+pMPoFLZIMvDcwgPnTGiIl6y5lZU2uMPDx8kFyAZqap+BJQKo0mgZw+2mIQ/
	 7S2f/Y2/fKHAQXRQ/+kvkoW76aBfEJHUE3QjITdCtRGFmr5Eaiy/4ZQpHfLLHFCX9VXV0
	 Q7+5TWqKX/9uHbUYHp9yenubReFELR4IA5XZPN2eli+zwNvs0MEyCUrcf0En08IB2bUsI
	 cV3hwoAzTiEuQhByUA3UfXifV4rZ+YQZJOo2xN/Wya5k5IN1RqXtzd3Y3P/9CGqNiPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=53aGqxQF1iJaRNRW8V9Vi+dBvXKjWm4em5xL6KM3Knk=;
	b=rDM3013vbJkVHLRa3VxfsZGIIu5CSPwSQEI/tx8atWFpa9mJXjx5hD/U4lhf0BcbVosJ
	 QSTOtmqZRpZQUuJuEPLl3+9jW0d63I0yWHtCRoYoPSgfxv2R3+UFAXMnsFKNfDD+phGXK
	 KDVRN7G7n0Ni3rz+9UCNhgh+KBmOVO9LOH4M7ssJO+Zn/C20Og0QnI1noxRgN3yVQS+pl
	 B7ukjeVCLYoEEYJfHHeAozAoFS5s3Ibt8IvHk0MBPr9BG4WL4iuuZKt9qowI2DAxOVTTU
	 jFNaBvgVVKhxbDWX43/y4C5xXutZzCU+l+mOE78NSJheqoqexoOdPgUuxZS+M2hS/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNOyfeh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA6606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNOyfeh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3951F000CF;
	Wed, 25 Nov 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618496;
	bh=53aGqxQF1iJaRNRW8V9Vi+dBvXKjWm4em5xL6KM3Knk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNOyfeh5lLzgd9xhsXFljKCrdkV16hTojRfplL/T9IOeAeYgZcj5R0h403vxWjFRY
	 x+P7DbwDk5ngm3oT8hYx9QVrRcV+UnnboizsAJDT/bh1Y/LC/Ocx8xAIlkGcV+OEzi
	 +mg/EjbmHZ21jwoSs0iqWnv9qUv3ZsYovCb0b+ghfdxoAq2FKUxij1r1i5E2Oy8JdN
	 pOZOoYHFdECAHjee/yui6v0ADBkKaH5V3wOUkMo4ZmY7VjC9yJs/Bxdvt6S4/MOo19
	 Ca/z1OxatGI9ypjl6mCNqW0NlJZG/f5JDHMZ0vH9NcOFPXbfqyH3oBZY2IHfCdSh1F
	 nThJZMBy8TNDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joas Antonio dos Santos <joasantonio108@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gtp: free the skb after handling an echo response
Date: Wed, 25 Nov 2026 09:54:54 -0500
Message-ID: <20261125145448.4175246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-starved-striking-0546@gregkh>
References: <2026112510-starved-striking-0546@gregkh>
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
index 23a0dc9f578be..60c09d3b38ede 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -397,16 +397,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
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
@@ -561,16 +564,19 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
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

