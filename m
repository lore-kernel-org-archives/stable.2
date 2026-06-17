Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1A49252B;
	Wed, 17 Jun 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708657; cv=none; b=gEiOmUr0+9aJBvKn4I3NsgOgWK9JfSf8BBCuWGsn70kzWMF3KKFqJZ66/KYN+exPKvO5H1EPB6kog5AFIEPYEtLCRNvN0NWNxKqJXTO6vZVICeEDPVjjTFL0GnjYYndjzdB1A7X3dvKsVzaNr6DdmJeqemV3Ww3mKUzuj4CYPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708657; c=relaxed/simple;
	bh=pjjp4MzWZ8FDUOpytnawP/n+vVA2Ar/oBkUxx2Mh0gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHCwILCpYeQaPfoWtPOV51awF7fTDN4rdWqQ9aVEZVTkyqmDEmfCCNi96bYNmggJUKzuzR9Nw6BBn1RvFZ0UhEWI6axgXc7bEuD445uJO7/NL5Wt8Ke9+Y2y1pcZkmNe8zQXofEhTW+vmphYGTDbluPwX1DTA3pqXxrKr2Tu3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7VBZWx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7VBZWx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F63A1F000E9;
	Wed, 17 Jun 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708656;
	bh=ghd9wTzINh2dtZPrT9KDc2aPUFeLgpcJQbubFr7vwtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=g7VBZWx6G1v0yjwE4S5A+2flB8u8FDeIBVSm6mcC2cCGY98LWPpuu8PdFUm2cNnNp
	 PfMv5D9fdj6LXXJnL8NSii2Suj1pRSk3rV/L7+hs1WUok8AqLUPzborcE2xFTPeJP8
	 utETkERJvyOkaLKtNX+tQtk4ICc8/ZJLnqgEsBU9zt00VtVYxViyAMQ6MdXGSSc3+D
	 SCXzPSLynWVR/FyEWX/HZP7jEZ6ZUrt78dUM+djx1shEciKUvOOJNnjsgkvMfybp2+
	 tO+6PZXhy78+xtFReBDcn86IkO9uW7wecclHeu+vqAmq/gPyCKSKED4YisMztmJFdH
	 t9jzfsmuqPlKQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Teddy Astie <teddy.astie@vates.tech>, stable@vger.kernel.org,
 x86@kernel.org
Subject: Re: [tip: timers/core] time/jiffies: Register jiffies clocksource
 before usage
In-Reply-To: <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>
References: <87y0gn3fve.ffs@fw13>
 <178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
 <CGME20260616184701eucas1p13c7aff447073832095aa4adfb85935f0@eucas1p1.samsung.com>
 <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>
Date: Wed, 17 Jun 2026 17:04:12 +0200
Message-ID: <871pe5dx8z.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 16 2026 at 20:47, Marek Szyprowski wrote:
> On 13.06.2026 15:28, tip-bot2 for Thomas Gleixner wrote:
>> The following commit has been merged into the timers/core branch of tip:
>>
>> Commit-ID:     f24df84cbe05e4471c04ac4b921fc0340bbc7752
>> Gitweb:        https://git.kernel.org/tip/f24df84cbe05e4471c04ac4b921fc0340bbc7752
>> Author:        Thomas Gleixner <tglx@kernel.org>
>> AuthorDate:    Tue, 09 Jun 2026 17:14:45 +02:00
>> Committer:     Thomas Gleixner <tglx@kernel.org>
>> CommitterDate: Sat, 13 Jun 2026 15:22:40 +02:00
>>
>> time/jiffies: Register jiffies clocksource before usage
>>
>> Teddy reported that a XEN HVM has a long boot delay, which was bisected to
>> the recent enhancements to the negative motion detection. It turned out
>> that the jiffies clocksource is used in early boot before it is registered,
>> which leaves the max_delta_raw field at zero. That causes the read out to
>> be clamped to the max delta of 0, which means time is not making progress.
>>
>> Cure it by ensuring that it is initialized before its first usage in
>> timekeeping_init().
>>
>> Fixes: 76031d9536a0 ("clocksource: Make negative motion detection more robust")
>> Reported-by: Teddy Astie <teddy.astie@vates.tech>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Tested-by: Teddy Astie <teddy.astie@vates.tech>
>> Cc: stable@vger.kernel.org
>> Link: https://patch.msgid.link/87y0gn3fve.ffs@fw13
>> Closes: https://lore.kernel.org/all/1780914594.8631fc262581453bbf619ec5b2062170.19ea6c8227b000701b@vates.tech
> This patch landed recently in linux-next as commit f24df84cbe05 ("time/jiffies:
> Register jiffies clocksource before usage"). In my tests I found that it triggers
> the following warning on Qualcomm Robotics RB5 board
> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts):

Fix is queued already.
