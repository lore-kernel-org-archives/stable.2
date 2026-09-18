Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76250320CB1;
	Fri, 18 Sep 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719790; cv=none; b=WcCLQvQgUi/ClNVSCcMoz5AEmebTrOHSTPR0KXEVoqLz/W26yPTWoTb1ZTXIlaCwfpmfbG9u60WHPXEdA1nKlUmjODdoX81iMc2R0rb05qI+5V3sd+LmaTveV0OMINIE+1PEkYfNxKQVW99HzBNM3oFPw/skcbrke+R/rcrGEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719790; c=relaxed/simple;
	bh=DHMjIxnciGUnPI78PIC6iMJrlrTMhmsooQqQ5lYryuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFYqCxXlp8diNf4LQ7GQjatRwq4wJpdhpahoXqeE0qxVBVC3CxCjNlFFOsBD6u5/C38PuTF/gxAeTWnOOjMXYINnBszgbE9dwov5Fms40fpz3srgCqxU7s3ZUfwqUWmUTCtKEmkiGIMg1bAz8aL77HSrb/hcnCWAL3yRxPvwCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qLpjqy7r; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qLpjqy7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789719771; x=1790324571; i=deller@gmx.de;
	bh=Pg8MJ1vSDzHARO8W4kTT49zDxaBfimVTwxk6yfv49Y8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qLpjqy7rZuJs0eyJuMkV6p1AjMOIj6xbFoyjFBw0gnhF9yvcwFO0hKMGhmWoxlXM
	 CdEm4Tvce9DUyb+u0BJmDl5LpWrb6waZIYh+LQmllWEd0Wu9jgnGGHOZUUNMkbSID
	 gAwIMVhyXECSUMK2F2rn9TYpNhVG3i5wfYj/TfCmdq8VFsn+990H0yZhc8oeH0gwk
	 UQoS0bD3cWumrSkHRWaopCQXGh7GzMfmxiDNanu5OcFhGZBycuhEIrVXD9V9SCrMl
	 s3BZkuY1jFX5fIAZwutqicdMQDrVhHPAY01UZdk/ADxDxcRtrwdd6Zd1UUA3gYeaG
	 0Xg+dyHzeCNVvWlkSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1wyN480In1-00FXpb; Fri, 18
 Sep 2026 10:22:51 +0200
Message-ID: <42e0fc0c-caaa-4d2b-bedc-164323bddac5@gmx.de>
Date: Fri, 18 Sep 2026 10:22:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] parisc: parse early parameters in setup_arch()
To: Zhenghui Hao <zhenghui.hao@qq.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 stable@vger.kernel.org
References: <7c90662b-903e-4624-bc97-96b1187332c5@gmx.de>
 <tencent_25C26948D9C4B056CBF12565F0600C4C2509@qq.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <tencent_25C26948D9C4B056CBF12565F0600C4C2509@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7k1PaEOwPiardAc11OI+A+ZTfGnuDe5vIophvPxzJHW1LtJPMY
 5azMdFXwK5W9XiWH92gby/4oSQWs1NgMFDn6iFZXaqXx2Xc3XY5jlDnQANn7SkyzDWJYPBT
 K4RpVRyEswJu8xdPMuGZ8Fm0CUgLlo/ZnkMW4NUABAX6ZqceCDq/PeDNBlE8kSutPyyEkVD
 qbRbcyFoICcxZumK9Drxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xZ3Jg9s2qj4=;6boRxEpTqcDrUN5SHkGcxR0aqRS
 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

On 9/18/26 07:46, Zhenghui Hao wrote:
> parisc is one of the few architectures that does not call
> parse_early_param() from setup_arch().  That was mostly harmless until
> commit d49004c5f0c1 ("arch, mm: consolidate initialization of nodes,
> zones and memory map") moved the consumer of several hugetlb command
> line parameters into mm_core_init_early(), which runs before the
> generic parse_early_param() call in start_kernel().
>=20
> As a result hugepages=3D, hugepagesz=3D, default_hugepagesz=3D, hugetlb_=
cma=3D
> and hugetlb_free_vmemmap=3D are recorded after they have already been
> consumed and are silently dropped on parisc.
>=20
> Call parse_early_param() from setup_arch(), after the command line has
> been set up and the memory inventory has been taken.  jump_label_init()
> must be called first because early parameter handlers may enable or
> disable static keys.  Both functions are safe to call more than once:
> the generic calls in start_kernel() remain in place and turn into no-ops=
.
>=20
> Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Fixes: d49004c5f0c1 ("arch, mm: consolidate initialization of nodes, zon=
es and memory map")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhenghui Hao <zhenghui.hao@qq.com>

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>   arch/parisc/kernel/setup.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
> index d3e17a7a8901..4d3015a411d6 100644
> --- a/arch/parisc/kernel/setup.c
> +++ b/arch/parisc/kernel/setup.c
> @@ -132,6 +132,18 @@ void __init setup_arch(char **cmdline_p)
>   	parisc_cache_init();
>   	paging_init();
>  =20
> +	/*
> +	 * Parse early parameters before mm_core_init_early() runs.
> +	 * Several early_param() handlers only record data that is consumed
> +	 * from there - for example hugepages=3D, hugepagesz=3D,
> +	 * default_hugepagesz=3D, hugetlb_cma=3D and hugetlb_free_vmemmap=3D -=
 so
> +	 * the generic parse_early_param() call in start_kernel() is too late
> +	 * for them.  jump_label_init() must come first, since early param
> +	 * handlers may enable or disable static keys.
> +	 */
> +	jump_label_init();
> +	parse_early_param();
> +
>   #ifdef CONFIG_PA11
>   	dma_ops_init();
>   #endif
>=20
> base-commit: 4982d3552a3bf94de503acf93433277d08421de6

