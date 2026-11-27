Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795738610;
	b=lq9zEXg+robgsnATf1m5bkwGGEy/v8f8HaFCo4oHbT9M5fps5e+ldam4ImZUEdP8Lsrh
	 NGtFOseBFdq+Y4bxNYIS8ohnXlGkYjzQikJhostdlkuYlJ1zuMBHIoHg4wNVhiCh1W81I
	 oKwfKhX5pLbKwykY8ziFkxY/aPfT3rDhjqFzGyFG0x0qTKlWDEE2f3iwpIVF64n5KTHBc
	 Kyl+R4oV8OUqIAX0Zo1dyHdMEogOv1R90HF9BzXLQzD9NJI/zXBube2qzgpUGWL+9XJQf
	 EmsyZOqDeZFVTJm+uK6Jz2PwdxCi7FD1U/hN3pDSxO+G3JPNbbyJzz58xDdSAyOMaEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795738610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d09q77CW+vLOu0h3yXJDzaOaqLHW3peCBQAh0XhX6Zg=;
	b=DvgHato9uc6uZAY6hf+BKpzTAECiPg4indj18oXPwaHxGxu3NOfSpeUvMB05Xy6X060J
	 J8XjzAfC/Neit7EcKdO9x80JyKtlkrndDheyE3YzDtmOBfqwIS6SLlavRkDoFPnWfODji
	 PjPyMJBI4gkWPDIKDfXZgwKMUX4+W3B7a+YEsVkSbUsuBV90rh634bmZ/VxShLWq4qVfA
	 5uNlSoaL2dZbmNdIcknMtb46fbLUhsKbVcEEPVjQ7yhNsCtUWw6xi4CvhPgOkUbNfN3v1
	 +HK9cGlE/gxUbcJrIkXyhj6ZBnjkI1MBCUm5lfittmIoZs7gHJOUTS0X8FHHW8ObZ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3+gfUgL;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83251606A69F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83251606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3+gfUgL
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so68512695e9.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795738609; x=1796343409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d09q77CW+vLOu0h3yXJDzaOaqLHW3peCBQAh0XhX6Zg=;
        b=D3+gfUgLoHhmkjycLbU8ZDWQECx0FNnNAudpkYvjpTYaKXacBhxhxE9hkG0UIi88ik
         BWLbgdFgEwU84Ypzy4/r+3Hx5ruvMwSTI4vYjog8bbq8F/Vgn0ta7ZDNVFH3PWmKNrhy
         7txK+TAQNTQ3L/1w0Sl2MWPgZNvUB+VQD6E2ruo98DRv6a2lNf+XqKmm09Vu+vCl/ILd
         S6rvS/6D3pngsAqu5p1SklS0Ruq99aWp9/xID6rq+eTPivnTQ7xbuDeh3cHZH8kxnD1Q
         txx2BpxSAyyh7+hvs3xSAUdfJZLLGgIv7KxxnjbJ4DkLczEhiFzumSA26VFI2YFfQklx
         IY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795738609; x=1796343409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d09q77CW+vLOu0h3yXJDzaOaqLHW3peCBQAh0XhX6Zg=;
        b=egJJRrHzVBRPgIAQj2ArJCTmbdXvgbtvQP+AKwXVxwN2QpX3TDrrCo/0DkgII8glOe
         Suxyf76zs1HHIaYb0r7mDwyEDGD+1VecddWbhYyG5Xv+B7eB49i3TiawxWHIvEtVS+kr
         PIUvyo+zP24lgkWiz1a5avnV4DhbgBxrbF35o4P2md8gtp94996UOBgByWIEkz2n6J3W
         5hMDPXQjmMftIZgzTdQCq8lBP7fLVxb3c7A+7h7w4BaYCkDi5YsPnN4kMHB4KbM5KkVQ
         /g5tj9sIXDH121XPrYUmOrX/KqczzEINLcU+P+vkSzXQ8kIxrS0fVrZN41eZwvkeuJY1
         Fk+g==
X-Forwarded-Encrypted: i=1; AL+hErFLzgOvHQylyyYqQxl4Akb9eisYcTOHhMHDJyDeGUglHrMEG2frYvEI9Bbe34xLNw8D3Kv7YPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Eojn36HNSkehEv5AttozkVbRW+vqcB/SPt6AMaDv07sXZmXgS
	wEC7dMqCC7ZLDpyREoF3pzA7AQ+Hv4nngkpD1ePZ6Q/FkDGBkwyVxIE=
X-Gm-Gg: AZFdTZeuMTJWlN5Y92LJL7+QnsWmt2MG8gzgLJVF0l9iPP/RpocdpJGS2/RLgpUHWf8
	/vnUAZI/YTY4N85ZKDgVwBkcf1pR4skf8icEZ/ns3Y0BL46e92nYC4IemSg84eJdgqUtD+IHMLE
	9UYbpJsiqUbmrW8Wbk12+jz94Ioiariy7TkgVEloZu3fiD+eIjrfULgT0AIHiPLcNKvfRBz7mbj
	g8kK/anG8glfzFxbKqNyH6ZzOjDriHTRptn5qhie9YslJUFxPVnJHTvCaUj0fbTfGyyrFFTldzw
	vZd+FrHaKmj+TJ2EpHEV0gt4Cp2BZI7u8JRB9Ar16qHmG0qpxGCgvDknn7eA8bEt8uXnD43ap73
	cX6ULagDLM7XFZZNXorLjb3Jbb8Vj34EihzNL+9NWN5DqW0zRTitNoID7+SNRPQSDNWzlAMY/Ge
	/xY7sIZqdxURVC5XMyiEu6ZJoPpDsC0CrJWb7F/y+R3oOZk/ojCbJ8EHZCooILdkS5jkUbJOcB8
	rEfNLgy9TJ0P/iwtNJ/R8cMPFbwarWdth4xtU9NtbOLT7cmr8mgQsQrI+mG7wIdg2AEIooXttXW
	lz6umuDX7crWeNM=
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb887e25e8mr450837465e9.2.1795738609068;
        Thu, 26 Nov 2026 16:16:49 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm356650865e9.3.2026.11.26.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:16:48 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 nf 4/5] netfilter: nfnetlink_queue: pin file with get_file_active before reading f_cred
Date: Fri, 27 Nov 2026 00:16:36 +0000
Message-ID: <20261127001637.1026589-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127001637.1026589-1-tristmd@gmail.com>
References: <20261127001637.1026589-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

nfqnl_put_sk_uidgid() reads sk->sk_socket->file->f_cred without
holding a reference to the file. Since the file slab uses
SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the
file object, causing stale credential data to be read through f_cred.

Pin the file with get_file_active() before accessing its credentials
and release with fput() afterwards.

Found by manual code inspection; not triggered at runtime.

Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nfnetlink_queue.c | 35 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a8aa7ad832c3f..7a31267ae38f6 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -22,6 +22,7 @@
 #include <linux/netdevice.h>
 #include <linux/netfilter.h>
 #include <linux/proc_fs.h>
+#include <linux/fs.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/netfilter_bridge.h>
@@ -578,29 +579,27 @@ nfqnl_put_packet_info(struct sk_buff *nlskb, struct sk_buff *packet,
 
 static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 {
-	const struct socket *sock;
-	const struct file *file;
-	const struct cred *cred;
+	struct socket *sock;
+	struct file *file;
 
 	if (!sk_fullsock(sk))
 		return 0;
 
-	/* The sk pointer remains valid as long as the skb is.
-	 * The sk_socket and file pointer may become NULL
-	 * if the socket is closed.
-	 * Both structures (including file->cred) are RCU freed
-	 * which means they can be accessed within a RCU read section.
-	 */
 	sock = READ_ONCE(sk->sk_socket);
-	file = sock ? READ_ONCE(sock->file) : NULL;
-	if (file) {
-		cred = file->f_cred;
-		if (nla_put_be32(skb, NFQA_UID,
-		    htonl(from_kuid_munged(&init_user_ns, cred->fsuid))))
-			goto nla_put_failure;
-		if (nla_put_be32(skb, NFQA_GID,
-		    htonl(from_kgid_munged(&init_user_ns, cred->fsgid))))
-			goto nla_put_failure;
+	if (sock) {
+		file = get_file_active(&sock->file);
+		if (file) {
+			const struct cred *cred = file->f_cred;
+			__be32 uid = htonl(from_kuid_munged(&init_user_ns,
+							cred->fsuid));
+			__be32 gid = htonl(from_kgid_munged(&init_user_ns,
+							cred->fsgid));
+
+			fput(file);
+			if (nla_put_be32(skb, NFQA_UID, uid) ||
+			    nla_put_be32(skb, NFQA_GID, gid))
+				goto nla_put_failure;
+		}
 	}
 	return 0;
 
-- 
2.47.3

