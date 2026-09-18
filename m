Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0428852E;
	Fri, 18 Sep 2026 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715095; cv=none; b=Id1MnvlPBmWDYimHrPRY9IwqMFf2q2j6WdrqazAHJl6Gi88qr6ilTuVqHWwJSL3oG2BTBhju0uZZhkffqklvh4a26Zs/NFUkhow0KlroQnSBQrrPdW0Lcpa17r6KD6YfhdR3+hYUWHCXSu9VxpXNbYSFiZfxYNOhON3HlW2RSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715095; c=relaxed/simple;
	bh=hR+/QcjXLVBg/OA5uxcD0A1A2eJ0jNKsGFfieacRsdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgcqk8Gdrg2AXaipKBpmp6nwLHctVzh/P4VtXB1PDHnrU8NO2VS6gnTGuUi3mo5woTQ2r9Q5kvIq9HgMdHW6HKfTlNpOvP8GAcYF53o1G9nIi8KXPHb5DjDUXXTLo2Ko/yNa3T/C8c0OS8zSi6sILaSAZ7qYs5nS5rerdDmQtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OaNWEyyk; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OaNWEyyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TFXPRkcvIArOupySeAX0TcSgTELR2YOuovnW88kaN4E=;
	b=OaNWEyykQ2H3a9b9taiUfs0Ct8uJtuvU2o8mfGSjo5l5wGLXXEokbkyHrUexzg
	4lSzZe4p7bL2fG3DTUZrDQ5Xt6Pj5aku8XuiL9kWrqmw8PtojtrLJ2JrR13ez3SL
	QCJ8LmUP/PlQnQebRWrUlQaM+wDtEQW0wBexYGNi6vVKg=
Message-ID: <cf1a87f3-acd5-4959-bd42-b88b25f48311@126.com>
Date: Fri, 18 Sep 2026 15:03:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: ethtool: validate TX coalesce before
 reprogramming RX
To: Andrew Lunn <andrew@lunn.ch>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917131235.1360959-1-xiaolinkui@126.com>
 <15b8cbc2-f3ca-4845-9a93-7fff6c5aede6@lunn.ch>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <15b8cbc2-f3ca-4845-9a93-7fff6c5aede6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD33wE24qxqKV86Bg--.60104S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw45Wr43Zw4UtFWkKFWkCrg_yoW5GrWUpr
	Z5Ga4YkryDtr4Iqwn3Xa10qFyYq34xtFZ8Gr18tryfWrs8GF9Yqryaqr4rW3W7CrW0qrya
	qF4Duas7uan8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcBMNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBiMY2qs4jhZZwAA3B

Hi Andrew,

On 2026/9/17 23:05, Andrew Lunn wrote:
> On Thu, Sep 17, 2026 at 09:12:35PM +0800, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> __stmmac_set_coalesce() applies the RX part of the request first and
>> only afterwards checks the TX parameters. The RX path already calls
>> stmmac_rx_watchdog() and stores rx_riwt[] and rx_coal_frames[], so when
>> the TX check rejects the request the driver returns -EINVAL after having
>> silently changed the hardware. A following ethtool -c then reports the
>> new RX values even though the command failed.
>>
>> This became easy to hit once the per-queue interface was added.
>> __stmmac_get_coalesce() reports tx-usecs and tx-frames as 0 for a queue
>> index that is RX-only, and ethtool applies per-queue coalesce by reading
>> the current values first and sending them straight back. The next set is
>> therefore guaranteed to trip the test for both TX fields being zero,
>> right after the RX watchdog has been reprogrammed.
>>
>> Move both TX checks in front of the RX block so a request is either
>> applied completely or rejected without touching the device.
>>
>> Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 21 ++++++++++++-------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index 154cc0c7623d..325db062f72a 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> @@ -850,6 +850,19 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>>   	else if (queue >= max_cnt)
>>   		return -EINVAL;
>>   
>> +	/* Check the TX parameters before anything is applied: the RX part
>> +	 * below already writes to the hardware, so rejecting the request
>> +	 * afterwards would leave the device with only half of the settings
>> +	 * the caller asked for while reporting a failure.
>> +	 */
> 
> Why such a verbose comment? Look at the rest of the code and make your
> comments similar in verbosity.
Thanks for the review. You're right, the comment is far more verbose
than the surrounding code, and the rationale is already covered by the
commit message.

I'll shorten it to a single line in v2 and send it shortly.

Thanks,
Linkui
> 
>      Andrew
> 
> ---
> pw-bot: cr
> 

