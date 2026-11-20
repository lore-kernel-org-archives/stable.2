Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162446;
	b=3lAgFBPX7LdCj29LexwCPrAUR6EZO+NeBzSFTaV2b7tEzljkYWMp+x81zwzHvtVgixeY
	 fsVvFCF3Jtfxj97jNUE3TxczxLCHrawCsUB1rnNxqt2bLVf/UaxKl6dNu5MfOlr99rAPw
	 TzSU1S3+S4Ek6vFHgF1FSy8aFSyHHBXJRhAjMm8SXz7+nUxZlImouQ+lQkHlN1vqxo09v
	 tk2rR6ZQkYSX/9GZGxbN1DRcHosXfof/zMK5J1D7X344RRyq+uY+vCLRXHNRXdlFSvi9Z
	 yXb0qzOrQaUD4yHI0Ge6BIpqh/mAOr/ejNhh0UopSD6olW99brSpvt7xjLepHUgrz6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T0QMJszuIflUVnI8KlcqSRkClwadTrIU4ZiU7YrghCU=;
	b=3tt5aR+BMlc3lrUNTKmJIhk2XgFdxE43rLPxli76ogfCDLKYuiw9On1o5QRC7VBpfgvO
	 CSikmSQ3/mGGlYPKj1jn1J8RUweOEXN66NoHchJQd0xbgUZXuWc64X9hZXqeUnSxiVxp5
	 VXMqNf48hQEMcMV1AErb5B+PiJBxm+6D5sN9zga9Z11HwD5YQfe9+8kcDyKE35oKgy0h5
	 iuJP96WXYTFb3lJ7662OIws9l7UuyFTB2xA8bIP/hL9H1Nik/3E/DerjgKTfrk6rAOL4U
	 FZMDRjyCfp3nHRaY4QctCJ51xal4acIpOWXXJv+Nj3CiJ5RGQ2HB1+oV7zhhkkceSmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="02Lc/GYw";
	arc=none smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45520606A33A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45520606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02Lc/GYw
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-550f311b527so288261b6e.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162444; x=1795767244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0QMJszuIflUVnI8KlcqSRkClwadTrIU4ZiU7YrghCU=;
        b=02Lc/GYw2gxzEmZruC8Z+5VLREVU/C4VyOlAiTMxbtK1EiR9O/InpVdhJt+jsuWdri
         azz8I0igt9BvLiWPwUHwdpK0BHkPn4Lx8FuZqM4E9wyoyqch+PyPwaOBGlWraenWlBmy
         aGiu/xLJvN5Eg8ammghkZk7ivQjJFM/+buBL9D0HCh/0P656asbkAQwatRP93Q0WwNJd
         ShcYWOZPADssfVezfCfKh7pE+WJ21o+uIq6DqzhqRIn8YmMySwhWMlVzeDONdlO6kLLl
         GatYTUYVUi0+ErEee8/+tAxo1dYdLt1DA3iqTS7u5nDLOa36q+Lm2WjY9Ut9DMeun4TU
         Hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162444; x=1795767244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0QMJszuIflUVnI8KlcqSRkClwadTrIU4ZiU7YrghCU=;
        b=NV0TF9kA1GPfY1wXl0/klOukv9PHRee0u73dlJZW0C7SAcTwXBWx0xY4wRvaGI6irv
         EwTAnyH5iuFTdZlCRIvC27Z7sF9IDHTETI+jjGPsf7G4keOCn5Kh/MPrp75O857EudGZ
         YClzB3t99jRWdgrc+MlWl2ZbqVT0o3PX6hvipVQKe0iZSLo5Grram8CLRPu5NAbRl2up
         +NOgHcXUrDfJJ/yJ3LUI6HRk23L+SpxABAgbGa3/eoCP1S5Ds/yfOBnrUnMNp9NYrRo1
         64I3VmcxDP53Fabmr0ImNSReTBlX8bvruoy/2syRsGPgObhDvkdzw2O1Cegtj+sdMCKn
         vB8A==
X-Forwarded-Encrypted: i=1; AL+hErEUMeKciO8UVn0+fk76y4VINMBIETha2DDB+sAyPZvMXjw/etD084PegMNv+J8GyKH1Mc+jccw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mqoxloKnJ+eAVkMiY/k6APEUvHzp6T0kcEKKALGXY+6Y1uKcv
	MHemfScbATMY/OX8VlHSK93KN2yP0ZkcFbL/1Hmv2KW0L9ElKsad2aC0
X-Gm-Gg: AZFdTZcbz0fof2lACcwIcJ4qIihQnD2ZLF3nk39JtgFfBFgs9CMAMAkXN0L55haHjij
	38Wty9yJ1yFcthEROc85Ef0ctCfpEwc3XQIQQt3f2eECICys2wgRsxIH3DS00izHG5YUFGPjdzC
	t06Y1jOd3J2TtOLzWo2vL/svweVZGnL05NkwYb/pC2P1tTWMSf9PJzsZ4p75tfmjKlAe9VjP6ZX
	Bzs3TznQJKNk+nbEBUWsAdsxyguG11GBTx96w63IV3caVB5H8wziCs5Mla/N8L4ObrinFxjH9QZ
	+hSPAXxYZFgd1qD5CYeItnWTh0MOoXKx6/m1ytdaVVUCdraDZ42Azhm0tmnOAbEeEtLD9Eh2JmZ
	mCo5a4E7nVLq1B94ZVBa1ikLKgfeL+sI66ZwYa7M9ph5bZe8CIEhmrtIsJMwqOIdYL8hm3Kum6g
	O7UbB2R0ymhsQCJVpWLQXet04pkRsKI/OyTzXnHNgi/vvku06/fyLlYD6xIAJ9kYb6V3EV7SITN
	s2bAFF1/79n4v+rRtoiBtgt5IZqDO4sMGRazjwTsaAkYQYSTF5B961Z7trNQ6TlnGzwpcgs/qOP
	QDNoTqAs8Gw4Y42G2+jgakT7l6McKjqVUDZdFm+fpWDRkHdrrHyTqraR7iXzUPsvNsA=
X-Received: by 2002:a05:6808:1387:b0:4f4:b62c:a3d8 with SMTP id 5614622812f47-57a0a937f43mr3229475b6e.33.1795162444278;
        Fri, 20 Nov 2026 00:14:04 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a350548ffsm1497559b6e.11.2026.11.20.00.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:14:02 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: llcp: fix double put of nfc_dev on interrupted connect
Date: Fri, 20 Nov 2026 16:13:54 +0800
Message-ID: <20261120081354.4098856-1-bsdhenrymartin@gmail.com>
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

llcp_sock_connect() takes an nfc_dev reference with nfc_get_device()
and always drops it on the error path when sock_wait_state() is
interrupted.

While the socket waits for the peer, nfc_llcp_recv_cc() can already
have claimed it: the CC handler moves the socket from
connecting_sockets to local->sockets and the reference now belongs to
the socket. It is dropped exactly once, by nfc_llcp_recv_disc() or by
llcp_sock_destruct().

If the interrupted error path still unwinds that reference, the
nfc_dev kref is put a second time. Once the refcount underflows, the
device is released while it is still registered and in use:

e.g. on v7.4-rc3 (KASAN build):

  KASAN: slab-use-after-free in klist_next
  Read of size 8
  CPU: 2 UID: 1000
  Read: klist_next <- class_find_device <- nfc_get_device <-
        llcp_sock_connect <- __sys_connect
  Allocated by nfc_allocate_device <- nfcsim_device_new
  Freed by kfree <- device_release <- kobject_put <-
       llcp_sock_connect <- __sys_connect

The freed device is later used by nfc_llcp_tx_work(), which trips a
KASAN use-after-free write in mutex_lock().

Check whether the CC handler already claimed the socket - it is the
only path that links a connecting socket into local->sockets - and
leave the references with the socket in that case.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: ff353d86a92e ("NFC: LLCP connect must wait for a CC frame")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/nfc/llcp_sock.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde68..22b2f65e984a 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -683,6 +683,36 @@ static int llcp_sock_release(struct socket *sock)
 	return err;
 }
 
+/**
+ * llcp_sock_on_local_sockets() - check if a socket was claimed by a CC
+ * @local: the LLCP local the socket connected on
+ * @sk: the socket to look up
+ *
+ * nfc_llcp_recv_cc() moves a connecting socket to local->sockets when the
+ * peer answers with a CC frame.  Only that path links a connecting socket
+ * into local->sockets, so membership doubles as "the peer claimed the
+ * socket".  The caller must hold lock_sock().
+ *
+ * Return: true if @sk is linked in local->sockets.
+ */
+static bool llcp_sock_on_local_sockets(struct nfc_llcp_local *local,
+				       struct sock *sk)
+{
+	struct sock *s;
+	bool found = false;
+
+	read_lock(&local->sockets.lock);
+	sk_for_each(s, &local->sockets.head) {
+		if (s == sk) {
+			found = true;
+			break;
+		}
+	}
+	read_unlock(&local->sockets.lock);
+
+	return found;
+}
+
 static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr,
 			     int len, int flags)
 {
@@ -781,9 +811,27 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
 
 	ret = sock_wait_state(sk, LLCP_CONNECTED,
 			      sock_sndtimeo(sk, flags & O_NONBLOCK));
-	if (ret && ret != -EINPROGRESS)
+	if (ret) {
+		if (ret == -EINPROGRESS)
+			goto out;
+
+		/* If the CC frame was processed while we slept, recv_cc()
+		 * moved the socket to local->sockets and the dev/local
+		 * references now belong to the socket.  They are dropped by
+		 * nfc_llcp_recv_disc() or llcp_sock_destruct(); unwinding
+		 * them on this error path would put the nfc_dev reference
+		 * obtained above a second time.
+		 */
+		if (llcp_sock_on_local_sockets(local, sk)) {
+			if (sk->sk_state == LLCP_CONNECTED)
+				ret = 0;
+			goto out;
+		}
+
 		goto sock_unlink;
+	}
 
+out:
 	release_sock(sk);
 
 	return ret;
-- 
2.43.7

