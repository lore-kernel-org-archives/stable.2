Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597026;
	b=wbvIVXSf3etMEuwupnjlWhLvT6nmIi1EYHZQWRGNn8jqWrwR4TnMKBjC2BHVJ276mBGt
	 MNr7Yjjk1gbq/51Hazv1RzUVsuU1DmVkQKyZAv69flgbSBd9DwHPF3KhzZQrzCL+WjuUF
	 L3aIv1PvbpYhKtAC7VD49q2sLxiLZS1N9TXDPKceC6YRnOXFFYzeXOz9Mtr+Jw10WCIKQ
	 q7tVOMyIj2bMNm9derHcI6mJo07uHLjuWGXyI1BMXzj8m4j7Yr5QjoJnZPKJGq1xFS/J1
	 0UrvMVi+6QOiCnpMfg0Ys6zzh1/tMjSwmUou43bm6kYNpdeQLaOrC/NWkmbSdlYGQKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597026;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ybfZ5PN5HdLgpOUYPRDVRBznObl4z7neczI/f8DISbo=;
	b=mi3obqx6hL3sWx+qJ7+XcK2D8cnL0Rr3DUZiR0aBCsz/M0xSFCNrWMNKlxElDHOc3kTD
	 xgjzEoYf6qJuuTcGAvOMLJOkhnU10d/62Vqx0p1Hrt0uA1u28qsktlBTMb9sD/8aEMnCY
	 dqlhe5AFk0vZYpZoiQiZV3axvlwUqrbcMR5kLtkgd3TI0rTQbsN7PgMOfNu8qHEQhDbmG
	 +Tgqy0JJSa9HfqKNze3IzO7D/SKmkgflo86XcSZjBQLNuq77t8YMlHx93aVp7y5U86hEU
	 0sHKcn5fia6Q+ftydFlPy2Tevx7pVOhM84lS1Vu/H/mDihqqso18YLyXu/8pT2WSXaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4rbu5LT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71085606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W4rbu5LT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CB1F000C4;
	Wed, 25 Nov 2026 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597025;
	bh=ybfZ5PN5HdLgpOUYPRDVRBznObl4z7neczI/f8DISbo=;
	h=Subject:To:Cc:From:Date;
	b=W4rbu5LTQT7yCusyTYLZ7nt85OZoSmwdSMKxAa1O2X/ngdHYG1djlBKj1y8FFL3IN
	 gqZNiMVrck5DlKpnD9t2F4nMPUG3fIJ6TcBcy5prAvKX7k6pDmnj4DaabrQ1tKG2cs
	 ZCNNxrsWfYJfi6KehD1/BhWpCbfQd5BQ5uFCX2X4=
Subject: FAILED: patch "[PATCH] tcp: fix request_sock use-after-free during Fast Open" failed to apply to 5.15-stable tree
To: imv4bel@gmail.com,kuba@kernel.org,kuniyu@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:56:54 +0100
Message-ID: <2026112554-frequent-aroma-0552@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 62754aad50d0b30938bd8ce30b43474ce502a2af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112554-frequent-aroma-0552@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62754aad50d0b30938bd8ce30b43474ce502a2af Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Wed, 11 Nov 2026 15:24:03 +0900
Subject: [PATCH] tcp: fix request_sock use-after-free during Fast Open
 accept()

Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
made inet_csk_accept() check tfo_listener before taking fastopenq.lock
to avoid taking the lock for connections that did not use Fast Open.

reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
then reads req->sk. If inet_csk_accept() concurrently observes
tfo_listener after it has been cleared, it skips fastopenq.lock and
drops the last reference to the request_sock. This can free the
request_sock while reqsk_fastopen_remove() is still using it.

If the freed memory is reused for a new request_sock with req->sk ==
NULL, the reset path in reqsk_fastopen_remove() can append the new
request_sock to the original listener's list of requests that caused an
RST. After the new request_sock is freed, the next append writes through
the stale rskq_rst_tail into freed memory.

KASAN reported the following use-after-free when writing
fastopenq->rskq_rst_tail->dl_next = req:

  BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
  Write of size 8 at addr ffff888108230688 by task swapper/5/0
  ...
  Call Trace:
   <IRQ>
   ...
   reqsk_fastopen_remove+0x142/0x210
   tcp_check_req+0x96f/0xdd0
   ...
   tcp_rcv_state_process+0x19c/0x26b0
   ...
   tcp_v4_do_rcv+0x16e/0x490
   tcp_v4_rcv+0x14a0/0x1af0
   ...
   ip_protocol_deliver_rcu+0x39/0x1e0
   ip_local_deliver_finish+0x124/0x1e0
   ip_local_deliver+0xfb/0x1e0
   ...
   </IRQ>

To widen the race windows, mdelay(5) was added after newsk = req->sk,
mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
reproduced with this kernel.

For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
tfo_listener, which reqsk_fastopen_remove() clears.

syn_fastopen_child is a field of the Fast Open child TCP socket
referenced by newsk, not of the request_sock. It is set before the child
socket is added to the accept queue. The paths that call
reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
this field.

inet_csk_accept() uses this field to take fastopenq.lock only for Fast
Open child sockets and rechecks tfo_listener while holding the lock.
Connections that did not use Fast Open continue to avoid the lock.

Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/avQKA_YTAThtbsYU@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 37cc8606d683..6c079929e06f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -683,7 +683,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	newsk = req->sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP &&
-	    tcp_rsk(req)->tfo_listener) {
+	    tcp_sk(newsk)->syn_fastopen_child) {
 		spin_lock_bh(&queue->fastopenq.lock);
 		if (tcp_rsk(req)->tfo_listener) {
 			/* We are still waiting for the final ACK from 3WHS

