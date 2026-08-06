Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0846DFEB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016180; cv=none; b=nzMmRIhtVciylnx467Ckjmm7g0htkzErXlQQy249rmkoaZqZ38QdTl7HdYTN6V9tZafE1Pwmvw2hnpagrDSejB1qDx/HANPd0aBCSDZU7ycWLua6ERR7T/jRHcytAMTQjNRNMqJs05d8sJGDC62Y9Ri5HLS36lbldK4t4hQ1dhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016180; c=relaxed/simple;
	bh=3hrI4QtkMmYWnCq/lmfwUVlNhbz+3bql9+2uqfxGqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWIskcgRDkBb/BqaOXGF1wpR6nu4cNNmNM9GZVfin+D9MQXkGHriRDrgovws+Xkt/LQ9/1N9lMUZbI6xQI+VcJfbzjNOwQAjDOBfk9gpW7UAu41hLhxVLfcx3VDE4wA4VsB6jayr6e81tXMIbNy9ltgMNHKz/xzsGYYVo18FtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZT1694l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZT1694l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AD11F000E9;
	Thu,  6 Aug 2026 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016175;
	bh=gEjcNE0lug4zCFpk/0++c9LIi1gn1aiSdBeQ6/kYiyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dZT1694lFHQvz16N8ax/JikrVUaKCYEwy7mVjcGE9UBWntDegem3oC54RzCAmaBFO
	 lJL/GQ+mqrENd/WaXsKvAQtcnXPmYk40aSA5TYn3Fesp7Candj0PHgUP91UQ1X0HuC
	 GVQMqyhQFis8YYXbYYDfFl1aQw8W1N3ykZF6PUOr9GAx2kSGZMTL5P3Pu8xdpy1Q09
	 jUvSaICdKjcHDzbFrKLusQ7AD9nqSOuNfWUB0qwVN1fgSzCOew8GKWjb3R0FlfOYtg
	 Wc4EHdHJaWkKA5HtdOdD0AYcsBddCWMXTR+HQif3lzfBmQu4bLSrOsmFusno5K9O7a
	 4IuXruSkBuQ2A==
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
Subject: Re: [PATCH 6.18.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Thu,  6 Aug 2026 07:35:54 -0400
Message-ID: <20260806021809.0001-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134346.2776524-1-kirill@shutemov.name>
References: <20260805134346.2776524-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:46PM +0100, Kiryl Shutsemau wrote:
> Migration entries legitimately carry uffd-wp, so clear it with
> pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
> move_huge_pte().

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
