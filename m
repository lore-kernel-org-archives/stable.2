Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8646C82A;
	Sun, 20 Sep 2026 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923948; cv=none; b=DysQSbVz798YqlN+AYW1s9gq/Qd5iwCi1gjlxwpCyHenwVww59UmN0vgxtvCiQg7wzL2S+Kod8BN6UxR2YT0w/GqXVXNGVaUk5z1jc8v61+WdDvIjYfJhwikehiM/ZAqEDfIBQXlNe7VgWGaBDvbPVb4z/+w0c9CE3u5Jhrmlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923948; c=relaxed/simple;
	bh=Px6qNtjxAUOxlis1EKxQF7UzsshyhnSY33KPJTEaBlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9AmP6pRhVo2iWlWkvUREbC85C3atQVr1/42dnk29nwX7MPsG3ZWm25RSLDYsEvRvTx3/o5dK/zHxV0C7DpemChwy5d/hoTovYOf4v9qf/3RaoWjz0J5aO/O5RK+DyQq2dDCz3xD2bwqcGLSZ26Y1X/AKmYjCM6RNg0lqqZjsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODsXaE8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODsXaE8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87181F000FF;
	Sun, 20 Sep 2026 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789923947;
	bh=nqzKVEoidCP6b282EQb7sYAmyyy5aQUCyjpcO9zBIwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ODsXaE8BO4b74Pe3mnbB+gvDF7olH46CflpkR+DQssbRdGdXCb5Y5yP86jDcswJSS
	 EiR+WQD/iQ2S/sboQHBpmQfFysk7Xj8ewtIKOXls9jNa2GKUPeDjNERRyQUjU2Jf66
	 Wd+OUPhPTpu0bWzp+M1KT1IpThn7pLEOvk7UGuoL0QoGcWKiZZ0bKSv4nQfwLpBNXd
	 V82mwL10l03f9HR61x1itBmoIZdgxzFX+uJfSTjakpG9SJFCiJdTOTNRHveoHA1aT9
	 6W3AqY/8nmk7jWJuUkLt57HXFcfo8RnY1MX+STYd3Z7WxGzraPa5zPbv7grKELzryj
	 KPdk0EgJ5104Q==
Message-ID: <de1b64ff-ee8c-4b76-aae8-ca29628b2db1@kernel.org>
Date: Sun, 20 Sep 2026 12:05:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] pinctrl-amd: Don't clear S4 wake bits at probe
 causes power off to reboot AMD Ryzen laptop
To: Olzhas <marat.olzhasss@gmail.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>, linusw@kernel.org
Cc: linux-gpio@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, sashal@kernel.org
References: <CANzgjV0YWUX6=ZGTbn4KEKqQmVhsZTsDPeRf0Nfq=YFT1eoPzA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CANzgjV0YWUX6=ZGTbn4KEKqQmVhsZTsDPeRf0Nfq=YFT1eoPzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/20/26 12:00 PM, Olzhas wrote:
> Hi Mario,
> 
> I am experiencing a regression on my laptop where attempting to power
> off the machine results in an immediate reboot instead of a shutdown.
> 
> The last known good kernel is v7.1.7, while v7.1.8 is the first known
> bad release.
> 
> I bisected the regression across 9 kernel builds and identified the
> following commit as the first bad commit:
> 
> a7c855969b1a ("pinctrl-amd: Don't clear S4 wake bits at probe")
> 
> With this commit present, running:
> 
>      systemctl poweroff
> 
> causes the laptop to power off and then immediately power back on.
> 
> I reverted this specific commit on top of v7.3.0-rc3 and the issue is
> completely resolved. The laptop now powers off correctly and remains
> off.
> 
> Hardware:
> - Laptop: Chuwi CoreBook Plus 16
> - DMI board vendor: Default string
> - DMI board name: Default string
> - DMI BIOS version: AB8139_S_2C_V00.01_007
> - DMI BIOS date: 2025-08-05
> - CPU reported by the system: AMD Ryzen 5 7430U with Radeon Graphics
> - The CPU/hardware appears to correspond to Ryzen 5 5500U / Lucienne
>    silicon, although I am not certain whether this is relevant.
> 
> Software:
> - Distribution: Arch Linux
> - Last known good: v7.1.7
> - First known bad: v7.1.8
> - Current test kernel: v7.3.0-rc3 with a7c855969b1a reverted
> 
> I have verified the fix by booting the reverted kernel and testing
> poweroff successfully.
> 
> Since the DMI board strings are generic ("Default string"), I would be
> happy to provide an ACPI dump, dmesg output, kernel configuration,
> bisect log, or perform additional testing if needed.
> 
> I suspect this may be related to an S4 wake source left enabled by the
> firmware, but I have not identified the exact wake source yet.
> 
> Best regards,
> Olzhas Marat
> 
> #regzbot introduced: a7c855969b1a
> 

This is most likely a BIOS bug, but we need to dig into the details to 
understand more and decide what to do.  It could also be a driver bug, 
most likely in a WLAN driver.

Can you please open a kernel bugzilla with the following information:

1) /sys/kernel/debug/gpio without the commit
2) /sys/kernel/debug/gpio with the commit
3) acpidump (just once)
4) amd-s2idle report (this will capture and associate some information 
that will make this easier to triage)

Please CC me into the bug report.

Thanks
