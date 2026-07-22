Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB735F192
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681654; cv=none; b=lVvE6Bj2ExIxipZev2PVqTE/eJsCpfRY5z+xJnx+EgsTdCXiCK7GlE7vhocStHoTs5x0h9obg9MYNteta78yUCyrdua1Wwq9yrdcheSnPawOEil3Jd6NmrmPvY/9SzijgTQtXVX+E/JSxLiP2rx9f+C4uNelbwqBYPJvSQUZKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681654; c=relaxed/simple;
	bh=9nGBO6H9B3dsMk1afnMac/TiIBtXZFkXq9zEYBM6KvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8bpZVyUB1QhA4u4Nulb/5JsZ9P6VvUvDcfipE9mzzmW9f6aRiw3Zc6R2JYnFVfrWJe1Fba3+yErZhbbzCs11DZ0m6J5FbOpELMvthMjcJCq4Rra73IkvMrpAVdpYeifmp60vYeewtVDNediRARVO3bYVQcw1tE/oUpAsL5wVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf8qFEV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf8qFEV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416B11F00A3D;
	Wed, 22 Jul 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681651;
	bh=wZrNUqY1Enwo/aHGVYl4vuCmrIbtxSlhcBqv9E52cmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tf8qFEV9ahds7KLIYzTrTyC3AM669QYZqdEvLid/PWzA88AJ9bpsU1I8QPHzVBzMB
	 kHvOpvgyYNBttMLoY+QqIeF7G/Jg6KJufHTLf8HZIJS85FMhrDTNWaAi90mvsDcUYZ
	 qRQz8BgXPWmMTagU5JzA7B17/Rl1I/5AXQu+Dqj493mBtM465zYJh14qzltfmmVM5s
	 FxbfLTlmu1xE1dSqlJRPBjroYG0Kd8oPXhO8A3JVz7ci+Rxe7a8XTYVXtdwxQK7vPZ
	 zbzj2ybug7379BjySUVl86eGhInPP3bH+xPs43Lk7xkWpVIJiHG5bn7UN7ktP2jaMw
	 sl6fxA4qcIhjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: BPF selftests compilation failure due to selftests-bpf-initialize-operation-name-before-use.patch
Date: Tue, 21 Jul 2026 20:53:58 -0400
Message-ID: <20260721201114.0011-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al8dSv_OvhwxFCar@u94a>
References: <al8dSv_OvhwxFCar@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can you pick up commit 63c49efc987a ("selftests/bpf: Add simple
> strscpy() implementation") along? I think that should be enough to fix
> the build failure.

Greg has already picked it up for 6.18, which covers the tree you hit.

The offending selftests patch is also queued for 6.12 and 6.6, and you
were right that they're affected too. Unfortunately 63c49efc987a
doesn't apply there as-is: it depends on 9a6a6a319157 ("tools/testing:
add linux/args.h header and fix radix, VMA tests"), which isn't in
either tree.

Could you send adapted backports of the strscpy helper for 6.12.y and
6.6.y? I'll hold off on those branches until then.

-- 
Thanks,
Sasha
