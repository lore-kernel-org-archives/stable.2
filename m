Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387644F565;
	Wed, 14 Oct 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967020; cv=none; b=dcuhyM4iJP3t/X5mC6s+R3Zeygrmwu9hT2mZr5Pgz4cYQGiTgQ/M95Hx+z889cYYXi4T0KLKXa8huVLUIsx3T8AQMaOFqs3MHk9x2hcMtXkTcBlYXGMOm5Xg1m0Le6rX/qDR1PeDu2Q4QZfYpR1r5wGWbZcHrc3eDrIxGY60rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967020; c=relaxed/simple;
	bh=+o9xEmQIxcgnU5m6Q21jiKL8m9Q/GnkQDPTQq4P9giM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXeuuF3G8NBpB2c4XzEocvXFDglKl3wwLEk13C+P3L4UromygoXJ8uYF5EWiA2nq3lJqoXG6w4oqX+IeK7tjbzeSN/8syx0ZYOR7jTnaDAog9nWPEXyes0U1lmCwQ5cAAoCbJGrDaJzgDiFg6eI0FNSj5GpBCpkQzKXV2nFJqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=JnDUoDPa; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="JnDUoDPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791967011;
	bh=+o9xEmQIxcgnU5m6Q21jiKL8m9Q/GnkQDPTQq4P9giM=;
	h=From:To:Cc:Subject:Date:From;
	b=JnDUoDPabfYof7XKcmxTcw7ZgqeTqYXSYXwRqA/epkaXHV1dlGPwa8npgHv8HWy3k
	 FDvGsizqGC0v3ehG5z8G+iqEGsUvApWT70vfBTbYwv8z3Hu8AjcAypGTClZeZ1Tke1
	 AV0q6LRVxxgVi95AdAHS+wHwywkss30L59hw0hvfcwAB3AqKyfaT+gDan04QjEsNYW
	 Xy0+ZGZLnxA6n3vqk+H/uopHXLPHFoeUq+g/dmLGv3ZFJvKmBTMY5BgVNJV+qjKjuc
	 FjvvE4yfX1sqGcYSXREgfVxcipvkoG10d9cRE5E/nP3tyU0pRNSiBCRKf0Salg/3Uh
	 TouyQfwpwc2HA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 225EF253AB;
	Wed, 14 Oct 2026 11:36:51 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Wed, 14 Oct 2026 11:36:48 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.48.143])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j4PMK1VttzByl;
	Wed, 14 Oct 2026 11:22:21 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	AutonomousCodeSecurity@microsoft.com
Subject: [PATCH 5.10/5.15] tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()
Date: Wed, 14 Oct 2026 11:18:11 +0300
Message-ID: <20261014081815.368-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/14 07:29:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206660 [Oct 14 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/14 05:30:00 #28682895
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/14 07:29:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Cen Zhang (Microsoft) <blbllhy@gmail.com>

commit 47f42ff521b4eeb46e82f9a46a4783a99f7570d7 upstream.

In tipc_recvmsg(), the copy length is computed as:

  copy = min_t(int, dlen - offset, buflen);

buflen is size_t but min_t(int, ...) casts it to int. When buflen
exceeds INT_MAX (e.g. 0xFFFFFFFF via io_uring provided buffers), it
wraps negative, wins the comparison, and the negative copy length
propagates to simple_copy_to_iter() where int-to-size_t promotion
makes it SIZE_MAX, triggering a WARN_ON. tipc_recvstream() has the
same pattern.

  Kernel panic - not syncing: kernel: panic_on_warn set ...
  RIP: 0010:simple_copy_to_iter+0x9e/0xd0 (net/core/datagram.c:521)
  Call Trace:
   __skb_datagram_iter+0x123/0x8b0 (net/core/datagram.c:402)
   skb_copy_datagram_iter+0x77/0x1a0 (net/core/datagram.c:534)
   tipc_recvmsg+0x3d7/0xe80 (net/tipc/socket.c:1934)
   io_recvmsg+0x47e/0xda0

Fix by changing min_t(int, ...) to min_t(size_t, ...) in both
functions. The result is always <= (dlen - offset), which is bounded
by TIPC maximum message size (0x1ffff bytes), so the implicit
narrowing on assignment to int copy is always safe.

Fixes: e9f8b10101c6 ("tipc: refactor function tipc_sk_recvmsg()")
Fixes: ec8a09fbbeff ("tipc: refactor function tipc_sk_recv_stream()")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20260720214103.47732-1-blbllhy@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-68289
 net/tipc/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 19ec8cf45e03..33f3ca59903f 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1938,7 +1938,7 @@ static int tipc_recvmsg(struct socket *sock, struct msghdr *m,
 	if (likely(!err)) {
 		int offset = skb_cb->bytes_read;
 
-		copy = min_t(int, dlen - offset, buflen);
+		copy = min_t(size_t, dlen - offset, buflen);
 		rc = skb_copy_datagram_msg(skb, hlen + offset, m, copy);
 		if (unlikely(rc))
 			goto exit;
@@ -2069,7 +2069,7 @@ static int tipc_recvstream(struct socket *sock, struct msghdr *m,
 		/* Copy data if msg ok, otherwise return error/partial data */
 		if (likely(!err)) {
 			offset = skb_cb->bytes_read;
-			copy = min_t(int, dlen - offset, buflen - copied);
+			copy = min_t(size_t, dlen - offset, buflen - copied);
 			rc = skb_copy_datagram_msg(skb, hlen + offset, m, copy);
 			if (unlikely(rc))
 				break;
-- 
2.43.0

