Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AC3E7BA9
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503707; cv=none; b=rPz8y4tetU6uAhXcrbRbtf31bgSefgiXh+tGwLJg2r5wM9/RThZwCkXWilzY6cUVu82LKYAEUHR9eu5xndUR91RWbO/UwamDhWqeTNBdu5o3Y6+8dcxKAsL4DeCLOBE+qL+Wrl1TouH3XbMIzj0pO2tCLwGccUtKWQmmssNL46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503707; c=relaxed/simple;
	bh=bZWAhI/SNWesR7lukDoX5NGLCgeYv7Rk10k9NwhATLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSEfX4cNHerzSR9CXnIZWizUw5Hpv6jClCOEUr3OITesLtrMoMRU3bORwhYVw7nHnNcApcLLQLT53XDCP4j/SDxT+nmXNSJWm3oPKS4AN0RdauEJ2va7OIth97wocdad6+yXc55ac6uTN3FwLsL7adcPX9XHrZ+dnbNevAb1D3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4f0WGQQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4f0WGQQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f1d8902so1636057b3a.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503705; x=1781108505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=P4f0WGQQLlTaVlQ5kO7uvNsKxIialrmV+hL9STXbyod7nCYXk6QlXzbj6wY9BMR3JR
         oaMu9ovTjj6l1T5daCPH4t+4O+miA/EwD+6wapQ5T13qSoXBDIaOzpwFW7MDSKqDi5gx
         qWecZQCU9Hde8UYq82yHdQfMIApt5lLc1r4iyCWkQ3ILm8/Ae7v1/qtCOKBSDg108pRF
         EZnJ6yVhEln5EzkILYTQh/lrPk3I1RgBa17yTXkk8PwaJ7hwqhV7ff+57CjzogAcGBFD
         e4hWo7fuxP+33DVFgdOQ7FTIHJJ2GC6+TPklE+ZVA8sCJaTIQSYwcasNIIw7cnntecB4
         mUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503705; x=1781108505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd5YhtxLNp2KnXGrb45Y+o+N5pgMe2J5d5AaYwVVkHo=;
        b=lymsBgLWO9uv/iaaD+e7DpLeb0ozDdDgkp276AQ4xfGf2oSt7BhTxuE4DugRkyey0k
         TO8+F4Dsy3CSSryMAzZvCLGVDiHFNAFVvColKYm3mrdEDjQ0nOjReS4GU7EDl+GMynNY
         IpKwVJr9P/wBAtLWxSbRfaUi6X7fZMkfIcOlPvflVQ3S3fzPFhMKWoqI1SsKH6Z6wv+C
         fCv1Gm1VlrEJi0JXdrCo4F/dxHa0oiryB6BKg6qG6RhRByB2GBe8soQ6T9WTSBBhAEpx
         /km4zq79z/JZzoOwlXnuE96+WQ4YEIyXsT3N3Ga8355f2iYoVyy+aZiNeUCRk/c2BIPB
         Q42A==
X-Forwarded-Encrypted: i=1; AFNElJ+SHOI/mKEyfcHo498PJZ5lzODkcfJRIUDqvpYmRIikPKKQLdvRbv3LvtoXbHMemvtwG5jkYvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOKVibWSvuTPCPuSG9f7Qne4CPbf+DhxSDBV3UzKxA8kJ2fU6
	w1V/FCBCkXEZpt09O2i7an8+cmySBYR7lRC6wXGsju+8HGfodvGTUYwy
X-Gm-Gg: Acq92OGFdNCXCmYNY5pDOM1kje5eg7sXC6BJ+45zb29Iz4UV9SNbFmqFp4YlNXovcXv
	9VrGpV6X1zVjq8zDonFzJSfJg/GXDmTYhbics52BOndEhtgQ+u9mQg7aoUQX8432m9HhW+DRrcv
	7x5zJOlDzTfrK5HE6WjHjRJm9N17zqObX3/vYKpWDs/WARMr/oYIEprDl9AxcyfkF9hoHzrKyjh
	urvPW2H005+qTbQJa+kMTvTJru1UwuDxaU3B4SVhd2scMBGOIii/Hv0Ws8xgnQHJSv7u6+FPQat
	VWtvWsTMF57h1hE1pLynCrU3HkPzwwigBRvuX0jUyOz3sKx+nr/695inwbTV/M8BlhBs95Gfymw
	ZmgB0DwYKRTniQv0zpzywoLucvmtInR7zSotFL7BXJPK/V5WcXYAc8RkyJ5xFlgRea7mb6w5ZSE
	pk2reZNWrKqLl7MPFS3vaJYeJpJLa39kR/Qzcp7Fq+/YRY9w1eowlTlRxjta7U1jJWnDibYo7o
X-Received: by 2002:a05:6a00:b45:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-84284e3668fmr4088859b3a.2.1780503705270;
        Wed, 03 Jun 2026 09:21:45 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc3dsm3505602b3a.1.2026.06.03.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:21:44 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
Date: Wed,  3 Jun 2026 16:21:10 +0000
Message-ID: <20260603162120.694986-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
References: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the UDP receive path skb->dev is repurposed as dev_scratch (the
truesize/state cache set by udp_set_dev_scratch()), through the
union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.

When a UDP socket is in a sockmap, sk_data_ready is
sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
(sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
bpf_skc_lookup_tcp), bpf_skc_lookup() does:

	if (skb->dev)
		caller_net = dev_net(skb->dev);

skb->dev still holds the dev_scratch value (a non-NULL integer), so dev_net()
dereferences it as a struct net_device * and the kernel takes a general
protection fault on a non-canonical address in softirq:

  Oops: general protection fault, probably for non-canonical address 0x1010000800004a0
  CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREEMPT(full)
  RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
  RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
  Call Trace:
   <IRQ>
   bpf_prog_4675cb904b7071f8+0x12e/0x14e
   bpf_prog_run_pin_on_cpu+0xc6/0x1f0
   sk_psock_verdict_recv+0x1ba/0x350
   udp_read_skb+0x31a/0x370
   sk_psock_verdict_data_ready+0x2e3/0x600
   __udp_enqueue_schedule_skb+0x4c8/0x650
   udpv6_queue_rcv_one_skb+0x3ec/0x740
   udp6_unicast_rcv_skb+0x11d/0x140
   ip6_protocol_deliver_rcu+0x61e/0x950
   ip6_input_finish+0xa9/0x150
   NF_HOOK+0x286/0x2f0
   ip6_input+0x117/0x220
   NF_HOOK+0x286/0x2f0
   __netif_receive_skb+0x85/0x200
   process_backlog+0x374/0x9a0
   __napi_poll+0x4f/0x1c0
   net_rx_action+0x3b0/0x770
   handle_softirqs+0x15a/0x460
   do_softirq+0x57/0x80
   </IRQ>

The rmem charge that dev_scratch accounted for is released by skb_recv_udp() on
dequeue, just above, so the scratch is dead by the time recv_actor() runs. Clear
skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
skb_set_owner_sk_safe() set just above.

Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - add blank lines around the added codes (Olek)
 - use generic block comment style (Olek)
 - Cc: stable

 net/ipv4/udp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..70f6cbd4ef73 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2011,6 +2011,14 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+
+	/*
+	 * skb->dev still aliases the UDP rx dev_scratch (its charge was freed
+	 * on dequeue above); a sockmap verdict program may deref it via
+	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
+	 */
+	skb->dev = NULL;
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.43.0

