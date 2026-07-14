Received: from relay2-t.mailbaby.net (relay2-t.mailbaby.net [205.209.127.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAE49218E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.209.127.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041003; cv=none; b=i06q3Q7ZOdT9PbnEVrzpwr4O6+jemZ5PS63cQCk6mKwbK30syjWNuX+4e3Xwu8GloEm25+Ife9Jto3yZXktyMBGFdb/geO/kZQjZglVe/RA3vD8MawYO8hQ2+VSSzuSdBxOGZGPCj59ZeAyLFntikbMO7jDeEIrZAiEaJLwoNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041003; c=relaxed/simple;
	bh=KiM2aN8uT6kr/hsc32GUqI5Xdj4wQV0rioA3HBeCsb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoLlIBLW+tDFy1tkoNDgxArJKIZxAdEgK0oMEH58aanxH84SGZm+2fLSKEWT0Cpt8CgkWXpRgOm95pEAsGEkE7JZwLUpOJ1uIwJB+nGZSjM4gVhKKTBlDri9tqUjGru3SYzhZGRkKJbgdyRprcWDQklkUI6EfmM7dg/QEoUTONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=ilRI7Xly; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=qNYtXSjX; arc=none smtp.client-ip=205.209.127.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="ilRI7Xly";
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="qNYtXSjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=+DZELDcPd2b5ebT6JL50/aoS1SRnIKasn9i5WpXWoUw=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references:feedback-id;
 b=ilRI7Xly8HE7Xw8mklrv9f8rOAxovKS4V4PLOMkxQTOx0oFH2++NYge8j1uK+9iX3p4VhBmsv
 AYcpdQ1YwJVzwAInqlsewBFQ8xAkfcha4Vg0bxZWm1ibF4w6SjFZfdeSSSQ6tEgg791XsVxR9LV
 k2NPw6/wRFuTvLYEhjsZJz8=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
 (Authenticated sender: mb86144)
 by relay2-t.mailbaby.net (MailBabyMTA) with ESMTPSA id 19f611c51df000362e.002
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 14 Jul 2026 14:51:13 +0000
X-Zone-Loop: be93bc963347866387ce6f738d79ead7623cb2997120
X-MB-ID: mb86144
X-SPF: pass
Feedback-ID: mb86144:19f611:587f4d46584359477840504741595e:mbaby
X-MAILBABY-ORIGIN: PASS
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id E91F9267F2;
	Tue, 14 Jul 2026 14:51:04 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id E72343E912;
	Tue, 14 Jul 2026 14:50:56 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id B17FE40440;
	Tue, 14 Jul 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1784040656; bh=KiM2aN8uT6kr/hsc32GUqI5Xdj4wQV0rioA3HBeCsb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qNYtXSjXsRicAfg4xr1C/osukt+6+XIGYJcsc0wjCncXhgTjaBQDn6MzJr2zp9CU8
	 eFlux9PgWW6zAU8omKsignrpI6DlQW4ehu2i9vmcU8SAHwGzkOyTkbjn80wkv9gIjG
	 nNeaLAmtrJoggkKgRkz8BAwjQPS6mroF86+XbUTM=
Received: from [198.18.0.1] (unknown [64.118.149.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 63B0F42007;
	Tue, 14 Jul 2026 14:50:49 +0000 (UTC)
Message-ID: <2ea8aeff-6be9-4915-8257-c18d3f9d05da@aosc.io>
Date: Tue, 14 Jul 2026 22:50:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] loongarch: retrieve CPU package ID from PPTT
 when available
To: Rong Bao <rong.bao@csmantle.top>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Chengwen Feng <fengchengwen@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, Xi Ruoyao <xry111@xry111.site>,
 Guo Ren <guoren@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thomas Gleixner <tglx@kernel.org>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260705093624.1079988-1-rong.bao@csmantle.top>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20260705093624.1079988-1-rong.bao@csmantle.top>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.30 / 10.00];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Queue-Id: B17FE40440
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action

Hi Rong,

在 2026/7/5 17:36, Rong Bao 写道:
> Currently, the LoongArch CPU topology initialization code calculates
> each core's package ID by dividing its physical ID by
> loongson_sysconf.cores_per_package. This relies on the assumption that
> cores_per_package counts in the same domain as physical IDs.
> 
> On Loongson 3B6000 (XB612B0V_1.2), cores_per_package matches the visible
> core count -- 24 in this case. However, the physical IDs range from 0 to
> 31 in a noncontinuous fashion:
> 
>          $ cat /proc/cpuinfo | grep -i -F 'global_id'
>          global_id               : 0
>          global_id               : 1
>          global_id               : 4
>          global_id               : 5
>          global_id               : 6
>          global_id               : 7
>          global_id               : 8
>          global_id               : 9
>          global_id               : 10
>          global_id               : 11
>          global_id               : 14
>          global_id               : 15
>          global_id               : 16
>          global_id               : 17
>          global_id               : 20
>          global_id               : 21
>          global_id               : 22
>          global_id               : 23
>          global_id               : 26
>          global_id               : 27
>          global_id               : 28
>          global_id               : 29
>          global_id               : 30
>          global_id               : 31
> 
> Retrieve the exact package ID from ACPI PPTT when available, in the same
> style as retrieving the core ID and thread ID in parse_acpi_topology().
> Use this information in loongson_init_secondary() when PPTT readout is
> successful. The original division logic is kept as a fallback.
> 
> Meanwhile, since some code paths like loongson3_cpufreq expect a
> continuous integer sequence of package IDs in [0, MAX_PACKAGES) when
> retrieving from cpu_data[], we also canonicalize the package ID to be
> filled in parse_acpi_topology() to meet such an expectation.
> 
> Cc: stable@vger.kernel.org
> Co-developed-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Rong Bao <rong.bao@csmantle.top>
Tested good on my Loongson XB612B0_V1.0 with an 8-core 3B6000:

Architecture:                loongarch64
   CPU op-mode(s):            32-bit, 64-bit
   Address sizes:             48 bits physical, 48 bits virtual
   Byte Order:                Little Endian
CPU(s):                      16
   On-line CPU(s) list:       0-15
Model name:                  Loongson-3B6000
   CPU family:                Loongson-64bit
   Model:                     0x10
   Thread(s) per core:        2
   Core(s) per socket:        8
   Socket(s):                 1
   BogoMIPS:                  4600.00
   Flags:                     cpucfg lam lam_bh scq ual fpu lsx lasx 
crc32 complex crypto lspw lvz lbt_x86 lbt_arm lbt_mips
Caches (sum of all):
   L1d:                       512 KiB (8 instances)
   L1i:                       512 KiB (8 instances)
   L2:                        2 MiB (8 instances)
   L3:                        32 MiB (1 instance)
NUMA:
   NUMA node(s):              1
   NUMA node0 CPU(s):         0-15
Vulnerabilities:
   Gather data sampling:      Not affected
   Ghostwrite:                Not affected
   Indirect target selection: Not affected
   Itlb multihit:             Not affected
   L1tf:                      Not affected
   Mds:                       Not affected
   Meltdown:                  Not affected
   Mmio stale data:           Not affected
   Old microcode:             Not affected
   Reg file data sampling:    Not affected
   Retbleed:                  Not affected
   Spec rstack overflow:      Not affected
   Spec store bypass:         Not affected
   Spectre v1:                Mitigation; __user pointer sanitization
   Spectre v2:                Not affected
   Srbds:                     Not affected
   Tsa:                       Not affected
   Tsx async abort:           Not affected
   Vmscape:                   Not affected

With that:

Tested-by: Mingcong Bai <jeffbai@aosc.io>

Best Regards,
Mingcong Bai
