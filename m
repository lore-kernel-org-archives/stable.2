Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A2EA754;
	Fri, 31 Jul 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505788; cv=none; b=ru6BNnzoaA78n9gj7VvVbhdO5JYlqThrBfHD1jIOQd7PZMT9inSGwnByis3onW+KGxqqBW5WRTqv140uPWaHn36oKPoGoER76ySQH5M+6XDoJM+3goU3oIKavHaV3kU8kXDIuAOJ5H0e+LmH+lQ2ne6S8ydb15poTX6iGB49rxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505788; c=relaxed/simple;
	bh=gGYLf1iDG26xIDtAy2i2QMPBNDaw6xLy7oeZTxFn0vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1IntrFLCQDFl5c0QB2W9eMZul7Sr6cyE/2cFejNvFj5ZWBannygMI/Dce96lrrlW4ZAT9ssSnjafHdpjyBt1VeZYyeVelq04RR+lAn+KFA0hbjoTAJTiov4WUEpJuW0iEgFfJl+ZBTyYsT5o+3PJb0FxxMEHAuWaFSfm4Ofp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4JdnL7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4JdnL7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF381F000E9;
	Fri, 31 Jul 2026 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505776;
	bh=hPyNvOCc7kJ7groVIiDn9argQp3j5/TH/GGTGDaTVLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k4JdnL7IvPxfzFAeJargDvUzyGpnzvEaN4RYJHaCLGJOOnrApIu0R+YlMwIKLr8x6
	 c4nt0i7FVo0JGZNIbjfd+vWo2XmqYrcHxOoVKv/MXcYOep0ktWchFb8/LLTu5x5JFm
	 4dzIHQdDX11crS26Dg44lZmOApjDGlh4rYPacRsA6VJJE+2Nkfv5LXXuQDITb2QpzA
	 IsiVe8X7CP4ZDfIdp4GMP4JGN/xMQu4vjyvf1rpveP9AJNmd7V4wx2YT6Fz1QXpNrs
	 AWMrcOHCron4oJZWkhrtTJICbw12diuubEPhJ5OdOngXCQY5bsN7B74XF/RAunt5yA
	 +sMXG5qqnG02g==
Message-ID: <79e35eae-5977-4da4-a0d8-4491b823a49f@kernel.org>
Date: Fri, 31 Jul 2026 08:49:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] EDAC/altera: Fix NULL of_node dereference
 altr_edac_device_probe()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, rounakdas2025@gmail.com,
 niravkumar.l.rabara@altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727132416.807230-1-dinguyen@kernel.org>
 <20260727132416.807230-2-dinguyen@kernel.org>
 <20260728185638.GAamj7ZjiuriHIBjTw@fat_crate.local>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260728185638.GAamj7ZjiuriHIBjTw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/26 13:56, Borislav Petkov wrote:
> On Mon, Jul 27, 2026 at 08:24:07AM -0500, Dinh Nguyen wrote:
>> In altr_edac_device_probe() dereferenced pdev->dev.of_node and
>> of_match_node() before validating it,
> 
> How did that AI let you fumble that sentence? :-P

sorry about that...

> 
>> which could cause a NULL pointer
>> dereference when the device tree node is missing. Check the result for
>> a NULL and bail out with -ENODEV before using it.
>>
>> Assisted-by: Cursor:claude-4.8-opus
>> Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
>> Closes: https://sashiko.dev/#/patchset/20260719211238.589402-1-rosenp%40gmail.com
> 
> So the AI review for this one here is this one, I think:
> 
> "This isn't a bug introduced by this patch, but can np be NULL here if the
> driver is bound via sysfs?
> If a privileged user unbinds and rebinds the driver via sysfs to a platform
> device that lacks an of_node, pdev->dev.of_node will be NULL, which would
> cause an unconditional dereference when accessing np->name."
> 
> Can that happen?

I don't think this can ever happen. The SoCFPGA platform is strictly OF 
enabled, so not having an of_node would be impossible.

Let me rework this down some more. Sorry for the noise!

Dinh
