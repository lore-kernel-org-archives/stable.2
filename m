Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF8364EAF;
	Sun, 12 Jul 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875271; cv=none; b=ct5CQFU145RMR3Ffw0nlGpkeKZqXqhx/I/nPewEvRVNB16n1J00YvH4q0MbXzG5Zh7MMhYAx+pMSZzojwSUvwO0t9MxTfkeXXCC28JgCivE27uiBwJwET5xf1BxPjHblBDkv6f5z3w5ySF1afh/jYI8C0eb2srmFjXM10xRvq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875271; c=relaxed/simple;
	bh=3t/8oLbvVkCPegE8QAQn71oA+Q4HfSxM+oHBOvO26rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtd2LG/LTLXyRnjevNQqSCwHgd2XcfMRNvK0p3gwdXxozxW/rR7huxNrgW+ufduJw9kLfDYJ4K92FF+fAvg8wqDByfXALmH9/yxTgO0Txw7ShcwVnUS/ttV7LrD8PsdPVuhabm1UyVsTTQkhhWW7mC2he5uOxLVj0WipM1PuY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hZd3B02y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hZd3B02y"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C99240E029F;
	Sun, 12 Jul 2026 16:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id srior6ed563w; Sun, 12 Jul 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783875255; bh=y0mSGKSljGbp3wm1OkPuo0d6XMXK1FIsRCwQHXpgKVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZd3B02yURgxnaN2bOuG5eS5BGaZkYAs2AweWjgF8MPvxxPq1Pt2vhEEqnCqz6wWA
	 8dNkaOdtd19u+IcSBM/HjAx7JcHZLN7A5upeotFOjvVZJuJPXZ2xLlJORfsSwePPkj
	 s2QScnUZnorDzAAJHT7r+lAsUwSUICK0TK1gzPA+4BNove0iPem796CCGh6+vQ2uTF
	 IaaWP96Soy2OIRtZQ4wj3sYYMzUU7eb9vJwS5dkoeTmPjJv/vViw09zNDbqo+F8B9q
	 AyltvY6d3w6OaBCUM9eOqQsnsnrBBcZmFjmra1vn3CEnFOv/wKIU6VNf/oyr4hwPGu
	 7M7+2UxNFU+pg0Lto33EIt9lKX7i+Z29412SELwxHS1ldaxuC8r38fIiiBJ/60gssa
	 pi0hvyvsYutR7Ji2QjYroHz3Tz4NoMG/Ar3Egs6W/tT79qOi1QngXwmUMBYQyqPoUH
	 Ruz1xqCCFqxR3bLPqeiF9m4mB9wan85MmnjIRAYyecU6ELmJSYolJcfG5wxdEz+Bdf
	 GsCumXAiqGmZg2okklasr3ESHBzuoOl7c9q1iHAJ7QaMfNvEci61R9mQ2/96kYvjQ6
	 X2EbOcc7yHrtpWfN6qHdZShRWsJAMFRBQB9QrCT/E+9KlUi/jyYAcpQpaMbn/8DBjw
	 Da+sRgL8/If7qfYW8RZJTeHc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22D5740E00C3;
	Sun, 12 Jul 2026 16:53:45 +0000 (UTC)
Date: Sun, 12 Jul 2026 09:53:41 -0700
From: Borislav Petkov <bp@alien8.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Message-ID: <20260712165341.GAalPGldsKpBs5treJ@fat_crate.local>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>

On Sun, Jul 12, 2026 at 11:42:25AM +0100, Lorenzo Stoakes wrote:
> This patch resolves the issue by acquiring the mmap read lock on init_mm to

s/This patch resolves/Resolve/

> provide mutual exclusion against ptdump, which acquires the init_mm write
> lock.

...

> We also include cleanup.h in order to use a scoped_guard() to implement
> this cleanly.

You don't need to explain that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
