Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D9341ABB;
	Tue, 15 Sep 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447303; cv=none; b=Q5M62MLVkZj+EotquW7MsdB86aQiD3PgCR8SaGgBdAQYGbbLPW8FhGD8FBicHYnb0gNzLxXe1dyRrP04K95FBY3CLwnRYuyQVLhd4aeId2aNGtZIMJfwJOJ4D14x5jmeMLICv0LbkdgC8MfGa7egJXNVB/gr/n2J0ibvfOX1Zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447303; c=relaxed/simple;
	bh=Ju8eEBCVHgcYCSDtTSvxH8+HI9wZGttAxQSi45Bswoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0+AQmJHIuT5LOS5d091qcSya2lACkfWep/BlzhkLLU5Ch4Xu8fHoi2TYRUBvYQm1pnd6IRjg4/KUE3AITdjs7I7qAOH+FWxvUX43RsKpc5J6x4WVvm7HHseuoQ4/1ikPcFHjhlxgTDb6SfdWSSwvVTIObK4ylcZr9ObFRtd1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YjiJYm9A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YjiJYm9A"
Received: from [192.168.1.22] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA0AA20B716B;
	Mon, 14 Sep 2026 21:40:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA0AA20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789447257;
	bh=1sQehgbLWYGj+S+yUfXvdCI2TMes99MZjrcGwUzDaFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjiJYm9AWuNLhyRL5alheaXn+Bfd/lmJegRMmM3/oMbFAQdJmoZY6JQNOeRrLs7eL
	 TG7KgQK7NncaysFM54SosVXffPki99wIxld/ueer5CBY0IvZvk/hh360emaosVYhx6
	 iTK31cg1lUAzqxVZ+OEgL1OdI5E0aJFPvV+NDZns=
Message-ID: <3f771293-f5df-4e74-aca7-5d34966d00e0@linux.microsoft.com>
Date: Tue, 15 Sep 2026 10:11:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
To: Hardik Garg <hargar@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Cc: mhklinux@outlook.com, ssengar@linux.microsoft.com,
 romank@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260911175146.1370148-1-hargar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2026 11:21 PM, Hardik Garg wrote:
> Register-page setup is optional for each CPU. If allocation or
> registration fails, mshv_vtl_configure_reg_page() warns and leaves that
> CPU's reg_page NULL, but initial context setup continues successfully.
> Meanwhile, successful setup on another CPU sets the global
> mshv_has_reg_page flag.
> 
> mshv_vtl_fault() checks this global flag before selecting the requested
> CPU's register page. With mixed setup results across online CPUs, the
> check passes even for a CPU with no register page, reaching
> get_page(NULL) when userspace faults in that mapping.
> 
> Check the selected per-CPU register page before taking its reference and
> return VM_FAULT_SIGBUS if it is absent.
> 
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>   drivers/hv/mshv_vtl_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index fc993560a45c..3296ab5c0243 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -912,6 +912,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>   		return VM_FAULT_NOPAGE;
>   	}
>   
> +	if (!page)
> +		return VM_FAULT_SIGBUS;
> +
>   	get_page(page);
>   	vmf->page = page;
>   


LGTM. Thanks.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
