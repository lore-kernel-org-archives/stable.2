Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B253815F0;
	Tue, 13 Oct 2026 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861935; cv=none; b=lCCGuM7ZVjJtw/lqRBfHvwP2KDSAcTsYCUEgD4+9XxwKjQDGcf149fyOclPqsgNvWLePLWZCjjpTFuKlHOAKGuc0CXzz1NR5LcvF5o6+04TuIFfWGzc4TU2s9KUFfGyFXd2Tq0OjLSvjGIEC8qKsyg4pA9rN6Bgb1rU7Hme+xBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861935; c=relaxed/simple;
	bh=hOSsdBCFKim2eSjme5XkOUXmJN5W8YlRsgA6oHvXmZM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HLK+OZRKp7KKzEm937GeNJGpri9P8khFt1YQ855Pgn0vtOlNtOOUgIlEd2yXO/oJInLzUFI1/LjpeOa3UbsyjcFcw+30f+sttSHksWJvR1E57AmWLNnkRQYB6qkw6IptbxnPk4uplOxkab/pQykL0JGI2h81ZuUA1hF6zoGN3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NyRm1VrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NyRm1VrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167851F00893;
	Tue, 13 Oct 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791861933;
	bh=pJssChfaw/WlnaVysEqwe4Z1tfuZOFEKdXZG/EwVI3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NyRm1VrFt9ZFJC62cb/GZbpmwcM4V21aTV9sKGdVMrIs2z9WqCR99Zm3HyOqUlF7S
	 ENwjeRfGAaG1XErBHECIiyNgzJtP5yvlDy8GfISuPQkn8Wu67qs4UUCq0v+VtVgB5o
	 H0cAA5rwHjdJTzV8Yor6vR8GbpG7w74vqDpKdWrs=
Date: Mon, 12 Oct 2026 20:25:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Muchun Song
 <songmuchun@bytedance.com>, David Hildenbrand <david@kernel.org>, Oscar
 Salvador <osalvador@suse.de>, Dave Hansen <dave.hansen@intel.com>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
Message-Id: <20261012202532.f059fd5ab947510a21d34cd1@linux-foundation.org>
In-Reply-To: <200A83B9-233C-44C7-B4AF-0900BA1E09DF@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
	<20261010112457.49485-2-songmuchun@bytedance.com>
	<asy-b7_C3SjnmSaS@gmail.com>
	<145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
	<20261012193114.77147e0a43affa8ee1ae896c@linux-foundation.org>
	<200A83B9-233C-44C7-B4AF-0900BA1E09DF@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 10:50:21 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> >> The correct trailer is:
> >> 
> >> Cc: <stable@vger.kernel.org> # 6.16-6.18: bf9e4e30f353: x86/mm: use pagetable_free()
> >> 
> >> Andrew, would you be able to update the trailer in the patch when you
> >> pick it up? If there are further review comments that require code
> >> changes, I'll fix this trailer as part of the v3 respin. Thanks a lot!
> > 
> > I don't know if/how the -stable maintainers handle a comment like that.
> > I expect it's more reliable to do this via Fixes:.  Possible?
> > 
> 
> Thanks. I used this format because it is explicitly documented by the
> stable kernel rules.
> 
> The shell-style comment is the format documented in
> Documentation/process/stable-kernel-rules.rst for specifying additional
> patch prerequisites:
> 
>   Cc: <stable@vger.kernel.org> # 3.3.x: <commit>: <subject>
>   Cc: <stable@vger.kernel.org> # 3.3.x
> 
> See:
> 
>   https://docs.kernel.org/process/stable-kernel-rules.html#option-1

Oh.  Consider me educated.  Edited.

> A Fixes tag alone cannot express this dependency. It does not specify
> an additional commit that must be cherry-picked first. The documented
> Cc comment provides both the prerequisite and the required cherry-pick
> order.
> 
> Would this be sufficient for the stable team to pick up the prerequisite?

Hopefully.  I suggest you double-check when you get the emails as these
are applied to the various stable trees.
