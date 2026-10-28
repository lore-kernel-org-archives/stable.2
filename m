Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210161;
	b=XD7tw20goxFeasrLbZ1qm51F3h2Rz9XSXmiv21qeSv+yh0InwlOKmYm/xBpKBfMdEB0O
	 3h35T0ID7HpPoZ7BL5gVf/hhXbVM34tPVtqI2ZCk/FOWQVfGsahY/mpOaUikXXo2wbpnB
	 CiegS4zuY0R1hQTxpkh/7smsyfrMnVi/gfp7uewabSyxVYnjsaeVGS8IoUmpujK1XwBTP
	 TeUa/CfrTZykDKYePCDAhmRO4E2Obc6UnlQ6fapnMMpnuCPugVBp4K/Gc5rmfrdWhNiJ3
	 Nx3PB9I8ebBQ1gKdlt7ScfCqrQfLH2svGspo/Kf0jO4PqC33I9eamFaLAfC0s8Vpaag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/7kQZK30vWurR4LOhHkoetB3xKBvRcGAUihhiqGJHYc=;
	b=LNAiUBzB++VA+As2PGAjRmJF0UcO54AwtM4RrLOOTHRS2d1ltbJSKQwE280W+jdjnf3c
	 N8NcspWndKSR9BvkAe4xv4zEK4qH6p18Azjjgn2a2qxufl20MbUVb5yWh2rYHpf6MlhGa
	 9yQxybKJ55Ppm0vhhYkzGM7HX/S1v7kKmYAG6Zy0SyGlgecRq8rlcTt7+EKyh0qMXKOhY
	 DOrRaSw44lCY2RrbZhz0DNMbxij5QdipRJrrnRdPAA2BEtygsdW1Bvd/L9fCmtwKK3CI+
	 zGn7imuVmezC2NtslVhgf+oDyhHthhdJsH6P4PCTDS9A9cJaCNirH/1LWFY7auFAjow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKWuicWj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37860A263C;
	Wed, 28 Oct 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKWuicWj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793210160;
	b=nTLr5Yguq0b/C3H2OebW5hKxN5fKonxHD2xKVoAvM+3TUNA2vA5aXJOMiA4HHu/OCnrE
	 /Yn0N1qGuU3orrHTqpQF9Y2L/GXsT76SBuiTflfNDMN4Og0JlUJ7aUR6n4KWwcSDrqIsj
	 enOFXfcQbZKWQyCOGPbylENstpSUydJyKXx06lj3NnnKOKexf9U/dka7pwNfF63gaQ5yf
	 ex27Deg+BVKNugAmHyGWjyFbizA2NXLIde7/pguBR6NX9KfiXxq2m7owVjPcDlod6++cl
	 BLpLlnifDbCuBe+O+DPlqZJ22u5TzdBzwB53nJDddJyrMypFyPEe6exWIRIecwFYdOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793210160;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/7kQZK30vWurR4LOhHkoetB3xKBvRcGAUihhiqGJHYc=;
	b=aRRBJ7OtXVPs4okXHaJW9/U0QVJNam24j+jQoinR9t5p3CvsMymxBI0miUqCGOssfgQr
	 E9yS0tdwZtIZJEYcMd6e2UxhhRcPhhDpDTrrtowRtlPFSmAbmgTGZH/aTjSf4NcC/9OLc
	 hskRimFO9+ACng3zKISTMPFD13jrnhmxKIeDy/fQaMywICZbbN/wbkee/2rjWDM0DgG+X
	 dL+ydnkBDzYHbTeoZWefhfqnrlThMPEogNUGDAjIutbqkvpofbMIk8xNLJT0kgJC8UJ5y
	 I1FKy1TRo0WFSQ2Fp9S8DjTMQAHcNljKlb0AsGoo4Y0vdc58VSLWw8MRJMwsmaRki9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7D8C31F031E5;
	Wed, 28 Oct 2026 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210160;
	bh=/7kQZK30vWurR4LOhHkoetB3xKBvRcGAUihhiqGJHYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jKWuicWjrWioaG8lRJQRktM1sg0hD3rgP1zhB+/dQ59e6I44SI8htGFkuj/Sq3BYp
	 sesglhHmNXd0GbTR1YkIoi9tEkIH/ZP22N9CQM7/xrMyVVNPWqXxdzJjKs/1JrHKFd
	 W7kS2Q11VDCnEkRbecauF/kNz+HSPYs9GMCQFbC44iz9zf6TBa57sF58wVEjdKKiWF
	 0ORiaFv2v27/hE+VRe+hIoWQaHDZeKI49JpWvM46GFG31lnUU+H4EXPfnwKwH9SR09
	 g51MA7GpQQ7qCEQN8w9j53px5Td/TlSaWhEvNkP3yyBDtr3XcIrx2smpkSto5QWUsy
	 pHh5xLgg3dR7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0E9CC45532;
	Wed, 28 Oct 2026 17:55:59 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Wed, 28 Oct 2026 18:55:41 +0100
Subject: [PATCH net v3 2/2] vsock/bpf: fix zero-length, MSG_OOB and
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
Message-Id: <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793210158; l=3879;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=Fv6wIyCvdPA88rsjL1PDN9TTHIaiEj+Jl/xpP9BfqoA=;
 b=vmSFC1mMOaV9MgLgItP9fekE1g5KX6bCdGA9DejGXaGzh/80o4zkGJivxjZZg76MZW4/2Kvhn
 Q+3bo60dXw8CHTUDk2ilW9hV1oPL9CmHR01g8x4AnIN03M/z+DgxcQ/
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() sends every read that cannot be served from the
transport's own queue through sk_msg_recvmsg() and its wait loop. Three
kinds of read do not fit that path:

 - len == 0: with data queued in the psock ingress queue (for example
   after an SK_PASS verdict), sk_msg_recvmsg() copies nothing and
   returns 0, and the wait reports data ready at once, so the loop spins
   with lock_sock() held. The vsock delivery worker then blocks on the
   same lock and all rx on the transport stops (hung-task).
   tcp_bpf, udp_bpf and unix_bpf return 0 early, and
   __vsock_connectible_recvmsg() handles len == 0 too.

 - MSG_ERRQUEUE: the read only reaches sock_recv_errqueue() when the
   native fallback happens to be taken. With empty queues a blocking
   recvmsg(MSG_ERRQUEUE) waits for stream data instead of returning
   -EAGAIN for an empty error queue. Route it to the native path first,
   as tcp_bpf does, so it is also not caught by the len == 0 check.

 - MSG_OOB: vsock has no out-of-band data and the native path returns
   -EOPNOTSUPP, but sk_msg_recvmsg() ignores the flag and consumes
   ordinary stream bytes; with empty queues the read waits for data.
   Reject it right after the MSG_ERRQUEUE route and, as
   unix_bpf_recvmsg() does, before the len == 0 check.

The len == 0 and MSG_OOB cases were reported by the netdev Sashiko AI
review of earlier, single-patch versions of this fix; the MSG_ERRQUEUE
case was found with the help of an LLM coding assistant (Anthropic's
Claude). Each reproducer is a C program run as root in the guest: it
adds one end of a vsock-loopback stream connection to a BPF sockmap
(CAP_BPF and CAP_NET_ADMIN), for the queued-byte cases with an SK_PASS
stream-verdict program, and issues the reads below. No kernel change or
error injection is needed. The reproducers are available on request.

Testing: on a private VM with a KASAN + lockdep kernel on net, with
reproducers over vsock-loopback. Before this patch: recv(fd, buf, 0, 0)
with a byte in the psock ingress queue spins and the delivery worker
hangs (hung-task); a zero-length recvmsg(MSG_ERRQUEUE) blocks; and
recv() with MSG_OOB waits for data or returns a queued ordinary byte,
which a following plain recv() then misses. After: a zero-length recv()
returns 0 and the next recv() returns the byte; MSG_ERRQUEUE returns
-EAGAIN from the empty error queue; MSG_OOB returns -EOPNOTSUPP at once
and consumes nothing. With both patches of this series applied, the
three single-VM tests of tools/testing/selftests/vsock/vmtest.sh
(vm_server_host_client, vm_client_host_server, vm_loopback; 44
vsock_test cases each) pass, as on net; on both kernels the host-side
runs skip the SO_INQ cases (SO_INQ not supported by the host kernel).
The ns_* tests of vmtest.sh were not run (they need root on the host).
The BPF test_progs sockmap_basic, sockmap_listen and sockmap_redir tests
pass (767 of 767 subtests, among them the three vsock subtests of
sockmap_basic and the 240 AF_VSOCK cases of sockmap_redir).

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 5120911b8143..3edc01268c42 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -111,6 +111,15 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
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


