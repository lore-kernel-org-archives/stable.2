Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872607;
	b=Pb9cb6PmjoJE/l+3rQIxwKwCVg8PorjVQXT1D39JqF9VlSdBA806Y9YrY8ZBNXfD2lSe
	 pDc6t/jjVYt/3Lmrh/N/lccI/4GVBdZQxJMGKBvfjSeXv5LeRkuMqEpwjnoYPMjFGj8W1
	 tHt/Cd8RdRcPEjFAjJBf/6dCrA+hnT/is4BlbmsMxVA8gNKz9DlSOs7k01hJHWmMxaPR9
	 0zjklyPfcwIMGTUOdOo2cwbadaGghoWQI1gKIVAjm1nMBVdkDMixxRLNwW6fBubf9cx/G
	 37tEHo5hBJmhC2WU8Eerq5a9FMjNJQggxvv89O79KKAmft1V+tc6MkynDLyBixMIc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872607;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=EmGcTmkZGclye3zFlf2LFFFXhokGH4wDq1/1wV5t+Es=;
	b=bsylKu98eQmCM3X8zL/DY41IPmmbhNvPjB4Qy8tZ0wr8Tv3mNOW4mX8z8rSDIEXqFvYB
	 6xtw0AbXPtZiCDTGYydTL7WsHa+7xSuu5tVBPK/g1kX6ynQ8H1A4ePbby/wNAI1K3/aYJ
	 eelln3QS3+zXXFBjJxfPr0C6Cc0m32ET5n4xAbuGuvCCQ+7kSocKPF31txdxcEvtoU/x4
	 1oeehbiQBlTI1m3hpfRP+ZsgWtLxzB8DbgBkIJ6d77RbcgsCFaST5ApzWMdMcJd3/98nt
	 vNuYMxIvs2sXYoEDXHZuRWWSBSf3OHzjFJTYVqR0P+hrdBX//tNYE+2MVfnDCPn4tNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0F53fwV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6D606A329;
	Thu,  5 Nov 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0F53fwV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278131F000C1;
	Thu,  5 Nov 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872606;
	bh=EmGcTmkZGclye3zFlf2LFFFXhokGH4wDq1/1wV5t+Es=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j0F53fwVxIG1kq6Bhvs9mFnDrLRGxsvL2fUXkhsz0DWarIN8uwSUSufs9hfg1tnRU
	 IQBRyKNPvzOYt9OAMKBPap+70kvJmIfj4U6Np01TYQqQJPtylia+ubPQyeSYUmr/Du
	 sG7e6xR3xzq12kFW4t9LzWufY6oaoGQ4/tJ8foJzBbCANQL5EDfFsohrk0SYF7IXFN
	 4ZseDyJxADF0osxNiSIT8GOstt2PNCf1Dd/K8pkXBnveMAzdCy5LuW+4URnDooxaZU
	 1nxR3YnDMwp4vS+lN2Yhvs6EpTEWC3y9WsJww0XgjhhJRvfSGJ9ESw7ICuSMfd7yzT
	 t0qlOYd7hgvsQ==
From: David Hildenbrand <david@kernel.org>
To: linux-mm@kvack.org, "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
 harry@kernel.org, stable@vger.kernel.org
In-Reply-To: <20261030161046.1497894-1-gourry@gourry.net>
References: <20261030161046.1497894-1-gourry@gourry.net>
Subject: Re: [PATCH] mm/mempolicy: use one node set for interleave weights
Message-Id: <179387260380.17106.274216033383622045.b4-ty@b4>
Date: Thu, 05 Nov 2026 10:56:43 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Fri, 30 Oct 2026 12:10:46 -0400, Gregory Price (Meta) wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> Switching weighted interleave back to automatic mode while memory is
> being onlined can cause a kernel divide error on x86, and a panic if
> panic_on_oops is set.
> 
> reduce_interleave_weights() scans N_MEMORY three times, but hotplug
> can cause N_MEMORY to change at runtime - and torn reads on that
> nodemask can cause a total sum of zero bandwidth.  A node that
> was hot-unplugged and then hotplugged back can then cause this
> loop to generate a div/0.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: mempolicy-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/mempolicy: use one node set for interleave weights
      https://git.kernel.org/mm/core/c/f6484ebb

-- 
Cheers,

David

