Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838F3C1973;
	Mon, 20 Jul 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579280; cv=pass; b=dTi8kPiwmV1Axk3wN6knChNLdz0R1N2ienq/KGsTqxE2lBr3tFqkfLn0XCRC2bSdFZGwM4Q2r7r4Nk+vZLKHrSVf9e2kw8VTZZ0H+qrCVumrTiwwGZpLIqXub/MFjc/mQY+mmspNhk369qC+8ck3L40gA2Uk4Xy5FxhjhrzSH4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579280; c=relaxed/simple;
	bh=0+P1VGSY+hJP7Pymn9l/OEI+Oj8haz7ONn+t4lUYDkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFe2rANGXMPFAqdXQbh7EurEEwycBK57+tqQFuwJGrVHMN7tNz0X6Ygmk62a4gUl9O+V9HHlLqaGUYkIf2NB0wpPHizoDXJVjF+s/G44X/Uat5u/vuYt7AsZagn4YEQFepOSqG7dAiM2Ta7L5HtOoz73Bpg+cwKQz4ufDnl61h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=sI9QGdNR; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="sI9QGdNR"
ARC-Seal: i=1; a=rsa-sha256; t=1784579244; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OxOyDSwmjZBcu0pyWLgdBTBwgyDPgrbUxzLoMFPfhil8H0D5vEjBHOsJbyJ+n+DuGTkttv0922/AgMbNJ3Yiygm3UI+1/gyppfGMHtiNbLmBPX21+vIH3dgrWkdFN6C6gQ879dLx9qrvgMk7XNDzpuSQfHV/K6G3sdFwQjVWFGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784579244; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zG85u2vJ0C015HdBuDt5gobU84Sb4xZS4i1DwuUb5PA=; 
	b=UPnhxv2StD413/s64JKl6oAm+GOttlRjhoZzTUPatGMqIAO1fyz4p19srTg4TMKuMlXOSUyDfHXzGZHPLZmk6BEHcCagvBEG1S9hYftrBHVPwY5j4r7xr4DbjmnAmUt1VSZjGLeZxzXwsKaH+6PyDf275huHQG3Ahep62BnNtF8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784579244;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zG85u2vJ0C015HdBuDt5gobU84Sb4xZS4i1DwuUb5PA=;
	b=sI9QGdNRgj2NSilQAcnorl4xNxb8VP6z1seLJR416tRi6f0lmYpzdrbnwMAUI3Rr
	U7M2bRaOhco2loIMDrO4qaxOfSU17dnjEZ8XkSRj9xTKJUWX2QNw6DelBpzj18hxLu/
	qcvDNJnKp1iyTbTmpHy8Qua3V33CU2aa6XGRBjMQ=
Received: by mx.zoho.eu with SMTPS id 1784579241321949.2792150117403;
	Mon, 20 Jul 2026 22:27:21 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linma@zju.edu.cn,
	duoming@zju.edu.cn,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: x25: fix use-after-free in x25_kill_by_neigh()
Date: Mon, 20 Jul 2026 22:27:18 +0200
Message-ID: <20260720202718.13934-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

x25_kill_by_neigh() walks x25_list under x25_list_lock and, for each
socket whose neighbour matches the one going down, drops the list lock,
calls lock_sock()/x25_disconnect()/release_sock() on the socket
(x25_disconnect() can sleep and must not be called with a bh-disabled
spinlock held), and then re-acquires x25_list_lock before continuing the
sk_for_each() walk. No reference is taken on the socket before the list
lock is dropped.

A concurrent close() of that same socket runs x25_release() ->
__x25_destroy_socket() -> x25_remove_socket() (unlinks it from x25_list)
-> eventually the final sock_put(), which frees the kmalloc-2k sock
object. If this happens while x25_kill_by_neigh() has dropped
x25_list_lock, both the lock_sock(s) call right after the unlock and,
once x25_list_lock is re-taken, the sk_for_each() walk's implicit read of
s->sk_node.next can dereference the freed socket.

Reproduced on a v6.19 KASAN kernel under -smp 4 with a killer thread
free-running NETDEV_DOWN toggles (driving x25_device_event() ->
x25_kill_by_neigh()) against several threads closing/recreating
neighbour-bound AF_X25 sockets: KASAN slab-use-after-free in
x25_kill_by_neigh()+0xfd/0x110, "Read of size 8" at offset 104 into a
freed kmalloc-2k object -- exactly the sk->sk_node.next field of the
socket concurrently freed by close(). 145 splats fired over roughly
64,400 kill rounds in the racing configuration; a serialized control run
(single kill, sockets closed sequentially, no concurrent free) produced
zero KASAN reports. With this patch applied the same free-running
reproducer no longer triggers the report.

Fix this the same way the rest of net/x25 protects a socket found by
walking x25_list under x25_list_lock (see x25_find_listener() and
__x25_find_socket(), which sock_hold() the socket before dropping the
list lock): take a reference on the socket before dropping x25_list_lock,
and release it with sock_put() once lock_sock() / x25_disconnect() /
release_sock() are done. Since a concurrent x25_remove_socket() can still
unlink the socket from x25_list (and reinitialize its list node) while
the lock is dropped, simply re-acquiring x25_list_lock and resuming the
sk_for_each() walk from the old s is not safe either way, so restart the
scan from the head of x25_list instead of trying to resume it.
x25_disconnect() clears x25_sk(s)->neighbour, so the just-handled socket
will not match nb again and the restarted scan makes forward progress on
each pass.

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 net/x25/af_x25.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..725d35596e3f 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1768,15 +1768,18 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 {
 	struct sock *s;
 
+restart:
 	write_lock_bh(&x25_list_lock);
 
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
 			x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
-			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto restart;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
-- 
2.50.1 (Apple Git-155)

