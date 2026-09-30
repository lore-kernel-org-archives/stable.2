Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA73546D0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758184; cv=none; b=exRX2VkrnC3Ix2uE5k011ArCrlUJFuxr3mrHibA4sDqIkZDXo7IvY/7taUOKiGZ/7aNtu5wVgQl7PURbiCznMzjv0rrB4uIPmpK//vrYtzHeAaboPBB7agTe9UoHCm2Lk/YfXPxypz8senPvWE/7Rr2HyrhtQ9A1xLrBCODE/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758184; c=relaxed/simple;
	bh=di4BZpr4iyJoFPd11E/eCFy183nA6wGksnOAfr3FRLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfwWVSODzIIJlqusx9S+tBzoqWcuEn1srjyKH0lVmejAxWc+DBRHStwU1ih5ewILWh04zUxSCg4i3lNsE4vglP3O3Y8T3Vp+jfGRYPKreWCtg/hN3da2dgq+gAYD9thtCyywf73mQxbWioBR+LTaWn/8j2P/1+g8dTX5YX7nkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN9yblSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN9yblSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D461F000FF;
	Wed, 30 Sep 2026 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790758183;
	bh=UuO8ixk7+EzReG8y1ezb9hLXfBqKU5xbROZuLNwlwW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WN9yblSgO72cW6BRqdnoVviYsvWHVYyf/wV4taWI0yfZYZJu/iCVaYSr6WrSR2WZN
	 WTTGslsx0Pu/s2js/FNrnu8FVkpYKvidgXgxpIF+47kzeVNRWDkYSS8WnHfUZYEBF6
	 xiJJzKrK9TBzWwmi5ZrC0sXkoRFvR18eUMw4sbkG2dcSHcPytAylhOE+jlNdm5Amqn
	 aet9SPQWLid8ihGxhwasVskmUvZr5opq8224V+XC7ZRmq+No3JrvSUQrODRyAh1laY
	 6wQlbiBruT7MjYhcoZNREl+p9a3ML+YmfsLQluWvWvzvMAGe59Ds3qP4sjkJUKOBc3
	 //N6sB5Vtrvvg==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 2/2] mm/damon/core: allow esz to be set to zero
Date: Wed, 30 Sep 2026 01:49:38 -0700
Message-ID: <20260930084939.14133-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930000401.2861657-2-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sasha,

On Tue, 29 Sep 2026 20:04:01 -0400 Sasha Levin <sashal@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
> [ Upstream commit 90179da203ba8b708c84a12a07cd44be0f346334 ]
> 
> When the temporal quota goal tuner determines that the goal has been
> achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> zero.  However, damos_set_effective_quota() clamps the esz to
> min_region_sz when quota->ms is set.
> 
> This is a minor issue, the main problem is that it doesn't match the
> description in the documentation, which state that if the goal has already
> been [over-]achieved, the quota will be set to zero.
> 
> Fix this by set quota (esz) as minimum as possible.

Thank you for doing this backport.

> 
> Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")

However, this patch also depends on temporal tuner feature, which was
introduced by 7.1.  It is not in <7.1 stable kernels.  So this patch shouldn't
be applied on those, including 6.12.y.  Could you please drop this patch?


Thanks,
SJ

[...]
