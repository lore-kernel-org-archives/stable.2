Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F53D891C;
	Wed, 15 Jul 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105403; cv=none; b=eNsoJO4MYxZzPmHrDetgcFvpPoEwyt4vA1Bz5ohGAKyRLYtoGnJmz8Hc9ai9gxuEsQfvbONO8lGUsscQeoXmVJBN7ry9V7ROkkxbhp4VtFqw80WrqCOO3Xopi50YObi+RqWK74v39+S2AiQUarFs9Yn7fBBcRkrfoTNEj4aV+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105403; c=relaxed/simple;
	bh=uitRDkWW53iDM4jOjF4jr38Fhuk8vDR/4csWNguwm80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJZArQ1NPlP0UclcP7WxFLcoaF/JXZoHM4s8lHlh+yM+P4PPyoEMrVLA/sYJ1eYw0Qnu9TeZ6iQwxRSRSjiI5kv0wzfF7Dfj+qjkibZe2lJTyoNSzkmjzaFbMMIkhon48YPyad7PRqlwU0u1MFPXGN+tmPkvbg279J8tAZ8kt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTTQs1kH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTTQs1kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A91F00A3A;
	Wed, 15 Jul 2026 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105395;
	bh=uitRDkWW53iDM4jOjF4jr38Fhuk8vDR/4csWNguwm80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTTQs1kHDnv24z6sGGe74snLCNDI9BRDFvqV3VvH2UoGiOAL18jl/9sh+xVdzeprE
	 1I+twMPVuuhWSHXX51WIqCtMvpOFG1qOBBPzoip6tGHXtDVeOpqTXBjTGbr2FFpnIL
	 VLc01Le+nkjUAgDNbODM6IGcg8S06zlb+7RQSxcYeiMc5NJMnP2mtFihcOshJLo2jd
	 RjH58YOIl7PvuElpdTUJ/Wo3VQWNhjtRfveKy0ovWEC/F3TlkTf3uxBggMtgPfUTEV
	 GphG0Hd5vZ2U8OEqG43VvUi77GxBwfakSQ5av4f0VkfQ7c6fn17j6XVxYnOK9x5h9g
	 u6AK2ovZnt79g==
Date: Wed, 15 Jul 2026 09:49:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v3 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Message-ID: <aldJG6vysez8HVJ4@lucifer>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-2-b812eccfa0f9@kernel.org>
 <13fcd4d7-0efc-4aa5-9425-8f4fa05c8eee@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fcd4d7-0efc-4aa5-9425-8f4fa05c8eee@intel.com>

On Tue, Jul 14, 2026 at 10:29:51AM -0700, Dave Hansen wrote:
> On 7/14/26 10:24, Lorenzo Stoakes wrote:
> ...
> > Resolve the issue by acquiring the mmap read lock on init_mm which prevents
> > a concurrent ptdump as it acquires the write lock.
>
> The move over to locking on init_mm instead of current->mm fixes the
> earlier issues I saw with this. Thanks for doing that!

No worries! It's kinda laying foundations and then addressing things with other
patches in the series, which is why Mike's suggestion of combining all the
patches in one series was clearly the right way to go :)

>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>

Thanks!

Cheers, Lorenzo
