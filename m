Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0E3B3BFA;
	Sun, 12 Jul 2026 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888068; cv=none; b=XZ6carjDhGinn/qr6kqU/5nlGEQ3SHnsKlpZE3rIr7qM+4OAXMpp40naSDoVUbAI7n7QpK9UosE0KmxUMfR2lR7199yWoxZEP7pVqjA8GBMe7ZI1q+ggM0UAcrBNJZVDL46sK5sck0hBcNYQ+cbdSvXGZkTrk3Kbq0lFDHlGygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888068; c=relaxed/simple;
	bh=SL8SVxS0+03NRXsmLRbXbAMsBMXKfSOzsfaRx1n5SFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFH4+HIjuA7Wd4YWYiiHVYm2r5gs8J6tGPLXH4Pv10Y3kEi3G0hAKwpR7FGDsmzQ88Lchd/nK6HnkUzEf3eqEbwJjTe5dMeGTOF6oE8Tz2vSmDNXrlRihwH1y09s6G+DIOWveDaxq02d0qjTV47QKSCcYBV5zyT/Z28n156qsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmgvewp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmgvewp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6654E1F00A3D;
	Sun, 12 Jul 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888067;
	bh=cd3Az1ImjXIaOh3RzJKV5RJtHyQvtsMEKHStSMNz50Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mmgvewp/PNc98bFXTeN5TNRRNkdI+H9KyTEZY1Vbgp7Es1bQXCvx6aMCKuWrXZ03J
	 TStAVroJWdZxL+8CbnCwQpjEC5u11KD2Mxyp8pnkFnaGtpupnE+3ZBP2DGe+PMsifN
	 c373oY0s4MjD7dYJFrSlA2VF6/onUfhcHmGxLuSYwPmoGrObotdK/dXkWaobib9vIj
	 yZhahNyy1PC3h4ClhFCqW659ta7crf0Ngiw2puis+HLfUOnDs0PysVbdFwDv0LhXEP
	 pb9dYRunDPSrw/3oPRZALW+z8bMP53jXkWoeKyXEAE3ZcOpH715it9pfrdkcaCumvw
	 CTKdv5Nc6UijA==
From: Sasha Levin <sashal@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: Please consider 83f99de1b7c0 ("ext2: fix race between setxattr and write back") for 5.10.y, 5.15.y, and 6.1.y
Date: Sun, 12 Jul 2026 16:27:40 -0400
Message-ID: <20260712105304.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJJ9bXzXfQuJ0+LrHbEjBvMR9X+WSYBzeZJFKBt+0HitNE6=CA@mail.gmail.com>
References: <CAJJ9bXzXfQuJ0+LrHbEjBvMR9X+WSYBzeZJFKBt+0HitNE6=CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Regression = a test that passes on stock but fails on patched.
>   5.10.y: NO NEW FAILURES
>   5.15.y: NO NEW FAILURES
>   6.1.y : NO NEW FAILURES
> OVERALL: PASS. The backport introduces no regressions in the ext2 surface.

Can you actually read the docs and follow the instructions there as to how to
submit backports?

-- 
Thanks,
Sasha
