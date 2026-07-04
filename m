Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470F371CE3
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130758; cv=none; b=BHFxT2V1D784d0RKviJYTi8AziIlaW3BJXKWonXuJeXqTcZMbmMzLh6EmsYJkxvkRM+beQaOPdALeWTa0UyB6CKtp1iSOMcIUEU79Pwi5DbNUOJdI3O+oZkvtqe/tMex9dyjisvB/LK9kRe3oX3iWz9CnwNAQ5aVK+axOtx177g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130758; c=relaxed/simple;
	bh=SPTSrMhT3+BCpI1Oi787llTCJDH+kQqwdpKbNJmUOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRl9Hla523QVutS79emOj22xim42ezOo/FuoRyso3rPbgFRKcg5CW+kv0Jb/bj6petEnkwbCzyqPfTC4lBuYdOaZGXwBSRIbld6GN5RZERvCSv4BtAiAXL1cy3HeuJA3IXvrkI8vHl1EP/kse/9AdyA3k9OBV2VI4fq4rCWZPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdoCgDtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdoCgDtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0271F00A3F;
	Sat,  4 Jul 2026 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130756;
	bh=xEo1AaQJes5X/KGwWEfSgH+0KRS+NkX/6r/RZR9huow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdoCgDtQ6oeWCuOjAeX10Q9rY5ny7mLhAcJzCzhjarhl4dqKlPrc6iCwno1MBwlA+
	 Fg5icKYtMHhpN5avCcgmp1iD6XAtj7rclrUsi52oLquKTKo4JdT0o0oGKNZa6yoErj
	 30QGhIFMRpXeZB7qe4vDNqmCHLiAuyec6RXM6vpmRq/8wR4QkodjBRsllLifTSjeYy
	 YQR2njlPGq4AXdfWklHY6SvJg10FVxSUhResGdFvqNaTxxf05HiF5Vo8Fq2VxMN1YV
	 ir5ukiH2C0E/U8P07ODMjpZrdADkmZNP3wndgM5jzk9Sd15Ed4PkjUp2oRIhOKKBvk
	 J1WtqsEuz0spw==
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
Subject: Re: [PATCH 5.15.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:17 -0400
Message-ID: <2026070315-stable-reply-0023@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154900.975365-1-kas@kernel.org>
References: <20260702154900.975365-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:00 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 5.15.y, thanks!

-- 
Thanks,
Sasha
