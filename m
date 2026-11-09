Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196420;
	b=RCKUQT+t5RIxbVOBs24U6rEcNy35NY3APAJqDRWu4ZJIvLu9eEHZmC9UzA/JEkaYe03D
	 2UZRQvnmSP8FKon3wslB59YA3fcN8b7N1D7ubU8TV9FrvY2MrnNK5wgk1bMi03rcD8hFX
	 eLNlUQQTzPIi8vc3dze3Z2FOQQYQXzYn4mQlem007KrgvXBZZPNYOlHrQjPQA/uxp6BMj
	 82j9frg2fLHZQJP1tPEBi8rbup7Cqsd+1WHLRVk2n1quZmPMM3t9ZYrTIPK0FYqAimUIB
	 1rblMBHNi9rScCDdT8J7nWb0Ex6XddyqJrkXLYIzQzQpNGlL0EtAlvjQInMpOZfBVeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196420;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ocFCQgnrZq3E5Wbo1k9gqSh7z9YgYKQWe52cQlkZ0UY=;
	b=D04ABXFc2UNv/dNwgJVLh8IsOBD8MDP9wjm6LkeGMRI/PmQao1tFizlMy3waRtqyAiUC
	 4PUkU4qmzbtt+l7uyKV0qEwfGfLduAwXpO3+KtAOlfU5A3qcubYnUAzrz7R7mAbFiVlF6
	 enHOKpg6y+qLjX5KsbicOaSsGz1EhA+asfVPd/1VMW28qfRgvTkAI1Vyr9qqRAzpr/dB4
	 DP+gjGPkoW0zZFJBXVyHRcTHz5umgD2dkX5WjwHxo4ReSzNyu0o6mhLu+L3B/DpULlBn1
	 6t3DN6/5lynJFXyy5oPcTJbcfXeN+bk48brJ2d8t2/mc/diBxEOuO748K4f5F3lnmHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="j3k/9zr+";
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD9606A321;
	Mon,  9 Nov 2026 03:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6FD9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=j3k/9zr+
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ocFCQgnrZq3E5Wbo1k9gqSh7z9YgYKQWe52cQlkZ0UY=;
	b=j3k/9zr+dycy+lXORykPB/5NLz64SLNuB8rO6NKovP51s9fnn/ynKVAK3Qm2RIf76oOdsMEFF
	yIq+ywaZnhHVv5J6PX1fHbTCmZSY+SMfHZ+MK+h8BdDp2JPlL8ozUip2kjNdnfyaPzjYnLRqNAA
	Ebf5kGRi0Y+RLv2yxvhz7hY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jNG923mM2zKm7F;
	Mon,  9 Nov 2026 11:53:26 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 28C3440580;
	Mon,  9 Nov 2026 11:53:35 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 9 Nov 2026 11:53:34 +0800
Message-ID: <e4ce40a0-2bcc-4be9-8697-797c84275cc7@huawei.com>
Date: Mon, 9 Nov 2026 11:53:33 +0800
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
CC: <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: destroy the page pool if RX buffer allocation
 fails
To: Simon Horman <horms@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
References: <20261103100533.1310018-1-vulab@iscas.ac.cn>
 <20261106180307.GM865646@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20261106180307.GM865646@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/11/7 2:03, Simon Horman wrote:
> On Tue, Nov 03, 2026 at 10:05:33AM +0000, Wentao Liang wrote:
>> hns3_alloc_ring_memory() creates the page pool and then fills the RX
>> ring with buffers from it. If filling the ring fails, the error path
>> only frees the descriptors and the descriptor callbacks, so the page
>> pool created a moment earlier is leaked.
>>
>> The page pool is normally destroyed by hns3_fini_ring(), but
>> hns3_init_all_ring() only cleans up the rings that were set up before
>> the failing one, so the pool of the failing ring is never released.
>>
>> Destroy the page pool on the buffer allocation failure path too.
>>
>> Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
>> Cc: stable@vger.kernel.org
>> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 47788be64be6..fe339ddc6379 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -5073,6 +5073,10 @@ static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
>>   
>>   out_with_desc:
>>   	hns3_free_desc(ring);
>> +	if (ring->page_pool) {
>> +		page_pool_destroy(ring->page_pool);
>> +		ring->page_pool = NULL;
>> +	}
> The condition is not necessary as as page_pool_destroy is a no-op when
> passed NULL. Please remove it to simplify the code-flow.

Hi Simon, Wentao,

Agreed, good catch. I am fixing the same leak in my series:
   https://lore.kernel.org/all/20261030095633.377289-3-shaojijie@huawei.com/

My v3 had the same redundant guard, and v4 will drop it, since
page_pool_destroy() already handles NULL and out_with_desc is only
reachable from the RX branch.

Wentao, thanks for your work on this and for tracking down the
duplicate. Sorry you had to withdraw it.

Thanks,
Jijie Shao


