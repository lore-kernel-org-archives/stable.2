Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617721;
	b=1oACI/u1KHugCl69gGx4t5rYWLavhg/O5oHPFbaaIe/cik/hO1OjBkf25zL7N+qnB4WW
	 zKRJ72rbJjsUJbCcFH5EUjJs7QvPkaRnrOuUN+7M0pTBV6uFpKofz919sM1L3CiwYAeaE
	 QLI2qGTJnpl1Gb/3D6bBhurU+V/SPZmPzv1Vnzq+oAp/dlsMqTsflocHM+ljO0Cn06Uvg
	 M9F4nVXoKBPH2YJs33eQVSUxdEeXuPd0zujoJHKS5uFOwurrtrEK9A17FCCB2mu5vcYRl
	 D/ZZMDxUqQnnl/8D0fxRFhWwmThre0iKNBWuWvOIdnjhNUo34mR1z9Yc1sCo52gghDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617721;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=K5HxYXJ9qQtyG09Ef1giggv6OFeEINzUk9fprZUwrTQ=;
	b=4z4PEcFclsSNV74KyPjvP7PmFtZASy0hum3zjvYmRx/+JSVyvpSUktSHaumGH0X4YgTi
	 e5Q/3RzUlsj5yuJOYHiF2qly4M/zfpoV+F4VmwFCLfqSkzh3uvRW7UtEtQfse4+bQRKlD
	 j8Eg80ih6ip6bbCgO5fpktkFRy7bkTsO7qkvOHN5wt0Liu6k0GSlHu9Ksc8oDbuHYKkI/
	 f+xclfJC/GYSzvxRvyAus3mhC7+ZfkbcW7SFFPAivqMwrNpk7Pe9uRUOPDHka5ecNtPDu
	 3ZJ5nBmrhcNRi+HMN2rLTYtzxN8g8gVzjq+RdZbdiKFvgV/hyLTSlg9ZlTXmqfhbALw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b="e0ryX+U/";
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473D606A324;
	Mon,  2 Nov 2026 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3473D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=e0ryX+U/
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jJ85807Y1z63K0;
	Mon,  2 Nov 2026 12:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793617548;
	bh=eUbzbZe7aNvgCJ+zMjYmKyjYTH7j5QJ2CoHI7QCmh9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e0ryX+U/myghuIhx36dQWMRHAbgRQW3i+HnUuIiAsXWD9AM3YjvAPV8i76vq4z7zX
	 KJ52uRJi0EH7QW9vGf5DP4KDI2RJyMUzfStdl2+vkU4ZoHihNWuWNAX1UbwWAMWdsZ
	 9V9w/ND8qXhvx9eFEYszeqachL43lsDixPXRlX3jufwXUxt6skwVjlcILtTG0QfUZk
	 LROIxn5qdLcs7TurctOawrHObvEmeYxqqsZoQ5jA494Qtv+pE+57Iceay/xFOHUDLW
	 drOJiS0VMlIZ8iGWsKZYtwNtfaUjBePoyGG8nBRGUMS54ZcoqAnTBVQ3IIAPj5Veyt
	 uj8a1Q0ExEFiw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jJ83l0VFWz501t;
	Mon,  2 Nov 2026 12:04:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jJ83c2VFWz8thK;
	Mon,  2 Nov 2026 12:04:28 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 45B495FA02;
	Mon,  2 Nov 2026 12:04:05 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0cf3aaf2-9911-4918-8f6f-c11d6077d39b@leemhuis.info>
Date: Mon, 2 Nov 2026 12:04:03 +0100
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
To: Salvatore Bonaccorso <carnil@debian.org>, Sasha Levin <sashal@kernel.org>
Cc: Christoph Zwerschke <cito@online.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Erik Brangs <erik.brangs@gmx.de>, benh@debian.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 1149377@bugs.debian.org
References: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
 <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>
 <auLhWSOpMQg6cALq@eldamar.lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <auLhWSOpMQg6cALq@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179361744584.1205261.5857706765137688230@mxe9fb.netcup.net>
X-NC-CID: s/TYEdNthf/+4FiD8m48E+xrSUohQGLrzlhHWBPuiSj+PddS6Rw=

On 10/29/26 07:02, Salvatore Bonaccorso wrote:
> On Sun, Oct 25, 2026 at 07:29:50PM -0400, Sasha Levin wrote:
>>>> If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
>>>> (on top of bluetooth.git master, with Cc: stable). Alternatively,
>>>> btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
>>>> is missing.
>>> I didn't see any regression reports for 7.x releases about those
>>> changes, [...] So I'm still inclined to say: leave everything as it is
>>> in mainline to avoid any risk and revert only the backports of those
>>> two in 6.18.y and 6.12.y.
>>
>> Yup, that would be appreciated.
> 
> I'm bit lost here :) Who is now going to sen the reverts for the older
> stable series? 
Christian, you offered sending the reverts earlier, could you do this
please now that we all seem to be in agreement?

Ciao, Thorsten
