Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806649;
	b=z3WCWgio6r2NA7Ml+AdwXaZ3ZdoBc2SvNMPec6OmiTx1vZsNjEWAnzlE+g2VzxglATlp
	 KrbEhAmEDfEhi22fsBAOP9fw8s9NnkeKGHnwH9Z2eNIi9/cG/+8xnuAsPUbmCJ+G+2lv3
	 qUpTdzHG18+lu1ounPKQ6mGKhqiXzcgGo7Vkql7pEO/t4i2kXLxQt3H2hKmpn5qVQ5jG7
	 0vgKJpfjpU1htJcSuaW4puh3rJgghWa+7S2bUWjDzLDk/EzFhUbxJaKCfZgjYUS8TPPuW
	 wsSGtoYZRJmzot4neMUR0utL/YAqr2mPnbV3IoyM69ySyxmJM6TDce/IiTUgEhiLcjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806649;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0dZfnZLmDKeofjrNWSCvtSOvjjruHXh+6zAo/G4pKXM=;
	b=S4BcPen3iU8J79+EUi/fHdJgRmvHFlrEc5xzZ9zWFuIHT2psmLY2Aw1l2Nua9ceaf/fR
	 MaDSoxurhqHwRpKgJfEW5y+OpOb60NUjd/njkfcOTfW6ygsMpc2bze1NLxi+RRBrQXI9F
	 vQamqBMJVtWswG/OVAkD70FQpxCz+AadTob5lW+MbDav0Qklqj+PJM3527HtFgMZqRvib
	 7rplbbW3cB82BOxtAaQWgcrD5I3rAx1QNmEiHoRHcvc5JHIoH0U0s7hKOrGv+0TXdVFX2
	 Pu4o10VYMcB+AXdJo/mUbzydv732E+EIbo9Y0MHLwPgz3EsPvOVTpb5p8FNHGadde7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohLm9M8w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52560A5BE3;
	Wed,  4 Nov 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohLm9M8w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EBE1F00919;
	Wed,  4 Nov 2026 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806649;
	bh=0dZfnZLmDKeofjrNWSCvtSOvjjruHXh+6zAo/G4pKXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ohLm9M8w+sPUogtQHsHFrvhP5/T6bXhVmBD08zqY5+xOFFYQdKdcMb9Mu56KhjLNi
	 SxK7HW2VUNQ8vgU28lG6glxgWFFbmxoluyRirEbqKD+UFr3dekSasdmHBfppmeg/+J
	 E9h7gp4Ki90Ot3z6e0zD6qZ7LqDoSNmAC/1bn2PdAu7y6b3uAd6H3+TubIBiWSlYHA
	 mepdfToLGZ2iir5n85xJ1tWmf1xuj+q8sRXz45QXLlLlO0r0h6jVbYw6uiRiyLFDuV
	 NXAe7OKuNBUB5MXUc1TX+1QJsyL3QwcmEhECD3aSxDr39ua3D0Di8zab5wYrByQVkS
	 ZVCJvaE5IefEQ==
Message-ID: <c52585e9-e3c7-4f75-9a3b-8a32e3559a5a@kernel.org>
Date: Wed, 4 Nov 2026 16:37:23 +0100
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
Subject: Re: [PATCH net] mptcp: pm: kernel: use RCU to free endpoint listeners
Content-Language: fr
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 stable@vger.kernel.org
References: <20261104125327.1041456-1-edumazet@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261104125327.1041456-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 04/11/2026 13:53, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
> instead of going through mptcp_listen(). It consequently misses setting
> SOCK_RCU_FREE on the parent MPTCP socket.
> 
> tcp_child_process() can invoke the listener's subflow_data_ready()
> callback without holding the MPTCP parent lock or a reference to the
> parent. An authenticated MP_JOIN racing with endpoint teardown can
> therefore access the parent after its last reference has been dropped.
> The ADD_ADDR error path can also close an already published listener.
> 
> Set SOCK_RCU_FREE before __inet_listen_sk() publishes the TCP listener,
> matching mptcp_listen(). This protects the parent on every subsequent
> close path, including a failed endpoint addition.

Thank you for the patch! But it looks like Kyle already sent it earlier
to the same list:

https://lore.kernel.org/20261030042255.74216-1-kylebot@openai.com

Probably best to drop this one here?

(It's not clear what PW state we want to set for this case)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

