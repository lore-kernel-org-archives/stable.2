Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24A2609FD;
	Sat,  8 Aug 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177103; cv=none; b=XkI4daq7zBPtK2sh79q+qXGCf113wQXqPDLi7Ya1GEON9qj1fWasEav9/+1sm+XeyjeMFp922KvznbHtl5GWIOeCBwP/CbFkOjnOtl/1fjsjZv0/mvsCPJSZQNYa6h43XqR8pMHnhvYeXEjQKHydTq2Y40TF2ldur2/2IepbVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177103; c=relaxed/simple;
	bh=ziLbc9RT3JVUPteFtM3sUzRBC32Auob/JQs5NQEaluI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4vHAXiW1SH1g+8ROFLaCy0KK9RVJFANnfZ8stRNo9KfTR2UYGxEuwZzkgV9HuV2UYFCSRk9tBdEPNkedotuhpFzmlWxX+BvjKqN/fGxDu7Wrd0vlz/q1PE7L2BLhxFDMjS1kWaFBLdn5amiwHjFvhDVVgBAvJnazX8775EeRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cTPC9i4v; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cTPC9i4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786177097;
	bh=ziLbc9RT3JVUPteFtM3sUzRBC32Auob/JQs5NQEaluI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cTPC9i4vJ3AY9N1x8WzTbUsY4iftWeDFDnZSQ0y5NHGA3dR+6lGtR1YNSycAKw5ov
	 rTxjKr6Z4mZ8V1+b13xXGhfWvJAKimRjE0KGgM0w4RkPdFLanXDuPsb5OWNRWNBHtK
	 /G+Z8j8ktC78AnltyhiODISkkPiLHy6m/j/W/MO41a7UBwEm3DzhOIH841ZPIXjQSc
	 X+wep/jMa3JYrYqyUcpQZI3jwvWPXycOojQz9GD8YPuJ92iyjNeIwo60ks5hCuqD9+
	 9h+JK0w0Roz8ZkIH1CvLJhP5d+NlddAjIb2ycPmCao+sc6Ne4oiBnJYptTUSVYh9ln
	 OlDvxbOPZL7yQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C0D3F600C1;
	Sat,  8 Aug 2026 08:18:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 17405200C98;
	Sat, 08 Aug 2026 08:17:51 +0000 (UTC)
Message-ID: <ffccc183-5fe6-460a-9dc7-5f2a174d3068@fiberby.net>
Date: Sat, 8 Aug 2026 08:17:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: reset late connection after listening socket
 close
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>,
 stable@vger.kernel.org
References: <20260807194513.1263310-1-ast@fiberby.net>
 <CAAVpQUD9RTxs742Ty-UQXJJwTbN2wrnFGQDffKN0eZL4udq3Ng@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAAVpQUD9RTxs742Ty-UQXJJwTbN2wrnFGQDffKN0eZL4udq3Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/26 9:05 PM, Kuniyuki Iwashima wrote:
> On Fri, Aug 7, 2026 at 12:47 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>> [..]
>> +       if (sk->sk_state == TCP_CLOSE) {
>> +               tcp_v4_send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
>> +               goto put_and_exit;
>> +       }
> 
> What happens if the state changes here ?
> 
> 
>> +
>>          if (__inet_inherit_port(sk, newsk) < 0)
>>                  goto put_and_exit;
> 
> -ENOENT should be checked to jump to a new label and
> call req->rsk_ops->send_reset() there.

I will do that in v2, thanks.
