Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733448;
	b=zHEjGJ+UjtieSQf3/zu6Apn/EsgawBFqGbD3WTjmQ4d5DtqbAEzeWXX/nAmihjSCOg9W
	 OZKgAmLzc8h7zwe6k4Lh6zx6A3ZFiI/QqM4k75fVX0uQlMfu61ff/p+VJMNTRGAiz++cp
	 7rcGfb4lxYUvu+P2U6SMg1Pjv3ypu595Edt/thtXmnsRQC2EA983VBLtNu6ypwBt28rc5
	 99nq2E0XILCIJawW61pTRSDmiUj5CvklgbJJzLxsSjO3sGsx1c/qBIplR2ddKUSYddFsW
	 5Hd0334hNQ2hjE3pfubR6S05OrabOxKbKAKXmMgJKUwXaLx5rmLWv3rTt4YZRW0MccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=1rkU+g9t1uaTzdch/Ik5cGWcLW/2h5r9PhewoeJhXTQ=;
	b=pjV+1f8GIV98puaeEVofNPIMaQ+fbwC/z/o7AavWE5FkAKyo7NuQF66QkMLpq9lNc/jo
	 fnmV8EYyhttMOphkCgHDB16oJVUjuZyM5VuzxwJRv4hfKwWc2J97P8Ud6b1JAYeH3aWYa
	 dI+9uTX/cQOG3zP+65pZ15YIDyBqDKM7+ZM6FmzDjiwwGefVMeMkMkX+Bantc3Jsshf7b
	 lxkNUwQhPMTMkY+a3GHmxrT0xdiZfhU8SShFsiYdxuGY4l5EXefliYfOlj5LQXnwy/NoP
	 FWvF8mB+1zHubi9zDBdZdbyjD+Ja8EWwYXf59mTw20TE2V+urL+6b8Xh0G7cPgwXVfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=DPjbDfrY;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F4606A31B;
	Fri, 23 Oct 2026 05:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21F4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=DPjbDfrY
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j9s5m12vgz6H5c;
	Fri, 23 Oct 2026 07:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792733372;
	bh=HIzE4xhnIQ5XIDCj7yubOdY20hHdv4Qa/jAqZeurEoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPjbDfrYpoi0TjO2DqaxmmdiUglBFaOO8DX5d1EqT2iT1StXeS44vDxP+FrH7hdzM
	 sUTsOQU85U2o085a6oh+VCzg+OzlpoLPeQyYNevve25ezrS4v1EvnFpOy5CHcBy1Fw
	 rU6aWaF5RX0a/Lwhg+Ea5g/ySdqDiW85i48sy5h3K11qNRCjDd/8F/kBCoAgvxbcVm
	 i4wystS1Qipj6+f7S/LJp+hpIRoXWZWKDbRWivXuKwTU3DuRHK6QPOdRZE3eC79L/A
	 a6c0UzSsunWv2v1XpkeVYE+hDEQ4Lw8SE9szI5fBc3fWfJiZ0Cim2O+RNsztlJr8DM
	 1Uxgo/dpKkO2A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j9s5c2xFXz50ZY;
	Fri, 23 Oct 2026 07:29:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j9s5b3jMsz8tjp;
	Fri, 23 Oct 2026 07:29:23 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9A9FD5F878;
	Fri, 23 Oct 2026 07:29:18 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d9115f08-88df-4799-9180-62ed11359f83@leemhuis.info>
Date: Fri, 23 Oct 2026 07:29:18 +0200
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
Subject: Re: [REGRESSION] 6.18.57: ACPI fixed power button no longer bound,
 ACPI power-off ignored
To: Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
 stable@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
 "Rafael J . Wysocki" <rafael@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261022162655.231431-1-fredericmariejoseph@protonmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261022162655.231431-1-fredericmariejoseph@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179273335900.851676.2243558642329476618@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 9A9FD5F878
X-NC-CID: K9S0CdHERiDSafk2HpeaAh5gSN8St9Wd7KVRIK312dIq3tLXKdM=

On 10/22/26 18:26, Frederic MARIE-JOSEPH wrote:
> 
> Since 6.18.57, a machine whose FADT describes a fixed-hardware power
> button (QEMU's q35 machine, so Incus and other QEMU virtual machines)
> ignores an ACPI power-off request.
> [...]
> #regzbot introduced: 38c79dacc8063ff8a0d75ce2a900fbaff82ad94c
Searching for that change https://lore.kernel.org/all/?q=38c79dacc*
reveals a earlier report that sounds similar -- and fixes for that
problem are queued already:

https://lore.kernel.org/all/1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me/

Could you please report back if those do not solve your problem, too?

Ciao, Thorsten
