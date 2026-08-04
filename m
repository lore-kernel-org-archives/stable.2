Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDF43CEC1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833878; cv=none; b=Hfl2pzgTkWxSCqb33/mZFZxjwsGiDOEYU6dLee5LvxdLFyh/0L04jvyvYfvPwcTDPJ3RPaPEWj9Mb3ypSbZjM01oNL4ncrOi1VlZiw92AYGszk9eDvTGaR+V3UUWgLWGGNFjJgvSBtQM87P7gVZYQ6sjzeFoOwBNg8DgrqcFu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833878; c=relaxed/simple;
	bh=EOd681BQys4pvZTCTiYw2QJDUa244+ZMLA9YBjXj9So=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQqvZY3wqhljwIbw65srUq+vayTdonYolrvYgXSlk+3pirONpsjtfNAdWSJlRTOcYiz1//WqDie5V25iZOmrvrg6zK5MwZ9/3Uc0hyaENFDk8tRZgpNqEmxbKEqzi9eT7t34BYLNRyMF4bOKXDcfk5NZ/T6bTULZlwSEuuXVlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ds3AHZCE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ds3AHZCE"
Message-ID: <1793132c-dd25-4ee0-bc66-f3636522164a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785833874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZVXe8L+2Fnvzy7d9/3jr9E+oS8Mu00TYoXRjiTMQ7o=;
	b=Ds3AHZCElBMXf6UN65dZ2S9XCWfPT+p6sYiiJ7gQrxWL3XUdznlhGq7BqsDPefV777QUE4
	jYOm4P68sGda/mekjKBl1Jx5as1uHjAo9X07lPB9TfCGW0tKrKcdP5Hw/luuGeFgn1/9ce
	h3OToS/B72xJiKBkagpTBbZxp4pGdVA=
Date: Tue, 4 Aug 2026 16:57:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, WANG Xuerui <kernel@xen0n.name>,
 Rong Bao <rong.bao@csmantle.top>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Fix acpi_package_ids array overflow
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <20260804075719.1137338-1-maobibo@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260804075719.1137338-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/8/4 15:57, Bibo Mao 写道:
> With LoongArch virt machine, one typical setting is one core per socket,
> there will max 256 sockets on one VM. With PPTT acpi table, array
> acpi_package_ids will be overflowed.
> 
> Here change array size of acpi_package_ids with max value of
> MAX_PACKAGES and KVM_MAX_VCPUS.
> 
> Fixes: 4e8f58620f67 ("LoongArch: Retrieve CPU package ID from PPTT when available")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kernel/acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 873e90990771..cb454ee92b20 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/kvm_host.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/serial_core.h>
> @@ -202,7 +203,7 @@ static void __init acpi_process_madt(void)
>  
>  int pptt_enabled;
>  static int acpi_nr_packages;
> -static int acpi_package_ids[MAX_PACKAGES];
> +static int acpi_package_ids[MAX(MAX_PACKAGES, KVM_MAX_VCPUS)];
>  
>  int __init parse_acpi_topology(void)
>  {
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
Reviewed-by: Tao Cui <cuitao@kylinos.cn>

