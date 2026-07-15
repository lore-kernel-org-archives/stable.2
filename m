Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2D35979;
	Wed, 15 Jul 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124991; cv=none; b=KfK0v56/ipYIpSpSwVLZDSgYBKT7x2c0ucwRMmkZtUwGBEvp1GPNUb8vxudq+Uir0Mpxdaac6BtWlQnq8UKj2fw5fik26w4ipmFQcA7vAfAAWnsKMezZHxua9QFNheDGkdsXnAIK/ZLhT7DzIvW2RBMgfn6jFXnfEZWAzSOt154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124991; c=relaxed/simple;
	bh=pGwB/bTHOs2/inH07hoVPtuuEgBzmNSQea1pphRCakw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LbD2t04Lre72qTgEjg4+pYX7WmhXLPaXgbE/tezeT6zqeReDKHp7qguLf7VKHXSJafYrRbzq7BWkV5P2NtFEWWqVUwUmn8aFg+UhFTqdMPmhuM25qdD/bUKT5snBLG+n0S7S9/S53Wpqic0cARIvzfzHPdpRErEiuZbY32rQ6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRTh16mR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRTh16mR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179E91F000E9;
	Wed, 15 Jul 2026 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124989;
	bh=t+bwpuTRptvyCO3bOxQYXi/J+49Jig0wU9FV1VYgk1U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LRTh16mRsy/c1BfJrXztagTLiF6iwreCzUL+HMeDfNjLTGE+v0MTqoHM8/94eqABY
	 N+4rtgZL0EhbYK5cAWGP8gj1ZAFr8ysQnUg3LJ1PmoX2SySSt09D3L2ijTv/4nXxuR
	 4LDqQrY4WGX8Sm/idsfK4IcTNLzYVepREK/kdWMk38B1xyBvHKg+MdYQDRQF14bs45
	 jul3NIZI0mB8QJhljbpCxZSix9msf8uYy+MmNt65ImY7LaGLv/N9lIzfEszPHiiEtr
	 Acq2DWAV0AppoRiInvJeAEKS8BHpzof/0gBMpYFlWjlydAXfZwQxHBKZTGLZ8EgTm/
	 CUv8LK3VaELxw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
In-Reply-To: <aldhVdwj9oMRN1Lk@thinkstation>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
 <aldhVdwj9oMRN1Lk@thinkstation>
Date: Wed, 15 Jul 2026 15:16:08 +0100
Message-Id: <178412496800.59347.11482869717348078349.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pGwB/bTHOs2/inH07hoVPtuuEgBzmNSQea1pphRCakw=;
 b=kA0DAAoWz53NioHifxQByyZiAGpXlimhljcAvWKWFrIOS3sEzEn8GxUJs2S9+ijUshZ0yWDKX
 oh1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmpXlikACgkQz53NioHifxSp3QD/TBV5
 Z46e/1R1KuwDd9I5f4zeXSY2PL7Lfd/HyDWWJhEA/2/77m0B36Vzye1+PL6ojrs5HOdPpWBBkzu
 ZANDfPtQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-15 11:34 +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 06:24:23PM +0100, Lorenzo Stoakes wrote:
> > Currently there is a nasty race between ptdump and vmap when attempting to
> > map a huge P4D, PMD or PUD entry:
>
> Nit: that's a strange order of levels :P

Ha, seems I couldn't decide on ordering so went with something random :P

Let's try 'P4D, PUD or PMD' instead :))

>
> > Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
> > page tables.
>
> How about adding here something like:
>
>   The read lock is sufficient: ptdump is the only walker that must be
>   excluded and it holds the mmap write lock. Other holders of the read
>   lock may run concurrently, but each exclusively owns the range it
>   operates on and cannot reach the page tables freed here.

You mean maybe I put the commit message on _too_ much of a diet? :)

Yeah sure, sounds good.

>
> > +	/*
> > +	 * Kernel page table walkers either walk ranges they own exclusively or
> > +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> > +	 * case).
> > +	 *
> > +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> > +	 * freeing page tables.
> > +	 */
>
> Same for the comment, maybe:
>
>       /*
>        * Acquire the mmap read lock to exclude ptdump, which walks
>        * kernel page tables it does not own under the mmap write lock.
+	 *
>        * Concurrent read lock holders are safe: each exclusively owns
>        * the range it operates on and cannot reach this page table.
>        */

Yeah that's better agreed.

Let's replace it, but I think (being super nitty) with an extra blank line as
above.

>
> With that:
>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

Thanks!

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

Andrew - could you fix the commit message and the comment as above? Can respin
if needed.

Thanks, Lorenzo

