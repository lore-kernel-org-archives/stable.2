Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996220;
	b=Xdefx03kaSPEMWrh7tFsFnp/EOKMBRKwrzIXgWxaTAxNjGRmN8WGbYeJFxRJhW/A9bDf
	 Xduop4povEJQcR+IXCgOES1RqDscyNxehiInU13aJiKbYhedEhi3bZNF2s1BCMfcbhHRK
	 3dd6rRBa/GV6DXn0tfSoJD/4WvR1emzuTJTn6ImPjxKjSpzJcz5t6oKw1e19Hr7YESbWv
	 dNeKTWZgUnDtnNkVGRchTMDvB8IKqioS0TcEfd25Bk18r8JnSAbgvTjPvXYu4/dOgO7Dj
	 TgtKCXxZjt4+CDuo6y6dNh8y2vIfw9NxwYy5sOcalBtIvXNX7Y+tphTo3SqGUR4jRFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996220;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=E6Wjea5xNlseMIU1gabJ1JMwd0McL/hKQzFqGCqzeOU=;
	b=kzQGmEXgOT1KbCMrlHFN1dyHsOWhax7aZFtzJNa2NghUgKLbHFt23rn2P2UWczdywDnL
	 Fe7R8oiw8hvxiQwKyHpCY7DPnWe5Q6KHtCbuQf1y1bpA4JpYfKSpImukxVuMCkwyAjwu6
	 LR6nOENiWK/dZwTE3blomXKEkGjefM330hQZ7J9q1ttKRXVruMtcDX3miNgoTnPzDniEc
	 xpYSD3kNH79DBK8Jl0BvE2uFCfDswEsXC5XMyBuvSbEiB92koKOR3dSoocHgkmodhAPN1
	 3v4Ttf/4un1EkjUMwOb0RxEWYLYVay0ODRZifsH9WF3dhXKLafsAmNtxZtUqiAsyZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XjrPMthP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466AA606A32A;
	Wed, 18 Nov 2026 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466AA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XjrPMthP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15561596;
	Wed, 18 Nov 2026 02:03:36 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AEBA3F882;
	Wed, 18 Nov 2026 02:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794996219; bh=zFDjf1tMOA6qI/SmwbQt0R6XTPbVY8wCmM4cP6BRPJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XjrPMthPZZfI1pBWz21Dv7UZ9xPXCvUH9GxyzTikPLlrPxsm3gpOlQ9g+DNsUd2Co
	 BW9VbSH8/9g/5nUPh1Z0wFnR5ltkZUqfqSXj3dUaE1hzd0oi5vsFGywqUtIQB4EylE
	 VVeX7op+xub0tx2bTp4azVsAuuVLIRixMyPzBuxk=
Message-ID: <8b078536-4101-42d4-bbad-d251cedba4f0@arm.com>
Date: Wed, 18 Nov 2026 11:03:40 +0100
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
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
References: <ab81e90a-fdc4-426b-8da7-45b1a80e88f0@arm.com>
 <2026-11-17-1-daily-reply-0009@kernel.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <2026-11-17-1-daily-reply-0009@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/18/26 01:20, Sasha Levin wrote:
>> Instead of back-porting this patch too, we can just drop the (pointless)
>> error handling in this fix patch.
> 
> Thanks. Both of these (this one and the "propagate MSC access errors" one) stay
> as plain upstream cherry-picks, and 197a7a41e6e0 ("arm_mpam: On saving mbwu
> state read the monitors before clearing CFG_MBWU_CTL") applies on top of them
> as is, so no adapted backport is needed.

Sorry, but why? This patch (and the other) are complete churn as such, 
and introduce a lot of unneeded code to the stable branch. The adapted 
backport is very simple (just moving a single line within a function), 
which seems to me much better suited than pulling in three patches, two 
of which quite large and pointless.
I will send the stable backport patch ASAP.

Cheers,
Andre

