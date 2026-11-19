Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100612;
	b=nMsUUnEX1PGa95Uoi3rmZhAVQvFFYgpVxJsJN1cxXF7Wtiu1i/lj0XqiNgGoR8Tziv1O
	 WSXEf6BrvhM6r2Nn8eFFGyKxerx0MfYSMcqwN6a7+iSdhiqIl4hpJhkfkg44tKbUkIw74
	 njdTn94DuXq3bc/pLGsoBR/OSocEuHHdVcad2CQIlJd2k/AJ1dLZcsdnxYTQ5p7BHj94Z
	 /9Kig8g8l1993u1jwajAlNImU+WXNywffBJBH6CWjHHg+Nr/yjVP0LYrm05U3Av0mmJpG
	 p3zq8i753Yw9/uaBq1b2prkCut8rQ4ED1fUudp2/cLNvIRv3d0d9QnFoJLxXcwzr3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IvXht9rKxgXPMf5xVPL2KCxkW3rV79KskWZxHYkWX/M=;
	b=1RNWXMr3usj2aCopGvvT+OLnfXzNKb27kI26DclmHXvUClhQxsPr4/ULSqUl29z7dqsH
	 dVVrjFKpHkhtnwVGwmhFlr3a5SPtoIo4H+bSGNYKdIJq3fCaJpcgAIu5MxJhChQO4DGO0
	 Ra4z7FF/OkZAT4N4p5Ne9tobRc/DkVmFO/sUxbpPwNNsVF6G8CS9a2quw6A2Wpq/+R/Ui
	 Cy8OC8WNPzdeiqOf9pgX62Bhljb04Lg4oycJSLFXi0VJuipS8Nr2c1F4nWl7CTuIbKOWb
	 ohsUx310BBgD/9cFQd9V/7tm7yBzRgb1ef3lw+eeuoMgEJRDdXjfA4Zye51CpzePO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oISKYwkY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E47606A326;
	Thu, 19 Nov 2026 15:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E47606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oISKYwkY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293171575;
	Thu, 19 Nov 2026 07:03:28 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C725D3F882;
	Thu, 19 Nov 2026 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795100611; bh=gRyRX+lqJrdSAjmhZqLOmUIsf/m7p4kFu+2CzAVJ0pg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oISKYwkYfAmZdcTNIxOqgLieQPrT1J9kR2R/8TYZPdmiZP2XI9V9Lz9wPPHm0V6x9
	 Dz08TtGGK7u3u6p1IwKOFfMiHldz7VBHA1XxbZDziqj/X+tXAl+uGywKXY8dv7qdvu
	 XqqdkrZ149lSNfyanoAFTZQkHNJRR8duCTmbLdOE=
Message-ID: <e943446d-a563-471f-81a8-1a69d3884097@arm.com>
Date: Thu, 19 Nov 2026 16:03:28 +0100
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
Subject: Re: Patch "arm_mpam: let low level MSC accessors return an error" has
 been added to the 7.3-stable tree
From: Andre Przywara <andre.przywara@arm.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
References: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com>
 <2026-11-17-1-daily-reply-0009@kernel.org>
 <8b078536-4101-42d4-bbad-d251cedba4f0@arm.com>
 <20261118124002.3727477-3-sashal@kernel.org>
 <cd17d0fc-2859-4969-9677-692aaa2db0b7@arm.com>
Content-Language: en-GB
In-Reply-To: <cd17d0fc-2859-4969-9677-692aaa2db0b7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 11/18/26 17:48, Andre Przywara wrote:
> Hi Sasha,
> 
> On 11/18/26 13:39, Sasha Levin wrote:
>> On Wed, Nov 18, 2026 at 11:03:40AM +0100, Andre Przywara wrote:
>>> I will send the stable backport patch ASAP.
>>
>> Dropped 84e8795c271a ("arm_mpam: let low level MSC accessors return an 
>> error"),
>> a3a94c13c442 ("arm_mpam: propagate MSC access errors for state saving
>> function") and 197a7a41e6e0 ("arm_mpam: On saving mbwu state read the 
>> monitors
>> before clearing CFG_MBWU_CTL") from the 7.3 queue. I'll pick up your 
>> adapted
>> 7.3 backport of 197a7a41e6e0 once it's posted.
> 
> Thanks! It turns out that this backport patch here logically depends on 
> another fix (197a7a41e6e0, you mention above). So I need a bit more time 
> to figure out what's exactly going on here, will try to send something 
> tomorrow.

Ah, because there are almost a dozen of MPAM patches now being 
backported into v7.3.y, the context differs slightly, depending on the 
base, but it all works out cleanly on top of v7.3.6-rc1.
Will send the backport fix in a minute.

Cheers,
Andre

>> Also dropped 643b64025650 ("arm_mpam: Release the mon_sel lock on
>> mpam_save_mbwu_state() errors"), which needs the mon_sel_lock guard 
>> class that
>> 7.3 does not have.
>>
> 

