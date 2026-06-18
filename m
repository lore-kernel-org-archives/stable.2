Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495802E7373;
	Thu, 18 Jun 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774521; cv=none; b=L3+97PaRXQJnVzmkhcdxx3TuXgcaX1Tnc+eNk2wlUeDi3LJgEfSuxWvb2SCDMd+9slj126UJOD/QsTNuTGP/sMDxD82W0Y3t1fzaQYNah90u4rBARoQFf5sxbDX+/IZ0dr77Jl3BYsIegas4Ay5wPOuzUzjPVUjuxZ9iqX5P18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774521; c=relaxed/simple;
	bh=xcqHPRenMM1Rngevx7vypZhaGXM/UbEh+8KgdAWooq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmoN1ZdvbWSsemFXDDec/L3sSwAH3x3DBJArMQ0xG2QCn19rS11wNB3b7DFueoCjst0pVgPayZhmnZ5o8jc0Bb05VvaUjWVznUKCrz+77XkLpi3ods1PeRj18Odf8jv8/0UdR7bt1ETWVZscBx7CzoFw2RyF/cjQF4o9Tg9aNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouTe4zgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouTe4zgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA031F00A3D;
	Thu, 18 Jun 2026 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774520;
	bh=tEYJ9kMeEHLO272k6shUEWPID4kYl7yFrhvCwSW9EyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouTe4zgol/qqvYdtUesO6rnH51nqxNfQqJrFucoXdQT8nSDiy+4iUGLreqe9CTCts
	 k34aRchUC67G4GJScTMgV7qLie0WngGjy0TGU84hGnBUS4j1bWOapDB6yiCQ2vjx3p
	 IBIygbkEI4qXzBFZarYkRXARmIWZaoxRV/Hzb2+brMGPMV4WUu721CKEsFszcUlPzA
	 AXoy597hfwzuk2KgOe2vTy9TXE2vAzRkMFHW0BjCj+Ke2BLD0t9Y2focow7JFgFOYr
	 90bvIuzU5MPLvWTusXIo5ChW1D09UBJYJnMloc+dtMa44O+5bIyDXrs8C6asHc5JwO
	 /UHnkSkoCPfRw==
Date: Thu, 18 Jun 2026 12:21:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <ajO4sLq2UBciSgOn@kernel.org>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org>
 <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>

On Thu, Jun 18, 2026 at 10:47:19AM +0200, David Hildenbrand (Arm) wrote:
> On 6/18/26 10:43, Mike Rapoport wrote:
> > On Thu, Jun 18, 2026 at 11:34:12AM +0300, Mike Rapoport wrote:
> >> On Thu, Jun 18, 2026 at 10:19:17AM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> I'm sure you considered VM_SPECIAL, which additionally includes VM_DONTEXPAND.
> >>>
> >>> Would that be better, or what was the reason to allow VM_DONTEXPAND?
> >>
> >> By itself VM_DONTEXPAND won't matter, as uffd can't resize a VMA.
> >> But thinking more about it, it's better to make vma_can_userfault() more
> >> restrictive and just use VM_SPECIAL.
> > 
> > Ah, hugetlb sets VM_DONTEXPAND, so it must me excluded to allow uffd with
> > hugetlb.
> 
> It would probably be cleaner to just allow hugetlb, and then check for
> VM_SPECIAL if not hugetlb.

Cleaner in what sense?
Will be uglier for sure, just take a look at vma_can_userfault().
 
> -- 
> Cheers,
> David

-- 
Sincerely yours,
Mike.
