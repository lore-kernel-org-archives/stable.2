Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257191;
	b=A3wMS+kjT7lIstn3dza+Jz0bwjkeiSsY3oZrgM0GxFAMf/D17WmvM3CDCjFiqHXY4UP2
	 UEeKpoaozGDRElRoNUPsrjjq+hyBGoXOkLnSFpOSvoN9DxvYHrw2IJ3PM3S9aGuzTbEPf
	 Ru/0HMr3m8KDyeKskR1FgQrE6rKIMaR4tmoWo96k76dDv9qrN1MkZERTiW3Afy02gu228
	 pN+rdMocygkQ33pD7qfYIBupE8xXEHaoZHjxpUd6otn3l8yFc07exfMYz20s9iYGkBaVO
	 /c01XIUTSPUubLRT+ncc86qgkbP5ZxrPBJlhaPBTq5YCvGFwvscpRaU0vQcj3+pNLCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257191;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4p4wKE6PvmozHeJwACGdfAUAVrmaa85dC2fv+mLU1vI=;
	b=ag5vTpU1kglUZv8ZXbKx7AgmHWteXLGqIQNZkosG/l1dpxPi49AQ2FW2iJlALXPPbp2q
	 B0OHK/Jfp/4u9B3dXMCg8CTwwLMft+DwhwpgotJImiBo4uIP83UbhAmJUiavLySu+sivy
	 jTlt2jlQ+cZ4v0Kv1D9oKTq0nUWw0WiejtdEbacXdZHZITUYpeoEzqr18ORT6gHjff/7z
	 81AzrKfNZqxzz6c+nbZFt9tfZ2zJUE/7GnlAouRyY8bGRCdtqLWbFrcLF4Bgh+oK8cbLc
	 VeN6x2oCpSBRVtlX01scTO4DOejsomRYpoDN0uCcDFQDg5C7hoFi7+XlGHvuMukGVHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZdJWXIcq;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53567606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53567606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZdJWXIcq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CbMozn8Q/GM0OSVU0Aj0Uoh2TZ6v7CkdghbcrV/tHjI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257188; v=1; x=1795861988;
 b=ZdJWXIcqcYftA0gxNsl1aBkyYr0nBTJ/z3nhKG63NTqFT2ytE0qAqsOBSenkfxOyu8G6PI85
 RveC3G00/L/MrYOjR471kst79DBN1phTpGrJanHmts2MAWHHV1HIcj3GW/XUXGU0sppbpKYYOaq
 OpsLbGQszno/3TM+aNWmUV5s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f56831efb0c9a871;
	Sat, 21 Nov 2026 10:33:08 +0000
X-Mizu-Trace-ID: f56831efb0c9a871
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 01/11] bpf, sockmap: Fix copied_seq updates with strparser
Date: Sat, 21 Nov 2026 18:30:02 +0800
Message-ID: <20261121103222.88209-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
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

With strparser, read_sock advances tp->copied_seq when it pulls skbs
off sk_receive_queue, and recvmsg() advances it again when the user
reads from ingress_msg. For a skb that the verdict passes back to the
same socket, this counted the bytes twice, so commit 36b62df5683c
("bpf: Fix wrong copied_seq calculation") added psock->ingress_bytes to
record how many bytes went to self and take them out of the read_sock
side.

That works for RPC style traffic, where each reply is read before the
next one arrives. But psock->copied_seq is advanced on every read_sock
call while ingress_bytes is reset on every call, so tp->copied_seq
moves forward whenever a new skb arrives, even if the user never calls
recvmsg(). Once the parser runs twice before a read, the SK_PASS bytes
of the first run are no longer subtracted and tp->copied_seq already
covers them. recvmsg() then adds them again and copied_seq passes
rcv_nxt. The socket now looks empty to TCP, the parser is not woken for
new data anymore and recvmsg() keeps returning -EAGAIN while the skbs
sit on sk_receive_queue.

tcp_bpf_recvmsg_parser() has the same problem from the other side. It
snapshots tp->copied_seq at entry and writes the snapshot plus
copied_from_self back at exit. tcp_data_ready() and tcp_msg_wait_data()
release the socket lock in between, and the parser can consume data and
advance copied_seq meanwhile. Writing the snapshot back rewinds that
progress and leaves copied_seq behind the queued data.

tp->copied_seq should only cover bytes that have left the socket: what
the verdict redirected or dropped, plus what the user has read. SK_PASS
bytes still queued in ingress_msg must not count until recvmsg() hands
them out. So let both sides add only their own delta to the current
tp->copied_seq instead of recomputing it from a saved value. The
read_sock side advances by what this call consumed minus what it passed
to self, taking the delta from psock->copied_seq rather than the return
value so that the FIN byte is still counted. The recvmsg() side adds
copied_from_self, and counts the FIN there as well. Either change alone
moves the mismatch to the other side, so they go together.

ingress_bytes is also bumped from sk_psock_skb_ingress_enqueue(), which
the backlog work reaches without the socket lock for skbs redirected
from other sockets. Those bytes are not part of this socket's stream
and recvmsg() never adds them back, so subtracting them leaves
copied_seq behind. Count only in sk_psock_skb_ingress_self(), where
msg->sk is set, which is what recvmsg() checks.

A strparser skb has no owner when the verdict runs.
sk_psock_skb_ingress_self() sets one with skb_set_owner_r(), and when
the enqueue fails after that, the skb is left to the backlog with
skb->sk still set. It is not in ingress_bytes, so read_sock has already
counted it as consumed. But the backlog picks the path by skb->sk:

  sk_psock_backlog
    sk_psock_handle_skb
      sk_psock_skb_ingress
        if (skb->sk == sk)
          sk_psock_skb_ingress_self   <- sets msg->sk

and recvmsg() counts the bytes again. So once a strparser skb is left
to the backlog, it must not take the skb->sk == sk path. Drop the owner
with skb_orphan() when the enqueue fails. This also gives the rmem
charge back, and the backlog charges the skb again like any other
strparser skb queued there. Picking the path by skb->sk is nasty and
will be reworked later.

Fixes: 36b62df5683c ("bpf: Fix wrong copied_seq calculation")
Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Co-developed-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
The BUG_ON(offset < 0) in tcp_collapse() when copied_seq trails the head
of sk_receive_queue is not addressed here.
---
 net/core/skmsg.c   | 18 ++++++++++++++----
 net/ipv4/tcp_bpf.c | 12 ++++++------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8a3b8536c0c21..16f84dcb5acd9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -574,9 +574,6 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
-#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-	psock->ingress_bytes += len;
-#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -642,8 +639,21 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	 */
 	msg->sk = sk;
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
-	if (err < 0)
+	if (err < 0) {
 		kfree(msg);
+		/*
+		 * A strparser skb comes in without an owner and read_sock counts
+		 * it as consumed once it is left to the backlog. Drop the owner
+		 * again, or sk_psock_skb_ingress() takes the skb->sk == sk path
+		 * and recvmsg() counts it a second time.
+		 */
+		if (skb_bpf_strparser(skb))
+			skb_orphan(skb);
+	}
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	else
+		psock->ingress_bytes += len;
+#endif
 	return err;
 }
 
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 788ce08eef4d7..e59103e77aa5f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -249,7 +249,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	struct tcp_sock *tcp;
 	int copied_from_self = 0;
 	int copied = 0;
-	u32 seq;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -263,7 +262,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 	lock_sock(sk);
 	tcp = tcp_sk(sk);
-	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
@@ -295,11 +293,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 		if (is_fin) {
 			copied = 0;
-			seq++;
+			copied_from_self++;
 			goto out;
 		}
 	}
-	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -341,7 +338,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 out:
 	if (!peek)
-		WRITE_ONCE(tcp->copied_seq, seq);
+		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
 	tcp_rcv_space_adjust(sk);
 	/* Data on the psock outlives the connection that it came in on */
 	if (copied > 0 && tcp_can_send_ack(sk))
@@ -756,6 +753,7 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 	struct sk_psock *psock;
 	struct tcp_sock *tp;
 	int copied = 0;
+	u32 seq;
 
 	tp = tcp_sk(sk);
 	rcu_read_lock();
@@ -765,6 +763,7 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 		goto out;
 	}
 
+	seq = psock->copied_seq;
 	psock->ingress_bytes = 0;
 	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
 				     &psock->copied_seq);
@@ -775,7 +774,8 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 	 * For SK_REDIRECT, we need to ack the frame immediately but for
 	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
 	 */
-	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	WRITE_ONCE(tp->copied_seq, tp->copied_seq + psock->copied_seq - seq -
+				   psock->ingress_bytes);
 	tcp_rcv_space_adjust(sk);
 	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
 out:
-- 
2.43.0

