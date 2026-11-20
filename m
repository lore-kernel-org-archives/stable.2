Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161563;
	b=x6Ft9jope8Le7+rZ68UBhoh2oFdQmiujge5p9ZXv2Ghjx/bYfRRgSWB44BVMULytc0ou
	 mydilhu8kDCiOF+EDjPH2RX0tR1DwH84vWpptIr9qD1zOYuh7p2wEyD6uE7FOW2rZly5S
	 zFrKZey7cvLwIOSil8HZ7KD2ww+kGk0DpzKMfeCeDeCLFstSTy3XwwT/RIuBpPCfLkAgO
	 r6peyIzkNW8+MdKy21Y6ABLsU2AhtaKsbqaeICpOXwgiBPkcEyKBhjAeQ5qDp3PzUpMow
	 YDwqweSyvUtg1y6faUy5B7YPy+NwmYaerMh8g9cJetOt0xdoWRpb8akwD6EM9VVNsoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+lR9KHvf51yvBoxd1/pkP2EXf3oWyK5p2AAAkTsaaU=;
	b=3gWfpxxw568PeM4es/WGSUY6XpqyPx/9xmytXXERXdTxJ2fIOWPvJ90NrtXE4Dmwywcb
	 emPpzUglr8suLyga4eVV0NAwLTvSObFTePV8/aS8mvlFMy1ziA3AV68LdfWDLXQ9PtcJ4
	 tM1zZXvvmu4Z/aDG86MdcGq6OmtMn44j55jdUdZooICQMmWT90PMU1LpB1lnNINU6Xt4t
	 LWq+Cz7B1Mj4CXZsnSTeBkmSIhbVmnEHTuT8os2AH1OaHR3nf0EfrtcFK1LpsPzDZKzPN
	 UNucjuchfPr5D4RThYi2mSl5r5xboGnNgVkIA0kULR7WUexWu/OsBHD820hh+TsTRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxngEe0e;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F84606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxngEe0e
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a00144f1so210199a34.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795161561; x=1795766361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+lR9KHvf51yvBoxd1/pkP2EXf3oWyK5p2AAAkTsaaU=;
        b=uxngEe0eL7yiw7fbE2VjSocWe3NaAGW/GESrNTbBhcCd+FpIyM0nARSzyJgBwU8txX
         n40EHENoLUN+xMxGu3BdZDJwHzm5+nnwc3s5W/w68y3OZf5PK57NMJYX1JoQVvgd8Qf4
         +nXqHNLqISbYFkcYvQ42YOgrq1bgguwMkNGxMSH/UxgNerB3HgDnCS46Y3phjfObtQ80
         Ota2E1aOIQIEGeGAoeJCDEA1qaSlmW8nooVbKy+R2rCt1EpB2/humwv5k16Zlh+C/51I
         cMWN/LAxdoep711gDHi/ButfdkhAO+9TF4safaEbWcczwVqeivDPzWpvyKEqCnDXGW1w
         epMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161561; x=1795766361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+lR9KHvf51yvBoxd1/pkP2EXf3oWyK5p2AAAkTsaaU=;
        b=YO8YcMkU87TNDYLOez7bKyNdw+GdpNDLzn3nmhUUksD2Xi3Hbdar16ulNNOzusjuWG
         905z/eps0rF1ULDTwBB47TAkkp/zdM76YOAFJIYBaHPNmHmOkTtC/3TSEEVdw90MKrib
         gJkKgpHNs5Lg9XNA4NfWm0hFIN9ylIzNN/Hr95ruOu+EcHo6TH+9dauUvzmzV6lhzIcZ
         dJtVzL3d6y8dnb1Rfn1aEzXpHwiXaxPUq4HLPzMQVyJXdexmLfkmROzDkChEwiaYLOSa
         N6JlzR1dk9z630DlCwIHM0vFAUGMiNDbiSTStbZjgmO922L9B8vLtq27zJXhIBZLNPKd
         NH/Q==
X-Forwarded-Encrypted: i=1; AL+hErHAii+xjhH2lncdMiKXNXJo4RQ9AKhqQTXY591U4PiKHm500EPYrue3DRaL0C4nsNF8C2C2Lik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kHsEqdbFFTFLrbc/tzHk6fQQVOqfMCqskkzjjkPPL+ACyguyV
	BtldsDkiNz2VDfNNTNQqRNAEJIRWUcctjaeM9MwG/RqJeTVwe40lBlHBCogjWQRbp3P51g==
X-Gm-Gg: AYBFou2A8OFhdQg9hWocOuKQSs4WpYuEs/rdr54zlRo5NTSpwOY/TWTDilzZbFJFCTX
	bpeepaDK8xvTowjs1WsrPU97ZdxIkgElEtJS5c7blHluFCpUrlsmjdWGD6A3FxGGPF60cFnVhYR
	ebjDftjQcsnvZ3UehxcIEKjw2an/8u0a13qSyqD/Cg4nXfQlNs0pB7JVyCCehdZBft2ZDbEMdGE
	HV9A+tr0x/EGOh2iZTLgUZ8mwxexLd2YmE7vATk6K22jyQBPp4StdGaE320pgN0QkzMfJwLX+hX
	eAK3+6eLvj+a0AuAq1MrIP8Jtvmj+CdlypYaHTk/b0p1ShRC3Ka60A/bZDdlOQkknU5LXm/9vUb
	PjRPhG4eHDTILRaWYnTAAdn887mwDRaxPlK5AIILUU8wNNnWs59WzpKBKkM52eRLJsYpQ9qIjC2
	jZlO3cnABxEwoAwYZSl2MSbmEtRZTECEZ7OGRAd0cqyLzWlUKeSsE7mETvo/53tunElcpR1x1z9
	Rdi4tkdCXPIunqUJFxPNLEuEBHnHKXL4PC4pxo0dB4xqEPKdjiL1XCR0gNVIGZtZMwkwB8PaP4M
	FTwer5gL9dmtUcsNKFvb/AcGR/iHo1azeFu+RE1zNsQID6t5RJyZFa06oI/LKwKlODOH
X-Received: by 2002:a05:6830:2692:b0:862:c6cb:2e25 with SMTP id 46e09a7af769-863152f8ef7mr2846379a34.2.1795161561258;
        Thu, 19 Nov 2026 23:59:21 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6d8sm1550823a34.10.2026.11.19.23.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:59:18 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: llcp: fix socket list self-loop on connect of a linked socket
Date: Fri, 20 Nov 2026 15:59:08 +0800
Message-ID: <20261120075908.4064155-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

llcp_sock_connect() only rejects LLCP_CONNECTED and LLCP_CONNECTING, so a
socket that is still linked in local->sockets can be linked a second time
into local->connecting_sockets.  That covers bound and listening sockets,
and sockets that a peer moved to LLCP_CLOSED with DISC or DM.

Both lists use sk->sk_node.  When the peer answers with CC,
nfc_llcp_recv_cc() removes the node from the connecting list and links it
back into local->sockets, where the stale bind-time entry makes the node
point to itself.  Every later sk_for_each() over local->sockets then spins
forever with the read lock held, which pins the CPU and stalls RCU, and
the socket is never freed.

Reject the connection while sk_node is still linked.  A socket has to be
closed before it can be connected.

Reproduced on v7.4-rc3 as uid 1000: a soft lockup / RCU stall in
nfc_llcp_sock_from_sn() while walking local->sockets.

This issue was discovered by Tencent CodeBuddy Security.

Link: https://lore.kernel.org/all/20261009092338.3146149-1-bsdhenrymartin@gmail.com/
Fixes: a69f32af86e3 ("NFC: Socket linked list")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v1 -> v2: reject any socket that is still hashed (sk_hashed) instead of only
          LLCP_BOUND, covering bind()+listen()+connect() and sockets left
          linked after DISC/DM.
 net/nfc/llcp_sock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde68..01b311d5adda 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -714,6 +714,15 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
 		ret = -EINPROGRESS;
 		goto error;
 	}
+	/* A socket that is still linked in local->sockets must not be linked
+	 * into local->connecting_sockets as well: both lists use sk_node, and
+	 * the CC handler links the node back into local->sockets, which turns
+	 * the stale entry into a self-loop.
+	 */
+	if (sk_hashed(sk)) {
+		ret = -EISCONN;
+		goto error;
+	}
 
 	dev = nfc_get_device(addr->dev_idx);
 	if (dev == NULL) {
-- 
2.43.7

