Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAD4E9C32;
	Fri,  9 Oct 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557300; cv=none; b=MCknnpP/3jwBtLUJNotkRXNhVVv47Kevrr/dT52udN7dkzfYfRhqN0MQ6V/F+J0x8A3iaofohMmDIw1Mzn/lDoe319lfu+ZqsVHlmsV3OqbP2XVBB1rJ7+CavbAU9TiUJ47Q88+ueCgdDx4xNZy+u48ARW9DB/mmVmM3zipZOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557300; c=relaxed/simple;
	bh=VQwvDsSseAedvgeFn25hPZokPTFSjybAQaKFaAbWhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdVy1mew3qKablzujgmzSCOuhQ5C1YQEpxki7PjgldZ1OPfnX7WHQoxCd5gmMmPYu2qRZnmQfN2vBwefdcbR/nB/3IfO/UJwkYuwQ1CUQ69bvYza9PQpNhrz0G4CD3i5G3ogidlHkZq67dmKl/zL/47GdK4LPO1Bnn0Z+85OCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJnFQ9NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJnFQ9NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F711F00893;
	Fri,  9 Oct 2026 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557299;
	bh=Ih2Tq7SKlVc8vPrcg+4O11tMJWP9hq3NM8B30W6BTEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJnFQ9NFsU5nyqUlludyo+1LiCr48FkipStHI8Q4PrluXSAOr9BFHTcD4pP02kbIR
	 syXF1YvIK38a63BGO3+x92mQy2woEMAWT0i1YWvHQXzcA3Pt4Tzys8YKPbsxbgOhR0
	 jHCMSmI1SCNgB5yuNx3rsCB6NVk6o5a0Y+3Yn1XDXDyJb4k9zrMyqhRa0+WyRxE5+v
	 4kQKVfvbUhn21wgXL2BjaXm+9s4WnIY5qDIEoggcR/S3henoXtCHM9zCBwh76g8aV6
	 PCfIobZcZ814Z67XUd4uLW7fD6Lg04sqzH5oecJuG4GFbcrGiIWmubPqO6qRwETX7l
	 4N9GKfYJkNlDg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>
Subject: [PATCH 6.1.y v2 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Fri,  9 Oct 2026 07:48:06 -0700
Message-ID: <20261009144808.18317-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092949-surpass-thimble-02a8@gregkh>
References: <2026092949-surpass-thimble-02a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
out-of-bounds memory access bug that was found by Sashiko.  Patch 2
fixes a bug that categorized to be backported to stable@.

Changes from v1
- v1: https://lore.kernel.org/20260930094853.52736-1-sj@kernel.org
- Fix out-of-bounds memory access bug by adding patch 1.

Liew Rui Yan (1):
  mm/damon/core: fix unconditionally skip last region

SeongJae Park (1):
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)


base-commit: af13aea0793685297faa77d75b825f0e5a99319c
-- 
2.47.3
