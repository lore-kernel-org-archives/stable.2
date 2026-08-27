Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61135E92F;
	Thu, 27 Aug 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857650; cv=none; b=UfZ+w5+Bcditc9DZbaUSg70vlVttRmFAFgeQ5dixKslrS20WWz/xURyU7ikFN2v8sZIcFUoTEWxR6y6dipPp82YOV9UmvYleKejNEp9aPBofY1KCFEneRJ2MwaR4i8GtDqWR/MvZkDzlfSsp9+bk9tNYSZQ4/9QTXq0pWD1uGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857650; c=relaxed/simple;
	bh=DSn0ma3Qi+XtwTridfdh6NoDaL2K1Odlyl3IwP5p1dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwkMhM6WEwI6ZT3JjjAtY08VcMLJuKofvZr9r+1iZ0Mxa70yL2wGCshc+CBgD4KVZDuGjfKXeN4UPP9AA+l4aFATaesm/tal9xSwWvllGi4bJinsRd1tA4GRlOhlRzNBHpfUgHyRyf+gcnjImorH1SNSByuuOxuh4J1a435+Apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr8CD/7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr8CD/7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE71F1F00A3A;
	Thu, 27 Aug 2026 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857646;
	bh=iBkYeummI34nAqq6+DERujsvtytAadaXjAGlle7z6xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dr8CD/7SK29RwWEh4K+kq8/ufcemRSfUIahE9cnQmwKgyr3uvbjogu64+XRBxMHmy
	 g1R+xB014OWA0VM73WVu+B89QMTrGD3khKlZvmYcWc5dYDflVQ7woUKa7AY+IjuKR5
	 Kwez23s+zWaE8dErJejxoHXIMf92rajbP1t067GCfZoQaKye2V/ISe/rK4DLARh2O7
	 Rr0GjF8vsIEm7YTmw1h+kp5RN4fUH6zgoQLok7LUktMk4TgKiBBG8elZVV1KptX4hE
	 Jo6B1eiI0P/mkH79oVHfCwFelG8AN1r/cfpGevh0rW7DPo71+npzW+Q6zcGoSgkEmV
	 IXi+7lKNXSkKw==
From: Jakub Kicinski <kuba@kernel.org>
To: matttbe@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 02/14] mptcp: subflow: no need to copy thmac during ulp_clone
Date: Thu, 27 Aug 2026 12:07:25 -0700
Message-ID: <20260827190725.3998222-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-2-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-2-a92309d121ca@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
mptcp: subflow: no need to copy thmac during ulp_clone

This drops the copy of subflow_req->thmac into the new subflow context in
subflow_ulp_clone(), since the truncated HMAC is no longer needed once the
passive-side request is over.  The commit message notes that thmac is left
uninitialised on the SYN cookie path, so removing the copy also avoids a
KMSAN uninitialised-read report.

(no Link: tags in the commit header)

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af81ad5e699d1..01db7edce18a6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -2084,7 +2084,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
>  		new_ctx->request_bkup = subflow_req->request_bkup;
              ^^^^

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the
neighbouring store: does request_bkup have exactly the same
uninitialised-on-SYN-cookies problem that motivated removing the thmac
copy here?

subflow_init_req() only clears a subset of the fields:

net/mptcp/subflow.c:subflow_init_req() {
	subflow_req->mp_capable = 0;
	subflow_req->mp_join = 0;
	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
	subflow_req->msk = NULL;
	mptcp_token_init_request(req);
}

and the only assignment of request_bkup for a request sock happens on the
SYN, in subflow_token_join_request():

	subflow_req->local_id = local_id;
	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);

On the cookie ACK path that function is not called, and the state restore
does not cover request_bkup either:

net/mptcp/syncookies.c:mptcp_token_join_cookie_init_state() {
	subflow_req->remote_nonce = e->remote_nonce;
	subflow_req->local_nonce = e->local_nonce;
	subflow_req->backup = e->backup;
	subflow_req->remote_id = e->join_id;
	subflow_req->local_id = e->local_id;
	subflow_req->token = e->token;
	subflow_req->msk = msk;
}

struct join_entry has no request_bkup member at this commit, so the bit
carries whatever was in the freshly allocated request sock.

Unlike thmac, the copied value is consumed afterwards, for instance in
mptcp_subflow_get_send() and mptcp_subflow_get_retrans():

net/mptcp/protocol.c:mptcp_subflow_get_send() {
	bool backup = subflow->backup || subflow->request_bkup;

It is also put on the wire by mptcp_established_options_mp_prio() and
exported to userspace by the mptcp diag code.

So when a remote MP_JOIN is accepted while tcp_syncookies is active, can a
joined subflow end up randomly flagged as backup and reported that way in
diag, along with the same class of KMSAN uninit-value branch report that
this patch removes for thmac?

For the record, the next patch in this series, "mptcp: syncookies: remember
the request backup flag", adds request_bkup:1 to struct join_entry and
stores/restores it, and the store happens after subflow_token_join_request()
has set the field (subflow_token_join_request() runs before
subflow_init_req_cookie_join_save() in subflow_check_req()), so the field is
properly initialised at the end of the series.  Would it be worth mentioning
that dependency here, given this patch carries a Cc: stable tag?

>  		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
>  		new_ctx->token = subflow_req->token;
> -		new_ctx->thmac = subflow_req->thmac;
>  
>  		/* the subflow req id is valid, fetched via subflow_check_req()
>  		 * and subflow_token_join_request()
