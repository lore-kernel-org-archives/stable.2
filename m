Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A13783B4;
	Fri, 28 Aug 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911145; cv=none; b=sAgG5faIykFBMZ/W7wTeVYmsImSbkso4KIiY1NNfi03/7YD9qOHC84nVJyYjcZPM9X1oQOfaVVf5oayghOh/Z2nfGlE9ayNoKsF7ioXBNNah1jY5fbRot7+EEKneSFMEAppJuCG/N7EzctpCjV0vAq1Owjoq6OgwrTDJHoo3rcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911145; c=relaxed/simple;
	bh=rh7ydI7GKJqG6nY9dYE/lkWRfceAJLLwblnkmdTBs90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+lwJPD4ubHFiOWMjQgXEavrJVmLwSn/dsDLzrPFrwr5AIgnf8IWt75ANSFTF4Fsb4B5P0fuDM8cLIwTp7lqTkE+2fhgLvD0ES04JGCLY0GI0idykXbDDViMG5auUxkaD62YWWrOipvOhq9c8oMtaeW1kkj3OrZStDd0biLMLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhfgIKc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhfgIKc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E1E1F000E9;
	Fri, 28 Aug 2026 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911143;
	bh=2+/PLbq9eAr3WZpjlc5dc0ni8rDbxUE+V7YrchB1cDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LhfgIKc7j1RnY8NAmPSkj953ILT5SymGzndUyAhN2IQmM9nruMTa5dI7q/t/DVrXd
	 4PWk1+8AUg7TJA9LMDVHeQ/vc/XBFvgc8Wg/4F+ygYZGoUPSbGyx9xbibnd70Y7udR
	 935JD3KHYzGcOgZ+oGle9Q/wGxayTZC+YsoYIh6pM8gZQfi+7Nfp9qBymjxOC840T5
	 kePJdh6B+W08eYGhJvpF+X7S3/EyOa+pD0ZT4ne3L/FAeo60E+l+tdk52cW83Bqy4j
	 DEMC+l+AXPbXbqdFJnYcyKs9JiPqxgPksGCyS1NhHK5pzgvBcwy/sFPVdkDj6nHT6Z
	 lqwMMfIOK5Aqw==
Message-ID: <b98464cc-5bb4-4dec-a843-0b0931e506e1@kernel.org>
Date: Fri, 28 Aug 2026 11:58:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 02/14] mptcp: subflow: no need to copy thmac during
 ulp_clone
Content-Language: fr
To: Jakub Kicinski <kuba@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-2-a92309d121ca@kernel.org>
 <20260827190725.3998222-1-kuba@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260827190725.3998222-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 27/08/2026 21:07, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thank you for having forwarded this, I didn't manage to look at it before.

> ---
> mptcp: subflow: no need to copy thmac during ulp_clone
> 
> This drops the copy of subflow_req->thmac into the new subflow context in
> subflow_ulp_clone(), since the truncated HMAC is no longer needed once the
> passive-side request is over.  The commit message notes that thmac is left
> uninitialised on the SYN cookie path, so removing the copy also avoids a
> KMSAN uninitialised-read report.
> 
> (no Link: tags in the commit header)
> 
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index af81ad5e699d1..01db7edce18a6 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -2084,7 +2084,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
>>  		new_ctx->request_bkup = subflow_req->request_bkup;
>               ^^^^
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but while looking at the
> neighbouring store: does request_bkup have exactly the same
> uninitialised-on-SYN-cookies problem that motivated removing the thmac
> copy here?
> 
> subflow_init_req() only clears a subset of the fields:
> 
> net/mptcp/subflow.c:subflow_init_req() {
> 	subflow_req->mp_capable = 0;
> 	subflow_req->mp_join = 0;
> 	subflow_req->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk_listener));
> 	subflow_req->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk_listener));
> 	subflow_req->msk = NULL;
> 	mptcp_token_init_request(req);
> }
> 
> and the only assignment of request_bkup for a request sock happens on the
> SYN, in subflow_token_join_request():
> 
> 	subflow_req->local_id = local_id;
> 	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
> 
> On the cookie ACK path that function is not called, and the state restore
> does not cover request_bkup either:
> 
> net/mptcp/syncookies.c:mptcp_token_join_cookie_init_state() {
> 	subflow_req->remote_nonce = e->remote_nonce;
> 	subflow_req->local_nonce = e->local_nonce;
> 	subflow_req->backup = e->backup;
> 	subflow_req->remote_id = e->join_id;
> 	subflow_req->local_id = e->local_id;
> 	subflow_req->token = e->token;
> 	subflow_req->msk = msk;
> }
> 
> struct join_entry has no request_bkup member at this commit, so the bit
> carries whatever was in the freshly allocated request sock.
> 
> Unlike thmac, the copied value is consumed afterwards, for instance in
> mptcp_subflow_get_send() and mptcp_subflow_get_retrans():
> 
> net/mptcp/protocol.c:mptcp_subflow_get_send() {
> 	bool backup = subflow->backup || subflow->request_bkup;
> 
> It is also put on the wire by mptcp_established_options_mp_prio() and
> exported to userspace by the mptcp diag code.
> 
> So when a remote MP_JOIN is accepted while tcp_syncookies is active, can a
> joined subflow end up randomly flagged as backup and reported that way in
> diag, along with the same class of KMSAN uninit-value branch report that
> this patch removes for thmac?
> 
> For the record, the next patch in this series, "mptcp: syncookies: remember
> the request backup flag", adds request_bkup:1 to struct join_entry and
> stores/restores it, and the store happens after subflow_token_join_request()
> has set the field (subflow_token_join_request() runs before
> subflow_init_req_cookie_join_save() in subflow_check_req()), so the field is
> properly initialised at the end of the series.

All of this to say that it is fixed in the next patch...

> Would it be worth mentioning
> that dependency here, given this patch carries a Cc: stable tag?

Do we really need to mention that?? This report says "there is a
pre-existing bug in the code around", then there is no direct
dependence. Or should we add for each patch: other fixes follow this one?

Note that there is an issue on Sashiko's side to improve that:

https://github.com/sashiko-dev/sashiko/issues/392

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

