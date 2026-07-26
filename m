Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB23002A9;
	Sun, 26 Jul 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785084614; cv=none; b=F6Fcv3I2rkS9kgXAE3g5CEc1ZXW1ZqYk2xE/X0LsEQ3iNb13L8yfyMy5Vgqq5vDM1daLVQT5jUbcfa7klQndmrzQkgjnvqPnYKWu7RCppm1+zs8B8rOAwCavmbu011Amc0UYuf8W62rcdN03+mD7cprQpnK7bLHCJKPS+ItfQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785084614; c=relaxed/simple;
	bh=vT/5K3Ja1PiO2m6m2XNDX/iK7eMGfT7cHgZOfuxAbSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnpfA/C1eMRMDxokMq7AZfDdpl4hNSouLnKYuozf0sk0p3E0DWPaXUiafcb4a3SzLraGDt3zZWAGjlFBUqsR6ZfBD3Era4yU7GBrMp0ib+V9aJyzR2I8Xbt9yrVZmzWuw4EdvzmS61qGoRW9XA9HKe8FTlQuzXhPGuxpr8G/AKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxfOEtrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxfOEtrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD0A1F000E9;
	Sun, 26 Jul 2026 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785084613;
	bh=bihQdyqP8nybmk/Z5jPpiccWyJrZK2FXr9JjFx/kKKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VxfOEtrqIoqIK5xImd1RD9szFaJb+642xnsx+4gFfvd/ngO5LzRGs6cxaJhiSR/7X
	 Wo2YCskKacWVCI5E/RJVQJmduIxdk46iUaLiDEx5o5fX7ZeD7cS+hgwnRBWZwU9xAi
	 U6/7XI9b0mH/1TA6xUen/ZnKcDJsthpP175NtyphpPaEBudZf8o49YRdHpS1nziqEq
	 Phr9xdWYresJUuQRSx9LjCyphG1I+2Om4MMLVv4T0ePuk0Ppc/gFdcXAXjG6iGGXRF
	 fTHh+zs6HjGwxDNEH6RlnmTF8ohK8LwV+O3JFniT4OgmtQk0+/pnMSP8KtB1az7JXR
	 q0Y9ArRK2EO0Q==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Sun, 26 Jul 2026 09:50:05 -0700
Message-ID: <20260726165005.88635-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726014815.1280757-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 09:48:15 +0800 dayou5941@163.com wrote:

> From: liyouhong <liyouhong@kylinos.cn>
> 
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid (including
> the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> without putting the folios back to the LRU.
> 
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.
> 
> Put the folios back on the invalid-nid path so ignored migration requests
> still return them to the LRU.

Looks good to me, thank you for catching and fixing this, liyouhong!

Andrew, I think this deserves the hotfix fast track.  The bug can cause memory
pressure, and can be reliably reproduced by the user.  The user should already
have a sysfs write permission, though.  Let me know if you think differently.

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ
