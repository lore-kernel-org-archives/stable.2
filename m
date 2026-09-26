Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779573E49E9
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436443; cv=none; b=Zcmyz9VtmWwoDwlrwnHd9qW2YeGI7TR9hBeu2NBB22pDd8xcluWDHcor18smn0KNl4Ea41jfeMTg5uzyoUDFnUCweeNqv1fH9g2r+84ElIn55wLsc/mY8l8B36E3RPX86t0aqHzxNhQZJIlGxnD3RQoiiUNDF8gPGXKE7KkWraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436443; c=relaxed/simple;
	bh=zgPpf7OqnpkuMnOh9Qa6R3mFbSYt16BXuCuYF6yO4Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTvSxAFYbJhhYq37LP2djIRSmOs4euNPbdl/AWvebeBhx7tPYSTjv09NzsnMKyqq2zPFGIEvsnor3E1cL+8s3coU8BgPkCmaMmFc72BW4QNwV9ws0dctmGQ2Jjyx1ac6AuycqE3CvSw+mk9RALuitTVJU2QLIdg+TUweAg+P9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAviHidu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAviHidu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1A1F00893;
	Sat, 26 Sep 2026 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436440;
	bh=04to+TVVfoOrHJIL6X5+BPZDQZ+lENHPmzZeCXpSsfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAviHiduudw6D6dK3grk6WkhY3STeJIL7mlmCES5zDaGNL5Ps1bS8ic314yaX00ET
	 M3xpDOMIBgitAaeSB/d2qBgLPdL0UuEpnuxVVAH3uRvGOyFJX5pIxQV7FAadJeEy8S
	 k3wxly0XDHDhGVr1Ko15vP/lWWY50uyOKDPfvRJWJHj8z3Mu5X0siVjyMGaH4W5hzI
	 WEReY9uPOVQ5Zejjv/oe3xSmKWNEEU4BGnQn+fFITlzdMlvJyOGWaitEn/+qOcE3ul
	 4L5he4noEOe4QEB/UBCcChcW8fpDXNaig3vPo+RQ38j/7tv6mawfgSuEslmU2SYDMa
	 NdSZdOOTTpf/g==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Sat, 26 Sep 2026 11:26:59 -0400
Message-ID: <2026-09-26-daily-reply-0006-re-hugetlb-avoid-reserve-subpool-ack-request@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926071811.77481-1-kmehltretter@gmail.com>
References: <2025021020-copper-visibly-e6a9@gregkh> <20260926071811.77481-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I copied stable, however I have no intention for backporting if it's not a
> clean cherry-pick, because private hugetlb mapping, and then fork() on top
> is too rare to hit.

Peter, Oscar: given the above, I'd like an ack before taking these.

Karl sent this for 6.6, 6.1, 5.15 and 5.10. None of them is a clean pick, but
the only differences are context lines and the older page/folio helper names,
and the result matches what 6.12 has carried since 6.12.14. Are you OK with
them going in? I'll queue all four if so.

-- 
Thanks,
Sasha
