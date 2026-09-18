Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AC270575;
	Fri, 18 Sep 2026 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767650; cv=none; b=VvfXo2TDENlidyFCgV/nz8yUiepj7JTJRmSwTlaY2DPArfhEQ+YnFzbR/06iOaObgrEtMZotIi/IXnVzzaxmy2wTAXI5vZ7UX9bo8Qi/CpYr0e1SOblEI3kRO7lIp7qQRiomOO4bVcaFSicniWIT76UbELY6k/7lZEJql7Z2TIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767650; c=relaxed/simple;
	bh=Lv1aUjpHiM+ZpoixPXC1t7RIfxI1hsCjCKdjkeyW7Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lea5yjWE3NACy+QeZng5YoIVn2yV2k1RBzXZWQIFjjJianv0ebFHSojNwUNLjBqvo5E/B+q4gAub6bX6q13JOBexA7RwaB1VvWbiTfNiPJbuf0DTeg9VAXAtPNqC9Dknk10+VU8HcO21ngePYp8+CeGB5ta2w7u7TuZc8hOvPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdgbQzPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdgbQzPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71371F000FF;
	Fri, 18 Sep 2026 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767648;
	bh=OuoHiyIJPzQjjc8nJ4SI/y9+bjZS6wJxmuFUU8K9JVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MdgbQzPnI5p9zA1klESPlN1jFMwXwCA8bqbQb7PXk0PdmJXwCEHLWnTDVmv4+58hz
	 D2Ai8y6rPYFAETkwWC5U2q012Sh+UQNIicZwN2MC8npsxxYtGg9PP/sQIMX/LX1WU0
	 d+hTDzuozeTCdt6VYK/oTCwWKbmGZ2QhxynYxcBB9gjlSc0CUE8GN7Ab4JedMSNogP
	 Be7DVGctCO5KQiFtDnydmRPOoO/EKdODvTnXRPKyEIKCL2GofPXbkpninQ7lCMsSnq
	 QjsMEbF7I/vLWmnO6pDSAASLR9etEVkF00nIrI0fHgpxIrACq9qcauwtUOSMhJSCeN
	 edBbN76HmXWZw==
Message-ID: <6b916ff3-aeed-4d7e-af81-65ba8cb6d66f@kernel.org>
Date: Fri, 18 Sep 2026 22:40:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: Fix np reference leak in
 onie_tlv_add_cells()
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 srini@kernel.org, stable@vger.kernel.org
References: <20260917123514.2151346-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917123514.2151346-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 1:35 PM, Wentao Liang wrote:
> of_get_child_by_name() returns a node with an elevated reference count.
> nvmem_add_one_cell() only takes ownership of that reference on success,
> so the caller must drop it when the call fails. Add the missing
> of_node_put() before returning so that cell.np is not leaked.
> 

Same comment, do not waste time with duplicate patches.

--srini

> Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/layouts/onie-tlv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
> index 0967a32319a2..3d77680f089b 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -128,6 +128,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
>  
>  		ret = nvmem_add_one_cell(nvmem, &cell);
>  		if (ret) {
> +			of_node_put(cell.np);
>  			of_node_put(layout);
>  			return ret;
>  		}

