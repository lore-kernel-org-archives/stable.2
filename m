Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050469;
	b=TpUVgwcdL/55IN9nYYvx66pIzttzJd1po7cPuoXqoq5JwdgtBzI4AGOOMRZevSIwjxoE
	 7SnCbbFnYHnkJ0EVrmcdrKlY3h5D1cWsVBFsod86WZ+C5DMV4D8CpLh/JsctGxUe32soq
	 8b6Qe+XNEWe1nMGdi3D9Hy4Lj3N20kwfaMdSnrrlTu/pZLpRBn1Y8GI1cGLb/UjZvYQJX
	 fIK/g3q8bSxH+k0JPnf0kX0PPLN0dIuxc35w0c9VazWDE1TNlGFVpeWUVFzWfuhDg5YKg
	 +D5vPyY1ESnxpf77RHEsFCrrMCtW9q3yz2y13C9bVxMPJTGwnkk8h/ZzEoPbkxc8lDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1s8YY3NNAO/dF0a6YTQ7X/lGKSe+gP52UoPXmf9iK04=;
	b=PhjkUK+Rig4BIrGeqQ+rPOxjs8+WAtf6ugHtKnZaaChSbolPoYVBFIF3G+eKnTe/ynN0
	 5V4wKTQd9Y0B81y+BIVks8R51ojHuHO5kuFnyDyUNdJTQjep7QykzNmPidRVEyBWmvQBj
	 bdLGLjN/a3y9SSWN4uOhXv3W5bLfi59wKnkqaz26NPYM2nOdmSZzrLs7Q4jow1EO1YGPr
	 yy8uFQIb/at6eUnXHgXk5FnUlXYYTQIxW8QTKFiXbnQU0OjdCWyuwN+HCMdHJC7jq7hjh
	 jCXXINj4rpLMqEoogA4CWobBTlixUkwmrVJhaUYyhZ4UDGvA8GpWbB5R/k/lQWi0+yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke7GtxA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07014606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ke7GtxA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F51E1F0089F;
	Sat,  7 Nov 2026 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050468;
	bh=1s8YY3NNAO/dF0a6YTQ7X/lGKSe+gP52UoPXmf9iK04=;
	h=From:To:Cc:Subject:Date;
	b=Ke7GtxA993KcM14aRPQPCjccKD8utZSBUIbIqmPkrIteir0ahIWJxyV6ad9lRauw+
	 SLbdkVE+JlQ8Ee3ANnUUWcp271wF8C/AFZswaQHgrvhRAaeG3YR6mXE/TAZU8zHN6s
	 d+KrdDli4MS/A1XxHYuO9BnZY4uZGClCJmtZkMO3ZDEwuoVtvi7YSlxNWk+1oRhVmu
	 RwC/BWP5YhV9c1HdGHog7X8waC15yXFIj0fIrxKjIFG3VVkLCJ/eyMbx/dq+SIosth
	 FVTwL8BxLJ7aNm3eLeWqo+CEjDl+iwRxRKCpysmdjrNV/6//4apeknwzbk35pjVFw6
	 K+BGGvfAELwiQ==
From: Sasha Levin <sashal@kernel.org>
To: tmenninger@everpuredata.com,
	cel@kernel.org,
	anna.schumaker@hammerspace.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xprtrdma: prevent disconnect feedback during endpoint teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:07 -0500
Message-ID: <20261107062106-failed-5.10-0b5bb4e586f7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0b5bb4e586f7b0a449f4d90a524f76a3be5db355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062106-failed-5.10-0b5bb4e586f7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0b5bb4e586f7b0a449f4d90a524f76a3be5db355 Mon Sep 17 00:00:00 2001
From: Tim Menninger <tmenninger@everpuredata.com>
Date: Thu, 24 Sep 2026 20:34:40 +0000
Subject: [PATCH] xprtrdma: prevent disconnect feedback during endpoint
 teardown

xprt_autoclose() clears XPRT_CLOSE_WAIT before invoking the transport's
->close() operation. For RPC/RDMA, ->close() calls
rpcrdma_xprt_disconnect(), which disconnects the RDMA CM endpoint and
drains its QP.

Since commit 31e62d25b5b8 ("xprtrdma: Simplify RPC wake-ups on
connect"), RDMA_CM_EVENT_DISCONNECTED requests a SUNRPC transport
disconnect. Today that path, along with failed completion handling,
reaches xprt_force_disconnect() through rpcrdma_force_disconnect().

Commit c487eb7d8e41 ("xprtrdma: Clean up disconnect") later added
re_force_disconnect to ensure that multiple failure indications request
only one SUNRPC disconnect. However, the gate remains open when SUNRPC
itself begins endpoint teardown.

If re_force_disconnect is still clear, either a CM disconnect event or a
completion error can set XPRT_CLOSE_WAIT again while the current close
is in progress. When the transport send lock is subsequently released,
xprt_clear_locked() observes XPRT_CLOSE_WAIT and queues another
autoclose.

Requesting a disconnect this way is necessary when a connection is lost
unexpectedly, but not when the event was generated by
rpcrdma_xprt_disconnect() itself. In that case SUNRPC is already
committed to closing the transport.

Mark re_force_disconnect before initiating local endpoint teardown so
that CM events and completion errors caused by that teardown cannot
request another close. An unexpected error that wins the race before
local endpoint teardown begins can still request a disconnect normally.

Use a fully ordered exchange so that the gate is globally closed before
rdma_disconnect() can transition the QP to error and generate the
callbacks that the gate suppresses.

In 30-second traces of a sustained recovery loop, without this change
there were 7,693 xprt_force_disconnect() calls, 6,267 SUNRPC autocloses,
and 172,892 receive-side IB_WC_WR_FLUSH_ERR completions. With this
change, the same tracepoints recorded 3,512 xprt_force_disconnect()
calls, 3,212 autocloses, and 131,287 receive-side flush completions.
Thus QP teardown continues to produce flushed completions, but closing
the disconnect gate before teardown substantially reduces their
feedback into the SUNRPC close path.

Fixes: 31e62d25b5b8 ("xprtrdma: Simplify RPC wake-ups on connect")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
---
 net/sunrpc/xprtrdma/verbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index be335eed329d1..54957295a6310 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -114,9 +114,9 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_ep_put(ep);
 }
 
-/* Ensure xprt_force_disconnect() is invoked exactly once when a
- * connection is closed or lost. (The important thing is it needs
- * to be invoked "at least" once).
+/* Ensure xprt_force_disconnect() is invoked at most once for an
+ * unexpected endpoint failure. Local endpoint teardown closes this
+ * gate before it can generate CM events and flushed completions.
  */
 void rpcrdma_force_disconnect(struct rpcrdma_ep *ep)
 {
@@ -587,6 +587,9 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	if (!ep)
 		return;
 
+	/* Prevent teardown-generated events from requesting another close. */
+	atomic_xchg(&ep->re_force_disconnect, 1);
+
 	id = ep->re_id;
 	rc = rdma_disconnect(id);
 	trace_xprtrdma_disconnect(r_xprt, rc);
-- 
2.53.0




