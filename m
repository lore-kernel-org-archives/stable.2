Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576D492E42;
	Wed,  9 Sep 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977246; cv=none; b=bdZIVeFitaYRKkWYI/P0LacdWmgKikO3/88D0KsqBNpKJBktvDp+cyNiTEG877LJ19k01t1TaWyAckwhocpYHQSdNfsmCSFKeBSUe1PnuMddA8L/iTEzbXI4OpqCYU88ESOtQh0orGm/HJEivUrZC3lBVJpINHoknqpj0DSM+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977246; c=relaxed/simple;
	bh=n7OTc5fFo6oGCdOW1SMqH4WBpt5JXMN8L2Y5Y4P0Gng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUbbbkvzAu/eXEpv2oQOjXCmQt5Qw/4LzIJKQU1X7mS2agmUtu9kOwooNDT5b3x3DHztbNop7Id3E+uKcC/6ywgkvlf1AKgtykg3gds7c3wP+Fv3pUPCDvRKdAMurIEFNh514ab3sukH2dvTfVo/CJw2ZcSW5RTwfv9MzXhaSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik1cyO0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik1cyO0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15471F000FF;
	Wed,  9 Sep 2026 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977245;
	bh=gjumx+yxNIwFXOmGDVV5fmM1mA/kwdbL0yxvNc8CNG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ik1cyO0nALOSAuqMostZkNlp8WtbHEZo+jlPFQACnQrsnXlJZLvL2/FY9LL3iic+P
	 sEgZ11Ge4rzCDNK7CTDDlvts1h7EngQkjD78oZMZYG4H2p0Y+Aq1HGq18xwdD2ICYb
	 EQkokuXJOoehIRZJdTxlOsiyv4ecA7cExkYtZLyFHU3col6SolsTVWKGBzDj9r274u
	 14m62f3nLoIsmX7cjUGr5p6dUtqdt/RR79x5MtgvNSvufI6uU1r6kE9oW1LbGxM9SU
	 3BoCiMzIuuda/lrO9QUg+t3RZBbYoPCPfqqOrgs1kptl9hnrPRVsPP7ZLcWwgPdlcq
	 gXlsX85finHAQ==
Message-ID: <196b5e25-3e5b-42b1-861e-f67f976374eb@kernel.org>
Date: Wed, 9 Sep 2026 20:07:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH net v2 15/15] mptcp: avoid pruning for OoW data
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
 <178896537782.219967.1022060629733006428@kernel.org>
 <121f90e5-a19c-4066-af03-8cf5594bb30f@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <121f90e5-a19c-4066-af03-8cf5594bb30f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for having checked these comments.

On 09/09/2026 17:50, Paolo Abeni wrote:
> On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> - [Medium] Incomplete realization of the patch's stated principle ("do it
>>   only when we expect to accept the skb triggering the cleanup"): after…
>>
>> --
>>
>> mptcp: avoid pruning for OoW data
>>
>> This moves the mptcp_try_rmem_schedule() call in mptcp_data_queue_ofo()
>> so that it runs after the out-of-window check instead of before it, which
>> avoids running the destructive OoO queue pruning for skbs that are going
>> to be dropped as out of window.
>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 4309fca6b119..0098e2830931 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>>  	u64 seq, end_seq, max_seq;
>>>  	struct sk_buff *skb1;
>>>  
>>> -	if (!mptcp_try_rmem_schedule(sk, skb)) {
>>> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>>> -		mptcp_drop(sk, skb);
>>> -		return;
>>> -	}
>>> -
>>>  	seq = MPTCP_SKB_CB(skb)->map_seq;
>>>  	end_seq = MPTCP_SKB_CB(skb)->end_seq;
>>>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>>> @@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>>  		return;
>>>  	}
>>>  
>>> +	if (!mptcp_try_rmem_schedule(sk, skb)) {
>>> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>>> +		mptcp_drop(sk, skb);
>>> +		return;
>>> +	}
>>> +
>>
>> [Severity: Medium]
>> The commit message says pruning should be done "only when we expect
>> to accept the skb triggering the cleanup".  Does the new placement
>> fully match that, given the duplicate-data check still happens later in
>> the rbtree walk of mptcp_data_queue_ofo()?
> 
> The change suggested here would add quite a bit of complexity for little
> gain, and would diverge MPTCP behavior from TCP. We learned the lesson
> the hard way we need very good reasons to do the latter. I'm pretty sure
> we are better off with the proposed code.

I agree with you.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

