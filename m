Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12A2E401
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974486; cv=none; b=LtynP3Hth6EeGEQYzfiW4biQ+Ug7KtYbPVjRsXUNF7FoJ35hDAuDwnvSjmWLIwdfjnuSnb5X6ngeJS61TZJN9yL4tbqoE91ZilYd24qGYL/vyuwl4ojTEOp997Yz01Qp2V2VpMfZBU7UTlnTZoRglsusWsbzIYl/BLVtEhAIiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974486; c=relaxed/simple;
	bh=DKnNfUTcs2/GrH/6mxjDITgJcKC8sJ6civs2vZjGZ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4e4YLMbXM4Tk2deBzbClLmDspEgmDDWBI8A9w93apEirX1N7sj0BFZBCbRDV7X5ds+d1+9OJ4MQc5xVR9YfnTwFClzHmUnsultnTTtCDNZHPz/NnUiRtC2sqRtnHbmvsYokg7H/kbKoHT2CCD6NieefZkrM3oWuoumlfwoz4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op+xYtyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op+xYtyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743301F000E9;
	Sat, 29 Aug 2026 03:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974485;
	bh=AZJWn7GVJ/iviRGAPjhH0SXCL/93mSrWHjGu2VHL5KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=op+xYtyoYawh/PKfMh+pP02YYvhHqteZ3U5tY2Deu0ilXG7Uozohs0skjz0klOyGO
	 MzVGS5iUw0U7C0QOkPRO/zFv3PSs7oUxxGYLhluaUf3GmIF6briCWDxsTtueRCDOWO
	 5PqAr1hzKduTXxKXh0UeCg9fDazpqchHKvBPBZUr2uAzy9OPzYVKfXSUh+lR9DEVWT
	 dmqabriJO4ZnE1+d/zzseBlhSJXRQOU9p81H8E/VOahXjTpFRta9r0zS8mC7BgnSrB
	 oiiC6ZACHqKR3+yqD0ciBPaKCaiDa6Rs1eK3W5Q3SErWj7Qv/vO7RhrVgQP7Oy5rRJ
	 APNo9c8OgQkhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: Re: [PATCH 6.12.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:32 -0400
Message-ID: <20260828-stable-daily-0001-nvme-tcp-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222015.45415-1-carlos.bilbao@kernel.org>
References: <20260827222015.45415-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.
>
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
