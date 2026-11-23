Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.59.206.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414210;
	b=wZQBJy9wojy25tRQfIvmxvObiVTlMxei319kYYL4zZ6ZOt1qB9CBrZQKUWt9Lj9dLv+e
	 Og733VAeXFyucyESby2UELek7pF6hdaaW+Cak5iJHKjjzbso43cLg7cMqRSTvAX20RRvw
	 NmBykd8sMZ6lfDcWqpN89kC1vMWZZ8WSnU4GiEaE+2yP9JDBK2OOQGFG/JXbyRy4QgMw9
	 08q7HrgLC4bHWCay50en8m2FKvwwD1T0hinGpXEaAb+Kx+issjagtCOc5Rl2JbU5ubkEI
	 vF0fjVopgBUrvvTXSOilXnZCJgOa5o49sVcLaUWy9cRsbBd+GFFYBJqOW3SV+aYbA2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=yLN4S3lrqlKtWig3p1xpyEGfVn7ZeVXiVgaiSlEzVEE=;
	b=nV6kKaahLYwdIaCPaBhIonxMLg9R0IgQ+5h7GYNn31uzXPGfTsvZXmEzWb7PyDfJSovz
	 7GruDmKgQM2ywWQxhFoNKHJVgI47EtZbBIOxzewIhZywObdwB1cXBr2PjxWOmPgCxMlXJ
	 cUGx4E6k7/bM1+bNpPe71j74IPTQC1t/tuhzQcNatPeL/sLDSslS6FFRs0edjIexee6C6
	 KFI3rYd7RQtnkFgaQLAsiS5LgUqaCkUnrQ+Ni++m5F/xbYbz7sgmar0Iq8+ai6V8Z0BHr
	 /b3u2MoK7BB45oiDKZssTWp+YGtODF4NmIlfLYUT+OUYiZ4JOWCQOyOBvRETb/9Su4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=evjLP5aM;
	arc=none smtp.remote-ip=194.59.206.189
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70070606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70070606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=evjLP5aM
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jXwV720P7z4Fdy;
	Mon, 23 Nov 2026 07:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1795414095;
	bh=+Hnb++gw85v3HhE/K0yTC4jAJfHcueKVxn3kbMs17QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=evjLP5aMylD+My2TuqwtmEnS24UW+7AGkdG2gRGnfJLuxs95uq0p9ye9d42J+DW4f
	 CSnvFKXprqWCWg+Y74Y24/Xmx8GyMy5mkzF8K/8pMHYjAnj2s0/7oijfSe0lz0red0
	 9hiSP70wdmPgmr6R++wRBQza1aujRzx2oqqpijuYzsNtlJE2sKTxyy8cx9FDsQq2IE
	 RWHOJOHAbnjrnV7BepgSaRfI/9GvbHksFapRceZw7R7DgmQlOybPSYJwtKkcBH4Mij
	 uh5vxnCwSzU42YY1zhLoMUknnMDTZrPRUoXGRgfyIS93DWBPh7wY2lPrE5wAQgBQF4
	 4HlKuL7r0ezGw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jXwSw5mqVz7x8S;
	Mon, 23 Nov 2026 07:07:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jXwSt3Lpjz8v3M;
	Mon, 23 Nov 2026 07:07:10 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8787E5FBDB;
	Mon, 23 Nov 2026 07:06:58 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <841bc5e9-51f3-4eff-8c54-8dfac6762c17@leemhuis.info>
Date: Mon, 23 Nov 2026 07:06:57 +0100
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
Subject: Re: Unable to compile 6.12 kernels on SPARC64 since 6.12.105
To: Greg KH <gregkh@linuxfoundation.org>,
 Iulian Vaideanu <iulian.vaideanu@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
References: 
 <CAPK=yVMe1Ro=aw_daLCOM9cBATsp6crdgB4wd0ty4vrnxtVKkQ@mail.gmail.com>
 <2026112346-vagueness-naming-01f0@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026112346-vagueness-naming-01f0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179541401883.830933.13122758706311832823@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 8787E5FBDB
X-NC-CID: 1CrMVWaMhYywk+Z1sR4PNr7Rjia7iyMGv8Mbn8NTYP0hWQMHi2c=

On 11/23/26 06:03, Greg KH wrote:
> On Sun, Nov 22, 2026 at 08:39:18PM +0200, Iulian Vaideanu wrote:
>>
>> Ever since 6.12.105 I cannot "make bindeb-pkg" vanilla kernels
>> (platform is Debian unstable on bare-metal Netra SPARC T4-1, GCC 16.1
>> or 16.2 from Debian ports) - it always ends in the error below in
>> fcntl.c, probably brought up by one of the fsnotify-related commits in
>> 105.
>>
>> Is there anything I can do to work around this?
> 
> Can you use 'git bisect' to track down the offending change?

Not my area of expertise, so this might be misleading, but FWIW:

Wondering if this is related to another sparc build problem in the same
area for which a fix was recently queued for 6.12.y, but then dropped
for now to prevent a deadlock situation:

* https://lore.kernel.org/all/2026102206-trinity-feminism-b082@gregkh/
*
https://lore.kernel.org/all/09fded57a6074dd89485.sashal-rc-0003@kernel.org/

Ciao, Thorsten
