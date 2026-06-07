Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E46E2E736B;
	Sun,  7 Jun 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814583; cv=none; b=jvoRDYXBWvgJE1K2nd94wlYzGJT6NBewruSy35o2pxfCwnL3XHqvvP54jZWnPZfo3vZWafnBwj1+9y3KexDz6+7nmXipo2B8R7JPhVRoxvYvVFVnV6yocMaRtFamrrSdmT3PJ37L2jsAqSgXg2BMApJmKHZAdMCs1iuhtnZWYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814583; c=relaxed/simple;
	bh=K298PaPxz7qYDNLk2ct3glg8mvCnu0tcDTsoTojdB1M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TA4Tl10Ea0K+oXIBmb+Gsalcu8SnNSdHRkDchi5sBDVi2+4/2+t3zNEpEI6W60tXqJeG5eB930a2t4tl5AxNEI5B9jTR1xRvc10urymDihPIK7dCemAgsyevbEarsFjqgfhcKOwJMj7kABtaHCBvWSzJlrvRXeRCzgSceASdMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrdMqZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPrdMqZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B01F00893;
	Sun,  7 Jun 2026 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780814582;
	bh=L0RBItlob1/lCm2QEqFsy3L9ByS4dHuuq7PrYLHZthM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NPrdMqZvcxVQhGRt4EBBfKFEkzzqQlXZNGWu4ls/OPkopsHtzYttxd9I1hKQas7LW
	 qoFbrWyVcmYin+8cBlYcBkTDMDozfZ4hHilmdab3DBkXn/SrblXaQ4B9lg1m199hga
	 PNWahamio2r4q9QKQrlFhn+8zk1iPDBzueNwRT4p5UXQCjR5KcfROCbNF462Nwiv7j
	 3BnQwG3qb0nQpzeVIKACQ5wOTixXnaOB4iQXXtBVCs2CHDGcEGPfYemWbWUW1Y5DqJ
	 plek6KJKcanjlnOGiGzf/m8eB+XeaaxnhD+WyQhgl9FQ7iUPxAJMrkDkUMLyDgK3jg
	 VmWCQJVfmCB6g==
Date: Sun, 7 Jun 2026 00:40:34 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Alexander Potapenko <glider@google.com>, 
    Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
    Yunhui Cui <cuiyunhui@bytedance.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
    Palmer Dabbelt <palmer@rivosinc.com>, stable@vger.kernel.org, 
    Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH v2 0/5] riscv: kfence: Handle the spurious fault after
 kfence_unprotect(), and related fixes
In-Reply-To: <20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn>
Message-ID: <85e01c4c-6616-3ece-520f-30c6f8e53974@kernel.org>
References: <20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, Vivian Wang wrote:

> kfence_unprotect() on RISC-V doesn't flush TLBs, because we can't send
> IPIs in some contexts where kfence objects are allocated. This leads to
> spurious faults and kfence false positives.
> 
> Avoid these spurious faults using the same "new_vmalloc" mechanism,
> which I have renamed new_valid_map_cpus to avoid confusion, since the
> kfence pool comes from the linear mapping, not vmalloc.
> 
> Commit b3431a8bb336 ("riscv: Fix IPIs usage in kfence_protect_page()")
> only seemed to consider false negatives, which are indeed tolerable.
> False positives on the other hand are not okay since they waste
> developer time (or just my time somehow?) and spam kmsg making
> diagnosing other problems difficult.
> 
> Patch 2 is the implementation to poke (what was called) new_vmalloc upon
> kfence_unprotect(). Patch 1 is some refactoring that patch 2 depends on.
> Patch 3 through 5 are some additional refactoring and minor fixes.

Thanks, queued for v7.2.


- Paul
