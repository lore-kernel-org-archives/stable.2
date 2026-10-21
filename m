Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590855;
	b=OCq/nzFNYyC5j89cEA/OgM7C3vl4PnNhh8jtrnTg4bKToDzB3eyy7Y9qxx5GiOwKz0+o
	 KvsaxLcmECR7Jwh2SIaxHBEDCnN5z09fDyEiD2nvG9xdYtO6FhJikohGkkOa7XGSietad
	 1EM+1+qULieiUtIqPPMuvy9cRq84+zbH9AXJI5V+pcr6Ukh3TTT8tySfDLm0IuzH+SI2i
	 P9FAwhZAVoxNd+DjGfKRAUDD+vqOBxSHRlXyQKeMOB3ylySf+VNp760ElEGjkjZ+iDYNG
	 h1TsGM1sRU70kNQ4tMfd+yO3GiVGv/fIhcHto3aPGVMLg+cOPf8j/4HGc8hF76R7R6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=1W9snRxGb2Dueqfe+SJB0GolyjLQkquHng3Qp2HEBx4=;
	b=Rp6aO3awi9SQypTKcjU7Y5+cy60L0golk48a47cGhIgFr8eNcrPMq5t7ji1oZN0iHGwz
	 ZF06YboqzUx1C/ADEpoTQ6XA2fJJfhQYyJv85zvDQi4FLH1yVTPR6vGpmhQL5BHs1/BYG
	 p12HhAhvc422HFMNOV0eNeavqAjome2A34EM1gTpKjM0aZVFjajxwG+XvJwDlDT0rDyh4
	 omt/M9MsJ8k8wSftVj6DVUhLZxVFexzNEuHCpnDdYvTsf7nxhE4qvZC9B125xE45et6Ao
	 i8jyXhnB0h1S2sYQ1CWkYJl5li43HfttW0ZviL0XW2G0rly3gi5btpNu009khHUExOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=eltxvrdB;
	arc=none smtp.remote-ip=188.68.63.162
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D0606A319;
	Wed, 21 Oct 2026 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9D0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=eltxvrdB
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8rP01kHDz3yQ3;
	Wed, 21 Oct 2026 15:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792590852;
	bh=1W9snRxGb2Dueqfe+SJB0GolyjLQkquHng3Qp2HEBx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eltxvrdBrGuvr+VeMJVD6WW+GvPmmxOnTnRHy4bro6KHPNesZB074SuvgYsqrMR9q
	 CYMkSYbBu1WFbSeqSWay0fIyD9sisB0MSpvXoAEY5Ch6uvHkBIZfAPOUBI/palMBOb
	 buinrYcUFXcc7zYk7TgB3vUaa6KiuZJMl7mLHUHD66w26DfH+qSDilrpkN80sWlDiF
	 tKmnqBF9GryA14xP660blxP7Hj10RW46r2FD0UMNgDzG9e84uJX3ZBxbTdmXByqpzw
	 EmnaAFDAP72McFKKZLfOAOVb/MsEP8q9u4n5Uq2W3JtPKtev1pN11PQ5gt6p+5JGmW
	 w6EXgWTla7fSg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8rNh4Rw4z3yw5;
	Wed, 21 Oct 2026 15:53:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j8rNg6gzZz8tjr;
	Wed, 21 Oct 2026 15:53:55 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D492D5F8D5;
	Wed, 21 Oct 2026 15:53:46 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e8e153c8-2c09-4b86-8991-a8eed56526cb@leemhuis.info>
Date: Wed, 21 Oct 2026 15:53:44 +0200
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
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and
 hangs when tiny_power_button is built as a module
To: Mikkel Sejdelin <mikkel.sejdelin@proton.me>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>
References: 
 <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179259082737.842613.2678257844613427806@mxe9fb.netcup.net>
X-NC-CID: UIlnd6wQu6n3PzuMLOc3ZGkfGlQ7p1Ecdf/WpZQ4wEEOwVJaiEE=

On 10/21/26 10:35, Mikkel Sejdelin wrote:

> Since 6.18.57, my laptop never comes back from suspend-to-idle: on resume
> init receives SIGRTMIN+4 and starts a poweroff, the display stays off, and
> the machine hangs until it is forced off. 6.18.56 works fine.
> [...]
> Suggested fix: backport f4203ec64e11 together with 52d864019636, or
> revert 38c79dacc806 (and its dependents) from 6.18.y. Note that the same
> backport also appears to lose fixed-event power buttons (LNXPWRBN)
> without ab06eb920401 ("ACPI: scan: Register platform devices for fixed
> event buttons"), reported at
> https://github.com/siderolabs/talos/issues/14657

FWIW, ab06eb9204010c ("ACPI: scan: Register platform devices for fixed
event buttons") is already queued for the next 6.18.y release.

Maybe your request to pick up f4203ec64e1155 ("ACPI: tiny-power-button:
Convert the driver to a platform one") is enough to make the stable team
pick this up for 6.18.y. Ideally you would try if this really fix this;
or have you and I missed this in your mail? Ciao, Thorsten
