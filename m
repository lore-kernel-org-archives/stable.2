Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705759;
	b=z8oFKj2DFfAzbYxkRQS2HR9v6jpDSGPQcSCUs8aU3d2dOQv3qMmUwSJrq7JMMBrE3fk4
	 LtMIwaHW641zQb8DPE3zuqB8+h4Q7yyNVCoEwQMHrLSPxcWH15rLPUGTwFaHY/x/amqC9
	 lyqCmlP6JSNA+wuiF4IxoE1Ex/KguzrxV1bOaTf6WIHZUrYpN7bkbhrZPVvELfrD64sBs
	 30hsBp2mNulk7ZDhOuPl1FWodpaN+cbN3mOVrl2FaHDf2pRUgIV0nE6hZMElyHFHoY1G5
	 LEyAiYpCZxS1xbOSiFqOdH00ZS/IMuu5oVuLsAtte46FsAhcZ7KbH2wYJvQm3yTGG3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705759;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WX4lESHx0tbK1LSzmk5ytUEo0lrUv9vsIGOakUON/JI=;
	b=Xrow8iFygiMO5c+uBCO10ubzTOFpKbmZNIFGewq6HLndRneSygvKGs3Ipdx8ABRCULoC
	 qpNTSWMnMWZCkTBzpSOLA6k+5nYIfsMzWZBDiSY4wRsx5f6aRuSIS+ycXRTpGfrFvA7Fb
	 aL8X8RHdcwjE8KpKErAfYcVxT8BGd5R9N0PX5M6zhXUI4A8zgudAx66EsflbbNtfqYLmR
	 6zur9CehoOEi4593Vf9PKQfBgJKC9B5uP4TsdrbhZTvT+xt3rYMwhhLRA865BjQWN0b8+
	 cL0fuIgEOIq4lgTEPH0nYf+FAgyNpyrxrWU6t9U1g36HRK9woKWINg3aYN6OWWHyuKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU+PdCJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41C606A321;
	Thu, 26 Nov 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU+PdCJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F031F000E6;
	Thu, 26 Nov 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705759;
	bh=WX4lESHx0tbK1LSzmk5ytUEo0lrUv9vsIGOakUON/JI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SU+PdCJ6pWxqh8CVxaA9F25Obma/Xt8FZmkHHgyp1gTl5rqSun8EUzYzTvyDvkHYM
	 /zcWuWICnA5+Khsmr8/HrhQj6A925iABnxntbaVMFC5pYMc+8kfus4ne6gE3mEayGb
	 NPWrb/LJzOlzddhZ5HxKZdDgWSSc+f6kyStIflTDKL2nNm8ptIXOCBtUB5Va+YWJEM
	 nR7RwXtUJJiBPqeMRvwCnCiDIlaLvI5LJ+lKdB8iCa3nxqVB435p8Z7F4zaIvqX7GR
	 0uikwmCla9RxCyW1JXWcdvb0fnABMGX5O1eGgSLepdWyKNLRVNmSiplz+xAab1wNsz
	 PvVtZfjHYO8NA==
Message-ID: <c9eb1633-ea90-4b86-b7d5-dc3c7ba2bf1d@kernel.org>
Date: Thu, 26 Nov 2026 16:09:15 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
Content-Language: fr
To: gang.yan@linux.dev
Cc: Abdul Wasey <w453y.me@gmail.com>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Mohit P. Tahiliani"
 <tahiliani@nitk.edu.in>, stable@vger.kernel.org
References: <20261126101818.3916631-1-w453y.me@gmail.com>
 <20261126101818.3916631-2-w453y.me@gmail.com>
 <0f1d9633b78cdacd57f4c235a5a787426083d788@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0f1d9633b78cdacd57f4c235a5a787426083d788@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

Thank you for the review!

On 26/11/2026 16:01, gang.yan@linux.dev wrote:
> Hi Abdul,

Thank you for the new version!

>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index d465524902f0..af3b092e45ba 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
>>  return 1;
>>  }
>>  
>> +/* Closed subflows can stay in the conn_list, e.g. the initial one: their
>> + * addresses and IDs are not reliable, possibly even reset.
>> + */
> 
> What about dropping this comment here? 
> 
> mptcp_subflow_is_closed() is a generic predicate — "is this subflow
> closed?" — while "closed subflows can stay in the conn_list with
> unreliable IDs" is a concern of the two loops calling it. And the commit message
> already spells out the rationale. 

+1

>> +static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
>> +{
>> + struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +
>> + return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
>> +}
>> +
>>  static unsigned int
>>  fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>>  struct mptcp_addr_info *local,
>> @@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>>  * already created by incoming ADD_ADDR
>>  */
>>  bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
>> - mptcp_for_each_subflow(msk, subflow)
>> + mptcp_for_each_subflow(msk, subflow) {
>> + if (mptcp_subflow_is_closed(subflow))
>> + continue;
>> +
>>  if (READ_ONCE(subflow->local_id) == local->id)
>>  __set_bit(subflow->remote_id, unavail_id);
>> + }
>>  
>>  mptcp_for_each_subflow(msk, subflow) {
>> + if (mptcp_subflow_is_closed(subflow))
>> + continue;
>> +
>>  ssk = mptcp_subflow_tcp_sock(subflow);
>>  mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>>  addrs[i].id = READ_ONCE(subflow->remote_id);
>> @@ -243,6 +260,20 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>>  break;
>>  }
>>  
>> + /* The initial subflow can be closed: like fill_remote_addr(), use the
>> + * remote address of the MPTCP socket for the remote ID 0.
>> + */

While at it, you can short this comment to something like:

 /* If the initial subflow is closed, use fill_remote_addr */

> Another question, why don't you just use 'full_remote_addr' here, like:
> '''
>   if (!test_bit(0, unavail_id) && i < addrs_size &&
>             msk->pm.extra_subflows < limit_extra_subflows)
>         i += fill_remote_addr(msk, local, &addrs[i]);
> '''
> 
> It hasn't been tested, just wondering if there is a specific reason to keep
> the duplication here, as I would rather reuse the existing code.

Good idea to try this!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

