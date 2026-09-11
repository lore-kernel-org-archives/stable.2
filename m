Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B4457E4C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125696; cv=none; b=TcFYiYmxZaGzkkNoDWPD7bHBYA+9Bu7GXgBfvodPW5HnU4xe9cCcRSCZSwOpIOC0xj6VlmEvnGPFdlLd+APWUMcy11vZrYyD3bMOC+qT4x8kdPc5ZxRqsOnLh2ju6HsGS5Etzd6T1GQd5CCciH2vQcAKATB2WXwFZ6AN8Xn9+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125696; c=relaxed/simple;
	bh=2M6ET3enCJoxL0cu/aQGFHXk6j5bII/e2eZERtvpNbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVJhDUZHn+jca5vQ9tOMwLhvMcv0NNITGX9/+rjTVenC+zGDtcPozR/0UyzgkRo+BT5+FoNpUrbe96RMqY3ysZo4z3c/TUVCqDsOdgPmoiUlvG6OOpWm0HzQecAtLHb28hqf0MP7kgkJCZfydD/2/ytJT4+8ltR4vHn0dGky/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfCexNw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfCexNw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EB1F000FF;
	Fri, 11 Sep 2026 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125690;
	bh=31aDyKlLwas57gyTB/BvEWRjjsOpuBSPhyWDOTaDasA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfCexNw3OqNQ75/zC4xa8gK2bQ5iNLInbOGp/T82MhEiXFqwSgLssigK947nTIKjH
	 HKiYc7wMJTQm6Tcp4TolUxBM+a30GDtv5bDdGncXWJdlRGCb/gseE86b6Vo2Oo5i+J
	 crKe6nbg1k9Ul2YlQVUDiHXc5E0p4Dw/ADnjRQFqa9yvyVljMJVCjgHqyYEcpDWasr
	 jZtNR4XnxYxtK6H6/JIEGOpjQMniGVlEjHIRWAznDqC6KFYrQ24QX6kumS4exO+0vY
	 Om339zZAWaxY+ZpsR06to0mxGbI+m3BrWdXnXs5iWbLFmAuLOFnw9riMGXapsHTMer
	 Wsurz6cLwl+yQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 6.1.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Fri, 11 Sep 2026 07:20:51 -0400
Message-ID: <daily-reply-0032-re-clk-meson-gxbb-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072518.322125-1-jbrunet@baylibre.com>
References: <20260910072518.322125-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The following out-of-bounds read has been observed by Christian on a
> GXBB WeTek Hub:

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
