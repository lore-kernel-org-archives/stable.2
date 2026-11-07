Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.61.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057740;
	b=Sg3SIpdihoCGfVMGseadHS1615YN0ClePA5qxIeFYkpisfaSxBraGwMLkBl+wP+c0qjj
	 L3T8a0UYkkLRnyplkoJMqFmDiGSFbd3LuXGtSMPWvtvJtqyVbgXcKwU4Hck0QkSRNvtR7
	 r4Jf99gVXvhBgvDkilosclFUAhBxNW0pZaBJX8R1Lbpsbd1La1DOgaeyHcB7TtmQxGdnJ
	 vTEudI+Rq9g1/p8swZSYy1mrlgFMj82XmGPbe1kafEBwqVzx4My14fVLV18hvKht7ETIr
	 eHspTV5p34lXeLSrapco9JSO623DBz2NZlO7Gkp4mA0bpByvRsqW3hbsDTUY71poepg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057740;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=cN9iEGGau212gWJDj+Y5lUwiMbffHjEqH89MusvVV4g=;
	b=WuYQ1pHicD7BMbAqrgZSnPgXuIKOiVvBW7iHvUjqf0/t0Nz13vOwqgw1vez6ccmg4Heb
	 3n2oZrt8IRG+Zh7E1NLGXcLLNa7vnaXhv/CMJgyCE1wsEqaEVOz/9kp0b8aNRsPiW3tMN
	 J10jPDZuX7JW5Q7MIjiOPqn9RGmLz02ulkRa/Qz9Zb3DqOsEXgkrS2YSDTa7ftBR2Z3mQ
	 cWshRIBqoCGmfntLXOrCqUySlbNzZ39b8uKtZG8kZtptsAH9f7duWfGhPCQZ2RTH9vc0p
	 1g+RzGST/yXey3lTo9/nRyPdOD0+/db74LpAUumlrnB5c6z6lMaEUhQ0lDaf8ji8+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=VPu9XqL4;
	arc=none smtp.remote-ip=188.68.61.103
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE9606A326;
	Sat,  7 Nov 2026 13:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DE9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=VPu9XqL4
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4jMGtB5WMhz8NtC;
	Sat,  7 Nov 2026 14:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794057730;
	bh=6egDlvExkyOc+F4Jd2boRm1JscAZdQPO7yHy2mCYPR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VPu9XqL4xL3fhZZwAdPYQPOSk/OTvse5XtuWmqfIRhgEip8oPlvHKZXiN47rfnAOC
	 eGEfuIiAZm11hzOrCLYHNjI8r7AdIiXvsSZgJdBGZztTH+F89gsH+SRggSUP+0irnJ
	 UaOK46ax/9GWUKYdXkau/c98fv3574eB9si8Z975qhUWwjlpIkSfBP1A3n9eauhOKS
	 pBNX1DfRImpzRTlJDSTwyCH5Gd1pYC7AUpYbsK7LZ5dbZi2dYQRJcIWxlT204G36XD
	 TYJpp+pet2E/VILy4D5843bPj/phYIKkaWZtS7PsexsJgjWzja22RNQTbYjdL9lw2V
	 +7dhwZabWrXWQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4jMGtB4qFnz8Ccc;
	Sat,  7 Nov 2026 14:22:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jMGt93y47z8v4w;
	Sat,  7 Nov 2026 14:22:09 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 98A0E5F8B3;
	Sat,  7 Nov 2026 14:22:00 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c27cdd7c-05cc-4198-b285-576f5b75abb2@leemhuis.info>
Date: Sat, 7 Nov 2026 14:21:58 +0100
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
Subject: Re: [REGRESSION 6.12.y] ALSA: usb-audio: please backport 70b4db7d2581
 ("ALSA: usb-audio: Use the right limit for PCM OOB check")
To: Laszlo Burian <blktk2000@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-sound@vger.kernel.org, tiwai@suse.de
References: 
 <CAFgCxzCT2uo7ujUJN6V7gsKHcC=61A=oqptzX0Ktnnb7qeqnVw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAFgCxzCT2uo7ujUJN6V7gsKHcC=61A=oqptzX0Ktnnb7qeqnVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179405772093.1604791.11699247387743809284@mxe9fb.netcup.net>
X-NC-CID: N9C7vkVjNHdoiHYB+Yh929Zo1MrPxbMrnF1hZb815QkUGDmKZWc=

On 11/7/26 14:05, Laszlo Burian wrote:
> 
> please backport the following commit to 6.12.y:
> 
>   70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")

It's already queued:

https://lore.kernel.org/stable/2026-11-04-1-daily-reply-0005-re-usb-audio-oob-612@kernel.org/

Ciao, Thorsten

#regzbot dup:
https://lore.kernel.org/stable/shfaXkZCI7FtyNr5tS4kCC_d5E4uQFhc0MtwJa2CQFXpNMfSw7Ub6urwWpGrcoRnHuoneJEi9mLwtnvVImMhz1Hb25iwNJxx8GZZsDCV_HE=@protonmail.com/
