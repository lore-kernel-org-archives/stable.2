Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F1205E02;
	Fri, 10 Jul 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654203; cv=none; b=eH4N+EPViU6AJdw0mHY3L2c70hIgGFCOuuti4GxHIw7R1wak94oomV8Sik+4NKtVH417iBubcIL+V+qLRZVFmyx2nVunapzdcD624stPWePNimisKOqLOj+5r3SYq0gv3uRdsbERd9+Gfj72Zog8ohWTkzHiVbU06f8wsxNRGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654203; c=relaxed/simple;
	bh=1sLRl3P3PdpKPo8zRbVYQgDu7SUS5+X0DApPQZrywtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukP/L8+IJkzKFoTUxRkflT7wmCTGu6Cvz2x5vjLE6naWcIZyWE8b9Y9l9DZPau+tR86XPYg0TWgVlRXLJZVPv+TM5oS9VEATGtOO8hJclR3L+shnV0Oq2qA1M1oj7DMuNZRIn0iTy7q/0Wyv4oufrIfxc66c7OvvgRDVmSsAA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7g9c12G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7g9c12G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B988B1F000E9;
	Fri, 10 Jul 2026 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783654202;
	bh=1DS+OkK07L8Eap9/ZYD3L5NCnYAkX05R10505TTEdLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b7g9c12GrubGWRnAJo8Y+VAUVQe3bDOL6P10dmcMoseMWD8dMi69fPnaq4NQdw77o
	 EwLUh4Ac/IeKJndbGqF0hfz4EITmOV/ejSgOUDv9Z1EpBiPVh53y1XbWsjSem/FcyS
	 D4xAtPEzyxb3+SCbL7rKGSMgb8xsD2B6l92iFtmSX3C/zvyhMbvKWtP/U8OXoydjZa
	 FFbXlbsyk9F5eIycNDi1T1IbgTWycVUGlCs3AY4caavTm8d5JrhresoSz7zhNFM7kl
	 Rp62xtlIeLGyXE+rXnYXglSqrDBpJP/VdKL1HGrl52JmcUPIH1CHijVdt3hFDnOFxB
	 JBrfGmg6A2A6w==
Message-ID: <6e835ca9-42b8-439b-a9ab-922a0b70c6a0@kernel.org>
Date: Fri, 10 Jul 2026 12:29:54 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-pci: add KUnit coverage for endpoint queue IDs
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
 <20260710023015.3744082-3-michael.bommarito@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260710023015.3744082-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 11:30, Michael Bommarito wrote:
> Add KUnit coverage for the PCI endpoint target queue-id boundary. The tests
> model the case where target-core max_qid is larger than the endpoint
> transport's ctrl->nr_queues, confirm the common qid check accepts the
> malformed id, and verify the endpoint callbacks reject out-of-range
> Create/Delete SQ/CQ requests before indexing transport-private arrays.
> 
> This covers the regression fixed by the preceding patch.
> 
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

I am not very familiar with kunit tests, but looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
