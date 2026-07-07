Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105443AC0D0
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407571; cv=none; b=VbokZdpUhZ74cAwPeP7SwGK8HNUJ52ybkAzYQj+4wWZvOiAw4YoOHU6kKp80b7Lomx1Riycy2YEFPa1bURl3vUiBJRrBXhPvkYXPrlhq/XI2kqMRi8Mu3RyccPSOrLHb+Tp6Ve6Rgdo+8OqBRyY02PHNYXPWhpfTSc7bh6J7/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407571; c=relaxed/simple;
	bh=vIxIQqpTIhDDpxaWL/KxlpymPgYqFIm+IIELYKWx95k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4NjxXIh0yFadJaQumLxayySbUarWd9npivv+TuWtLJcci0vLc6qQBCIz6sdlnrwWMxiQbfP/qUxbrnxM4iLKwW2VWHhBiZU0VQVc3iNncp+vW3tUyveNl8VN3DLzQEm1xXpAy/tLRy1x0KV1yVpPQJeHQANMvJOLnbF0k0wMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VrFm2b+0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VrFm2b+0"
Date: Tue, 7 Jul 2026 08:59:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783407567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3mZO7NTFKwd7aHo5QwYs5BUY5MkVsANllXsSCa2qZE=;
	b=VrFm2b+0l3DoRENXcu2oq2+VoUSPORFXWwBWSpMDShvNzdUzeQux2FVSRMbWyi7PZesnE6
	icAHh1s7Y8EC9bFxgk5HBn+5/6R8DbllGINY5Ep+Q8u3x1nqo3F9hwlX7k5FYRHJPoIweP
	J25P0up1nNwqJCdsByOUKUsimX69ZmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/boot: Reject overlong acpi_rsdp= values
Message-ID: <akyjyoPhYdmzYyvl@linux.dev>
References: <20260621170010.276591-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621170010.276591-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 21, 2026 at 07:00:10PM +0200, Thorsten Blum wrote:
> cmdline_find_option() returns the full length of the acpi_rsdp= value
> even if it is truncated. However, get_cmdline_acpi_rsdp() only checks
> whether acpi_rsdp= is present and does not reject overlong values that
> do not fit in the buffer.
> 
> Reject overlong values and warn to prevent boot_kstrtoul() from parsing
> a truncated value and thus from silently using the wrong RSDP address.
> 
> Fixes: 3c98e71b42a7 ("x86/boot: Add "acpi_rsdp=" early parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Drop the newline as warn() already prints newlines around the message
> - v2: https://lore.kernel.org/r/20260621131836.175468-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Warn on overlong acpi_rsdp= values (Boris)
> - v1: https://lore.kernel.org/r/20260617130417.36651-4-thorsten.blum@linux.dev/
> ---
>  arch/x86/boot/compressed/acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index f196b1d1ddf8..aed27604c11f 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -184,10 +184,15 @@ static unsigned long get_cmdline_acpi_rsdp(void)
>  	char val[MAX_ADDR_LEN] = { };
>  	int ret;
>  
> -	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
> +	ret = cmdline_find_option("acpi_rsdp", val, sizeof(val));
>  	if (ret < 0)
>  		return 0;
>  
> +	if (ret >= sizeof(val)) {
> +		warn("acpi_rsdp= value too long; ignoring");
> +		return 0;
> +	}
> +
>  	if (boot_kstrtoul(val, 16, &addr))
>  		return 0;
>  #endif

Hi Boris,

Could you please take another look at this when you get a chance?

Thanks,
Thorsten
