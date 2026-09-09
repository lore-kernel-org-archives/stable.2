Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A023932E3;
	Wed,  9 Sep 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976669; cv=none; b=syg8sZmTld+sEWxVdnsRbGXcVXLSR+vTul50A824DeSxlKV1pPnFxbXuMqRMXXhLphWHuxWIngPzMcUKSOVUzQ0ybvWb56wKj4PntjLCvBq0AVmui8LFqSx6y9gPSpFosyT9k4uL2iM6qEa7Ne0ER2ppMOt02ohAvA15uB85Npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976669; c=relaxed/simple;
	bh=RDcZ1N2of0hE/KEQ6YmRibGweUEaHd7NGJ3Ngz3ILKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOGtGuWidHVQu3Mi3b9+BHduVng0nYnkfzWOjeBNDVhOE9qwD4OF5L+nd0pSdi6WQlGHlIXbTxAgPuE8c/0Am/EM4Y4m1jjcs+AiadmEEUFVv8wyakOle3wo8+HC+EYye9sws/FHkcb36TrYkDYY5dkWP+85+AhM686KCUrnb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0M7TaBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0M7TaBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADE81F000FF;
	Wed,  9 Sep 2026 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976667;
	bh=bedgQLEmoSjapKQJt0LsEmsD0KkdBrnumX6yghAqwSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O0M7TaBuuIqeIHUOZyRrnOQaqBQIdb11hRbifgvv3Oo04KEluIYkgIs5eNKIyCmk7
	 9R7sajMx7heh8mCNAlr8RBlvRhDVgv/ApQbDZbjKY+OqD+i05Zv4ux3UaJmXKqraJp
	 flQtBNyvmsjjSXGs0lA9e2MmMC3bUvQVYCc9qhxiDbLFuR11YQxa2K2Wm1MJIPnsZa
	 FLYqKRwkKLx/NpPlcLF2jqG6dFCtiCgQ1rdnD1plb8QSiKxKVkMIatuH7vDg1VLVXF
	 NB2z0caRV5lW/50dI3O3wFbCaVZgGZVP/y5D3+A7d/cuaEGA2zgjklsKsQi6Lbl+jb
	 Y1AnG5Tjd8MhQ==
Message-ID: <8118ffe2-635f-40dc-98a6-d0bd1878e29e@kernel.org>
Date: Wed, 9 Sep 2026 19:57:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH net v2 04/15] mptcp: pm: kernel: drop pending ADD_ADDR
 when removing ID0
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org>
 <178896537388.219967.5173915953995910937@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <178896537388.219967.5173915953995910937@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 09/09/2026 16:49, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> - [High] Incomplete fix: in mptcp_nl_remove_id_zero_address()
>   (net/mptcp/pm_kernel.c) the new cleanup forces `anno_addr.port = 0`…
> - [Medium] Newly introduced wrong-entry teardown in
>   mptcp_nl_remove_id_zero_address() (net/mptcp/pm_kernel.c:1152-1157):…
> 
> --
> 
> mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
> 
> This makes the in-kernel path manager's id 0 removal path symmetric with the
> non-zero id path by dropping a pending ADD_ADDR announcement and decrementing
> add_addr_signaled before queuing the RM_ADDR.  The lookup key is the msk local
> address with the port forced to 0.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
> 
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index 424f1a7f9248..1a7750813235 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -1137,6 +1137,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>>  	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
>>  		struct sock *sk = (struct sock *)msk;
>>  		struct mptcp_addr_info msk_local;
>> +		struct mptcp_addr_info anno_addr;
>> +		bool announced;
>>  
>>  		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
>>  			goto next;
>> @@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>>  			goto next;
>>  
>>  		lock_sock(sk);
>> +		/* Drop a possibly pending ADD_ADDR for this address. */
>> +		anno_addr = msk_local;
>> +		anno_addr.port = 0;
>> +		announced = mptcp_pm_announced_remove(msk, &anno_addr);
> 
> [Severity: High]
> Does zeroing the port here make the lookup miss the announcements this
> patch is meant to remove?
> 
> The commit message says:
> 
>     Subtle detail: signal endpoints are stored in anno_list with port 0, but
>     msk_local carries the connection's local port. In other words, entries
>     linked to ID0 paths should have port == 0. A follow-up patch will ensure
>     that.
As mentioned, a follow-up patch to fix this non-directly related issue
is in preparation. The series was already 15 patches long, it has not
been included and will be sent later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

