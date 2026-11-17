Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954588;
	b=WgaGQSx30vJ1KroUmBIfizpl9x6X9mT2jGn5TJN0etiVB6k3OgCCysrNriWuep7bB76u
	 hYBLdE//IVybYOd3dlh75OO5sBMFxwfaV0AYT+HwlnCdtRuO10XCEzxNJDwwdfeRqHxzD
	 eCuyRp7+j/4vCxicVWfuPcefpxSl8mXsFD1+AxUuHTEmBgrGJmAafR3J0nifuh3bWUbJB
	 YPopyJjWBwdYLElH4tTGI76zxc3KQnNrC5mCE7By+nFBSBH/8PYa6vhL2rQz+UqjjsCYj
	 9jKSNUtuJeLS+2N0g5aZORBi8y5LL1qN/8WnQNueSFWRp6j6cpn/flbkvU5wi++MPYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954588;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nJ50dWwrw6eP7lM7PGnaKKuzHTxZuNFJv4CpyDCuR8k=;
	b=BKYnd4xBE6Igjmw2+7kNRSXFP7U3D7GKolcu25qoYCMD5h9vGEY+cwDTDQzXKBv1QR2K
	 3HPOxa9mClihXy7g7LLKI7Gta0k0S0xDqU6UDHT2qdJxgXe2BU971QTjs41NnJJCpG+A9
	 XrCLDWaTPquiUnw6wm3HfnXYhOrG90om9IZcieZuqWAzR5ddz7jN/ZMHBy/jhHN5XsMwe
	 7dxq/Txrim5fPm0KoDe343metrO34HAe94Ul76dWoOE+o36oVzZw+V3oFTQs8aJdc6QVD
	 vVDI1GiZv+x1VBTLv/8UZXX7sxffW6FXdCQ3+HvtvMW3uLaLKst3pqtopbjSUATPg2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP0byFfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA7606A31C;
	Tue, 17 Nov 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP0byFfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2749D1F000C5;
	Tue, 17 Nov 2026 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954588;
	bh=nJ50dWwrw6eP7lM7PGnaKKuzHTxZuNFJv4CpyDCuR8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NP0byFfJqLTtWq80K5MV0KlEcn0WEW2Rx+QgjSnN87b+LnlHAf36CoNWloi6fuaUs
	 q1fZ1cgA5ogofiTUNcodn4b5M4/aAMOiWNLxi8gCMqQLxfrkdlgFAwqRdHCvUHky2N
	 Kecif7O9nGcpWldlVwnvSllXRUoj5yG6MKdv6jeWosC8+/K5HH+urfrkbuZJZek9ex
	 fbIcriHJgHiZ8tmYiXgwmV/5fMdYzTDKeHvM0U7zjrrk0STAL0rBtrVMT0z6pXHR6E
	 8Lyocfw8S4M9dBegu7Tby1F+9Jv5k3TBopuVfQ8SuorFgv9ElwpwTGqVp8RxpUkzPp
	 SJyRxF3p+hHzg==
Subject:
 Re: [PATCH net 2/7] mptcp: push pending data after a sendmsg copy fault
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
Date: Tue, 17 Nov 2026 22:29:46 +0000
Message-ID: <179495458661.3136.9219707272531758975@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-2-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-2-bf7656de653e@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] mptcp: Fixes trailer in commit message cites 69800e516e96 instead
  of d9ca1de8c0cd

--

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2130,8 +2130,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	return copied;
>  
>  do_error:
> -	if (copied)
> +	if (copied) {
> +		__mptcp_push_pending(sk, msg->msg_flags);
>  		goto out;
> +	}
>  
>  	copied = sk_stream_error(sk, msg->msg_flags, ret);
>  	goto out;
>

[Severity: Low]
The Fixes tag looks off to me. Before 69800e516e96 ("mptcp: propagate
fastclose error"), a copy fault in mptcp_sendmsg() already set
ret = -EFAULT and jumped straight to out. The out label sat after the
if (copied) __mptcp_push_pending() block and returned copied ? : ret.

So with copied > 0, the already queued dfrag was left on rtx_queue
without a push even back then. 69800e516e96 only introduced do_error
to pass ret through sk_stream_error() when copied == 0. It kept the
existing if (copied) goto out; behaviour.

As far as I can tell, skipping the push on a partial copy error goes
back to d9ca1de8c0cd ("mptcp: move page frag allocation in
mptcp_sendmsg()"). That commit made mptcp_sendmsg() queue everything
first and only push after the loop.

With the current tag, stable tooling would miss kernels that have
d9ca1de8c0cd but not 69800e516e96.

Could you double check, and if you agree, point the Fixes tag at
d9ca1de8c0cd instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e%40kernel.org
