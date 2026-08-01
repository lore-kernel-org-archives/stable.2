Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19E2FD7C3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785549422; cv=none; b=YUCK09ievDP660YmE4XiySfoxQU9aAq/sitRTos8UHi2TLa54Js0QrBVdIuO6za979ojiSL2Bfn7VG94zqWGADoC7Eptg8Y6INHXij00gqFafMZCh4gA0J7UFEX8Rswbg2/OFwXXTn9w6atpdkJ2KJTgMeljZoETyeo9ryRF0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785549422; c=relaxed/simple;
	bh=5nI1YV9oEDjrGDp7uwFQzuXVVhrxiw62jmY6XY6BHkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6tI6FLZDJYxWvdoKxDwfPOszU6ot1wzl+IswfHoGYb6lgdw0H/iq1jXM/XSSHx1Vkf5Vsw2NrKKAMCnWfBnWk47vgWaX8jiOlaa5tzCHrDCPFwO4Y2QVNskubYY1YmFsbbPKAKZ0oUgCybR8nGbvOrJIPbKP7cU55Pj8QteZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r5OV2WxL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r5OV2WxL"
Message-ID: <4f8e09bb-b6b0-4036-af0c-89306b48493d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785549407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOynNBRjq+0PgzyR7DZJL2Mfr0E7TAHDO2EaMZcNWUc=;
	b=r5OV2WxL4CgbwooswczjvgJ55IrmxVPc0HrEKma6rpOV8LpqyeNxxslo/smi3C7RFvp97k
	CKgfr3Db1s23lRXb7xnhAtdBhsqWNxVC+Yb4Bi1skOooHSGoka6WV0EzBCRU39Zwc2IrR+
	mlmM0UtlFRrEyIgmnN51OA7BvZTEzhs=
Date: Sat, 1 Aug 2026 09:56:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: ravb: fix use-after-free in ravb_get_ts_info
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
 sergei.shtylyov@cogentembedded.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260731063254.71260-1-xuanqiang.luo@linux.dev>
 <20260731182550.GA3091634@ragnatech.se>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260731182550.GA3091634@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/1 02:25, Niklas Söderlund 写道:
> Hello Xuanqiang,
>
> Thanks for your work.
>
> On 2026-07-31 14:32:54 +0800, xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> The PHC is registered by ravb_open() and unregistered by ravb_close().
>> However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
>> clock. Since the netdev remains registered after ndo_stop, get_ts_info
>> can still pass the dangling pointer to ptp_clock_index(), resulting in a
>> use-after-free.
>>
>> Clear the pointer after unregistering the clock and only query the index
>> while a clock is registered.
>>
>> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>> I don't have access to RAVB hardware to reproduce the issue. To aid
>> review, see the similar PHC lifetime fix merged as commit 8da13e6d63c1
>> ("net: macb: fix use-after-free access to PTP clock").
>>
>>   drivers/net/ethernet/renesas/ravb_main.c | 3 ++-
>>   drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 5f88733094d0f..3a9d9f8718216 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
>>   			(1 << HWTSTAMP_FILTER_NONE) |
>>   			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>>   			(1 << HWTSTAMP_FILTER_ALL);
>> -		info->phc_index = ptp_clock_index(priv->ptp.clock);
>> +		if (priv->ptp.clock)
>> +			info->phc_index = ptp_clock_index(priv->ptp.clock);
> While this avoids the lifetime issue, the fix is incomplete. The info
> structure will still report HW clock support but there is no PTP clock
> index.
>
> I have a pending series which cleans up most, if not all, of this issue.
> Could you check [1] and see if that covers your concern? I will post a
> new version of that series as soon as vacation time is over and the Gen4
> PTP driver itself is merged.
>
> 1.  https://lore.kernel.org/all/20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se/
>
Hello Niklas,

Thanks for taking the time to reply while on vacation.

You are right that my current patch is incomplete: it fills in the
hardware timestamping capabilities before checking priv->ptp.clock.

This should be straightforward to fix:
@@
-    if (hw_info->gptp || hw_info->ccc_gac) {
+    if ((hw_info->gptp || hw_info->ccc_gac) &&
+        priv->ptp.clock) {
          ...
-        if (priv->ptp.clock)
-            info->phc_index = ptp_clock_index(priv->ptp.clock);
+        info->phc_index = ptp_clock_index(priv->ptp.clock);
      }

I also checked patch 7/9 of your series. In the currently posted
version, ravb_ptp_stop() still does not clear priv->ptp.clock after
unregistering the PHC, while ravb_gen2_ptp_clock_index() calls
ptp_clock_index(priv->ptp.clock) unconditionally. Therefore, as
currently posted, the series does not appear to fully cover the UAF for
the Gen2/Gen3 paths.

As this issue predates the Gen4 work, if you agree that a small
standalone patch would be useful for fixing the UAF in stable kernels,
I would be happy to send a v2 including the change above.

Enjoy your vacation!

Best regards,
Xuanqiang

