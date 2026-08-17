Received: from mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032733B4EA9
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968853; cv=none; b=kqITv6mkifG+HGH5hTCgHIv+9huh6bsSUAZNvPG9OQ4DJcnzHMhvzMsLeDfpfvKLBY0dev5rYWCUJb0PECwSYs/MPZlXlkOeQcT17j6W9lMqx5snKXTWG/j+kUcOeDhCzOHRBFQasVHZPNZMMUR4EjGYWD/63t/lYWDs3iqDTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968853; c=relaxed/simple;
	bh=BZGD/kL6wdaidGWNG1WyLeQTkSGw7D7Oxub8aW7qdWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkZNJQ+oLn8L1ZKNMKebLUON0rvs/Nz0b80dMZg+CSS/7Zqw7M/3Hp94BdpiJVzuI66ipSlyeiiI3AbZdhDw5Zx1V3JNcBD14Rtd6QAjmcF7mFjuC9bP+wGeAhP9BrYbsOvNfrI1o8ZHC+YzW1JD60fB7vwou789H4FrxyljzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmzgoR4Z; arc=none smtp.client-ip=91.218.175.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmzgoR4Z"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BZGD/kL6wdaidGWNG1WyLeQTkSGw7D7Oxub8aW7qdWQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786968849; v=1; x=1787573649;
 b=xmzgoR4ZIhGADnLD8KmFyxCh9vTQMaec+kv6nCtPrRoQrHqUVpSlExRGveykq0P4FU57pEMC
 aVSNCqtICeEwqx5cbGtYKT2OZ+4OU3E3/V2YB1vE6LQFGiQ5JhH9dqDw3tJ3goFydFKApdmdAho
 MKACFHcM0zwzw4fVM0Jb8yz8=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 7968e220c24ef2f1;
	Mon, 17 Aug 2026 12:14:09 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e872f9e-ee7a-41db-afbf-4bae49257bc0@linux.dev>
Date: Mon, 17 Aug 2026 20:14:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] ipv6: fix request socket use-after-free after
 IPV6_ADDRFORM
To: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 willemb@google.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260817090319.3897799-1-imv4bel@gmail.com>
 <20260817090319.3897799-2-imv4bel@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260817090319.3897799-2-imv4bel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/17/26 5:03 PM, Hyunwoo Kim wrote:
> IPV6_ADDRFORM turns an AF_INET6 TCP socket into an AF_INET one. It requires
> the socket to be established, and a listener can get there with
> connect(AF_UNSPEC) followed by connect(). Request sockets queued while it
> was listening are still there: inet_csk_listen_stop() leaves them in the
> ehash, and their timers only drop them while the socket is not listening,
> so making it listen again keeps them alive.
>
> A request that arrived over IPv6 was hashed with inet6_ehashfn(). Its child
> is cloned from the converted socket and hashed with inet_ehashfn(), so it
> belongs in a different bucket.
>
> inet_ehash_insert() locks the child's bucket, warns about the mismatching
> hashes, and replaces the request with the child in the request's own bucket
> anyway. reqsk_queue_unlink() locks the bucket the request is really in, so
> there is no synchronization between the two. Both can see the request still
> hashed and both can drop the reference the ehash holds.
>
> The extra put takes the request's refcount to zero too early, so it is
> freed while it is still on the listener's accept queue. The listener is
> then closed, and inet_csk_listen_stop() reads the freed request and
> writes to it in reqsk_put().
>
> Refuse the conversion if inet_csk_reqsk_queue_len() is not zero. Nothing
> clears that counter when a socket stops listening or listens again, so it
> still accounts for the requests left in the ehash. A socket that never
> listened is not affected.
>
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>   net/ipv6/ipv6_sockglue.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b4c977434c2e0a..64fc6127e75332 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -572,6 +572,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>   					retv = -EBUSY;
>   					break;
>   				}
> +				if (inet_csk_reqsk_queue_len(sk)) {
> +					retv = -EBUSY;
> +					break;
> +				}
>   			} else {
>   				break;
>   			}

Just thinking out loud.

Gating on inet_csk_reqsk_queue_len() reads a bit oddly, since we already 
require TCP_ESTABLISHED right above.

it's really just a proxy for "this socket used to listen and still has 
leftover requests.

The real issue is we should drain req when disconnect the listen socket, 
at least we should avoid replaces the request with the child even when 
sk->sk_hash != osk->sk_hash.

But that's the hot path, so hardening it for such a rare corner case 
isn't worth the cost.

