Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CE4195BE
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969674; cv=none; b=H/sseiSoCdRZPPFXfu0djQMwGE8xcGtGgpoeV2lKH/2hRtj8TV/gpxDggBkMJ44x5+D+gRbK2ujazkBJbdzy6Lt9yJziVnjH7x0ylR2auEJQfZ7DgT0IKKLIiPhB0C/anJ8wQ6tgHY7UgA1nu+ZMWEEVi3aM09UwQWgeigMwZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969674; c=relaxed/simple;
	bh=QKVZ8Ky62reOL6LU+lIteAFwEWTbgFAMVsCUtHLSOrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0p8WHRwp+UGj93iANaB5w0drZkj+N8DGqyfI/vYYeqoXk2P7IQhf1AqkX7v9hBSf7oyG9fuxUJmPeZJmW9rjAfGOs2XUH2TtcqYLKO2SL0hmuIGXUYrAx6JCSN8LRXkveAOdZ0eICNcmbyEmrDHKTS6sstbfObRDgtiK/7b/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6lifhyY; arc=none smtp.client-ip=95.215.58.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6lifhyY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QKVZ8Ky62reOL6LU+lIteAFwEWTbgFAMVsCUtHLSOrA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786969659; v=1; x=1787574459;
 b=Z6lifhyYDsXIFQHznuA+5QmeIjPXYpq6EQw+GygzH/VxC4yM/M/B7PkVhtJtOzJEkF/70Qfx
 uigLRl2GBAQIq63j5B4/+cs9KhrpTzh+fY7wzEtSp5xFmrR2pUq9ajU/921LX4yo+O5fABKe+eB
 S7rVoa8/hZNF0iYkTAuhtH7w=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 8559e1e456ab6fc9;
	Mon, 17 Aug 2026 12:27:39 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <75320acf-e9be-4eb2-b52e-f344969f235d@linux.dev>
Date: Mon, 17 Aug 2026 20:27:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] tcp: do not inherit out_of_order_queue from
 parent
To: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 willemb@google.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260817090319.3897799-1-imv4bel@gmail.com>
 <20260817090319.3897799-4-imv4bel@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260817090319.3897799-4-imv4bel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/17/26 5:03 PM, Hyunwoo Kim wrote:
> A child gets a copy of the parent's out_of_order_queue, which can be non
> empty when/if parent morphs from listener to active session. Parent and
> child then point at the same rbtree.
>
> The parent is no longer a listener, so inet_csk_reqsk_queue_add() forgets
> the child immediately, and tcp_disconnect() frees the skbs the parent
> still owns. The parent's own root and ooo_last_skb are left alone, so it
> keeps using those skbs. That is a use-after-free, and the parent frees
> them a second time when it closes.
>
> We need to make sure this can not happen, by initializing the queue after
> socket cloning.
>
> Very similar to commit 8b485ce69876 ("tcp: do not inherit fastopen_req
> from parent")
>
> Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>   net/ipv4/tcp_minisocks.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 6ab3e3a0b43173..d13813d50947dd 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -591,6 +591,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>   	newtp->total_retrans = req->num_retrans;
>   
>   	tcp_init_xmit_timers(newsk);
> +	newtp->out_of_order_queue = RB_ROOT;


Does tcp_rtx_queue suffer from the same issue?


>   	WRITE_ONCE(newtp->write_seq, newtp->pushed_seq = treq->snt_isn + 1);
>   
>   	if (sock_flag(newsk, SOCK_KEEPOPEN))
