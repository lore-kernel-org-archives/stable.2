Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793326;
	b=2K4ClNFzNaWNC3eTkmCMBLA/G58cFLpc9e9perX9o4VhUIZxHRiaV/US3b77wx9mntev
	 M8em7dMsVUypYfokPN2rX2ZIISuZe/Xg/h3C39j2lBGzDhnwwV0Dqc20/ER3WL6UDCc0F
	 09q9SKriXQi4FK2sEvhfGRXP+OxrIlXVupzZpjWQRrgya6gazwbgfhRGwCFxBHB+0xJHn
	 7fsVB7Ps2jEFkI19tSZigliXWHjtpI1+cKkatuZ0J3vicGXbLpljcWc6xRvHv0x6EtSlW
	 XGMhY1raCQ7cP+ooM6qSxyjSAYtkYmJjxHvhFYApKkMYS1joRrTZqiPcEylR4tsfGYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=y9Cy6S/dJOP0Wkat096mayPMPffl30NQd/fiIAUB+XI=;
	b=QLTpOml1mk42OdjwqbFF1zfM3Oi/WKE8NA50T9wIT+07sxmbO3Am8XTulzdUiTeyycFV
	 lUewFX0ekYmmlorfBQTLq3z+/Jh3RuEnN2Yoe2C28Zjqlq9nR1p4BXVw+YKYk8yOMyp2N
	 JqxiluBRZQhsXJ6QwokioUNPzu8Ic+Ee7xrrkcgNvj9cVP2a5jqYZBYIZXdhdJS8KNytp
	 cYollLPFn2sDYIJOMFkx99AIY/PuK4ZMc4P6zymnR+l5mSXqXhEg8TNsZ7rM7+Ijp66LZ
	 eqWmai01AkMevy0zvlFIiMXRQKeXTn1+b6C8xVMIKvjXxPukKDMo57+AYkUNxyWRPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=gM52dHey;
	arc=none smtp.remote-ip=209.85.128.99
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F73606B75E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F73606B75E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=gM52dHey
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4bb76bb36c7so6399605e9.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1795793324; x=1796398124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9Cy6S/dJOP0Wkat096mayPMPffl30NQd/fiIAUB+XI=;
        b=gM52dHeyaSiVd0xSq5PJisvfLe1WAPMBqAyJCMY26cu5aLTTm3EXgCfm8zRYYNe49p
         R1fHun/+HwpRZIVQS8hOVTOCwTXZF0DnXb/01Z0YWHSSZOW/j9n3W4TT4aBkMF1zlIQE
         VJDklzShYFc/cXUI/jcULu7NA9/TcIxd2rCotGnpp+3p1SMPUtxn5VWYQ2HgHfImijD7
         gahFIQFs72cgzh967NAgN7dHWBvkUSuQdOCW2B1mvEamloZDugBftVFIK0rihHVVRG5Y
         J4ea+RFfWtzHWrp7pFtdAntX27kjpS8W2oIK2UkJcSp8GSjSPHvOwgCYyylHMBb01HMM
         g/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793324; x=1796398124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9Cy6S/dJOP0Wkat096mayPMPffl30NQd/fiIAUB+XI=;
        b=AGZX8AgnWtJ4BjfGIOVURrFLX0gLxmYFZaKdlK28zlmCNfOZeUBiIk2xJxJ6lpPxjH
         nIj+bPAkZtio3nlJ1f8RQVciFT5qcWWsj/yHOeCR1KMez5MOTj6fBrJcfPo9GvWqRKG5
         KlkPRm66toCxRDs/hGYzaowhT7dDOSpI2NLKRgx7/sCYWw9cDfbFMEmoDb80dzXh8PwZ
         geZB/CO/MBzr47dyCWhbkswRpQ0KS71Px6jnrueB7ksIsaAFn5S/SDX5DzdwS5zYbWJQ
         flucwPa064mLiBtZcGW1TD0rCtRRu/399KuSk4Ip9c6RwNZRU9IgCh0FvIRgjlAR6Jhs
         uGYA==
X-Forwarded-Encrypted: i=1; AL+hErHdQOGMZFxbbz3O30cZygc6ECTZG/AVsigDJX7RG9aiJfRkQJi9ejEqvxtpuWM7pmaf7WLuQlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DL84KpjsumuU9w7Wli5O9zLWRwv5MSOIftPuBh6+/QCFsW2yA
	WuBVNCSiEm+qev32Z2s1skHSYF+m3qLyEcMphk69GJF1ZzZlivSv4TW6xHWrzBA9caR+MRs7UN9
	9z1cPftXDRv/61fHUhqQ69QIFV/vv1jzd7ozy
X-Gm-Gg: AZFdTZdmmTuLpxVKhe7cQDfqCQt3O/2Rg5xSDDNx9CMsqzRkYGTDg3852+qOMs1zz6D
	3yeAI3nt6rBHTFUnHDK7UwKhJQg32aF680ll2peX2WfZFAfF0KMSLltthqcEG/QzUgjQNJrDbqq
	uCf20M6hsygYq+Wcw4mjW7fY8kWm+22DA4r45snQ81kFf8GDA8xZ66DBTYnHal0US2LTpRRdi+w
	RW6RWXspjFc1V5cNsaJY/pa6u0luIZvd8szSIVnhdYPHeW2kmWy61mceYmZWRe/0gkT0Pvy3HNb
	xiAATA2edJbTc852IyiUr9GhxOypg8FryQHg+GUWMb38+dIzYGfafbUrGO6+rXy5qZgt6LuUMxl
	498sjlVTxWe0PTx7uHw8U7WsWgQ==
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr451870655e9.2.1795793324518;
        Fri, 27 Nov 2026 07:28:44 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with UTF8SMTP id 5b1f17b1804b1-4bb853aa2a2sm91105585e9.10.2026.11.27.07.28.43;
        Fri, 27 Nov 2026 07:28:44 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with UTF8SMTP id D030A13D8D;
	Fri, 27 Nov 2026 16:28:43 +0100 (CET)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	James Chapman <jchapman@katalix.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net] pppox: only wait for a grace period for lockless receive paths
Date: Fri, 27 Nov 2026 16:28:22 +0100
Message-ID: <20261127152822.2098330-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.3
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

Commit 92c1bf630abf ("pppox: drain queued packets on channel handoff")
added a synchronize_net() call to PPPIOCGCHAN, so that the receive paths
that observed the old state finish queueing their packets before the queue
is drained.

PPPIOCGCHAN is issued once per session by PPP daemons, so each session
setup now waits for a full RCU grace period. With accel-ppp, the PPPoE
session setup rate drops from ~1100 to ~250 sessions per second, and the
latency of pppox_ioctl() goes from a few microseconds to 4-8 ms.

The regression was triggered in CI testing by a PPPoE performance test
(accel-ppp server in a VM using ConnectX-6 VFs, bngblaster client) on an
unmodified kernel. It was validated by reverting 92c1bf630abf, which
restores the v7.2 setup rate, and by measuring the latency of pppox_ioctl()
while PPPoE sessions are being set up:

  bpftrace -e 'kprobe:pppox_ioctl { @s[tid] = nsecs }
    kretprobe:pppox_ioctl /@s[tid]/ {
      @us = hist((nsecs - @s[tid]) / 1000); delete(@s[tid]); }'

Only L2TP needs this grace period:

- PPPoE receives packets through __sk_receive_skb(), which takes the socket
  spinlock and moves the skb to the backlog when the socket is owned by the
  user. As pppox_ioctl() holds lock_sock(), pppoe_rcv_core() either
  completes before the PPPOX_BOUND transition, or runs from release_sock()
  and sees the new state.

- PPTP never queues packets to sk_receive_queue: pptp_rcv_core() always
  hands them to ppp_input(). Moreover, PPPOX_BOUND is set as early as
  pptp_bind().

- pppol2tp_recv() tests PPPOX_BOUND and queues packets under
  rcu_read_lock() only, without taking the socket lock, so it can race with
  the transition. Waiting for a grace period is required there.

Add a lockless_rcv flag to struct pppox_proto, set it for L2TP only, and
wait for a grace period only when it is set.

This fix was tested against the reproducer: the setup rate is back to ~1100
sessions per second, the same level as with the faulty commit reverted. The
pppoe.sh and pppol2tp.sh selftests also pass.

Fixes: 92c1bf630abf ("pppox: drain queued packets on channel handoff")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 drivers/net/ppp/pppox.c  | 7 +++++--
 include/linux/if_pppox.h | 4 ++++
 net/l2tp/l2tp_ppp.c      | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
index a6f72c813bef..8d73951b8013 100644
--- a/drivers/net/ppp/pppox.c
+++ b/drivers/net/ppp/pppox.c
@@ -93,9 +93,12 @@ int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		 */
 		sk->sk_state |= PPPOX_BOUND;
 		/* Let lockless receive paths finish queueing against the old
-		 * state.
+		 * state. The other receive paths take the socket lock, which
+		 * is held here, so they are already serialized with this
+		 * transition.
 		 */
-		synchronize_net();
+		if (pppox_protos[sk->sk_protocol]->lockless_rcv)
+			synchronize_net();
 		/* Drain packets queued before the handoff because a bound
 		 * socket is no longer readable.
 		 */
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index 594d6dc3f4c9..29447a0666a8 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -64,6 +64,10 @@ struct pppox_proto {
 	int		(*ioctl)(struct socket *sock, unsigned int cmd,
 				 unsigned long arg);
 	struct module	*owner;
+	/* The receive path may queue packets to sk_receive_queue without
+	 * holding the socket lock.
+	 */
+	bool		lockless_rcv;
 };
 
 extern int register_pppox_proto(int proto_num, const struct pppox_proto *pp);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 4f311d473a64..9109c7c156a5 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1708,6 +1708,7 @@ static const struct pppox_proto pppol2tp_proto = {
 	.create		= pppol2tp_create,
 	.ioctl		= pppol2tp_ioctl,
 	.owner		= THIS_MODULE,
+	.lockless_rcv	= true,
 };
 
 #ifdef CONFIG_L2TP_V3
-- 
2.47.3

