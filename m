Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049246F4AF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547872; cv=none; b=PY7BW+H1IbKJLNY82bteSJxk+ZuvjlhT1bWK34pyo9E+A/Y/54MiEhxCVpEwRlxOZ0P1J7DTZeLkHE8J/wZ3vlzUc56qk6z0DUSxQ8FB1Zy/Ob6IjjWPbpN8+uUTyudpCZWhBLuW6MehusW6/fwsyu6M0a6fKLcFux3bBlmT/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547872; c=relaxed/simple;
	bh=J157RENJaSOVnRBc0VpFasHVK4YEoAwYHyLHBJ8LIgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIGVO9FYmAhZPaNh0j5iR2jZz1ZFm/bCKjeH+MX5kGaaHAVp5HpzNmCY9asqIyn/4iZZdBvYVHmvdNlpL90O9xKwV/fyGiUudvITxLziDNQ4ms4CyQxsy9hgLvBgbFbzlNEUVqy49nB1B4t229Oks/tJLljk4I/0wJfO6qoyBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P27qSDlD; arc=none smtp.client-ip=91.218.175.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P27qSDlD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J157RENJaSOVnRBc0VpFasHVK4YEoAwYHyLHBJ8LIgQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789547868; v=1; x=1790152668;
 b=P27qSDlDb23W1FaR9JKgOhrCQdXP/CoEYJMa3CRTcDljbe8C5LvfWyKmRof+adWsOEaGaFNC
 0CnqIk8J5Sl7lqapCSz+wq3+/c5o1SUvJaKgDsaDhK6AHW5eyNusHyQh5MB3lMsEMyCll+6eOSc
 583/jmlFNytDxLPdG8MQ6E/U=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 10bbcbde662d06e7;
	Wed, 16 Sep 2026 08:37:38 +0000
X-Mizu-Trace-ID: 10bbcbde662d06e7
X-Migadu-Flow: FLOW_OUT
Message-ID: <c45fe13e-0879-4848-b66d-b95c49a906a6@linux.dev>
Date: Wed, 16 Sep 2026 16:37:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: llcp: Fix socket reference leak in
 nfc_llcp_recv_ui()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: david+nfc@ixit.cz, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, sameo@linux.intel.com,
 stable@vger.kernel.org, davem@davemloft.net
References: <20260916073424.1971784-1-vulab@iscas.ac.cn>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260916073424.1971784-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/16 15:34, Wentao Liang 写道:
> In nfc_llcp_recv_ui(), nfc_llcp_sock_get() is called to find the bound
> socket. If the socket type is not SOCK_DGRAM, the function returns
> directly without releasing the socket reference via nfc_llcp_sock_put(),
> resulting in a reference count leak.
> 
> Add nfc_llcp_sock_put() when the socket type is not SOCK_DGRAM.
> 
> Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   net/nfc/llcp_core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index db5bc6a878dd..5813c80ca593 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -888,8 +888,12 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
>   
>   	/* We're looking for a bound socket, not a client one */
>   	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
> -	if (llcp_sock == NULL || llcp_sock->sk.sk_type != SOCK_DGRAM)
> +	if (!llcp_sock)
>   		return;
> +	if (llcp_sock->sk.sk_type != SOCK_DGRAM) {
> +		nfc_llcp_sock_put(llcp_sock);
> +		return;
> +	}
>   
>   	/* There is no sequence with UI frames */
>   	skb_pull(skb, LLCP_HEADER_SIZE);

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Please use the [PATCH net] subject prefix for fixes targeting the net 
tree. See the netdev submission guidelines:

https://docs.kernel.org/process/maintainer-netdev.html#networking-subsystem-netdev

Thanks,
Xuanqiang
