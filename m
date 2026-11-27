Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798935;
	b=4qC3puo4bF6skHeiAYVLgHFH9GQmvtsXMyBTe9O5aI2k/11gC9YPMMSxvBJJLwD/xy/Y
	 0V5RWKzNmOlgeIF7ID2ttJ7e7pjNAYQKUhTscv38SirnfBJ4isPzhgFBqY0l0AW0RumD5
	 vKtJCHN09hOTJmB58bxjNptDCSmggDNFS6wQ+4oDxMHL9yhcbfwtifPRmTYppXFGvnwGI
	 cz+eZpuSsq6Wz3ewjshYWDGPjcu/1cBUQuYC55LhqJ6YIMZ8yWc67FmaoZ/f0bvngsJmp
	 Pd8m2GD6wgeMj3lanhIw3ecmEFPrJjAIBpTmSS++lYUm386HfBLUQTdrlkeef5W0QZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FZpAunXJ0cmmYacjL5dn4R49Yj4BqxThYEfcEHgP5Dk=;
	b=1MQg+ig1iXljgHcwLnUJ+ONjeHGp8/8dmmeLWKfwrIbAyuBniQlHIFhcnGfU1HnuX+OK
	 MkcGeni5PGU1gbuika3Xixd2I+vzFrE3NZAqL4DnYfujZ7NzfZTFtBdgVTZ6vRk8MNSDu
	 Lpo30+eZF/8zhFOnxI57CbR9lq3KzZqf6WCAdUw55qA/Q6f5ShnktzoHf/R0RTNGOzW6t
	 Kr3+iZrYVPyfvPlSu2UXDzSbN0VDwAZ9IOifU5yICzgRxpnKrkqg+RhzAjP/h0luiZ0oJ
	 CEA9gT9biMR2GBfqALbGH2bq7cW1WQFMYEwOgpBfZi5cWJjd3Ebk6Zc7fhYGVs4/VZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vgan3g6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6F606A691
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vgan3g6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A971F0092C;
	Fri, 27 Nov 2026 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798934;
	bh=FZpAunXJ0cmmYacjL5dn4R49Yj4BqxThYEfcEHgP5Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vgan3g6AinB6TV70/WQm9TkqPv+aX7XacROoh2QpFj2ipSjzudkuS8tQB6CaxeoOu
	 BqpXFLKYRPz6NbWR5whqy37fcWpBVSDcWWE7bAKH0VDfpIyLCTKAIq9q+15e3NBI8i
	 D5USKeDk2mdm2VFGFzL4U5QUR5MXN6ysvT+sffJ1Fz3HSOjtE/Lvy9G3cWu5jFbtzU
	 JJZ1zNAOa1698/Q3lHMH28kuVKONMLGmB2i0fny7TiYJ7tRouy6LlL6JktIPYIagw3
	 v88pnkj3irwD9m8PDji5xe+AHWL33XG/pW4tDwWiQW48vttWXbHXaKfDzh3k/1oOkP
	 /+c/PKcuSSevQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Bundschuh <mkbund@amazon.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 6.12.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Fri, 27 Nov 2026 12:01:12 -0500
Message-ID: <2026-11-26-1-daily-reply-0024@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125212602.1324983-1-mkbund@amazon.com>
References: <20261125212602.1324983-1-mkbund@amazon.com>
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

> If the device underlying a zoned target is removed, its capacity is set
> to 0 and blkdev_report_zones() returns 0 without reporting any zones.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
