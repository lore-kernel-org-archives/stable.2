Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2634A79D;
	Fri, 26 Jun 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508482; cv=none; b=RwbFTUuoSzbiy3g1n2NBSwyivL/UpSkjJNC07VpsOuJ7IheVF08q4VvWu4Wzpj0CDWfps5lsWrepzsTjcB+1sEKHwtPFfJwXbWLSbZVJdRPZCGNE7wF5kK2v4Md0F4KClcaR131ABZ7bzfh1aUJ9zWm11YSWDXZO9rXryGIdLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508482; c=relaxed/simple;
	bh=qxOAVD2IVgxGYDXAssIoyviDaflFIw5rrqHn+lcy97E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIAAfIBMLb50D27f9/upZW6v+Y3J5u3vK9WkTafUeYu3ARaz7aK1NogYxAR0qogkS87FwfF1xi7rxHQtXRFkNv5UWsCMJ5ldhCEgB/7S4pLsUTfqbnroS1CVJ8qNpf/DJS51CBeuB536O8Iljr6JhO8BilQbOzPGsjGFoqXV94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNISukl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNISukl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2611F000E9;
	Fri, 26 Jun 2026 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782508481;
	bh=lOkQRA9yEqIS0HRbN4Jb3YffZ0tu56nPTonrEBLDaCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WNISukl8DdfiIe1sWNuew3iqtHAzuC69CtB3W3vBrVvOR9O19q2QY+oPR/LhdOrsc
	 pK02+uoFNLQ+aFUW5JzBUdgJt7N3vN0grGI3oiG8qJgRiGFkDIZJEf4ORZwMX7DRWc
	 4ZiahtD7cee+YdbR9ArNDi2kIIA6yU4uvj8Ce6mSQ4wIbxEx04Q2LoA2E+GrmCwJ7y
	 MgsA3QNmi295PJp/rk/ywSKl6Yqx421+3OSoDlgYjfxDbkX8atephUda9TTx2/7O+X
	 SsFZhDzEtgSHYEIdbiB75NZStxv2YswexsAeynX37SKZYG4WGUunVbZb/i3YzA3b4X
	 rhwOXbRzH7ysg==
Message-ID: <7d4b85ca-ec2a-4c43-aa39-58148ccef82e@kernel.org>
Date: Fri, 26 Jun 2026 16:14:39 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: hp-bioscfg: fix attribute enumeration
 on older HP BIOS
To: Muhammad Bilal <meatuni001@gmail.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626204945.18868-1-meatuni001@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260626204945.18868-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/26/26 15:49, Muhammad Bilal wrote:
> The hp_bioscfg driver silently fails to enumerate BIOS attributes on
> HP EliteBook 840 G2 (and potentially other older HP models) because:
> 
>    1. hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
>       contains fewer elements than the per-type expected count (11 < 13),
>       even though only the first 10 common elements are required to
>       register an attribute.
> 
>    2. hp_populate_enumeration_elements_from_package() returns -EIO and
>       discards the entire attribute when any single element has an
>       unexpected ACPI object type — typically after a BIOS AML error
>       returns malformed data.
> 
> Hardware affected:
>    HP EliteBook 840 G2 (DMI: Hewlett-Packard HP EliteBook 840 G2/2216)
>    BIOS: M71 Ver. 01.31 (02/24/2020)
> 
> How to reproduce:
>    1. Boot a kernel with CONFIG_HP_BIOSCFG=m on an HP EliteBook 840 G2
>    2. modprobe hp_bioscfg
>    3. Observe dmesg:
>         hp_bioscfg: ACPI-package does not have enough elements: 11 < 13
>         Error expected type 2 for elem 13, but got type 1 instead
> 
> Testing notes:
>    Tested on HP EliteBook 840 G2 running Arch Linux kernel 7.0.13-arch1-1.
>    After patches, hp_bioscfg loads successfully and enumerates available
>    BIOS attributes. Attributes with shortened packages are partially
>    populated and accessible via sysfs. No regressions on systems that
>    return full 13-element packages (checked via code inspection —
>    pr_warn path is only reached when count < min_elements).
> 
> Relevant dmesg (before fix):
>    [   11.xxx] hp_bioscfg: ACPI-package does not have enough elements:
>                11 < 13
>    [   11.xxx] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT,
>                Index (0x000000032) is beyond end of object (length 0x32)
>    [   11.xxx] ACPI Error: Aborting method \_SB.WMID.WQBE
>    [   11.xxx] Error expected type 2 for elem 13, got type 1
>    [   11.xxx] hp_bioscfg: Returned error 0x3
> 
> Muhammad Bilal (2):
>    platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP
>      BIOS
>    platform/x86: hp-bioscfg: warn on element type mismatch instead of
>      failing
> 
>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.c         | 11 ++++++++---
>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.h         |  3 +++
>   drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c |  7 ++++---
>   3 files changed, 15 insertions(+), 6 deletions(-)
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
