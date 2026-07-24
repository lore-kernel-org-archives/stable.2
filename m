Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB343304D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892177; cv=none; b=ZMrLxTeVKGLvdVNxQ2xdr4DsAdCZpP4u6uMMLKcb0QlNT5oLO0YwsQgBUXebMcB1s32VOPKK/ROqqVV8MRqlW3U6Igwv3iWGib28xP1QS1ErwrxicY+YCCAUlYXigBZUfMnNwhaGy5/xvBXYK/38pNohTjgfc2kN1LbgGogdWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892177; c=relaxed/simple;
	bh=SRWhznllSil9KmJxB2VXvv4qKV/+i+2hQ+MaRRs8+xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF2OtmzZRyvywmGEkGIMHWK/zqQNsXsGC3i3MTt/B8CPIXFUwWqMNhqpdcBTjWYBke4DSvJuXu1Jb4WFh+JCYxlIKgKXALOZT0J9Hzvu2WxGvGcp3EFMRyfMMbfIideDrzwsQMreM2pkbi4xPnMZ6NKOpIU4zU8drTRTU8tFBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP4Nhk2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP4Nhk2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538641F00A3D;
	Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892175;
	bh=nGCwM54DPg79c8zvHpsmcL29/75sVXPsYwWXxWbjwM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cP4Nhk2ulRSEbcF/5myiw0EHN5dmY/KQS7JvSNT4GvnilJwQCCBgun6i5zyNZbnON
	 kAyFQqUP3iFBFyO90lky3/Qll2ebLv51s8/nCIMOxAiP+f1bZeYeAEIGA6l7M87oSw
	 0E1TYgUYEjTuP8nb/lnrHIGLUeJSKgYqdVPdJS+zqjos0OpziUHzyf46kHKTM3x/eE
	 lvKWZWjGPJgGkG6YkDmwO1ZxnYcISrjChks/jKD0JKAntONoELhxlxhX5HXihPGoeT
	 Euf0iZ0Vbd0mSUFv7aP2ZEISsjDsDqGwL1e72745mwDoqPtp6303fA0O8O3eZiG6t4
	 yhVdDIA+QkuqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.18.y] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Fri, 24 Jul 2026 07:22:40 -0400
Message-ID: <20260724105500.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722110123.1908692-1-kirill@shutemov.name>
References: <20260722110123.1908692-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> fs/proc/task_mmu: a missing huge_ptep_modify_prot_start() in
> make_uffd_wp_huge_pte() can lose hardware Dirty/Accessed updates
> when PAGEMAP_SCAN write-protects a hugetlb PTE.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
