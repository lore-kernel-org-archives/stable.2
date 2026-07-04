Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DE371CE3
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130756; cv=none; b=RxF7vDc8Ji6YERRxhFpv7wx0KOSfEGreAn9FEexIj36e4HBfVpZnzgpP8wTwy9/d+ndjwwvJsjUziPaeiWCvauvdRcFhvO7+n/42tyxOo4PL3yMm9FpMbjC6SiKxuD+oTIQnFHA+sZ6ziY1oEhY+y5cMZB/QB3z91qDtp9/cmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130756; c=relaxed/simple;
	bh=p1/WEz7UmSXEOVXSUkgmE4J8UdPLE5xntULIxTnbmlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBtLcFe7aG4W4TuEpgumspqs2GI4KpQYLZWGFZmEFgp/bYMga5lMZWJMIeaM/+JUyv3bZTgB8eixiwuX7T3yiMEEOtGDbscEVt95a7KjLrAasV1hpL3N+4g56sUx0pgf/T+dWaE7c+tp/YYC4S3iZutGK/CFpNM5rqJ0DJCSXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq8sX1pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq8sX1pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E21F00A3D;
	Sat,  4 Jul 2026 02:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130755;
	bh=9RbPJ8CLSCCWuQwLbfPVJgdM++eHUoGKAKPEyksVALU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oq8sX1pw6dDHayqXmDOlP3MvyKrzkzKX67p//uEzkVMK/Zo7uASb9y/la9XE5IwSv
	 JUNlGPT2ToNUTzBS0EgQ6Q8vA8SH52klSwWdxwpYrtuBLgTALxQvXG3shp7vvMQwM2
	 z0wyJSw6zSHLFMDwTFttYsCg+cVBTd3C9Ye/e8it45tyazI8/WIiZc6r3AZ1YcsYPF
	 3LlbQyea/duY2YeawgrX7CpSarfakTl9N0mKUnLP8YvI4hLs8lvrdUtR0/czFfVVT+
	 gWK3XHCbTojzh362WcBX7jfiHl2JFvQlt3fnATZ/4P9k8YFUS46Ge69s/ZifiOYwW0
	 I//hNOYZM2otg==
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
Subject: Re: [PATCH 6.1.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:16 -0400
Message-ID: <2026070315-stable-reply-0022@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154902.975458-1-kas@kernel.org>
References: <20260702154902.975458-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:02 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 6.1.y, thanks!

-- 
Thanks,
Sasha
