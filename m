Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064438B7DC;
	Sun, 23 Aug 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484862; cv=none; b=VkaIIRHFUiZ8wmzMg/duRitDnUDn65AYYz8jU3TG+W7rqMzcdofxjdDzXWQsthoUoXNmoGhI7xBPpCFfa85xJp5vkDI66tlmo4cvc7f5IccqaqRoIlwPaoAEK0oq+Yrisb3ThTnmJW0amQgl9ZmNGQK5c7bWp6u11/aGhnMgivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484862; c=relaxed/simple;
	bh=5AMzwRSHFy8/KtpQeJXNdeP8+/orIEXCB3AWeJXAsZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rjl9j+laulUyviIJqmBii0UCePDXD5W53iJuaFcV2jAz25ZINtLfegnN0zu+ZFwZB0u5VdttPQTrblP+VrSoKZWOFKNnVlnlOytaaGuD1suYhUVdjf9JIRltCL6VJ6YOe1p3dvW0ok0Yfi+gwZ/VTe3+uXNmzP9Q6mvhnRGSYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9+JH6mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9+JH6mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DB11F000E9;
	Sun, 23 Aug 2026 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787484860;
	bh=pFjV8bi6kyHTViD5LKRs9iaQgt9ATvgARIa3LkNRVaU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=l9+JH6mTSB9k79lySgOP1yPjIho4JhikjAb+e2r6I6F8AJXJsjFfSswYvh6wV6hAO
	 LD+snPYihVcPIO1nODIIFPNGxeJn239dY6WQ5PaO1+9XEDNIUKKq7jMLUywacU+bXr
	 iJw0k1srfuWNwEX2jXgQWqEuCju60u3j5hn28OkUSmOrx3KuV/WVIEObH+YvTaNOH/
	 AiwLGnqIseB0qdm0D3BMPhsPVH/GiucFLAWHt2b+dYlCwINAIEc89Dr3N3/4mvWCyY
	 FpJkWQDSNDyVhOovNGBqD5Fhx4MPp3NOLCWd9KGUMsLNpXLgb44jP6amcoW/PYbsfq
	 2ODJIy+Q3TcBg==
Message-ID: <d989dda7-951c-4e4a-b251-aa5e97a6ebd7@kernel.org>
Date: Sun, 23 Aug 2026 13:34:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] thunderbolt: Cancel the DPRX read when the domain is
 stopped
From: Sven Peter <sven@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 stable@vger.kernel.org
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
 <20260817-b4-tbt-fixes-v1-5-eded2461f5fc@kernel.org>
 <20260818061717.GW893316@black.igk.intel.com>
 <1a51d323-8437-4d59-b185-710901eb9922@kernel.org>
Content-Language: en-US
In-Reply-To: <1a51d323-8437-4d59-b185-710901eb9922@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi,


On 8/21/26 19:58, Sven Peter wrote:
> Hi,
> 
> On 8/18/26 08:17, Mika Westerberg wrote:
>> Hi,
>>
>> On Mon, Aug 17, 2026 at 09:54:02PM +0200, Sven Peter wrote:
>>> tb_stop only tears down DMA tunnels so a DP tunnel that is still
>>> waiting for dprx_work to complete keeps that work queued while the
>>> routers are removed and the control channel is stopped. The work only
>>> stops once the DPRX timeout has passed and because it requeues itself
>>> until then the flush_workqueue in tb_domain_remove won't wait for its
>>> final run. The callback then runs against a domain that is already torn
>>> down. A reference to that domain is kept so the completion waiting for
>>> that domain to disappear in unbind will block until the timeout is
>>> eventually reached.
>>>
>>> Just cancel the work in tb_stop. This doesn't affect DP tunnels that are
>>> already alive and keeps those displays working.
>>>
>>> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel 
>>> activation asynchronously")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sven Peter <sven@kernel.org>
>>> ---
>>> I also didn't run into this but noticed it when fixing the hop alloc 
>>> thing
>>> and think it makes sense to fix it anyway.
>>> ---
>>>   drivers/thunderbolt/tb.c     | 5 ++++-
>>>   drivers/thunderbolt/tunnel.c | 9 +++++++++
>>>   drivers/thunderbolt/tunnel.h | 1 +
>>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>> index e368a6b53f64..f7e68372da09 100644
>>> --- a/drivers/thunderbolt/tb.c
>>> +++ b/drivers/thunderbolt/tb.c
>>> @@ -2958,10 +2958,13 @@ static void tb_stop(struct tb *tb)
>>>           /*
>>>            * DMA tunnels require the driver to be functional so we
>>>            * tear them down. Other protocol tunnels can be left
>>> -         * intact.
>>> +         * intact but a DPRX capabilities read that is still in
>>> +         * flight has to be canceled before the routers go away.
>>>            */
>>>           if (tb_tunnel_is_dma(tunnel))
>>>               tb_tunnel_deactivate(tunnel);
>>> +        else if (tb_tunnel_is_dp(tunnel))
>>> +            tb_tunnel_cancel_dprx(tunnel);
>> I prefer not to expose "non-generic" functions for the CM if possible. I
>> wonder if this would work:
>>
>>         else if (tb_tunnel_is_dp(tunnel) && !tb_tunnel_is_active(tunnel))
>>             tb_tunnel_deactivate(tunnel);
> 
> I think this might also tear down discovered tunnels because they aren't 
> originally set to active in tb_tunnel_discover_dp().

this is correct I think, but

> Only on the resume path tb_tunnel_activate() is then called on 
> everything in tcm->tunnel_list which will, because they have no 
> callback, then reach tb_dp_dprx_start(), take the synchronous path and 
> then finally end up in tb_tunnel_activate().

^-- is only true for the hibernation path:

nhi_freeze_noirq() -> tb_domain_freeze_noirq() -> tb_freeze_noirq() -> 
hotplug_active = false but nothing else, so tunnels stay in the list

and then on restore:

nhi_resume_noirq() -> tb_domain_resume_noirq() -> tb_resume_noirq() -> 
tb_tunnel_activate() -> tb_dp_activate(true) -> tb_dp_dprx_start() which 
then has no callback and takes the sync path.

while the non-hibernation suspend path ends up in tb_tunnel_deactivate() 
which drops it from tunnel_list and the resume path is fine then I think.


Sven
