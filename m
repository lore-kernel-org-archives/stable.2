Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D502EDD78;
	Wed, 14 Oct 2026 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954542; cv=none; b=nAWeAx378CINlI5vD90O9cpkipXxQ8qAlYUetza8a2E1erqI49fgVyeZpNXeDxeLqwY6xo4jDBC0vBpohmWRSADeZjt75NzE+88oVsM3/CjeaDgtqVEg9KTYjacqxkwAEgr8yGj9/91QLRoQZFYOtSs+v8e6ypz6l1YlY/uQ3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954542; c=relaxed/simple;
	bh=rlOCRJxxvXSKz+/MJviNY8p9lyon2NiOyUkj6CTSmVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h59J3vJQKIEOiUGIrNkvFHNwkJBTH5XGDccmhzaPwNVOFTjIadtkz4y7M0lii/BDPtnOwA4SrIyVJ8tAvu5CrdIDI+ERQFxZ3zmtJtTFprUOQTxAHMZ4o0k+gvlAExKN1WZ3y2cvoIOFy00eiKe73HGFgHm7ll+LRQ467tfkHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lndRATsB; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lndRATsB"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4j4K3m2xL0z6KWM;
	Wed, 14 Oct 2026 07:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791954516;
	bh=rlOCRJxxvXSKz+/MJviNY8p9lyon2NiOyUkj6CTSmVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lndRATsBfoahdm3mP9oJK+Q0nB9ifTmf237VP9j7KOkIPiEMLksyYWgvwRyjZ4m0e
	 kbNeNGSq9J1hZWLcsdoJJ5iGy2LhupI84r9qeaCH9K2xjLdb/0t2Ayq4QLCW8P9SF8
	 lH7V80P3Jb1S1LwGrTOePXnQO0+JoFynbmKmx8D4+f0sl8ZKeGkjzJ30P0SKlRRJDk
	 V0PcYam7mebSCkL8A4ldR1ymd0OVooeHln4ckfsv8meBeLbfcdmHtjMQdidojN+LOo
	 RNRklpxocgi/8pw1hdFdVZh73ibt2WYkzQoxI1krKxbBljlcx23nw2dU+JZ0tc/ko5
	 DB/odp+3nYZgw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4j4K3m2CfMz500g;
	Wed, 14 Oct 2026 07:08:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j4K3k4Bskz8tgR;
	Wed, 14 Oct 2026 07:08:34 +0200 (CEST)
Received: from [192.168.44.19] (unknown [185.238.219.103])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2395F5FAD1;
	Wed, 14 Oct 2026 07:08:29 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 185.238.219.103) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.44.19]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e8f862fe-f86c-4522-9ef9-70fd754529af@leemhuis.info>
Date: Wed, 14 Oct 2026 07:08:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>, Andi Shyti <andi.shyti@kernel.org>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
 <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
 <20261009145800.rc-reply-0004@kernel.org>
 <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
 <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179195450992.3085560.17461462397598041287@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 2395F5FAD1
X-NC-CID: tEcCbzUfgwUCJqdcJyw89SeupMi+Cl/mJpUEdePdcPQiCyi2gWI=

On 10/13/26 20:28, Mukesh Savaliya wrote:
> On 10/13/2026 1:04 PM, Thorsten Leemhuis wrote:
>> On 10/9/26 21:01, Sasha Levin wrote:
>>>> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
>>>>> I would revert the original patch if there is hardware that uses the
>>>>> I2C 1MHz fast-mode, since the current timings aren't to spec, but also
>>>>> weren't before.
>>>
>>> For stable: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
>>> SE_GENI_CLK_SEL") has already shipped in 7.2.9, 6.18.55 and 6.12.112,
>>> and is
>>> queued for 6.6, 6.1, 5.15 and 5.10.
>>>
>>> The 32 MHz clock map (506bb2ab0075, v6.13+) does not exist in 6.12.y
>>> and older.
>>> The backports there pick only the 19.2 MHz entry, so the Yoga Slim 7x /
>>> X1E80100 timing regression cannot occur on 6.12.y or older, and I'm
>>> keeping the
>>> 6.6 and older queues as they are.
>>>
>>> 7.2.y and 6.18.y do have the 32 MHz table and are affected. Once the
>>> fix lands
>>> in mainline, I'll pick it up for 7.2 and 6.18.
>>
>> @Andi, @viken, and/or @Daniel:
>>
>> Is the patch at the start of the thread or some improved version heading
>> to mainline meanwhile? What Sasha wrote above is one reason why that
>> would be good rather sooner than latter; another is a regression
>> report[1] from Birk (now CCed) wo ran into the problem with mainline --
>> so it would be good to fix this before 7.3 is released, too.
>>
>> Or is a revert the better option to achieve that?
> 
> This is in active discussion with hardware experts, but taking time to
> get specs compliant configuration values while it's being tested.

That's how it is sometimes, but then it's likely best to go back to the
know old state by reverting the culprit -- or is that a bad idea for
some reason?

> I see 7.3 release on 25th, so what max time we can have before reverting ?

Not sure where you get this from, but 7.3 most likely will be released
this Sunday, so four days from now. Given that this affects stable is
should ideally be fixed quickly anyway. And the issue is know for a
while, so it normally should be fixed already, as that's what Linus wants:

https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

""But if it's a regression with a known commit that caused it, I think
the rule of thumb [to fix it] should generally be "within a week",
preferably before the next rc."""

Ciao, Thorsten
