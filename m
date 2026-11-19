Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108185;
	b=ymjAM1Be3oj7hRREJKMSa0I/XhmCyjAt21iZ+MATqV/8mpi8h1P797xonCLHT/ODvUId
	 UHwqRiD0WmA0xEtn1YxGhDaZAk3kUuKIJj1r8sq8HLwLyrut0z1zG5lDCaX9W2ecAZ0Ni
	 aPd5oO8xr6RWnehnsS5jVYqgkD8b3SPr+FROjmhMiVokgvGOzKnPH+fFro1eBOZDVaIXc
	 xTfMjA2pTmkdun4j9u6eUniBwdkYQ2U2IVfxvAATjxdRdGuhRfBtHA7kFvCPLW6xxGUEE
	 R6VIs4xuH43LpVpluTDtyPh/uR/Q6JkuJ8G4pCmB40JTAJhVJ4cW5Ca4j2wquMqkArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108185;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=kjTIY2UGx1NhgSjOcEomeCUaUU2lXIF0XQz2S9XVKnQ=;
	b=HhADGixLb4Ec2owTZz4KjYomitmjLxsHMG8nLqsksuGM/7TuhXEW0hA1dXMot6nQ9r1k
	 TN5sTI4YUR2aLKq+nNlD54BHJCQUMxBfsB5iBno98lysjHicAtEEmgNh3t7+ehsnmQXuH
	 UJC5Kn8mLv1h1KBQS2x20gqCoaC/PJdnGIrPm3w29Luk0H3p58gqrn3MMWZsURDBwQPn2
	 EifLM6lcf4Sh0dF4zUcuvJ5Hce6nljwaShmnVMcFvWbxRdpBg/O363VfI7ne9DaYU0pLF
	 TOhPoGxKpbNCgHOt7XfbgneGvfUdX+91uz8INo0XWyUbBlsQ79u+PDr4ynm1UymHvlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXyUIae0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A20606A325;
	Thu, 19 Nov 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXyUIae0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F21E1F000C6;
	Thu, 19 Nov 2026 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108185;
	bh=kjTIY2UGx1NhgSjOcEomeCUaUU2lXIF0XQz2S9XVKnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DXyUIae01T8Xa859KkxQde5Jcqqz5g/qInarIp6L4ZYzYFFQ9+0xEtGhX/UWCo1vT
	 QiBN6T25udIt0yP1xSZ/bE/BuXPLlatRUp2KwVXdVQOENKb1imYQ39kK+K8Dd3lrh4
	 WhjrANW5+l+vCNu2TDg4DFfQYsP44jVxhn0+9CRbNH6V1nhDpyHNfIMLtq+M/R/Q8o
	 l/wQaF/vEKaMwVkHFbc47y9VcxiSdVl1jjyLmB4PsNERY9LsxJoDLxjvZfU/63w/s7
	 DbTH37N0wq2TGfBtkGPmTySsX5Pw0lt4GjJPmiOE6OmAx7Bg6RFoOwcS8aiLZvSUeh
	 85oIPYAbNhA8A==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
Subject: Re: (subset) [PATCH v2 00/13] mm: batch of (urgentish?) fixes in
 oomk, cachestat, dev-migrate, percpu
Message-Id: <179510817294.6189.11093382716469445160.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:09:32 +0100
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

On Fri, 13 Nov 2026 21:45:18 +0000, Lorenzo Stoakes (ARM) wrote:
> A bunch of fixes for oomk, cachestat, device migration and the per-CPU
> allocator.
> 
> These patches were originally AI-generated, tamed into upstreamable state.
> 
> Some are more reworked than others. Those which needed a significant
> rethink are submitted as mine and marked as Reported-by the relevant
> original author, others are smaller edits which are annotated as such in
> the usual fashion.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: migrate-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[10/13] mm/migrate_device: refuse to migrate shadow stacks
        https://git.kernel.org/mm/core/c/62fab3eb

-- 
Cheers,

David

