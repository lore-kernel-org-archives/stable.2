Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594037;
	b=tOC2DtWyst43lWK2xozT08pQIJawBTQeUuiaEsFU867JA4Uuo0cq8ApjUCUe6o+ruuxC
	 eNot1NXuYNcsTKiTCCFlVJ4lS9YjnZGpPxLVLmFZp8GTaTbfww95+m3TKYNYuA6WmH7If
	 SdhNPrVZf6hZlQLcoZNDnHsnWdY8E6Fq5MPOTXh6750eDnBxtl5nip87IYB2+YjIiXMc7
	 Qn1Ev6JBtQy5IM5NKda5CyE+Qvyx1EQ15qS23HWdB1gX43jIww7Gf1J38j7H/L/IehJmO
	 ow8xqhF8h1fgBqjwrAe7edFdBiWwy9yZdcPxkWJlaP4YmqPnfxdYSETwrI/zLOjumuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gGgY/g42kXiEi9hKkVOcPMTngxVYNDDV66irTK01U44=;
	b=VQMkgxBn4/5OURRd7SVGu3iC1p1y6s8eVr9tIbUMgv+jBfkUwQj4umxOB4CY/WVI8wUp
	 osEgLh1zvaEhhq3GkYzz0cXcjGwnvpHu6kjWASOB5pUF67bz1ef0cQ2Srn4bQfpaMe6Of
	 huWztLEbzpB/VwUrwMe/tOKl1eK/z6QFfmDqUbLJz7IpnaZw7RpEdG8spDXB+T7q+2sfz
	 3ecMSJNWlJbDax8GALMf/OGwp3C4ApMumpZ1jOv2UVjI4lolZZ63qLx6UFB+3BONYRQWX
	 JHIb1ZfYCdr11TLkK4626txaXshE1lgydOTrDsIQ9CdNDrBB/S3CLLaWXZWG5eQTJTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfdUzDSH;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851D606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9851D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfdUzDSH
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2f0918f9e8eso15056425ad.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795594036; x=1796198836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGgY/g42kXiEi9hKkVOcPMTngxVYNDDV66irTK01U44=;
        b=FfdUzDSHVVNa3C4b4EHLfZ920Wdj/MKuK7+8i8ZOKGQlQ+PLHUPlc94TM/n6vdtdy2
         nehzlNTFChs+knZU9/X6OCbJWgHK0brI5NDm+eY3eaadXqtO7b/HJl01Bz0fQhRBx02a
         JSNaBRhZnVQMDAE1t0drp7iZRV+F0u1WCgjA1O6i9Uw3WSdFToaxcyOHSfuwRBhAetdy
         cBfGisA39axL6zOiQtbnlMex0az8cn8dwR6+ukk3o8mvEjvoEv5BJQ8A+PvHa2Goubmw
         JubVVt6HGtIlPopWs1sj2QW8GVA24x+1uQTscTolF9R+4JyasfOvr0Xh0CO3DF6+xAid
         KcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795594036; x=1796198836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGgY/g42kXiEi9hKkVOcPMTngxVYNDDV66irTK01U44=;
        b=Wp2yLxRnmNHP86sM39kgUElzIYs8lHz4Z09RmXrvFJ5okZgJprRWcwGHFltlwdUW3B
         bG7EHwp5X1T0MrtIcot+dc5YP3H70K4smUtVO0BwR2Pzo0Iys91j6LlbIiJqirI3jNrw
         1PpzYzpy2FCe3qV4R+NO1Wd3qS1Tni/AVQksZxKJhlxcR89/vAKQZDq6CxxDomhpXfQC
         kgjbHQ5qFDl51aEPSNc5fKy3zzd/DblSORe72HKZq2BK5+UIsIxrSv7qaF/RHMXhQ9kh
         FqXu9QVGrM9gADWAdoQGk0jO5bJk4kqL2Duzwd6D7WAsDE9ug2ougbniPsTCsgbnNAnC
         owAw==
X-Forwarded-Encrypted: i=1; AL+hErF4Rkp/v8ot+3IdyuGPhwhWNFjbFLi2ziUSjt6V7/5HH5WMkNuyyhtbFiUd/ek5DQ7lqWEciDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z88g2F4+lBlaSRxFPZPNAdtLHAPmfrl5vjO7nBf7zpeWoh6WwvJ
	arbO0C0rcOQncrn+wTERXk87GIMq+HMKlvkbMZJzreiLSj37q+hPdHXj
X-Gm-Gg: AZFdTZcDbrl/jY9pDjLye3dUWPRqOzyXrX8sQ3QEBpaZNvxnq60woSn3NTzX7M73zYd
	pS36pMoN/APdZcRvS4hbgByDAg6h6V5Zzsht7Jpgj4PmLtd3dkUbyb292KpUKW7AcVFcgP5gR6z
	pFq/zJf4T3NI2qDZNWj2mTSv0SHiP72DpvP0/46TffZLqIc/WQMD8TpwlMW+R4P5k5bSF80xL/7
	xOfQdfe/stmumY6IOAPMJE2ng5Ue68lFr6lmtSVcTwgrq0BHGdOdvM7hPwNOVj78TENHBo4H4vw
	yHLrHvDvUOIowC9iDOpGUTn9QAS6tarwLVXP1KKOpkzC6sD8asmrOzzq/R5ZMz7h8iv673pmSAw
	q+MPuf+eRNUh/Bw30ADwIZvEMEiCY1pmlIBvV4h6MuJlpQ2g6vVy1nC/7BuLWpOjwhb5zv/8kAs
	P1qNoBxDQfdnP4kb5MP9zMsn8t3VZ0cYo8uca6DQeWWedCpiWer29Ak7ZuMmanmr4XgtUptVxyA
	QalQOTNPISwvzX1ftjl6K8n7D/78SK+vlNnDrVdmMgvKNJ33lo7v1smSyieTNT1ar6VpRkPZXnp
	YYph8fw94AafyIJu6CsqrL/zoDtwYYSYUE47SYXqhlrLUb15ldFMrxWQ7fwSnFWmHfY5thcZU32
	a
X-Received: by 2002:a17:902:ef4e:b0:2f0:4ebf:84e5 with SMTP id d9443c01a7336-2f04ebf8708mr162770625ad.45.1795594035760;
        Wed, 25 Nov 2026 00:07:15 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a74sm83444005ad.12.2026.11.25.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:07:14 -0800 (PST)
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
Subject: [PATCH nfc v3] nfc: llcp: reject bind and connect while the socket is still linked
Date: Wed, 25 Nov 2026 16:07:06 +0800
Message-ID: <20261125080706.648722-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The same stale-link case reaches llcp_sock_bind(): nfc_llcp_recv_disc()
and the non-connecting branch of nfc_llcp_recv_dm() move a socket to
LLCP_CLOSED without unlinking it, and bind() only checked sk_state, so
it would link sk_node into local->sockets a second time.

Reject connect() and bind() while sk_node is still linked.  A socket
has to be closed before it can be connected or bound again.

Reproduced on v7.4-rc3 as uid 1000: a soft lockup / RCU stall in
nfc_llcp_sock_from_sn() while walking local->sockets.

This issue was discovered by Tencent CodeBuddy Security.

Link: https://lore.kernel.org/all/20261009092338.3146149-1-bsdhenrymartin@gmail.com/
Fixes: a69f32af86e3 ("NFC: Socket linked list")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2 -> v3: apply the same sk_hashed() guard to llcp_sock_bind(): a socket
          that a peer moved to LLCP_CLOSED with DISC or DM stays linked
          in local->sockets, and bind() only checked sk_state, so it
          could link sk_node a second time (reported by sashiko's
          review of v2).
v1 -> v2: reject any socket that is still hashed (sk_hashed) instead of only
          LLCP_BOUND, covering bind()+listen()+connect() and sockets left
          linked after DISC/DM.
---
 net/nfc/llcp_sock.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde684..c12170dde8401 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -86,6 +86,15 @@ static int llcp_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, in
 		goto error;
 	}
 
+	/* A peer can move a connected socket to LLCP_CLOSED with DISC or
+	 * DM while it stays linked in local->sockets.  Binding such a
+	 * socket would link sk_node a second time and corrupt the list.
+	 */
+	if (sk_hashed(sk)) {
+		ret = -EBADFD;
+		goto error;
+	}
+
 	dev = nfc_get_device(llcp_addr.dev_idx);
 	if (dev == NULL) {
 		ret = -ENODEV;
@@ -714,6 +723,15 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
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
2.53.0

