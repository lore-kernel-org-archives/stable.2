Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC7371CE3
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130751; cv=none; b=dfD3PJZBLIVxdyfC+p5JhW/14hgPzCtXIRoFF0DQ9aUi/ai/yRUC+GE7nQSBJIcONB5Z2fLVm9BfpybqtsAZDOZHkakrs4H7FB409koeo931LA21k3Sa8+nJ4PcUx6P7zYHyfpo+TpwbvU1oifeFLjDrmr2BdRBmob5BhxE1H2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130751; c=relaxed/simple;
	bh=Bymeqo7TJygbQDFx1b+mc+ZfhO7vUxNbkBkpgc1FSIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGexzgl4g+crcPjik9H1LPxru7cp3D72u5ERBuDMezEA+ycF2SNrnjVyzeh+7hE6QVedHmhWjYzagZCBpH9NYxCOj49SQwim7OcVJV5y20UjNKouBHdoo32rWGDJfUN5aX9B2PW6bV/JlJRM33uekHvys0ee4WSdUff57r5M/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfCQ7v8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfCQ7v8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3691F00A3F;
	Sat,  4 Jul 2026 02:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130750;
	bh=LXOcPNzgegE6L6G/fMOjfbLXmHe7Z7CrfUSz7274nys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfCQ7v8TpmaDaRz4ItLLC52emgeSTOSpbC7yXZCrbMzoRQcu5Tlsz8w85divZUacW
	 yE4+PtE1UKB9Poha36Yhkdbmod9lSp+FiL5LAtQmZUDN5R7kIQj88JW0ryZzT9XHDn
	 TnD1n6AqKarTNeRl+1OnmpWGr/aWzc1mQqrLF0p8oLIK+VlIGxt0NxP8I6Pqncbj3t
	 cuq977QDzN8MnJvaQwIf2GhLWFR3xjLrCc6v4JBaz3ewL0EshejbTjCBoud6prlEE7
	 nyCEJid5vHfOoOpMl5IzwdbJMXNie7kQ0T3tvZjXfHmTW08QEqhjGkx6/4L1TzIypL
	 HFFqAedPMSv/g==
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
Subject: Re: [PATCH 6.18.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:13 -0400
Message-ID: <2026070315-stable-reply-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154907.975486-1-kas@kernel.org>
References: <20260702154907.975486-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:07 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 6.18.y, thanks!

-- 
Thanks,
Sasha
