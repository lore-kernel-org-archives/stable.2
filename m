Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06627355803;
	Tue,  1 Sep 2026 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225718; cv=none; b=tE396gHv9yGxLo/FKjr8rt9MHlzn9B54PnJwHqyDhrT+pOZ+AQpBhwDrHWUObkz0+pXj6J02Qo7v6Eow6sAKFrTkLUaYcIFewNW/xXqJEJLuy3pWP7g0dbkqmN0XsoM8+nUOq8907bOVAfGcsQyD75oXZW0ijCyec7z0xLaI3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225718; c=relaxed/simple;
	bh=cB89cDMEEqDThPkLnO84NeMoAsdM/l0LNXFdQfBzY94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRnLcMukgr+YdNWcFcBY5YQ3CQXTqzA0G0PWBJpWj94TlsYe5gWGoa2yFVLf9uTO//wVe/+EUgCZKG4m4sELa+M/CaOQnHLKH/9B03L45rhxs4zOIazRFv24fH3MTpLueVhNcJxyWLR5SB8G7DIztxBm2gsmii2aE2uQkzxUYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrYZkVU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrYZkVU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FF31F00A3F;
	Tue,  1 Sep 2026 01:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225716;
	bh=QBdUVaXmnsficgyAZ6a/uotxS9hvkMAlUvTvgvoTIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrYZkVU8GXUY3oKmWLqdUGt/YfpBXqQVfk+KQz8tr5TRgjvYQ4ND1evUU2DXd/nVq
	 A/DCSB5TAw/RedREy/u3j8nbAq0sO8/ZZzpPSSqn7SU3OnuDCyMgULmKvC++cjHS14
	 eSrbDTDD8FEJL92Ts+L7yRg+8eYRRU8vhfjhfT0GJNwckMNi/EnDEu7zMZMbGICzTa
	 e3dc5wTerx36exknn4Grag84aJNXO8SX201WSrghffU/eBXyK4dkmN9Y621bf8FQfU
	 7bUcYtOZv+c0zb7ZsBgmgRYxIED8yJAGpnb3iuKzZAvgwb+Lx2ir0MvfbI431kAc+c
	 caVV12LGRLe4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: Re: [PATCH 6.6.y v2] Revert "arm64: mm: Don't remap pgtables for allocate vs populate"
Date: Mon, 31 Aug 2026 21:21:46 -0400
Message-ID: <20260831-daily-reply-0002-arm64-idmap-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831152906.7000-1-kmehltretter@gmail.com>
References: <20260831152906.7000-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit 54322d95309d9aa4cb77b34ee4b6c8b541f3e21f.
>
> The 6.6.y backport removes the clearing performed by
> early_pgtable_alloc(). Its replacement clears allocations made by the
> generic page-table walkers, but 6.6's create_idmap() still allocates an
> extra root level directly when a sub-48-bit VA kernel is loaded
> sufficiently high in physical memory.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
