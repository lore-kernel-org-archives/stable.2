Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31B2E401
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974489; cv=none; b=HYCK4+aVozxnjswD5HD1He4NZuGe7FCmwrv/160TtlJypsdmc+pyBKIjXjvxXJrZn5H7gHlOD+fcemliokhYislN9sH1wqAggFTIvZK+QsqT5hqOJ8c3+u2gOZfxGCyNIZM3G3pH1iPum0ZHCyRnlhc4l3lPZJ3zKbMrNIQTq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974489; c=relaxed/simple;
	bh=RpUWR7zgZrXoP0nu9byXNHNoj5YgR75HeKLJDfSkJfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aV6hEwAOn/++xHRZwKs77gyd/Ngzmaf8Gb8qW89/cc70XkRox+87McMW1Y00hkgXxHYPiCUfMvhNIX6Qsgettxng6zL9lPZ5Yq/t5H2gq02V+XG24rc/ZR5cxS6Kf0Lu761Nuk+smiZQEkoXDWR51wHtTGdd1+h0tkdoqoAcZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuH3aafQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuH3aafQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C9B1F000E9;
	Sat, 29 Aug 2026 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974488;
	bh=N79wN7YPixkdJkvEQMksfAjXEw5uADOn6KxuHnfXdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuH3aafQFcKm+Kd86TKeHQGnFTuZove8+IfrZhksPMFKsiH6MXlI0Oy9Zo8gHpJfz
	 LaIS4JJeRjjrsrbnO2qrBAHjlV0dvg1dxuakdQ+yQMQWWE8Fsl9fu5nzlqKyhLJ+sI
	 j1fr2mwfdslUtctKQwe/mTvqj/XGsUAE6PF52FU+3AtecepW6Mea1YyEsau1JUy4KR
	 KmYkMAqTHWrOXwpGI1H6FPLclATsUNRcQo30KNwUO0jR810LyyNq+MrkUySEjHLmHw
	 N6ldSoAPtH//h/MvG3sMV6qShNfoIkqeMFtTBjFZXyjLNMEKTHZ7Q/nKiK9zYv56TX
	 SZjeurQUlcR7w==
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
Subject: Re: [PATCH 7.1.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:34 -0400
Message-ID: <20260828-stable-daily-0003-nvme-tcp-7-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222024.45443-1-carlos.bilbao@kernel.org>
References: <20260827222024.45443-1-carlos.bilbao@kernel.org>
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

Queued for 7.1 and 7.2.

-- 
Thanks,
Sasha
