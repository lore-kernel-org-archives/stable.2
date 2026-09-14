Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C462EEE99
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356313; cv=none; b=qVvu9Jhm3wy8kUw3DFn2u8lPkLdMcD4jnvloZdCz28srVqOnx0TlBFNfpkIFMHnBijByxVFJMTO9m9tFdi8H0KFSfp5hFx0zHaMjTuiCKT8vqMpdC6apN64IJD1K1it+hrPDLKCigV7OanBPqzjisiOGX123CpqW+7hhQcTB3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356313; c=relaxed/simple;
	bh=WjqZVWhWelClT7YdgOmsrZ36uXsXlPIhwcyup00iM5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyJxUj/GvnX+WSQoGjL3QO1sHUFm4Jm6S7fdpg3wYkNnmwOmb06nSaz6jpU1BHupVnPG0KZZ0Nl9wNAMQvjPGepMcp7O3m00Y3tQh+II6DOIlFFfQMKnNqFyDYH9zLYdJpQzpHvoilmMgHOHpba2Yg+ZJnI1TYbWJ5DkI0ntiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WhHcIcjr; arc=none smtp.client-ip=91.218.175.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WhHcIcjr"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WjqZVWhWelClT7YdgOmsrZ36uXsXlPIhwcyup00iM5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789356306; v=1; x=1789961106;
 b=WhHcIcjrFG+DrZdPVh5p+F/gs8OGa61E8G3FYqLtkkELfxpl44fIoN6lFdRLXbJ0TvltFLRd
 6XfjsrauQFSlxWnSbTstjdoPQ6g/NDNBxYMtOhggR60ILRXcdS09QqLMh6JVJCw3VeAY+jt7FrS
 n8AQCw8JbQoI5RGr95HoAgEc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3ae4c64fb9fec7c0;
	Mon, 14 Sep 2026 03:24:56 +0000
X-Mizu-Trace-ID: 3ae4c64fb9fec7c0
X-Migadu-Flow: FLOW_OUT
Message-ID: <49df8a8c-c7a3-44a8-995b-0ec6fc194a3b@linux.dev>
Date: Mon, 14 Sep 2026 11:24:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: alb: Fix overflow in TLB gap calculation
To: lirongqing <lirongqing@baidu.com>
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260913125859.2349-1-lirongqing@baidu.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260913125859.2349-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/13 20:58, lirongqing 写道:
> From: Li RongQing <lirongqing@baidu.com>
> 
> compute_gap() shifts 32-bit values before converting them to s64,
> which can overflow for high speed network devices. The overflowed
> value is then incorrectly used in the TLB load balancing calculation.
> 
> Convert the operands to s64 before shifting so the arithmetic is done
> in 64-bit width.
> 
> Fixes: 097811bb48c7 ("bonding: optimize tlb_get_least_loaded_slave")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/net/bonding/bond_alb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 43ac8e2..b520040 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -160,8 +160,8 @@ static void tlb_deinitialize(struct bonding *bond)
>   
>   static long long compute_gap(struct slave *slave)
>   {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	return ((s64)slave->speed << 20) - /* Convert to Megabit per sec */
> +	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>   }
>   
>   static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)

This appears to have already been fixed by Hangbin Liu.

Please see:
https://lore.kernel.org/all/20260831-bond_overflow-v6-2-ffb0ed1f7268@kylinos.cn/
