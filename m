Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7443D4F7;
	Tue, 14 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022599; cv=none; b=XMvFbRTHOpnv7tBU4DM832LpAE9q7sTM5KN11fYCLcDpqjnzqwU/QZKT8NbDIFeLyR6xzXPvHunS3pmJrgkL/4F9kITwYV0IPzO3GMLwexsrAdlxWQTyqcjFPic/HVafBilh9MKkkYLRaBpumRe0HPduLSIJxtrEAzGRgzB6ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022599; c=relaxed/simple;
	bh=ZepVuhzW21/hUCaWiKuOK4e1luh7TWvi44wNV50RL3I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uMAM7T6ybiFW+3kLpZyjG2/OnxF50eX12IqZwajLkoOgxCXAbUe4UXDZQ1Zx92fVlBpW974xnqbC3+t0/KtI4iC1Uehw2HrOzYwx4xkWcHCTFgOrtCcj5vM24V8lGRNd2K+IjifxRuF/ZumJzfTTjpxNHfbreYpvdXrRJvhU5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVZmAc6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVZmAc6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F87B1F000E9;
	Tue, 14 Jul 2026 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022595;
	bh=HctaYC25xmi723t9mpPbmCLQP3IBod29aBYdTrLa6xA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZVZmAc6QGPyLQjp4Kd7I0ZXRjuVkK/fsGkjzg7Dr9mX68oMKo9p3bz+tPlc9xds1y
	 UL5BGrb2JOckIQ3juGIhe7VJK+QkjeM6nnsuJYMzZXYtJXKNQ99wMk/eiz7pupxkAQ
	 jIWNA6wpCcUeZdhpNzb3kZeMeNa6FQp7AsWpRzMLvYH+0NX5EVmxxAD3VIaqycp5n/
	 fR8iCRtltXt5S3iLSXOf/lOTBdD8B0DVWq/fclNd47VRzfLxNulbsMTZnWwsk9qtQI
	 MksoMVOSqDFAVPPTUlB7Tza6Oua913SFqFJWY+RR5/0oikgUyWkmQy2X++jb9LUBXd
	 pI9mgDHReg4Zw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v2 3/4] mm/ptdump: always stabilise against
 page table freeing using init_mm
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
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <alUdUKk0zGmskSib@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-3-ad134cc3a12a@kernel.org>
 <alUdUKk0zGmskSib@thinkstation>
Date: Tue, 14 Jul 2026 10:49:39 +0100
Message-Id: <178402257936.69739.4642059153515341814.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ZepVuhzW21/hUCaWiKuOK4e1luh7TWvi44wNV50RL3I=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLC2Exfud25crSsetf8mCsrnNnW9nV/7tLPT5/09cimd
 V/3ln6W6ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEfG8w/Heo1PuZ62TUtlIh
 9PHGKMH9iscZlofvkWJ9l3JPsbM15D4jw7rfdXP/RV1/G7ynQ8DgSIePeCH/0w8C349m1Jy4KKe
 pxQsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-13 18:19 +0100, Kiryl Shutsemau wrote:
> On Sun, Jul 12, 2026 at 11:42:26AM +0100, Lorenzo Stoakes wrote:
> > x86 and arm64 invoke ptdump_walk_pgd() with non-init_mm mm whilst still
> > walking kernel page table ranges.
>
> The code looks good to me.

Thanks!

>
> Same comment as on patch 1 about the commit message structure, only
> more so: the race itself is never actually stated -- that these walks
> hold only the walked mm's lock, while the freeing exclusion built by
> patches 1 and 2 hangs off the init_mm lock. The fact that makes it
> possible (x86 shares kernel pgd entries with every mm) is hidden in a
> parenthesis. And the last three paragraphs read like v2 changelog
> rather than commit message material.

OK, will reword.

>
> > We take this after mmap write locking the non-init_mm mm. Nothing acquires
> > the init_mm lock first before locking an arbitrary mm, so no deadlock is
> > possible.
>
> Do we want to document this locking order somewhere?

I guess Documentation/mm/process_addrs.rst is the best place, I'll send that as
a follow-up separately. todo++; :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

Thanks, Lorenzo

