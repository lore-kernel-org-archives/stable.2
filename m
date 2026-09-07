Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF222AD37
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744161; cv=none; b=ONKDowcTCK/BSt9eSHLWtoYHpWo+fxGMFKTB64pAnoaGias5HaLrI9nUx0Ob1ZOR/8JkOLCxFIQWXgtHTKrckMRlhRNF1QAxwOQv7xGI6rDagfRCmnSXJCZGbDgIZrdyE6LcqcmsfK+qeOJp/jjQx9rPK3FdBOl7ojg7alxsBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744161; c=relaxed/simple;
	bh=5I0FvUMWFtZc5xM1MIxqdxbTFsYXKwcRB6hAOA1uSa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo2HGKlkNgu2diSWiTegEc2fr37R7RkYJOSHkwwrOWKKAcFSTkK6CPbyfCxh7WrSdX9VmvRR7tEKeBPU6WmR5NV9gSKsHG3RhsP7ChfM5+4IQanV7UpuvRf78qZltyD6WiPY28wpHFiSgoVf53SPfMBWTidiA53uDVOgOLHTpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmwQMZ54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmwQMZ54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B936F1F00A3A;
	Mon,  7 Sep 2026 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744160;
	bh=z0fElBwCFfiXTXhVZRhqpS0bT5CoSpVugvXPmFfWAeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmwQMZ54hnscay+qs2NshLkedxrMsIBxRs/Q8RSMLvX51ZlwUZOg5T61m9+nA5GZe
	 2b0MaFrouLZRy4uWAQPDUgzJEnivgeXyAWOMpGW1oc8n2+9wF7rgRlUIycR/hnmrpn
	 8bta8DYra6mm9MzGGgUMsWRI7WJFS8vPGPHf7TyknUfKkXZKXNFOR/TTUBFADdpYuq
	 2w6wWp+x2Z7WgNH+ZFVtr6lcrZfC47sCqnTy0KcctC5+lJ+uoqFNJOtjMZFhr1eRU9
	 lDxBXq/91Ft8f280CrlypwJDr/NXLKiTqb0GLndltTv4ogiRgy+sHRZJ02K2nOWmwr
	 zepVjaKhPzqEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mario.limonciello@amd.com,
	Hlib Wondertan <hlibwondertan@gmail.com>
Subject: Re: Request stable backport of commit 4b6ec94fdae2 to Linux 6.18.y
Date: Sun,  6 Sep 2026 21:22:33 -0400
Message-ID: <2026-09-06-daily-reply-0003-smu-resume@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFdGzA7dHZxaW4Vdzp6HcwhJxpWB+vakM85gCCk-qgAY=cHukg@mail.gmail.com>
References: <CAFdGzA7dHZxaW4Vdzp6HcwhJxpWB+vakM85gCCk-qgAY=cHukg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport upstream commit
> 4b6ec94fdae2407d9b8e69e3ec5f879e72ad667e, "drm/amd: Drop calls to
> restore power limit and clock from smu_resume()", to Linux 6.18.y.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
