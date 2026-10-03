Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F722230BE9;
	Sat,  3 Oct 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066966; cv=none; b=EhwS2HXn+uge8fgp00AcFKbUG2gZEzB7+fqOrajMcl21isYX+SMtUYx40ZK6+YprIo5pd1CpaMEtS6ebBA+6SJTcil74ZqYBqZmOjUJfNMBEJpSIuzgIrizIxiNHXGQTWBy5bYKQZO+pHeef/ZHcwtx2iUcAu7jrV0qDdq8TLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066966; c=relaxed/simple;
	bh=FiV+xu1C7b70EtQEOfds+BccAQIG9gjIOxAPQxnvK2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuKyO4FY14WcDQzyHDaTau5/CUmMTM7XbYfk+I7+pdreBmccmcubGBg+BRZn09ZvFY/c2jNs4u9aVeJqD4UTkSY71T1K5c2GwwwaiglNUJbn297KC5t9rexM92bPuP59A8kR4jDKkNgc7TUDpWAYaVBjgr7QmowEmRmiSadlhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OulOAhDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OulOAhDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5782D1F0089B;
	Sat,  3 Oct 2026 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066965;
	bh=v3g2qz2DSkLclrr1clLWyfKHSWifm64yOVatxLf2c7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OulOAhDRCo3XQw5jalaR+BhTF0V1smWmcq38FFayTjjIsx8Pg9BMHAMjKwmgX23to
	 Fl1/JXEfF+/5LTRkc3Y5XVo1qW48wxEw3RbUqSZKryZ6tnz5tw+bCKxdsbORtL5VpI
	 BLUZQBm0HnOdCKLnUtULprfKqpF6t5/0cGrMsh7PppqDP+TLmy2a5lk9JY8xbfyi7i
	 wPnS9zuvvgV8/g2mtrHAUe5hl9oiu54br57pOYpaAvPT5LcyzMZ0OcIV6swJJxS7f+
	 VpOZWbbd9Lif4hk1kARF+4Kdd0u0JSGj2e0/I+2xlEevnNjw2pJQdKpUSbAAekROjp
	 PHrzem6M6QmzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.1.y] net: ena: Add validation for completion descriptors consistency
Date: Sat,  3 Oct 2026 18:32:52 -0400
Message-ID: <2026-10-03-1-daily-reply-0011-re-ena-completion-descriptors-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002204534.26297-1-artem@trailofbits.com>
References: <20261002204534.26297-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7 ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
