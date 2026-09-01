Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BC3AB498
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225724; cv=none; b=QK95lCKE6emtgXIJ2F/tyXNze05C6F497o61KyQKpfLt80tAVsfedx+4z984RSSOjokWLXVK47PIuwKDyNxHOnmF0rcbmyoEd4KJMP/6PmwUl+bcSW8R4TL4RPHoPN0n9vVi84RF0yA84o33VWT/HqnPGTYLIfTZuA2SWLooui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225724; c=relaxed/simple;
	bh=5tRriPkTtEmfPPAXNr/KnSDk7kAYdmh/jVqONx4fbqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N527DLW9CylqnhTm5x8jtjsuGba+8UXNkRbEt4KakI7J5oysjlNXU5jXnC1GEcoFcw1ZRJ6kthU97CNkZaBzcuONDLVEKZ+HVjWg5lMFLIdW7ebAvnk0/rYsOQQ7y6EsQ9Q4L39B+Xim0RLLin0gCuzVbt9X7Tta+6p4n7PbRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmzBmIQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmzBmIQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FBE1F00A3E;
	Tue,  1 Sep 2026 01:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225722;
	bh=hJZoW514uEInOLUN8S8e3zc4YecqjAlwcGeNaOwqtnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmzBmIQOg4TEMhcaDK0jt+S4kcYqulfjwLF0iuVk+xS7492JPgyl/m7DCETAsPifW
	 so4A4o1ZAkPQ8ax7Dhj9JmGBhxQryi6uFWOmX48mB9CFWpSDjFd0LblRIymL+TEmH1
	 u0KM5son1XU5a5ySz9IY82mKvDLqQHf2gfwbhJ+AShkCNPHChGesM/2nLWqfNhxcTD
	 fuI69xEeCrsQWmAFDLjZbnVMzuYsx9KQD4q5kaaqZmg6OSlNibV940ZcR5dOQaPzw3
	 mt4TZU5SCAE3YqdBL+liewBBO32v9BGbNULf3nAVi5iL5TZckySG8FLBlkHFt9tBXp
	 beWxozdWd3eBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.6.y
Date: Mon, 31 Aug 2026 21:21:50 -0400
Message-ID: <20260831-daily-reply-0006-cve-fixes-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830082733.35424-1-artem@trailofbits.com>
References: <20260830082733.35424-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I applied the current 6.6.y queue to v6.6.155, then cherry-picked this set
> without changes. The x86_64 allmodconfig kernel and modules built without
> warnings with WERROR enabled.
>
> Could you please queue these commits for 6.6.y?
>
>   0f022d32c3eca477fbf79a205243a6123ed0fe11 (CVE-2024-27010)
>     net/sched: Fix mirred deadlock on device recursion
>   d7f01649f4eaf1878472d3d3f480ae1e50d98f6c (CVE-2024-39478)
>     crypto: starfive - Do not free stack buffer
>   d48e1dea3931de64c26717adc2b89743c7ab6594 (CVE-2024-50225)
>     btrfs: fix error propagation of split bios
>   dbc30a57bd8e026995e9fa8e8c31cffd18542c01 (CVE-2026-64070)
>     powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Queued the mirred deadlock fix and its noop_qdisc owner follow-up, the
starfive fix, and the hv-gpci fix for 6.6.y (the hv-gpci fix also went
to 6.18.y and 6.12.y). Dropped the btrfs one as it doesn't build on 6.6
riscv.

-- 
Thanks,
Sasha
