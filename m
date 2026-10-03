Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908338DC74;
	Sat,  3 Oct 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067207; cv=none; b=ldNeR774D7CYM7FZEk2eAXFklI1gGEgqA+nev81p0Uj1Z2oJDOcjSls1LbEAfdaXqj6Hr/4ZKGf2MhWqt9x5eapsTmQqk8uLZ9RXydIpR4pdhh3+jrqUG20WwjlTdNlzGpGIImOpkhUDNEcNZqV+Bs57QYid7MS3d71ieKeQy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067207; c=relaxed/simple;
	bh=dwLgRddozJuphK4t6xH+tSCA3BdgH+Lnqx1fz+9XCQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeT9gN146ADP7VJQ6yqYNVnT95dA9WZ5qBvn4UTP0ByWa7Z9wQpyjZ1u/7TlapSWk1aUA/7YzwntYrJVsLca4ILVrdaLIYRqlo1UCf+1tVjgnuPF1EpxBsIGulDpp60Vz7NZS9GIKDiUtUZoiYndWP3tE2s1yoDeGU1cM5S6uBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3WDAGnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3WDAGnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1991F0089B;
	Sat,  3 Oct 2026 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067206;
	bh=Q8MeU89wcR1F3Q/A0tK1tn1RvHdQqhCgRtFNHu+sOdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3WDAGnI9Lw+UgNeDqI5ja0zj9FSFrLzRroxMtd4X87xTibBEZh8/mxbMaINZvfUN
	 b+O1Giu/i1cbKE+cdoWGxd4xmuXS/+LA8mawZFb8L4A+9KpFugp7qP6cK+mcRZ1JcN
	 EqNRmufXEAuM21bkNXM3TfLSOmsmzFhWy3bQKAYrW73vd0kUKvY26xhG/o1TJ6aHvl
	 AXLZy3yuRG92uXTqDotMuwX22w7THSaD2Q2/QlcFwqrX8nQaQyGWqF3i+ELfuDK+L4
	 Wfsou2i+VOunaAAKf2WLZk2ToEaWDvHEx5LwtnaQRd6jbSfRTTKxtkwIpvOiYA3LOu
	 j0hC8wiQuOjUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] nvme-fabrics: use reserved tag for reg read/write command
Date: Sat,  3 Oct 2026 18:33:07 -0400
Message-ID: <2026-10-03-1-daily-reply-0026-re-nvme-fabrics-reserved-tag-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002204646.26451-1-artem@trailofbits.com>
References: <20261002204646.26451-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

Queued for 6.1, thanks. I moved the backport note below Keith's Signed-off-by,
as Harshit suggested.

-- 
Thanks,
Sasha
