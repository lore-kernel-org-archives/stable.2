Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61603358AF;
	Tue, 14 Jul 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056267; cv=none; b=GUJ5DWgdbNogEsjq/rZf66UdmGfaW98PI+caCg04AkBpzyNGPzxFge8abJq7TF2Oh8KQc5gm9bc7ISUywcaDYa0L9J/Ajg0JOuHP+kGfQmNoQ7SPpiUy2QcoowMIKEQ4WP8g12UXZhDnTcumol0f3Dc3+1JNQXlbzeylRhJ13Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056267; c=relaxed/simple;
	bh=f4JuB3xjIDrmmKEJgfI8bPfxrdLKnwMUYrwZ16RcEKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QmUTYLtchgAjXNWt77A0by0HwU3YCrFfJ13+/p/GGR/qHCksHZDCR2KjzlBl3qP84rq+TnbImBMsXYZdYk/jAF3d0IpWmoR3uJ76/CQ1Wm4R+lC3r9yw4as1p4q1oH+gTcbnFysU/UUNWFgkl6dOw6zYYvCHSFT4eZgoFh4dkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1ubEDfd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1ubEDfd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C740A1F000E9;
	Tue, 14 Jul 2026 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784056263;
	bh=w6alW6kAgplsNU9MfVHgcE3PqiC79iFkgMzFjduJ5sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1ubEDfd2R3TAeYbwE0NtyG9rf0Dt9m11go+ZNpZ99iG+RnxImznq3aOOsz5c9eTc6
	 krHoU0nLrt5epm3hWxpU2WqYggIoI9WP/O47lr/puJ1MOxkLyocPEqwOLTWCTbskuH
	 IUe7SZrZnxZGODba8idgTvTKApYNyA9BPbBrjoeU=
Date: Tue, 14 Jul 2026 12:11:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau
 Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, David Carlier
 <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v3 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260714121102.9cb28d080556c94d45a6bc3e@linux-foundation.org>
In-Reply-To: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 18:24:22 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> ...
>
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> support, and removing the ifdeffery with the partial revert patch.

Thanks, I've updated mm-hotfixes-unstable.

> v3:
> * Rebased on latest master of Linus's tree.
> * Accumulated tags, thanks everybody!
> * Reworded commit messages as per Kiryl and Boris.

I've confirmed that v3 introduced no code alterations.
