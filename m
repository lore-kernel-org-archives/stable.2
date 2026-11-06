Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794002246;
	b=2n7hvBYuYi1bO/KFwoEHcb0Ax0w4u0/U6L4O2dPmsHcFkVlUFxh6HHEOw8hcNi3iqM2N
	 DRE4Oy8XhlNtsQHUoy6qMEYxyOShNdPRIbkZy/6M85v9nBYMe+z11dqq18B9DCq7RIkKX
	 q/kNLM1ODl/aD5aRC3KctT02mVQWRpymIYqHovJtm6Ue5Mexdba6baXcpcuefSzKyuw1D
	 j2EOxRHccjXRez5CzvF6ONiGVyrGdaVivN55p3cz1G3/Y9TD157u0BwcY4hzas9TvBcfX
	 nkHEclhNOPY2XJFz02oKnAxe5u3kmyS1Ftv4rDTq6N1mPLXRdgGaUDFUJgWGiU7wFJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002246;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4hTF15KGZnWZXaxkczJaxpuVmQOPU5K6aaPcUmXIxUQ=;
	b=kGra/X7YgnHH57i6K/DykpFuU+1EIX7sVwMsc5+K7cpPLo6jB77p1GyFETGGMgxEK3ue
	 F/YsRxaq00sSzXG3asEF2vb0aN7fOj9zDY3imHMgQ7t7iSYc4gaUJLufHnhs3aLu9q4Y/
	 FpUjNLwaaxCYo6R9xdJylUdEwmmaF6oFlj32289vF8HopL0iDKNMVVqlBVHBheJsPGuVs
	 4kbCYlbscenHAgsKnDWH0A2x/Z/cKGuy5E4ILXGmxCkNE4q255sh6DstHvlcB1+9G8O4+
	 yVic63Z7yFAe0wJ/pnsW65ha38ffW+9xur/fK1Z2GUDmplkAdyUSyDNStq6/qRl7FDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmXRZoMV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3511606A33A;
	Fri,  6 Nov 2026 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmXRZoMV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794002245;
	b=GQFLqXs9ZSBdCVsaypa7ul4+rB/iuREMX8x+JAM/ZwvYWCLIEHkT37MuQMykjSSUxLuP
	 7Iw98j8+vBhEh1UU4XAAAn0Gq4aOOzeobM+MLcZksrd90fxd4KXbgu/FwuHwOHy+G97zD
	 a3DCuOatsN01DUn8pYLrzuIdk5OfZEoVufoIqVms6o687eLx2vxNECG/x93PFJqHNrip/
	 7QS5GzqDjbLVQiTdkU+0Grx1Tx2lQ9Stch7nBelg91RZhnIV8Of39eRBMPl/CV11JBzaV
	 7In/AJKP8LFfvBdm3FtjN8wm27lCcjUvwlAiZg9pjZqyCYJ1KhMf6gqCuRX1cpKKdoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002245;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4hTF15KGZnWZXaxkczJaxpuVmQOPU5K6aaPcUmXIxUQ=;
	b=XMA4wY13oO2feldtj9iB8YOXNB2F8mmGe2//7wSY5Rhy8KdAQrFiFSzEaDOEJUYmr/d+
	 iiEVkEdVFcYY7+xtPB9vFfxumjp7ttFbuy82Lc9lY7dT4GkR8UUbZqi4wodG6893xGMHA
	 j3W9RX9mJX4PKj5eHGJwwm02K0lmfRhZbBFSG2aEhx010N9wfB4Gmzwxg2pA4zQw9F19Z
	 MRdk+IXErvKnsmSlJ9eB/DczKsCNi5XhlXEyqICQC9ZSQ1TUUQ3hVS+l14nJltjCA6isR
	 pFFHdxa3u5NbZ46Us9MR4/VDa6fCqZBQVR7FOl9SlEItVVRZdJmHcECMAt3gePqlDmw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 068601F008A1;
	Fri,  6 Nov 2026 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794002245;
	bh=4hTF15KGZnWZXaxkczJaxpuVmQOPU5K6aaPcUmXIxUQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BmXRZoMVRUwrx6vKTJEE8lQTIttkKxTb9rd4NZ15y4yLfggmRPBh6TkjotfmWONCL
	 eSD/PAh+Lm2TXi/lWQeZh8a/GeeItO/4pFknTB/gNMbgCGjgmvbO9XLGvBbksZ47aG
	 A6LOWPartW7dCrWVT3dH2Y9FcsGtVl6KOMME2v2J9KnmVdsSYHZqK/lvLzz3hhJBJM
	 B9sp+TruqCfV+GGwTmTFb671dLECc7Yq6PFgYofTf8NlQs98ok3uZHKTJLJFwNk6/a
	 D7WngxUmDbC9tfKQPJ3h5HILbzG7xq1bUdAGQCYVYvZr4CNRfktqQNfAXOJOf+MlwU
	 bYwFDDYeB8nCg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5BF06478B1;
	Fri,  6 Nov 2026 21:57:23 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Subject: [PATCH net v4 0/2] vsock/bpf: fix waiting and flag handling in
 recvmsg
Date: Fri, 06 Nov 2026 22:57:20 +0100
Message-Id: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NOw7CMBBErxK5ZpG9zpeKeyAKfzbEgBJkBwsU5
 e44oUmBKN/uzJuJBfKOAjtkE/MUXXBDnyDfZcx0qr8QOJuYIcdScC7gpjsJAjgitO4FEYFkK3J
 seJkLxVLv4Sl9VueJ9TSy8/cYnvpKZlxsS6xzYRz8e12OYg3/GYkisWkVNUWtRFOVR7pb5Wlva
 fVHuTFg/csggYM2vCpQo5VWbw3zPH8AJ4gEqgsBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794002242; l=3156;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=3N1HVbW/FKojBN21DNx2VL0tmiNZKFzaJqEUw7vm67M=;
 b=dzk2bNoM+L/XeEtTJDqisAtunD/8hRkFnTCN+GQfp2y4JcrBsy04acBNPoTkUcxKfYxQm442M
 4vz/Xn5ONiVC2M5bVBzXmgcbfqPuYtoIEKpgY5HrdJ2I16tmzZnqwXK
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

vsock_bpf_recvmsg() holds lock_sock() while it sleeps for data, so the
transport's delivery worker, which needs that lock to queue the data,
deadlocks with the reader. Patch 1 releases the lock around the wait and
makes the wait loop with the exit conditions of the native path. Patch 2
handles the reads that should never reach the sockmap wait: len == 0,
MSG_ERRQUEUE and MSG_OOB.

Not addressed here, as in v3: data that sits only in psock->ingress_skb,
and READ_ONCE()/WRITE_ONCE() for the lockless accesses; both are left for
separate patches. Not run: the ns_* tests of vmtest.sh (they need root on
the host); the reproducers ran in a guest over virtio-vsock (PCI) and
vsock-loopback only.

The deadlock and the MSG_ERRQUEUE case were found with the help of
Anthropic's Claude; the other cases come from the netdev Sashiko review.
The reproducers are available on request.

Changes in v4:
- 1/2: comment why the wait stops on sk_err and why it checks
  signal_pending() (Stefano).
- 1/2: one data <= 0 check in vsock_bpf_recvmsg() (Stefano).
- 1/2: say why this is one patch and how non-blocking reads change
  (Stefano).
- 2/2: say that MSG_ERRQUEUE consumed stream bytes and why the checks
  come in this order (Stefano).
- Shorter commit messages.
- Rebase onto current net.
- Retested, with a new reproducer for a dataless wakeup during a timed
  wait.
- Link to v3: https://patch.msgid.link/20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de

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

 net/vmw_vsock/vsock_bpf.c | 77 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)
---
base-commit: 6d2cf411aba2aa0bd641b49be5b1964ac5097a50
change-id: 20261001-kbh3-1-022-fix-v2-e3f14290641a

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


