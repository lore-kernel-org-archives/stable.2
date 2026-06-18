Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9652DC32C;
	Thu, 18 Jun 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800765; cv=none; b=WBYiDGNw9+ZloFCBfjPwT4yMtrFUmmdadS6fC57O6HxRTnboBBdnZyJ6jiq3pAb7q4Y7jujrxXQoWFkW+MkX7ET+qMPyUNNuK/Tu/ajlWHopekWna8zOS3+qMvT5++L20hogM9GzD2KuP9zFWwIevOnmco4ffXW0ynUmlDNjoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800765; c=relaxed/simple;
	bh=2/3W2i4dRmUZlZut0wVZKcVHce0jJGFU1FjSUnL1E3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLlgpBeXUwmmU8db5QbDVUYCwOFXhIbug+C0RvILjh52ojXh67FHCE29GGH2QjfSX1ytkyaNyPUnI+MykmJFaf/RFoZO+4XKGtrlnZjeJqq0iadPQbSeSprDu+fSdobODmBOLptQagJ9+RD1Mv++m4ku68lTgodTFkB3DT2QiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G3w6klXa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G3w6klXa"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD32740E029D;
	Thu, 18 Jun 2026 16:39:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ng0m4VOmjTvY; Thu, 18 Jun 2026 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781800750; bh=KKxRtvT5aXOb71e5ovExohqC6iQT36FboU1UYXHGekw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3w6klXat1W8NHJB1aw5nkhE2KJnt1hdlVOeMsnBZEhEi1uqFG4wVq/4WIyhKwmZN
	 SnrB3Koq86DVMffx9GWFb8CWNM9TQMamih2yEYzkFrpW1HX0PC5RY+VT2N1HBs+k9R
	 rmT9gqyan+jz7pUs9nACG/GzYaRxj4n/i8kgpsSiuwhSUZCm2EpKeFqywcJp5AP59u
	 cGpiBUMSaiskbDjPtQgIO9FQgcDctTV8k4PhLw/Rvqp6BqVCss0bSjc3lHJzWYWQpa
	 2RybuR29SWBL28ISZyCGaiom8Yjds+x+uqvnxjtUExMeXsFFUpRJQnxMJkCGXLhgCF
	 7eyBToi5Qe05RD/tBQViD2ynEEwAW4oi692431iUkkYKWyyzhsbx1GOHn/ILQy2jDS
	 GKj837sg+kln19MjLbUk9EKau7BmlfJuYdfUGf0dlfVzqcdLml2f+yjcE7vyhjfKSz
	 au6drYt//aJzftEAwUNABiaXwUYiTvVduR5Y+k4DfLN6VAqUmFMjIIRvKC0+xUNuOq
	 QscsjCbNP5AJmzuwMlGEkfRAqEfspOeH132xNYxLJ7pGF2FxqktWcesLqyWd6c8YOH
	 KHQm2HAZ9tV1YyU8p3qqdkOjlBgzC+CFtqSOkwLqPCkbrmLWPw2c4UaW6nhO/lHnHs
	 vVozXy3WtEtRh2KGn3shnhFk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C9FD40E01D8;
	Thu, 18 Jun 2026 16:39:00 +0000 (UTC)
Date: Thu, 18 Jun 2026 09:38:56 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
 <ajQI0mJwobsGHj6F@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajQI0mJwobsGHj6F@linux.dev>

On Thu, Jun 18, 2026 at 05:03:46PM +0200, Thorsten Blum wrote:
> get_cmdline_acpi_rsdp() can truncate it into a different, parseable
> address and use that instead.

How?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
