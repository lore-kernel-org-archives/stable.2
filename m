Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D64A3D4C;
	Thu, 15 Oct 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056489; cv=none; b=P7B2mWE2rBybe5bTpDvbyz54KOLl6dr434ZxiiB/lRKepLztT2O4mcTMDfndlxADvpPY7vxnMNJJgwd+yRihRxPKVfpuxHmG76eh/wJvNz6ANTGNvSwBlbfVugMe9pSY3+4fuNh9h7JEZAIawZFhOm5G1HAcf0ksW58+j0Zj1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056489; c=relaxed/simple;
	bh=JrB6BaUJjw5NITp5DDMkWpNKvqBppRg+vr4TEGuH+5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X40E+KqLlzo2T+aBZ8i3NIF2UxWoDJywksrzivTZ0GGpiTbFSnWMAaGN5bunO5LwtpBs/WT9ekO1mqUptMCmNIsmcVwRFe6b61ic4ZMdUFXkxnLkYDLerl03YXDVxe9M92P2DI68bq9KimYcP6UlGJQqlK6Owca4zTiNKetxAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gseBVCMq; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gseBVCMq"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4j52mj1Bgxz76Xf;
	Thu, 15 Oct 2026 11:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792056485;
	bh=JrB6BaUJjw5NITp5DDMkWpNKvqBppRg+vr4TEGuH+5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gseBVCMqoKYVz5ylGfE/cnqQag4SoKFOIaWbu1F9Xbpvz7AD8wGSPQUjnlr3iwS7g
	 vZXyGFBHUevgehe/sl254CkjY4JJdFuxok5D4H8YRAujnpRf9wo/q8iFKattz8lndB
	 FzcZ81iZz4wak3WKoCTZPJHw86D4HITwb+Bbcqwzw3NBnFvzsVJQA0+M/12OuKI9Qn
	 EVEENRtIKCAp5oi8YanERXRPmc5h1i6XzjKmoK/f1yeeBpbcR0APaITvka/dHeslmO
	 ZvmNQBFBkfsL+okPTOpgfJZIELpp7HTij4ePrC8nAu0RaqjR6ApjUK2I2cc2w5hNbe
	 Oe5Y2iCiJcD8Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4j52mj0RZnz76XY;
	Thu, 15 Oct 2026 11:28:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j52mf2xdYz8tf5;
	Thu, 15 Oct 2026 11:28:02 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 90FF15F9A7;
	Thu, 15 Oct 2026 11:28:00 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e51025a5-8106-41b3-90fc-53e51891ea9c@leemhuis.info>
Date: Thu, 15 Oct 2026 11:27:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: track the perf mlock gift separately
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
 Alexander Motin <alexander.motin@truenas.com>,
 Ameer Hamza <ameer.hamza@truenas.com>,
 "Caleb St. John" <caleb.stjohn@truenas.com>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
 <20261015075817.GO2009045@noisy.programming.kicks-ass.net>
 <atCYFpm63elRyuw7@gremlin>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <atCYFpm63elRyuw7@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179205648162.3507777.14501017423963775184@mxe9fb.netcup.net>
X-NC-CID: C05WCq3tRTscu+zR3z0ATbzEno476my1YXpBYGDUjkpMVOchz8c=

On 10/15/26 11:09, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 15, 2026 at 09:58:17AM +0200, Peter Zijlstra wrote:
>> On Sat, Oct 03, 2026 at 05:29:07PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
>>> Resolve the issue by simply giving perf its own field separate from the
>>> rest.
>> So I'm a little confused by all this -- perf introduced this field,
>> others jumped on and shit broke, so we fix perf instead of the others?
> Yeah I think the blame really lies with the later users, and that send a trend
> that led to further confusion (including myself, mea culpa!)
> 
>> Anyway, patch seems straight forward enough; and you added comment to
>> the fields, which I suppose does clarify things some.
>> I'll take it. Thanks!
> Thanks, much appreciated! :)
Just wondering: how urgent is this fix? Is this something we should try
to get into 7.3 given that this was noticed in a regression report that
blamed it on an 7.3-rc commit[1]? That commit also made it to many
stable series now, which might be another reason to get in mainlined
rather sooner than later.

Ciao, Thorsten

[1] https://lore.kernel.org/all/asEllR7if-J3wteg@gremlin/
