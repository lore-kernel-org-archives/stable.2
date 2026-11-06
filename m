Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794002245;
	b=a9tsPCa/bsMmtzJYeqBo+RvkwlI6MqvTT68pagPffvyJpemFts7wku+nQdYMIqeVttSS
	 gpfuftJJW0wdGth27iE0rrmbYSWM1qFaoTwLQnCF65AcV7GIOpfIvq+6pheSYpn4fMFSt
	 V2K9i2MD9yV58Vj2KNh1EOegRmmzdD2WbdAeZSzURol1RH51T5w6aNtTkIUZw6PgH5bN1
	 xDi13MNYSgXsNtDsGutaT3P16iKPQOhgWFR4vtmCryM7+rCaUCo0lrjVPkEeiO28t6T7M
	 LIb4Y4be/ob+2TZfF/XSCmLgqPftPBLLPWBBzSCX7CIfpbO18ldP6WXEBgGcgARop2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002245;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7ybh3E16d2SUEDENtkilOBR9lZ4BgG8EeV/MZT26TyI=;
	b=j0TDMTCjXb3pd59v5EFVWMmLBmNHJZoleGBRVJ5kaFzjeoUEX0f0DTedGyvJ9r0eFqMW
	 ACa7rr8UPiz2EmFA2dPiu92RSXzd3+H5ofR4ZiGqvlyc+EhSGYS+ha2fv9BU4C/bIvycC
	 dNOB4Ac8nicwsB+srSlha9fKT9jDA9WLM75aRuknu3nrkIHBx4b/0XtzAschrqperQ/go
	 99pPc1RPqc4OXWMTw/+GFATvQoVEeI3R0uLM7DEhFIuMuwj6u0qJ0dyxyxqsMuzkxiXN0
	 aKAvLR7T6JbV3GZlSkyYLhkEFU70qK803GeoZWr4pqZiPeTma3emeKiy6yNgR4TW1IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5nikFIQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30962606A326;
	Fri,  6 Nov 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5nikFIQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794002244;
	b=wo9BRt52MOj5TfOST4CARRMGcL+0AJm/7kIUQOzbe+EXWHhwflI4xVCiQFVECr8yJ7zM
	 8huiuPI/J4lQpe4D4EPEjpnScoQ7p/mq9Yxnj1QFTG50paKFOqIEqhWKdo2mE8xm1PHIT
	 nehgNVY3xtrXmR0DBdkxyTHvllgySqj+HXKnEiFbDsinXov3R/tHMrVdamWBJce1Dj9BZ
	 Tvj3gZZlpGmm/sl/q41m+Uz3P1GKZCzTKOzgNIximzOUEbiZNDCvsVQdngoFhC8ayqk6q
	 7u+IMrU2LLzJsODSJOmVkkG0GSKMVcz/gE9naqVcqlBxh4XPTa3KnOJwIxEd1WD7FjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002244;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7ybh3E16d2SUEDENtkilOBR9lZ4BgG8EeV/MZT26TyI=;
	b=ypoKyOpb64VAeWp9IyMY7hVAa7W4uFpAKrAEDOFCbkQG+84kFzJ0/koG2dd+abE9LOcH
	 OIL7Ba7snm65U9gtqKvpWhpKNn6JwI4SwbZToO6tC+AVLRCQ34OplaLolQQwEA+4wCLlY
	 JF2fq7TIQhgEZHmp1J2iWo1S1dLCW+hDK0vVWlfAVCrbpz04Ftayy8Qcu7xe4H2s8omDE
	 076CiFtQgB9owt3RolDgDovuk0aUE8ZQ7vdzbBIx1diSOYfFwWg8JqNoL9Es7IQl83UJ1
	 P1yeu4YDNXSOJleqng9iETpO7IiHn8yoj2FuL5rTxfZHVZ2TAlbS2fC1IGzNtIX6HDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0636E1F0089F;
	Fri,  6 Nov 2026 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794002244;
	bh=7ybh3E16d2SUEDENtkilOBR9lZ4BgG8EeV/MZT26TyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W5nikFIQSAle88623t11L9MWWNRYzwis8kAGioVtbDtDfzSp4+ELgdEvma0Fjs/x3
	 0+3ZJPvxyDPkGQExXztsmdhV307fsFaZBFXfkTu8o+C1GIjWijh1Csgn66OR+OgeMJ
	 Dh/YOevYYCKRAHAi3BcRSEsL4AZFZQLX6oegCGE6KuvI4XXXQ6RDBxhuHQ1vJxzD5E
	 46brBqPZT4S86cP2CvZtOblip7++CrhteLxlIY6wHYrneKc+oqIW+CWV5kacM08Jto
	 NRxZHa60hMY+TEy7nQv4PLlQ73DtfWPcsURhmFKRNxLYgL9fY9WguAyqTZz7KuCV+s
	 IiFRgaClZnbfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7DD33478B5;
	Fri,  6 Nov 2026 21:57:23 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Fri, 06 Nov 2026 22:57:22 +0100
Subject: [PATCH net v4 2/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads in recvmsg
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
Message-Id: <20261106-kbh3-1-022-fix-v2-v4-2-c7d36703814d@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
In-Reply-To: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794002242; l=2197;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=dwUGR/eCK7GtoK8H9bbKU0ilJyfRtgnQIrQ7vPni5kQ=;
 b=4nZ5slW3UfHVgJAEtqPZdz8lRe6LZIvhoXJrslECxOHSir4x5eu+lfl6KdZ04cTHPnrsnMHUi
 AqwPFJDB60RDKoWYhN1qCGgcwQVMb13vpu1lai55X4LjYu6QHfWu1sK
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() sends every read that the transport queue cannot
serve through sk_msg_recvmsg() and the sockmap wait, which handle
neither a zero length nor these flags:

 - with len == 0 and data in the psock ingress queue the loop spins with
   lock_sock() held, and the delivery worker blocks on the lock;
 - MSG_ERRQUEUE with data in the psock ingress queue consumes stream
   bytes, and a zero-length MSG_ERRQUEUE read, as MSG_ZEROCOPY users
   do, never reaches the error queue: it gets -EAGAIN, or waits for
   stream data if it blocks;
 - MSG_OOB consumes ordinary stream bytes or waits for data, where the
   native path returns -EOPNOTSUPP.

Handle them at the top of vsock_bpf_recvmsg(). The order matters:
MSG_ERRQUEUE goes to the native path first, as in tcp_bpf, or a
zero-length error-queue read would return 0; MSG_OOB comes before
len == 0, as in unix_bpf, so recv(fd, buf, 0, MSG_OOB) returns
-EOPNOTSUPP as on a connected native socket.

The MSG_ERRQUEUE case was found with the help of Anthropic's Claude, the
zero-length and MSG_OOB cases by the netdev Sashiko review. Each was
reproduced in a VM with a vsock-loopback socket in a sockmap, without
kernel changes or error injection. With the series applied the reads
behave as on a connected native socket, and the vsock vmtest.sh
single-VM tests and the BPF sockmap test_progs pass.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 6d96ff03f28c..58b32fbc1f4b 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -119,6 +119,15 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct vsock_sock *vsk;
 	int copied;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return __vsock_recvmsg(sk, msg, len, flags);
+
+	if (flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
+	if (!len)
+		return 0;
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return __vsock_recvmsg(sk, msg, len, flags);

-- 
2.56.0


