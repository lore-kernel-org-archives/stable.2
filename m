Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87D37F8AF;
	Tue, 13 Oct 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876904; cv=none; b=d3tYbwTGBW9d8sqGM5ZToBJtZ89LjETyo1cj+oi9tYS+qvsAVZfBy+GbChdcC0f+XZNk0x/h+ZIuWw09HQePa+jKw5O2i1+4xBsdegT92WOMjJWYp+K28JXqXgnLRJm9bHWQAcJYQo1kbFJknDB8jpzWerMiYK0FRx7Q85ynhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876904; c=relaxed/simple;
	bh=yK3aUF6G3VXhj20EG+0GSq6ad7zFjJiv8ySOyktqqnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvKaqLK8Nbcgbms8SM+hzLMVQAVWANiCVpr4QXZ7RCieEYCMEn1bMHTFwTcMg7aaQkW6J8ju+6s2PULJ7DQpo70P4kPAmjAcve5bxWj6S4fdDx71CkHRC3TIolGHkPTNVwh50m6DYsTfnm0xs/s0Q7NO6soXkfzw+KOwss0LK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=c1g6exYk; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="c1g6exYk"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3mM70tVbz8GYT;
	Tue, 13 Oct 2026 09:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791876899;
	bh=yK3aUF6G3VXhj20EG+0GSq6ad7zFjJiv8ySOyktqqnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c1g6exYko+YcYjZ/V1HPUkx8dA20JNZXpxkW0UegwjiQ7pYUXjaz3zXiKqQGxRPGN
	 sXmcbW6kAiCWlfUpicwuc4rbtLkwA/61fhrHkhX62hrotO9hSWKrK4/xR5t385C/OX
	 OD5fiCDPWyhnGEnIkkH3RrjBfiQogByUzQpPGT3ZxkSADiR9brfnwZG6ECpELl5SnR
	 FuSxhcI743HOafdpvbeOplyBRMZ1aXfcCD6J6tm08aytI1TD7Us+2C96/L40j0ZkuR
	 5Fom9vn8ZyVwpen6DYWdduXUDqIxcYeVVNvcMzBNfNHaMvRPO71DVn1Kji4BLr9m0v
	 YM8AarzkCkKYQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j3mM7085fz4yQX;
	Tue, 13 Oct 2026 09:34:59 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j3mM62yH2z8sch;
	Tue, 13 Oct 2026 09:34:58 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2CDEB5F998;
	Tue, 13 Oct 2026 09:34:57 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
Date: Tue, 13 Oct 2026 09:34:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Daniel J Blueman <daniel@quora.org>, Andi Shyti <andi.shyti@kernel.org>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Sasha Levin <sashal@kernel.org>,
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261009145800.rc-reply-0004@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179187689790.3430384.13434509312600935232@mxe9fb.netcup.net>
X-NC-CID: wdbnc1cbTq5Z4cqPM2VXVJI1T6fW6zQSkLj8AO7tYZMxaJsXRPs=

On 10/9/26 21:01, Sasha Levin wrote:
>> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
>>> I would revert the original patch if there is hardware that uses the
>>> I2C 1MHz fast-mode, since the current timings aren't to spec, but also
>>> weren't before.
> 
> For stable: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
> SE_GENI_CLK_SEL") has already shipped in 7.2.9, 6.18.55 and 6.12.112, and is
> queued for 6.6, 6.1, 5.15 and 5.10.
> 
> The 32 MHz clock map (506bb2ab0075, v6.13+) does not exist in 6.12.y and older.
> The backports there pick only the 19.2 MHz entry, so the Yoga Slim 7x /
> X1E80100 timing regression cannot occur on 6.12.y or older, and I'm keeping the
> 6.6 and older queues as they are.
> 
> 7.2.y and 6.18.y do have the 32 MHz table and are affected. Once the fix lands
> in mainline, I'll pick it up for 7.2 and 6.18.

@Andi, @viken, and/or @Daniel:

Is the patch at the start of the thread or some improved version heading
to mainline meanwhile? What Sasha wrote above is one reason why that
would be good rather sooner than latter; another is a regression
report[1] from Birk (now CCed) wo ran into the problem with mainline --
so it would be good to fix this before 7.3 is released, too.

Or is a revert the better option to achieve that?

Ciao, Thorsten

[1]
https://lore.kernel.org/stable/179173732257.29426.7905170638383807320@pm.me/
