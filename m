Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163852D9ECA;
	Fri, 16 Oct 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151907; cv=none; b=HEwlPHp2YEDyuJhmSdRcVi68p/6civlv49IZlFYx5nD2IkCNp53F6lH4fT+7uTs5rNJwvUb2gzE7PeSxE/QJcmUDymYVMXJNKKI38EgFr9RhecTvU0zZj7IDC7YohePZXvIvk6fbrl06rVLSX5wiXzl32kz0MMk1AV+jx8mYl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151907; c=relaxed/simple;
	bh=AcYGRXY36UAanRTnTVInPJm63pgo4pGI7wWIYwP9gAw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y/w/ETHrPwDJTKQGQPnprtHlI/FesjOrQ5FlmSFi75tf7e/9IT8m71wpLhiY2ia328wsf0uapDzcme+Oi/PmO2YTravGTVzMbXRd0sq8xPyUggEzR9WU0A5aWPbjhBg+q6X+sNSdvkQjJwgLO1RBJOEUWL2cN2eEl9iRH/SfNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5k3c2l0Wzb0pbk;
	Fri, 16 Oct 2026 19:58:20 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5k3c1h8Szb0pbf;
	Fri, 16 Oct 2026 19:58:20 +0800 (CST)
Received: from [10.29.8.50] ([10.29.8.50] [10.29.8.50])
	by zhaoxin.com (8.30) with ESMTPec4f970a45a5b88e734c302ee7f55106
	Fri, 16 Oct 2026 19:58:18 +0800
X-Eyou-Smtpauth: weitaowang-oc@zhaoxin.com
X-Eyou-EnvelopeSender: weitaowang-oc@zhaoxin.com
X-Eyou-From: zhaoxinweitaowangoc <weitaowang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <weitaowang-oc@zhaoxin.com>
Message-ID: <a6c0d634-f16b-4999-9e04-f13b123d195b@zhaoxin.com>
Date: Fri, 16 Oct 2026 19:58:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
 <87bj8uc7rv.ffs@fw13>
Content-Language: en-US
In-Reply-To: <87bj8uc7rv.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>

On 10/16/26 17:30, Thomas Gleixner wrote:
> On Fri, Oct 16 2026 at 11:36, WeitaoWang-oc wrote:
>> On 10/16/26 06:12, Thomas Gleixner wrote:
>>> On Wed, Sep 30 2026 at 01:29, Koichiro Den wrote:
>>>> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>>>>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>>>>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>>>>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>>>>> race. Maskable MSI interrupts use the direct path to update configuration
>>>>> info. However, the current code logic is the opposite as only maskable
>>>>> MSI interrupts will enable reservation mode.
>> Thank you for the suggestions. I realize the problem description in my
>> previous patch needed to be more precise. Before posting v3, I have
>> updated the change log as shown below. Could you please take a look?
>> If this looks good to you, I will send out the next version.
> 
> Looks good
Hi Thomas,

I've reworked the changelog as you requested. The correct version is
the v3 sent at 18:10 UTC (Message-ID:
20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com,
https://lore.kernel.org/20261016181016.3850-1-WeitaoWang-oc@zhaoxin.com/),
which includes the changelog and Cc to stable. Please ignore the
earlier v3 from 18:06 UTC. Sorry for the noise.

Thanks & Best Regards,
Weitao

