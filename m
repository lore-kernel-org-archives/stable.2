Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759D20E702;
	Tue,  4 Aug 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882494; cv=none; b=YE0cGRquxCxfvUjxKPa1hnv/ya3mtrimYQYETgxw++FfeOrR+ZmX6BydQeHEgRA3WeIP7zTIp+CieapC6+cgLRZ6BCsYAlhmOsoD5Fn7T2DtcL1HzQU6EH31h/HAIeEhI5H1xpPl/8YxFJRZymC3Njh9eYKODDjSBm5YUFfusVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882494; c=relaxed/simple;
	bh=mdt0W9sI9DPNLVtNcWbATHR5J3IXzx5migq62Y66YOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bbni86DcQiB+rsfooym36ftFE8YBf+kRLGx9zELyCnA8DGZwHBrZFh7a6ZchhIMMyZe0vSiQW1t2Xil8N35Gh4Mc54XBr6D0NVz/0T6xqmADoyhDysPaOq6qpvtpvG3Ng0JLmBkvbqP3vcO+o1qtzNYIy3nKAMRiaUMjBjdAPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2wemNAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2wemNAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C631F000E9;
	Tue,  4 Aug 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882492;
	bh=IrK+sFIlkFTgCaWsK9DUWhSC502yfO7RwF/MpE5Myxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N2wemNAvBS2zTNnVQMWlqmNOOBvt7tnmkkBTQQKICH99Psa6lO+6bQlOtR/QB2yHX
	 IzSMt6tdzOE2AYMxqCA91Z6/S16+Q4y6KtR8W+tWe2rxmCYDO3k+ZNE0gBwraGEt6X
	 HOn0iT7E2uL8BjTeaTjJL1V4Jtxzu9840GpQ+yfXzfaxCxejb7pdiycKUxABsfxuA+
	 n3yZjO7ErIyQ2IrP43QZSImOnPI7w7FCHPyCbtt+JZFj/HhJolwncn0E8kU3acJ4cl
	 5KL/dAk9It/6xlq02XswUuDECXcRknjUh430JW6nRL37Y9lI6t4/uB7LV8U1xmlVqY
	 uNy7ieQxY/Vpw==
Message-ID: <04736898-ccfe-4d16-acc7-31d70c6276b3@kernel.org>
Date: Wed, 5 Aug 2026 07:28:09 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
To: Yifei Gao <gyf161023@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260804213626.3410403-1-gyf161023@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260804213626.3410403-1-gyf161023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 06:36, Yifei Gao wrote:
> nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
> reference on the controller and installs the completion queue. If the
> subsequent PCI address-space mapping fails or returns a too-small partial
> mapping, the function jumps to err_internal / err_unmap_queue without
> calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
> gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
> succeeds, so teardown never releases these references. A remote PCI host
> that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
> leaks the CQ and a controller reference on each attempt.
> 
> Drop the CQ reference on the mapping-failure paths. The err_internal and
> err_unmap_queue labels are only reachable after nvmet_cq_create() has
> succeeded, so this pairs the create/put correctly.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: it would be nice if could explicitly mention if you actually tested this
or if this is just an AI generated fix.

-- 
Damien Le Moal
Western Digital Research
