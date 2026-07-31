Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4C3F12C8;
	Fri, 31 Jul 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492028; cv=none; b=XyU+F/ZbPtIRQ8TlQv/GV1JRbWowijGH302xPMBx/CdfzNhLEr06lRwZYRxC7WHioJwOOub3ex6qoMT6M7+XYzkYKYJdnv1eVITJF/gfXqDdsqN9Wp7z9zj0Bn+KF0OePXPCCY7bsydJUsdmNjguFtfDbuF9FL34UvFfsug5Zas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492028; c=relaxed/simple;
	bh=OYpoB9suRxZzo54nJU2J/Mf5/QdnvpWf7FIayQ8+Qnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/lILVT3WxLa1dBy3X+LfqJ2DjCm9RnUw2T7sIpsr/chiotp594Oa7sRlsJ17eAJnL1ZgQMWUzMmOMwwUHH2m1XkXvOBIXZOPXstoBOvz0Ffb7noY0+GeeFXtNIzqhRK4/NDsXR2roukEy5GgOMZ2Bw7WcdeYeh12Hp+kzLjPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwGFT7oW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwGFT7oW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD41F000E9;
	Fri, 31 Jul 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492000;
	bh=666vf6gX8Y7a1iPos/kAXlh9FlK90Abg4Z9nTC+uJ20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CwGFT7oWiyFZ2G90Pn3yvr/omXwUzbvsKeldr0lUhEKF/PrW269rnnjJgKImF0xam
	 FVcyOB0eO7np6kURtZ8HaMRDIAOej/+YtxjnVxCbHl3VHh12RTtMo/7b2eJr6/Cvg1
	 NtWTxBbDdIX1kXdVbbo+H8Qhaq2Qzy1JMfM37sdZm44BWSS66mghyipdRw94tbgoad
	 bpE2hNl2ZXw5c57vtRWH8r9baWFt6vAQ6SX+EQRV1yed6OH34OvYyNh9Bi15q0iWqJ
	 7XmL+MgS6jeXc5t3ZhbdnmAbhC2jsV9iWOM9joTIJFZMOQbm1atITlzIMUS9D7NOCs
	 86wP5wmubKcCA==
Message-ID: <5dc85312-9b6a-4dca-96a4-662eaa861192@kernel.org>
Date: Fri, 31 Jul 2026 11:59:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/5] mptcp: avoid combining some incoming suboptions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 Davide Caratti <dcaratti@redhat.com>, Christoph Paasch <cpaasch@openai.com>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
 <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
 <20260729172306.31deb67d@kernel.org>
 <c77bd843-725f-4d65-8750-87da6105a8d3@kernel.org>
 <20260730132705.58e65d98@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260730132705.58e65d98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 30/07/2026 22:27, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 10:14:53 +0200 Matthieu Baerts wrote:
>> On 30/07/2026 02:23, Jakub Kicinski wrote:
>>> On Tue, 28 Jul 2026 19:11:57 +0200 Matthieu Baerts (NGI0) wrote:  
>>>> Some MPTCP suboptions are mutually exclusive according to the RFC8684,
>>>> but also because in different places, the code doesn't expect some
>>>> combinations to be present. That's specially true for suboptions that
>>>> would be present twice, but with different attributes.  
>>>
>>> Looks like Clashiko has much to say about this patch.
>>> Could you check?  
>>
>> Sure, I will check that.
>>
>> Do you think Clashiko could look at patches from the MPTCP ML as well?
>> Because the (deprecated?) AI review tool we use didn't find anything:
>>
>> https://netdev-ai.bots.linux.dev/ai-review.html?id=d1d1ff69-0f15-4812-ad16-e4f6f2df9f6b
>>
>> Or maybe that's because the model is different, and this can be easily
>> fixed? Or maybe the prompts are different too?
>>
>> I'm asking, mainly because once patches have been accepted in our tree,
>> it can be hard to have the original author fixing them. Not to block
>> other patches too long, I often have to fix them, so I would prefer to
>> get the same review tools (if possible) to prevent that :)
> 
> Sorry about that, I know it's annoying. Not the best time TBH.
> I'm modifying our instances very actively, I don't want to have
> to worry about the extra surface of integrations. Hopefully things
> converge soon and we can switch you over and kill that old service
> we had completely.

No problem, I understand and can wait.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

