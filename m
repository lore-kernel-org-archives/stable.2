Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C3230BE9
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131419; cv=none; b=dSuY/98fskkkrATdib8qPVqWlaUd6fT/75qQPlmvTmjFrgm30NWrprVleOkywH+qQdC6JoVuRDzgT9gsLH27wGSO/ADbXmhWThGasITyLC4RXZkOQbfvIfNgPBurseuGG/19/SjLv//ArhsmZQVqtf7PNbOeY8jEAKmZA7GdXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131419; c=relaxed/simple;
	bh=GptqzJnqUSia2fLsmh8HFVMRu0eZet4k8sgd0r1Uwvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJNW08ZU68VRuHJaUGwVUNsBKhlbiJA2CAcnmJx89uYbQ2jpYRUfcKMT37/exxJ4clDfWkRsHwnU08dubDqyQELO4ogdQ2KceSkUu0BMovKmowihheAgcolaRgHavczH34EkNE4rfBLqb9lRjB9dcw72kj/FloObknB03sukVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDHPYyej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDHPYyej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E81F000FF;
	Sun,  4 Oct 2026 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131417;
	bh=u8MQc0otPVfJyu6in96+4GhKvgPJpm6DhYz2jYjOx4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDHPYyejtDVpPgSNmw93n9GBGKzCM7VLKuJpiD+zvMNPWYPv7oRfQ6sLbUvCqf4hI
	 SgYEJWYjJOrW+mT57t6snwoPEeDp2cM1jahgPbErssG1AD8mpBAA/RAKXJ6OLGCkI7
	 OOcwywiUn/UJkdyyBDtb4L3lYuNSZqygT3dYaQ2sVb45AcknsxgJ2NPWJuQFOcWHMo
	 w5yls2nQsPE6wKhG3iHCOgqZ/vLKr11afCTXq0WR0JF/AMjaq2BitmWseSihJqvHjA
	 cz43U2xrlSiz3EmYpYjuB5On9tZRIP1VdIFqQRw/GyHXvUd8RPz6hQU64cm+ENOtEu
	 OMImD4wj2Lvkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.18.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sun,  4 Oct 2026 12:29:46 -0400
Message-ID: <2026-10-04-1-daily-reply-0008-damon-adjust-quota-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003154341.19354-1-sj@kernel.org>
References: <20261003154341.19354-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature.  Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
