Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C6381AFF;
	Thu,  9 Jul 2026 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598007; cv=none; b=E5jHTEmhJ1uacjpGVDO4AFUR3E7H9mlmRjy2DE6kw1Py3ZDk3/XCD0benNJvE/BVCpycgw3Ob5+NXUylhfKr1tuilglkrLZV8X8f80ILyGLhfngRqB2JlbWzags1D+9pKjzq1WyWRvYUMf+AjfwCuVdqR8ERSttRSdnXcC6MlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598007; c=relaxed/simple;
	bh=tz7wxxNEV/4kEzCgnlblJbKSUMoWw6JwRukQ64PN/zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRPECZIv0HZfuFFVGXe2osNqMiBElMb/CQpbUq2UrSPzBkSlVEdQ+TBStFYvM37olLwE1x6eI5Tk/jCsgwS6vk9mkYUsvqpDUG9ZHokN2F4io20FEpj7CWE7ZI3UmfRllKjJcFquXCKz1T2L3gvIGEPPmrpIbkPZ21HIsEMsTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pFpddwwp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pFpddwwp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wTsbFPng4nRn9k/g8RF7ssMzIf9aCU+tT518nWT311k=; b=pFpddwwpu7ZaeU1UawtdwTr9At
	a0s3hLn8EQzW5OpZWl4sZTrH3rQje3c3W07R7WanoS8GbdXo4h+2t1G1PYE3kz2mFrNWdp7LGAF6V
	tjaf9q8CFvWoVtDfGKs6TrcudDGZXAHLD9UTHvOMa5MfWEqR87VWUud5lFQDCSItmUOaYL1i9Tzp3
	028CkZ3bC28yZP+b6OVz2xuxrAupwlOVsrEjWUr3edheCj06k295H83T6tvQ5KAYB1W3NXTDuDFKO
	0M+tkdbl6agtDMCoqqs69HJ15KJ+WrRps4sDutJ3enLsgv9lnhNEF8o4vzJA76ZDs7q3lZk+l4IWN
	+3KCh3Iw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whnJh-0001w3-1s;
	Thu, 09 Jul 2026 13:53:21 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1whnJg-000Kpf-0y;
	Thu, 09 Jul 2026 13:53:20 +0200
Message-ID: <e30f1c25-bc81-4a2a-a997-9b7007890b03@iogearbox.net>
Date: Thu, 9 Jul 2026 13:53:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
To: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 jannh@google.com, stable@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20260709025316.999913-1-mattbobrowski@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260709025316.999913-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)

[ +Kuniyuki ]

On 7/9/26 4:53 AM, Matt Bobrowski wrote:
> Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
> before bailouts that access it"), sk_clone() performs an initial
> shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
> the cloned socket newsk.
> 
> If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
> to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
> to the parent socket's BPF local storage. When newsk is subsequently
> freed via sk_free(), the deallocation path (__sk_destruct() ->
> bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
> leading to a use-after-free (UAF) on the parent socket.
> 
> Fix this by resetting newsk->sk_bpf_storage to NULL immediately after
> sock_copy() in sk_clone(), and remove the now redundant initialization
> from bpf_sk_storage_clone().
> 
> Cc: stable@vger.kernel.org
> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> Fixes: f12dd75959b0 ("bpf: net: Set sk_bpf_storage back to NULL for cloned sk")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

LGTM, thanks!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

>   net/core/bpf_sk_storage.c | 2 --
>   net/core/sock.c           | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index ecd659f79fd4..1d295a8769fa 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -158,8 +158,6 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>   	struct bpf_local_storage_elem *selem;
>   	int ret = 0;
>   
> -	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
> -
>   	rcu_read_lock_dont_migrate();
>   	sk_storage = rcu_dereference(sk->sk_bpf_storage);
>   
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8a59bfaa8096..498a57f34f5b 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2492,6 +2492,9 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
>   	sock_copy(newsk, sk);
>   
>   	newsk->sk_prot_creator = prot;
> +#ifdef CONFIG_BPF_SYSCALL
> +	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
> +#endif
>   
>   	/* SANITY */
>   	if (likely(newsk->sk_net_refcnt)) {

