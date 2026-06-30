Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310D3B3C19;
	Tue, 30 Jun 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851406; cv=none; b=tO1/kVWLtvWPdsHhY7g1S0qj5msLP/vvbSOB6uLvQgH8kzy1rcibaQBVxe39D1MrDFKrWSO89KPaAgjCDghcqx3yUZ0sL7qfoiqUTa8NvgM/3bQ0aOtlttwKv1NMmm/2iunNMx6blgJc3/+ulFgZYJ8LutTqLjyVdxPuezq0od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851406; c=relaxed/simple;
	bh=Tgln74rz2Kjb3EWG+scMN7KvI8hzfFfZyYYTxErX/Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHBTOi2mTKkbl9YO+QvT/I5TyntSH9SwCfLYJA6yzZ2a7meE1hRta77sxYgZhwZSRcLzaycUp46a9FwoXoXLQ8ACo909dsDQI7WwVq0I5/ZPJe8pClSyKd6M+18We9FjDEj4dyN8YjbntDz+XDmuyLKCXKs4vjLhJoukRdBBYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=nH9ebcaa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="nH9ebcaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782851393; x=1783456193; i=w_armin@gmx.de;
	bh=9jrx+CrC+0jcONytMiV9tO3nmIDtBoV+ZdY3NMmY6+Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nH9ebcaarHVkQuE8zbFbaH1N+uWKXM68MEhUHgxYoWqx86NZQW1wghVB7UAN6ZZI
	 g7NNP2Yr/czqpKoCFBBHzruL7SZOvinbpl/eSc1Ys/se4vGgtNbYuZeHH2Y2lpFae
	 Pj12PpTEC4rDBwso6BJ37/iFDUwp54zsXSGYGaFPsKeTb7utfjgGCg4DomSPeCrBz
	 KIrWlax23WFjGKsXmYdF7P9QPXltKYIq/8bef15vHOotdgU3tuGGianpf3/Q7fqla
	 Ee4TC252w60aL3yo45kQqBBy5n5h/hgvLjoEfe/mZdlfVShKfy3Fq+1y++YxDxE2+
	 p5/0e/CuF2cQMuT0wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1wg2XM0i1V-0098NN; Tue, 30
 Jun 2026 22:29:53 +0200
Message-ID: <82c8271a-4747-4930-bc31-bc0786178c6a@gmx.de>
Date: Tue, 30 Jun 2026 22:29:52 +0200
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
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260626204945.18868-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wsO8aFSo+oTl4fL0E9vVz86ohsI+ude1WE21DAVwmY+ojoKOzwo
 OU6E4xB0HqNtrxD3uYJ+hFy2v/XCG+pYyUYNoEy1sSBiFjS4MFpQkGErApME3zoQilX6DN3
 eNBbcrlPmi+g3RsmBHqFkELi3W2CFLUKvZGTfRKG+1bpjO7sjncTJvHhMyvJ7ruIJvL2XRE
 Z6ey4TDu3xL84ahof/U+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k5M3xpU2cQU=;CLWB9hJiyTjk5EQ80y0pISiPNSg
 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
 quvvRgjNX7b7a8pcEw=

Am 26.06.26 um 22:49 schrieb Muhammad Bilal:

> The hp_bioscfg driver silently fails to enumerate BIOS attributes on
> HP EliteBook 840 G2 (and potentially other older HP models) because:
>
>    1. hp_init_bios_package_attribute() hard-fails when a WMI ACPI packag=
e
>       contains fewer elements than the per-type expected count (11 < 13)=
,
>       even though only the first 10 common elements are required to
>       register an attribute.
>
>    2. hp_populate_enumeration_elements_from_package() returns -EIO and
>       discards the entire attribute when any single element has an
>       unexpected ACPI object type =E2=80=94 typically after a BIOS AML e=
rror
>       returns malformed data.

Hi,

it could be that the ACPI firmware still transmits all the necessary data,=
 its just
that some package elements are combined into a single buffer element
(see https://docs.kernel.org/wmi/acpi-interface.html section "Conversion r=
ules for ACPI data types"
for details).

The correct solution would be to migrate the driver to the new buffer-base=
d WMI API,
because said API ensures that ACPI objects are properly marshaled into the=
 common
WMI data format. However this might require a lot of work :/.

Regarding the BIOS error: this usually happens because creating a ByteFiel=
d with and
invalid length does not cause an error under Windows. Passing a larger buf=
fer usually
fixes this problem.

Thanks,
Armin Wolf

>
> Hardware affected:
>    HP EliteBook 840 G2 (DMI: Hewlett-Packard HP EliteBook 840 G2/2216)
>    BIOS: M71 Ver. 01.31 (02/24/2020)
>
> How to reproduce:
>    1. Boot a kernel with CONFIG_HP_BIOSCFG=3Dm on an HP EliteBook 840 G2
>    2. modprobe hp_bioscfg
>    3. Observe dmesg:
>         hp_bioscfg: ACPI-package does not have enough elements: 11 < 13
>         Error expected type 2 for elem 13, but got type 1 instead
>
> Testing notes:
>    Tested on HP EliteBook 840 G2 running Arch Linux kernel 7.0.13-arch1-=
1.
>    After patches, hp_bioscfg loads successfully and enumerates available
>    BIOS attributes. Attributes with shortened packages are partially
>    populated and accessible via sysfs. No regressions on systems that
>    return full 13-element packages (checked via code inspection =E2=80=
=94
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
