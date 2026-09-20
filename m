Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE42ED16D
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889692; cv=none; b=iVKxMokVxNgNmFiVOJrbpoB+BFk891Xc1rm/tCYoNmX+kU+nNx0eDAwLnV4xEuxyiZoaxi5r0QJjmEWu36VvSAsQKnvtf+NskfuigKFa+f3cZKZb7UeXMAwA5f4v+5EhSf2cEZ9akenanPqKCcqpgdjpcupr3dIvhMDl3L2WVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889692; c=relaxed/simple;
	bh=TAj2NX0BalsJBIg90f+gSFK6xjs2mTvRi0degX+efHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FawT+YWflzQlotVy9xYxzIhwa44GN/LsAoHCtNZdNZ4950HK5xzSFO3dDJ8quQMfmam8ilhH/HHORh931G0pbKGIMB23d2v0mXizhyydavbKMaf0iwcNwqSWta0tYVPf7I4FC2kLmNtqWVl1wRGXtr2YClr3itdidJaOGCvw7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfqnl6An; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfqnl6An"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so1294298b3a.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889691; x=1790494491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nzImtRCLEOk3zqgss+ECzroPEOpVx7SLulh8ddX6bHw=;
        b=Jfqnl6AnnAbY3RFLcpgYnf5JYS1l8SVPRaT2SL25G+mxcP5YWN4oE/HxUa28g4wRX3
         3mVWW7i/M6gCxftMrgz6F/UJRaSYmO7xSqdPWBuMob1ZSnOo5nvD19zP9HoiuB0leXZh
         oZF0EB6cneSUt5e4KZqzkSIJ34IwgYHA00Da12UK8QZGNlKqzYoONmQw4dvAYi/m9f+v
         sWbSXtSjOw0nwMd1y4kbz2bFqC7J5rQpEhs0nbJeT+g5STINgzbXAJzCgfCPlZmfz+qU
         TO6aiszANdzV6VE9QHDqbB4aRECF6jbfq4lVWmV6ypS8PoLvdcoSnj1pnnd3grNylYMO
         MOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889691; x=1790494491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nzImtRCLEOk3zqgss+ECzroPEOpVx7SLulh8ddX6bHw=;
        b=Y5ilkI/3fyMCIguOt3BphUWk7iEtnF9Y/lVfQqALihAD/2fv3eS48cBF3RJsn9psvT
         +Jz6+mioFj8Sxpyps5B8d5XBMAbzhzXC0TYD2fzoB/Bm7DOrNgcFhiLXrIT+EEUR4BM3
         Pmc/xoznrbTg+ZBtDeBomds4wZwsKu6PQ0v1b/wq17GsQrpI299/FSFmLxDgNkLqDWGr
         zEbdPpGBJzATH+DgoGUmZWNB884k5w9qi9JOJgh8FNjYHPLNMQEMPHUlPktjjNsLA9dB
         41NPjP1WhgaX1ZlUZ6NjWMgbdo/0NglJ2oH3zinJjLHEPhvtdu6YW96Q6MEg9XiJeaps
         xapA==
X-Forwarded-Encrypted: i=1; AKwUvBz88/MJB2db2nLNnHUS0PI0K70Gvi1OQPRCz0Mk/OaD9aZgDWULP42qn+iWGF11ZdQhGCSH9hU=@vger.kernel.org
X-Gm-Message-State: AFuF++lgD8ELz6+Q/VtUzrDWCyG8a0t/ZdK5gGyTqHJzngQlE+mUN+RR
	rJJdhZJKmgXZ50hOt0lrvuV6YFzKuWDEM0kjGwAFPLwSYvGpidLl/zVj
X-Gm-Gg: AYBFou0WMPE3fDxyg+ThFuzYOP1zAJLAxBnE9zXlEVLSnQNW98PA5iiIRBWkAdmUzvB
	dzCsT8VbLwY7M9D1Jb3G8Md3jUqGPI4QoUGTPS/HKfZTGUL34MHWaiEn0mvvv9D59ltFt4AJEDL
	9h5wpecDvc/0o06pmP9hmYdSaWtPe29tGr67vZ9KSs0BUo4Seht45cbNn9aro9JJZ2rof6RLnx/
	Et5wjwuWO5LlWiYl7vnzDeMiH/X76WyJOCS7u6zcn+UA9xx7BvyqpX3J0VDz7iSJ1DmyHZK5/Eh
	SqZLoWdU5p9Z60NWuX1PyHmvClpjVzOMSfONzwHs5Qmm7l0I5pX5Yxs3AIvHs0rjlve27pg6QFi
	UsGtgbCWDQRpbnOSiMZjWO0xGTAa2bsEz6a0JEf5oBQTANIootjSrUy0cVDE6vyr6+Lf5tCNYef
	Iu8KKcYXZlg0s1M+UJwLl9UR/LgYbkGRec4NDVQDRvpnZZZjpWbkG8gjGvCBNoHZMNfVg4qw8W7
	qvjgRT1eLbPt8DVLBgsMBeFb68LpxTe73H7fzwmM+IidR4rE5mY2i+GcSMoiV3MJVmTL3MAegHJ
	I8mOyN3enTM=
X-Received: by 2002:a05:6a00:1815:b0:874:919e:d6da with SMTP id d2e1a72fcca58-874dd5f0fd3mr12084288b3a.18.1789889690773;
        Sun, 20 Sep 2026 00:34:50 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm1716959b3a.2.2026.09.20.00.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:34:49 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH net 0/2] tipc: fix connection lifetime during netns teardown
Date: Sun, 20 Sep 2026 15:34:40 +0800
Message-ID: <20260920073440.64223-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789722780.git.xuyuqiabc@gmail.com>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Thanks for the review. We verified each point against the tree with
1/2 and 2/2 applied (net/tipc/topsrv.c line numbers below are from
that tree).

=== sashiko: [patch 1/2] infinite spin / softlockup ===

> Infinite spin loop and softlockup in tipc_topsrv_stop() when waiting
> for connections with pending work items to close: loop
> `for (id = 0; srv->idr_in_use; id++) { con = idr_find(...) ... }`
> holds `spin_lock_bh(&srv->idr_lock)`; when `con == NULL` the lock is
> not dropped before continuing -> spins ~2^32 times.
> locations: net/tipc/topsrv.c:713 tipc_topsrv_stop;
> net/tipc/topsrv.c:133 tipc_conn_kref_release.

Correct, and this is precisely the failure this series fixes. In the
pre-patch code the walk is:

	for (id = 0; srv->idr_in_use; id++) {
		con = idr_find(&srv->conn_idr, id);
		if (con) {
			conn_get(con);
			spin_unlock_bh(&srv->idr_lock);
			tipc_conn_close(con);
			conn_put(con);
			spin_lock_bh(&srv->idr_lock);
		}
	}

When `idr_find()` returns NULL the loop keeps incrementing `id` while
still holding `idr_lock`. Any connection whose last reference is being
dropped in tipc_conn_kref_release() then blocks forever on
spin_lock_bh(&s->idr_lock), so `srv->idr_in_use` never reaches zero
and the CPU spins under the lock. That is the
`__radix_tree_lookup -> tipc_topsrv_exit_net` RCU stall in the crash
log of the cover letter.

2/2 rewrites exactly this walk:

	for (id = 0; srv->idr_in_use;) {
		con = idr_get_next(&srv->conn_idr, &id);
		if (!con || !kref_get_unless_zero(&con->kref)) {
			spin_unlock_bh(&srv->idr_lock);
			cond_resched();
			spin_lock_bh(&srv->idr_lock);
			id = 0;
			continue;
		}
		id++;
		spin_unlock_bh(&srv->idr_lock);
		tipc_conn_close(con);
		conn_put(con);
		spin_lock_bh(&srv->idr_lock);
	}

i.e. it uses idr_get_next() and, whenever no entry can be taken, drops
idr_lock, reschedules and retries, so a pending
tipc_conn_kref_release() can always make progress and the loop cannot
spin under the lock. So the finding is correct for 1/2 standing alone
but is fully addressed by 2/2; no further change is needed for this
point.

=== sashiko: [patch 2/2] sock_release() in atomic context ===

> `sock_release()` called in atomic/softirq context:
> `tipc_sub_timeout()` (timer softirq) -> `tipc_topsrv_queue_evt()`
> -> `conn_put()` -> `tipc_conn_kref_release()` -> `sock_release()`
> sleeps (`lock_sock()`), sleep-in-atomic.
> locations: net/tipc/subscr.c:110, net/tipc/topsrv.c:322,
> net/tipc/topsrv.c:120.

The chain is not quite as drawn. tipc_conn_kref_release() does not
call sock_release() unconditionally: it already has `if (con->sock)`
(line 134), so in-kernel connections never take that path.

For socket-backed connections the remaining sleep-in-atomic concern
is real but narrower than the chain suggests, and this series does
not change it:

- tipc_topsrv_queue_evt() only calls conn_put() synchronously on its
  error path (line 340): the connection is no longer connected after
  the lookup, kmalloc fails, or queue_work() returns false because
  ->swork is already queued. On the normal path the lookup reference
  is handed to tipc_conn_send_work(), which runs in process context
  and does the final conn_put() there.
- So the remaining sock_release() in timer softirq only happens when
  that specific conn_put() drops the last reference of a socket-backed
  connection, i.e. when the connection is being torn down concurrently.
- Neither 1/2 nor 2/2 touch subscr.c, tipc_topsrv_queue_evt() or
  tipc_conn_kref_release(). 1/2 only detaches the listener and cancels
  srv->awork; it does not touch the subscription timer path.

So this is pre-existing and orthogonal to the two patches, not for
this series. A separate follow-up could avoid dropping the last
reference for a socket-backed connection from softirq; that would be
a separate patch.

=== sashiko: [patch 2/2] NULL deref in tipc_conn_close() ===

> Unconditional `con->sock->sk` deref in `tipc_conn_close()` panics for
> in-kernel subscriptions (`tipc_topsrv_kern_subscr()` passes NULL sock
> -> `con->sock == NULL`); `tipc_conn_kref_release()` checks
> `if (con->sock)` but `tipc_conn_close()` does not.
> locations: net/tipc/topsrv.c:158 tipc_conn_close,
> net/tipc/topsrv.c:724 tipc_topsrv_stop.

This one is a valid latent bug, and we agree with the asymmetry:
tipc_conn_close() does `struct sock *sk = con->sock->sk;` (line 158)
unconditionally, while tipc_conn_kref_release() guards its
sock_release() with `if (con->sock)` (line 134).
tipc_topsrv_kern_subscr() really does allocate with sock == NULL
(line 587) and such a connection is inserted into conn_idr, so if one
is still there when tipc_topsrv_stop() walks the idr, 2/2's loop calls
tipc_conn_close() on a connection whose con->sock is NULL.

About reachability in the netns teardown path: the in-kernel
subscriber is created from tipc_group_create() (net/tipc/group.c:190),
and it is normally removed synchronously by tipc_group_delete() ->
tipc_topsrv_kern_unsubscr() when the owning socket is released
(tipc_release() -> tipc_sk_leave()). Since the socket holds a net
reference, netns teardown cannot overtake that. The NULL deref
therefore needs a kernel connection that is still in conn_idr at stop
time, e.g. when tipc_topsrv_kern_unsubscr()'s two conn_put() calls do
not drop the last reference because a pending con->swork still holds
one. That is a narrow race, not the common path.

It is also pre-existing: the pre-patch loop already called
tipc_conn_close() on every entry found in conn_idr, including
sock == NULL kernel connections, so 1/2 + 2/2 do not introduce it.
(kref_get_unless_zero() in 2/2 only narrows the
already-dropped-reference window; it does not dereference con->sock.)

Orthogonal to this series. A separate follow-up could mirror
tipc_conn_kref_release()'s check in tipc_conn_close(), i.e. skip the
con->sock->sk access when con->sock == NULL; that would be a
separate patch.

Best regards,
Yuqi Xu
