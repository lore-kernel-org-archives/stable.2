Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575461;
	b=l0WucuH6eHr8GidDqgTQgVTItCU7jkwJ5zfwcgaOXNDiJJMdgQN3sHJRvDel67mhOEnk
	 rad+8Wxzbgjm3Kl/xxx1WRRk7qzYMzhrDekloCS/4YVnQKmDz6vLs+FJJrhAmRAL9s+eq
	 mh1FJRQGaKS9Cc2e/yaLx4/4Kd4XVWM/K55Ad4qAFK7ZFyYp56fSZE+YowcYDOQMjDzOb
	 SDhZKvnM65sEaKMWPALBOdyVj5L0gjBZC4RV+bFPeckvIfltl8zEHIPxg7Ru2OqbYLze5
	 cNiaipOT5EzpiKwLQto2pz4BilhtYGLs98ZSuEm+Y1y9Oog0giWBhtOcolk3wWAiabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SwOZibvAccnxBelZH8y949wCLqVF2LXLaAyvhlz6UsE=;
	b=LlKyeiZXRY35mhmh2IvWYK7ta5Zxr8cSTTo6//4ptHmCFK8RrTHA+C8kT6Z0koZBPbPs
	 RwIwhaEvIp3AntCnhFuHeQWrEsU4r+9Y/sbQ2lFDlRs3RenIF44LMiJvCzmg4FqYwXQe0
	 lc8Mg9P7/UiJ38a1YzciL+vaKKkj7oKGCk78nxEBSDBa5N8XgYMY1T0TSzYZfVYQiC0LF
	 CWuzJOo80lj379RwOqF3SBsJ4Cad7HLOcXiUEd6qckJEbCZLqW++pY0yqTGRoUpqZGXJS
	 4l5vjjdl4IGMtTWfde6kG6RxWNq+tYy/C5ksoIWEjlQB1NwQWy7Jtn6Y0qlWtbibMGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9pck++a;
	arc=none smtp.remote-ip=209.85.210.67
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC4606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48DC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9pck++a
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-862df509d48so4108005a34.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575460; x=1796180260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SwOZibvAccnxBelZH8y949wCLqVF2LXLaAyvhlz6UsE=;
        b=t9pck++a1w4bc/mxi1Z84pgYZwdNd2gw5rXSY2Hazzt7fsd+ONy4xJDVFKnCck73AG
         eCppw7T6xcbzrFCuZuWPv6wC7/yrV8wRUazl8ni2x+qAEggMepFHaN+g2r7NFooWDBkZ
         x9WeLHk+l584mjuO1qtOb6krBqkc7eJz4Avi1ll/lq6RwyWSC05vCKW1kTYWenhuQ+UC
         7bnKodMtl96aMJjYt+FFRX4AqbgqLg153LtCC+WvWtKozQ0CfNqDTDQ2ivpPKd9aZpSe
         JUT8JIuE16PeTKA2FaUZEVE9baLGvRUdTMQBfZcZRYPS0txuzYjcsib1ALlX80oFJ+vE
         /2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575460; x=1796180260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwOZibvAccnxBelZH8y949wCLqVF2LXLaAyvhlz6UsE=;
        b=xw7tq4pD+N/CXTco1eTR1+8c3ebS28lwP2q8JAqZcAHvhOwR2fwPLcOzUKDgMHdKOs
         24b0B/3XDx3bBVwM017S24blGCEJbETCRbYAtgQD1kRcJxNS7koY1AEq1S1cRDDZVV5D
         1381ECo1lBbBTIFHitdaINLQcWutfks3JSsC0lz7tOnYl4kCDZEo068zktSeebloABNo
         0xSEGckYCPPP2ghIS3HoaPDYMvo7JKAI/+c8swQ7h8bRjZgoDWU5RLIUbRUnMGZavLt3
         hfS/al7etGni4459eKWRQzbuG+BYnk4+cxfTSaQRUoS4md6tnRyDJJEuM9odat5D9nti
         uOWg==
X-Forwarded-Encrypted: i=1; AL+hErEWM6MvsJv7gKTPRYf1au8GZHBm7ND/v6qpIzulP5iBYk6KYsX+Hx2f8hzZLR5jU4fRupnR83w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yPZe3f7pN7heEVVdxfmaRiOkqw/Tyj5ErvW4Qe2924QbCJ01B
	1iXDYGuPa8bcxuR41RjwdgzzOJKWT+BhoYzmqKJvohFk9ocEEjmKzU82
X-Gm-Gg: AZFdTZdwfJ+6BCcuytyTCbsk0yJ7uCCW77KcaqmtjjFoSrXRtagqZmVPAva9Y436DTU
	LDNcKZZlveS837G+Mu1GHxsO5l5+UKnzDwHJjUjQLWNIalZge8Wm7F1DFbHSP7B/k4J4/w+D5lU
	458rhAfyFXS9JMWDw3CA1MVjlMuKvg8M2cuywVoZBIYvDAqT03bPz2J4EzGOuxLccRC2/5NLgeO
	0KVbujRVPvwVySFMQj/1v9D05vEpPUSIN+qjbAAhHGHJiOWjMRkTHOY1oE1eRJQshS0vPtDCkDC
	laHxBPcerkD854lx005eZ+TaljBNY1xFohgZlepTUcniDdoJEikTnKewPwgubyRIXPgjyjXFdgJ
	cA+ZIttuMCkvYefETKcV7JOV1fUv9MsdlkETWgFUHmdetg3pdSG4lhED/HI2HJ8UC1Q/xmxVdbG
	ZHnNjxYxGXQE9TK8N03umsfnOIpzDh6dU67VNsPgQkOkwp9SO8TMCWhb9k+QgOoiR+CYtkkemhn
	LFtk3zpwfEI3834FtG7coSgO9dmQwYUqO/Y6mlBN0hSEM7PnfHNhJy1BBE2nzkyJv0OxqIl5Zve
	i+q7qJ8GFxA8IIvnMFU465otKomSE58/q3wVjs6JgxMR2v8yGY5m5NX2LzgvR+tOmid1
X-Received: by 2002:a05:6830:640d:b0:862:c21e:4f75 with SMTP id 46e09a7af769-863091e1e95mr13456344a34.15.1795575460166;
        Tue, 24 Nov 2026 18:57:40 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86322db2d1asm10701384a34.4.2026.11.24.18.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:57:38 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@kernel.org,
	horms@kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nfc v2] nfc: llcp: walk the accept queue under the socket lock
Date: Wed, 25 Nov 2026 10:57:30 +0800
Message-ID: <20261125025730.383142-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

llcp_accept_poll() walks parent->accept_queue and reads each child's
sk_state without holding the socket lock.  nfc_llcp_accept_dequeue()
unlinks closed children and drops their creation reference under that
lock, and the last sock_put() frees the child.

A poll() racing with accept() therefore reads a freed child:

  BUG: KASAN: slab-use-after-free in llcp_sock_poll+0x440/0x4e0
  Read of size 1 at addr ffff888112387812 by task poc.bin/528
  Allocated by task 198:
   nfc_llcp_sock_alloc
   nfc_llcp_rx_skb
  Freed by task 529:
   __sk_destruct
   nfc_llcp_accept_dequeue

Take the listener lock around the accept queue walk.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v1 was posted to netdev without a target prefix; netdev does not take
nfc patches, so repost to the nfc tree as [PATCH nfc].  No code change.

v1: https://lore.kernel.org/netdev/20261118083811.1721010-1-bsdhenrymartin@gmail.com/

 net/nfc/llcp_sock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde68..3503f1a7a7cc 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -584,8 +584,16 @@ static __poll_t llcp_sock_poll(struct file *file, struct socket *sock,
 
 	sock_poll_wait(file, sock, wait);
 
-	if (sk->sk_state == LLCP_LISTEN)
-		return llcp_accept_poll(sk);
+	if (sk->sk_state == LLCP_LISTEN) {
+		/* nfc_llcp_accept_dequeue() unlinks and frees closed children
+		 * under the listener lock, so the queue can only be walked
+		 * with that lock held.
+		 */
+		lock_sock(sk);
+		mask = llcp_accept_poll(sk);
+		release_sock(sk);
+		return mask;
+	}
 
 	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
-- 
2.43.7

