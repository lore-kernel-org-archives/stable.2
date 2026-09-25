Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164C3DC4AE;
	Fri, 25 Sep 2026 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362120; cv=none; b=ChVZ/Qhr67cBIkKqKiWw9TpOErNLBEO8bss+BH8DpkKIIvVyNwS0mkC3WI+OCQl09EhWSU9ricgfH6PTS9PBbZGXnhy9Cs/l6WwmBDa3mPWw2bwUwx5iHhOu41L8waVxVTosYBqPWc8lKiOYKKw7RTsrFXIudUbiIPqTUHyIe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362120; c=relaxed/simple;
	bh=+PXrbTr9W3WMI4KWWlThGDbxJqHXIc0ukPT+qhY7mAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldx3WeuYECAgEKGja+wGgZ+pFZOa9iJFakhSxPInaXjaN23mmntHuxVAmojK43kLNBaRhMhAzS+JK53et1TbqVZ6IFLsVE/UlVt23EmYPpktGEJeYoTMpTejuiWO23hUOBwOsYhhS5AGGf2NzfZInCxnHsu3/nbcsAfVDi+HjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeEdSaNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeEdSaNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C508B1F000FF;
	Fri, 25 Sep 2026 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362115;
	bh=WrgWRdYmbvngJuego1CL3y0Q6XgtgwKTem8e626V37s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JeEdSaNSef922NokpeOobJ0BVHhX7Dvt1FQDeZ05iBGsjwIVL4b0Hlq70n6Pc/hJf
	 +hKDFnRaa8RO9EbNVnuo2vjAqhcVAjB2/YBgZNbXGSVnUU2H80Euds/ktKZQVLqGQ2
	 cCXPK7OwhhMNrb5g8dyNnJuSAO0T/oIC4dYU79Z3rNvDgS08SsvU8ho63HNIT8yaJ7
	 ZWf8KDXr+B+vSWdXOYMkLoCRi4932bgbQ3AM+QzmKfvrTyTs3gcKrzbObFJDDZYJv4
	 M+8RNUfInHPoiIuO+9BERi0OCQDQ1qUd0W6wRQbEw3vFfNtdMjR2hR/+5CRweYR4w3
	 H5zEFeJW0B3PA==
From: Sasha Levin <sashal@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 6.1.y] erofs: Fix detection of atomic context
Date: Fri, 25 Sep 2026 14:48:05 -0400
Message-ID: <2026-09-25-daily-reply-0013-re-erofs-atomic-context-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arYacJ7KdcTO7UDQ@MacBookPro.fritz.box>
References: <20260922200448.27724-1-artem@trailofbits.com> <arSoAUX4jDzgY-rG@MacBookPro.fritz.box> <2026-09-24-daily-reply-0004-re-erofs-atomic-context-follow-up@kernel.org> <arYacJ7KdcTO7UDQ@MacBookPro.fritz.box>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> btw, just correct a bit 5.15.y also has commit 648f2de053a8 ("erofs: use
> workqueue decompression for atomic contexts only"), so
>
> upstream commit 12d0a24afd9e ("erofs: Fix detection of atomic context")
> upstream commit c99fab6e80b7 ("erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC")
>
> are also needed for 5.15.y.

Right, both are already queued for 5.15 (and for 6.1).

-- 
Thanks,
Sasha
