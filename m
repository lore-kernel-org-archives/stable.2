Received: from mta0.migadu.com (out-112.mta0.migadu.com [91.218.175.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8523B52E7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730902; cv=none; b=bZiKQEvjtoqLJXGqTtOfykgfpCMR1aEMOXdASpRwhlXVWfPVXtl/xsFtZAwWSinqMRz9M6Mmf4f8Izv4RDin3tiL8coP4nRqkbfw2T7iBWtYvv4FwPZRMbxPmnmoZNNDdPkb8UD/aEcoy5L8tkck0a/RsRhU7JOjaPMU55nUjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730902; c=relaxed/simple;
	bh=SrqR7uAUH4PXd37yWoS/E0KE1OoqhoAelmP1GqzU7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cweG6kytZQm7BXEr5QJGgdzmXLA0/szGLsCkYIOBk5PK5YKD+GlrObd+9y7wpyZhPG3uN65EZJhqFVD4C28LS3RTzAFi+/bWn1I7T8faIAAVT9WsJh6bpl8iMEh2f3eGGBKaFvEFGDddfeod8Ukfz+VkdEsN0kyr+fPKrAWwjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fQLHzep3; arc=none smtp.client-ip=91.218.175.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fQLHzep3"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SrqR7uAUH4PXd37yWoS/E0KE1OoqhoAelmP1GqzU7EM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787730897; v=1; x=1788335697;
 b=fQLHzep3eFj19dEwRP184VkDP80ucw7tTa5Ex/ZOL5uqW5Gxuk+dlCLsuDseCjbhV/FqChku
 UWoX8eZXOz7rb9cT/p8GH56+jnwqz4/eL8AlWSQcv1mwktV9l5RtxnbVjtS6iDM035+kvfRYhQb
 ECaww7u9KRuK/BN3Cd7fHCpA=
X-Envelope-To: stable@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 7789bcaa3c5f2525;
	Wed, 26 Aug 2026 07:54:57 +0000
X-Mizu-Trace-ID: 7789bcaa3c5f2525
X-Migadu-Flow: FLOW_OUT
Message-ID: <b75e9ae4-ba79-4c0b-a3c5-da270de0b75b@linux.dev>
Date: Wed, 26 Aug 2026 15:54:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after
 unbind
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
References: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
 <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
 <749d7a16-df31-4bcc-822b-3153fc69d072@linux.dev>
 <667fb4ef-0822-432f-ad0e-aeb4bf66dccf@lunn.ch>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <667fb4ef-0822-432f-ad0e-aeb4bf66dccf@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

在 2026/8/25 21:03, Andrew Lunn 写道:

> On Tue, Aug 25, 2026 at 11:34:04AM +0800, Xuanqiang Luo wrote:
>> Hi Andrew,
>>
>> 在 2026/8/24 20:54, Andrew Lunn 写道:
>>
>>>> The IRQ is requested at attach time and released by phy_disconnect(),
>>>> so phy_remove() cannot free it without a later double-free.
>>> So this sounds wrong.
>>>
>>> If you unbind the PHY, you need to also unbind the MAC, since a MAC
>>> without a PHY is useless. When the MAC unloads, it will call
>>> phy_remove() so everything unwinds in the correct order.
>>>
>>>       Andrew
>>>
>>> ---
>>> pw-bot: cr
>>> 	
>> I agree that the MAC should normally be unbound before the PHY.
>>
>> Also, the paragraph about freeing the IRQ in phy_remove() was
>> misleading. It was not relevant to the change being proposed,
>> so I will drop it in v2.
>>
>> Do you mean that unbinding the PHY first through sysfs is not a
>> supported operation?
> To me, unbind is an odd thing to do. What is your use case?

I don't have a real use case for unbinding the PHY while keeping the
MAC bound. I found this during code review and used sysfs unbind to
reproduce the crash.

> When doing development work, i tend to reboot the target. If not, i
> would unload the MAC driver and the PHY driver, to ensure i have a
> clean state.
>
>> The same sequence was used to reproduce the issue fixed by commit
>> c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver is
>> unbound"), which made me think that it should at least not crash:
>>
>> https://lore.kernel.org/all/20200917034310.2360488-2-f.fainelli@gmail.com/
> A crash is not good.
>
> But we also need to look, is the fix the correct architecturally, or
> we are actually making it worse. Drivers have function pairs. A
> function which does setup, and a mirror function which does
> tairdown. A function to bind to a MAC and a mirror which unbinds from
> a MAC. That symmetry makes drivers simple, easy to reason about.

Thanks for clarifying. I agree.

> Does this problem happen if you keep to the symmetry?

No. I checked the normal teardown path, and the problem does not occur
when the symmetric teardown order is followed. This is expected.

> Does your fix to this problem make the symmetry worse?

The normal teardown path is unchanged, but the patch allows the
asymmetric state created by a PHY-first unbind to continue with the IRQ
still installed. From that point of view, the fix is wrong.

> If unbind were to cause the MAC to unload, is the symmetry kept?

Yes. I agree that this is the right direction. I will stop here and
think more carefully about how to enforce the ordering before posting
another version.

Thanks,
Xuanqiang

