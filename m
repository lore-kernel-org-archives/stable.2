Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D542413D9C;
	Wed, 26 Aug 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759789; cv=none; b=tPiUWvsSV0FKWE1aQqWHuJt6YM61Dpf0kDu3TvuBYl+1izlu4aF3ZOMlDkTzEOJNhk4syvE9Gb5sm5SK7rbtRya+LCd1jjJdNGpAkJ027Pg9ClqguhVnfnsXKmFx3iNmwUzYkqg53RxI+TqX8iSiuS7Yeh/jOlKKbGYiNaZWdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759789; c=relaxed/simple;
	bh=CoSLCRPdIZBNyg1eBGr9k6anmDbc8TLWXW1Ev1uI608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzRqjdVtqcnySxpiVYGp2u5Nhc1DBGeMYXfBJJBeNy6jypEJRqInWPwaUIfW2yOUpaCkd8BWOpM47m16mLfzRNiLPstzipUrOD0oBQZmiGVfjGu+lNov7AlMjE6Vp5ZlcBjreWFC3oQotn0vyhmr+6LzCciBTpsw1TbfLGgHGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h5rKYzpH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h5rKYzpH"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9704640E020F;
	Wed, 26 Aug 2026 15:56:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j6pNEN2KU-xN; Wed, 26 Aug 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787759773; bh=1UjgLHFQQahhrBRAJb+d3ftPZMUUftCr0+sQrG0uMKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5rKYzpH3CnW61fzwDUq6ntQ/L5SGW6Q6OZEfRbcfOzD1YgOMUjz4SZeqVjLndZsb
	 1397OScGxspHc4J3Tjn67rVU9wToQ8WUiorzLausymRbfKv7N2OG7O2CGYu++NPAiC
	 0nm+lXnFdWMa2mdP7iVpolxHcbwflpwSyuKq/1FwxMELg5SqAlMV5JMNE4ckkm5fiJ
	 bv6z4ap17kjeyDSgS/XcRoRG1QkRQyDh/1QB8BvZiD5GeHWpWNimsGH8jZVBkglku3
	 lPU7t5ZRTaFXpCf6xFcQXHW4a5e6OCXC2r5qCrwLreO3P8H909VgULRbG1XGvrLBh1
	 arscFsXSJ+x075S6R7hcdi253cnlZu+ftGp54bUrO97wq0AUpM8ljvxil2da6igq3L
	 ULNgNUNUchj1hpPpnhC1kJepnFzwX04d8AXiWlXFaOKhzjNZRZ9hhRbyIgn0iZQJ5x
	 LHcpfEwDEjNf+EkPbAeEVz6UQyX6worxyF1hzjY6Mrh8zOIEbJGejUQNXHNHe72GSu
	 t0M9OlcaQEoInGQgBkstqvZ/iy4JRrco+cfOZxRoW+RHNuzJN9Pp2iWeW3P9l1w15h
	 8GN6Mvqs9M+0gE4C0WFFf51gvVGYQweEBEn2s9F67ZhJFBJwiWbKdvM1sH3VIKlVLI
	 qMPOxYgVBI4/pVdCs+MtahS4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 101ED40E020E;
	Wed, 26 Aug 2026 15:56:01 +0000 (UTC)
Date: Wed, 26 Aug 2026 08:55:58 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org,
	Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260826155558.GAao8MjhRP6GnlEVA-@fat_crate.local>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-2-jason.andryuk@amd.com>
 <20260826044518.GBao5vXvWQx9_a9RzF@fat_crate.local>
 <e165a4d4-bb36-48be-b422-245ce52a997c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e165a4d4-bb36-48be-b422-245ce52a997c@amd.com>

On Wed, Aug 26, 2026 at 08:15:49AM -0400, Jason Andryuk wrote:
> num_roots is 1, but num_nodes is 2.  Integer division gives 0 for
> roots_per_node.

Aha, Xen has some topology knowledge and it manages to produce 2 nodes.

I'll add that to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
