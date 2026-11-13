Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564913;
	b=L4i9GSXIahkBh5FmumKbHJ1wTWpMS8JPkPWQ9K+cEu96QZGGqi2LEmt/QsSRT/7ukA5/
	 RQIBGUnhpneHkrEboRnZWesE+zxEB+e+nZCstqhcTIjnbqPbeJEvUjTqGdzWFgxprNsdF
	 f5HsOfEyx+kb8vhvEG0Mtyz/5GKINcoenaGSAnPk5udKWO6LHBLa9ZLcREydmFZPpHIBF
	 VpN3oQuw9QPoOy40GX8yYJk4ZGbjSOAP5fuddheby3r8Ms6QNpXhi1d7zEmqGOylX35Of
	 +nUjlLBdKb5rP69aDF+lO5b5iF+YqIM0l1zBruuIG0JKaK1XgKvqqkwS4Gl0Gig8dSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564913;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rMuyr457fqCWZXx15HHMmpYyTiHvK3jp03BAUYi6K/g=;
	b=mqGZNa1KHmNilbTl0ELY/RgNolb2aTJJYOuNeONsrYrnZVVRzjGQVyVlTkfuyOU3sS5+
	 +DlE0GWhVOM8PnYSNc4dzp1G55u+pZ6KAdqfCu5KwzPfH9Uua3lMp9mDsAnC245sXwT4q
	 UMqfUfLvKqUVaFhCaZ52nlRCXKiip7RHJSCxNNLAgWG3w0HuWDbwG1ttg8ylHnrt0mUrD
	 FJV4BcDvoU433xSk4Rr8AdWJV/JUY6SytnzKVWEE02k/ilFAYJ0xQzWBFkgYemYU6Db+r
	 MJhT0Z/pPPwuA6J29GYn6IaFcLCN/kBhmE9ZHz0EqUsCaLoRdiQTzBgEjAG83+cWnFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mugwqvhM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD80606A894;
	Fri, 13 Nov 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mugwqvhM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A811F000C4;
	Fri, 13 Nov 2026 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564912;
	bh=rMuyr457fqCWZXx15HHMmpYyTiHvK3jp03BAUYi6K/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mugwqvhM1NYSHmQVe1isbb+Lt7fz8+iLoYW5R22sMCGb3YuPbqdLN+KDfQCT8NvxU
	 ms7URPHAVatE2sRnmNhqBJ8cJgyO3ACmQrMGrk5JAEDYq6p+Ep18MvT9fHEuMGZ/p0
	 DTSm/kK1aZMBl0Bp2I2ZOLM7kRDi+pl2SyW7u4p6dG0ASRhvGyngVmkAwzdjR6dEtP
	 Dclc8J2YE4U60LiGVPkGX6UKSyY2EcSphkWyfETBtsYYOeDp/X4SPrFn4VyR0E/oRn
	 JFHNvcqIK3jLyDTAYxEEMAAZcwM62FV36r1CsTIlXyLB2bvy+QPTS6tjfjnrmoAsH9
	 dCNgaq9OvQBiQ==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, 
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
References: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
Subject: Re: [PATCH v4] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Message-Id: <179456490744.5856.15187695775214289167.b4-ty@b4>
Date: Fri, 13 Nov 2026 11:15:07 +0100
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

On Tue, 10 Nov 2026 22:19:25 -0500, Zi Yan wrote:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
> 
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used
> by migration_entry_wait() sets PG_waiters concurrently without taking a
> reference and the frozen refcount during split cannot block it. Meanwhile,
> __SetPageHead() does a plain read and write, so PG_waiters atomically set
> by softleaf_entry_wait_on_locked() will be lost if the set happens after
> __SetPageHead()'s read and before its write.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/huge_memory: prevent losing PG_waiters in __split_folio_to_order()
      https://git.kernel.org/mm/core/c/7183af7f

-- 
Cheers,

David

