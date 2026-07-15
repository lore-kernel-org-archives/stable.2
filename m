Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589043603D5;
	Wed, 15 Jul 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104311; cv=none; b=TnKzvcxlgqHWzBYcAJRXxZiI61wZOzwwg6xEf6K2nUj+W7Ng/bYjIOeFiwgPA95RecX3MjlQD1h+0CYBzv6LQ/r43WfSYqhNQzqTo2epG4B76FOCphMBHBxYX+tCqA1ukByePT2u3v2vpz2zlqjqbXYgBVNJRwdqRHXozHfWbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104311; c=relaxed/simple;
	bh=QcqaG9bdGXl50jPu/JZyaS7ewr6T+770xaHIMx0NS0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybyt2qKbWOvStAzLf4p+1MGWNask0LITt0qUniTtu79nbGBJUK3VIFc68u3aex5W77ruPLB6U9VN68BxARo3TwOUhtEiTOD4y74TT7KE7+iEMSgy9r8/1xOl8Ocdy0ty0L7/7zsxh2wYOMvcIO9LkD103idiNjVMXWORPjrF2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUzAtmOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUzAtmOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DA41F000E9;
	Wed, 15 Jul 2026 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784104309;
	bh=QcqaG9bdGXl50jPu/JZyaS7ewr6T+770xaHIMx0NS0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XUzAtmOxttpIajpYuy9PHtsD/bbW3lMFTsULGrMLvudH7saF0OU+fpWl05tOPF6R5
	 tP3keWSIwMqQ8Qx6ee5BaOdgQLqR+bNqka/rqBZpHdQOLs2mDTSYbheNF78Igp0/HA
	 Pf4kpQpBBTUT2RpHgFJtIwPFPjufQ170EIEbnVoLc4n8lvuzFvTQ3lsnkjcazdojkk
	 J2AkTaVg7ZHOEBORZxSngiVqpWHUvWAOIRyRnMe3zvEJYh3TXK4bc+/Am4c5Zd1x1w
	 uw/4/J0AllxcbikrYAIxECY8JQBp/wRGpkqQX0wQKp1p9DXCEiLP32lM18eK4CXR5n
	 MuUZZ7YqLzzMg==
Date: Wed, 15 Jul 2026 09:31:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v3 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <aldFYDI6LFOv3GsM@lucifer>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714121102.9cb28d080556c94d45a6bc3e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714121102.9cb28d080556c94d45a6bc3e@linux-foundation.org>

On Tue, Jul 14, 2026 at 12:11:02PM -0700, Andrew Morton wrote:
> On Tue, 14 Jul 2026 18:24:22 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> > Kernel page table walkers fall into two broad categories - those ranges
> > where no exclusion is required via walk_kernel_page_table_range_lockless()
> > and those where exclusion is required via walk_kernel_page_table_range()
> > or walk_page_range_debug().
> >
> > ...
> >
> > This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> > lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> > Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> > support, and removing the ifdeffery with the partial revert patch.
>
> Thanks, I've updated mm-hotfixes-unstable.
>
> > v3:
> > * Rebased on latest master of Linus's tree.
> > * Accumulated tags, thanks everybody!
> > * Reworded commit messages as per Kiryl and Boris.
>
> I've confirmed that v3 introduced no code alterations.

Thanks!
