Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCE41167A;
	Mon, 15 Jun 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542156; cv=none; b=KLkIdQOoPXkL6mmCbUleMaXx1VnZGbmXKOV8LGs3Mn5FoEPYsqtyLUkc7N5a8pxKh9nKvzZB16BbfRsfE3HHi+F/C8H4OB7V5+V7KkgFSvUf8xjde782Cx2Ua3b1qIWK4zuzz4XDpkOy7EUc42Yf4ZsVRGWiUzPYDDneySjNTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542156; c=relaxed/simple;
	bh=edfUnc6xtOg8nreVx1l9GgQ7LRTcijUWggT9VmGlqD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP66svqIHF3uKarCyBz0QWRMqgfobPjLkAmVu+bPcZeG8BSOGQ8kmMOEidfUSjmpQehCj4fLGl2z05iRtz2yPw0rH52jVHSTWWLIFYTA/TgjwgxXq/7kkwsrX6sCIEyHARG/eVhdYfRfHTQm2pl56jW8rOYBM4RbIwVZ+Ukn2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLydyh/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLydyh/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F471F00A3A;
	Mon, 15 Jun 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542155;
	bh=9KMHFkvWVjJq8wV6DOPhDqXx0riaGku/JWu2rovsXjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLydyh/4ZZqAIT+BGQeJHTT3byFU9h9KaswEQyUWLRMCm8aUEZzsGYCz1nEV+QP1c
	 OoNSNfVAh4tOludtFQuvxJVcUgBB8zA1JTUpgbsLkt9xjeLV91qpDXQS/3c1Bzzqdq
	 /d1IBcdO4pRpbM6bpWQY6eTzUIRKZRdvBmwmAXj1kUJqOklS/wheOk3ZIAAE6SrwDL
	 UzF80dFL2WwvhBsb0VcHMeyULSCQ9356PgLZT/YE3ngYPg344T5mMzaWbHlaV8fbAk
	 H6Dh9BE2K9k3zWPzKQgjip8Q33jJGgyYbgmOiZ85W6D5qvSNh4yJn/cYKOBNOQAp9B
	 JmT08kiAt0V7Q==
From: Simon Horman <horms@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	veritas501@foxmail.com,
	linux-kernel@vger.kernel.org,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
Date: Mon, 15 Jun 2026 17:48:58 +0100
Message-ID: <20260615164858.783714-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
appletalk: Hold socket reference in atalk_rcv()

This commit addresses a use-after-free race by holding a reference to the
socket found by atalk_search_socket() until after the packet is queued in
atalk_rcv().

> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 30a6dc06291c3..61ec5c569dc3c 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c

[ ... ]

> @@ -1474,9 +1476,12 @@ static int atalk_rcv(struct sk_buff *skb, struct net_device *dev,
>  		goto drop;
>  
>  	/* Queue packet (standard) */
> -	if (sock_queue_rcv_skb(sock, skb) < 0)
> +	if (sock_queue_rcv_skb(sock, skb) < 0) {
> +		sock_put(sock);
>  		goto drop;
> +	}

[Severity: High]
Does this code introduce a memory leak or an infinite timer loop?

By holding a socket reference in atalk_rcv(), the socket memory is kept alive,
but atalk_rcv() does not hold the socket lock. A concurrent atalk_release()
could lock the socket, mark it SOCK_DEAD, and call atalk_destroy_socket(),
which logically purges the receive queue:

net/appletalk/ddp.c:atalk_destroy_socket() {
    ...
    skb_queue_purge(&sk->sk_receive_queue);
    ...
}

After this purge, atalk_rcv() might call sock_queue_rcv_skb(). The core
function __sock_queue_rcv_skb() does not reject packets for SOCK_DEAD sockets.
It will successfully enqueue the skb and increment sk->sk_rmem_alloc.

Since AppleTalk uses the empty sock_def_destruct() instead of a custom
sk_destruct callback, is the receive queue ever purged upon final sk_free(),
or does this permanently leak the skb?

Furthermore, if atalk_destroy_socket() finds other pending allocations and
arms the destruction timer, will the timer endlessly re-arm itself?

net/appletalk/ddp.c:atalk_destroy_timer() {
    ...
    if (sk_has_allocations(sk)) {
        sk->sk_timer.expires = jiffies + SOCK_DESTROY_TIME;
        add_timer(&sk->sk_timer);
    }
    ...
}

The timer checks sk_has_allocations(sk), which will remain true indefinitely
due to the uncleared sk_rmem_alloc from the leaked skb.

>  
> +	sock_put(sock);
>  	return NET_RX_SUCCESS;
