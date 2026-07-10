Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A2381C4;
	Fri, 10 Jul 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654081; cv=none; b=SufLHuznae2sunK5DQe1xI+LMcqNqXFR/UNWeuC26K0XxkRoga4yMxcUVv9hXdQ72Ga/aG5/PI8P0st/k+Pbij+AsRaBjdfCTPCcw7eLSA6Pry3NdrxltNpmP94LkVvJ5zJRX+mHdzc7SSX38jH52txNwsUAjoTPOzZOGnOgO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654081; c=relaxed/simple;
	bh=cE0B9bW/ANROYP3RFW3uwKXXKLWhJF99I2RISDviq0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tufXnHXcPmuXp6zXhtSZYlTnAurWDAfNjkLBriZ9ElTysuAgBQqpxHZyBClGFbH2BrKO5hJ+RiHztrVI03T1HhuZFXbwNcZ8JAj4RmYRr+oyBLQAkrTj8zGnFoPIqTPaBVtX/VgimezMglEqvltAbpTsEJvxG9KLY9SMhf31Tew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJuQMTiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJuQMTiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA331F000E9;
	Fri, 10 Jul 2026 03:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783654079;
	bh=0KC2NEqiwuxRfm3Qsk1EFtYhbUETyKz9jYkvkW+WGMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WJuQMTiYh/yqtt45gXuT2EB3hiFUaRB1d180Wva8rLVQgwNClZXn/bC9aXpu3DjMU
	 TChDz5eC0Pn0DcuQVohx5OPqUYxqS1+ezlpUb1AgGr6HZiY38LZMIqhmj/1GSQj0ov
	 atPZjG3PhsaNAjgwMNtO0f9LcknQPx7J5Bj7wum2Qzp5CVeLwPMOh02UUQcaLWCu2c
	 5XP5R4CLDTp4fjbKT+/nrupFRC+cCEGz3FoRLl2AtZnOjrNxB8DX2cPzn/Z9CIqMuG
	 mVgE9W0y3CK++v1uRLwhigJdJd51mHZjisNMeZCjgLM/ke6aRstk7ahwV8Ilkozlp7
	 igSRKDmTsYqeg==
Message-ID: <bf3201f1-cf49-4c4c-8104-ec50f2d4ae69@kernel.org>
Date: Fri, 10 Jul 2026 12:27:47 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-pci: validate queue IDs against endpoint queues
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
 <20260710023015.3744082-2-michael.bommarito@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260710023015.3744082-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 11:30, Michael Bommarito wrote:
> The NVMe PCI endpoint transport allocates SQ/CQ arrays using
> ctrl->nr_queues, which is capped by endpoint interrupt capacity. Common
> target admin validation only checks queue IDs against subsys->max_qid, so
> a root-complex host can submit Create/Delete SQ/CQ commands with qids that
> pass the common checks but index past the smaller endpoint transport
> arrays.
> 
> Impact: A PCI root-complex host can crash an NVMe PCI endpoint target with
> malformed queue IDs.
> 
> Reject queue IDs that are outside ctrl->nr_queues before indexing the
> endpoint SQ/CQ arrays.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
