Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC353D6CBA
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499690; cv=none; b=es/TRNQfDIpNgj/oxaAFzh3GWPlx42luxxwmQKbu5Qf5y7h1RfPrJNGPwiYedHjjhzW68PrfYHB+KoHO5RP9xdEEwV3T8yMSF2UgbBmkZI1+qJ6TlFW8QJhykjglcadePUWXKX7lTw9aAsb/TLRinhehiVWWkN97g9hPRHYkIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499690; c=relaxed/simple;
	bh=oo4j2k/gszT4TTziUBNika2URy46wSDBmLFd9dMs0zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTOWKFu/3hj6h5VB1hgUfNWucWE5d3jsP6macMB4G03srqFbd7azI6WY7LM0uZL9rjVeFCNS0QTm37EHL3HmUv9tMaLfEbEOgdStHCUOJ0x9Lnjr5O82OL9V6k+C03UCPPXCZLZwpLV1sUaK8Y7CuNvq0d9ShfCGn2vfgPj7Hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9LgHXGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9LgHXGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAB61F0089A;
	Wed,  3 Jun 2026 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499689;
	bh=WifTskjz45CxEdHtLk5S7QzE5uC2nUfzznFRVVToxq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9LgHXGyzSe1Wemk04Dm/gij4oX+dfrhn/Vi11YzxiSTEyV+zbg/S/oFq3huORMik
	 ZDgKZ5X0QdZPg3Mi+TuPVOEr2kNlfJBG3341BWH8ocmV/tNhGbs+bGRy0jv9E8LBhh
	 NL2GbhwE0vnE3knnDD5rUqkf/DssvacW4bzhxwcO/p0/EqPIgYLVcL9uL6QnCUYtNU
	 U2/Pqrk5ze11KFsZ3h+NeppnH0cVI0rMgvkEgcYqiO5udZva1CdEDd1PN4OgV8LeqM
	 cSkhEIQX4oE4uMMRU0XihhzdZ76BgH7NLpfvkTDXzOjDxC3kHKflL2VvCt0EXhno2+
	 nc8miaMtYMgug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tp_meter: directly shut down timer on cleanup
Date: Wed,  3 Jun 2026 11:14:13 -0400
Message-ID: <20260603111500.item039@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202135.443823-1-sven@narfation.org>
References: <20260528202135.443823-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, and 5.15.y, thanks.

-- 
Thanks,
Sasha
