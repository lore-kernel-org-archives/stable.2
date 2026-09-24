Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916492E737D;
	Thu, 24 Sep 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209282; cv=none; b=AFJxpRxUzvOtZ4Oh2SB4W1dEfFHSWEeHcvepHLPt6q+kx6U9ovreMY5I/LyaXBnFbB/THgtN8+5avccY+N9vQz691DKszkr85rggfNHUoDYbPa7GSwnz/AAx/c6hhZQncFsw9QCZuRH0Aydy1SLSn0AlfXNd+WyGYfBL0wl0988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209282; c=relaxed/simple;
	bh=HXnR1i6E9HNNLKqyqdlglybXR5E08kAolT67YwXCi9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWL1crmjjNUqshpYRPlL2e2KQKbUK2CdA4sKKV6IMaoYmvkHjR9kclWx8dfoiJWIfCcbWH+sM0kPn2ltIhIFjxxeV3eDRnIU++tt/QjZIzgj2PtMQYx5dnbe8mtY20ldxmrkmbi1HUgnjyICc8uPlQqJ5GV98yY2QB0+0BqqhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzQSwC+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzQSwC+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6D51F00893;
	Thu, 24 Sep 2026 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209279;
	bh=m+GWLIwFpPKVB13qnLI5Bw0feO/05wfn2yVZo+nfxu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzQSwC+wFeBtS3T3yLqWeaGdao287ksBdEwlubwx+JX5xLwQLvUNZ+EawYWmxUD/4
	 JCcKYmkiwPbIa3FOtjrOz2R5CUcohmmLZm+DWVynYrMzbY8uimDb8mvqGV/QVGyq9h
	 VjAZEcj2bFnzbkp8VGW/DQqAzI/9sVwQFNt6lzMzyUwQRCsIdtF2CmBOiXtzFy8C/4
	 J01wkM60/5ReUW5kEWssq2IHUpnzyuwHfQQ59DiwQHPOXPiSuRzbFLzpJgDf7xRtk8
	 qEJsmypvEI7V8fZxr4jx7Ey/Iy124DamTXLiPtz8nwUbAsG6/E2XyiJ1iPdGjUphpd
	 xB9qG+32pzRoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gao Xiang <xiang@kernel.org>,
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
Date: Wed, 23 Sep 2026 20:21:00 -0400
Message-ID: <2026-09-23-daily-reply-0011-re-erofs-atomic-context-detection-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922200448.27724-1-artem@trailofbits.com>
References: <20260922200448.27724-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: the source change is unchanged; only its location
>   in z_erofs_decompress_kickoff() differs. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
