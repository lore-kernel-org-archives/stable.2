Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169687;
	b=eNrQv1xVaDGmuS4uoHdS54CLHQryT6iIgGt7ZiDGNzXRiZhcO4/l7AD2jSL80yCUPg5x
	 GuwtjGQHpe6MhDixa0j3K3TDFZCJo7c/x4ooaLnaHCSrlS4HJKmHs7eXFGHEoaulk86ko
	 +ExOVTiIlTzYClVjZonEdxoKy37qyCXzbYgjxs8a7wLYOExIt7lj/3sV92r+/TT3CVu1U
	 ZXPpodQISXcB1cb12maI6oEKR4UaPZ7KXwix/kp6yd5VP98uD1wxuYyw6nIwkUAlNNbXG
	 sfTjKiiuwxrTciqCDwFWQPJhdMOXjiheP7LwE5x821NOz9hfqiY7dr4/yc0TgTwnkXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VCC0GT+39trwZ5tv5TKEwxsqF3LcbndkKMsSu0V1BgA=;
	b=LNhIbMPl8BNi917wFZ2fdUrv0B/g6iaHDO4UC6H08gkZJUfB4uFWl3kfuOp89q5rLLmc
	 VmmblQ+Hhbvx8FrMvdMzCef1UuDzk0LWUAcGsWI9KK84pXoGB7/6tZJO13xeDh+eB1NdK
	 ZSDDuZfRM+pVO2Ph2K0iM9OK0lZ8t9xjX9XTPr6LYb9nAwVUXmJHwVrP7d5Jhhwl344aJ
	 lwzaCTKBj+PHcCc6esT+zkrnCeSS80nEeAcC+kz7NuHdNg/feVfqaSC04a5PJdufIS52M
	 w+EGokgrAYq3h71Uay9jExF47d6+vVtOlzw4IyqcvYcAFL8M5/3UixPj+wPKJ27n/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk3AouPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D5606A322;
	Sun,  8 Nov 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zk3AouPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0585C1F008AB;
	Sun,  8 Nov 2026 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169687;
	bh=VCC0GT+39trwZ5tv5TKEwxsqF3LcbndkKMsSu0V1BgA=;
	h=From:To:Cc:Subject:Date;
	b=Zk3AouPO3OtZiNvvfPDC/JlpdAOcXBg/pmT5FDEXGMpHJBV9gAxuyjIyGrGF/C7AR
	 RoBuKhKT9MRAPQ1TbDa9t5zzxxklEEyAxQIg5S/QPW7yWBpS7NvWCfL2vP09Dt+rDM
	 ZOmwKRMZ7powC+6B/sMggVxushF+62vi8Cfs2unmI5G/1Jp9PfGZdZ+1O2wYkNTxHH
	 cQwYgCaHDdXcNTUdoKkr+J67TyW0QhFY9Bn0eTfpq2uHGnXFxxwtwaTZsi9MBByGbw
	 IhCDHSWc9N0gOiIIzVGhEnuae2XPLnTpzONtxNM0n7CWKyEX6C82HPT4yq6W5f8B2Q
	 qRl9Iy9EBrp1A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.1.y 0/2] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sun,  8 Nov 2026 12:27:56 -0800
Message-ID: <20261108202759.117377-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Manually port two DAMON fixes that cherry-pick failed [1,2] and turned
out to really need to be picked.  Note that seven patches [3-9] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107054458-failed-6.1-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107055454-failed-6.1-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[3] https://lore.kernel.org/20261107054658-failed-6.1-cec08aad3def@kernel.org
[4] https://lore.kernel.org/20261107054701-failed-6.1-1bfb9384ae0e@kernel.org
[5] https://lore.kernel.org/20261107054705-failed-6.1-6f276422aded@kernel.org
[6] https://lore.kernel.org/20261107054708-failed-6.1-a1c7fdaf1657@kernel.org
[7] https://lore.kernel.org/20261107054711-failed-6.1-409d2ab6d982@kernel.org
[8] https://lore.kernel.org/20261107054714-failed-6.1-1d2397b2c414@kernel.org
[9] https://lore.kernel.org/20261107054721-failed-6.1-1c3352282063@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20261107224800.340250-1-sj@kernel.org
- None.

SJ Park (2):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)


base-commit: 718bf49618bbf78a08ab69ed0dfffa8e8f917cfa
-- 
2.47.3
