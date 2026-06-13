Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94092332EA0
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362302; cv=none; b=HICCyeoExTrEyBpINaoGvCoS253YDJl5AOFajqijVFluwNiZbLyHZVc15gSUVZkIlwebXjxZRxvXZiNGnmG8ZG4z62j+OzA478D9tiPiFXfFPL0LTbY5Y0LFI+472DgJDPmS0G42ahIbtntXh+T8QjVV6M1D78pIED1l43RLSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362302; c=relaxed/simple;
	bh=ld2UUu0GoEg8zq6jL6xt6HQYlRXCdhhqJqHYQbiaHGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPwQfHUfQE7C0cgG4u+RcaExUVML9JTSgupmMoeclvTpcf3XryVtWPilQDzBaUc0awKunMVjFSRV26/dM8sx8OzA1s4hIkIALExjmrfAWjXsiqyxC3QXVRWvK5TUjf4fO0N08RTqJUdcrc8uKNl3h6xSbQa84zX+2ygPVzaoHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsMDz5r2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsMDz5r2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EF61F00A3A;
	Sat, 13 Jun 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362298;
	bh=ld2UUu0GoEg8zq6jL6xt6HQYlRXCdhhqJqHYQbiaHGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsMDz5r2PQKGx7VPIl+jshxIigddHCJODgSwdZQhw7osC+xFaNj3NMFcKnnAX6T/m
	 +Y1sTwxj7UFnhXqDrBE4HTpaOHrgI1s3fX2SFgIa3xi1w1lzrtWuxFJ0s1gAvDT0pT
	 p9yq/7LUbVxKG1PHb1nraQPeFajZrzl2tJEGlPMvs8kINt+IGBnOu5rYJBkCd23Bn6
	 ApzHK/y0eJplncdCrW/tZCrEa4SPtFnwLZv/mQY4q5BcXoBNCwnqAc7IyhQe5w8koo
	 N0Ydef3cmCyOqtBN3yb0kLzoRHRr1h573F5KvU6JRPtxd1ZlNtEy/NTklZoPUczlDU
	 H9Tz+KCuJJ7jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 6.12.y] netfilter: ctnetlink: ensure safe access to master conntrack
Date: Sat, 13 Jun 2026 10:51:27 -0400
Message-ID: <20260613143001.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612190705.909607-1-mkbund@amazon.com>
References: <20260612190705.909607-1-mkbund@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 07:07:05PM +0000, Mark Bundschuh wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
>
> [ Upstream commit bffcaad9afdfe45d7fc777397d3b83c1e3ebffe5 ]

Queued for 6.12.y, thanks.

--
Thanks,
Sasha
