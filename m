Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015270;
	b=3wIvtEEpNknWpnC30KPDmcLBQptkSe3AYnj1zyKq3aYBvQQzpfn7Ks0I+xqpEa8nKsHE
	 7B8Ufr4pxWcF9m+c1svCzhlbnGYNyUTjejZpW1KoxN6urZvmwn+q3erXkdD+HSTiZI/9x
	 5Si1jKQLr/pxp/X406w4IXVniX9HwEjDmQ7QYlejA466sL8d45y2o9weHweYTI42/XKYd
	 4X1L2Bujcu9YHXFuvQvHDf5uC4ctyZiJ7EnARgNEXAXF+qfolqrOPZx2r26l7gl0WNXWU
	 vWnxRMYzMEyH+SM7MQkPfdGZcOzh/4siVOWEESPRxirmbr/dQLJJgvy8qwAlaKgysiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015270;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=1shZqnP71Ukitlfj99kedJcZBJQFJWYHeZCXEuiVk/I=;
	b=RRZcwjiBpF+M8tZqu1mq57PWUZmv40JX1q36AINgk6SDp4fQ1j5HiBNWyzYny3yL7/ac
	 Bqgu8URAVutD9aFVJsx03RQfCHC6VfBBGAOyrGuB3YWdxMjQ6vHsdegWpRNDp+tlgpHG/
	 HTiz2owEvC68+hCuU9nhWF9lsaPK5MdBawDtqNWVq1mGA5AlOAQJlGtrmU2Jx4Iy4IRfC
	 w03Mgf4OiOtkHkt0GRm5sKcHo7utXERfTJ2/Tvjv+pPNGHTc6MmaSWBsIjYIcRnEQQOuM
	 A9y6Xxon30alu8xuDaHw8ZzrmMjcanF0xs6jlSVM3lXSL3kNTG3DdrcAU5nM6+KBIqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhFelVEj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415F606A32A;
	Wed, 18 Nov 2026 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhFelVEj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1F51F000C5;
	Wed, 18 Nov 2026 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015269;
	bh=1shZqnP71Ukitlfj99kedJcZBJQFJWYHeZCXEuiVk/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AhFelVEjfmme1YPI9SS+ALRaQvFt+2IMeiCSN+WgOjeEnv+/SuTNf01cZy6ptDUYR
	 qv/tiHy46NDQyvohLFArJuLSsfy6vAVfAjVqoLBPTlszEbf04FN8CMxzRsJ9d1yi7R
	 brtXqyu94yBnimenwmhETIFopB0rebgPYtlPWVNdluMDvPyVu17HWeotXEe7kmazyQ
	 HNRJ/F03FfU1PSeSYm1vlKEpMz6j4DKS/RCdxpK0FURFwbqKlYl3v8M1e9YzI023ra
	 ifwZgVYhoaeH5afzbCuCVdd7EprCvOeqhwy3A/kfibbP3cMGU1Y7oDipu3gRnSFzLC
	 3i7iv0Q6NGlsg==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Tal Zussman <tz2294@columbia.edu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
Subject: Re: (subset) [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
Message-Id: <179501525761.13527.5348420494097607881.b4-ty@b4>
Date: Wed, 18 Nov 2026 16:20:57 +0100
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

On Tue, 17 Nov 2026 23:28:40 -0500, Tal Zussman wrote:
> This is a first batch of userfaultfd fixes, with more to come.
> 
> These were found by a mix of regular old LLM review and by having an LLM
> write a TLA+ model of uffd interactions with PTE bits and other state
> and seeing what issues fell out.
> 
> Most of these fix places where mm code loses uffd-wp or RWP protection
> while moving or migrating an entry. Userspace then either misses writes
> and accesses, or gets pages reported that nobody touched.
> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
> file through a private mapping.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: thp-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[6/9] mm/huge_memory: build the moved huge zero PMD from the destination VMA
      https://git.kernel.org/mm/core/c/ec36bf72

-- 
Cheers,

David

