Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495108;
	b=MS0e3NVZsTBkJQ5xs4H34oBG3rJgJSIbh5oblgAMCg8qtwixhoOLiHMcQ1FOK4yIYQ8L
	 d89PqXNd0HODy2yfpcFx8YWgSaNrhmfFyX7O+7tNxqbIHFLcLEa81X1LeTM6MiglSf/zk
	 iQaLEMs0jOqyWZguXb2hSPfVFBWdepE1Sap68GRbonYqrXcOWedAEpWcI2O+vsXLTxjRJ
	 ZhkiwAc2u9ZuL+Iylwl3TDyhrJK/tZCbp8NoIUtDAgK1eevtNjXaGNRd2rh89OHepeokf
	 mUBVHuFnr2/aYB0i7o9qs58yCwTX1jUAQ5/L20QKuVxJnTt1+YeHjqj+2gtwdY2HSsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495108;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R5IQJPZPaZ722ekjdLCDgWz4ITlLwSuM6xAfRDg9ni0=;
	b=fBSNoA086slkdczcw604nnQP/l8yUcd2ul5tvH+M9hCxCvfm9sA3ik/MfysO9tsyr8CW
	 ugsnfXvc4laiB0dJvXJngyPPShG3NGbWlGbdn2ZoZD0Vv8Gb5zbZewowM1wxTM0LIDki/
	 bpvhYVT0ck+ef0WE5BFdf8mkyttWH4BMCrhXUJEIvzo7CvajSQQVx0uT24Zs7IbvzWg0u
	 iyb7zStzFKESsbs1TdJ+i9vbSmkZjISqszeWXuFE2CTrA7kGoGaNl/aJFld1cAnsXqU8C
	 dMUEc1oMMl5cwfEFe4EFvySJIA9oTdhU0DsuNDGPU1pb0HikIXJnSMeVoPgeJmxW+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dk4k5rJ2;
	arc=none smtp.remote-ip=95.215.58.81
Received: from mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA445606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA445606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dk4k5rJ2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R5IQJPZPaZ722ekjdLCDgWz4ITlLwSuM6xAfRDg9ni0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792495099; v=1; x=1793099899;
 b=dk4k5rJ2uBJQaK0Ebxj+ZRKGeR7+0Dzboqmb1PAWhUgNDcQrvmS/Q6DIv+x0/jUNhCjPP81I
 hvVMRm2bPmIP9yN8+OhNAY907Bgu2YUyLLpGSbukh7MLi0HivgX9e9PTJ2XIn9ooDJwHKZLE6V/
 OOJPryfOPQ5r4u51Xx+w3T60=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 380707f91af7ed82;
	Tue, 20 Oct 2026 11:18:19 +0000
X-Mizu-Trace-ID: 380707f91af7ed82
X-Migadu-Flow: FLOW_OUT
Message-ID: <21053bda-1be0-45c3-80a1-fe012886ab0f@linux.dev>
Date: Tue, 20 Oct 2026 19:18:09 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
To: Sabrina Dubroca <sd@queasysnail.net>,
 Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, wilfred.mallawa@wdc.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261019222626.745408-1-rjethwani@purestorage.com>
 <atdJUP6Jb0jODBYE@krikkit>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <atdJUP6Jb0jODBYE@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

Thanks for your reminder. I totally forgot that thread.

I will send a v3 and update the commit message to address Paolo's comment.



On 10/20/26 6:58 PM, Sabrina Dubroca wrote:
> 2026-10-19, 16:26:25 -0600, Rishikesh Jethwani wrote:
>> do_tls_setsockopt_tx_payload_len() refuses to change the record size
>> limit while a record is open, because both TX paths size the record they
>> are filling against tx_max_payload_len. It looks for the open record
>> through tls_sw_ctx_tx(), a plain cast of priv_ctx_tx to
>> struct tls_sw_context_tx.


I guess sashiko will complain the same issue:

https://lore.kernel.org/netdev/20260901031931.1636980-1-kuba@kernel.org/


> There was already a patch for this
> https://lore.kernel.org/all/20260901072927.128688-1-jiayuan.chen@linux.dev/
> with extra locking to address sashiko comments.
>
> Jiayuan, were you going to send a v3 to address Paolo's comment? Or
> maybe resend your v2, since it got marked as "changes requested" in
> patchwork?



