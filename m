Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301407;
	b=2rmfbB6PGl7Wo1tLXlsH324+6KHiZDq7AflMQW7KyZ/jMCzKnRYVfSX6EWP6GlgvzI1e
	 A9kjtKc7l7eg9vr2dcQS0+nF4LrOXNbX5JN/m5dnMqQyMkZdfrvkOTkbhYiTQz+bVk5gQ
	 dhMKwcXywtaQ54xl3/pJIdtKWQVCn6xlqBvN8JadqxszfEtOc0atvuQAasH9x5DP36h32
	 +1cY/30RB8OGclJjXIukkbsSTZ3RRbF2Z5HoXI4KMlQMjF/p9gC0xs7Mugyz9sFP4xoR0
	 T/zdhceRPI5fLmijM5WZS7zSav6isxtnsVLJTuobVBIRo/mZ9/1GrHULFwzDt965Z5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301407;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Iq1nJKDhrKzbagGZuuPD9GpgY8AW8Ce7+/1CYqXDwc8=;
	b=l6/Wm+++SUoWS8Ud/YF/jkHIfz3FNkp549nv/oeJg+Mamzpxs9dE9A2OvR0cbLvSmvi9
	 8m/enEH7EdGLx4xSW7cmX/t3hdeN8WZFgXsbz+1fClLUamU1b6bGeIins3tlswvjF1JzY
	 StEI6MiKfvPlqklWpBorooHNsKn9ZbBVH0vb764syZfQzYYVURQN07Ul5ZVg4OgANcBPa
	 cKvGtD4O+5N6XLrlomyfKxfKnm5bdjH5SniCQ5YW1wmjSakYDpfAsp8kQhPKUsrF5JIQ8
	 J74BejMHobxjo6wfvelSBIavbTkXxVf89v4UujWhyposBzonusp++NdiTw6Ykxln9EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k36dh6iD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E7606A321;
	Tue, 10 Nov 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k36dh6iD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794301407;
	b=rKX0OX0hMepRHCMfc+Mk2PWDPtvFo/y5wemS8M989MosE1mySnlLpxcC8/Y6SfjINIv+
	 RTVw+hdRQvb6+EoXADHVp5J8X2Rv1EQIf5ogdA5aALHbMwiU3sPMgFLERnV0UN2+jjbpU
	 iPHcP9y2XfHWp8hP9UiWN9ShRsU4RaO53Al2hkXJQq9FeGg+gLgKkQC4/s+SJ09skad3/
	 8V0jBO0snqJU7FMLEwm2v4W9Gxnv2dmNMiHDUUux/rUrScA7s3ygsMCka3eEwO/kTq587
	 L6HUztBxHnZevY/jPS7XohGs66a/vF0hGJufsLzRMx68nbI3/ELCuLy/2doWn8eQs0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301407;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=Iq1nJKDhrKzbagGZuuPD9GpgY8AW8Ce7+/1CYqXDwc8=;
	b=DFuxtGeOzxhNDcZKdO/4iOK+5UX4rp/vGtsUV+gYsn3bSVqHFLu9H8zdaYyUbN6QuZV3
	 Ossh8LTqndIoR3BtATNFxz7J6Y2f2cp4jOBWgr8aKYs1IbQ+ykxUWTlk/W0P8DS4v+BB5
	 zMdW641gnJjIfmAa0PeIaW9d0b6fAsxfsDZ+YgyRynW4coAWwxAV720xJ9WyPFu3mm/Qi
	 bnCm5xayYsAHv7JSDmRPr/oNVjSfWSz/h9oE0kQZ318CSWlzzek7ZulE/GqxjvZgnHHub
	 MTRGZonDPCLwazc2tTFfA7V3jwuKWk+HJMAmpZRnCT0lrxJNeWgUvV1hi42XCYqG6LA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B7C541F008AB;
	Tue, 10 Nov 2026 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301407;
	bh=Iq1nJKDhrKzbagGZuuPD9GpgY8AW8Ce7+/1CYqXDwc8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=k36dh6iDdVvvAa3/qZ0yNWwlkRnSDdY/StCsP0nrMRnp4Ac/Lhgkp4B/U/yFKg4TO
	 82EYAijRN2sTqfORWiKwaizVXmPyGHe8Ia6wuHbJgLHIqH3Bnkr84A0aLlvsBYE+pq
	 MjyV3JYYBYZMme+Mdho9vwJg8qF/nSNHTDxNHErQPzCbdFaVqOFUF20XTdij75HX8U
	 Q9IzVqyK133uV68ykf3SFV9UnCHFBPRoo5ozJX6CYNqqq53UVyEp0o390Dj0cpfo6d
	 YfpzM1qjpVQHezw74DfAMAgkBqxhHfGKlFqrAL+Hjj4r0Tq13YQrdy5O0axvE1yaRC
	 yPeZfedb0hAow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4921D48A57;
	Tue, 10 Nov 2026 09:03:26 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 09:03:26 +0000
Subject: [PATCH net] gtp: free the skb after handling an echo response
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN3d8moC/x3MQQqAIBBA0avErBtQg4KuEi3MJh0KFZUIwrsnL
 d/i/xcyJaYMc/dCopszB98g+w6M094S8t4MSqhRSinQlohkXMCUI16kT5z0cGgzqm0fDLQuJjr
 4+Z8LeCqw1voBEyRO/2gAAAA=
To: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
 pabeni@redhat.com, joasantonio108@gmail.com
Cc: osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794301405; l=3733;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=R9TcIxYRIQLC36eXFKBEQ/zbPTM2JwmdjnAqri7utlE=;
 b=USEiUSTtzqnSdLf/+y3HR6JuvI4VGG9bRKewqbXKarWNZBPZtmD7tPcE1rq5inbOwayXH3Xhc
 QUiacOqhnsZDNrw2Y+AxQyPrTEc3pzMt1uxH2zbeqM4MqTRWLdXJhPK
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

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

Found by LLM-assisted source review.

Fixes: d33bd757d362 ("gtp: Implement GTP echo request")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
 drivers/net/gtp.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 1dd32e979cf5..85d1b0c46ecf 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -561,16 +561,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
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
 
 static int gtp_proto_to_family(__u16 proto)
@@ -748,16 +751,19 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 
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
 
 static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-gtp-echo-rsp-leak-7a3fac62bd3c

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


