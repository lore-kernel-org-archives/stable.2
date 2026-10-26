Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022809;
	b=l6xhlDGZjZldUXwcEwqEj+OxD4/BbtQykkHz2F2dLO/P+Y/ROAVSMBjddD71BAaWu7/5
	 9HtZBM9Y/2qsVvtCSobLHxQBH6+A6xQE/7GK/384CO44KaEWdyLepPAEY462cICUXo7GI
	 7Buy9kSSCe1iKBDjRfCU9ucbU80LsXf6qtXWM/LHKDh7G8oIFuv8TOfr9phe5pkFW+YpQ
	 cBNTsSROj0vBzQr/2Ck2Rs2h3DK0r+WOASkoCysFHdgqvhWfFx7Ayld0JPAzqA7xoR/C/
	 horQ90/nPf07sKCfAOMx5KxcQoxwBqdDsoIWCNjatilDyYKliM+OtO7nSf7AIRu1n6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022809;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2VNtcJdRiVE5wcehkgvy8TAiipkC3W4OhSqQ91G0hU8=;
	b=yQu5iVn5Ownq9Yu+OWLRmiBYogCC2QhWhDAe76JNB8p6TbVZK4J97VwvkzTMOJF9/Oza
	 PHB+dLUGoUCeDnemANvAApDyiglLYxfRDokDP7+h9hUdrMxPcGYvmFXCda0+Xa9LUnS2U
	 0La7svZcoRwFNkzlvboBDBApbhF+VRUWCDdMMhmgzwyb1TcnY6oTG/wPs5nAI0Pne2PZb
	 gcvqI3g7b8bKzUkLvXOod2Uiu8DfvJDoxo3o0tblP1R2WaG6SVEIOnBaSQ2kVGHAMdWAw
	 /BspYdQoqozmbMWLqm6Dm2KOvxkAjz7eX1Ha7o8NbMksLDQFY1lnRFVobPYOaPfnv2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjBhwON2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C584606A31A;
	Mon, 26 Oct 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjBhwON2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73641F01825;
	Mon, 26 Oct 2026 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022809;
	bh=2VNtcJdRiVE5wcehkgvy8TAiipkC3W4OhSqQ91G0hU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FjBhwON2lGqcDeAsQsur5YQJpwijTGL4gNxeB5JDtzunt2ZZduk4xjYTAo4go/lcZ
	 2Ve+e21JhrcXXcs9OOlnbwi4MzsFVfRdSI1sHTUueXGDCH21vG3mBKNGGZpOdr7YlY
	 cUViZLTP8txseKSOJ0MNjl+SB3FDOhv3ilrjaaXLxzb5OtnypOzQI+/hseFVUmFuvx
	 biJmLnh3FuzD56tP9s1isiBSqoSCE9HED5vpgGDUK1LVc4GQj6oxVJ7kV8SfEJxucz
	 GdAirjMlWMjzqoqiTgccW04NJAFGnOvGT/IILN4tjOafVrcHPqZHTHDWVgJyVSxIlT
	 KbIcgx6+lz/Rw==
Date: Mon, 26 Oct 2026 13:53:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, liam@infradead.org, 
	vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, usama.anjum@arm.com, 
	avagin@gmail.com, mirq-linux@rere.qmqm.pl, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap
 ioctls
Message-ID: <at9YUh99R8Ib7Lr9@gremlin>
References: <20261023181300.3366487-1-hengyul@cs.unc.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023181300.3366487-1-hengyul@cs.unc.edu>

On Fri, Oct 23, 2026 at 02:13:00PM -0400, Hengyu Liang wrote:
> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
> handler of /proc/<pid>/pagemap.
>
> However, do_pagemap_cmd() returns -EINVAL for every command other than
> PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
> the VFS returned -ENOTTY for these commands. As of now, they fail with
> EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
> of ENOTTY.
>
> The issue can be reproduced with a simple C program:
>
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <termios.h>
>
>     int main(void)
>     {
>             struct termios t;
>             int fd = open("/proc/self/pagemap", O_RDONLY);
>
>             if (tcgetattr(fd, &t) < 0)
>                     perror("tcgetattr");
>             return 0;
>     }
>
> Before that commit, the result is:
>
>     tcgetattr: Inappropriate ioctl for device
>
> After that commit, the result is:
>
>     tcgetattr: Invalid argument
>
> This patch will return -ENOIOCTLCMD for unknown commands, as
> procfs_procmap_ioctl() in the same file does, so that the VFS turns it
> into -ENOTTY.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Seems reasonable, though I doubt any sane user is relying on this.

Confirmed the conversion from -ENOIOCTLCMD (first time I saw that :) to -ENOTTY also.

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

--
Cheers, Lorenzo
