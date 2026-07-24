Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6D33D6F9
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892176; cv=none; b=lkmp5hd//vwwcBKAxFC8u7dOkNbgWl/8Ju7lRLHAtMBU3nwOVVAc9OfN3gJ4rGdC/AoIPc2UQDLjIYrhLBBi+oxxOcIEn7n7mnmp5X1SUAbbwBvRxAUi9cKWIVI0j52HEqjITx7a0hJuR9CU2E/RxksyrHH+JDTtDWRd6vM1cEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892176; c=relaxed/simple;
	bh=O9zhTgE0xAhiGNi0q5pKMCvXByXZLV7EN61u8UHpn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGJD66okDokqrrpXcnivvPsi1Yl6DctOf2Wo9K9mdfu2hvpo+4tZJgdPFW/kYS6NaD5JoYKOzlKCtjOXuP+QXtCQZTTk1rKCI4C0XECaLM1MAkSGibOVG4RKcbYZIZuOP1DKI1Jw31kFsYeFgo97MDsZ8lyqh/qLffVK4jjR8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K02AHaYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K02AHaYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD321F000E9;
	Fri, 24 Jul 2026 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892175;
	bh=wz1tu7QYywygqHXD3kKrudxBMLd4rpVObsjK3sK39yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K02AHaYSbuz6TeIZWBueKFcF6HrZJbVJdvlwVXwsKNm/XLXySbZzluiJO2SOY8XUN
	 DBA8Nv3jGO4wdKtoNz0pcatHiBuj4s4wjeF/zxqcPuhsf2MlFU7leJgRmq+HIiyWXB
	 /Q+3ahFTyc0C3pU0IvLPDbz6yKz+CB6rxPQEQZLPG7j0Lum7aQJwpVJ71uJnpA5cYs
	 SiMWMTJmb90nkNUUT1L5qBNLn11UoC+4+XAuz1qeUXxjmVqH9TkXaHnB75g6OUMlKO
	 l+5vEwK7jl/56u8xkIYeqqQNZgKuVjyWE9jPB1JXWWy+YmQE2aj8Ra8TwTKIG4aNYv
	 eJGQyHc6Za+GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.12.y] fs/proc/task_mmu: fix make_uffd_wp_huge_pte() prot-update race
Date: Fri, 24 Jul 2026 07:22:39 -0400
Message-ID: <20260724105500.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722110120.1908684-1-kirill@shutemov.name>
References: <20260722110120.1908684-1-kirill@shutemov.name>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
