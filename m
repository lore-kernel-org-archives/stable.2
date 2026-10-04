Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF4339719;
	Sun,  4 Oct 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131424; cv=none; b=RjS7VhywKNKkn7lrlFZAn0CIVXYvFzSgqCxjffWGZxd8U39AIaIXTZACRmC2qNg6uU0c2AzHgbAzjXX+Bea87ErYDkzUM6BBjd37CUmiQQWqEANcGcKRSiUQNs/j2y4pdKylCWFzmxjSdTGM1tVkHeXc+L0LkJQiMlgIdMcsQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131424; c=relaxed/simple;
	bh=z21mwh4hWsZV8xYmF7gftACzk4ugTfFteRg9uhx5Mq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOCX+lHZqbgTNHr5YuNNbOH3yoIOnxijBIr0bC99va+yIJjj1IIbS66I3P12jx2py7Y7KL9bo9JP6i3vhpaLSCd4qCaiAQPuJ7Ga8jIm2FZZYoX1LcH1+7zcCF7npNjjUbvxMBhX/AB0RangFCf35y30+0htbLW0HzuaTVe7owU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHJMY7Tv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHJMY7Tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487071F000FF;
	Sun,  4 Oct 2026 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131422;
	bh=TOhpHzRRGAK71CrDI/fuQj76b+OuTtOAwfdFRFK1FaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cHJMY7TvyxDUgUeZ45tr0jgJA9w28OSimD61i/joOpl2G6z6rz6oWIOvMgngJdOnG
	 tazVHcsDd1BF6ynqfgmHd+IM53THOE2GMqT/Nb/aiUVSj3pTxnJhVCcrg2KaKI73wg
	 obDNB2ErIVCv59sA+4jKwBi/i6wItmXsWx6EnOMBPeyD/5j2NkP/xQD0TfxRToQuPY
	 MssyYOxRKHJxjPLPmvEpT4Q9l3iHY3aNMfFOvpgv+RXkevpQauna2Bl5Nd7SZP27pI
	 MvtXC9ZFrFoBrBvG6IeiYZtWwcjQKVVdNC5YDuCBjf3G051VyM3ij+uOSlndxHVcXb
	 co3Rmh9FX5HqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.6.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sun,  4 Oct 2026 12:29:48 -0400
Message-ID: <2026-10-04-1-daily-reply-0010-damon-adjust-quota-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003154818.24786-1-sj@kernel.org>
References: <20261003154818.24786-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature.  Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
