Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50483C3443;
	Sun,  4 Oct 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131404; cv=none; b=o8LQTI1D/BRMZlvSTbXkf9436yvcsa+7nXAgV6BGyi64Lc/GqhVe32eTOU3sed8LoJVt+dSX0/2V9ZaHieHzH4cBAPJ9gx747dhPMWM80EWkxp81jDt0EiTGZUcARKrnshxwmsGqM51a10OOw76vO6/PzgzxyJcXsQGBxVMpTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131404; c=relaxed/simple;
	bh=w/6AvkHm1eUPp5fcJ+l4F6yi+c6XlH7/Dklw/cXw9R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz0VBxrbCSyEtq+t3BYGve8tYMq6iwAROgg3KoZCG7YTVsE8Ma13YfOmDlMmj9CjztMkpsPejmZFMqAyPhaCY5fr6VGthIiDD4fPLfNrIcuEC50Ovjz8AEae+BLi1zHtpSs0XdG+KAnMPDlg81mlSyVWmVn0NkYo5eVaRUoe++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n78pJipv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n78pJipv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD661F00893;
	Sun,  4 Oct 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131403;
	bh=EFrMYW3fMwQxhOv8HCPif+Dcyo6/fkWlqXW0pzGXkYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n78pJipvNsTlRvChSgAUK4AQBnDSXuaCwEFf3swhAS8XELbgn98Z0DUrj2RDsl7s9
	 8t6szmDAp+RadseWGxuouxuabkCKN7SiU2nROTT49eT+sblzbGIajd/K8E0y/fuV0S
	 pDTHOc4SpKfReU1pGZAcwqRSU3pSUVVEx3g610v3baOB0IFK9QmBSId8Hs0Iv63Fwd
	 V7/l3dRLHUdkyivZJG65bSUB1VwZ/7mbpYyjCHqQj99D4cI6ztUo7Y9tX7Ujy+MpmA
	 oYUsoi8ntVMqq6Ol+r7/VE/cTuRJ+hG528hb2mrEY2MAkSghNeRTQr6mwZ7ecfEMWp
	 BdtXbe09p9y1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	penguin-kernel@I-love.SAKURA.ne.jp,
	linux-perf-users@vger.kernel.org,
	vineash <vineash30640@gmail.com>
Subject: Re: Request to backport "perf/core: Fix WARN in perf_sigtrap()" to 6.12.y, 6.6.y, 6.1.y and 5.15.y
Date: Sun,  4 Oct 2026 12:29:40 -0400
Message-ID: <2026-10-04-1-daily-reply-0002-perf-sigtrap-warn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179105913174.1859134.5466929391582828993@gmail.com>
References: <179105913174.1859134.5466929391582828993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider backporting the following upstream commit to the 6.12.y,
> 6.6.y, 6.1.y and 5.15.y stable trees:
>
>   3da6bb419750 ("perf/core: Fix WARN in perf_sigtrap()")

Queued for 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
