Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEF288C2D;
	Sat, 25 Jul 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000997; cv=pass; b=VxySH7POgZaIiOIUXGb2qivfw9TdfEMLenZPFN3OX0r+wJ6QIXDS78eNPGbJlvbBC/nBiopTl+vdR+gtc6B39VtpjyGZUIHmKkKPoT2kVpYP0j7KYtpXCVy5q/6Sf947GTKiwEIVzi7UgXUsReKJoDrrkbByA+q+HupGIdR3HTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000997; c=relaxed/simple;
	bh=aaT4bSz5HqqnTrLzg36MqwkeRkeee05kQBWMOuFMa9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2ZQm99Si8SiDgaa8x2OzjX8uFU0TbWbXn52Vc5L4QdSL+vattXdlB88PxZfOIbE6cu+xauvnicUH65Qlwj7F8dTKPXbPJIvnZLahzObAkU16df7c9OQfxSeRfdg4RDIdS9HJLHIygtivZYZ6DVmwVPpozI3cxRAN2WmI0uOoyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=czLI0mj3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="czLI0mj3"
ARC-Seal: i=1; a=rsa-sha256; t=1785000972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RYuLiCNK/wLM+A1AL+pi7reeRfYUqTvJfzNwaUYFST6oGvWU0r/XmZYJ/AtLCufWD6zOqco+OFwVexiNNKiyMNzMFgDeBMEwOCBMXk+KBjfM98jtxol281qb2kUzhPB/xFTwIi+h+B8NMMyUPokv4m68Gj14JnfE032O2Xpnky0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785000972; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WKq3a9nQc3N0aKZSTpXVKdyLOSqPpQF428qAw79wyQs=; 
	b=OiaSQ4bVUWFXJWQ32dSTu6iCPU20ymm1qO3bfgbiP9u6Bi8KI0imxjdqCz+Hk8fiByK2lNEpucjp1o3obfikW4XaMcqcF6Ln5hFd9kUdJR51XAQ2IXAtOafnhc9geB5wNwFkd1YCV4jIfDWQmZrL1ZwW6f2fCx0UF4cqsDMmjVE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785000972;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WKq3a9nQc3N0aKZSTpXVKdyLOSqPpQF428qAw79wyQs=;
	b=czLI0mj30hc4LWFO1Tueq8WRo+KJA6tmUGbitGWug78ATEAVdjpHjgTshFYnnnL9
	GffR3iyKrM9FoDvcOWcWJG0r2mI3vU3ty77K1tdQXpFVb0AcB7HIMqFqfQwjkjk//mX
	sv18y8/olrNMmEFss6B0Go/gNmPlPX0cdjmvv8ao=
Received: by mx.zohomail.com with SMTPS id 1785000966591653.2956125819782;
	Sat, 25 Jul 2026 10:36:06 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:35:57 +0000
From: Yao Zi <me@ziyao.cc>
To: Zixing Liu <liushuyu@aosc.io>, linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>, Jianmin Lv <lvjianmin@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
	loongarch@lists.linux.dev, stable@vger.kernel.org,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2] platform/loongarch: laptop: explicitly reset the
 bl_powered state when resuming
Message-ID: <amTz4qZ6CE7fn7QS@pie>
References: <20260723121840.1120953-2-liushuyu@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723121840.1120953-2-liushuyu@aosc.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.966.17
X-ZohoMailClient: External

On Thu, Jul 23, 2026 at 08:18:39PM +0800, Zixing Liu wrote:
> On EAECIS NL60R with EC firmware version 1.11, resuming from S3 has a very
> high chance (>= 90%) of causing the EC to lose the previous backlight
> power state. When this happens, the laptop resumes normally from S3, but
> the backlight remains off (when shining on the screen with a flash light,
> we can see the screen contents are updating normally).
> 
> Since there is no generic way to query the EC's backlight state on
> Loongson laptop platforms, assume the worst-case scenario and restart the
> backlight power inside the kernel each time the system resumes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53c762b47f72 ("platform/loongarch: laptop: Add backlight power control support")
> Signed-off-by: Zixing Liu <liushuyu@aosc.io>
> ---
> Changes in v2:
> - Move bl_powered reset logic to loongson_hotkey_suspend.
> - Link to v1: https://lore.kernel.org/loongarch/20260722044457.1333404-1-liushuyu@aosc.io/

Again on my TongFang L860-T2 3A5000 laptop, no regression is observed.

Tested-by: Yao Zi <me@ziyao.cc>

Best regards.
Yao Zi
