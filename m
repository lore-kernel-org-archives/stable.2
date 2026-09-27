Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F0547057;
	Sun, 27 Sep 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521202; cv=none; b=s38s08RSAarLA3HLxgzp/9wC+BuycOxrMbPeK3TVvQF21Sjq9RiR9kDljiws4mIuwwYHQ7KNVsIllD4V2xrCDWCHuEvBNDW4x4zxnXVl9y0ORoSqEkuG2eoQekSUs8mxqLT3PV7SE3LWRlAkj4x1DE0cd6cef8edXlTxx7CLhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521202; c=relaxed/simple;
	bh=KU9lv687yNJvnyIhGwj9LN61/fNByfNSPd4BCZpkw00=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9mq9jrOfbgsHvNmZwncXYYUJ4J0SZb9qQTuHbhvAvSh6OtQkn4zOtX/wlmRVwtRS6NrtVAbq+sCDW3h/ZDRYR/Hw7yirkQ3sfbfaj7ZQL1Okuv35crmIdNrtCNsXLm+BTWIqqdjpX4NoC9sk2GrI0QNHBLNfrEO6DvRRD0h8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7XnQXYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7XnQXYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AFC1F00899;
	Sun, 27 Sep 2026 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521198;
	bh=nfRJccmq840w/V9WRvnmSJRzqXpcGB0YL2/Z8nuMMa8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V7XnQXYlsyuxD+V6wKcFZSu4jnbwO1OFRgabPGmrRNFC8LaRTbrXFTsemdMKjsZTp
	 BlvQHFFMyBSGZ3HK+FDLcIdZ9LTf+Ovy63wjQBVjcmhDm7b9NIBt9QCn7YT1X7/gVb
	 Lx0UpDzEuCuM4XMIZPe2YGIXHiYyoiU0qvD26ixRj+py4COS9tCcDBiuvz1Cd+CtNo
	 SG1Ds2pnSITTgl7AY+YOwNDq3VeeGzfCsA5RwdNc3uVy5d0wiYUYOL2m5O5EBA0kqB
	 rS+17Lhs4oUDnQZqY7aWtCTMeVxanRaLTnEzxPbYNyk60ay1wePxuQ25Mww6/cQ4AH
	 zTz9YR972YsIQ==
Subject: Re: [PATCH net v11 15/17] afs: Fix lack of setting call->server when
 doing FS.InlineBulkStatus
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:56 +0000
Message-ID: <179052119696.2160803.18135878260747693344@kernel.org>
In-Reply-To: <20260923133706.1496540-16-dhowells@redhat.com>
References: <20260923133706.1496540-16-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds `call->server = afs_use_server(op->server,
  false, afs_server_trace_use_call)` in afs_make_op_call()…

--

afs: Fix lack of setting call->server when doing FS.InlineBulkStatus

This commit makes afs_make_op_call() take an active count on op->server
and store it in call->server. That stops afs_done_fs_inline_bulk_status()
from oopsing when the server doesn't support FS.InlineBulkStatus. The
function moves further down internal.h so it can use afs_use_server(), and
a new afs_server_trace_use_call trace value is added.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 330654ed16ece..40dc85d9a5c95 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h

[ ... ]

> @@ -1771,6 +1755,23 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
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
Can this leave a server record that is no longer used with no GC timer
armed?

With this change, every op call holds an active count on op->server.
afs_free_call() drops it with the _notime variant:

fs/afs/rxrpc.c:afs_free_call() {
    ...
	afs_unuse_server_notime(call->net, call->server, afs_server_trace_unuse_call);
    ...
}

When active reaches zero on a server that hasn't expired, in a cell that is
still live, afs_unuse_server_notime() does nothing:

fs/afs/server.c:afs_unuse_server_notime() {
    ...
	if (atomic_dec_and_test(&server->active)) {
		if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) ||
		    READ_ONCE(server->cell->state) >= AFS_CELL_REMOVING)
			schedule_work(&server->destroyer);
	}
    ...
}

Only afs_unuse_server() sets unuse_time and calls afs_set_server_timer()
when active reaches zero. Before this patch, op calls didn't pin the
server, so the last active count was always dropped by the server list's
afs_unuse_server().

In the async read path, the call can outlive the op's server list:

afs_fetch_data_async_rx()
  afs_read_receive()
    afs_put_call(call)          <- drops the op's ref
    afs_select_fileserver(op)   <- may afs_put_serverlist() the old list
    or
    afs_end_read()->afs_put_operation()->afs_put_serverlist()
  afs_put_call(call)            <- work item's ref, reaches afs_free_call()

Suppose the volume's server list is replaced while the read is in flight,
for example after a VLDB update or a VMOVED abort, and server X is in no
other list. The old list's afs_unuse_server() takes active from 2 to 1,
which doesn't arm the timer. The call's afs_unuse_server_notime() then
takes it from 1 to 0, which does nothing.

Would server X then stay in cell->fs_servers and on the probe lists? It
would keep being probed and its callbacks would not be given up, until
afs_purge_servers() runs at cell removal or the server is looked up again.
The periodic afs_fs_get_capabilities() probes also unuse with the _notime
variant, so they wouldn't re-arm GC either.

Probe and CM calls already have the same _notime behaviour. This change
extends it to every FS operation call, including async calls that often
outlive their op.

Could op calls be released with afs_unuse_server() instead? Another option
is for afs_unuse_server_notime() to set unuse_time and arm the timer when
active reaches zero on a live server.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com
