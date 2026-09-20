Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E20472520;
	Sun, 20 Sep 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926665; cv=none; b=ueaLRGt0n9p2+zstOLB7AL40WMfdsUkDoz4bWtEwguwt+GncWaFKEi0iJrJ+hl5ePUe+nge3hY7+NI4avjSmMl8Dl5sv/hvpuDXgMpnJ9UY0DsUUX2tHSIz9273CNA4pMhKzz6TsTrf932gBDP0NOZ6DzwZXS32hbztz8iBPvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926665; c=relaxed/simple;
	bh=3QvSPWIbvJRfBI2KJAUuR0allRS2f1zcnaKS9heRVCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1QvcVFK9q3RPzWvozjYHrwee9bOSnPIn5i5AnjW5GgiKkFSK3aUypN12lpDERtrdTm5X/mkmECoAFb72nHrurySEqJo1hr5ooYUn6fPz2pZoYq/DqOtAR6P/KdmEwGET1uOD1+gSaU3riV7tXuwamKZrYmOryZHRJDCPUJIW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbFynyQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbFynyQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB601F00893;
	Sun, 20 Sep 2026 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926664;
	bh=JkiK1l40zgx8qead8nkgW71sHetsJh5WyduFCv696Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbFynyQz8Y7/IWtRsTpRjO3/Bd5/MSvrhnTtGcNz6flEzP+pP1nGMywTMqfPQ0HDZ
	 PWjbbgAvE65XEcTYAc/2xHvGpJAA5Ex/6f9YDa7/eCDQJwjAWB+ebKi9W6PHHtIQ+z
	 q815twKUOboO3h3b0mFOEZsu4DWhwyfCsyHDhVGnz4gFpVIV1ukpiAOYeyhY5AdFU8
	 t71zgudjHX2jyr0mieG1dHrXzNeAtV2GVsZEFqpd5DMA9CvMNRkvQD7uGnrp4aM38w
	 QXNSoJ2S30W0cbzV/U1SVMYNTAbnlFwy+wDHgg1q8M1H386GV+gnfdivsFcrd2/655
	 1ojs6OfQZNxgw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	matthew.leach@collabora.com,
	superm1@kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	David Lomas <david.s.lomas@gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image() after freeze prepare
Date: Sun, 20 Sep 2026 13:50:43 -0400
Message-ID: <2026-09-20-daily-reply-0011-re-hibernate-preallocate-deadlock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
References: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>   task:systemd-sleep   state:D pid:36677
>    throttle_direct_reclaim+0x358/0x3e0
>    try_to_free_pages+0xbf/0x220
>    preallocate_image_memory+0x35/0x9b
>    hibernate_preallocate_memory+0x25b/0x390
>    hibernation_snapshot+0xc1/0x4e0

Rafael, Matthew: there is no fix or revert in mainline, and 7.2 has the
commit in its base release, so 7.2.y users keep the hang whatever the
stable queues do. Should the ordering go back, or should the hibernation
task bypass the pfmemalloc throttle?

The commit has no Fixes: and no Cc: stable, so nothing is lost by
holding it out of 6.18.y until that is settled.

-- 
Thanks,
Sasha
