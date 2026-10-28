Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210160;
	b=OjxsWlkKkJYV47fsbk2rVB9OZ1rf/OGbFIfveSNOFYt63AKIp2QEX9yFZf1u1cuasl6U
	 Yq3NVmt7jtK9WXe3M6jbXgFwiG1J+aAS3T1fT6tTlEOwlKnpzY2sMhjC1AcRS7HsLSRYd
	 VksZwi3dFFb4Fa4xn5j0JiNNDIjYW922QMaEaYEB6d7bI85KgC/ZJp0rEq9KHWIvEaDcX
	 HVNXj3czNrcTDCCmEND/lPo5MqbJkNZhTEoWo9YwyR7I/5MYoy/DYreRQ9INnqsMxJZyv
	 NNcI2fVyNdnBmk54SoA8Me1N12X6fn3MHi7CJPo8tAoVE9Qa0ZYCxXbp6eDz419NHWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210160;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=a/xQi7IAk9m+nuRxq8RigTOPlEQpxTs7m/an1+AlzF4=;
	b=DXEGmHCdNr+ZCPA3mZuWXEr443PEJZCCOiOa8aaYCMv3zV7qhdc3g1ymRA0wVNiKFlBx
	 QVugdVolAORJAyQFWxEsfdCPHY9IrUVcxEk7GELNE1Z5HFeWW0140fwV/+6wfjwz9slX0
	 oHsXQXQpOt11Qnp5YWT2ct7GLTXTZe96qO3QRowWmWn27X51nAqmraiahpYwEtXwkr7OH
	 5afd0G7tZfS/F1EQDAyFAjVCNW6NwGzdXzN5U8C1cxaL3mowZbNX3iRnhlDX6TUZ9QNPJ
	 xlPAsjO118rM79uTj2ahOCLMJLcBJEQc4ov/4FjpAN37DhebxOA40PDcx8/U65Gwi7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAow92Pp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226660A2602;
	Wed, 28 Oct 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAow92Pp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793210160;
	b=VGlx3/t19nSNWObNtmDwOUniEPey5tBk8M2I3cOGHI8FCYwZdoptASDsDJ9P/MSIsTn5
	 oP5LA2g6LDWQQ4Id6WDtgmMArnASbF3T3tCrT612pUj1eyfkUVO0hWq9Dabi/xxP1/OkC
	 frGMCz78ORXlM1mvecAlzot05hU240NAQ5Oh1b8g7s4M0iRTrhkvlAzCDZfcNpDoSr37l
	 sO/AtkS+qw3w5kMfGpVTWeOHQ3SsD8AYEb+0AUxtEfsj5XFWMOzinDkmyZ1bPX/CcfPqL
	 5ryzOjKeLGpsvc9cLNiLMIz7QGBSGxNm91V+ed9R10IyM22NgiyXo0N/ITDgrTJduKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793210160;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a/xQi7IAk9m+nuRxq8RigTOPlEQpxTs7m/an1+AlzF4=;
	b=XzKwugfY2vLmALm+xtjanS312GEVb1zc5jU8v5nwgawLLm3AYGk2+pMXyspCtf+9OS6e
	 PG2/Taw6FIi2eIcxquEB9aWuAybiQXYg/vJcb9fS4SJJXwuBpxIq8dGpQNIuZjvTaWtnn
	 W85FUF4No98EBQco5b1dWkxFrrfs1r3TpKgW+lAKv8JO4nhNBsB7JSiwxqnMR+D4beHbl
	 v0jdgVKE774IIlhlQxMqCHwo+M71ZU2cDrave7ANGX8n9sZD10RVRFoZZT9+Oi0RJC4cU
	 fVnHAwmvvcKUBK1AjDdsZLqDsHIyRwLyVd4dcxFSCzA81LXnfm3d6U4wfcjLl17yHHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 66F6D1F031E0;
	Wed, 28 Oct 2026 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210160;
	bh=a/xQi7IAk9m+nuRxq8RigTOPlEQpxTs7m/an1+AlzF4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=VAow92Ppr+IMuw7VvilX8pwKxsVOpLDpRA32Zl55JmPzBZ7wGG8Efs0PlNRLQJDYB
	 gkfZWeE/gh4yJsQqzKUoFC3toQeLIf1biGfxtxqiU+RnbtY93xALrpcxZX2WdOTUoe
	 d2WAyip5eFxmRcnR8F+U3sz9l2Tz3qpKxr920nOku6oCyCIiHM9AttWG7faLXMJzaA
	 pUAgevDbCblfMaB64LfUZwk8y8c2JkLMpv7MoXRTRhlfJJ4q8qGeU6Xgnq8rNysJuS
	 3GC7rkvQ+Ar4SqZDmkfPsZlfww/ugIwmAdg7RmShRSfnijHEBc7RC6YFxddQCJSy0o
	 /REGrIVBxSwRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EB99B45523;
	Wed, 28 Oct 2026 17:55:58 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Subject: [PATCH net v3 0/2] vsock/bpf: fix waiting and flag handling in
 recvmsg
Date: Wed, 28 Oct 2026 18:55:39 +0100
Message-Id: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CMBCGr0Jm7ZhOQRRW3sOwKGWQqimmrY2Gc
 HdL3bv8/ucCnp1hD22xgONovJltgnJXgJ6UvTKaITFIIWsSgvDeTyUSCilxNG+MErkcqZKNqCt
 SkHpPx8nJmxewHKD7if7V31iHbW2LTcaH2X3yc6Qc/nMSKbEeFTeHk6LmWJ/5MSjH+4GhW9f1C
 8dh32bJAAAA
X-Change-ID: 20261001-kbh3-1-022-fix-v2-e3f14290641a
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793210158; l=3124;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=5BjgUPTK+Q5h2bvpD5C1SETglAWcW6+J75MQCpy5pss=;
 b=hIkUf7xsHfJhu8is5rphbJIa8ojwE74njpamLIww2+KFea5blbCiVJ7YFgrtSD8m2+PX1ycYc
 Nb2geFyhP/SDVckrvVsn8DykNasVOYCwvTL8t3zP8dQ5S391WhRH2JC
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

vsock_bpf_recvmsg() holds lock_sock() while it sleeps for data, so the
transport's delivery worker, which needs that lock to queue the data,
deadlocks with the reader. Patch 1 releases the lock around the wait and
makes the wait loop with the exit conditions of the native path,
including a state check that ends the wait on a reset connection after
getsockopt(SO_ERROR) has cleared sk_err. Patch 2 handles the reads that
should never reach the sockmap wait: len == 0, MSG_ERRQUEUE and MSG_OOB.

v2 was one patch; as Michal noted, it mixed the deadlock fix with
fixes for pre-existing issues, so v3 splits it. Patch 1 alone fixes the
deadlock, the dataless wakeup, the peer shutdown and the reset cases;
the zero-length, MSG_ERRQUEUE and MSG_OOB reads keep their current
behaviour until patch 2.

Not addressed here: the netdev Sashiko review of v2 also noted a
pre-existing case where data that sits only in psock->ingress_skb makes
recvmsg() fall back to the native path, which never looks at the psock
queues. It is independent of this series and I will send a separate
patch for it. Annotating the lockless accesses with
READ_ONCE()/WRITE_ONCE() is likewise left for a separate patch that also
covers the native vsock_connectible_wait_data().

The deadlock and the MSG_ERRQUEUE case were found with the help of
Anthropic's Claude; the other cases come from the netdev Sashiko review.
The reproducers are available on request.

Changes in v3:
- Split into two patches (Michal): 1/2 releases the lock and loops in
  the wait, 2/2 handles len == 0, MSG_ERRQUEUE and MSG_OOB.
- 1/2: also end the wait once the socket is no longer TCP_ESTABLISHED
  (0 with SOCK_DONE, else -ENOTCONN, as __vsock_connectible_recvmsg()
  does), so a reset connection whose error was read with SO_ERROR no
  longer waits out the timeout (Sashiko review of v2).
- 2/2: reject MSG_OOB with -EOPNOTSUPP before the len == 0 check, as
  unix_bpf does; this also stops MSG_OOB from consuming ordinary bytes
  (Sashiko review of v2).
- Stefano's Acked-by on v1 is not carried: neither patch matches v1.
- Drop the Assisted-by trailer (removed upstream); tool use is disclosed
  above instead.
- Rebase onto current net.
- Link to v2: https://lore.kernel.org/netdev/20261001-kbh3-1-022-fix-v2-v1-1-cfae958a1976@eldare.de/

Changes in v2:
- Make vsock_msg_wait_data() loop, check sk_err and the peer
  SEND_SHUTDOWN, and add the len == 0 guard (Sashiko review of v1);
  route MSG_ERRQUEUE to the native path ahead of the guard.
- Link to v1: https://lore.kernel.org/netdev/20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de/

---
Jerome Mohm (2):
      vsock/bpf: release sock lock while waiting for data in recvmsg
      vsock/bpf: fix zero-length, MSG_OOB and MSG_ERRQUEUE reads in recvmsg

 net/vmw_vsock/vsock_bpf.c | 71 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 14 deletions(-)
---
base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
change-id: 20261001-kbh3-1-022-fix-v2-e3f14290641a

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


