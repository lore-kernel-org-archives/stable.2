Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44A46D567
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016183; cv=none; b=DZXlUTKQLPtyAeZxlX+VZOczjEyOz8etLpuGhFLnZYDqMj8w7Hexsj31UUsW+ziBqy54yJ2kH+5GbVyZAnbqn303qrnkwjGL/Xm88lb3tzz8ZgPGknaAanXORNPM5OR/41780ZGeAaKvqfYK9GjFicO8wtbUx9+3EnFYNQaFdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016183; c=relaxed/simple;
	bh=ApZBwnh2t+mBXP3YSLtRlMpiJaSklWB4oll/StjZyQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVYLW7c4l1VCzDWwfy+ARdKH5VBgxXJTYXeS1cj3h++/c/YZOlkhkUF9xMcAdo0gWZTRh9pWQhMRv7rLLX21nhPRDSCh7ItMDUFs9G+v+f+qQMUDKmaCMfd0lUF++2CpgoWsrSlFNqkMHeA53DI5CCptMd5pdsi8W+NXdFGdzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7BnIgIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7BnIgIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD21F00AC4;
	Thu,  6 Aug 2026 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016177;
	bh=oDhqWEbNLedye7XSHPpZvdaN9AF1d4YgFaL+0KMdzh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7BnIgIttuBxM8HS91dRqneAW6oDbaBQf8SVQZPCKrH0vZi5HX6UGTxOEl+ffg0ZS
	 eTvLBIN2SzrTrGWoWWaZ/3/eqCWdpkdCz60SZxj/3Dy0yWuo7RWR5BnfcZRZS+yFRl
	 O1dXc6EUgGN3C/aG4UI58+34bjLF1d7cwUSInRr7uRgmUK/DRUoshL8KiIwuik+lc0
	 6Fl1HKGEkVzocYJFCYvDRrUiG81YGijoY2KwKOj6VJw8es9QI8tcpVar/wnahGqgHc
	 m1G4TobcLc47q3VmDOPq65Jwj4/IDuOupXPzVspVP4oq0TZc20qbal3cmaGtqTG8vv
	 2o6AaZO4JL/7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.12.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Thu,  6 Aug 2026 07:35:55 -0400
Message-ID: <20260806021809.0002-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134343.2776514-1-kirill@shutemov.name>
References: <20260805134343.2776514-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:43PM +0100, Kiryl Shutsemau wrote:
> Migration entries legitimately carry uffd-wp, so clear it with
> pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
> move_huge_pte().

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
