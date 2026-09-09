Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034293EC830;
	Wed,  9 Sep 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985613; cv=none; b=OCopLOJN73Bt+orOySN5+AP+IK3w1dupCIjyqQCYQK4S2a565SI5GOvv+hb+wUOaddwt0jAFkF3nXWF763gh0MZauJ3MK7EkBVcMqjnAynJhnI1J2sS2j+Szqz2oKHyne8FLAhINwoT3b/Ktenw+bEFyKypnexzlPcjutj7yYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985613; c=relaxed/simple;
	bh=7pDDt2N4a+ziKc2tkajQ4icNjTzsSSvYMDzTgrBlLg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb9W31ILLdy8CZfmfWXHz9k8EBv/THzCuQH1B6lBkjGQtEF9LbVKQUGU3QEA79iT7clcmb+SQEZk3V+9Mlca8CS/2SQfs8I9ONg12l8DuHLlgvgFO2LryCTpPj3ia+3f2DS7t8xo1giH2aaF/i6MHDC0rTYxUsEBbkCU43G5ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc5Wj0Ge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc5Wj0Ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BB1F00899;
	Wed,  9 Sep 2026 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985606;
	bh=JzKodSS4g/oSWoPyJcTa/ur3Qnr1aqXhjbX+d9OKJbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mc5Wj0Ge9Y2LH9DDB4J48Bghhs6cWAo2APbU7xzi9tdtzRlS9rR9ca9lbWmSXG+jo
	 tjxLFT6h5C/PPgcs67H8uGepO3Wn9eT3c7R5FIk5beq+ogga9VpX97qp7Zky9jFfX2
	 LTRYP2xuRSGfya2H6E9f37xEQocw6CAyuWG19uoxeHRLML73vwfXrY2T4H7AxZKtvi
	 FU0/HilQtSBgiAqRWu3Jm5K7/RiZ0oeHZJwJsxmzrvPju/sz9uADB/LV/XHHyr73rY
	 Zeec+ngQDy/AjEdq72ZsMOztZkSaVZwHsUUM28ptdFEgT2wGg6kGzEpxLAl8d+YtB1
	 9muql7K2Ely8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Wed,  9 Sep 2026 16:26:10 -0400
Message-ID: <2026-09-09-daily-reply-0012-damon-vaddr-drop-optim-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909060736.273661-1-sj@kernel.org>
References: <20260909060736.273661-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
