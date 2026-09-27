Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275B24A078;
	Sun, 27 Sep 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521193; cv=none; b=OGC9Lapcs8bn63y+urPay7C5vfaLsZfjSGbQ3KT7sFJQPuA+IPmykPVlPRxS2dQuYRjmHq0hmCUJNo4KkkKG/xZz/VrXNXfCAUmUyJT4clhLnGvK+iZxhaTt0vas6QlRX/uztmOy7B0s9sp3vtJRCgn6XhW6t8snFLEkNrf1KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521193; c=relaxed/simple;
	bh=XZg2qcKTBZzvJ64C1avQwRP07cBGZyZOp5v0Ww+I/RQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cy7b8+Ff2ditMJaUpy9CN9P3bj4Djd5XV09E8690XRbaVprAJ7C7oUQpatML+Iz3ahLZu9Q0XZL7yCZKQ9GwcPeQvtQ+phW9BuhxKfvydxw1NeRiDLVCsdmt2Ii76d9PaN95MbwCYa9c9tL2l26RfNTU+Rhm4tLKMN+EWbMsbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgUpVUqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgUpVUqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC391F00893;
	Sun, 27 Sep 2026 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521192;
	bh=FnDHmjC6qI6pSsVrhkJqLDNzaddQ8I++Pcj0dlfb+ME=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XgUpVUqwOjZipNxRWnoOtjsf2V1vH80GOn1fRmSEkQBMF5q9DF/AOxC+hJYU/AvSh
	 oki4dxbbx4URrRK7dM/BY0gpfOnCCxq3qxMtQdVIaFlcP6g7aaxcWTo+nolqW8ivbx
	 u3PyllrLErTbW/GS6Y96QPP1xqJjDPFnXD/usCm5ZF0Q6TyPOILm/wv+XTycYgf567
	 NEt+2vDBDO62vUAvMzCWfPR5LVHHVQNCUL0Qk1VqL9obwmCnW9dQx5/2QmAgHfLDGh
	 YsW3bEfdhSpeXsTX38dTNW7xrnE8kQe3KDjVTurtOzUN9mnFjyX4FFjPCS2+rrYHIa
	 0n3qGEvP2502A==
Subject:
 Re: [PATCH net v11 05/17] afs: Fix afs to abort the rxrpc call on send error
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:50 +0000
Message-ID: <179052119087.2160803.7747904167170153027@kernel.org>
In-Reply-To: <20260923133706.1496540-6-dhowells@redhat.com>
References: <20260923133706.1496540-6-dhowells@redhat.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When sending a reply fails on an incoming cache-manager (CB)
  service call, the afs_call is never completed.

--

afs: Fix afs to abort the rxrpc call on send error

This patch makes afs_send_empty_reply() and afs_send_simple_reply() abort
the rxrpc call on any send error, not only on -ENOMEM. It also makes
afs_make_call() abort on any send error. The afs_abort_oom trace reason is
replaced with afs_abort_send_error.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index bcb8bb15d471d..c38458157eccf 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c

[ ... ]

> @@ -869,22 +868,12 @@ void afs_send_empty_reply(struct afs_call *call)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= 0;
>  
> -	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
> -				       afs_notify_end_reply_tx)) {
> -	case 0:
> -		_leave(" [replied]");
> -		return;
> -
> -	case -ENOMEM:
> -		_debug("oom");
> +	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
> +				     afs_notify_end_reply_tx);
> +	if (ret < 0)
>  		rxrpc_kernel_abort_call(net->socket, call->rxcall,
> -					RXGEN_SS_MARSHAL, -ENOMEM,
> -					afs_abort_oom);
> -		fallthrough;
> -	default:
> -		_leave(" [error]");
> -		return;
> -	}
> +					RXGEN_SS_MARSHAL, ret,
> +					afs_abort_send_error);
>  }

[Severity: High]
Is the afs_call still abandoned here when the send fails? The rxrpc call
is aborted, but nothing calls afs_set_call_complete(), so the afs_call
stays in AFS_CALL_SV_REPLYING. afs_send_simple_reply() has the same
pattern.

The commit message says the change stops "otherwise abandoning it". That
is true for the rxrpc call, but it does not seem to hold for the afs_call.

The only way out of SV_REPLYING is afs_notify_end_reply_tx():

    afs_set_call_state(call, AFS_CALL_SV_REPLYING, AFS_CALL_SV_AWAIT_ACK);

That callback only runs once the final DATA packet has been queued, and
that does not happen on a send error.

A later notification (from this abort or from a received abort) goes
through afs_wake_up_async_call() -> afs_process_async_call() ->
afs_deliver_to_call(). The loop there does not handle SV_REPLYING:

    while (state = READ_ONCE(call->state),
           state == AFS_CALL_CL_AWAIT_REPLY ||
           state == AFS_CALL_SV_AWAIT_OP_ID ||
           state == AFS_CALL_SV_AWAIT_REQUEST ||
           state == AFS_CALL_SV_AWAIT_ACK
           ) {

None of the CB call types has a ->done hook. So the drop_ref reference
set by afs_charge_preallocation() is never released, because only
afs_set_call_complete() drops it.

If that's right, the afs_call leaks along with its rxrpc_call, peer and
server references and its buffers. net->nr_outstanding_calls would then
never reach zero, and afs_close_socket() would block forever here during
netns teardown or module unload:

    wait_var_event(&net->nr_outstanding_calls,
                   !atomic_read(&net->nr_outstanding_calls));

A remote peer seems able to trigger this. It can send CB.Probe or
CB.CallBack and abort right after the last request packet. Then
SRXAFSCB_Probe() -> afs_send_empty_reply() -> rxrpc_kernel_send_data()
returns -ESHUTDOWN, and rxrpc_kernel_abort_call() does nothing.
-ENOMEM from txbuf or txqueue allocation leads to the same state.

afs_abort_service_call() in fs/afs/cmservice.c already pairs the two
steps:

    rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
                            abort_code, error, why);
    afs_set_call_complete(call, error, 0);

Should the send-error paths in afs_send_empty_reply() and
afs_send_simple_reply() also call afs_set_call_complete(call, ret, 0)
after the abort? No later patch in the series changes these two
functions.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com
