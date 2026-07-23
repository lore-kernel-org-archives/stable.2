Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77E4756B6
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820911; cv=none; b=kt5CVFv6+ksXUMRotSBvqnTs7u5KDPKRS99ozsEe/41jH/e3RmsyFTV+RbRqJHY7TX82ikwknW130TYFY6911vP6JvfxczT63R2DhCxIJfePMe0Y+wlhwc75EvgdtI7FSKe8zxrHMxzcrvClIgPdjkba8MdOa/JZdHtQhMjz5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820911; c=relaxed/simple;
	bh=f/W56l8v8I4Z/bI4TUYNCd7jTn6u4MyWo43wLwwz+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Asj3uiB6/fbJ8dIio1+Ts8JxjJg9/qzQgh/zbF7BwQ1fElcJzSwxWe2zyTDIRE/0jCtEQC9qnaL8JGJ85AT5SoSK2IsGCKwFzWBU00IJX7m0i+T83Sh6+sTMTigsLsgy5Db1jCfKcpXCP5O/Jl2mBKK0mWkgUCpBxBP5Z/QPvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKNjJ7yz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKNjJ7yz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9b3f380006so102918a12.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784820902; x=1785425702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUwFPXE0ARZ2U6TesCDMJktXSbqLTCmlCnjsBK9QtbM=;
        b=lKNjJ7yzMjwjyP4JKop1k931LjF3By13vj8GM5YnBq5vk4uV0JzuCmSfYUadN3c8c1
         1D1GguBOWOZeGZIAJg/um7xhS8RRYzIHTlYJgVGfD29MV/ztNJn/i+GgqmCGmayIGOEL
         YnAxhUj8AvuVLpnBJ3PisxXTB6xwKZY+q8GDK0TPy0tYChfFFn5nv8fQmcK7Y8IdMlBT
         Mov9ChiuVFVcsnjpTHjrcrg8v9iSCV1wVSQ5LtYYDYh3LU0shvWE5Aajp/vMUwhnQuoj
         zewHYtInzS6RAmSRC+KRTh9xih7BnE2idfPh3OX+BsvGDDkItWJOVDK+2jZXUPvKgB4M
         e5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820902; x=1785425702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUwFPXE0ARZ2U6TesCDMJktXSbqLTCmlCnjsBK9QtbM=;
        b=Tqf5PlceRxTfZxM0ehcje9LuxT7ZTUgjr9kUze6b3P2cV3T2WfSL7TW+dtCXQRhztZ
         PhinfZwQLDTWGyjejwJWTJybXbP7khTGEGTTkpFojaA+Hh5PWB03J2mMxnLu7cDeIZ3U
         pMnh51kLjqRuqT82rtJs/n0KXaz3p+XyhVSRzYajjP7UOdFxkkeaY3Gpt54gx/ipKzKr
         Js0NBc5K6NL9WxvhydJ5jYg5PxMntOwysbTm+h5PPlgTsBpnXUo+k7RRbJ0eNVqx7nRS
         m2ohpvdlLZovG62ASmx4A91ZI7yf6Jv+57aqgVwLxFhDDS9A8jo7MNURVRa5iTbeV/be
         agCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0SgHDYBHRE6bTdxoAKXNhw9XRx6pkokSRkcPLFF2dHeEe+AAho8dMXBiVGZMRUZJQ6TvHEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuEhM3XV+gNc2quib9dqwMKE4pblFqOsemZ/uYBCSyZwU1mWm
	MMBEP58+fdKtZ1nklJzJewgLKNcccxq6HKHwRcTgwIXgguscy+84JgYTw9IFYQ==
X-Gm-Gg: AR+sD12Bx6W3ldmH8zerAY7rCzf3hKdk3ytqjlOzrh0+yGURoPjAZsssEiayEG5+54d
	Yg8KYIQop8lPB0NRmZryNn5FCjU78ikxyo7b8XlqmdCGFHypg+2AsHNoNlbw49TNEnEAjcvmYON
	dYf5CpB69UatleXSHBMlPUlb0xvdbwRGyT1hygeF4jX3ZMBcWJeT6YGBcoWEVz4+fmo3Un5H/N0
	BYwArmgkdaZIg+psXJj2oa6PZTSlt6k3Qc69cvOhxV75+e6G0cSdgisFkGWV2tKTAm5LkIUHsfN
	aUcAsoBWZslbJ1ZyA0Sx0DeapmNa5lsYB62EFEdJWUo9YwhpK2tquypFUdc97ADfb3kwLao9L1a
	+5Hck//alZq7Rx4zWhq0VFWb5TC0/tLZdOLMYCaTypLKzsMoO9tBe3tEUz6m3oG+BWF2TibDDmC
	IEmKfPjOxx3px63j/ecHID1wsqaOdAjosx0d6VwQi5c+NRxI7VHuROwA+IDfWXldBMY4mKXnkvw
	H9y+qU=
X-Received: by 2002:a17:90b:254a:b0:36b:9323:c726 with SMTP id 98e67ed59e1d1-38f02f3b968mr153278a91.4.1784820901333;
        Thu, 23 Jul 2026 08:35:01 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149a62cf50sm7576718eec.5.2026.07.23.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:35:00 -0700 (PDT)
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
	Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
Date: Thu, 23 Jul 2026 23:34:50 +0800
Message-ID: <20260723153450.3224353-1-nicoyip.dev@gmail.com>
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

The same unclear ownership also leaves several error paths inconsistent.
A failed cork allocation leaves cork_bytes armed, a subsequent temporary
message can escape without releasing its pages, iterator errors are
returned as success, and a failed redirect of a corked message discards
data while reporting it as sent.  Re-evaluating an existing cork can also
copy the object onto itself.

Make temporary ownership explicit by freeing only &tmp at the common exit.
Reset cork_bytes when allocating the persistent cork fails, propagate
iterator errors, preserve redirect failures and clear the copied count
when corked data is discarded.  Skip the copy when the message is already
the persistent cork.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Cc: stable@vger.kernel.org
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v2:
- Address Sashiko review findings for stale cork state, iterator-error
  propagation, cork self-copy, and masked redirect failures.
- Keep the original stale-cork use-after-free fix.

Sashiko: https://sashiko.dev/#/patchset/20260719161630.2901208-1-nicoyip.dev%40gmail.com
Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev@gmail.com/ [v1]

 net/ipv4/tcp_bpf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..0594ee4013b0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -443,12 +443,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->cork = kzalloc_obj(*psock->cork,
 						  GFP_ATOMIC | __GFP_NOWARN);
 			if (!psock->cork) {
+				psock->cork_bytes = 0;
 				sk_msg_free(sk, msg);
 				*copied = 0;
 				return -ENOMEM;
 			}
 		}
-		memcpy(psock->cork, msg, sizeof(*msg));
+		if (psock->cork != msg)
+			memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
 	}
 
@@ -495,14 +497,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (unlikely(ret < 0)) {
 			int free = sk_msg_free(sk, msg);
 
-			if (!cork)
+			if (cork)
+				*copied = 0;
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
@@ -579,6 +582,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					       copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
+			err = ret;
 			goto out_err;
 		}
 
@@ -603,13 +607,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
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

