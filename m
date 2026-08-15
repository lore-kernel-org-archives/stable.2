Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03434231842;
	Sat, 15 Aug 2026 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756389; cv=none; b=HprjXWzj5Z4envBGuD35sJoGji4LK+CRke8Hf4qycAFJ3Pb/cZaB2KFafcDtcR+4KhE0qjNVCGZk02ubhUY4i97XvSDGXbsyPmUTVR5h7ABzUyY9YKuZRQ0TqgLye2duFa8VFGooKyhWK5wbkO7jCKwmTwrRrj9YWGs5ANlcnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756389; c=relaxed/simple;
	bh=4IOgLynmYCPOKqbbnq0NGw16A8WBHw4tKb9Mm8cPCSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfoH6diC2VwgRrrLBjXDH4ije++kk7f+dmWwqa+fR7Rczrq2d0DSchIv99xLB7cV+R3WdzLTca447E02ZyYdoqx4ZlROImVxubYIyCxIsVeugWCgSvv2GV9mZknoZmt17iXg/dlD/ILPcIcwa+/KH9soanmwY2VydIHxjjZJW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kq6tdoVG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kq6tdoVG"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 847E640E0031;
	Sat, 15 Aug 2026 01:12:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yq5LbZOkGrUv; Sat, 15 Aug 2026 01:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786756368; bh=icuyadA8iREYLMPrLRybBS+1NqFF4QAz9Ft9gDy1OgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kq6tdoVGs7RUsJtdtUp9xplPFUiBMQ5wBVcggLTeNNy5hB8S6aCIzHbhCLLRiceB6
	 2Tpmz3JVaQ2TBTynY6loKhbwZqR8SoXQoMmOrIlrIKv7kRYnKXIWLv7aKGgAGOSG/I
	 GIyG9xOqX5l55Dg0mEQQEhIdvJqfh+Kr/5HkZwcXy0A42XQkt9CdtG3rLx3uVhij0p
	 0Y7FDAOJlzUdHzn0DI2Td/ace184/7rWXPzun8ZBYUZaPHnUgPS+8148IQz6Rw2u5X
	 j76qFNvTWRnrNYNg5/MK7acVpDjJEW8bedUPmR8YSnT5AEAad4EadoSbbDVzEodGww
	 YtyCB8NEnqZHYdnebuvxho1yPu6ECLw5H4YgLX2fKZ18zCdsJW3INDg3ESo8cXzNyG
	 pKlB8XgdIXpb8yHjny6DTcAWd05LT9i9OPGwwrb9aEYp5pESaVTbYqG196XfJXWJL7
	 u1vHDzD+5GwVrj+rBbREyZH0ZSsVDMHn9ENsURC683Wp+++mWmgjFZ1xppjYyfSg+z
	 yKQpYCSbOBvf354T2rwVWNFPL/B4SIXSpxXtfM0eUz9JgQbEz6rgDmPxdwfes2tWwg
	 iT+/XWcyki2d2VE6I6a3+dZlOPrJKry6DoT7mgDKr4rpWKMZXNCs7gpHyns1tM0XUz
	 TL3Ehbfr2ljXLMlpo345PXwI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DADB840E014A;
	Sat, 15 Aug 2026 01:12:34 +0000 (UTC)
Date: Fri, 14 Aug 2026 18:12:31 -0700
From: Borislav Petkov <bp@alien8.de>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
	stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address
 resolution per register
Message-ID: <20260815011231.GEan-8_6t46sayCwzU@fat_crate.local>
References: <20260814220254.3797467-3-vineet.gupta@linux.dev>
 <67663b343f4aa2719eee273f10ca74a469fa1ab5e8772933083f51b62284a59a@mail.kernel.org>
 <fc9da1e4-714a-4a2a-974b-fe495a3d8afe@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc9da1e4-714a-4a2a-974b-fe495a3d8afe@linux.dev>

On Fri, Aug 14, 2026 at 04:55:00PM -0700, Vineet Gupta wrote:
> I'll respin v4 targeting bpf-next and drop stable etc.

You've sent three revisions today. Slow down and stop spamming people!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
