Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDC4B049F;
	Tue, 18 Aug 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037402; cv=none; b=IlhSQ1GESFYVOCzOBWQKep/ydtnQ7FCdsflVW5JeVH65RZawiEyeVEZQc6mMcU16t4BnWr+shAQjqUzmdgL0uIZCYsAeQVKVOACfLY4p8zlT7HayvBrYVHFH1ti+nki9A2H5C8wXLeAO+W8lxfTmPvsH2OyGMGlAjJxSt406TZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037402; c=relaxed/simple;
	bh=An9QRXxQh5c6qDRgEqkWdAra0rKd31au3+d60AnTTqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flaeobvuoI7Cuh8ZdOtSYsdXgrBlKPTUxMjEXl1kzj+IEQRLJucEs9V6J5uoIfx5ifh9eaBFgSCXhI579aHzn3lH9bJeOwj01T7qAzZEWjU1t9n6Jd4euPHhrGOcPpZWedQ7iU/K6OE1TJPxllqWaeOx9kQwCryAUbXDuPVQ47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUWDgzud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUWDgzud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94FE1F000E9;
	Tue, 18 Aug 2026 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787037401;
	bh=YSi68YQ1b6ket9ADghC9xT0rrZLBKS9r3cQe8y6Lwd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TUWDgzudrlRbaLYizQ/L+Yv9HhJoPISIWkvwrqqXHkXYQ/P+Mjucy07z+SVpZ1Hp6
	 1+9KTXdMY5MK6Bl5U6yE7HQU8SyMx5aAVVcmET66QYcsaIErLO2M4LjTbbDfSSVEg9
	 KUfSLXuY3hio4aRh64O1hzuJa78MJ9tKa9NXlhtwOZBgiSAxwk/PdTOPXEXERacTOZ
	 X89WCmwnRA0sc/SCIGgfkZ4fabn+PEY5vw5/yoDnAjl8sJI6PJHRsDjRb6sEKuE0Tx
	 vLnZB2AJKTRiMH004WUuwyMr/+YxPjxsHhQhdd4C+CpFVTAIHsLSJ91VhJ9qR8sORX
	 rwwRXiAHWZjNQ==
Date: Tue, 18 Aug 2026 08:16:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Hagen Paul Pfeifer <hagen@jauu.net>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Message-ID: <aoQFsk9GwrZvb7rM@lucifer>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>

To preempt the sashiko stuff, both are false positives:

1. The per-process RLIMIT_MEMLOCK limit is on purpose, it's what you'd expect,
   it matches what io_uring and every other use of the pattern does, and it's
   strictly _more_ limiting as it's per-process limit vs. total inode usage.

2. It doesn't support fallocate so hole-punching isn't an issue. Pseudo-inodes
   are used so you can't drop_caches (which is a privileged operation anyway)
   and secretmem_release() will be called eventually regardless of how things
   are discarded so there's no possibility of an imbalance.

--
Cheers, Lorenzo
