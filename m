Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D83D6CDE;
	Sun,  4 Oct 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146756; cv=none; b=ZpqgFr+n5Dyp44h3CLdvnwCzhKcrmDKI7QN1dGu6WFkZ9kPuzgRFoq/PgWI7ZMttY3LK5EP6jW7aoWXOgh4wZ418MzAlR4rnFbQnOlnrEMgtCuif74LCqYaNc6dHd5RNni68SXDv7muQkZRma/I77QVS+SguVDUuAJuy2+w2gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146756; c=relaxed/simple;
	bh=AZ/Id6ZYC0nEjD0j7yvd+4hstmqkPbdt1uKeJgEDyso=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tGT0o5IdNrE3GGtq+IGaVrlqA74PeirqV5DcIok0PZO6vUJdiSnY4dTsZN5JWF52S0uhtNOehSTZXSRsYQ4MqKDAHb8QBhFjHXbQrSRVFXzSKqIejp43YeeGc5L9nkQjGtA5xrqR3gNDYr3RddjT0hv1/AwMSjg6pUOzaOApXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=iEMMcRcL; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="iEMMcRcL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NPvZyu0myKxwG9F9SdBTbUKeFJxAzSnA3inj1//jMKU=; b=iEMMcRcLJ2Es5+AJxeSY9pECgF
	O5lJXFX7M68SifImCdrXLROlV4JWBEJuJ/3Y0R3yBl5dZxoQ61XNUvHt9SB6dCIaK9E5Lv55uJhAH
	/45n9FViOOWqgg0CIr/jmPsL01K17XBQT/75WUj+yYvNOl2ogy3m5SEssP1/Vp2yK4mGxsdmGmbnU
	uxt0d5WbYc/2UDzbPDmZeLn/tz2o4b1eGLBjmwW3Ho9mdTOEeRKBTqOEGA8pih1OVx2NdaFZ4Ey49
	Hhoh7+PF9YuXljfXBUGkz7QRWyVmi4Y8HenQt+WlTgD1vcpAMwN7ARNG8YXONwJV3UiS4Zw5EdVAv
	mhvh3n8w==;
Received: from [::1] (port=59926 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xDT5k-000000075yp-3Wxn;
	Sun, 04 Oct 2026 22:45:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Oct 2026 22:45:52 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: netdev-bot+sashiko@kernel.org
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] tipc: fix use-after-free in netns teardown
In-Reply-To: <179114204389.434549.3724053905057286143@kernel.org>
References: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179114204389.434549.3724053905057286143@kernel.org>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <be98434488231b3464631e6df78a5b5a@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-04 21:27, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> 
> Can restarting from id 0 on every pass livelock the teardown?
> 
> rcv_wq is an ordered workqueue:
> 
> tipc_topsrv_work_start()
>     s->rcv_wq = alloc_ordered_workqueue("tipc_rcv", 0);
> 
> Take a lower-id connection A whose rwork is queued behind the running
> rwork of a higher-id connection B. The loop closes A, but the reference
> held by A's queued rwork keeps A in conn_idr. On every later pass
> idr_get_next() returns A again, so the loop never reaches B.
> 
> tipc_conn_recv_work() keeps running while B is connected and requests
> keep arriving:
> 
>     while (connected(con)) {
>         if (tipc_conn_rcv_from_sock(con))
>             break;
>     ...
> 
> The cond_resched() here gives up the CPU. A's work still cannot run on
> the ordered queue until B's worker returns. If B's receive queue never
> empties, idr_in_use never reaches 0 and cleanup_net() spins.
> 
> The old loop advanced with id++. It would have cleared CF_CONNECTED on 
> B,
> which ends B's worker.
> 
> Local peers probably cannot keep this going. The listener is bound with
> TIPC_NODE_SCOPE, and local user sockets hold a reference on the netns.
> 
> Remote peers are another matter. tipc_net_ops is registered before
> tipc_topsrv_net_ops, so the bearers are still up when 
> tipc_topsrv_stop()
> runs. The TIPC_LISTEN branch of tipc_sk_filter_connect() has no scope
> check. A remote node that knows the listener's port id might be able to
> connect and keep sending TIPC_SUB_CANCEL requests. That precondition 
> has
> not been confirmed.
> 
> Would it work to first walk forward through all entries, using
> idr_get_next() from id + 1 and closing each one? The loop could then
> retry from 0 only for the entries still waiting on asynchronous 
> release.

This looks like a valid concern. I will address it in a v2.

> 
>> +		if (con && !kref_get_unless_zero(&con->kref))
>> +			con = NULL;
>> +		spin_unlock_bh(&srv->idr_lock);
>>  		if (con) {
>> -			conn_get(con);
>> -			spin_unlock_bh(&srv->idr_lock);
>>  			tipc_conn_close(con);
> 
> [Severity: High]
> 
> This is a pre-existing issue, but can this call to tipc_conn_close()
> dereference a NULL con->sock?

Indeed, Sashiko is right. I reproduced it.

I will fix it in a seperate commit in the v2, by guarding 
tipc_conn_close()
behind a check on con->sock:

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9..01dd34b 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -706,7 +706,8 @@ static void tipc_topsrv_stop(struct net *net)
                 if (con) {
                         conn_get(con);
                         spin_unlock_bh(&srv->idr_lock);
-                       tipc_conn_close(con);
+                       if (con->sock)
+                               tipc_conn_close(con);
                         conn_put(con);
                         spin_lock_bh(&srv->idr_lock);
                 }


> tipc_topsrv_kern_subscr() creates conn_idr entries that have no socket:
> 
>     con = tipc_conn_alloc(tipc_topsrv(net), NULL);
> 
> tipc_conn_close() dereferences the socket before it tests CF_CONNECTED:
> 
>     static void tipc_conn_close(struct tipc_conn *con)
>     {
>         struct sock *sk = con->sock->sk;
> 
> Other code in this file already allows for a NULL sock.
> tipc_conn_kref_release() checks if (con->sock). 
> tipc_conn_send_to_sock()
> only calls tipc_conn_close() inside its if (con->sock) branch.
> 
> Here is a possible sequence:
> 
> 1. tipc_topsrv_queue_evt() takes a reference on a kernel subscription
>    connection K through tipc_conn_lookup(). It then queues K->swork on
>    send_wq.
> 
> 2. Before that work runs, the group socket is closed:
>    tipc_release()->tipc_group_delete()->tipc_topsrv_kern_unsubscr().
>    This clears CF_CONNECTED and drops two references. K stays in
>    conn_idr, held only by the swork reference.
> 
> 3. cleanup_net()->tipc_topsrv_exit_net()->tipc_topsrv_stop() runs.
>    cancel_work_sync(&srv->awork) does not drain send_wq. idr_get_next()
>    returns K, kref_get_unless_zero() succeeds, and tipc_conn_close(K)
>    dereferences NULL.
> 
> The old idr_find() plus conn_get() loop had the same exposure. The new
> loop retries until idr_in_use reaches 0, so any socketless entry still 
> in
> conn_idr is now guaranteed to reach tipc_conn_close() at least once.
> 
> This loop is being rewritten anyway. Could it skip tipc_conn_close() 
> when
> con->sock is NULL? Alternatively, tipc_conn_close() could check
> con->sock before using it.
> 
>>  			conn_put(con);
>> -			spin_lock_bh(&srv->idr_lock);
>>  		}
>> +		cond_resched();
>> +		spin_lock_bh(&srv->idr_lock);
>>  	}
> 
> [ ... ]
