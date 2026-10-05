Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817B30C168;
	Mon,  5 Oct 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241112; cv=none; b=ndtcuf5+JLzH1VXkxAnZjQUN4dEJpSJsXuRDhj2/YeGDwcrUB8yf/LEYRVusuzE7Nk41rCsNCe/rl7x3gdxHIeJ8kx4uwsqReUq7eAEX40UDMAXYyZKrQWI4UeTQesc6h0HLfPV47axoMzENBaX+Q5BJDIPg9SniRCf7xN3P65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241112; c=relaxed/simple;
	bh=YbIChEOL3ptri2LXxa3qlBjqQ0hf+hVpTKWCXP4FzME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtlUsw8r1OdWESWfgC97fi6zJpK/nlfmFB0xz+RSSElmazM96izO1tho8Isz9eVLZelksrbuK0+oKyee3bbyxAAtXCdQL0cH56HAkOkieDYfHUCOgiVHE17PRee1c5bl5KX1siuY+kdQu0eu9Aw2x3YgzPFbdyF6ye+1H9jVJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RreWbYwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RreWbYwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3ED1F000FF;
	Mon,  5 Oct 2026 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241111;
	bh=YHqtZCAF1YS3R+3clhU5z4/uaYRZAiBK++WyNrkIInE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RreWbYwejLsb8r5wyOo8e9q6v4Y5AAh1s8JRyaIbO32JN/Eqm/LagxjnUy5/jw6/9
	 iXTDFOBOHMMz+D32wbxQzw8zJF8svM6XLSnkkEOHM+LJeu6MmwG+SVJ+i5/IVhApn1
	 9kdMjn9pyFFPjVjuMN9TH48UOvho6dbzIn4OFFkZyGkEftYu4kSgGwJOw7aBm7OKS4
	 PcA00w4X7AmGOW3BS9JWL7OSJQjrLXtdmD/Y14WwIYI7Ad6LScH3tvd7HPZJzWsFOp
	 WAOtRRmELNKi62TFs/E4KGVRSAY2tpJHbE2iM7N3vzBr9Dagy7Nz0Idy1z3McPuDgR
	 fKbJe+HPPhb1g==
Date: Mon, 5 Oct 2026 18:58:28 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>,
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	John Fastabend <john.r.fastabend@intel.com>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: netdev LLM review for backports (WAS: [PATCH 5.10.y] net: sched:
 cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode)
Message-ID: <asQrlAkQSIGqbV7k@laps>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
 <179119639380.1402591.2155637888002963@kernel.org>
 <asOtjgd0NMXMjCCZ@laps>
 <20261005142128.30f80c5b@kernel.org>
 <1acb8eb0-3443-43e3-ab66-5328b98a6143@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1acb8eb0-3443-43e3-ab66-5328b98a6143@broadcom.com>

On Mon, Oct 05, 2026 at 02:51:18PM -0700, Florian Fainelli wrote:
>On 10/5/26 14:21, Jakub Kicinski wrote:
>>On Mon, 5 Oct 2026 10:00:46 -0400 Sasha Levin wrote:
>>>I started seeing these reviews on proposed backports of net/ commits, and while
>>>they are REALLY great for upstream commits, I do not think that these comments
>>>make sense in the context of a backport.
>>
>>Blah, sorry about that.
>>Let me add a regex on the tags to exclude patches with 5.x/6.x/7.x
>>
>
>They are useful if the backport does not cleanly cherry pick, because 
>it is possible to introduce bugs in the process of back porting a 
>specific commit. I don't think sashiko is quite smart enough to be 
>able to do that however.

Oh, sorry, I agree with Florian. To be clear, my objection was with the
questions that it's asking, not the review itself:

> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.

-- 
Thanks,
Sasha
