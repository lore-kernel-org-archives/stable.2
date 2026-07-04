Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937143749F7
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130749; cv=none; b=d2/3X/Hsc7c6NwYJPBNBAVo2qaSyIoMBZWAwP1mzgzhxt6FKZzJYBrSGdJCzGCx8lF+cZ4NZoKmddEPvREYUzsrxTOZfpLy3An0R1nUPBcQaq01L1Qi0IwV6WZyU2WVfF27es0fy8i/bdAJ8b4shs1EUXHEspxfy43xbKHJmQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130749; c=relaxed/simple;
	bh=p2esmnv3C4tAtf/2wdWCj8HNGs/JBx9foPru6p5TLGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTv1BfXUe1w6tbJQ/oB8CuV7TezCuUPzZ6w6BoeJ24aTIMqq9pPagHZWd8109yotL3ah+pKvLPc8LcZ6fvQzwANI1EPUXoSDAb4nAQv3RiM2R3rcC/7yew7EZ9rzuAYoyPYbhDF6YqGT2dIL6wpDSl/4rwA2jo615iEDCb1MGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz7SoV2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz7SoV2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181AE1F000E9;
	Sat,  4 Jul 2026 02:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130748;
	bh=81PCE2mbwOgj8kX6gc2Z2Hk9aUjJ1uNYjYVBkzh6qwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jz7SoV2mbK0kkcDiWeKLz8bS1DcTwg2TeBQ4JS4OJku37uVDxMqwXX3qzFnKAgUgi
	 oTROFkTDTswR2CeoZHrBTRzEcS6oguuQGmLJpQjGML1ZXtHBY9n3Kt6g/Tioaj1OlJ
	 VD2Ff7DCImAOtWyJGCJi3MfXhL/pfaqus6dG6bCwheIVvRWnAYeJw0jDfzcdQ3y7wf
	 FS6TvA5nTF75k7VnLiMV5HUBtqtrunbSnUFkOh2Smzl9HaAcDcgCb+KtEpAjKN3Tfw
	 qeqWiY5kryThVqmCQHkHp8QdgNGdIqe7NgeZCTxrMq81SdUf+d0Q+PRSvKw850+vUa
	 y8c2bjWdXenEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 7.1.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:12 -0400
Message-ID: <2026070315-stable-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154908.975523-1-kas@kernel.org>
References: <20260702154908.975523-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:08 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 7.1.y, thanks!

-- 
Thanks,
Sasha
