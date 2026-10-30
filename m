Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330782;
	b=4QdHUDprjA0vX9HROFx+hLVyE0w/OBzk5NIRES08LIMsSpLQzGrzc4iTqJcMw8ojvH6G
	 0LqiZCO0T5d0eAdzLWs+pCUEC5Q1lWvdvXoM3Z+uYLgRuvSy6lNeYBwYeEj8dDntVoT04
	 Jk0My9sN2v1XECdMBJM8Q+CwFgq18Amg58MmCziqplttYR87NNVxGhmc2xpjEzySMxKK7
	 3g2Xs2g/sHQZ3a0yWi/Tk7K3xse7chaqOWlsmviVhNNfM5joWXIHXKrGXkCHXGBiCOPEb
	 9JfY7G0gzGxb1ZU8QAoMGPPaNl+x26eo7HUgcObA1CzKVfzl5gKP777CEIA8abjVtxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
	b=rAFActVHQ3khaHvRNkZLVuy8r6Vl1n43XifLSRjiwoe42hqJCWIqt4TJD7Y44sKYn7EA
	 oRv/Pf7cuNh/gcG1vmLEr0IuMwQbZr8CsMHo6ikPtLh8QM/gc6fecgxjqE/NWNAt8qNQC
	 NTMAy3uKZxwvg2QnJA+aVeRoG0N6hY8WzuJ/R2cm9Sa2evOvuvwdEaMB8iWg8/cmGjDkh
	 z5VIrHy25bKtW1N8c/KfURHGQ/qUP3vt08kxdGkEAPn14BjItJY1ptJx7brMe7Kn0FtJg
	 CqiXSbw7kplTVS2odz67QIwdZ8j3c3FpA6RQTDwu+IMEd9IZE2x4RWqcVAEcoG7y1hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cvziuYvO;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2D606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAC2D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cvziuYvO
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533861a59b8so2829191cf.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793330781; x=1793935581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
        b=cvziuYvOVzFZocDxF+ucfhtYbfLsWTaXChkz3r6vlmZ6/7GMz4SXolSLq3chMpwqfr
         R6IsQYrNGpb5cjr7F8LnSVgSapPZCK1S0d/WsePhsWkrxpFU0fydNG7qvL1fwmbtwXjd
         pK98kpt7dN6w2n4q4E56rDGZ5yU9HJAcmWl+hjjRSJccZkSOe76GDbWf6G1dPs85y7PD
         Sgp3V1ZemkhjA8hpQQ/lkz4s0ckSgeZZ5TGK2e/BDWi7Q59kjk8rgQr5ryQMURVUJ6o2
         Dyl5/c+w1p955BNE5H+nXA57po6+hzGKd7NhqQ2f8PC6zUTwicswoX0eqb7LbIYJg0Ek
         rRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330781; x=1793935581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
        b=Mieu1x6VSWsXbv/iTy/iGVfcX+qJpFVP5Y5vmxgrY1cQYffB7e1nkyfDwL+sgglDxE
         K2Jvs21URekLTVMwNtdyKVcI8lZ1CUTq0NrkBX7mnfbU+ES6/rneQHFig3qqjVREq9t6
         xDLYUi4sTfpvSlCl5xSdCZ6y/9InO39Y4l0DEeraNgovkLmkfxoV9Q4c0RtLyjaSGrr8
         aGRAfiFnz2hPIGWW0tmP9Qk2dE1yj9PRYYpfxeLjPm1MSzadRJYV/yMXTxmefvLp2m6U
         LTws1PUgVI8JH30JMdGXUCq3LZcvIr4obTGJxyEGQdH6nH/Lk2yxVOP4hpH5C7bRffgl
         CUMg==
X-Forwarded-Encrypted: i=1; AKwUvBzZVeeFs4BKdJCBG/piRzDN/rerQ+s82CaqIYyru0n/tmIqJDTJeJtaFu0iV0WmEpRORt0y1tY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBP9kfsvBpi7vtaDeEypzgoV/1nSsQyW3dWUZ9ENMUlXAxIJq0
	DPH+BTFaRPhxYqoFtPml7TqdMPioCCgXlGNf7SXSeXoj8IT8thMeSmXBoN+IB/sA1w==
X-Gm-Gg: AYBFou2v6ajd3G4rcIDgzcaX7ZqCZqRCz/eWU2f2K9NcDW9RfHHAFAG9oP3hFAvAVu3
	pPFua0vZFjXaQiKQoKO7ddi17XK5SYA+9iqBgK4fJFseZU38LrhAtDdwhOONvRWWRKKhH6wXX0L
	16lG2RxPkM+wQzGgs/0umzR+IsPQeraxSD6IiRgDSaJMMjZYAZ0GXBCBJxhxTr9g7rGOyfa1ngX
	5XkOXma9krewk+12Glos3iMKELwQfSOZiuStP0V1a83zmV/eUPDHNCnu+zgzuXiCJEaXCsFwKTa
	DCngHi9RolaaT06uIeUu5iPcvD/auUKAQA04OMY8hiGzqDa7mtMTWpJrCL//Z+E6yHeDd0XyQE7
	LoXOJ39SP/tONd2y4umIXR1Pg7VNhEER89QBCnqjut6r0I3dyII6pWZHC9HMRfwfjiLzfMxP/wk
	msm/ZSb37gPI4cmkM4jcFsSUTnSRRZojdf6d/sb9eW4w2kZIfeeDYTcTPxAl4jrZNoulF9G62Sw
	dyZOWQ95bxFd52eQ6aTlREBkiM+9wuF7b1RHd4bIHKNBEzET+UbWBMAF4t538K89ieqkbUwAO/v
	rBurAZXa1SYzPntgUc0LthbvU1igl8TSi4uajtP2MyptCDvjrb6k
X-Received: by 2002:ac8:6f12:0:b0:51c:fc4:a144 with SMTP id d75a77b69052e-542b405957emr16806811cf.4.1793330780610;
        Thu, 29 Oct 2026 20:26:20 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca804dc9fsm4001476d6.24.2026.10.29.20.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:26:20 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com,
	gnault@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Thu, 29 Oct 2026 23:26:17 -0400
Message-ID: <20261030032617.4065353-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
pppol2tp_connect() and the netlink session commands find sessions with
l2tp_session_get(), passing the socket of the tunnel they name.

L2TPv3 session IDs are unique per network namespace, except that
sessions carried over UDP are only unique per UDP socket, the socket of
their tunnel. However, l2tp_v3_session_get() only checks the socket when
another session has the same session ID. Otherwise it returns the
session, whichever tunnel it belongs to. As of now, a session command
that names the wrong tunnel acts on a session of another tunnel, and a
PPPoL2TP socket for a second L2TPv3 tunnel fails with EEXIST, because it
finds session 0 of the first tunnel.

The issue can be reproduced with:

    ip l2tp add tunnel tunnel_id 3 peer_tunnel_id 3 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5003 udp_dport 6003
    ip l2tp add tunnel tunnel_id 4 peer_tunnel_id 4 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5004 udp_dport 6004
    ip l2tp add session tunnel_id 3 session_id 7 peer_session_id 7
    ip l2tp del session tunnel_id 4 session_id 7
    ip l2tp show session

Before that commit, the delete fails with "No such device", and session
7 of tunnel 3 is still listed. After that commit, the delete succeeds,
and session 7 of tunnel 3 is gone.

This patch will make l2tp_session_get() return NULL when the L2TPv3
session it finds does not belong to the given socket. The receive path
calls l2tp_v3_session_get() directly and is not changed.

Fixes: 5f77c18ea556 ("l2tp: use IDR for all session lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Compare the session's tunnel socket with sk instead of the tunnel ID
  (Guillaume).
- Describe session IDs as unique per netns, and per UDP socket for UDP
  encap, in the commit message.
- v1: https://lore.kernel.org/netdev/20261025145831.2133617-1-hengyul@cs.unc.edu/

Tested with the commands above, the same session ID in two UDP tunnels
(still allowed) and in two IP tunnels (still refused), and two PPPoL2TP
tunnel sockets.

 net/l2tp/l2tp_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7e042a3e648c..0cd3e38bf662 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -315,10 +315,19 @@ EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
 struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
 				      u32 tunnel_id, u32 session_id)
 {
+	struct l2tp_session *session;
+
 	if (pver == L2TP_HDR_VER_2)
 		return l2tp_v2_session_get(net, tunnel_id, session_id);
-	else
-		return l2tp_v3_session_get(net, sk, session_id);
+
+	/* l2tp_v3_session_get() doesn't check sk if the ID hasn't collided */
+	session = l2tp_v3_session_get(net, sk, session_id);
+	if (session && session->tunnel->sock != sk) {
+		l2tp_session_put(session);
+		return NULL;
+	}
+
+	return session;
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get);
 

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.53.0

