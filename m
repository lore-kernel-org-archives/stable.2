Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D482F39C2
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823980; cv=none; b=HuIHPEdbZUqGfRsCtD8q31t8KnDM+mGM6KSeTg4TscrpzTtZcSANrYaB0i5In14l+V5wcVpDoGE9Zy532wSP/XolIbjsNKPArxz453sRbVmmkR1ne5Kr5tX5LCpLFbyBZ9T+ss7Bsj0VF5AehfMfUVxyM2EdAJPKe55MoR17xfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823980; c=relaxed/simple;
	bh=TCOlassBQx9ySoijfMz1l85P5sgTBaeOOaOHQV89RSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8kbHfZJ48EVwc+dSJ4P7MEaos5GYvUXa02MSdBFN8zriAOTlOviE6Tq1L36VKyiR94UK0I4zR8NezeT1kfFoNHZqQanPkUIO/yCGYgdD4UhrHmXpOkpfIp9JWhhyJkUwpVeAlbjNATHuQGXxU+1JEAiydxVO1HSQg0JwdCmN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAFVHmav; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAFVHmav"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so87175a91.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823973; x=1785428773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cZoKc9FwZgZIi/HTgzAkALIT6yFSGhhHDxBwZd3grk=;
        b=qAFVHmav779Mjsvl/j/pjkexhKI8wvQPiJcUVy3iZzNWqp4aP0oq76Xs0/CX3E2uAA
         5B1LB0guEisj9yH7IQUFV40rmIw63OfnliHdqRTjkAUsySaT7swNp7lY8J8sdLs+7PDm
         bLcDC8ZqmKVqzgfOjFFKAIAjXjQoLt6rr11u8ttXRBYhR6aGLiN0WqNlsgnwICgHxr7b
         Vz7qeqgGK2JyLxxs+7ETINPqM3lbjWvjmvekDedPFaIUvImnD02VepQyHQZH6rH6lJJ+
         yMT2HGRJXCuf9YdraEz4tdyCuPqAvxKao91wg4tIjVjXGQJHIVuZzi2QUFtaCJBNSNuF
         +uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823973; x=1785428773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3cZoKc9FwZgZIi/HTgzAkALIT6yFSGhhHDxBwZd3grk=;
        b=ONLZezeU7VmrrjMiXcNJBtClq1KrOjn3jZFpcvYRbX4D+Yz6+n54IPgux75+HwSxBH
         NwO2H2M561r7fMtDMJHsDza7AETlsA5GdddbkJKN9/QXNn6Lti2Sn36F7qZAmM72hMWR
         2CR3xfzFby1p61ZzSk55thqCpUadecA977gYmrw24nNCbk5HVUc3n87oO4vvqrBUilSG
         SrB/7nmdBL5ZMqbQ1VV6yNBQ2yMK4Rx+5YcMNqhEemMzK7KSZmWf7aE1YzR5sdFYRDSJ
         3XeKxoAXlpypNCwgFYVn7r8MvVYm6/OM3HdeA3qozT8Gu3j7V3jlRjPdu8MOGfXmG+V2
         WMeA==
X-Forwarded-Encrypted: i=1; AHgh+RpoPEG/BUuEWwOk9rmpmFmsK2LOe+EWgPOaG7xbum5JwHD2ERzUEYXojOaobR/y3JbhhpZ00i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnvTcqx4HhIXMaA8Jc7nNa3SwuvCWoACPyzE9NrRD4yvII7n+
	035+NcpJ9MCSJmY9t8jCEo2Oi7Jem2cVQ5dvdRUDHlSX5JojnomvqBWg
X-Gm-Gg: AR+sD1135xcpSjg+eMPj1PeHBn9m4wWsXLgGWagbm2O4lAXdRjKw5FJTkJld1qt83nk
	6ShuSvPPs6oWDap9ttcjZwvpcap8PRKnWiGdOK/blM4pqYVKxrszMWDDtePq1/vfGpHViNH/Ect
	YT0OWudywHsJ3F3xytAazoZ1M1toi0T+l2tUdS3cQdgsPrIvqZwkPrM961iqxTOyE2QXbW7ifGu
	vAez7Caiz/HnFTIPdgW/Ov+188otZvmxOHMGBiV4S/SZpd9uVhu5fOeosEmtTpwH7HkNLAboqWZ
	zCZl8fTOVV5xr+fVrfV9SVUj9QNNRKI6mx6zJZXOY2gS40qRwQy7/V5hyM9LuHou/XtRDhfg1nA
	9urHvQHHsQUxX0MkAvv9ZJpdNVUs87U5zyfXTpEfCrcdxJabjRJyZNTYeTgjOkXLcIH7M1uDDfr
	5xXowctQecMWWn/9h7DRJ3xPfQ+whmy/7ZXdakORujFFE3NF2BPCq8mIn2ht+uuKjIVgbS
X-Received: by 2002:a17:90a:c88b:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-38f02945ac9mr361904a91.2.1784823973168;
        Thu, 23 Jul 2026 09:26:13 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm17536546c88.0.2026.07.23.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:26:12 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
Date: Fri, 24 Jul 2026 00:26:02 +0800
Message-ID: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which drops
and reacquires the socket lock.  Its error path used the current value of
psock->cork to decide whether msg_tx named the stack-local temporary
message.

Two senders can therefore interleave as follows:

  Thread A                         Thread B
  msg_tx = psock->cork
  sk_msg_alloc() fails
  sk_stream_wait_memory()
    releases the socket lock      acquires the socket lock
                                  completes the cork
                                  psock->cork = NULL
                                  frees the cork
    reacquires the socket lock
  msg_tx != psock->cork
  sk_msg_free(msg_tx)

The stale cork is mistaken for the local temporary message and freed again.
KASAN reported:

  BUG: KASAN: slab-use-after-free in sk_msg_free+0x49/0x50
  Read of size 4 at addr ffff88810c908800 by task poc/90
  Call Trace:
   sk_msg_free+0x49/0x50
   tcp_bpf_sendmsg+0x14f5/0x1cc0
   __sys_sendto+0x32c/0x3a0
   __x64_sys_sendto+0xdb/0x1b0
  Allocated by task 89:
   __kasan_kmalloc+0x8f/0xa0
   tcp_bpf_sendmsg+0x16b3/0x1cc0
  Freed by task 91:
   __kasan_slab_free+0x43/0x70
   kfree+0x131/0x3c0
   tcp_bpf_sendmsg+0xec3/0x1cc0

Make temporary ownership explicit by freeing only the stack-local message
at the common exit.  When a verdict moves that message into the persistent
cork, use sk_msg_xfer_full() to clear the source and record the persistent
cork as the current owner.

The related failure paths must also distinguish bytes in the current
message from bytes sent by earlier loop iterations.  Track the former in
msg_copied.  If cork allocation or redirect fails, subtract only the
unsent bytes belonging to that message, preserving the syscall-wide count
for data already sent.  Also reset cork_bytes after allocation failure,
skip a self-transfer of an existing cork, and propagate iterator errors.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Cc: stable@vger.kernel.org
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v3:
- Transfer the temporary message into the persistent cork with
  sk_msg_xfer_full(), leaving the source empty at the common exit.
- Track the current message contribution separately so cork failures retain
  the count of bytes sent by earlier iterations.
- Address the two ownership and return-value issues reported by Sashiko.

Changes in v2:
- Address Sashiko review findings for stale cork state, iterator-error
  propagation, cork self-copy, and masked redirect failures.
- Keep the original stale-cork use-after-free fix.

Sashiko: https://sashiko.dev/#/patchset/20260719161630.2901208-1-nicoyip.dev%40gmail.com
Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev@gmail.com/ [v1]

 net/ipv4/tcp_bpf.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..fbb11b5abcd4 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -416,7 +416,9 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 }
 
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
-				struct sk_msg *msg, int *copied, int flags)
+				struct sk_msg *msg, int *copied,
+				u32 msg_copied, bool *corked,
+				int flags)
 {
 	bool cork = false, enospc = sk_msg_full(msg), redir_ingress;
 	struct sock *sk_redir;
@@ -443,12 +445,18 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->cork = kzalloc_obj(*psock->cork,
 						  GFP_ATOMIC | __GFP_NOWARN);
 			if (!psock->cork) {
-				sk_msg_free(sk, msg);
-				*copied = 0;
+				int free;
+
+				psock->cork_bytes = 0;
+				free = sk_msg_free(sk, msg);
+				*copied -= min_t(u32, msg_copied, free);
 				return -ENOMEM;
 			}
 		}
-		memcpy(psock->cork, msg, sizeof(*msg));
+		if (psock->cork != msg) {
+			sk_msg_xfer_full(psock->cork, msg);
+			*corked = true;
+		}
 		return 0;
 	}
 
@@ -495,14 +503,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (unlikely(ret < 0)) {
 			int free = sk_msg_free(sk, msg);
 
-			if (!cork)
+			if (cork)
+				*copied -= min_t(u32, msg_copied, free);
+			else
 				*copied -= free;
 		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
 			msg = NULL;
-			ret = 0;
 		}
 		break;
 	case __SK_DROP:
@@ -534,6 +543,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	struct sk_msg tmp, *msg_tx = NULL;
 	int copied = 0, err = 0, ret = 0;
 	struct sk_psock *psock;
+	u32 msg_copied = 0;
 	long timeo;
 	int flags;
 
@@ -548,7 +558,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	lock_sock(sk);
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
-		bool enospc = false;
+		bool corked = false, enospc = false;
 		u32 copy, osize;
 
 		if (sk->sk_err) {
@@ -560,9 +570,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		if (!sk_stream_memory_free(sk))
 			goto wait_for_sndbuf;
 		if (psock->cork) {
+			if (msg_tx != psock->cork)
+				msg_copied = 0;
 			msg_tx = psock->cork;
 		} else {
 			msg_tx = &tmp;
+			msg_copied = 0;
 			sk_msg_init(msg_tx);
 		}
 
@@ -579,10 +592,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					       copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
+			err = ret;
 			goto out_err;
 		}
 
 		copied += ret;
+		msg_copied += ret;
 		if (psock->cork_bytes) {
 			if (size > psock->cork_bytes)
 				psock->cork_bytes = 0;
@@ -595,21 +610,23 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			psock->cork_bytes = 0;
 		}
 
-		err = tcp_bpf_send_verdict(sk, psock, msg_tx, &copied, flags);
+		err = tcp_bpf_send_verdict(sk, psock, msg_tx, &copied,
+					   msg_copied, &corked, flags);
 		if (unlikely(err < 0))
 			goto out_err;
+		if (corked)
+			msg_tx = psock->cork;
 		continue;
 wait_for_sndbuf:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
-		if (err) {
-			if (msg_tx && msg_tx != psock->cork)
-				sk_msg_free(sk, msg_tx);
+		if (err)
 			goto out_err;
-		}
 	}
 out_err:
+	if (msg_tx == &tmp)
+		sk_msg_free(sk, msg_tx);
 	if (err < 0)
 		err = sk_stream_error(sk, msg->msg_flags, err);
 	release_sock(sk);
-- 
2.43.0

