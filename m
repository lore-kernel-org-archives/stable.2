Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206829;
	b=ejhBzwGQrkdmLvuSSK6raDlzqq4ZBZXJ7qnhA71aRNUfdJyKctH8U+qLfZCukGiaOiY/
	 pej7TLICctop/eotIJ4iAvaGI7sDF4nYs65BYqCKeW3O37BmRe65fIRmSHIvk55zUOZ6N
	 b25CF1mI5JNBzrlMIi92rxehG6rdyAn2HUuMyA6vrK2vmNK1g9bPdo0FaxttU7jEk+tl2
	 OjWubT/Tjv/YPQoAUgjaW8ME5lz0pgP5mJLEuud3S1grpOTx/kytd42ViaUjO/UCbwBuL
	 9HNaX2S110nsiJg6tVadz1XyiZbXizJJHIbu/TFTpX+1sIz3TyDMLtX6S70W9D3xUiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206829;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=hZm9lZhgjP3OUdGyGGXPNH376tgpFhHxDRPWMChVfQo=;
	b=SWoOGzOr6wNBJ5KhRR2+eeIRBzk6hkD1OMObVtPoqbGBsSjJgYlzAFYivsxmFJZ3LA/3
	 7/jdMNowhlQ+7dd/7Wwr4JMdEj8IFw8oeA+ORVGMoDiF4nzNipihuk6vNgqsdaM8joOWy
	 zboELi+XUNvQx1ToX1b1kDsjYgw9FEZEIq4dgbHgBm7QLgcsPQKYXTQupx/x7lAGPQSi1
	 UF4aGI6ciiqU04oMcclePohuEaREx++luTJ0KPfsuKmbGprKao8fOU1o/QUWYgv1j/+XJ
	 t90iAdNgOTcQ5HqQE1rcxAzovnQVtnSyg4HXCXHFOauc2339noWDO5H5/xOpKnp3rOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=IGPBkBBm;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18260A2602;
	Fri, 20 Nov 2026 20:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA18260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=IGPBkBBm
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jWRr33fXHz5vlP;
	Fri, 20 Nov 2026 21:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795206819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZm9lZhgjP3OUdGyGGXPNH376tgpFhHxDRPWMChVfQo=;
	b=IGPBkBBmfyWPT9KNs3XohQTh3sgzvSyuVUOo9WmuovDUMwEzWssc5oyugKzRgf1dL7Os7H
	Plung0i0xrH0Y1cYq4OO9vbr/ttVWaGIzgtvU8M6zFihqTTAOUBIgI/lKFdGcslON1dvr5
	qHhMjkFhcq/xwW+DLiXZwKasVBPYaVN8FNkYNLqHeUX+0Gi/CowhfgHOpuHs/Dn+wSZJKt
	aR1RaERl+nq7pB4Aez+1w+lfpjy1sgx4ZsYZjCAe4OmISJ/18QdN1YqE90YHtUQ3P2quB4
	qH4St5k4QpF5pHu7uxUX/0EYaZ5W9hUZYu4YPOsu7mqbb8xb6bjMlw8mVADRiA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <02a73961-95ab-4caa-85d8-ea92f916a0ab@mandelbit.com>
Date: Fri, 20 Nov 2026 21:33:35 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist when
 disabling an XSK pool
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261119140412.163202-1-antonio@mandelbit.com>
 <20261119140412.163202-2-antonio@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jWRr33fXHz5vlP

Apparently Sashiko has hit a little, but valid, interesting hitch on 
this patch.

Will need a respin.

Regards,

pw-bot: cr

On 19/11/2026 15:04, Antonio Quartulli wrote:
> xsk_get_pool_from_qid() checks the queue id against the stack's real
> queue counts, which can be higher than the number of rings the device
> has, e.g. after igb falls back from MSI-X to MSI on resume. Disabling
> the pool of such a queue then passes a NULL ring to
> igb_txrx_ring_disable().
> 
> Only disable and re-enable the rings the device has, as
> igb_xsk_pool_enable() and igb_xsk_wakeup() already check.
> 
> Compile-tested only: the XSK pool path isn't reachable with the QEMU
> 82576 setup used for the rest of the series.
> 
> Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
> Cc: stable@vger.kernel.org # 6.14+
> Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> v3: new patch.
> 
>   drivers/net/ethernet/intel/igb/igb_xsk.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b5..8ed82bb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
>   		return -EINVAL;
>   
>   	rx_ring = adapter->rx_ring[qid];
> -	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running = netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;
>   	if (if_running)
>   		igb_txrx_ring_disable(adapter, qid);
>   

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

