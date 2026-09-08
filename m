Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600903BE161;
	Tue,  8 Sep 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900591; cv=none; b=rylaRFC4as+R/x/ftDlRwBhqX0dxI8PCdcl6HEMdz2VYakToJUk8AHiu1e45N7e09JqIHqwtxCdv/Qn7xulVDDhMpBmdcPNXn+PN2oER5FH8igE+25YuJ6pwXxjWrKqmzAWQvNX6khf489vbxbUigVJMFxs9jxuJma5tVs4Fqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900591; c=relaxed/simple;
	bh=rr7jP+o/tIaaCSap9FFxWMlaWxzojrUoAJqp/8FaPWo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cUPQFfDBAYFudKrfSnge00TDxoP5LOM5OVevxKJjT5YJgku6KeIGLQFeIdl0fLA9wQTUbKqEfnFBwphWe09O2I6wIfFzlnBDGtKjktymyP4zXWuDs0o/iCq1cL7hNEhOSlNu133xppESL+J05ZPEohSYz2E6ixTPMCuX6xZDJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKZStkGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKZStkGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9872A1F00A3D;
	Tue,  8 Sep 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900590;
	bh=hOZVNgdTCozarcIysVBxcpzcU0zYCoCaekkyVWDOn5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NKZStkGJVmOWCiTEJUy6lA/mnTV0lFnER32+5wW1NWICFTcM1rjUEG0LWYc/caZUu
	 A4FQVrtB2fmR/TP74ypwfLLUOntC3IWExdAZ0UnakgrKL4YkMqLTgcMiCPNlHBZ3oB
	 au5tB2E0E8pDn5bMzWP4sg2ag4gH57htAiv1d+OXmsfwRrHah6ip+gLKkZNowCVkmL
	 nfus6JnQJE6uRVqpj/qVQAGR9XGKRR/SYxKcQ08h9mejeUscE8ek8OYd3YPLAs8mxv
	 Nh6ZpI4coM/qnEswyk7FS9KseSOJ35swnSIXs5ET30aHarhVnavzocNDifhVYPZlSA
	 icipXX6MwmPaw==
Subject: Re: [PATCH net v9 12/14] afs: Fix lack of setting call->server when
 doing FS.InlineBulkStatus
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:49 +0000
Message-ID: <178890058914.219967.3574425365873177104@kernel.org>
In-Reply-To: <20260907113743.1453210-13-dhowells@redhat.com>
References: <20260907113743.1453210-13-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] Use-after-free of struct afs_call via the stale op->call pointer
  in afs_wait_for_operation() (fs/afs/fs_operation.c:281-301).
- [Medium] afs_make_op_call() (fs/afs/internal.h:1758) now makes every
  fileserver-operation call hold an *active* count on op->server.
- [Low] Commit message names a non-existent function as the release site
  of the new server reference.

--

afs: Fix lack of setting call->server when doing FS.InlineBulkStatus

This moves afs_make_op_call() further down fs/afs/internal.h so that it can
call afs_use_server(), and has it set call->server from op->server.  A new
afs_server_trace_use_call trace enum is added for the new active count.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> Note that this requires afs_make_op_call() to be moved so that it can use
> afs_use_server(); the server is un-used by afs_free_server().

[Severity: Low]
Should this say afs_free_call() rather than afs_free_server()?  There is no
afs_free_server() in fs/afs; the server teardown helpers are
afs_server_destroyer(), afs_server_rcu() and __afs_put_server() in
fs/afs/server.c.

The active count taken by the new afs_use_server() in afs_make_op_call()
is dropped on call teardown, in afs_free_call():

fs/afs/rxrpc.c:afs_free_call() {
	...
	afs_unuse_server_notime(call->net, call->server, afs_server_trace_unuse_call);
	kfree(call->request);
	...
}

> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 290873bac89b3..65a0866cd8b85 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h

[ ... ]

> @@ -1763,6 +1747,23 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
>  	return &vnode->netfs.inode;
>  }
>  
> +static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
> +				    gfp_t gfp)
> +{
> +	struct afs_addr_list *alist = op->estate->addresses;
> +
> +	op->call	= afs_get_call(call, afs_call_trace_get);
> +	op->type	= call->type;
> +	call->op	= op;
> +	call->server	= afs_use_server(op->server, false, afs_server_trace_use_call);

[Severity: Medium]
Can this leave an idle afs_server with no garbage collection armed?

Every fileserver operation call now holds an active count on op->server,
and the only counterpart drop is the _notime variant in afs_free_call():

fs/afs/server.c:afs_unuse_server_notime() {
	if (atomic_dec_and_test(&server->active)) {
		if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) ||
		    READ_ONCE(server->cell->state) >= AFS_CELL_REMOVING)
			schedule_work(&server->destroyer);
	}
	afs_put_server(net, server, reason);
}

Unlike afs_unuse_server(), this never sets server->unuse_time and never
calls afs_set_server_timer().  So if the call's active count happens to be
the last one dropped, the server sits at active == 0 with no
AFS_SERVER_FL_EXPIRED bit, no armed server->timer and no queued destroyer.

In the synchronous path this doesn't arise, because afs_wait_for_operation()
drops the call ref before afs_put_operation() -> afs_put_serverlist(), so
the last active drop goes through the timing-aware afs_unuse_server().

The async read path has the opposite order:

fs/afs/file.c:afs_read_receive() {
	op->call		= NULL;
	call->op		= NULL;
	afs_put_call(call);
	...
	afs_end_read(op);   /* -> afs_put_operation -> afs_put_serverlist */
}

afs_fetch_data_async_rx() then drops the final call ref afterwards, so
afs_free_call()'s afs_unuse_server_notime() is the last active drop.  If the
volume's server list was replaced concurrently (so afs_put_serverlist() drops
the list's last reference), does the afs_server, its endpoint state, address
list and peer bindings then stay in cell->fs_servers until the cell reaches
AFS_CELL_REMOVING or the netns goes away, rather than after
afs_server_gc_delay?

> +	call->key	= op->key;
> +	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
> +	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
> +	call->service_id = op->server->service_id;
> +	afs_make_call(call, gfp);
> +	afs_put_call(call);
> +}
> +

[Severity: High]
This assignment of op->call is the only producer for the rotation loop in
afs_wait_for_operation(), and that loop never clears op->call:

fs/afs/fs_operation.c:afs_wait_for_operation() {
	while (afs_select_fileserver(op)) {
		...
		if (op->call) {
			afs_wait_for_call_to_complete(op->call);
			op->call_abort_code = op->call->abort_code;
			op->call_error = op->call->error;
			op->call_responded = op->call->responded;
			afs_put_call(op->call);
		}
	}

For a synchronous call, the reference in op->call is the last one
(afs_alloc_flat_call sets ref to 1, afs_get_call() here makes it 2, and the
trailing afs_put_call() above brings it back to 1), so afs_put_call() ->
afs_free_call() -> kfree(call) while op->call still points at it.

Can a second loop iteration then use freed memory?  If the issue function
returns without reaching afs_make_op_call(), the if (op->call) test is true
for the stale pointer, and afs_wait_for_call_to_complete() reads call->state,
call->net->socket and call->rxcall, followed by a second afs_put_call() on
the same freed call.

With this patch, that second put also drops a server active count that
afs_free_call() already released via afs_unuse_server_notime(), so does it
underflow server->active/server->ref too?

The early returns reachable on a second iteration look like:

fs/afs/fsclient.c:afs_fs_inline_bulk_status() {
	if (test_bit(AFS_SERVER_FL_NO_IBULK, &op->server->flags)) {
		afs_op_set_error(op, -ENOTSUPP);
		return;
	}

That NO_IBULK bit only becomes settable because of this patch, since
afs_done_fs_inline_bulk_status() is its sole setter and previously oopsed on
call->server == NULL:

fs/afs/fsclient.c:afs_done_fs_inline_bulk_status() {
		set_bit(AFS_SERVER_FL_NO_IBULK, &call->server->flags);

Two more paths reach the same state: afs_alloc_flat_call() returning NULL
under GFP_NOFS, and the

		else
			op->call_error = -ENOTSUPP;

branch in afs_wait_for_operation() when the newly selected server has no
matching issue_*_rpc.  Getting a second iteration is ordinary control flow -
afs_select_fileserver() returns true again for VBUSY/VOFFLINE, for
RX_CALL_TIMEOUT and for -ETIMEDOUT/-EHOSTUNREACH.

Would clearing op->call before the put fix this, matching what
afs_read_receive() already does with op->call = NULL?

A git diff of fs/afs between this commit and the tip of the series is empty,
so this doesn't look addressed by a later patch in the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
