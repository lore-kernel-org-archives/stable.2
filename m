Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139BE35F185
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542468; cv=none; b=TvwNyNlJANg4RdqTusEoXYxyKyzUr7PQA7uP2ZUqRb1uLCFna5xY3kGjV6oEq3dcY5iziuqDV9Wu555CcCo1LDp8UfFB1r6DTdJT1e1hzhPK1Y9rcomOy9gs5lgc4wxt7UlFtbke6CM5Ne8s5pIT9SlAmdwyELibJW/IGAHvRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542468; c=relaxed/simple;
	bh=fshRyVnVklSNFCrBGc5v+fvhYMKreR65qNagU/FO848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzTpGC340Ph1EUrlx9BIxy77LgPH7HUU49PZU7yIs95vGCQAhyHeqTIPDEcJkPAGUdEBDkhsmo0acfl3QocWmb547fbzgiO7mK98hF74liCiLyA2oHPJOVb7BurZttqyM+cDIe9DBTEldO+KPujBAMHtw/Gi6+9LSRrLblriico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4wKDlT/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4wKDlT/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2876666a91.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542465; x=1788147265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3Ne4nEWByrW0EmFrdDA4ySM1EU9MVsFB0We73FOJj4=;
        b=Y4wKDlT/IyZgrxdbD748RoH8u5Zmr56XV6677dlSzAHS75yvkGczaKspktA5EPBgV0
         zenyKOM7Ehm2cDmJsc5neT+nw49KHA9U0G5kgv6KLlcu8f2THNRtykNdNsf4P5Zd7d6+
         vD7W7xNhY+oJdtrTGUMu1N7lKRd9WTxOwYPWaxy/Zzf37sXePThOvILs1gvrRtuDP/IY
         RN5YiRvPN+fPCT0KxM9en4h54GtY8RbEe/r5j9H0MboVZ1fSWpinBSFNPrpjiFbm747t
         PCWItsin2ALQAMpc2SJ63wfg64SqDh2ovZ833UKyX/4XZUXacx+Oug2VSlQpluzyovuB
         TgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542465; x=1788147265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e3Ne4nEWByrW0EmFrdDA4ySM1EU9MVsFB0We73FOJj4=;
        b=EcDO+EHmTeUgfFZu/VT0btEAdQ2nW4rTrqbpVoCc9JgUhq1R26jETscmLxusESIsh+
         CDz/+YuCMErrynwWLvtcYnF89IQtZBNuMvyBW20kQCs3DY4A4QxeUF0Rb5FLWLAV7eO6
         yejnRlxfaztGEVt2tXVaxbcTs1cIJ6I9dbqzK4h3vstn/9ViNoDArS5fWlkqxkkow+Fu
         Jjf31XA7vfzRCvWBYIREtHMrUMQ0pI5m1D4NXgCvcsLACYlgOaIFW2qnI2c6ZQkPTJuE
         f/tFR1SNwrdBFeWFNrmajXUKvcLp8Rnqa5tUQN8bCj/Bpqxd8THxIOh10zJZREYLz1HD
         3c/w==
X-Forwarded-Encrypted: i=1; AHgh+RomlbWNV/flLyXSA547Q+E8+1pihDtGlqLyxgyWrYEPD2FCMZUXX1sVHwoq8eiQgzyuoXQWxug=@vger.kernel.org
X-Gm-Message-State: AFuF++nQNRbDtSgd+UYh04ad0AG9Rw2RkUpgy2jwgvoHRr9XYXVt1kLg
	zFCzin0Hpdds+7PCP96wCJ1wfwzQik23uHdId1AdexUlnv7pTHaiibvV
X-Gm-Gg: AR+sD12+iSe+Y5tl8l1gVDC9kHDTrg6qcqdXLqu4C1u+X+phZ+ShX9Avpr7ptnUj5+4
	x02zQW3OHhY349pxl/0Upi8B4Uu2Bb+YWL4JWbqMJfeSgNdldmc3fECmapDBEUkPSJnXWajfeVO
	LZ9ggE6hDLuKfW9vJW/kj9czREITbFD6FFwZdjdlpjjPiEB6oYsYfCieGBwz4uhlm/yARxZI0of
	qI8Uhg8cMzVq/haSdtkrqxEPcNcKckg9RvOsV3JRR5J+TYimEyEnO0qkZzmrDHlyp2CDHPO62SX
	WA2+LxE+96Soq8uDt2up7J6aBsZ3/hzAB0jsm5m7yn6Wop/b8XNbeB/tsnZXGPeslmM7PTFzzfc
	JKCm8uoTZWKTTjPoeO0JI97jAYa8FEvM71b+2NqkSHc26rYF/hoT3VKlvWT8OthqKBpILcVwxDx
	4+Hduu+eNIK0z+e206rmMTszypYprZMDRjvU0pPCbMR52k4THvcukGUPYP5ieggz4shbKic7q/C
	/1O5f6Hd/Y=
X-Received: by 2002:a17:90b:268b:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-395c4528324mr21965634a91.0.1787542465447;
        Sun, 23 Aug 2026 20:34:25 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm4227256a91.1.2026.08.23.20.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:34:25 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch,
	kees@kernel.org,
	jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com,
	ij@kernel.org,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/8] ipv6: fix request socket use-after-free after IPV6_ADDRFORM
Date: Mon, 24 Aug 2026 12:32:47 +0900
Message-ID: <20260824033331.1084971-4-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824033331.1084971-1-imv4bel@gmail.com>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_ADDRFORM turns an AF_INET6 TCP socket into an AF_INET one. It requires
the socket to be established, and a listener can get there with
connect(AF_UNSPEC) followed by connect(). Request sockets queued while it
was listening are still there: inet_csk_listen_stop() leaves them in the
ehash, and their timers only drop them while the socket is not listening,
so making it listen again keeps them alive.

A request that arrived over IPv6 was hashed with inet6_ehashfn(). Its child
is cloned from the converted socket and hashed with inet_ehashfn(), so it
belongs in a different bucket.

inet_ehash_insert() locks the child's bucket, warns about the mismatching
hashes, and replaces the request with the child in the request's own bucket
anyway. reqsk_queue_unlink() locks the bucket the request is really in, so
there is no synchronization between the two. Both can see the request still
hashed and both can drop the reference the ehash holds.

The extra put takes the request's refcount to zero too early, so it is
freed while it is still on the listener's accept queue. The listener is
then closed, and inet_csk_listen_stop() reads the freed request and writes
to it in reqsk_put().

In short:

  socket(AF_INET6) -> setsockopt(TCP_DEFER_ACCEPT, 120) -> bind -> listen
      // a native IPv6 client connects and sends nothing
      // the request stays in the bucket inet6_ehashfn() picked
  connect(AF_UNSPEC)                    // stop listening
  connect(a v4-mapped peer)             // become established
  setsockopt(IPV6_ADDRFORM, PF_INET)    // become an AF_INET socket
  connect(AF_UNSPEC), listen()          // listen again
      // the client sends data and the leftover request completes
  close()                               // use-after-free

KASAN log:

  BUG: KASAN: slab-use-after-free in inet_csk_listen_stop+0x1c2/0x760
  Write of size 4 at addr ffff888010b7cbe0 by task init/1
  ...
  Call Trace:
   inet_csk_listen_stop+0x1c2/0x760
   __tcp_close+0x6c1/0x7b0
   tcp_close+0x23/0x90
   inet_release+0x93/0x100
   __sock_release+0x66/0x130
   sock_close+0x18/0x20
   __fput+0x1f0/0x4c0
   fput_close_sync+0xd2/0x170
   __x64_sys_close+0x55/0x90
  ...
  Allocated by task 0:
   inet_reqsk_alloc+0x8c/0x320
   tcp_conn_request+0x324/0x11f0
   tcp_rcv_state_process+0x2ff/0x2cf0
   tcp_v6_do_rcv+0x326/0xc30
   tcp_v6_rcv+0x1e07/0x1e90
  ...
  Freed by task 0:
   slab_free_after_rcu_debug+0xc5/0x200
   rcu_core+0x4dc/0xd20
  ...
  Last potentially related work creation:
   kmem_cache_free+0x11d/0x5f0
   tcp_v6_rcv+0xb30/0x1e90
  ...
  The buggy address belongs to the object at ffff888010b7cb60
   which belongs to the cache request_sock_TCPv6 of size 352

Refuse the conversion if inet_csk_reqsk_queue_len() is not zero. Nothing
clears that counter when a socket stops listening or listens again, so it
still accounts for the requests left in the ehash. A socket that never
listened is not affected.

Reading the counter once is not enough. inet_csk_reqsk_queue_hash_add()
puts the request in the ehash first and bumps the counter second, so a
setsockopt that lands in between misses a request that is already
reachable. No new request is created once the socket stops listening, and
a SYN that found it while it was still listening is handled inside the RCU
read-side critical section the receive path holds. Waiting for one grace
period before reading again therefore leaves no request that is reachable
but not yet counted.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Read inet_csk_reqsk_queue_len() again after synchronize_rcu(). A request
  is put in the ehash before the counter is bumped, so v1 could be raced.
- Move the check below the TCP_ESTABLISHED and v4-mapped checks. In v1 a
  listener returned -EBUSY or -ENOTCONN depending on whether a peer had a
  half-open connection at that moment.
- Add the trigger sequence and the KASAN log to the commit message.
- v1: https://lore.kernel.org/all/20260817090319.3897799-2-imv4bel@gmail.com/
---
 net/ipv6/ipv6_sockglue.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e0a..6d2dd9ae46a964 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -587,6 +587,21 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				break;
 			}
 
+			if (sk->sk_protocol == IPPROTO_TCP) {
+				if (inet_csk_reqsk_queue_len(sk)) {
+					retv = -EBUSY;
+					break;
+				}
+				/* A SYN that found this socket while it was
+				 * still listening may not be counted yet.
+				 */
+				synchronize_rcu();
+				if (inet_csk_reqsk_queue_len(sk)) {
+					retv = -EBUSY;
+					break;
+				}
+			}
+
 			__ipv6_sock_mc_close(sk);
 			__ipv6_sock_ac_close(sk);
 
-- 
2.43.0

