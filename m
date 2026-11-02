Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.244.194.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617597;
	b=aA5OJkiA6dkOfNbZok5xQ/l3Ytl/72WGtugBFhoeHCwdaY990aTvhX8s0pn4OYpQdSbC
	 0ZQwqLYdJR0pwl2/LYY6/HtWG9ZRYbJa399He6+vIzEEEBhmoGeAfKofZC3L0Mpgz+FUO
	 M5o+w5Bz/MaVi9U/muDTQ7l21/XBV3mH81sTpc/5XHiMXcYktJ6b4noVGs9unUhOBWWEW
	 meM2FBPKi4g4ll4p70QRb71GlLM+c3lpcawK3KMMRQ5s7Lj1SSnOD8ir9SaBx56VvU7SZ
	 r5rT2laXis2PAhJaHQR18k4QNgNzP/CMdCfnTG9RfZGVuv/c9RRArgFJ0FGIRMBHwSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:
	 Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=7uACpj18c5vSxhT04PkcvzJ4BcwC0s67cyii/fIfICg=;
	b=huKm66dAiTb1ly/RPl9yHPnnJAfu061jMKUWnv56/9OZMDlLuKQAPEKbw8uvMNC1d8FT
	 Rmcy9JVJgYyUaqVlz+p99v1z4rSt0ku0Vh5NeWW784wvr74riPqUVvR8GtySAgBxfy2Vn
	 uwY6/l1t2GerF20JaCiQ+AcbADNR93lHdPmaDsej5eLOY3agCejZNk0M4DzouFxbKB5A1
	 xUJd4kw3PTbI0CSKn7pdX0mSmRAD5VmkpZGmCsWfK/tWHeOPU0oD4L/0ViSGLcOS22bYS
	 BLwyv60/Ol58GQbS69i9Wo6hcv9hgil7LziHKBwXmLxoRwsWA2Uu78TcDngW3UyLnrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=hKn+VAfd;
	arc=none smtp.remote-ip=185.244.194.184
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1540606A327;
	Mon,  2 Nov 2026 11:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1540606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=hKn+VAfd
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jJ85x24xwz9DYb;
	Mon,  2 Nov 2026 12:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793617589;
	bh=JcpHIHPRbTHiaFAGdolcnzsT+BS2ZSoJfZD+/uv9GMk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hKn+VAfdEPTJEAo92CKadHZv8WDHz0pIorUb1CnFEExAy23Dsf/RnoOXXFML1oht/
	 uEYkfky0ygeLrc1+sUJxPVHpf+IsKZof1GgpEATLJRc96GAWB6bqC56Mf7Gg82Kn9f
	 OD4MnhmvkMPic67+FFfTF+VwwRizrpdZ9rG3IdrJzlu0fw/sI8mtDNOOpi4WYM3C7b
	 Eqjpc4+pP/e1zB8iyQtTvWDm3UENnS38bRNzIfywQkrw30fcz5gx0vX9qIAi2yWl+9
	 Bl0JPFsc0m1P6riegrkH4SPEgsKVgQtDbLH1+Hs5XEojEiNeNBhsP/XuoyBklRQys9
	 sUNWEo/B0FKig==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4jJ85x1N37z7wLr;
	Mon,  2 Nov 2026 12:06:29 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jJ84t2JpZz8tgf;
	Mon,  2 Nov 2026 12:05:33 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id AB0685F9CA;
	Mon,  2 Nov 2026 12:05:04 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <509e17d2-ddc7-45a7-b801-08d8125869cf@leemhuis.info>
Date: Mon, 2 Nov 2026 12:05:04 +0100
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Christoph Zwerschke <cito@online.de>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Sasha Levin
 <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org
References: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
 <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>
 <auLhWSOpMQg6cALq@eldamar.lan>
 <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179361750525.1205629.14667278806776514133@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: AB0685F9CA
X-NC-CID: tK+jJPFNB2NlJBfmjJJ24n4SWq7C3MQrDui4qUqrxrrONCFdJJ4=

On 11/2/26 12:04, Thorsten Leemhuis wrote:
> On 10/29/26 07:02, Salvatore Bonaccorso wrote:
>> On Sun, Oct 25, 2026 at 07:29:50PM -0400, Sasha Levin wrote:
>>>>> If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
>>>>> (on top of bluetooth.git master, with Cc: stable). Alternatively,
>>>>> btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
>>>>> is missing.
>>>> I didn't see any regression reports for 7.x releases about those
>>>> changes, [...] So I'm still inclined to say: leave everything as it is
>>>> in mainline to avoid any risk and revert only the backports of those
>>>> two in 6.18.y and 6.12.y.
>>>
>>> Yup, that would be appreciated.
>>
>> I'm bit lost here :) Who is now going to sen the reverts for the older
>> stable series? 
>
> Christian, you offered sending the reverts earlier, could you do this
> please now that we all seem to be in agreement?
s/Christian/Christoph/

Sorry!
