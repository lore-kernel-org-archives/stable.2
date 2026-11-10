Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273191;
	b=ib3XVa1YKW3C5X38QLACpn6vNWBgIRYpY2k9ct6IZ4kUKHiVymnfvcrXhn7ypFgvBKFP
	 VdBCqoJUqI018p4QeBNEvuxr+tUi7jhGqs8wlvdCYNDhzf3cSi9zyYG/oGO55esSrF8bR
	 el8vBWjZu/CvpWom2VyHmcmHKrk118A7CI8r1smkbLCiG0qZV3o1fmSiR/kELSXqIMhpi
	 xeL+9rxssQv7pczqR+gI+DDUyqZsU9fCJsLMUIlxAJ7v64dEHCDuzwW1/owYfDwVgbHMw
	 L7dn9cTo4p3SLAT/gSShQ+Fkaug1jAfVwQkjFiu1Q9WDPmp+5HJjQsoypAzsgS2BWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6xnUF5SMtE97xOhylnFb84ucdDn9zYIqWd+B87zBJeY=;
	b=X+KguIdjKitFyjgW9BdbvTrnIE6gfWcjM+PyVg4Aj49r749MYo2bL42FbjEtIkVuIHnZ
	 L4UEG9iG37vR0msCm1eaz/MoLqscyB7z938f0Nwx9iOCks44NJPluwtxAzTID1jHtw52e
	 axjX0BbIQJzzhvWxoPTHapGeRV8KvU0nhyrpU+taUIAmywdAp6PKyp6cD4i6MEhxDBzcw
	 sODL1sacff0kYGVJN2xzYYAXArLKbm3GatKjqqzppG7Bd5zWVvcLFepuX4b0yxItfSdgD
	 ++v82tAwMZp8hOsrsUuAorPpfgDBBXIZBUDUk5S5LkPw28ovER9wfcBcuT8NvubFQTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2Z0j83p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2Z0j83p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D41F0089F;
	Tue, 10 Nov 2026 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273191;
	bh=6xnUF5SMtE97xOhylnFb84ucdDn9zYIqWd+B87zBJeY=;
	h=From:To:Cc:Subject:Date;
	b=G2Z0j83pi5vOY3fngbXnEgRns+fpvojN5HdDgVsCb3SyKwnbQR8PA0S1o3lyJrbCH
	 cn7F86k3Nc0ZEGeW34ET9A9Xi2Fc4E4vpwoqUO7HLxvmRbM1f2TGIWdU5oYVEQZm0K
	 RE8Jqb3wkPCDvhy9Jq+9OkwXTU0eQ8Sd6q3xW3h+5tzSL12HzWce3EYeSyiMD10qkH
	 s+nW67OgtBcHQMmjm82a3r5G2l66PUnaNFdjik479LaGOVD1L0o06AXD90BXYpcbiv
	 QhD9ZJjZ2CHR/HyLQW+oaxjx5LBFOnqulAkuqDGkgTJ5fIiZyiIJvpB4UR02WFqRtJ
	 yDAHuVg3g+nuw==
From: Sasha Levin <sashal@kernel.org>
To: imv4bel@gmail.com,
	kuniyu@google.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: restore refcount ordering for lockless socket access" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:09 -0500
Message-ID: <20261109201309-failed-6.6-5b5d8f351dd9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5b5d8f351dd96f56a58bb516a80e2d4d742fe4e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201309-failed-6.6-5b5d8f351dd9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b5d8f351dd96f56a58bb516a80e2d4d742fe4e2 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Fri, 30 Oct 2026 06:42:17 +0900
Subject: [PATCH] net: restore refcount ordering for lockless socket access

Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t"), default builds implemented refcount_inc_not_zero() using
atomic_add_unless(), which provided full memory ordering on success. The
commit removed that ordering on weakly ordered architectures, allowing
accesses after a successful reference acquisition to be reordered before
it.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups and in inet_twsk_purge(), where the socket is validated again
after taking a reference.

bpf_sk_assign() can receive a socket pointer obtained through BTF
without a reference. Use acquire ordering when it takes its own reference
for a refcounted socket.

Use refcount_set_release() when setting refcounts in the SYN cookie,
TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
TIME_WAIT smp_wmb(), which separately orders the refcount store before
ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20261029214219.1035176-3-imv4bel@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/filter.c               | 2 +-
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 4 ++--
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82ab..d832d3332c6f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8022,7 +8022,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
-	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 		return -ENOENT;
 
 	skb_orphan(skb);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4a507e5a26724..e56beec438773 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1061,8 +1061,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		 * hold another count to prevent use-after-free and
 		 * call reqsk_put() just before return.
 		 */
-		refcount_set(&nreq->rsk_refcnt, 2 + 1);
 		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
 		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
 
 		req = nreq;
@@ -1447,7 +1447,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 				goto child_put;
 			}
 
-			refcount_set(&nreq->rsk_refcnt, 1);
+			refcount_set_release(&nreq->rsk_refcnt, 1);
 			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
 				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
 				reqsk_migrate_reset(req);
@@ -1500,7 +1500,7 @@ void inet_csk_listen_stop(struct sock *sk)
 		if (nsk) {
 			nreq = inet_reqsk_clone(req, nsk);
 			if (nreq) {
-				refcount_set(&nreq->rsk_refcnt, 1);
+				refcount_set_release(&nreq->rsk_refcnt, 1);
 
 				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index b0239d203f045..860145d810ed4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (sk->sk_hash != hash)
 			continue;
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				goto out;
 			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
 				     !inet_match(net, sk, acookie, ports, dif,
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index a1d86026aefb0..e256c55ce9f29 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -143,7 +143,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 * Also note that after this point, we lost our implicit reference
 	 * so we are not allowed to use tw anymore.
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set_release(&tw->tw_refcnt, 3);
 
 	/* Ensure tw_refcnt has been set before tw is published.
 	 * smp_wmb() provides the necessary memory barrier to enforce this
@@ -330,7 +330,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 			if (check_net(sock_net(sk)))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				continue;
 
 			if (check_net(sock_net(sk))) {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 349a3e9927eba..4e0ff3b820627 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req, NULL);
 	if (child) {
-		refcount_set(&req->rsk_refcnt, 1);
+		refcount_set_release(&req->rsk_refcnt, 1);
 		sock_rps_save_rxhash(child, skb);
 
 		if (rsk_drop_req(req)) {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 6dfe40322fb59..33451f00c4e80 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -366,7 +366,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
 			     req->timeout, false);
 
-	refcount_set(&req->rsk_refcnt, 2);
+	refcount_set_release(&req->rsk_refcnt, 2);
 
 	sk_mark_napi_id_set(child, skb);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index aa5fa1dd062f7..1eea584d80df8 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
 			continue;
 		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
 			continue;
-		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 			goto out;
 
 		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
-- 
2.53.0




