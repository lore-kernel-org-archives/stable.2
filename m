Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C753C943B;
	Wed, 24 Jun 2026 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316781; cv=none; b=YKKD1ZcKTC+iy2VF0+WoUjnKe1o7iPJC4xXlUQ2yVqaLvpVMZJxYGuQBsMvLje6rFMGx5KP2hEolluH1eEFlunSCmP2HkAHolMdxg6jBo+4T4DaFcIEcCr7k64ae9KS7r64UMAcggIL5knpjq35Ju/4zZF9770oAaKlUEfioAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316781; c=relaxed/simple;
	bh=OP4zJ868jv8SA76gK2Ui/O/ohUsqjY7uDOPaA/mPK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOvKhmicRurjyF++8m6fOvZA7NH6qgPRY+aY/U11z/MhI5U2rNFT070J3ES8LD/nJOMatmOQez3vQ60KB669SVjpNJZKib+1+UW8BZSpHyXB3qzV/VApFRorWqgceju5Hph/Dtmnru39NOH18VQFk0AmTJiD6kHcVJIpPs2r5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O0DA7QAi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O0DA7QAi"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 957D040E01B4;
	Wed, 24 Jun 2026 15:59:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FFGtgjwgrxmW; Wed, 24 Jun 2026 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782316766; bh=T5NJIgaQoJlWVb5HGBjiAcmbTZQidJ2oaGBWWkbDt6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0DA7QAi0yde1RiagtAnoIPUpaT5dJRe9Z1XV97ENkb87Y0oqRENa2KdPMGjbm/Jt
	 vQpnfRFpRVrQzFJ99flTlDBcAFszmA2/c/hx79aCvPmId/fF6sexSPJvRTA/gbbHzw
	 JRRCR1xba4QbpYnDVdu5yWjl9wD8oIO2wvoXfOGic2C24bjEwO6/F/Im9pk0rz23i5
	 u3q+TPzNiaIYs/wE7gQkr+vKpU+HUQQ/iQiN4EQPjqHa5IZKaD+JJLAfX1Sfi2sETH
	 49258pOUv6ofbQ9uMEx64ROpw/snyF1BZhOo+OFipOgAsWmL0I4nTpjvLs7lu7YjT/
	 bCjpToul5HDHzwjhyHLSi3ypyZiqTlxJC3ntC9PsTlyArEUWJqezs/V13ED4c9nbDs
	 t3F1eMYSc8WpUcn2nTqAEgZVc165nWTzqW1Jd4a47icnS4kY7yD2AHd1GG4RN0mnav
	 ztyUfQStH65PnX5+QR9rE5srsDFJUEVkOH4fZ5lcJ1Iw3iTxQPWT1uicI1IfYpqrE0
	 OFFQiWfYmYqJiUTiYFPkeNDJ4lQlCtLhw9pI3R1R/hhiAxVQ5LjLfkZ43u/BRZlzsg
	 lrtFlSTyj8fjSVQRM/59zRAliqvVPrC7vKWfxzYDa2+uRpGjsADSa5x0CNLPHM4Zi9
	 0MsBKp46ECQpT+DdN2qrljSY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2B3640E0140;
	Wed, 24 Jun 2026 15:59:13 +0000 (UTC)
Date: Wed, 24 Jun 2026 08:59:10 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
 <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>

+ Andy

On Wed, Jun 24, 2026 at 11:41:16AM -0400, Jason Andryuk wrote:
> I have wip s0ix support with Xen where dom0 issues the amd-pmc calls to
> enter s0ix.  I'm not sure of all the uses of SMN, but with Xen dom0/hardware
> domain running most drivers, I think it should be available.

Well, how should we make it available if dom0 doesn't really allow us to
enumerate PCI roots and thus count AMD nodes?

Andy, see upthread.

What would you suggest we do here on dom0? We're trying to enumerate AMD
nodes but dom0 is doing something special wrt topology and PCI roots - see
get_next_root() in amd_node.c.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
