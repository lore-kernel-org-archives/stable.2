Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247146D2C9
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016184; cv=none; b=iBsvlN4EP0IKQWk1WW7xLpFfMuRfDQOVB28xuHXy44MHPpjmxcr4jxb6MuCqW9jCSpn/StYMlOwnyFEGn6VJ6b6NEQdrvkep2UOMjHmPPw80XKt42TjBFwgkJ+2wpDItVQpw0yMmu1ytChvOmeu5cqYvOW8Lh76FIk3piABt+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016184; c=relaxed/simple;
	bh=KSgh5xPe1/nc3g8gxsUYrv5IqKWjKG1boYq8PhpDgHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeDyDq7+md98UBsPm5jWkkhcUZx7j8M+iH4FPy9RkXP+fx4lahzkuui1vDksWzE1/Nu7RchpX4EjCBwU75Yl7jIKmoWabzzx/6IluwFgqeG1A4VGzrBHPeuvqEDtsX96L4yT4Ap2hwKiO+rFwCh/T+CxlZ4lsE4jCzvzxKqBmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwdv0QLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwdv0QLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7249F1F00A3F;
	Thu,  6 Aug 2026 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016179;
	bh=j/3DEbKSXu8sfc/5oaq2fLHJiFwZUecx60V5kDcY+FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xwdv0QLcUalMpMtYP/xerhTBR57g1LVb50/hFlOip27d/I3vHxLy988OZfbnQPbJ2
	 i72qGKd+o/WygXHhTmfFklzmVcUYrcpgsMK1Qq1OLoSamVMGWJw9ga1ZFy7dTruIE4
	 7teeM2qIsWz9lS3Jk9wZaIFYFLnPcr6gbCyPGajWD6mgx+dVH4UenfmxMo2akwu+Kq
	 2GSymRVQB3qeB3Vdbj5utCpiW9i8gNYoHHXUL1bJ0zuejaqn5TYUijlGprfxWCfYNS
	 7nymcz1zSy+8h8pJLmV8ravaewnPbdjikM6c+cuzsytOnIR3Gv6hEx2FxVGv1gLUbV
	 lIf4wcyaq3U5Q==
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
Subject: Re: [PATCH 6.1.y] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Thu,  6 Aug 2026 07:35:57 -0400
Message-ID: <20260806021809.0004-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134330.2776491-1-kirill@shutemov.name>
References: <20260805134330.2776491-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:43:30PM +0100, Kiryl Shutsemau wrote:
> Migration entries legitimately carry uffd-wp, so clear it with
> pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
> move_huge_pte().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
