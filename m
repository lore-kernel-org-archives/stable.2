Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792915659;
	b=aOQDpqrR6Dt4BrehoW/ykieUgY7SwPKtxubiFrKQj4L7nZsbl3P478pFrZwHj4RzaXV/
	 ZmIGwbIaxM+CrTWS7oP1ASSHnW+OYYksp1Vungi2d75NZLW5q3B2SaXqMnulCQz7/aS7p
	 xUpfIO1Afy5q/h5OyE/ufWBIt5FHOM5uCykx6AhsnGpSCHMxWxr6JWELa2YRCyIRj8kLT
	 SqECVldC1UEN59quubNo37Tq6YTRiK9I7IbHUfzeVAYEAmWD8DdgtLX6DxyHYp8evwxZG
	 Dr9t2RnkpH2KWlNikZxjJau/zubh3SSJBqWDv62Dgd3omjYuTcPrtAHo30tyrnEUyLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792915659;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=zbSwU0bKBd7RvGs+0XPKASnkrq6zfZU8MhR5qhg9u64=;
	b=fVs8Mc5q4VFCOEfEsyrUPYI0ZLYECqrtKjwS6UbCCcsjRdkhTEnaxREu9yl7MBm4sYZ0
	 MOx+w/JkZr2MOfwULC7Gl1JoeiNoEKcsZ8PCywZ4t3cAD0LOtSRxlBDbAq6C2F52gImpj
	 rO4PamZgyzPORAT0x5861usSlnhvdZL7nRf9q1nPfnYLcKQ+X7d4qSooMD0PfcxjJAljD
	 z4DWUmoOxwRSo+OSUYn5ENUC8k3dFuGCgwcaD9HYn9I1JOnZDcj/z+COVpJjFJUVih6ej
	 XXPnz+ZiEzQASmh8Qjlhq/LJlR9NTf3w1q0GqRTZTGS0qu/LYRC3CXEOkTcVFjmjsiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XaGnVYV7;
	arc=none smtp.remote-ip=188.68.63.166
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D3606A31F;
	Sun, 25 Oct 2026 08:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343D3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XaGnVYV7
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jC8W670d3z4FdS;
	Sun, 25 Oct 2026 09:07:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792915651;
	bh=e01dwD7Pjn0J7HP4870T+qNA4WbymnKWxim3Mv9VhYA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XaGnVYV7ebJzg9awH4PX+UP0+2AjiEobnJkXQXomiEo4Ls20MpfZ+psCUB4H3xtsc
	 KqFa4+g+Ah10QDAtFmxj0TwK5Lo08FJLbiYCn6m54E7vxesW9qSqErygzYjzEfXjl9
	 FtnKdg9Cmf7z01tSNofGubYF/Gxn3gnTgk0zDnwIJUuaLJmCYWIO2T4l1Yf4neHkRS
	 OIKCh83VVhn7Jh4pIsuxabTiCSj1DYw83qjXlN2HcyFFvjbirAvg6DVxNYHdwxAlr1
	 N/pFujtqEXtzpQB0ZNxYoJyMHbxNlzW4vQo5iEFCupdiI0TtRUt7efBTT+Jddy62sC
	 b+UxkzBAeC1aQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jC8W66HBLz4F5y;
	Sun, 25 Oct 2026 09:07:30 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jC8W62XYPz8svC;
	Sun, 25 Oct 2026 09:07:30 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id AC1A05FD42;
	Sun, 25 Oct 2026 09:07:23 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
Date: Sun, 25 Oct 2026 09:07:22 +0100
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
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Christoph Zwerschke <cito@online.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org
References: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
 <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>
 <2026102508-thicket-duration-c971@gregkh>
 <6299a7bd-a934-41b2-95f9-d68056551714@leemhuis.info>
 <3bc2cf5d-6cd2-49ae-91e2-ed3af96362f2@online.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <3bc2cf5d-6cd2-49ae-91e2-ed3af96362f2@online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179291564419.1221425.15793536407934588708@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: AC1A05FD42
X-NC-CID: vR/EhMdaQBEEeRwv0pWsyWL0oGUNXedsvxrQmjP3ljh1PHTuc/Q=

On 10/25/26 08:37, Christoph Zwerschke wrote:
> On 25.10.26 07:27, Thorsten Leemhuis wrote:
>> Feels wrong to me, as
>> Documentation/driver-api/firmware/firmware-usage-guidelines.rst says
>> "Users switching to a newer kernel should *not* have to install newer
>> firmware files to keep their hardware working.". So what those three
>> commits did in mainline even there could be considered a
>> mistake/regression. No worries, mistakes happen. And reverting it now in
>> mainline would do more damage than good. But overall it feels wrong to
>> bring that mistake over to older stable series.
> 
> I can confirm the analysis: [...]

Thx for taking the time explaining this in details to us, much appreciated!

> [...]
> Regarding your concern that a revert in mainline would do more damage
> than good: on 7.3 I also compared both variants (with and without the
> ID entries) with the BT600 for HFP and LE Audio (BlueZ 5.87, PipeWire
> 1.6.10). mSBC is negotiated and used even without the wide-band-speech
> flag, and I found no difference between ROM and loaded firmware. So
> for these two adapters I could not find any damage from reverting the
> ID entries in mainline. Of course this does not rule out that the
> loaded firmware contains fixes or improvements that my tests did not
> cover.
> [...] 
> If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
> (on top of bluetooth.git master, with Cc: stable). Alternatively,
> btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
> is missing.
I didn't see any regression reports for 7.x releases about those
changes, as I suspect that people that regularly switch to the latest
stable or mainline releases often update their firmware package, too. So
I'm still inclined to say: leave everything as it is in mainline to
avoid any risk and revert only the backports of those two in 6.18.y and
6.12.y.

Ciao, Thorsten
