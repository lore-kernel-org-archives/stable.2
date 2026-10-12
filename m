Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05591442390;
	Mon, 12 Oct 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788878; cv=none; b=t0VYK6rpmIkiwOdr2lqZ3dgcEEul4F/MdPJUExk6E1SSekfNRrq1/boAz8RqimPNeK3fUL/A1PQJ2me/RvvTRFEoQ4WXFqfDK92YlqVz0eFCzjW1nhjDWasFuZ7aC2uCtzZO6C0S07pe083c+5JfvabAprMbkY5JP1z7LRSzwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788878; c=relaxed/simple;
	bh=i5BIRVAPpniOISGJ/i5CsM5ZpN/mj5rHCcHGicli75k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N68HBoKPXM57G5Y4yWnuwsI/5wdW03NLqTijLZU5Rfl+n26wvKkAtrK2OlCL6bz+v2TfrijmlWRJgXyHvRw9Rm9ZLXYc85L4gVJy+I///vwd3bhGFA1pUPVA1l6SOCxJ8Z0HfDv0HYluFwy+A8ksLtNeG3mCFgjEhTuBZZkpIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KEGgUBw5; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KEGgUBw5"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j37p961tyz4CN8;
	Mon, 12 Oct 2026 09:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791788865;
	bh=i5BIRVAPpniOISGJ/i5CsM5ZpN/mj5rHCcHGicli75k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KEGgUBw51XKEHFsoKPSUYd0h0P1wwCRlCi6pUAg1GQkOLWsAyXDh0gcIQlHTAfnvB
	 Mf10nBTYRpdKrFl46l6TuNn/836VNoQV40OcXjZgZshcYNG5uT88FPeeWQL4rEvLCd
	 F46CR508UtmGXuOfIDlnc+I3RZE2XPpquUOSwvRye8tHY9bkMQXiRbKCHCSd85Ff+/
	 rdGIEgPIj0eXKCXCWFryMSNwVXLSTKpqhNqe1Pmq0oE9KiKSg6dobxh4+yPl9pPOia
	 1OZUM+tbQGNLWdmP5EdcbG4BNyEqCMm/4BqASsXkjiIkpDMZdaJMJwTyyhlKK78IkD
	 sj5zLEp+AFivg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j37p94l9Xz4CFN;
	Mon, 12 Oct 2026 09:07:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j37p86G9nz8tfd;
	Mon, 12 Oct 2026 09:07:44 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 98C085FA1C;
	Mon, 12 Oct 2026 09:07:35 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <a64dc5d0-eb09-4482-b8b3-16d8d015e2bc@leemhuis.info>
Date: Mon, 12 Oct 2026 09:07:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Birk Skyum <birk.skyum@pm.me>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
References: <179173732257.29426.7905170638383807320@pm.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <179173732257.29426.7905170638383807320@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179178885607.2571480.10778353119121245415@mxe9fb.netcup.net>
X-NC-CID: 8Q6MsXqw5AlrJChlWYXUT1ubh9yG509Hi9+8C29qBzL9iKyaUA0=

On 10/11/26 18:48, Birk Skyum wrote:
> 
> This change takes away the built-in keyboard and touchpad of the Lenovo
> Yoga Slim 7x (x1e80100). It reached stable as 139efdb3ee6e in 7.2.9,
> and with it the laptop has no keyboard, also at the disk passphrase
> prompt.

Not my area of expertise, but from a quick look it sounds a lot like
this will be fixed by this with will likely be fast-tracked to stable
once mainlined:

i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
https://lore.kernel.org/all/20260929041444.9837-1-daniel@quora.org/

Could you take a closer look please and maybe even confirm?

Ciao, Thorsten

> With the change the first transfer on the keyboard's bus fails.
> 
>   geni_i2c b80000.i2c: Bus arbitration lost, clock line undriveable
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -11
>   i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> 
> The touchscreen on a80000.i2c keeps working. Both buses are set to
> 400 kHz in the device tree.
> 
> To narrow it down I took a 7.2.8 kernel that works on this laptop and
> replaced only i2c-qcom-geni.ko, built from the same tree. It is a
> distribution build of 7.2.8 whose patches touch neither this driver nor
> qcom-geni-se.
> 
>   7.2.8 driver                                keyboard works
>   7.2.9 driver (its five qcom-geni commits)   keyboard and touchpad dead
>   7.2.9 driver with 139efdb3ee6e reverted     keyboard works
> 
> One thing I can see from the outside. The driver does not set the rate
> of the SE clock. Without the change clk_summary shows the clocks of the
> I2C controllers at 19.2 MHz, so the 19.2 MHz table is used and
> SE_GENI_CLK_SEL is 0. With the change the same clocks read 32 MHz.
> 
>                                       without     with
>   gcc_qupv3_wrap0_s0_clk (b80000)    19200000    32000000
>   gcc_qupv3_wrap1_s0_clk (a80000)    19200000    32000000
> 
> So as far as I can tell these buses now run from the 32 MHz source with
> the 32 MHz table. I have not found why that fails on b80000 and not on
> a80000.
> 
> I have not tested mainline, which carries the change as cb97bf3d4f91.
> The same backport is in 6.18.y (5815329988ac) and 6.12.y
> (f5d0302416aa), which I have not tested either. I can test patches on
> this laptop.
> 
> #regzbot introduced: cb97bf3d4f91
> 
> Thanks,
> Birk

