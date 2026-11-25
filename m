Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597873;
	b=SDo1ui+WmmY2UVrDhLuUOdtq+CyWTcKaWCVzNMezcE0cs+aPWQTE62l+8th5MNG9oh9F
	 ydhEoQSmVr+3Cz6UsLCgu8io5PRP4GOkfbvt/vckvbYRHjpIAN5vgGPJ5NUeHmvIXI449
	 9a4UsezFL+m68iM5PscI8wRsgEHMYwTfh76VOIjnrL54hhZRVNwutpVVWUsAjDrK1WZTJ
	 sc8ACnpYiW8kcfnUSpqXC9waFW8SX8GMIinYAPQmO/W/mCmIvhRcr34kSRjo2fazaUh0H
	 2ZtvnVsKXVZyuH+DQ/ED7j+32G9NebbSrxP3s9yC7BkY4wnslGQzyaDAdigktQBngCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597873;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/Z3pxd7oxgc2jHFNuyP4lSpwPelm8i9RVr4Oltu0g8s=;
	b=wpnLeS0U4iiyOESAHQzYkllf75oyISwRXVc4oIupvoE2yp+UhmQRCxwO1j1D8YqwkUpN
	 qECjiZ5os1mUv7Se2bsbsOrAyjFxN22Beb1TGK9M3X3uXkGDwONtOK7CSnYeWJaX1fVU7
	 R9EreKATl1iqzrV8judvJgbQ9+GOrEp5agyzOvwVsm+8tWfP0EVx6e+UEwbpudSbHs2ZU
	 T+AnAsVQ0Da6s8J0uPpcrxUyfDU1A4q75/Okela04ITluHzUyTipLF3IB6yMzKTvWPm0q
	 zQyOyLY5zh4QdorABbRzRPoOc5f7QecbV1vxydwk3rhtpA5v4xghc9K3EzkgJCRKH4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yra4XZ1j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C73606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yra4XZ1j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06871F000D0;
	Wed, 25 Nov 2026 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597872;
	bh=/Z3pxd7oxgc2jHFNuyP4lSpwPelm8i9RVr4Oltu0g8s=;
	h=Subject:To:Cc:From:Date;
	b=yra4XZ1j4XmgPwejGxnBbP2vwxZ7hrBHqDS61jENk6h93fMMEZF8siJSreMloVZaZ
	 3BXYgUX/2e+vhm0zGvCSy8mBjbwDxifo8y8oAqJ2OW/CJQ6NndC6k0DmgPUP3xiyV1
	 dtlStJsCK5Ii49+ShntFyh4d2LRVlFA3EsvqkKbk=
Subject: FAILED: patch "[PATCH] gtp: free the skb after handling an echo response" failed to apply to 6.1-stable tree
To: joasantonio108@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:59:11 +0100
Message-ID: <2026112511-garden-tassel-ecb6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f17b293d155f377e4cff582b8113991d2ad346d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-garden-tassel-ecb6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f17b293d155f377e4cff582b8113991d2ad346d6 Mon Sep 17 00:00:00 2001
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Date: Tue, 10 Nov 2026 09:03:26 +0000
Subject: [PATCH] gtp: free the skb after handling an echo response

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

