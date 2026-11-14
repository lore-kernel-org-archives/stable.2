Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657556;
	b=TNICQ0IDTA9qPwcVlc30rsSfS+P3Pa8r57tbXHG1i2ANcukm263gNl3m8YHm0jLphbD7
	 m3cYvmHmTAcIKwb8Vk1oZMp3bxdot7o4RQE8rZZmZVTXqDmHL6PTodWVdEu+aFrulwnpx
	 MXjB1wSitzhyPULtC4DbploJLUaqgh5HBsmNXISKKDklLaCYvmOUdwGqagi3YGRWEHkx0
	 hUZyUSygSSJFWf1/Xz5Gn4Y2BE5dCumvYdK2iIn5Xvs+HQhJuRloP22vMnzksZlqkeZ+I
	 BHCTLeHc8eE+9SYh66SEljT1zjEtpl7nIN7GWB+uSEFH25c+tTcKf7eoJXW4a1g8Kxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SPA37YGgureDWQIEB+9Q3nNARSqEbSpJ8VBl+t4Y6c0=;
	b=bO8FQm4cnqrznax8Uxxd4351/qfrxM/It0tgX4btEmheEXYdSewVvTQunM0ObS/bMO+u
	 2IciqUHYarg8VT/0ZE8LfbeYFKy9R9yT/TBe/Rks6jMvHOvzF7WjtHm4KviKlR6+OGHMB
	 38GExhT/z48p8MJI9XT2Wc4EwgZB7u2SF24ZJjy0bBcs7KxPd8H0XRI5zqUCTrMKMNyGH
	 1V6GRbI9EKEIUpw+zz/npHDmAe5dTxk+9zzPj6o7foE3tpzJxIR/MNLDbBe7wkO/ieXfu
	 DpnE0WOtCNHMydlQy8djR4nauQZLsfBYZUiZGvKQuUUrBMnyRYfVncLP+9Q3Lc7G6ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CevO0zI9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFB606A32D;
	Sat, 14 Nov 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CevO0zI9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794657556;
	b=p/pZCm9V8cQECLPtC31Xd4kFiHuQCC5KRti7cN41qfuRqHJhVlu+jixRURel9tbJlwsG
	 tYBdNGSEADiMVjL8IOGaA0sG5FxtpoCXHifawNHulO/idZ3O/zwt1YiA06XsrojQ6tQ7V
	 ksVLEDGJEgqsRF48FTZ+YiDe8bThH/x/qXNUrizTd99u377OCXgk8w7l4I/nn3r2PGMQR
	 2XJ6rEF8RhVU/FKCOIMrv+HtsTjBWtXYyFT8eEb1tPghDXe1vaav9HEEXENsUQYMu5WIG
	 23+PVDAi7/flgrkV7ql85eYlck5fO4UepN2OjPcRyFJjh4Y5xRK5Wck0/j+PhB9qOmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794657556;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SPA37YGgureDWQIEB+9Q3nNARSqEbSpJ8VBl+t4Y6c0=;
	b=snO2mjW8B5GJI/TZKtVZ+mH1apuTj6PWJd37kxKeEIgJeCBgfRoF3KUUaL3NovK+vmF5
	 Z/z+ZtdUvUhjpR45ZlxwocLAAyNOk/tjZxAp0FzYyJjeSFKktSsgcVR0Q8xBCGQVEOY/R
	 JHAUmPH2N5dvf5zDqBx0gRvFjZP/7G/+F3C52XZQdLsLbQDpxO4k8fVaF/Ume3/oudkjS
	 uGome2E3jiBIxo4itRy5ngPzwS5e/MwCnzTyXw46coNLlC1D2fEdR9gt5sox33VUlXnZm
	 8WMnDYFkj2/LKdQdK41Vcz288ZecOSuEWi787nM/91tvSVoQgZ2Coh1Do/hD4gdLTtw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B97C71F000C4;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657556;
	bh=SPA37YGgureDWQIEB+9Q3nNARSqEbSpJ8VBl+t4Y6c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CevO0zI92EWJyvfjonwAAn27fhnxW/S162JefscfA0lJxAgQ42AE2n2aVFgoG2mam
	 H1U/JRQCoeqc2CoZbOwYQ4r9U+PzFVMIEyX1a+PXx6rJvoj+lCca8x6jd5Rb0JAuTx
	 15m7Il5j913U3XmiGAbqDV/e5l1br7qEG//qKh6WxGlfwu8qXlVEAL1/Nx3d8IQX6H
	 0ang5g7/bI/EoIns0BgupGAgDmftevmWIeY2DXC8gKn47v8gajgstT7n7MAIGNQx8Y
	 6G7PItujaOzjwWM2bxDbA3hVXUXFz+WWaEIAk3+iOFQczIIoU+P75OwXN7+HX5n3Zx
	 cwRahjn0VgmpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 30FAB49D76;
	Sat, 14 Nov 2026 11:59:15 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Sat, 14 Nov 2026 12:59:14 +0100
Subject: [PATCH net v6 1/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads
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
Message-Id: <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794657554; l=2260;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=HNk00rg3w34p5I+aJL5/O9foUQOvgErOJTc5nh/GqmQ=;
 b=swjcV4jiYBjHRD+LmXnkm4bBMz5vy4M5McoYob0jJlTaEfRXY+ad6xFFFFtcLe4OhoOT/wnJ0
 SohR0mWWn1DAy4oT/UEDBgfmmzhcdpCtcLvSj+7BIusfI3+jsD7ehrY
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

On a vsock socket in a sockmap, vsock_bpf_recvmsg() sends zero-length,
MSG_OOB and MSG_ERRQUEUE reads down the sockmap path whenever the psock
queue has data or nothing is queued at all. That path copies from the
psock queue and waits for data, and it handles none of these reads:

 - a zero-length read with data in the psock queue spins with the
   socket lock held, and the delivery worker blocks on that lock;
 - MSG_ERRQUEUE consumes stream bytes from the psock queue, and the
   zero-length MSG_ERRQUEUE read that MSG_ZEROCOPY users make to collect
   completions gets -EAGAIN or blocks instead of reading the error
   queue;
 - MSG_OOB consumes ordinary stream bytes or waits for data, where a
   connected native socket returns -EOPNOTSUPP.

Hand these reads to __vsock_recvmsg(), the path of a socket outside a
sockmap, which does not wait for any of them. They now take one path,
so the order of the checks no longer matters.

The MSG_ERRQUEUE case was found with the help of Anthropic's Claude,
its stream-byte and MSG_ZEROCOPY parts by Stefano, and the zero-length
and MSG_OOB cases by the netdev Sashiko reviews. Each was reproduced in
a VM with a vsock-loopback socket in a sockmap, without kernel changes
or error injection. With this patch alone they behave as on a native
socket. The vsock vmtest.sh single-VM tests and the BPF sockmap
selftests pass with the series; I did not run them on this patch alone.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..c9b399f37720 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -80,6 +80,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct vsock_sock *vsk;
 	int copied;
 
+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
+		return __vsock_recvmsg(sk, msg, len, flags);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return __vsock_recvmsg(sk, msg, len, flags);

-- 
2.56.0


