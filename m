Received: from mta-201a.earthlink-vadesecure.net (mta-201b.earthlink-vadesecure.net [51.81.229.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95A3033EC;
	Thu, 13 Aug 2026 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601314; cv=none; b=JZJ9KX8HL9whQiBvglvz+e1Z3QnGMFMjAZXW+lo1YYaknp44hfmfQGUrMgW7Tgo+e+q38HjnuYWw9hFSwqkt9KjhjFpVkj5XOWkDrRKngOjAcrBRm49JFIVgLoTJn9Nqe+cs1E/e58BniSh7Z9ZUeN4O8fnzRryYjmmY3H1CaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601314; c=relaxed/simple;
	bh=EUpn9wNf/E68gBc+3Iz490nXfjdeIUlfPhiZmNVCzwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YADLSluGAn03gB/yzNc1wQPcvmSQnGTTMadEJcxnxlrbfqQIRpa/hq2m1p11tNJEX3kC35Rh5p3yNa3hGEX4rKftb96+UAUzY6hAPhE1Yjgea8I+JqxUI1pKLyR2v+B23aluEGBNghy7dY2mVTcMQghz5uDDdZ0zsHFwa25Uq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=UVMjIacj; arc=none smtp.client-ip=51.81.229.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="UVMjIacj"
DKIM-Signature: v=1; a=rsa-sha256; bh=IZ8AHtto8KgxOnhzbTtl69L6Tqe0UTI5qCOem0
 RXSUo=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1786600358; x=1787205158; b=UVMjIacjxf7Ip2jZWTMrGLKSm7h
 +XID8Tv1npbF1SYaD3zkotXQvyWAT6T8bE4w2T2SGoWxHUc5NU+n7juthWjgm4S8WzdtXND
 mhDGx1Nf9EzE21CjziYABHTajBi5YMvQ1+WyiTv9uiceChhSy9Nu9FoPZuZIsv90mERKqJD
 lvehGHJHPCf3MTrfi1wosMA2OXldmnORi/H4MVPiktOghVWC0W3nOXezX19KzxdCkKcDmQS
 Rj+tApOO96XdGWYKQ89neBe4H8kzzSZ8QcQEStHUlszr3Ea5lfYWqSp989wpAg4l6bFjRjg
 /zs3/plWALfh87b4bQzMkNvrct98uAQ==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id edc54ede-18cb478c6a002e08; Thu, 13 Aug 2026 05:52:38 +0000
Message-ID: <5c7cf96a-74a6-46c2-bde3-f39b25a2d09e@onemain.com>
Date: Wed, 12 Aug 2026 22:52:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Anand Khoje <anand.a.khoje@oracle.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Abhijit Gangurde
 <abhijit.gangurde@amd.com>, Leon Romanovsky <leon@kernel.org>,
 Eric Joyner <eric.joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813051315.430146-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20260813051315.430146-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/26 22:13, Anand Khoje wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
>
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> v2:
>   Fixed the Fixes tag.
>
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 14 ++++++++++++++
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c    |  5 ++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index fd3ee9820531..1822361e1070 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -920,9 +920,23 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
>   	};
>   	int err;
>   
> +	q->partner = NULL;
> +
> +	/* Only normal RX queues have matching TX queue partners,
> +	 * skip partner pairing for hwstamp RX queue.
> +	 */
> +	if (q->index >= lif->nxqs)
> +		goto skip_partner;
> +
> +	if (WARN_ON_ONCE(!lif->txqcqs ||
> +	    q->index >= lif->ionic->ntxqs_per_lif ||
> +	    !lif->txqcqs[q->index]))
> +		return -EINVAL;

This driver doesn't have any other WARN type statements, and the WARN* 
is more often frowned upon now that so many places use 
panic_on_warn.  The other place where this kind of check is done simply 
prints a dev_err() and returns -ENXIO - see ionic_txrx_enable().  Brett 
or Eric J might have another opinion, but you might stick with that 
practice here.

> +
>   	q->partner = &lif->txqcqs[q->index]->q;
>   	q->partner->partner = q;
>   
> +skip_partner:
>   	if (!lif->xdp_prog ||
>   	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
>   		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 301ebee2fdc5..73998d61593 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -543,13 +543,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>   		break;
>   
>   	case XDP_TX:
> +		txq = rxq->partner;
> +		if (unlikely(!txq)) {
> +			err = -EIO;
> +			break;
> +		}
> +
>   		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>   		if (!xdpf) {
>   			err = -ENOSPC;
>   			break;
>   		}
>   
> -		txq = rxq->partner;
>   		nq = netdev_get_tx_queue(netdev, txq->index);
>   		__netif_tx_lock(nq, smp_processor_id());
>   		txq_trans_cond_update(nq);

Other than the above, this looks fine to me.
Reviewed-by: Shannon Nelson <sln@onemain.com>

