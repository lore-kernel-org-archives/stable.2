Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE424A078;
	Thu, 15 Oct 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072501; cv=none; b=HPXrCmBhNJrSLSmFOPwbdrC5+0mpTM2Xo/oc1kmDmYU4Gj7jat2BiyQ/tqUz5JFzEY88H+Mc5EUzKJVqVZmT/w5wetUOI1ZtaI27BagUG5JWpt0nV7YsRzGf1rJvhhiMe8P0TAnGZyFNSloQbbEZtKXkeQ5BM0z0ch3hEVs2GhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072501; c=relaxed/simple;
	bh=0PRBjTr5TypY1b893wkFMEDgcWkORlJqXUbeNeHQLNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeXlvjCS5LfiT/vvaCRpK7rUAJw0WfqPBf9GX2xrR3bJg8+TlN7Q0ZSWvi0bt2+xlleuQYUVrzU73MD94eS65cwmdNHmVh7k7fw4b0Cw3y12LF3802bsnFWMaV2pP2kcxqE0UeEK5T3sjH7CYqdpeScasibaJiRq300nnGp9Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+s5HZxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+s5HZxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2937E1F000C4;
	Thu, 15 Oct 2026 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072499;
	bh=gcI24nl2IlPA5Bb0Wh99zUo3x/8i2k9HfoyGQVQIpDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a+s5HZxibXWhqhURTstsw12T/IevWt4HrHhRpZgbNCdg/hWmVdbb2gZ4YzOpVs1X+
	 8UfkgDVdL/JQAzMUaI5YDFrAThRBXJWI1XxrX3c8sxnoiFNlLNxenVhMo5uaqgf1Jk
	 1ArLyKrMO3Va5Cp1nw0RYV7K6u4jfA1r3FV25QV30265brksQ1nNGVNQKQ7LN3ocvk
	 KQ5tovhGpFCrhA+ZiE6bubRtCD7KTbLkfNRiIvDEMvlAhU8pxBBcIhMrklmhmfG5Xj
	 etdkC5AzhFEyn05iJZSi7gtIF8BSb5ZCFXSzYebOO6kdwH7HEkAA832hhPo+ujro6q
	 b3umGmKUykOmA==
Message-ID: <6747ddd1-3eb4-45ff-be2d-f858dc71ab35@kernel.org>
Date: Thu, 15 Oct 2026 15:54:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/4] mptcp: reset msk state on early connect failure
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 caoruide123@gmail.com, stable@vger.kernel.org, vega@nebusec.ai,
 sashiko-bot@kernel.org, weir@nebusec.ai, kuniyu@google.com,
 daniel@iogearbox.net, kafai@fb.com, Quanye Yang <quanyeyang@proton.me>
References: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org>
 <179198834484.434549.4616694240552704738@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179198834484.434549.4616694240552704738@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 14/10/2026 16:32, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new error path in mptcp_connect()
>   (net/mptcp/protocol.c:4224) calls…

TL;DR: this is a pre-existing issue.

> mptcp: reset msk state on early connect failure
> 
> This commit changes the mptcp_connect() error path. It now clears the
> fallback state (MPTCP_FALLBACK_DONE, allow_subflows,
> allow_infinite_fallback) and resets the first subflow context. The goal
> is that a later connect() on the same fd can use MPTCP again after an
> early fallback followed by an immediate connect failure.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index e89a69ab927c9..e6f73a5ee630a 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -4212,9 +4212,16 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>>  	 * subflow_finish_connect()
>>  	 */
>>  	if (unlikely(err)) {
>> -		/* avoid leaving a dangling token in an unconnected socket */
>>  		mptcp_token_destroy(msk);
>>  		mptcp_set_state(sk, TCP_CLOSE);
>> +
>> +		spin_lock_bh(&msk->fallback_lock);
>> +		msk->allow_subflows = true;
>> +		msk->allow_infinite_fallback = true;
>> +		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
>> +		spin_unlock_bh(&msk->fallback_lock);
>> +
>> +		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
> 
> [Severity: Medium]
> Is mptcp_subflow_ctx_reset() resetting more than this path needs? It
> clears the whole reset group and then sets local_id to -1:
> 
> net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
> 	memset(&subflow->reset, 0, sizeof(subflow->reset));
> 	subflow->request_mptcp = 1;
> 	WRITE_ONCE(subflow->local_id, -1);
> }
> 
> This also wipes two values that are set only once, when msk->first is
> created:
> 
> net/mptcp/protocol.c:__mptcp_socket_create() {
>     ...
> 	subflow->subflow_id = msk->subflow_id++;
> 
> 	/* This is the first subflow, always with id 0 */
> 	WRITE_ONCE(subflow->local_id, 0);
>     ...
> }
> 
> A second connect() gets the same msk->first back from __mptcp_nmpc_sk(),
> so this setup does not run again. The reset also runs on every immediate
> failure (ENETUNREACH, EAFNOSUPPORT, BPF pre_connect, ...), not only after
> an early fallback.
> 
> On the retry, local_id is -1, so the connect goes through:
> 
> tcp_connect()
>   subflow_rebuild_header()
>     subflow_chk_local_id()
>       mptcp_pm_get_local_id()
> 
> mptcp_pm_get_local_id() returns 0 only when the msk local address matches
> the subflow's address:
> 
> 	mptcp_local_address((struct sock_common *)msk, &msk_local);
> 	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
> 	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
> 		return 0;
> 
> mptcp_copy_inaddrs() runs only after a successful connect. For an unbound
> msk, the msk address is therefore still zero at this point.
> 
> Wouldn't the kernel PM then give the MPC subflow a non-zero ID, either
> from a matching endpoint or by adding an IMPLICIT endpoint to the netns
> endp_list?
> 
> If the endpoint table is full, mptcp_pm_nl_get_local_id() returns -ERANGE.
> tcp_connect() would then fail the retry with -EHOSTUNREACH, even though a
> valid route exists.
> 
> A non-zero local_id on the initial subflow also seems to break endpoint
> removal. When that endpoint is deleted,
> mptcp_nl_remove_subflow_and_signal_addr() gets the ID from
> mptcp_endp_get_local_id(), which returns rm_id 0 for the MPC endpoint.
> mptcp_pm_rm_addr_or_subflow() then skips the initial subflow because
> id != rm_id, so the initial subflow is never closed.
> 
> The reset also zeroes subflow_id, while msk->subflow_id has already
> advanced to 2. After a successful retry, mptcp_get_full_info() would
> report the first subflow with id 0:
> 
> 	sfinfo.id = subflow->subflow_id;
> 
> But tools/testing/selftests/net/mptcp/mptcp_sockopt.c expects:
> 
> 	assert(sfinfo[0].id == 1);
> 
> mptcp_disconnect() already behaves this way for subflow_id. The local_id
> part looks new, though: on the disconnect path, the msk still holds the
> addresses from the earlier successful connect.

The code here is doing a "disconnect" of the first subflow: similar to
what is done in __mptcp_subflow_disconnect(), mptcp_subflow_ctx_reset()
is called. It will indeed set subflow->local_id to -1 and causing the
(minor) issue reported here where the PM could assign the wrong ID when
reconnecting (yeah, another reconnect after a "disconnect" case...). So
I don't think this issue is new, and the fix here is doing the right
thing of calling mptcp_subflow_ctx_reset().

> The commit message mentions only MPTCP_FALLBACK_DONE, allow_subflows and
> request_mptcp. Would it work to reset only request_mptcp here (plus the
> token and key fields if needed)? Another option would be to restore
> local_id to 0 and keep the original subflow_id for msk->first after
> mptcp_subflow_ctx_reset().

I don't think we should set the local_id to 0 in mptcp_subflow_ctx_reset
because it will cause issues in mptcp_close_ssk(). Maybe we should set
local_id to 0 for the first subflow in mptcp_disconnect()? Anyway, that
should be part of a follow-up patch (I can look at that), not as a new
version of this one.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

