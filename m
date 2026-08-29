Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7E2E401
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974488; cv=none; b=sUzPpVC99iSpFtRPgbQXikTSMMzUwG+FY7SXTRzRR2f/w0327StKweL7/WxAY/wGPzaavUiYPoR/LFdJaffBVT1YvDlVfG5yu4E+ac8yGUhQ153mF+5d224/VcjjGSrld0XVLhdvmdj3tHYkHtf23LWD62o4Y+cCQaSz/6Ytcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974488; c=relaxed/simple;
	bh=VarCGy/8mB3uTN3FIRt3s1+k+ywV6Fk0E7UVKHQB+vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpAD1itv8a3/2DULj4IgHurdLX6ZGEwT4IV4QTS54Qm7139t8umltS25R3SzBwEhppul+dXtCWYEAHs0M9B+c2YSivYV+i9S/hqxh3bwlIrTQ5pL5+6Ri/dW3knLCyUdqCWirfDedxPixFruAVwOIOGSYz2pDQoZo5Dml0+91SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKNrdz92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKNrdz92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE461F00A3E;
	Sat, 29 Aug 2026 03:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974486;
	bh=QEyjoaZ4YFjTz4SvMH2FwGTjy4G9kfHjnURcu2krxnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKNrdz92hRUt5GwZfvog3RF/vTywz+sE0LZgnw39/XLuZRnXtn3bq9zN702zGcIvG
	 Mb0LHuL79lvasVe6LgONDUg/sSSgWcBXsxKlkz+Ex6eVKrQzcWNQnboggHlGEzD83n
	 yp0mV9Lha6uUIvFvq467r8s114/eleOk92vav5FPHmLKUxVpNaKB69YJ9dr5TPfoAh
	 oQRcnAw7XTgCb9mrQzzfT0fscBONNTHkNqTiikZ4aYisW3e71ylud86OciLIORrC69
	 X6rDxuNFOCZxHIKvm48nJLSik4Z+l3KZATenHh0d/pBkrQkas+aCc8+tfrGBmkKdWI
	 VJJ5GyRu+8/0Q==
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
Subject: Re: [PATCH 6.18.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:33 -0400
Message-ID: <20260828-stable-daily-0002-nvme-tcp-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222022.45428-1-carlos.bilbao@kernel.org>
References: <20260827222022.45428-1-carlos.bilbao@kernel.org>
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

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
