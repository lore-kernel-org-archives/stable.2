Received: from mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A0425888
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972304; cv=none; b=KpnFOacBrb3uFu5a61Sho6dOUg7tCrPjwAKEJHYwCM+1cKPeU4RjJtqXEFnXP7XOYjEVvTGa+c1V5hYy7SUJc6vnuWBCAvHkOjNCHpiqQXMjE28rDF7GP6pKmXVgZgEXHUmbVC6JR6B5MyJXgkBOq1zfQRfd+fADSTnO1zYfXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972304; c=relaxed/simple;
	bh=iA5srvVkeBvjwt/oKVyedL29fZDrf4G88HAM0hvgjMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS69XGIuTkBllE+rUDGSLIDm7k5iju7SOxII57n4nVrv9MEmHOCnYuQORjrbrh0cumI2iBgbb/ku+CkiDW+PVxY87NjiQUmGVbn+28c0Woz7YfOyGuJcnGhgJLPTENtmMTaAOPc5gHMZL9rlJPbXGyzxImQ9tZ6rVRPW8c/fg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hv2TihzJ; arc=none smtp.client-ip=95.215.58.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hv2TihzJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iA5srvVkeBvjwt/oKVyedL29fZDrf4G88HAM0hvgjMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786972298; v=1; x=1787577098;
 b=hv2TihzJN6cUQz578KgznlGn2XO6jYiMV4Ck3FqMHjIGQlIKs2mTjdRDvBrqs47qha3eF6+R
 WA0kwZ8q+AdOEPmY6fNk1ti29VgOaMNXafefqoNf3DnnUkBjp9U36/y8xWmi9vJFSQutDjZUaX6
 IUu+vYOFcOZxTZUm8MCMBNmo=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::6:5429)
	by smtp.migadu.com with ESMTPS id a0bb66c1330947f5;
	Mon, 17 Aug 2026 13:11:38 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a7360a7e-6c42-4891-a01c-a349d1cb803a@linux.dev>
Date: Mon, 17 Aug 2026 14:11:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bnx2x: fix NULL pointer dereference in
 bnx2x_free_mem_bp()
To: Jiangshan Yi <yijiangshan@kylinos.cn>, skalluru@marvell.com,
 manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: yuvalmin@broadcom.com, dmitry@broadcom.com, ariele@broadcom.com,
 eilong@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 13667453960@163.com, Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260817033332.175665-1-yijiangshan@kylinos.cn>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260817033332.175665-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:33, Jiangshan Yi wrote:
> bnx2x_alloc_mem_bp() sets bp->fp_array_size before allocating bp->fp.
> If the fp allocation fails, the error path calls bnx2x_free_mem_bp(),
> which dereferences bp->fp in a loop bounded by the non-zero
> bp->fp_array_size, causing a NULL pointer dereference.
> 
> Move the bp->fp_array_size assignment to after bp->fp is set, and
> add a NULL guard in bnx2x_free_mem_bp().
> 
> Fixes: c3146eb676e7c ("bnx2x: Correct memory preparation and release")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260815122149.951215-1-yijiangshan%40kylinos.cn
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index 5b2640bd31c3..d84d1845a096 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> @@ -4712,8 +4712,10 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
>   {
>   	int i;
>   
> -	for (i = 0; i < bp->fp_array_size; i++)
> -		kfree(bp->fp[i].tpa_info);
> +	if (bp->fp) {

there is no need to put this defensive code ...

> +		for (i = 0; i < bp->fp_array_size; i++)
> +			kfree(bp->fp[i].tpa_info);
> +	}
>   	kfree(bp->fp);
>   	kfree(bp->sp_objs);
>   	kfree(bp->fp_stats);
> @@ -4742,13 +4744,13 @@ int bnx2x_alloc_mem_bp(struct bnx2x *bp)
>   
>   	/* fp array: RSS plus CNIC related L2 queues */
>   	fp_array_size = BNX2X_MAX_RSS_COUNT(bp) + CNIC_SUPPORT(bp);
> -	bp->fp_array_size = fp_array_size;
> -	BNX2X_DEV_INFO("fp_array_size %d\n", bp->fp_array_size);
> +	BNX2X_DEV_INFO("fp_array_size %d\n", fp_array_size);
>   
> -	fp = kzalloc_objs(*fp, bp->fp_array_size);
> +	fp = kzalloc_objs(*fp, fp_array_size);
>   	if (!fp)
>   		goto alloc_err;
>   	bp->fp = fp;
> +	bp->fp_array_size = fp_array_size;

... when you have fixed the root cause of the issue

>   	for (i = 0; i < bp->fp_array_size; i++) {
>   		fp[i].tpa_info =
>   			kzalloc_objs(struct bnx2x_agg_info,

