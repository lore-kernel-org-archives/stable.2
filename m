Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4D42BC33;
	Mon, 20 Jul 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556809; cv=none; b=smJRU+x57aUBnpYzNs3aV0YfTwrIYVmgLtQjvmxDJKGdPwJPfgy8ODUMUU9uq0Ej3OBNGy+cI/JRkLlNejDL5KZdXidLi5pnS7sEkXJVjF8542USQ9qXRMozhItisxqoEe1zsa+vjvidsoqOVWe1IIS5BfAbibahyOm1Wf6+JY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556809; c=relaxed/simple;
	bh=gyeYMfx2Pv4MTur87xIatlvuP/dsiXYa/GpSF3VAJ0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN3FLSC5P7+Kl2FyvpNQXTTZ3gm1zC55Iy6cX/jHsfmw7aZSISZwUjx7I8JKeNCKv/QPNcvn2kXfTmbtliiv+kr2b6Ua/LZ38kwgwH2QExEUXDdxyzaEKL4+EM8XbPU2/OtocHxrdL+Iq+hkRBXp5rBoJOexlRV4KX6aDe6dltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzV/mjHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzV/mjHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDE1F000E9;
	Mon, 20 Jul 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556807;
	bh=CqvcRS8MbvZHooKKiQBEFXsX+dokNE5uYuQ0vfjb0yg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BzV/mjHcCWZS1tZpMs1jroe5i1aPVgJKpaz41Z9oo7B+aXubYGUq/nt/JAOCjThlN
	 jaQJLDbFqDa1w4g4MUb6XM9s/YfX8/sO71Yn1rMtS9ywrgiIMcEkxrUbgncRslqHCf
	 brJ0vetUmp9RXVuBro0CihwhqJ94crg2WBjVGc8xm2H+D3r9FUDhZ+4TTqG2oRZ9Mf
	 jXVBBMgNrLXp4gMZTyvcpc5nhHXgjjPXfXpPBZbHIThXvtID5Syl442AiEVSlrV/QP
	 FGEj+HY+B7gyKZWuAbkcHsAWMXgDnjcWHCgXgDywBhLPucrNzMK0WHc3VKZLyTUWEo
	 yTKeZL70tD91A==
Message-ID: <e1ef6af9-3040-44ae-ad00-5e9011c8edda@kernel.org>
Date: Mon, 20 Jul 2026 09:13:25 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] EDAC/altera: Fix device node reference leaks in the
 SDMMC ECC setup
Content-Language: en-US
To: Rounak Das <rounakdas2025@gmail.com>
Cc: bp@alien8.de, tony.luck@intel.com, stable@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <182c3d64-17b7-4e18-9bbe-2fd97eb231a2@kernel.org>
 <20260717131720.19038-1-rounakdas2025@gmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260717131720.19038-1-rounakdas2025@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/26 08:17, Rounak Das wrote:
> Under altr_portb_setup() and socfpga_init_sdmmc_ecc(),
> of_find_compatible_node() was being used to look up the sdmmc-ecc
> node. This node wasn't being dropped using of_node_put().
> 
> altr_portb_setup() did not drop its reference under its success path
> or on any error path.
> 
> socfpga_init_sdmmc_ecc() did an early return thereby skipping the
> common exit label and thus leaking the reference.
> 
> Add the missing of_node_put() calls in altr_portb_setup(), and route
> socfpga_init_sdmmc_ecc()'s success path through the common exit label.
> 
> Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
> Fixes: 788586efd116 ("EDAC/altera: Initialize peripheral FIFOs in probe()")
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/patchset/20260708091135.94114-1-rounakdas2025%40gmail.com
> Signed-off-by: Rounak Das <rounakdas2025@gmail.com>
> ---

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

