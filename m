Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230530;
	b=tqZXB7zE4+hqmS7PWk8JAzupXNZv+Nz6TrnwlVPQLCfx98t71gFROg8tQN5HtCAazRSy
	 RIRlRhs5pTWUZx3H+nGV4lNBwthgNz8ZHJfaUxWbrG8aJENIvBAGdKUdKhfQJk57EQ3K8
	 hjoHT9WBqtZbUAg0I+jqCg3OajcqwRUhBoCpbM3SO4x+GWkk9dOx9kMa92uvnIFJWHExh
	 z7e6xMXjypL0QSAJL+xY9NpyDoUPor661+02yliurlG44TcPaQ9o1HRLC5k3teSYF4S/9
	 gXuAQWsbP1j/UUrHqFi/MquedgziGLdRKcEvyp5fcWjfypmR2hYH8H9Kw2mEC73nCRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
	b=K7pECU7nRZQFiwzSbO+FwsFlE4TXe79vuqMpt9JTIs+4ukXqKetDvVQfYbmcb+sgGzaJ
	 X5XlktL7xL0VvOliYQhTGt7GUJkRhHSLe0SmJFBE2H9N6V+1ZF7xMZsTgQD36nl28zt00
	 +t55KZWSfZ/BROiDbcQOpyQ6USCT7uuLfmhLoEHc8E12U7iG1aqIYZ876ZuNIfxbAWHHz
	 YCabGM759Z9XxArJA6HcC8b64aUVrirWSdBW1ulOpFUCgROiZIBLinIuS7spfRz3/iHko
	 xpHlW9AUtv1i1NpdeaErb9d3fXHMX04eEx+ynrW8OAL44XZNIjrq5Qz+qB8G2jp3vHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ssn/dJ0h";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DFE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ssn/dJ0h
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso276919a12.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230529; x=1794835329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
        b=ssn/dJ0hIDcrWl8YGRCXQ0Oy2oyESWTAeJlYQdSL4pfgeUEik2aB0njapnZkBshcU8
         GDKFf5Jz/hzGT9GHmunRTpkzbi4eKo1tk2GR1U6q9qRTmUyeAEEz90NwSYMO5CU9Mj+j
         HeUt6CGviLhQrstxgXntw9jw3BM1tZl2Ly0uSF4Ua+tSl7fx7hYTyyNKzY7cWWzqal//
         VlNlL3w1h8fgUT0fl+dLKGCOwc/5ZnadDA9SszyVommmFwKcDBeXvlpLBJqjGEmOS41T
         aAQ7E5lCbg4vlT4315aUSUW6B0uQ8XHVhpYKZODYlS8KuPGLueV27EHfw7v8T5LupU4R
         YV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230529; x=1794835329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
        b=cbQedBPee8m9IjcpBgELhbw7ARD5+quU5Zo1rDizXFSjEQdJhhilSaxffZ5AIdfwy6
         SPcb+asdKkqxz+zRIpGE1JpHXyxmOlmbHbO++UpuwXCC+BtG3zThiBlHBVyvhkjZse5P
         A3tOuNE+qyRVwAezG4PcH4AejTYKJl6osAT4KsHBTIFlHxZJtWltbKc4SYsoHbh7nO9X
         E7kpdVV1RrBd0LeW92VBZLWayJaZhKU6u1ZJShFs9zqWr3KLpeDYv8kAl3lVROokIsin
         VVL9mRhhVHA7ZMzLCZZOAq4pN3Ja5dhKhc4mI1qcsWr7VH9kVFfNUP9zgFIUFT/VgaWC
         Au8g==
X-Forwarded-Encrypted: i=1; AL+hErG7HBSS97QCoI+b4AmjoIXJbvC9QDessA4uB9/Iy7Z2wL1OnUC88sp3eMjB3JeHhEsZxuI8oA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8105F2TmIhJW9STENI+6+g2ijgbYbyQI8eBdpqAUWNeB+3U0AR
	8GXnRauJJgB13XdoPjDp0AwiCjUl9j10JZMfQxTRU3lEyMeVq+Twpinn
X-Gm-Gg: AYBFou1gOGbbG0ZBzhwqlfUegS5VX9ycwArFe4gyQ1y1EXUmNlkhFz8g2g/9PRnSDCb
	xwRhoFSriLxqSGu1AKskPcF353DCg6dGIkJotA4FuAzXHE6h4s4LGZhZv2xzuK9/pUhRtdCtxO/
	6S5MvHcInbzAp71X/FN/XhT97lLO4r+2+RMPVzP+3E0+a+TCXafIRGRk3Wo4RJiJWqkTbz/hr0w
	6uFPECzPiriX4sAC+hDmU+t6C2dWQtyxr9PoF7z6O0vGYO1hudRP1rQpvoU0InAfjlJsmuozBqK
	0+gSMcuib7eikPl400vtoW1qIA1f97eDsF07vCt+DTHuVjKqXwf2OzctzIHw0bDhNJM8k9u8EPI
	VKeWmmbt9sL39BedGNQg8kLPgWltcgIlc40/quO8xHa0tOhoesDib3Y5Z8lXy9DzTigZgIQzJmB
	bv09ZzQ+s3MPhTm18k7m5Q061TkwzNywBLMfoeiK+CTOrZouelKynSbHOJMd77AJVFyVR6WiJy8
	0+WEyGGkvXBAeJ/naoSbSPvVgo34Ox77NBBV3HYDrz5xkndwqWUxENNY4hZsQ56K5FDOPuVMxfw
	vkev6VhGB4REkvc+CjWRf4DBU2mnKjdjhh8P4+gkRH5yiS2k6PNjJr5j4JPmoakNBr4p
X-Received: by 2002:a17:90b:3ecc:b0:3ad:43c1:7d41 with SMTP id 98e67ed59e1d1-3b12d37dc87mr3626719a91.33.1794230528418;
        Mon, 09 Nov 2026 05:22:08 -0800 (PST)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881e6bsm11010043a91.7.2026.11.09.05.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 05:22:06 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	security@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel
Date: Mon,  9 Nov 2026 21:21:43 +0800
Message-ID: <20261109132143.94305-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Reading buffered ERTM data after ACL link loss can clear local busy and
send a supervisory frame after l2cap_conn_del() has destroyed the HCI
channel, which oopses on a NULL pointer in hci_send_acl(). The socket still
owns its L2CAP channel, so its lifetime does not protect the underlying HCI
channel.

Require BT_CONNECTED before clearing local busy in recvmsg. The socket lock
already held here serializes this check and send with teardown, which
closes the socket before the HCI channel is destroyed. Continue to allow
buffered data to be read after disconnection.

AI assistance was used.

Fixes: 61aa4f5b9f43 ("Bluetooth: Use the transmit state machine for busy state changes")
Cc: stable@vger.kernel.org # needs adjustments for 5.15
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1 GCC/Clang, sparse or smatch warnings.

In QEMU/vhci with KASAN, the base kernel faulted in hci_send_acl() during
busy-clear after the link was dropped, in two boots; the patched kernel ran
31 rounds that reached that state (RNR sent, slow reads, link loss) without
a report.

 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..e5c15c083c1a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1332,7 +1332,8 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	if (sk->sk_state == BT_CONNECTED &&
+	    test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.56.0

