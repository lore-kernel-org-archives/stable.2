Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7C2472AF
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477820; cv=none; b=d/qJmpDxLIRWsl35ElPKNRkg72cFDXN8y3O8i+1wUnLj2eK0jsWKtExqYnZW2Spi/7dI/+YJ5x4GQb2OXagz6T3CSU7DiZr5X41xBcRGTlbEoAYDzoCLiruQpPhR6ZSCSpdnA14PHpEP0OidTSHdJAyCa901ev4igRCtN6gg5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477820; c=relaxed/simple;
	bh=iSGrBa9MrZpnBNiL/pSvSPtiuYn2CkLBSU+mghu130o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzmW47gSzqfuAyxnth/8stogwNwDpfHzDvvV/PBh8s6U0tSqdTaxUgKZYg3PDBdN5evzXGJ3JNnzmkWET2Pt7Cn84LxhuT6CuKErU4WfODJx6YVRFf1Hsxf8ZlGNUPTmUK5GE59jjlzT3dZXB0J35zxt7Wz9WJ99M9D3wVw50rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxqWL1aY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxqWL1aY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8482ac263bdso246578b3a.3
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477818; x=1785082618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsGdm1kAKTSurBA0TqYfEfEn/QcPy7r5m6E0+HTCYIw=;
        b=DxqWL1aYc8w6Y2MR25y5MkHQy/eZV0OavN1GzY23KlH+Xj5TE4UqkzJH6CGQuUIURI
         WP1q8yQkkrX1hcAZQv8aOU7V7zFyJIaTOR0i8VwX2aDD0NwGzWcTYdHmidxVOHI18l4l
         bXiU9nxThyC1xzPA9pxEQtVIYOpaUjgd7el6o4aNnV+rqLOxhlQwQl78+AQALCTbLu3z
         lolhIaHuFJx0HfVft0iUzvOKaT52fWEWOMsfh0gcYbXF61x6KrvUhFbzPbhCfjmJyzzJ
         D+v+H6QyaxGUh5AXqdMzdAwkQq9ZozMEdAyJMB5AjAGOUBocCCFN6s44eOt+mFma/ACD
         eJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477818; x=1785082618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsGdm1kAKTSurBA0TqYfEfEn/QcPy7r5m6E0+HTCYIw=;
        b=haNGkuXPHrgNhcC3owJ0sGzpU/A/110TrSIqPQKT3atNk7xvSgsKTrHt/9Nl+f0rN9
         89FVdCB7tGUYXEjEdkiIXK88s4aqUYqY8vLzkY6H58ZdxsT0RNkM0jIFe9WAh5XKWfe4
         WZErJ88GBInRMPF71sBhgbCFLlfyUG2vQWMWJKQYfe9XNWyu4Xk87f68A/m+c/cEpWZo
         vpJoMfW+pQcueyG+TRLvuLGK9s0EfPno9NhN1w5Pc14owXv1rFwBgJE8XEWKEtX/Siye
         zm93u+n6/qqzpKw3zxkp9ipE00yLkc2Voc9KT5VAu7kVdW8JCzR0wtmcR8DxfbEsUZ2G
         /A/w==
X-Forwarded-Encrypted: i=1; AHgh+RoKHHPwRUCuF/dZetbXppAVnFLdJyY0bLdfC5fC6JvzipDo2jXm/M/XcrSHE+7xEitMQB9GJnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8zO048kePuaEEcov/NdP56J0WpVZjnLFN3fdpBqc0K/FYZOr
	113R9JnefdM/45xFJLflPvClTK2EvtAa+nYEzd7I1bx9A450Ls0+O8Lq
X-Gm-Gg: AfdE7clqByxWcP/9G/cKl0ZojtIO+ceWVs49+Ao4/OBnA3cEV9OaTHxG3XOs8zCqcb4
	pZ3ncvYglhFyMIlZRx+U4vUGV5lU+YCJUVPlK0moBXeI9ufv+vkXFhxiFIU0LbvecqihHKSxTqV
	dd3ipAknDjE2PRfuZr6h1socbsA1SRjC9vFQgPrAo/wVq/e3AWY0RBHKc9NtxcfZTdFtLIs93fx
	PrIqZCUJ+ro1yOi6FEFDE+n7zPMfF/NITWq8KJzvR31WnXx/auq/Ygt6tUjsgCP/Li5+ByKsTij
	yal19D87SjuNvNV/6E7h7cxX1uTX0EwLaDIWBdC2lbOgEDT5gPdRsFKAPTD4eYs+gdQB3XSLvhD
	yEiu2vMQ7M1BBEdP1tmOTgqWIujIMcTCgvx0H28S94emPnR4NTck4CI2uy3wu/Cc5W1rUHYID90
	+nDXmomHKpICUwFkSZxsjsCKMkf9aaDAoDymX1JRLmTw9Sq0i3d8qGc0m3MKs=
X-Received: by 2002:a05:6a00:ad2:b0:846:8b0a:1536 with SMTP id d2e1a72fcca58-84c294da01amr8277970b3a.4.1784477817551;
        Sun, 19 Jul 2026 09:16:57 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c3793ec61sm3018204b3a.42.2026.07.19.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:16:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
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
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org (open list:BPF [L7 FRAMEWORK] (sockmap))
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
Date: Mon, 20 Jul 2026 00:16:30 +0800
Message-ID: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
drops and reacquires the socket lock.  Its error path tries to decide
whether msg_tx names the local temporary message by comparing it with
the current value of psock->cork.

This comparison is unsafe when two threads send on the same socket:

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

The stale cork is therefore mistaken for the local temporary message
and freed again.  KASAN reported:

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

msg_tx can only name the stack-local tmp or the shared cork.  Test for
tmp directly so a changed psock->cork cannot turn a shared message into
an apparent local one.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..a30475afb6f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -604,7 +604,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
-			if (msg_tx && msg_tx != psock->cork)
+			if (msg_tx == &tmp)
 				sk_msg_free(sk, msg_tx);
 			goto out_err;
 		}
-- 
2.43.0

