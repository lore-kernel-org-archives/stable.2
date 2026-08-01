Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71E83A14;
	Sat,  1 Aug 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588413; cv=none; b=XEDC0jzUJCaXzZdWun28SyfcM9QnUPUJ5Rci/0uL6L49ViSvcronkEonr5mTlOZ6880x+bcEAq6mGCpUkKshmroIa7MF/F2ugxM8qG2yfSef06yJPmCEAZuLplHqNDOEgWYJj7nGImEVERJIXZHeK0L8DqbUjZgrO8Kyy1UEceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588413; c=relaxed/simple;
	bh=XNpQhcPOqIyikhSqyYnfJ9qyrPhhlZVyKaToAqlgWiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/+VmY0dgyitSaObPVe0jlSPu+Vt96xaddhfok9p+svbPqPkxgbm8QmscQLjIBsAny350EMpga/Puwq8BFWz5vAaH9Uldx+9Ns3jgGrJwvJsi/BpN++gcnIEzCnZctQPmrb7PFFVIPKmZV+aMC0bk2ooskoW7V3t1aQZbJRS7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqdQ0gEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqdQ0gEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99A21F00AC4;
	Sat,  1 Aug 2026 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588412;
	bh=FkxXSTG3H//V9ns14rG4qN59j0AblwsWEwAmJcsn5lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NqdQ0gEjqB7HERKuKpQmnPZaDGNbkB1jDYLk2t4C951COmRrMXdjq4R1JHuxfOyQZ
	 NSiT4zUzTR8xDpP4TrmxxbOP+3UI6gz37JXEaodgU9p44im+5xtwKhAO4ROLZEt6Fy
	 ZEFk5huLhtE2BPrmSvheETTa1q29dYvHKqhTXZ02VMXNEVnKHmKYRru7TIubaV/zpQ
	 rIdxK72V80+Ik7Z9Y83dqTpqNNOo5J+tUixSTOYDxX7617eZcYGMvX0axVRbyHUcp3
	 v7OvKtcPMLboYglTn+6iRpwbWegIE7gOkaLy11VZhMormeDdU/UGB7Ti6BFxzVKvy/
	 Os5/l3k+5yhtA==
Date: Sat, 1 Aug 2026 21:46:44 +0900
From: Harry Yoo <harry@kernel.org>
To: Danielle Costantino <dcostantino@meta.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Hao Ge <hao.ge@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: [7.1.y 0/3] mm/slab: fix unbounded recursion in free path with
 memalloc profiling
Message-ID: <am3qEKonkiyEG_nE@thinkpad>
References: <20260801122533.319272-1-harry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801122533.319272-1-harry@kernel.org>

Ouch, I did not add "PATCH" prefix by mistake.
Not sure if it makes stable maintainers life harder.

Fixes for 6.18 and 6.12 will be submitted over few days as I review
and test them.

On Sat, Aug 01, 2026 at 12:25:30PM +0000, Harry Yoo wrote:
> From: "Harry Yoo" <harry@kernel.org>
> 
> This is backport of "mm/slab: fix unbounded recursion in free path with
> memalloc profiling" series [1] for 7.1.
> 
> The last patch has a slight functional difference compared to mainline
> due to lack of SLAB_ALLOC_* flags. I described those subtlties in the
> backporting notes in detail.
> 
> [1] https://lore.kernel.org/all/20260713-kmalloc-no-objext-v3-0-47c7bd138de7@kernel.org

Also, I did not include the first patch from [1]
(mm/slab: fix unbounded recursion in free path with memalloc profiling)
as it's already queued for 7.1.

> Harry Yoo (Oracle) (3):
>   mm/slab: decouple SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT
>   lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
>   mm/slab: prevent unbounded recursion in free path with new kmalloc
>     type
> 
>  include/linux/alloc_tag.h |  3 ++
>  include/linux/slab.h      | 19 +++++++-
>  lib/alloc_tag.c           |  9 ++++
>  mm/slab.h                 | 28 ++++++++++-
>  mm/slab_common.c          | 13 ++++++
>  mm/slub.c                 | 97 +++++++++++++++------------------------
>  6 files changed, 104 insertions(+), 65 deletions(-)
> 
> -- 
> 2.53.0

-- 
Cheers,
Harry / Hyeonggon
