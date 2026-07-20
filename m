Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181913FBB6C;
	Mon, 20 Jul 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547738; cv=none; b=iUb3pF58mcmGSBKDVcmvPQLAHV/ybA2nzSRupBowpwuplHzCAviSZigo3zEK4xyjT/tZpCOR79cFhtGkP9yag2WBpYFiqD9tydnP4TTnItkFzuoeoLAMNoBsxUjxxEpNjsAyjOdZnL1ta4QUAGbIzEuywS9ywXK8uToqHOdFPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547738; c=relaxed/simple;
	bh=yv4wxHX6rFseijDuEUu86XbpHsyLktClwfogTVZ5dRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKzJFQ4JhH/9f0VPPgYKgUyk4Cx8QvSDd5kFVm4n0uSqe2K10ROS9Uo1BydASq1Bes7KucXUA7c9mLp7KCGDmzCyb2lQZIdT2c2CvFj9uAhKp0BK8EA3REk1R2LkuP/FO2Nr3Ag1U3Gis1w7KSpcvHfn5x7/OX2JDyyxQkdMBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFYZVpim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFYZVpim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3601F00A3A;
	Mon, 20 Jul 2026 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547731;
	bh=yxhWtBByfb7lvx7HMUtl4FWqPZPbAKLseDjcCJqNcCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFYZVpimVaM5CF2l1JsjL9yGIeky3f5R2OwdmrcvPFHYElG8+ucrDuSC5VjLgW7ox
	 +4Gty77XwmFa5/5GmEYQIPqeyX2dib6sYXFQ7ShH8AU8u9jeimdXaJsZ4s1FWMZVAz
	 PfgLUnlIn2Div9u7fYWNspSesxZGgLC8IU3QsJa47ezQLMQiiCwmhU6Ke6o2hISr9a
	 Fds5Hz5ddvQNZjUU1/3vQr5kDREsI5cBOZ1U1m0zK/mKlhbz6S69O9tWBh27zUbxSk
	 MOB7oTDFNi5zDQ8cOPzJJV/lMSesM/9sTxos+kIJGxAZm+gH/LWd1QvmPZIG5ytibP
	 XWXyqifoW9Akg==
From: Simon Horman <horms@kernel.org>
To: shuangpeng.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: Fix raw socket local ref leak on rebind
Date: Mon, 20 Jul 2026 12:41:51 +0100
Message-ID: <20260720114150.115059-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713012111.4066423-1-shuangpeng.kernel@gmail.com>
References: <20260713012111.4066423-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260713012111.4066423-1-shuangpeng.kernel@gmail.com?part=1
---
Now I have enough context to produce the report.

commit 569ae381cd8b4adedc1a30fa7c6777d518fb2eb7
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: nfc: llcp: Fix raw socket local ref leak on rebind

This patch fixes a leak of the nfc_llcp_local reference owned by raw
LLCP sockets when the bound NFC device is unregistered and the socket
is subsequently rebound. It drops any stale llcp_sock->local before
storing the new reference obtained from nfc_llcp_find_local().

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index feab29fc62f4..0c00cdaabbc6 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -152,6 +152,7 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
>  	struct sock *sk = sock->sk;
>  	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
>  	struct nfc_llcp_local *local;
> +	struct nfc_llcp_local *old_local;
>  	struct nfc_dev *dev;
>  	struct sockaddr_nfc_llcp llcp_addr;
>  	int len, ret = 0;
> @@ -185,6 +186,11 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
>  		goto put_dev;
>  	}
>  
> +	old_local = llcp_sock->local;
> +	llcp_sock->local = NULL;
> +	llcp_sock->dev = NULL;
> +	nfc_llcp_local_put(old_local);
> +
>  	llcp_sock->dev = dev;
>  	llcp_sock->local = local;
>  	llcp_sock->nfc_protocol = llcp_addr.nfc_protocol;

[High]
Does the same rebind leak exist on the non-raw path in llcp_sock_bind()?

nfc_llcp_socket_release() walks local->sockets first and, for every
non-raw socket, sets sk_state to LLCP_CLOSED and calls sk_del_node_init(),
but does not touch llcp_sock->local:

net/nfc/llcp_core.c:nfc_llcp_socket_release() {
    ...
    sk_for_each_safe(sk, tmp, &local->sockets.head) {
        llcp_sock = nfc_llcp_sock(sk);
        ...
        sk->sk_state = LLCP_CLOSED;
        sk->sk_state_change(sk);
        bh_unlock_sock(sk);
        sk_del_node_init(sk);
    }
    ...
    /* If we still have a device, we keep the RAW sockets alive */
    if (device == true)
        return;
    ...
}

That path is reachable for non-raw sockets from nfc_llcp_mac_is_down()
(which calls nfc_llcp_socket_release(local, true, 0)) while the nfc_dev
is still around, so a userspace rebind of a SOCK_STREAM/SOCK_DGRAM LLCP
socket that is now in LLCP_CLOSED with a stale llcp_sock->local passes
the gate and reaches:

net/nfc/llcp_sock.c:llcp_sock_bind() {
    ...
    if (sk->sk_state != LLCP_CLOSED) {
        ret = -EBADFD;
        goto error;
    }
    ...
    local = nfc_llcp_find_local(dev);
    ...
    llcp_sock->dev = dev;
    llcp_sock->local = local;
    ...
    llcp_sock->service_name = kmemdup(llcp_addr.service_name,
                                      llcp_sock->service_name_len,
                                      GFP_KERNEL);
    ...
}

Would this overwrite of llcp_sock->local leak the previous reference
returned by the earlier nfc_llcp_find_local(), together with the nfc_dev
ref that nfc_llcp_local_get() holds via local->dev, in the same way as
the raw path this patch is fixing?

As a secondary consequence in the same window, the unconditional
llcp_sock->service_name = kmemdup(...) reassignment appears to overwrite
the previous kmemdup allocation without a kfree(), and
llcp_sock->reserved_ssap continues to reference an SSAP that was reserved
on the earlier local.

Would it make sense to extend the same "drop old_local before overwriting"
pattern to llcp_sock_bind() so both bind paths are covered by the fix?
