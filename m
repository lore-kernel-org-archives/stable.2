Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAC3F9F38;
	Tue, 14 Jul 2026 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022410; cv=none; b=FwcJfVj8/tH+5+FTne4aWX4PoWbhdGTPDmo2q5xT5Fd+Jt+S9O3Ax3tSbhs2s021BOSNRuq0riLRA2M7v5xT64GC6fxWe8cTqeONhUCYVB9vxmcAS+6p7xGAwLXKeUZs9qIrbxDnnBFpCGZqsUr95mvJtIzF8Kq2gQMNPaV+0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022410; c=relaxed/simple;
	bh=a7VMRw+J+v8nzO2qena+1Qa+1xYq9bL9avRWJ8DcXDM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UcFYttBdL8WLWgf4XJijdxgy7lbdY41Q8MQW1bTFNve4ugaSmhMnfUgnHct+EMGt71yYkOHxIdjhf9P837QRydManUEasKQXq3zQyfUPD7qrW9477l87xjUKgCuhlxJ4uuB7e0+PZVnu9+e5EW4kViDunDuxpiq58gmi0ulxwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx5oJE4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx5oJE4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4AE1F000E9;
	Tue, 14 Jul 2026 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022406;
	bh=E1UQ1who+MzGJnhRAGQnZjnEvcZY391rlmuNIJbBr8I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Wx5oJE4RDEO4dpFV0phT403AjtH8RYoSYzbGWynEUfagmkrDOBkIbSFsS+x53Ry+Z
	 5EyDiYSdAlSv9M9WXQCsigWqSLQqxT60I3cGYCq+cTtojdHF9mL5k6OUmcHi9JboFn
	 GEb5fgFiZIjw/cz5FWDvHJte2fMyl2uab32nxlFj2pXeb84lc9s0I0zXS6z3d6SXXl
	 VP1FX7yrz+0z7UUMLnhbYRTPjdYSiE/+1upFXAxeEEBWrK+9mI+jbnZLn34Nu0FyLx
	 lh9kNwEY/9P0B8kcjQOWOs0RkuOPBOwgdAthkIV9aVwNzhJUf3oauqhZB02agLe1es
	 olERYlqWI2iYw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v2 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
From: Lorenzo Stoakes <ljs@kernel.org>
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
In-Reply-To: <alUUfGnM_vbhOTVK@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
 <alUUfGnM_vbhOTVK@thinkstation>
Date: Tue, 14 Jul 2026 10:46:30 +0100
Message-Id: <178402239024.69739.1681992582238824793.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=ljs@kernel.org;
 h=from:subject:message-id; bh=a7VMRw+J+v8nzO2qena+1Qa+1xYq9bL9avRWJ8DcXDM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLCWMtnZOXOu+4kNGHDhr83f+jpc3x//2kdX9irTVzJ1
 lqvT5qXd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi7TMZ/heEXvVdbXTATHn5
 Vw8+tT+vdm+4V+LvWbF054M3B9t/T21gZPjK4SQ4J9OKY9Nhx39/5+0WvP0neuI64/CWJqVTqp8
 mmzEBAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-13 17:42 +0100, Kiryl Shutsemau wrote:
> On Sun, Jul 12, 2026 at 11:42:24AM +0100, Lorenzo Stoakes wrote:
> > Currently there is a nasty race between ptdump and vmap when attempting to
> > map a huge P4D, PMD or PUD entry.
>
> <... skip 145 lines of commit message :P >
>
> The code looks good to me, but I think the commit message needs some
> love. It is long, and the pieces of the story are scattered: the race
> itself only shows up around the middle, after several paragraphs of
> ptdump background (including the arm32 and EFI notes that the text
> itself says are not relevant to the bug), and the one genuinely subtle
> part -- why the read lock is sufficient -- is not spelled out at all.
>
> Something along these lines would be much easier to follow:
>
> 1. The race, up front. Diagram, if we you feel like it;
> 2. The fix, and why the read lock is enough;
> 3. Why a trylock;
> 4. The arm64 wrinkle and the temporary ifdeffery patch 4 removes;
> 5. Secondary changes (guard class, walk_page_range_debug() assert);
> 6. History, if you feel like it.
>
> Point 2 is the one I care about most -- the same reasoning would also
> help in the comment in vmap_try_huge_pmd(), where "Therefore, acquire
> the mmap read lock" is doing a lot of unexplained work.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>


Yeah that's fair, I will reword!

Cheers, Lorenzo

