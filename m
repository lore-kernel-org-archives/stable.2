Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5441A933;
	Mon, 20 Jul 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554596; cv=none; b=Fww/RVAXCNcm5b3TCEiS9b7oN0hUtlKBcu8miltzdck6uWjTDbmvepEd0tbQH+Dc103KE23plNnsixeMRQ2hknVFjUnIAE1+jEtZH55WkonbaYZ1Gv67Jfgav2kiJnP8f5i1ZG0SCZysfjvpwouDwcSUVO5cWJuoCxhgIZh+oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554596; c=relaxed/simple;
	bh=AOlhl4AViQk+vETqKgDUwbm1EhmwBFbpPGO30Kz346w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwlGci6ioSs/2LvsNDKJxnSEecjWfYJYw9WHkRwQH/ojLLp7S4nngq3m27Z8tLOjKHeiQkxPH1dv4Ikn2yiJyMbABhp/nPX8p4L7ExeckifNFs0tXQ+gDX+elyw9/W4f/Dlm/WkkftNzG77SqRzLUGNa0RLTiTrWvOstENybQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I//SSo4r; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I//SSo4r"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TpmgnPnv5gIqPomnCHRu1qnIVw5opQrOTvHoS59GWyQ=;
	b=I//SSo4rWlZXwek5Ynm1gX3MnDD9sLL0Nj1CwZt/AaNdp08A4etJkOuuKTaqriJTiWVqRWOkw
	rZN69x/JtDCnwgATflatWtlR58E3x4qaNnYHOI4J17xWOCE5KnLYiVk3b8augwRo+JHftd0sPrE
	kXs6Tm0kaOdk2e656wbcYws=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h3hBQ4wQRz12LFy;
	Mon, 20 Jul 2026 21:26:54 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A981202E6;
	Mon, 20 Jul 2026 21:36:29 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 20 Jul 2026 21:36:28 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <xuanqiang.luo@linux.dev>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <luoxuanqiang@kylinos.cn>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>,
	<wudi234@huawei.com>, <tengpeisen@huawei.com>, <shijing34@huawei.com>,
	<wulike1@huawei.com>, <chiqijun@huawei.com>, <ducheng11@hisilicon.com>
Subject: Re: [PATCH net v1 2/3] hinic3: fix use-after-free on DMA mapping failure
Date: Mon, 20 Jul 2026 21:36:23 +0800
Message-ID: <20260720133623.717-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260710090527.58354-3-xuanqiang.luo@linux.dev>
References: <20260710090527.58354-3-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

>  drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index 9306bf0020caf..5739ecb08d0d3 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> @@ -578,8 +578,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  		*wqe_combo.task = task;
>
>  	tx_info = &txq->tx_info[pi];
> -	tx_info->skb = skb;
> -	tx_info->wqebb_cnt = wqebb_cnt;
>
>  	err = hinic3_tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);
>  	if (err) {
> @@ -589,6 +587,9 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
>  		goto err_drop_pkt;
>  	}
>
> +	tx_info->skb = skb;
> +	tx_info->wqebb_cnt = wqebb_cnt;
> +
>  	netif_subqueue_sent(netdev, txq->sq->q_id, skb->len);
>  	netif_subqueue_maybe_stop(netdev, txq->sq->q_id,
>  				  hinic3_wq_free_wqebbs(&txq->sq->wq),

Thanks for your fixes, the proposed modification of the hinic3 driver has been
tested on hardware, and it works fine.

Reviewed-by: Fan Gong <gongfan1@huawei.com>
