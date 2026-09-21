Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08608485944;
	Mon, 21 Sep 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992791; cv=none; b=PdL5g1M0ttBKsY6tLT+f877Wyw4zErh4n0hI35//XiIDjwuVaqlQ2tJGF7W3lcbQwcdHR0Sz+HPt6va+BgLmYOveVspb5pSg1siy0623EH23i8XYFjCJ5RVQW+KP3P+Moiajcug3ZWTL3j0v0Jy42DcxjBK2Yj7iyBRKq6ws2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992791; c=relaxed/simple;
	bh=dpd+uWZSbe5JVD3oNk/ozKrHpJ4aJ/NHRAIXLxPRdm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAwnfZJa6i+Yjkmp4qT50vOKvFyBWPb7jteUbxmZinWZCZABI0pE+h62QEYtMPJpebQ8iO3x3K7BKRT0W8dMCOF8PhVnT0ZdOLHcFXr8m7Z8IPTIhSe2RiBhK0aKY08aA4iBfzA9Q6/RIQL+uQEwVYN41YXYS41ZUURAMnTYr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NGwWsrvo; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NGwWsrvo"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpMZ34Tzgz67Ln;
	Mon, 21 Sep 2026 14:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789992779;
	bh=dpd+uWZSbe5JVD3oNk/ozKrHpJ4aJ/NHRAIXLxPRdm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGwWsrvoxYsQV9Tknfh9Yz8FgWQmc1g4DTEwEs3YK50SYW+Gi88UnNt9DH1+Gq4UT
	 7tdh7SZWKVZQh1wUoYpp0Tr2HlLvL69BOH5RKcpK1mdFMYqF9uLGadqNmxqKtP/5dF
	 DZxTLhIepjPj6mq047FNH/yxsr4GuUz1axk6wn+C2vgDP8EAUMTHgAJF40Dpu1bebB
	 bgN1lfB8gchtyYBCBO7yiEjWi8+DAislnf66okVbFip6+Zi7mCdR4KBjlotWTnKQZ4
	 7e1V8UmLLsiM7TAQ0W5p+Q6jFOypmkz1czk2MuQdL8a/8LPrj4Gs+fMeuvguaAUN9E
	 BXLDCq5SNZb5Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpMZ33mVJz4yMX;
	Mon, 21 Sep 2026 14:12:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hpMZ22wQ9z8tfV;
	Mon, 21 Sep 2026 14:12:58 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0BF855F9D7;
	Mon, 21 Sep 2026 14:12:53 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c8f31f54-bd89-4b33-bcca-4cb7a37a3cbc@leemhuis.info>
Date: Mon, 21 Sep 2026 14:12:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: "Prica, Nikola" <nikola.prica@amd.com>, Bjorn Helgaas
 <helgaas@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
 andy.zhang@amd.com, jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 gbayer@linux.ibm.com
References: <20260918170735.GA1162623@bhelgaas>
 <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178999277363.460430.15838978290489561503@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 0BF855F9D7
X-NC-CID: ByO4sKkeqxS+9ZeRAJA8DoNCqbMF6EfFFO2Sl6JPSE673dwy8HM=

On 9/21/26 13:04, Prica, Nikola wrote:
> This patch fixes a regression introduced in v7.0-rc1-2-g1ae8c4ce1570.
> 
> #regzbot introduced: 1ae8c4ce1570
> #regzbot title: Breaks atomics operations for headless passthrough devices

Thanks for that

> One more question though, we encountered this issue with 6.8.0-138-generic
> kernel, we figured out the regression point is 6.8.0-135-generic. Since our
> validation teams are using older kernels too, is it safe to assume that
> fix will be backported in new release for 6.8.0-*-generic version?

To make life a bit easier for the maintainers I'll answer this: 6.8 is
EOL for years now when it comes to kernel.org aka "upstream". So only
the vendor that still maintains a kernel based on that version can
answer that question (I suspect that's Canonical).

Ciao, Thorsten
