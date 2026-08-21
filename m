Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12135F60E;
	Fri, 21 Aug 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335101; cv=none; b=NzVBC+141Ig0kMnUObJ5judQAutTbi2B5hiAD9LKecO+R9eIfoJPYCqFWw/q8g1jheyD+IdwHevjJ3pvEXJDIWKJ8/xy04twPaZlnFqTW3tYH+IwuBt0Q/TgHr6hyoYm3zlD85MxqfAXxAfzQlnNmRREBWXMTXy5l6c3W1bQ0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335101; c=relaxed/simple;
	bh=IuvXl22zqV1mpWxgbDnK2t4/VY68QqAPCkUvcMS60HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZPT+XFgZ6mXjkUU0jP3dYhUYDKsjT/Zb4oGaWgjvC3rE0rNIyUlV+5NkdeLhf/yTQXiBqSeE1rFRxz2gSXntxtk1cLRLyk2SS7TCjjwHWlnzArAsu7j+MB6vVmTG1hQfrwHbKps3RN2ua1K8HvQcee1wRYYNNLGk3bBIb9u48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrSoXhLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrSoXhLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3FB1F000E9;
	Fri, 21 Aug 2026 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787335100;
	bh=qzKSa1SgH7pGsOvdpuCR/HK4FY/wDBHvqCO83CUMiGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mrSoXhLC4ZBTPLJAxC18QFdYI7wyG6FgBHv5TvBr3JsZrlTzfSUdVZlpUV0PWA4iI
	 M3iTA0Fs/tVV+8UkcK8fm+QpTOPqfleklUS6+5nKcG3S1bsRRZw4W+2JDoo+WhRyE5
	 GN9mrK2WJM3NKc0yXiEDDh46E8Uh2a4qCyrX8efD/5lAr48CGusxysL2uOxonRTEoI
	 Jpt3Y/yC9ncnPhZni7RhNHpDNP/WQvAsa6z5iGh8QKTptwtfkgRAFdCVzTIv7Sjmnx
	 mzOio1eOhbZBAJdsrJse5mle5Lt9s+oDQBdbwP8fyb5esKitMzve7x8UHuCD4qsFlS
	 6FT7N8PvGHS5Q==
Message-ID: <1a51d323-8437-4d59-b185-710901eb9922@kernel.org>
Date: Fri, 21 Aug 2026 19:58:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] thunderbolt: Cancel the DPRX read when the domain is
 stopped
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 stable@vger.kernel.org
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>
 <20260818061717.GW893316@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260818061717.GW893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/18/26 08:17, Mika Westerberg wrote:
> Hi,
>
> On Mon, Aug 17, 2026 at 09:54:02PM +0200, Sven Peter wrote:
>> tb_stop only tears down DMA tunnels so a DP tunnel that is still
>> waiting for dprx_work to complete keeps that work queued while the
>> routers are removed and the control channel is stopped. The work only
>> stops once the DPRX timeout has passed and because it requeues itself
>> until then the flush_workqueue in tb_domain_remove won't wait for its
>> final run. The callback then runs against a domain that is already torn
>> down. A reference to that domain is kept so the completion waiting for
>> that domain to disappear in unbind will block until the timeout is
>> eventually reached.
>>
>> Just cancel the work in tb_stop. This doesn't affect DP tunnels that are
>> already alive and keeps those displays working.
>>
>> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>> I also didn't run into this but noticed it when fixing the hop alloc thing
>> and think it makes sense to fix it anyway.
>> ---
>>   drivers/thunderbolt/tb.c     | 5 ++++-
>>   drivers/thunderbolt/tunnel.c | 9 +++++++++
>>   drivers/thunderbolt/tunnel.h | 1 +
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>> index e368a6b53f64..f7e68372da09 100644
>> --- a/drivers/thunderbolt/tb.c
>> +++ b/drivers/thunderbolt/tb.c
>> @@ -2958,10 +2958,13 @@ static void tb_stop(struct tb *tb)
>>   		/*
>>   		 * DMA tunnels require the driver to be functional so we
>>   		 * tear them down. Other protocol tunnels can be left
>> -		 * intact.
>> +		 * intact but a DPRX capabilities read that is still in
>> +		 * flight has to be canceled before the routers go away.
>>   		 */
>>   		if (tb_tunnel_is_dma(tunnel))
>>   			tb_tunnel_deactivate(tunnel);
>> +		else if (tb_tunnel_is_dp(tunnel))
>> +			tb_tunnel_cancel_dprx(tunnel);
> I prefer not to expose "non-generic" functions for the CM if possible. I
> wonder if this would work:
>
> 		else if (tb_tunnel_is_dp(tunnel) && !tb_tunnel_is_active(tunnel))
> 			tb_tunnel_deactivate(tunnel);

I think this might also tear down discovered tunnels because they aren't 
originally set to active in tb_tunnel_discover_dp().
Only on the resume path tb_tunnel_activate() is then called on 
everything in tcm->tunnel_list which will, because they have no 
callback, then reach tb_dp_dprx_start(), take the synchronous path and 
then finally end up in tb_tunnel_activate().

I think setting them to active in _discover is the correct thing to do 
here and should be fine, but I'm still not familiar enough with the code 
to know if this has any other side effects.

This is probably another reason to just make the callback mandatory and 
run it on resume as well so that we're not stuck for ~12 seconds in the 
synchronous path there in the worst case.


Best,


Sven

