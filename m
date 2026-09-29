Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F133CB2C7;
	Tue, 29 Sep 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699587; cv=none; b=oZOrzFdrlah5rnO/rNTrUfRsPuw8jRybVnnAAlMmLHDEm//H8zR76J7Afmo8odkdpgmlQ1nVaiyTuJ18ym2tkobGFLa67wPXFPwQdIpoQUXI80q1tpnIInPpO46Tz3DHg8C4g/Tgj7soEKJmlVRroTvpHXuLCsPi3pYFsX/ng+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699587; c=relaxed/simple;
	bh=0RUTTWkAztuBE6kNH8F0KG1K63UvbLEBc1iYCnmJwiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F9m6L9WjaXz/YXcwmTVSleZxUGPMj5G05H/jpu1KYJVo+4gaSNBiGHI1LkVlXrliEl1TyBgaFTp5wuMK2vlr0sh9dxiD8Gjmw69tEFIxhRHE3+ZCiN9q3m+VcZ29F7aKCwNpq61qadaf/n0L6IhUQkJ2GqsM3FIoti3hqN8RBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqdKaM/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqdKaM/C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6AFEC4AF0B;
	Tue, 29 Sep 2026 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790699586;
	bh=0RUTTWkAztuBE6kNH8F0KG1K63UvbLEBc1iYCnmJwiQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AqdKaM/C9shv7K4p87qMEdsdgC6ywFh2ZnedXGpLU6O74lFpfhYYX5UZtMawuMsnJ
	 LgEwStb8FyzfqKJOcoIpG5H9Ym/A0Ol/MKcm/bCRDAiMBNmUJq4DKkhA9fBy+8TmXS
	 8JBOgKGwCB4+xIYddejgj7NMlhoh5pqZ8YJatMQZchRei5FuzLYAdXxfSOj0Qhtl67
	 F9VZL+MDLTw0pjc7WGuJELeuUGsuwuTAms87HSuSCPDXs3hgE3oYSVyLV2QLkkdlrT
	 jhNWxRX6GvFZHqQIKxH7ftdrJ3qXCP8cOQ08sXeGoq+brW2q/oBm8VXFb5r7POT20U
	 EkWEfqdByUMSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DBCA5FA5;
	Tue, 29 Sep 2026 16:33:06 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Tue, 29 Sep 2026 18:33:04 +0200
Subject: [PATCH net] vsock/bpf: release sock lock while waiting for data in
 recvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swubjVjqr4iHtN3YVYiStCKU/
 nujHmdgZkXRbFpwblZkfVuxZ6rgDg2GKaSbko2VISwn7qSjRz95csQiFO1D/sgh+NhGbh1q9Mp
 a9W94QdIZ178sS3/XYf6usG07HflYVHcAAAA=
X-Change-ID: 20260929-kbh3-1-022-fix-340aa3f7f071
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
 Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790699585; l=2593;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=4IPBHLtgo8ghTbbKAwJ8yZ9NmPZQTYBQyUYCEEc51UE=;
 b=a5k/85Mme7ztf5MTcaik5O/66KyvJ3vqg/NckJwjUvqqNN5AX0f09Nk7mbJKtmd2bED+s22s3
 o2QNttsa+atCbSNoqOIKaMTU4xeuiPQ5/JHuHN5r0C3z65nhuT8jNyQ
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the whole
receive loop, including vsock_msg_wait_data(), which sleeps in
wait_woken() without dropping the lock. When data arrives, the
transport's delivery context (the vsock-loopback worker, or the
virtio/vhost rx path) calls virtio_transport_recv_pkt() -> lock_sock()
on the same socket and blocks. That context is the only one that would
queue the skb and call sk_data_ready() to wake the reader, so neither
side makes progress. A blocking recv() hangs until a signal arrives (a
finite SO_RCVTIMEO also breaks it); while it lasts the shared delivery
worker is stalled, so all vsock rx on that transport stops, not only
the affected socket. The hung-task watchdog reports the worker blocked
in D state:

  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
  Call Trace:
   __schedule
   schedule
   __lock_sock
   lock_sock_nested
   virtio_transport_recv_pkt
   vsock_loopback_work

The reader holds the same sk_lock-AF_VSOCK it is waiting on, taken in
vsock_bpf_recvmsg().

This code is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
drops u->iolock around wait_woken() and re-takes it afterwards. The
vsock port substituted lock_sock() for that serialisation lock but
omitted the unlock and relock. tcp_bpf and the native
vsock_connectible_wait_data() both drop the lock across the wait;
vsock_bpf is the only one that does not.

Release the socket lock around the wait and re-acquire it before
re-checking for data, so the caller's locking is unchanged.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/vsock_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..bb7d81a95baa 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long ti
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = vsock_has_data(sk, psock);
 	if (!ret) {
+		release_sock(sk);
 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 		ret = vsock_has_data(sk, psock);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260929-kbh3-1-022-fix-340aa3f7f071

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


