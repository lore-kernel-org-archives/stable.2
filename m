Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8C3A1A2D;
	Sun, 19 Jul 2026 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473260; cv=none; b=nbiedr+vsAQscx/0kBQV5DCuZd34Mnd2U3iiodgJ//1HE36jCZ40isaSAMfyL0o1CKRNLg3ntnToQX/+Z+rn2s8Odymd4c7uNwuA7GckUBan2pqPcgggsSNaYVwhRXDol5J3dkmsiZi6mOd8ZTZ+XrpdPClaHAAUS4etU5WWY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473260; c=relaxed/simple;
	bh=sVIQQsfLK7r/d6Pd9/3MXEYgECqshP4zH0fMTF/gkGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHsdAsqmUjKiMMoVxniAxySwyMkBc5r7CbcDJIjuS5BVlO2l2jN/zgM7TOq0aUcoo8sEFySWHnylhCW1I69v64ZqymvRvO0LXDXX1uN7zY20FQHmV8nyoyC/rxbAgO/xX+tW216nvjJFihtAojEkgYSWlRbf0oxmg3Wq5R99Bzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghzd9h2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghzd9h2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797801F00A3E;
	Sun, 19 Jul 2026 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473259;
	bh=QlaDZ0F/r4zw/rsZizEA3u3Y+xIkmU3KaYDe1Grke1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ghzd9h2YXqbcu7sjxpjLalVZK7BzCIXX+ZZEX7pjNZCFS/hkJ4nwiIyoqe7KG2Sad
	 SL0DEKT/nZ2rOKcuHnww/ehom7KFRcVfU9MDDslSnlXIR6FSn93EeW9vKAJayY3WXV
	 3vDVKd80BvFaYrotPq8b9n95HxwkZRMZsm10vWcR5JFt0YKWrkwi1WkfgNCGYg5tPA
	 LjWvZR/WyAO6yu3Fcy9kcwu+NjjrEUcO2GjKC+JpFNue7UbrJorJzZZKjgxRqrM1Ak
	 7OTCVtkUW9G2lAeeTemKQL5n+TMHvLh9RhrLkWsXSOTPGS1aMnvWVK3kQNAKIBRNrp
	 O90kKffborrJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH stable 6.12] selftests/fs/statmount: build with tools include dir
Date: Sun, 19 Jul 2026 11:00:31 -0400
Message-ID: <20260718192718.0017-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716170626.1433958-1-florian.fainelli@broadcom.com>
References: <20260716170626.1433958-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [florian: resolved conflict in statmount/Makefile]

The Makefile conflict resolution took the upstream TEST_GEN_PROGS line
verbatim, which adds listmount_test - but listmount_test.c doesn't exist
in 6.12 (the test was only added in v6.14 by 3ab8a0b2a0ff10 ("selftests:
add listmount() iteration tests")), so this breaks the statmount
kselftest build on 6.12.

The rest of the patch looks good. Could you respin a v2 that keeps
6.12's existing "TEST_GEN_PROGS := statmount_test statmount_test_ns"
and only adds $(TOOLS_INCLUDES) to CFLAGS?

-- 
Thanks,
Sasha
