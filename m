Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32F52D2B3;
	Tue,  8 Sep 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869885; cv=none; b=NnoEDlL7i2nmILgiXbmvU0XVe+MgtrWqzBcU+DhenQ5SR46B0zgW0w08sApc+X9rsuVHoNRMxP7OIEaNaXKiyaoCMe/MEQGMisEfJWskT2g7dXcNBLFMm9PX++NF3fF/TLUE5YA02N0qP1tE3ju2YnIt6L8g3KDYdWvob7G1aCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869885; c=relaxed/simple;
	bh=KzsdawDLxTRlnTCuQxp0McWfnQ4xiy/NYzw9ZRBEEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NphT6K2CABI4c37dOpkmWMEYu+mY6i1o4QgsqQlwRYQ+FLuCWOFRiy8H+w5M+KBzrtp3gMxWM8ClcYrLXiSrjKhQkqDn7xFBUrDA0tWvcrJmBqlhYyC5YS4raqChh3LAkNY90ip1b/jBFk7OhYB950QYIiZOSoAVGEOsPEfrDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f296w9/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f296w9/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7E1F00A3A;
	Tue,  8 Sep 2026 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788869879;
	bh=66ooEKVLbtl0ky7Wg+6hd1bobdHtjV4SER9G4/VGnLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f296w9/qgQrLsZ2LDV5XUecyQD8yhrxnpQiC8SULUCZF54XsCwpH668rpA6xgX7zw
	 PVal9tljne/UMSMDdeylNSDuNVpUJVFdLXDMo2mc3RVPB1uXrzAgTDlfDOFvroTWdR
	 RYFLrVBMdGRmLbyCgzCsGaRj0eopCP2DWdU1rn9KaQF+tNHfaUPpjW4Fpyu4tJvnFD
	 /1r2I2XeETIscEsU/xIm07gIM+nVZXXNyJ9e3kO8SAEsxVsrOEVWWxYM/cxCnGIDJn
	 rwqR5TXeKiSQrXsDruRoBOp2XmSEZ0hZ7yNKiL3bbLXnKbfnHLPScfQZc826iL7RUP
	 6UTHsolkGM7nA==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Tue,  8 Sep 2026 13:17:40 +0100
Message-ID: <20260908121740.432088-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
References: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai?part=1
---
> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c
> @@ -52,6 +50,19 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>  	}
>  #endif
>  
> +	if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
> +	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
> +		sk_drops_inc(udp_sk);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
> +	skb->dev = NULL;
> +	skb_set_owner_r(skb, udp_sk);
> +	skb_dst_force(skb);
> +
> +	skb->mark = RXRPC_SKB_MARK_PACKET;
> +	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
>  	skb_queue_tail(rx_queue, skb);
>  	wake_up_process(io_thread);
>  	return 0;

[Severity: High]
This borrows UDP's rmem accounting without borrowing the lock that
protects it.

rxrpc_encap_rcv() is called from the UDP receive path in softirq
context with neither lock_sock(udp_sk) nor
udp_sk->sk_receive_queue.lock held, and nothing serialises two CPUs
delivering to the same local endpoint. Both new accounting calls in
this hunk perform an unsynchronised read-modify-write on
udp_sk->sk_forward_alloc: sk_rmem_schedule() reaches
__sk_mem_schedule()/sk_forward_alloc_add(), and skb_set_owner_r()
calls sk_mem_charge(), which is the same non-atomic
WRITE_ONCE(sk->sk_forward_alloc, ...) update. The newly added
skb_orphan() in rxrpc_io_thread() closes the loop from the kthread
side: sock_rfree() -> sk_mem_uncharge() does the same non-atomic
update concurrently with softirq enqueues on other CPUs. Note that
only sk_rmem_alloc is atomic_t here; sk_forward_alloc is not, so the
atomic_read() guard at the top of the hunk does not make any of this
safe.

The normal UDP path does not have this problem because
__udp_enqueue_schedule_skb() performs the forward-alloc bookkeeping
and the skb_set_owner_r() under sk->sk_receive_queue.lock, and
udp_rmem_release() takes the same lock before reclaiming. The
consequence of losing that serialisation is not confined to this
socket: the drifted sk_forward_alloc is eventually handed to
__sk_mem_reduce_allocated(), which subtracts it from the protocol-wide
udp_prot memory_allocated counter, so a flood of RxRPC-shaped packets
can skew global UDP memory accounting for every UDP socket on the
machine. That is a worse failure mode than the unbounded rx_queue this
patch is trying to fix.

How do you want to serialise this? Options I can see are enqueueing
via the existing UDP receive-queue locking rather than open-coding the
charge, or holding local->rx_queue.lock across both the charge in
rxrpc_encap_rcv() and the skb_orphan() in rxrpc_io_thread() so the
charge and uncharge sides are mutually exclusive. Please say which you
intend, and make sure the answer covers the I/O-thread uncharge path
too, not just the two enqueue-side calls.
