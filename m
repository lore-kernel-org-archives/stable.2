Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4F34C981
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692774; cv=none; b=Er9Xuam9FYKzJYTtgHgTsaoGoyE2SU4UnCLvdiEJs7ar6aIyfqEN80xv54S+T+1C4dEd21ULfgEisUaNl8D6U6macGMokmFdsAaq3Rqy7E2VcdXqyMmmHwWNG6n1v6azMXReZPeqSkotkx0h6hQ/0pNj7rFCOWm1CIp7emRXJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692774; c=relaxed/simple;
	bh=dNudxIXO+Jyn8s/xxYph+Eh2a7Q9jVUhntpUHvvF4hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLERKN06N/TcsWNppRE8THGmZCh7mwvKVvIDa8WIiOMaERnTVEDO1wFSZw/uyk8+NxHFz1m4ofJ2UZO72zYNuKlpGmndrZiWVa1MSSz5OdS82uWpvGt5+hbw0CYxUQBN7SKHaTMudgQdffOzY6lAYxwJOVaKzMTNN4Tps09SY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRDwRSeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRDwRSeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372E71F00898;
	Fri, 18 Sep 2026 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692772;
	bh=oPWQbrdT05bZiGAx0FMRzuQD6QqVYbM8qcIQ9BrTo0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRDwRSeQklaOeGYXhCxUSl1DdyVTVRrhyQPHgwp9LTy0yoE3wTFY2aD1UwWBDV6wO
	 2iSkclNO/hol4Se06ziYjc5WFyk7EweLzvV9TvAB99xW1OhpKDzQRNGn29rB1+cw5C
	 mXcUm25snH4MurQ1HxG22n0YvvPgZKUv/GDe6ptAc+OAsTgOAyUu4IujOaFsCAKa4K
	 XfZL7I4rHMYCPRYYDF6SjTUE/sX473I8KbN6XAj9H8mX9W/bzvm5P4NaSQfxXIAmyG
	 cPMNetzPHdauH1rmb6WRUDBEIUeoI6fsiXKuYZ7RG0g4EZnEhlXFt7OjMOP+lHKHjC
	 5JJzmcPsrAtKw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20stable-rc/linux-5=2E10=2Ey=3A=20=28build=29implicit=20declaration=20of=20function=20=E2=80=98kvfree=E2=80=99=3B=20did=20you=20mean=20=E2=80=98kfree=E2=80=99=3F=20=5B-=2E=2E=2E?=
Date: Thu, 17 Sep 2026 20:52:31 -0400
Message-ID: <2026-09-17-daily-reply-0004-kernelci-5-10-kvfree@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178964994501.141985.8613990755737198148@kernelci.org>
References: <178964994501.141985.8613990755737198148@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> net/9p/client.c:935:9: error: implicit declaration of function ‘kvfree’; did you mean ‘kfree’? [-Werror=implicit-function-declaration]
>   935 |         kvfree(fid->rdir);

The break comes from the queued backport of b4d71bea1445 ("9p: use
kvzalloc for readdir buffer"). Below 6.1 kvfree() is declared in
linux/mm.h rather than linux/slab.h, and net/9p/client.c includes only
the latter.

5.15 has the same backport queued and is broken the same way, and
fs/9p/vfs_dir.c has a second kvzalloc() with the same missing
declaration on both trees. All of that needs handling on 5.10 and 5.15
before the next release.

-- 
Thanks,
Sasha
