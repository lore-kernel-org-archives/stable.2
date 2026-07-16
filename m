Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42938D414;
	Thu, 16 Jul 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235317; cv=none; b=lU9ROSma+SYqDeQ2FIJn2nLXxQImZIBn0bhpw0Y5Z7LrdgG27W6kir475yzGjfHjBYkHy8Mee0tuimRrhafsgILqzQ0gkTqwauBFU29/C5lO29jgQDhr9Eg1m3yLp5drQwrWHFjh9tmh1H3Q8ykQ4/d0SFjqb7JHX3RaDzbtUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235317; c=relaxed/simple;
	bh=/jYjeSXcOT3X5lsTrlA4VeJ2bkToZrgAD9L5OpajHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmvw5EtLIC9ZSI013uDEhHRlnTQZaxufQnUte3tvGvbTPuIqg9oJXes8fVzl3oZqkfFyUU9cvP0YZK7p0WEUvyXluZX0vC9gTqMv+q/7p/DDs0xDCwvxMUr8mBIYe0QieUF19Qf4sRh5dVfDb4GRQ9gBL0lmkihz6ZxbNqOy9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LappT5Ev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKpaO5xr; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LappT5Ev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKpaO5xr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B9FA1D000D4;
	Thu, 16 Jul 2026 16:55:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 16:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1784235312; x=1784321712; bh=OYy1tfJZXR
	2TVEr/O4x4hI/z5S9nXSQdWXW3Zvav3OE=; b=LappT5Evn5BiYjBdwTkRCj55Ww
	/UAwuAZkARNs3X+42FnBKa0bVXP4Z6tFOzMWCIaiz/D4pIRQP1DsqN++uGnYB6ps
	fTjY+mSYvpDvHcPHp6EUleosFRFOMGM6Oh+ymM2fAGaWp3t9pYBRw8gjnW95csT0
	/882UB3NTI113430X32JbbibXV1UMhvgOG7zTsIW+WQKbGvMB3it6X7+GzLlTIm+
	YFt6a/m0WdYNLzs6wUZZQDU683J9JeuZhNVBuPJeCMXV1uwULSa5Q1bi52Smz5tn
	JCbM6pxP20Msyq0paDKggKStDq2KV2YDq6Zj/qLPEdNVXehzsmzQsjqKYe9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784235312; x=1784321712; bh=OYy1tfJZXR2TVEr/O4x4hI/z5S9nXSQdWXW
	3Zvav3OE=; b=SKpaO5xrkvpvO+ahYfahkuR8q/8HL/b66VH8TfNoty9c0P4CIo+
	ug8tHs62GgCsOZ55JxAZj60OpZ+RaoaJKsoGxg2xvx875AJZOwitvj3Q/kRTOdp4
	+JyGNzHNlT7qqo5yNHk5kz/eyBCnBTgBQub1efcU9qT9rrRRXQkoNsRzVT0LkY1o
	1lob/M+Y1tp5b7hr7NtDn4sjAMt002LA1+Nwv+cXnCAWNqeD/b7gfHGdcJfADaTP
	LnHW5sy7e4hCiQ+hGy5PzyjdDTqiSwfXikJM49h6c77EDRQv9CT78603E2GQMKtT
	FIN35g1Yk/RVh7dWpL/m8DC0pJdtj0JY0+w==
X-ME-Sender: <xms:LkVZatnSGPXHgOtP5mGZRJwVYo4BLTf0DvFQcLVeP6JdQWOoR9GGkw>
    <xme:LkVZan63dcXku7U8P6n9z4Sg_vguurKKQZfAzIGapbHmMYEdenVt169v24ybVEGzF
    8HckIOC4xxCURyn2mGdwHP7CRm6Ash19n3MW64cNncRQN5yTYrJrqs>
X-ME-Received: <xmr:LkVZap0Sr9Xw7B4T9ZCzb42uyxr27U722QwDpAG8IFCEVy4y4onDZ6fto2kZIHDIYMz5dErpT4bDDKPHAEnsGMgZqsQUTk_z>
X-ME-Proxy-Cause: dmFkZTFnL8Z0ImdM+oE12G/gCpjnnlxANVgwjXf6yX+nI9cmWhvgDHv8JAC5kGzBVRZrmo
    skBj6p+tOUDoxVvdB7lFEaYvL4A7NtsAX4BSTXRBmF/1Cex8moWBM/BkMnHNI/2YDRXf/g
    31dC4YpopPx+WjICE/Eckixxg5PGf8qzZXfMWAUbgxjSfhEDBHtLf4mO1N0M0MPm6C5C0V
    0JODzJzEWlpiK4YjT+GhcX1O5C8pTe2OYWqJtwuwNV7eoJdCRo7Ar1kMRN87FnL9M6Ya6Y
    uWjVwRN94miv9DJl2PdB+LSNi413Ef+7acgnia5gR40rGoSALm2OjBeWSnAeZWnK79puEk
    lqqtPVnIERQdl9fhODqBSkSm7Q50ZU9LLJUuUST4AvBmYgj4WqhOSWyq5hfyPWZOeNn6ff
    xUcBgIxsjxnubmkQR8YHSr4COOXzBSGO6yfoTN7QE8UnLtwWiQjgDKJAF+FfQeUkkMW+Wz
    rmhMmylm2x/5rLfcl7tPgGRcX056PWwSVdG1iEEudOHe0XKINh3JRSmugrgWkKDrd2SNkm
    8Z2J0JKYPYymi6h9UDTiWDhF1v1mcJctEQgz26D41nmCRFKajTiNkULYQ0H/56/tACMwec
    p+FeDvD5uXF5H1/oJcIezLGqtE1xOvxO3CtIIn9nQkzpN2eqphoUfIvv5u7A
X-ME-Proxy: <xmx:LkVZaqEY6QmrUqdu2_N5oWDkzLy3XovlYGX5vG2joBrKQ5F82g18DQ>
    <xmx:LkVZagixCh_iTkV180UBweeqDUBUyZ__730Ng2QN_7mvfViD9mqViA>
    <xmx:LkVZalCOstYraig59tv5Igdif5_2qHGJO_niOQH9_d-c4bUftpn_YQ>
    <xmx:LkVZaqTIZepf3DcJiRsfeGeJNZamy80oX8Dlar5LA4ISXU8CjsS5XQ>
    <xmx:MEVZauy1BayoYwFnjVNb9Lvf0zGSl4nC6118WTAfGzRBjv37b9CGzIau>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:55:09 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Breno Leitao <leitao@debian.org>,
	stable@vger.kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH v2 ipsec] xfrm: espintcp: fix UAF during close
Date: Thu, 16 Jul 2026 22:54:59 +0200
Message-ID: <a62857f72af228a0781a5c0cc0f8d898d9e0d7be.1784234935.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZDI reported and analyzed a race condition during close for espintcp
sockets:

    espintcp_close() frees emsg->skb via kfree_skb() without holding
    any socket lock. Concurrently, the xfrm_trans_reinject work queue
    invokes esp_output_tcp_finish() -> espintcp_push_skb() ->
    espintcp_push_msgs() -> skb_send_sock_locked(), which reads the
    same skb as a data source.

Fix this by adding a synchronize_rcu() call after resetting sk_prot,
since esp_output_tcp_finish() runs under RCU and won't use a socket
with sk_prot == &tcp_prot.  Simply taking the socket lock in
espintcp_close() could lead to leaks, if esp_output_tcp_finish()
re-adds an skb in the slot we just freed. After this, the existing
barrier() is no longer needed.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v2: remove the unnecessary barrier()
v1: https://lore.kernel.org/netdev/50e2ab4348eb8177581058f0152394cfae6a8d27.1783071494.git.sd@queasysnail.net/

 net/xfrm/espintcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..cd817b855ba1 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -515,7 +515,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	strp_stop(&ctx->strp);
 
 	sk->sk_prot = &tcp_prot;
-	barrier();
+
+	synchronize_rcu();
 
 	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
-- 
2.54.0

