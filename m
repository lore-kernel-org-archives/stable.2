Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597869;
	b=SyGU4j8BZPdYXhnWpjcc5U+f/UTBZscXTqPxTHOf5Zv6Mlcn3CIGMDyzjYfAIqPsB+LO
	 wc5UflygyiOCKEBNF/Uvxq70T92OypAohanT29SRaVC99hgAgmmAU9e7TNTFDScaLxoQx
	 YGzkMlo93dqqG44gMi0GOmidy4a7YnQxnpeAUE+RQqeCgPT58WN7xXnO/ZgaeO+NBBLEd
	 iC0d1HK0Dha9M4DXkx3KnEHdHqhdAJ5i3oHNH7phRvt5KeenetCd11Y9/GRLNfWRzNaKH
	 ZtiFF++D/+CbponPPEpIe7mE9kBHDt8xJUZN4yEKnBap6eyElQxMWaIQbFHSQaopihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597869;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1OTk0BW+nwYuIZdQdAb7ZFFun1Si/LJhcH6hibEq3F0=;
	b=zGJn6PTIWG34OlS6YFSZxcvgf97IWC9AWgjMkNRoi7k9flf64JR5adNRMaWsDyonviAs
	 cb6M55AeBsM0Con+q7pU1rSyIvL0ml6WTH47EitxwuGwrzPYFB5usY6jRvqXsRk0A5N+I
	 IRazBIMnVejs1ZOMXlQ+PtfFmDyvaoNEnhCKddxvfQgfkr36VPbT8HSDMgyicvcrP0zgF
	 7xtCJlhLpOX9VwqAUi9S6x2eHSSzXPHeYygABylEkTIsZI6/XW4ZIjJOw2XxDPNHSTUbj
	 7cHiG7cn6F7dZukqmPpkrsu/cys4wqw3J01ftI4cL2HQthwhxmuLCPlzAX1Jc7ePysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I69C6yVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFC606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I69C6yVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA671F000CF;
	Wed, 25 Nov 2026 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597869;
	bh=1OTk0BW+nwYuIZdQdAb7ZFFun1Si/LJhcH6hibEq3F0=;
	h=Subject:To:Cc:From:Date;
	b=I69C6yVwSthE3VuJjtFCBomK+vhvqIp6faeAJkSQQ6hp0XaGGH0eEJ/gEtz4b8YYh
	 2xtDyC0WWWyBe38YJHsWMqE1PKh9Nt18mTR4kAEBT735scA4FWsA2oRO2V/ELL2zzf
	 yC9ZPPHZTIRCOHpPBeFkG/O83HSlhqsdI+k+Q/qQ=
Subject: FAILED: patch "[PATCH] gtp: free the skb after handling an echo response" failed to apply to 6.6-stable tree
To: joasantonio108@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:59:10 +0100
Message-ID: <2026112510-starved-striking-0546@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f17b293d155f377e4cff582b8113991d2ad346d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-starved-striking-0546@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

