Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985F4B0499;
	Fri,  7 Aug 2026 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077057; cv=none; b=rt4FQYnI8wrfKusIHpPggvd8NIFg47tjwzKrj+0B/NQsJr/yRwKQtNaCsXFI/Lq+0eY/mW0ngPFG5pQqEQ0ElUUfMs04AWiNtmAj0taIvEILoxNmc0lf4dsFF27XW3nlPwyJbcgWTU4MVTGqpQ+78plIWwIlISbdq1xp61OoAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077057; c=relaxed/simple;
	bh=9FSbAsM322O/ViSZTusv+kTtNYPGMN4k5ojoKo3T6YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOpoSWwgaqm1torD3Do0UF927tcH324tc+aObp4NNYgCgt0b5Q7IIOuQHDZEzSg1JamTdhXL5hGiOPloZJGo+O72Si5h6PjeMVfR7JU/l5Yyseh2MOP/HJHhnskek/kFFR1JNH1wmS2B1cABy6qjqDR/MNiCMvA/ogH9H7D47Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U6V+lDxV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U6V+lDxV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D4AF440E016E;
	Fri,  7 Aug 2026 04:30:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TSGH0n6bqdN5; Fri,  7 Aug 2026 04:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786077041; bh=drjOgN4pqw+092DvcFRWvHPLSWtuwbmehxootEv2qAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6V+lDxV3SkmFgrEYOdP5DykoItlSYApYomZdqGe2NKjVgpe7IiDRwBqfHBkYattF
	 uUZW+VGHZ6537NjqvUjyk6AM2BYDMhSgwnrNhq82g9rAAqwbRu4iXLdf9aMJGTrZvk
	 BruQFl4CzzFSY1b+qoO5zn0jCsadhU3hfOxWjETDVB4bh2qhLpiQi5fyrXrFNc0QO6
	 SUIrYcd1T+5Uw7hKeoXevz9pUl8EeGRH/h43qAE5MT3MPrjOeaVQKGJoEoS5jU4FQz
	 rJ7adVqdTTDNrs5rtNqqZuw+N1ImxuxlGiXLRlBBneP/bo2G/1Phs4FRjayGzXtOzV
	 t0t1QFbgd/e1Smshz5audJj0RE/GpGv3aLJQ0WqhsXWnNeIpj4hnFUVe0eBEhiOpU3
	 3tREAKwQb5X+jntMYU94RmzWAOe5fe7aQxEUN8QtbfV3F08m7Hh4iCQufpbnaJVWu2
	 VML6a5qRNWfUaq9gXybKbI3eJ50vEb3VBshgHz6VjUhsQYSymehsSSZyt+3R1Mxrlv
	 5HEqIj7dnhsZwXVlsbwwea1/sf/mYn40rPR/jtDVD1HMKZYnCwUFuBtv/HF2TZ+BaD
	 qjfgiGQJEGwunWru7vMpCXS4UqlhsFI+kQigCOcUbaici3PkDEBNzvPvdNKSjH9fUG
	 7jIaRwiFDTk4cdRsvlWUU8a8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59C4D40E00C3;
	Fri,  7 Aug 2026 04:30:36 +0000 (UTC)
Date: Thu, 6 Aug 2026 21:30:32 -0700
From: Borislav Petkov <bp@alien8.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: CVE-2026-68480 mitigations for older stable series (was: Re:
 Linux 6.6.149)
Message-ID: <20260807043032.GGanVfaF37dKFTb7PG@fat_crate.local>
References: <2026080618-mulch-nullify-723f@gregkh>
 <anVdmsj0Ko294nBP@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anVdmsj0Ko294nBP@eldamar.lan>

Hi,

On Fri, Aug 07, 2026 at 06:22:50AM +0200, Salvatore Bonaccorso wrote:
> In fact at least they depend on CONFIG_MITIGATION_SRSO, which only was
> renamed in a033eec9a06c ("x86/bugs: Rename CONFIG_CPU_SRSO
> => CONFIG_MITIGATION_SRSO") v6.9-rc1, correct?

Yeah, I'm very sorry about that.

> Borislav, can you have a look for the older backports?

Already sent fixed versions to Greg, waiting for him to wake up.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
