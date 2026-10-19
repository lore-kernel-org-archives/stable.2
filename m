Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430192;
	b=fuc0QiZUWyaEVvklRGvy8TsSQB/0eIz5r41EKHaBCq9imHoKECuHLJXotzbIvnNn5usA
	 bWh+67xSKj6TldICe3rW5rXbSlzk9L4zVigDWrKf0XsT/s8KupXYAQoTMK3vYKvnA3EY6
	 AOsJtN4tn8zbsYftHQqayypiVs6zXzg2nTu2kf69Okwut1lgcym9YlW7TZ/cuteqQVkJe
	 f9vMjh1aU2Ty+KEazy8x+n0P0L61JvixBgbQdT21ndyij57qHdydGfPwqvazMyJQBdl6q
	 6O+RPLKlmImlgj3ymvQyuTlV3/Dc5oQyHoWE+nDVsWcZqr1UYfPVK7FQ61FCEhVr1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430192;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=K2vUzuaMBCNTUuvS6I+gP0mVDNrQtyFuOyf7v+WWCK4=;
	b=DJYrU6h58ASGQ7XMiaaAgN0b0t9E4ifHbVnamTTpVoGtbDfPqd+IF//kwWBrT2MtNDfX
	 mBf/PgQUDawFWHIYBJtfrjQiqhFo8hLvyuAtYA/HBBKV2BgPHXPalaMR69jeaEDpZaUU4
	 oeIrl2NQyipKiK5XzwmTQOrXznMEjuKSQGAPOyA1BQcYI+Xum0vd2FibEGKPPZOVPV/+0
	 NLee8uZ9cfUPVRt765J72W/f7uUYDWBxQ0IRgpMq4f5HnLqO7Ye/1iA8fr7Erl4zdEIUZ
	 +ItOADlQsl+glbnncWHI8kc4la+fxC9U9xYVFIUmYqfDE9LoJErNpXoJLQRS1OeI/1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="ChWe/0gB";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B9606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ChWe/0gB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6EAF51A1237;
	Mon, 19 Oct 2026 17:16:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3975A60582;
	Mon, 19 Oct 2026 17:16:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A78B10328429;
	Mon, 19 Oct 2026 19:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792430177; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=K2vUzuaMBCNTUuvS6I+gP0mVDNrQtyFuOyf7v+WWCK4=;
	b=ChWe/0gBcL6Z0ItStPa/eTv7ISYebz5yzAyP/xTLc92Ewba7oxmNNgU2GDiIKY2YBdzOS/
	uYq+Wo2GKhlPcFtjvxHMGv93MzwbyhZb1sG5rFzZ8JCMtF6Zhu27FrzT5pyw6brr6KLZGG
	ZuTHg2VKmkpQ1A5IdXSARoE9gZiW57k6LtVtpMTvKigB+DOWsIQ+1jlaM/VNJWs0uUIUpN
	gERIWSKRwoMj7twbqo/1t75xDzHXs+SgcHRu1BNHN4tvRVhftEVVhL5idOQdVyBVQli/MO
	+mZr0P+Y+mL7Oh4l1sAXFBtk/qenV2XqIvv616XzimId7nKDnr4jKPipgeR2pg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 19:16:11 +0200
Subject: [PATCH 5.10.y] sock_map: avoid race between sock_map_close and
 sk_psock_put
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2024-39500-v1-1-e23b37e81914@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3bJLtIKvorxIGXB9YCmVaIhv
 LtFj98k8y9IGk0TjsWCqLMlu08ZsisQrpdpVLI+GxVXXlhaCrNSRk371jHTwauw56bpa4d8ekQ
 d7P0LnuBK4fKD839Pr+6m4bnVsK5fEoE0YnoAAAA=
X-Change-ID: 20261019-cve-2024-39500-76e106088d45
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792430174; l=5109;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=JMhG3o9boJ+wxHglsnr7t8etUPNj8qZyaqZOEfMIXRU=;
 b=wC1Z/gb6XmH3vAEa8zkLo4H8SrSTwhJVpfNo/Vlm/ve8IwCIYPZqo4OwHI6ilbwaPvBl1QSis
 JTedoy2k0HhAIb/1LrKCYa+WBClOGuCb82/R6qqEHlxTzjVFzZErO+g
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit 4b4647add7d3c8530493f7247d11e257ee425bf0 upstream.

sk_psock_get will return NULL if the refcount of psock has gone to 0, which
will happen when the last call of sk_psock_put is done. However,
sk_psock_drop may not have finished yet, so the close callback will still
point to sock_map_close despite psock being NULL.

This can be reproduced with a thread deleting an element from the sock map,
while the second one creates a socket, adds it to the map and closes it.

That will trigger the WARN_ON_ONCE:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
Modules linked in:
CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 unix_release+0x87/0xc0 net/unix/af_unix.c:1048
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbe/0x240 net/socket.c:1421
 __fput+0x42b/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb37d618070
Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Use sk_psock, which will only check that the pointer is not been set to
NULL yet, which should only happen after the callbacks are restored. If,
then, a reference can still be gotten, we may call sk_psock_stop and cancel
psock->work.

As suggested by Paolo Abeni, reorder the condition so the control flow is
less convoluted.

After that change, the reproducer does not trigger the WARN_ON_ONCE
anymore.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_map_close()")
Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/r/20240524144702.1178377-1-cascardo@igalia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/core/sock_map.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 438bbef5ff75..1aa4eafdd7ea 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1601,13 +1601,17 @@ void sock_map_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	rcu_read_lock();
 	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
+	if (likely(psock)) {
+		saved_close = psock->saved_close;
+		sock_map_remove_links(sk, psock);
+		psock = sk_psock_get(sk);
+		if (unlikely(!psock))
+			goto no_psock;
 		rcu_read_unlock();
 		release_sock(sk);
-		saved_close = READ_ONCE(sk->sk_prot)->close;
 	} else {
-		saved_close = psock->saved_close;
-		sock_map_remove_links(sk, psock);
+		saved_close = READ_ONCE(sk->sk_prot)->close;
+no_psock:
 		rcu_read_unlock();
 		release_sock(sk);
 	}

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261019-cve-2024-39500-76e106088d45

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

