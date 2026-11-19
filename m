Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104534;
	b=HSt6W4Z3PkwI/eDNK4wKMZjsGmMG0bxOLfkmKDjuDtJrcXqURe4wJXflQvWO/0AdWJQB
	 d56jrKrFVLorhcifniZH7rDnlGw/cXBIXzkCXSiBm3XQ3jKp/PJMzzOWpDZNlxOn5GCgL
	 AUsYrHMN/DyMgQmTPDPje8s20Lr6kbfUwqr4hJRF0gF33egdNM2BuSZJEuwtdXA31L0Nq
	 2rOPTYrsqrH0nQdbJc4O948ncureFt5V2TOvu17X38HYn4W++PVGhnQ9cqVKjcHytK/TE
	 zHLhAO3FO+PGe8a+6Ynos0FWI/5uLb6Th0R3tUb2BVeH7jVc+wZx0oju1l6XnfeJ5aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=35jWkan8QrkaPRylC5K3UpZbmQ+9UKIYCT6TBP0zgfY=;
	b=ZeG7c2iNy0V2+N7BUrm5cnK/7MVUCLkHbkerr1FeDfibh7UHPp+SaryBlsfhiRUpidQ3
	 4gV2/O7vUF9PVDIL9iwU6enYlZqOm0OGakC3lsGnzrvTQiB9yZRzBq5BWmsRgTfjmlKHN
	 oQ8X6vn8wQYTAhNndf700Rc3bhLrSvL1PiJSg2nWtOfvbpTIUvqH5BBxfuC+MAQ3DKYuu
	 AbTJnYx2jAKR61iSHjyY/fBXlPoBBwMGcsvnGYrxIdIr0J0SGy6CNtYgXfWyV7YFw35gh
	 yWALlFQqPb0xdtRCeBILI2Wc70i1s5Ie7lpYWkXwnAoXTA/I+pV0J7fZYxmhvPV0Dfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiH6vH4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAED606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiH6vH4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56A1F000C4;
	Thu, 19 Nov 2026 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104534;
	bh=35jWkan8QrkaPRylC5K3UpZbmQ+9UKIYCT6TBP0zgfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oiH6vH4VgQIOvtpHHgGAmuFqbu7lOn1HBh1/oeExEiXZA/utx48Qf2L59XNVegW0A
	 A73sp6EeDpaUY28rvgrupL87GNV+H0W29QlIhoKo8dQajLI6uYEGm3kSEnNlRS1Yh1
	 u6C8ZJQeKchbvFYkfsEfJdTwtuy1IpaKAK0FmMxGQ4Glwoyl337CKmivOMFQjD/7Gg
	 AA7l7OrTmO5bKBYZFzmJK60kXU8hSjVHPts14b/P8AHB32yqoCXpXw24ml7n9tQXOQ
	 kdZ8frzuB6MvYfmZt6YgDzWt1oSn3Ke38NqhCSxqkyQaZbyxWwgC8cms69f3wYRkIW
	 Dhhbpcr+KRWmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.15.y] net: ravb: Fix missing rtnl lock in suspend/resume path
Date: Thu, 19 Nov 2026 11:08:21 -0500
Message-ID: <2026-11-19-1-daily-reply-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1794982026-14518-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794982026-14518-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 2c2ebb2b49573e5f8726112ad06b1dffc3c9ea03 upstream.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
