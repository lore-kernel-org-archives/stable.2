Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.0.225.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915855;
	b=KtZ0tQpi7nlt1fE1Un8cYkBWJjbuX7r+mNKzDEkh1kv1/T/v0uB8lKAoUCmANjU5q1I/
	 K+wrpeKBS/145P5xzvH0xtusmlVZysICpLBbN/ndY14ztC5UPXoDLrJjWNPmd8vyS0kze
	 PI8zh6CsHN0RVk32fEmF982jJOvBCHNAlCn8u2yf3ElkRM+i7Un8jH4umedWDjvcov5SD
	 3gELWMBzsOpRWxtGhieIVkTV7TcWKbKxqHHTG/2LrNUlggd1kC5jFXMvJ6Rp8Lxb1zx/n
	 FcAHNdu887qPJVqR7RAP6xQVn2Qpc0MAptMqznzr9LTUGFQAswXLRu55nqEEpJNyNYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915855;
	h=DMARC-Filter:Received:Received:Received:X-Eyou-Smtpauth:
	 X-Eyou-EnvelopeSender:X-Eyou-From:From:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Eyou-Sender;
	bh=CnFWtmTzB6e1lCB3/JvbUr6eRBMHKOdxJBcATu0Xry4=;
	b=aznc3XqL5RPT1DKItsPLyIl7DZ2lxdMo53iaMGFK8iZLRfnwh4bTzKXhT67nOQfRNwfR
	 CvXg/Lsu7s5XrkOQ4yzdR2FIr9I28lKxB24hOusxPzTnUzu+ZKR0rxjBgiI84GDExKYwZ
	 cMfI82HsoaNe62DmPIKZ2HB96oWJ27LSzBY3PqFRIIzFXhSBcGwS/ClxD4Rxd8aOx9FLw
	 uoP3b9KvwhjuzBVlZssQn30NCb7CWF6gGG3oPlTKpyILPatueC4/krz1xQzL8KFOlw0kd
	 Dy2KRYLCibcboLID9DINcHAURvWFaQd8fH0H1a0hQBLE41iycvDhldcoB0RxZrgqs0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zhaoxin.com;
	spf=pass smtp.mailfrom=zhaoxin.com;
	arc=none smtp.remote-ip=210.0.225.12
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D624606A31C;
	Tue, 17 Nov 2026 11:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D624606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4jTNDL0wN3zb0pbW;
	Tue, 17 Nov 2026 19:44:02 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4jTNDK4Yq0zb0pbW;
	Tue, 17 Nov 2026 19:44:01 +0800 (CST)
Received: from [10.29.8.50] ([10.29.8.50] [10.29.8.50])
	by zhaoxin.com (8.30) with ESMTPa7a6895ed00357bec528d64555ac5126
	Tue, 17 Nov 2026 19:44:01 +0800
X-Eyou-Smtpauth: weitaowang-oc@zhaoxin.com
X-Eyou-EnvelopeSender: weitaowang-oc@zhaoxin.com
X-Eyou-From: zhaoxinweitaowangoc <weitaowang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <weitaowang-oc@zhaoxin.com>
Message-ID: <455b3899-386f-4731-8508-afcecff1a90c@zhaoxin.com>
Date: Tue, 17 Nov 2026 19:44:00 +0800
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
Subject: Re: [PATCH v3] x86/apic/msi: Fix MSI interrupt affinity configuration
To: Thomas Gleixner <tglx@linutronix.de>, Koichiro Den <den@valinux.co.jp>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
 <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
 <87jynid352.ffs@fw13> <316900d3-2ce8-4391-ad8f-556bb5540c2a@zhaoxin.com>
 <87bj8uc7rv.ffs@fw13> <a6c0d634-f16b-4999-9e04-f13b123d195b@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <a6c0d634-f16b-4999-9e04-f13b123d195b@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>

On 10/16/26 19:58, WeitaoWang-oc wrote:
> On 10/16/26 17:30, Thomas Gleixner wrote:
>> On Fri, Oct 16 2026 at 11:36, WeitaoWang-oc wrote:
>>> On 10/16/26 06:12, Thomas Gleixner wrote:
>>>> On Wed, Sep 30 2026 at 01:29, Koichiro Den wrote:
>>>>> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>>>>>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>>>>>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>>>>>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>>>>>> race. Maskable MSI interrupts use the direct path to update configuration
>>>>>> info. However, the current code logic is the opposite as only maskable
>>>>>> MSI interrupts will enable reservation mode.
>>> Thank you for the suggestions. I realize the problem description in my
>>> previous patch needed to be more precise. Before posting v3, I have
>>> updated the change log as shown below. Could you please take a look?
>>> If this looks good to you, I will send out the next version.
>>
>> Looks good
> Hi Thomas,
> 
> I've reworked the changelog as you requested. The correct version is
> the v3 sent at 18:10 UTC (Message-ID:
> 20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com,
> https://lore.kernel.org/20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com/),
> which includes the changelog and Cc to stable. Please ignore the
> earlier v3 from 18:06 UTC. Sorry for the noise.

Hi Thomas,

A gentle ping on this patch. I sent the corrected v3 on
2026-10-16 18:10 UTC (Message-ID:
20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com),
with the reworked changelog and the Cc to stable you asked for.

Is there anything else you would like me to address before it
can be picked up? I am happy to respin it if the current v3 no
longer applies cleanly, or to adjust the changelog further if
the wording is still not what you had in mind.

Thanks for your time,
Weitao

